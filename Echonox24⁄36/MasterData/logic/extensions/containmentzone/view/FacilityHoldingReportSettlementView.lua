-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportSettlementView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportSettlementView", package.seeall)

local M = class("FacilityHoldingReportSettlementView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._columnNum = 4
end

function M:buildUI()
	self._cellItem = {}
	self._txtTitle = self:getText("facility_holding_report_settlement_view_1965013119")
	self._goScrollView = self:getGo("facility_holding_report_settlement_view_1162049283")
	self._btnClose = self:getBtn("facility_holding_report_settlement_view_329676857")
	self._btnCloseInScroll = self:getBtn("facility_holding_report_settlement_view_1346071661")
	self._scrollReport = LoopGridViewHelper.New(self._goScrollView)

	self._scrollReport:InitGridView(0, self._onCellUpdate, self)

	self._goNewInfoRoot = self:getGo("facility_holding_report_settlement_view_138793823")
	self._rectTrNewInfoParent = self:getUIComponent("facility_holding_report_settlement_view_1196859656", UIComponentType.RectTransform)
	self._goNewInfoItem = self:getGo("facility_holding_report_settlement_view_-1528206774")
end

function M:destroyUI()
	self._txtTitle = nil
	self._goScrollView = nil

	self._scrollReport:Dispose()

	self._scrollReport = nil
	self._btnClose = nil
	self._btnCloseInScroll = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
	self._goNewInfoRoot = nil
	self._rectTrNewInfoParent = nil
	self._goNewInfoItem = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.onClickAccept, self)
	self._btnCloseInScroll:AddClickListener(self.onClickAccept, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseInScroll:RemoveClickListener()

	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	GlobalDispatcher:addEventListener(EventType.HOUSE_HOLD_REPORT_RECEIVE, self._handleHouseHoldReportReceive, self)

	local info = self:getFirstParam()

	self._roomId = info.roomId
	self._nowIndex = 0
	self._waitForServerData = true

	self:_updateTitleContent(lang("tip_work_report"))
	ContainmentZoneAgent.instance:sendReceiveAllReportRequest(self._roomId)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLD_REPORT_RECEIVE, self._handleHouseHoldReportReceive, self)

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._scrollReport:ClearCells()

	self._reportMark = nil
end

function M:_handleHouseHoldReportReceive(e, reportLst)
	self._waitForServerData = false

	ContainmentReportModel.instance:removeUnReadFailReport(self._roomId)
	self:_duelReportLst(reportLst)
	self:showNextProtomerReportLst()
end

function M:onClickAccept()
	if self._waitForServerData then
		return
	end

	self:showNextProtomerReportLst()
end

function M:showNextProtomerReportLst()
	self._nowIndex = self._nowIndex + 1

	local nowData = self._reportLst[self._nowIndex]

	if nowData then
		self._reportMark = {}

		self:_updateTitleShow(nowData.protomerId)
		self:_refreshScrollViewShow(self._nowIndex)
	else
		self:close()
	end
end

function M:_updateTitleShow(protomerId)
	if protomerId and protomerId > 0 then
		local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)
		local serialNum = protomerMo:getProtomerSerialNumShow()
		local protomerName = protomerMo:getProtomerName()

		self:_updateTitleContent(string.format(lang("tip_work_report_s_s"), serialNum, protomerName))
	end
end

function M:_updateTitleContent(str)
	self._txtTitle.text = str
end

