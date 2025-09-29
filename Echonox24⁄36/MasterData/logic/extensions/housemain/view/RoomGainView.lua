-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomGainView.lua

module("logic.extensions.housemain.view.RoomGainView", package.seeall)

local M = class("RoomGainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("room_gain_view_copy_-2062033495")
	self._btnCloseInView = self:getBtn("room_gain_view_1954193289")
	self._scrollRoot = self:getUIComponent("room_gain_view_copy_-418328633", UIComponentType.ScrollRect)
	self._goItemReward = self:getGo("room_gain_view_copy_-608941279")
	self._goItemHoldRoom = self:getGo("room_gain_view_copy_-2104478538")
end

function M:destroyUI()
	self._btnClose = nil
	self._btnCloseInView = nil
	self._scrollRoot = nil
	self._goItemReward = nil
	self._goItemHoldRoom = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.onClickAccept, self)
	self._btnCloseInView:AddClickListener(self.onClickAccept, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseInView:RemoveClickListener()

	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	self._intelligences = info.intelligences
	self._cellItem = {}
	self._rewardLst = {}
	self._holdRoomLst = {}
	self._showOrder = {}
	self._waitForServer = {}

	table.insert(self._showOrder, HouseEnum.RoomType.Supervisor)
	table.insert(self._showOrder, HouseEnum.RoomType.Manufacturing)
	table.insert(self._showOrder, HouseEnum.RoomType.Shelter)

	for _, typ in ipairs(self._showOrder) do
		self:prefareReward(typ, info)
	end

	for _, typ in ipairs(self._showOrder) do
		self:createReward(typ)
	end
end

function M:onExit()
	self:_setEvent(false)

	for key, value in pairs(self._cellItem or {}) do
		local go = value:getMainGo()

		value:onExit()
		value:destroyUI()
		goutil.destroy(go)
	end

	self._cellItem = nil
	self._rewardLst = nil
	self._showOrder = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	end
end

function M:handleJumpViewEvent()
	self:close()
end

function M:onClickAccept()
	self:close()
end

function M:prefareReward(typ, info)
	if typ == HouseEnum.RoomType.Supervisor then
		local managerRewards = info.managerRewards

		if managerRewards and #managerRewards > 0 then
			for _, v in ipairs(managerRewards) do
				if v.itemCount > 0 then
					self:addReward(typ, v.itemCode, v.itemCount)
				end
			end
		end
	elseif typ == HouseEnum.RoomType.Manufacturing then
		local manufactureRewards = info.manufactureRewards

		if manufactureRewards and #manufactureRewards > 0 then
			for _, v in ipairs(manufactureRewards) do
				if v.itemCount > 0 then
					self:addReward(typ, v.itemCode, v.itemCount)
				end
			end
		end
	elseif typ == HouseEnum.RoomType.Shelter then
		local holdRewards = info.holdRewards

		if holdRewards and #holdRewards > 0 then
			for _, v in ipairs(holdRewards) do
				if v.itemCount > 0 then
					self:addReward(typ, v.itemCode, v.itemCount)
				end
			end
		end

		local intelligencesDiff = info.intelligences

		ProtomerModel.instance:updateProtomerDiffIntelligences(intelligencesDiff)

		local protomerUnLockIntelligence = {}

		if intelligencesDiff and #intelligencesDiff > 0 then
			for _, KeyValue in ipairs(intelligencesDiff) do
				local protomerId = KeyValue.key
				local intell = KeyValue.value

				if intell > 0 then
					local binTable = ContainmentModel.instance:decimal2bin(intell)

					if not protomerUnLockIntelligence[protomerId] then
						protomerUnLockIntelligence[protomerId] = {}
					end

					for i = 1, 32 do
						if binTable[i] == 1 then
							local id = 32 - i + 1

							protomerUnLockIntelligence[protomerId][id] = 1
						end
					end
				end
			end
		end

		local cfgRoomIds = HouseMainRoomModel.instance:getRoomIdsLst(HouseEnum.RoomType.Shelter)
		local allReportCount = 0

		for _, cfgRoomId in ipairs(cfgRoomIds or {}) do
			local roomId = cfgRoomId
			local canReceiveReportLst = ContainmentReportModel.instance:getCanReceiveReportLst(roomId)
			local num = #canReceiveReportLst

			allReportCount = allReportCount + num

			if num > 0 then
				print(string.format("收容室[%d]未领取报告数量[%d]", roomId, num))

				canReceiveReportLst = ContainmentUtil.sortHoldRoomReport(canReceiveReportLst)

				local roomInfoMo = ContainmentModel.instance:getRoomInfoById(roomId)
				local protomerId = roomInfoMo:getProtomerId()
				local addPoint = 0

				for _, value in pairs(canReceiveReportLst) do
					value:setReceive(true)

					if value:getProtomerId() == protomerId then
						addPoint = addPoint + value:getPoint()
					end
				end

				local predictInfo = ProtomerModel.instance:predictProtomerInfoChange(protomerId, addPoint, false)

				predictInfo.unLockIntelligence = protomerUnLockIntelligence[protomerId] or {}
				predictInfo.cfgRoomId = cfgRoomId
				predictInfo.reportNum = num

				table.insert(self._holdRoomLst, predictInfo)
				roomInfoMo:onAllReportReceive()
			end
		end

		for index, value in ipairs(self._holdRoomLst or {}) do
			ContainmentModel.instance:reflashRunningReport(value.cfgRoomId)
		end

		if allReportCount > 0 then
			GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_REPORT_CHANGE)
			GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLDROOM_INFO_CHANGE)
		end
	end
end

function M:addReward(typ, itemId, itemCount)
	if not self._rewardLst[typ] then
		self._rewardLst[typ] = {}
	end

	local orgCount = self._rewardLst[typ][itemId] or 0

	self._rewardLst[typ][itemId] = orgCount + itemCount
end

function M:duelHoldRoomInfo()
	return
end

function M:getReward(typ)
	return self._rewardLst[typ]
end

function M:createReward(typ)
	local rewards = self:getReward(typ)

	if rewards == nil then
		return
	end

	local rewardTitleName = lang(HouseMainEnum.RoomTypName[typ]) or lang("tip_harvest_settlement")

	if typ == HouseEnum.RoomType.Shelter then
		self:createHoldRoomInfo()

		rewardTitleName = lang("tip_harvest_settlement")
	end

	local shower = self:_addShower(self._goItemReward, self._scrollRoot.content, RoomHarvestItemLstCell)

	shower:setData(typ, rewards)
	shower:setTitle(rewardTitleName)
end

function M:createHoldRoomInfo()
	local count = self._holdRoomLst and #self._holdRoomLst or 0

	if count == 0 then
		printError("待获取报告的收容室列表为空，不展示收容室一列，这不正常")

		return
	end

	local shower = self:_addShower(self._goItemHoldRoom, self._scrollRoot.content, RoomHarvestHoldRoomLstCell)

	shower:setData(self._holdRoomLst)
	shower:setTitle(lang("tip_holding_room"))
end

function M:_addShower(prefabItem, root, class)
	local tempGo = goutil.cloneAndSetParent(prefabItem, root)
	local shower = Astral.LuaComponentContainer.Add(tempGo, class)

	shower:buildUI()
	shower:bindEvents()
	shower:onEnter()

	self._cellItem[tempGo.gameObject:GetInstanceID()] = shower

	goutil.setActive(tempGo, true)

	return shower
end

return M
