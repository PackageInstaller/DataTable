-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupPassportView.lua

module("logic.extensions.brothergroup.view.BrotherGroupPassportView", package.seeall)

local BrotherGroupPassportView = class("BrotherGroupPassportView", ViewComponent)

function BrotherGroupPassportView:buildUI()
	BrotherGroupPassportView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableview = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnPay = self:getGo("btnPay")
	self._btnTip = self:getGo("btnTip")
	self._btnOneKey = self:getGo("btnOneKey")
	self._rpOneKey = goutil.findChild(self._btnOneKey, "rp")
	self._scrollRect = self._goTable:GetComponent(ComponentType.ScrollRect)
	self._sldProgress = self:getSlider("tableview/Viewport/Content/sldProgress")
	self._txtProgress = self:getTxt("txtProgress")
	self._playerPos = goutil.findChild(self._sldProgress.gameObject, "handleRect/img/pos")
	self._showcell = self:getGo("showcell")
	self._showItemList = {}

	for i = 1, 3 do
		self._showItemList[i] = i == 1 and goutil.findChild(self._showcell, "item_" .. i) or goutil.findChild(self._showcell, "specialItem/item_" .. i)
	end

	self._txtShowProgress = goutil.findChildTextComponent(self._showcell, "progress/txt")
end

function BrotherGroupPassportView:bindEvents()
	BrotherGroupPassportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnPay, self._onClickPay, self)
end

function BrotherGroupPassportView:unbindEvents()
	BrotherGroupPassportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnPay)
end

function BrotherGroupPassportView:onEnter()
	BrotherGroupPassportView.super.onEnter(self)

	self._passPortFuncId = 11

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	PassportController.instance:sendGetInfoReq(self._passPortFuncId)

	if BrotherGroupModel.instance:isExitTeam() then
		local teamInfoList = BrotherGroupModel.instance:getTeammateInfoList()
		local data = teamInfoList[1]

		for k, info in ipairs(teamInfoList) do
			if data.score < info.score then
				data = info
			end
		end

		HeadItemController.instance:setHeadCellByInfo(self._playerPos, data.headInfo)
	else
		HeadItemController.instance:setMyHeadCell(self._playerPos)
	end
end

function BrotherGroupPassportView:onExit()
	BrotherGroupPassportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)

	self._showId = nil

	HeadItemController.instance:resetHeadCell(self._playerPos)
end

function BrotherGroupPassportView:_onClickHelp()
	ViewMgr.instance:open(ViewName.RulesView, self._curData.funcCfg.rule)
end

function BrotherGroupPassportView:_onClickOneKey()
	if not BrotherGroupModel.instance:checkAbleToGainPassport() then
		FloatWordMgr.instance:show(lang("当前队伍不满足领取要求"))

		return
	end

	if self._ableToGetOneKey then
		PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)

		return
	end

	if not self._curData.hasPay then
		self:_onClickPay()

		return
	end

	FloatWordMgr.instance:show(lang("当前无可领取奖励"))
end

function BrotherGroupPassportView:_onClickPay()
	if not BrotherGroupModel.instance:isExitTeam() then
		FloatWordMgr.instance:show(lang("当前队伍不满足购买要求"))

		return
	end

	local endTime = self._curData.actCfg.buyEndTime

	if not string.nilorempty(endTime) and ServerTime.now() > GameUtil.string2time(endTime) then
		FloatWordMgr.instance:show(lang("已到截止购买时间"))

		return
	end

	UIStateManager.instance:push(ViewName.BrotherGroupBuyView, self._curData.actCfg, self._curData.funcCfg, 1)
end

function BrotherGroupPassportView:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		self._effs[go]:setScrollRectClipping(self._scrollRect)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScale(1)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

function BrotherGroupPassportView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function BrotherGroupPassportView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.com = goutil.findChild(cell.go, "com")
	cell.txtProgrss = goutil.findChildTextComponent(cell.com, "txtProgress")
	cell.itemList = {}

	for i = 1, 3 do
		local itemcell = {}

		itemcell.go = i == 1 and goutil.findChild(cell.com, "item_" .. i) or goutil.findChild(cell.com, "specialItem/item_" .. i)
		itemcell.rp = goutil.findChild(itemcell.go, "rp")
		itemcell.mark = goutil.findChild(itemcell.go, "mark")
		itemcell.item = goutil.findChild(itemcell.go, "cell")

		MaterialMgr.resetAll(itemcell.item)
		goutil.setActive(itemcell.mark, false)
		goutil.setActive(itemcell.rp, false)
		self:_removeCellEff(itemcell.item)

		cell.itemList[i] = itemcell
	end

	return cell