function M:_duelReportLst(reportLstFromServer)
	local tempReportLst = {}

	for _, value in pairs(reportLstFromServer) do
		local protomerId = value:getProtomerId()

		if not tempReportLst[protomerId] then
			tempReportLst[protomerId] = {}
		end

		table.insert(tempReportLst[protomerId], value)
	end

	self._reportLst = {}

	for protomerId, reprotList in pairs(tempReportLst or {}) do
		local sortLst = ContainmentUtil.sortHoldRoomReport(reprotList)
		local unLockIntelligence = {}
		local rewards = {}
		local reportLstForShow = {}
		local realReportCount = 0
		local realFailReportCount = 0

		for _, value in pairs(sortLst) do
			local isFail = value:getFailLevel() > 0

			ContainmentUtil.duelReportLst_Rewards(value:getRewards(), rewards)
			self:_duelReportLst_Intelligence(value, unLockIntelligence)

			if isFail then
				local emptyGridCount = #reportLstForShow == 0 and self._columnNum or self._columnNum - #reportLstForShow % self._columnNum

				if emptyGridCount >= 2 then
					self:_duelReportLst_AddFailReport(reportLstForShow, value)
				else
					for i = 1, emptyGridCount do
						self:_duelReportLst_AddFakeData(reportLstForShow)
					end

					self:_duelReportLst_AddFailReport(reportLstForShow, value)
				end

				realFailReportCount = realFailReportCount + 1
			else
				self:_duelReportLst_AddNormalReport(reportLstForShow, value)
			end

			realReportCount = realReportCount + 1
		end

		local emptyGridCount = #reportLstForShow % self._columnNum

		if emptyGridCount ~= 0 then
			emptyGridCount = self._columnNum - emptyGridCount

			if emptyGridCount > 0 then
				for i = 1, emptyGridCount do
					self:_duelReportLst_AddFakeData(reportLstForShow)
				end
			end
		end

		self:_duelReportLst_AddRewardsData(reportLstForShow, protomerId, unLockIntelligence, rewards)
		table.insert(self._reportLst, {
			protomerId = protomerId,
			reportLst = reportLstForShow,
			unLockIntelligence = unLockIntelligence
		})
		print(string.format("原体[%d]报告[%d]份，其中含失效[%d]份，生成数据[%d]", protomerId, realReportCount, realFailReportCount, #reportLstForShow))
		TableUtil.dump(reportLstForShow)
	end
end

function M:_duelReportLst_AddFakeData(reportTable)
	table.insert(reportTable, {
		isFakeData = true
	})
end

function M:_duelReportLst_AddNormalReport(reportTable, valueData)
	table.insert(reportTable, {
		data = valueData
	})
end

function M:_duelReportLst_AddFailReport(reportTable, valueData)
	table.insert(reportTable, {
		isFailExt = false,
		data = valueData
	})
	table.insert(reportTable, {
		isFailExt = true,
		data = valueData
	})
end

function M:_duelReportLst_AddRewardsData(reportTable, protomerId, intelligenceData, rewardsData)
	table.insert(reportTable, {
		isRewardData = true,
		protomerId = protomerId,
		intelligenceData = intelligenceData,
		rewardsData = rewardsData
	})
end

function M:_duelReportLst_Intelligence(valueData, unLockIntelligenceTable)
	local info = valueData:getIntelligence()

	if info > 0 then
		local binTable = ContainmentModel.instance:decimal2bin(info)

		for i = 1, 32 do
			if binTable[i] == 1 then
				local id = 32 - i + 1

				unLockIntelligenceTable[id] = 1
			end
		end
	end
end

function M:_duelReportLst_Intelligence_ByPoint(protomerId, addPoint, unLockIntelligenceTable)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)

	if protomerInfoMo then
		local orgPoint = protomerInfoMo:getResearchPoint()
		local finalPoint = orgPoint + addPoint
		local cfgResearch = ContainmentConfig.instance:getHouseResearchCoByCode(protomerInfoMo:getProtomerCfgResearchCode())
		local orgLevel = protomerInfoMo:getLevel()
		local tryNextLv = orgLevel

		while cfgResearch and cfgResearch[tryNextLv] do
			local needPoint = cfgResearch[tryNextLv].point

			if needPoint == 0 then
				break
			end

			if needPoint > 0 then
				if finalPoint < cfgResearch[tryNextLv].point then
					if tryNextLv ~= orgLevel then
						tryNextLv = tryNextLv - 1 or tryNextLv
					end

					break
				end

				if cfgResearch[tryNextLv].point == finalPoint then
					break
				end
			end

			tryNextLv = tryNextLv + 1
		end

		print(string.format("原体研究点[%d]->[%d],等级[%d]->[%d]", orgPoint, finalPoint, orgLevel, tryNextLv))

		local _condition = ContainmentEnum.ProtomerInfoUnlockCondition
		local cfgUnlock = ContainmentConfig.instance:getProtomerInfoUnlockCoByCode(protomerInfoMo:getProtomerCfgUnlockCode())

		for _typ, _typLst in pairs(cfgUnlock or {}) do
			for _, value in pairs(_typLst) do
				if value.condition == _condition.ByPoint and orgPoint < value.param and finalPoint >= value.param then
					unLockIntelligenceTable[value.item] = 1

					print(string.format("原体研究点达标[%d],解锁条目[%d]", value.param, value.item))
				end

				if value.condition == _condition.ByLevel and orgLevel < value.param and tryNextLv >= value.param then
					unLockIntelligenceTable[value.item] = 1

					print(string.format("原体等级达标[%d],解锁条目[%d]", value.param, value.item))
				end
			end
		end
	end
end

function M:_refreshScrollViewShow(index)
	local len = self._reportLst[index].reportLst and #self._reportLst[index].reportLst or 0

	goutil.setActive(self._goScrollView, len > 0)

	if len > 0 then
		self._scrollReport:SetListItemCount(len, true)
		self._scrollReport:RefreshAllShownItem()
	else
		self._scrollReport:ClearCells()
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local itemData = self._reportLst[self._nowIndex].reportLst[curIndex]
	local showItem = not itemData.isFakeData
	local itemClass, itemPrefabName

	if itemData.isFailExt then
		itemClass = HoldingRoomReportFailExtCell
		itemPrefabName = "holding_fail_item"

		if curIndex == 1 then
			printError("首个报告为FailExt，请检查")
		end
	elseif itemData.isRewardData then
		itemClass = HoldingRoomReportRewardCell
		itemPrefabName = "reward_item"
	else
		itemClass = HoldingRoomReportNormalCell
		itemPrefabName = "report_item"
	end

	local item = self._scrollReport:NewListViewItem(itemPrefabName)
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, itemClass)

	shower.view = self

	if showItem then
		shower:setCellData(itemData, curIndex)

		if not self._reportMark then
			self._reportMark = {}
		end

		if not self._reportMark[curIndex] then
			self._reportMark[curIndex] = 1

			shower:playFirstOpenAni()
		end
	end

	shower:setShow(showItem)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

return M