end

function BrotherGroupPassportView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if not string.nilorempty(data.freePrize) then
		local proxy_1 = MaterialMgr.setCellByCfg(data.freePrize, cell.itemList[1].item)

		goutil.setActive(cell.itemList[1].mark, data.freeState)

		if not data.freeState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[1].rp, true)
			self:_playCellEff(cell.itemList[1].item)
			proxy_1:setAutoTips(false)
			proxy_1:setCallBack(function()
				if not BrotherGroupModel.instance:checkAbleToGainPassport() then
					FloatWordMgr.instance:show(lang("当前队伍不满足领取要求"))

					return
				end

				PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)
			end)
		end
	end

	local payPrizeStrs = string.split(data.payedPrize, "#")

	for i = 1, 2 do
		if not string.nilorempty(payPrizeStrs[i]) then
			local proxy_2 = MaterialMgr.setCellByCfg(data.payedPrize, cell.itemList[i + 1].item)

			goutil.setActive(cell.itemList[i + 1].mark, data.superState)

			if not data.superState and data.id < self._curData.unlockIndex then
				goutil.setActive(cell.itemList[i + 1].rp, true)
				proxy_2:setAutoTips(false)
				self:_playCellEff(cell.itemList[i + 1].item)
				proxy_2:setCallBack(function()
					if not BrotherGroupModel.instance:checkAbleToGainPassport() then
						FloatWordMgr.instance:show(lang("当前队伍不满足领取要求"))

						return
					end

					if self._curData.hasPay then
						PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true)
					else
						self:_onClickPay()
					end
				end)
			end
		end
	end

	cell.txtProgrss.text = data.progressKey

	if data.id then
		goutil.setActive(cell.com, true)
	else
		goutil.setActive(cell.com, false)
	end

	self:_refreshShowCell(self._tableview._tableview:GetCurrentIndex() + 1)
end

function BrotherGroupPassportView:_refreshShowCell(dataId)
	if self._curData.prizeCfgs[dataId] then
		if self._showId ~= self._curData.prizeCfgs[dataId] then
			self._showId = self._curData.prizeCfgs[dataId]

			local data = self._curData.prizeCfgs[self._showId]

			if data then
				self._txtShowProgress.text = langPara("%s积分解锁奖励", data.thresholdParam)
				self._showcell = self:getGo("showcell")

				for i = 1, 3 do
					MaterialMgr.resetAll(self._showItemList[i])
				end

				MaterialMgr.setCellByCfg(data.freePrize, self._showItemList[1])

				local prizeStrs = string.split(data.payedPrize, "#")

				MaterialMgr.setCellByCfg(prizeStrs and prizeStrs[1], self._showItemList[2])
				MaterialMgr.setCellByCfg(prizeStrs and prizeStrs[2], self._showItemList[3])
				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function BrotherGroupPassportView:_refreshView()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	local dataList = self:_getCurDataList()

	self._tableview:reloadData(dataList)
	self._sldProgress:SetValue(self._curData.sldValue)

	self._txtProgress.text = self._curData.progressTxt

	self:_refreshOneKey()
	self:_refreshPayBtn()
	self._tableview:MoveCellToCenter(self._moveId)
end

function BrotherGroupPassportView:_getCurDataList()
	self._moveId = -1

	local dataList = {}

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = v.thresholdParam
		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.isLast = false

		table.insert(dataList, data)

		if self._moveId == -1 then
			if data.id < self._curData.unlockIndex then
				if not data.freeState or not data.superState then
					self._moveId = data.id - 1
				end
			else
				self._moveId = self._curData.unlockIndex - 1
			end
		end
	end

	if self._moveId == -1 then
		self._moveId = #dataList - 1
	end

	dataList[#dataList].isLast = true

	return dataList
end

function BrotherGroupPassportView:_refreshOneKey()
	self._ableToGetOneKey = false

	for i = 1, self._curData.unlockIndex - 1 do
		if not self._curData.normalPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPay and not self._curData.superPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end
	end

	goutil.setActive(self._rpOneKey, self._ableToGetOneKey and BrotherGroupModel.instance:isExitTeam())
end

function BrotherGroupPassportView:_refreshPayBtn()
	goutil.setActive(self._btnPay, not self._curData.hasPay)
end

return BrotherGroupPassportView
