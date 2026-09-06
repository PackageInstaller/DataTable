-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagMainView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagMainView", package.seeall)

local BuddyLuckyBagMainView = class("BuddyLuckyBagMainView", ViewComponent)

function BuddyLuckyBagMainView:buildUI()
	BuddyLuckyBagMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._txtTips = self:getTxt("tips/txt")
	self._btnShare = self:getGo("jumpBtnCol/btnShare")
	self._btnCard = self:getGo("jumpBtnCol/btnCard")
	self._redPointBtnCard = self:getGo("jumpBtnCol/btnCard/redPoint")
	self._bagView = self:getGo("bagCol/bagView")
	self._bagCell = self:getGo("bagCol/bagCell")
	self._effZi = self:getGo("effZi")
	self._effFenwei = self:getGo("effFenwei")

	GameUtil.SetActive(self._bagCell, false)
end

function BuddyLuckyBagMainView:bindEvents()
	BuddyLuckyBagMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickBtnCard, self)
end

function BuddyLuckyBagMainView:unbindEvents()
	BuddyLuckyBagMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnCard)
end

function BuddyLuckyBagMainView:onEnter()
	BuddyLuckyBagMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = BuddyLuckyBagController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)
	self._actData = BuddyLuckyBagConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGainBagPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagNotifyChangeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagHelpOpenBagRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGainLuckRes, self._onUpdate, self)
	BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagGetInfoReq(self._activityId)
end

function BuddyLuckyBagMainView:onExit()
	BuddyLuckyBagMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointBtnCard)
	self:_onClearBagCol()
end

function BuddyLuckyBagMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointBtnCard, RedPointModel.ID_BUDDYLUCKYBAG_CARD_GAIN)

	local effPath = "20260626/chaifudai/fx_ui_chaifudai_fw.prefab"

	self:playViewEffectUniGo(effPath, self._effFenwei, nil, true, nil, nil)
end

function BuddyLuckyBagMainView:_onUpdate()
	local leftGainBagTimes = self._subMo:getLeftGainBagTimes()
	local maxGainBagTimes = self._subMo:getMaxGainBagTimes()

	self._txtTips.text = string.format("可领取福袋：%s/<color=#FFD99D>%s</color>", leftGainBagTimes, maxGainBagTimes)

	local bagDatas = BuddyLuckyBagConfig.instance:getBagDatas(self._activityId)

	self._bagCellList = self._bagCellList or {}

	local childCount = self._bagView.transform.childCount
	local dataLength = #bagDatas

	for idx = 1, dataLength do
		local cell = self._bagCellList[idx]

		if cell == nil then
			local mainGo = goutil.cloneAndSetParent(self._bagCell, self._bagView.transform, self._bagCell.name .. idx)

			cell = {}
			self._bagCellList[idx] = cell
			cell._mainGo = mainGo
			cell._icon = goutil.findChild(mainGo, "mask/icon")
			cell._tagLock = goutil.findChild(mainGo, "tagLock")
			cell._tagShare = goutil.findChild(mainGo, "tagShare")
			cell._tagHasGain = goutil.findChild(mainGo, "tagHasGain")
			cell._tagCard = goutil.findChild(mainGo, "tagCard")
			cell._btnGain = goutil.findChild(mainGo, "btnGain")
			cell._btnPrizeShare = goutil.findChild(mainGo, "btnPrizeShare")
			cell._txtName = goutil.findChildTextComponent(mainGo, "name/txt")
			cell._effRoot = goutil.findChild(mainGo, "effRoot")
			cell._btnPop = goutil.findChild(mainGo, "btnPop")
		end

		local data = bagDatas[idx]

		self:_updateBagCell(cell, data)
	end

	for idx = dataLength + 1, childCount do
		local cell = self._bagCellList[idx]

		GameUtil.SetActive(cell._mainGo, false)
		self:_clearBagCell(cell)
	end
end

function BuddyLuckyBagMainView:_onClearBagCol()
	if self._bagCellList == nil then
		return
	end

	for _, cell in pairs(self._bagCellList) do
		self:_clearBagCell(cell)
	end
end

function BuddyLuckyBagMainView:_updateBagCell(cell, data)
	local bagId = data.bagId
	local poolId = data.poolId
	local prizeId = self._subMo:getPrizeIdInBag(bagId)
	local isGain = self._subMo:isPrizeGainInBag(bagId)
	local leftGainBagTimes = self._subMo:getLeftGainBagTimes()
	local prizeData = BuddyLuckyBagConfig.instance:getPoolPrizeData(poolId, prizeId)
	local matType, matId, matNum, matName

	if prizeData then
		matType, matId, matNum = MaterialMgr.getMatParams(prizeData.prize)
		matName = MaterialMgr.getMaterialsName(matType, matId)
	end

	local isUnlock = prizeData ~= nil
	local isEnoughTimes = leftGainBagTimes > 0
	local maxGainBagTimes = self._subMo:getMaxGainBagTimes()
	local isCanGain = isUnlock and not isGain and isEnoughTimes

	if not data.pos then
		local pos = {}

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			GameUtil.setLocalPos(cell._mainGo, x, y, 0)
			GameUtil.setLocalScale(cell._mainGo, pos[3])
			GameUtil.SetActive(cell._mainGo, true)
			GameUtil.SetActive(cell._tagLock, not isUnlock)
			GameUtil.SetActive(cell._tagShare, not isUnlock)
			GameUtil.SetActive(cell._icon, isUnlock)
			GameUtil.SetActive(cell._tagHasGain, isGain)
			GameUtil.SetActive(cell._tagCard, isUnlock and not isGain and isEnoughTimes)
			GameUtil.SetActive(cell._btnGain, isUnlock and not isGain)
			GameUtil.SetActive(cell._btnPrizeShare, isUnlock)
			GameUtil.SetActive(cell._txtName, not string.nilorempty(data.name))

			cell._txtName.text = data.name

			if isCanGain then
				local effPath = "20260626/chaifudai/fx_ui_chaifudai_kuang.prefab"

				self:playViewEffectUniGo(effPath, cell._effRoot, nil, true, nil, nil)
			else
				self:stopViewEffectUniGo(cell._effRoot)
			end

			if prizeData then
				MaterialMgr.setIcon(cell._icon, matType, matId, nil, nil)
				GameUtil.addClickHandler(cell._icon, function()
					CommonTipsMgr.instance:openMaterialTips(cell._icon, matType, matId, matNum)
				end, self)
			else
				MaterialMgr.clearIcon(cell._icon)
				GameUtil.rmClickHandler(cell._icon)
			end

			GameUtil.addClickHandler(cell._tagCard, function()
				UIStateManager.instance:push(ViewName.BuddyLuckyBagHelpCardUseView, self._activityId, bagId, prizeId)
			end, self)
			GameUtil.addClickHandler(cell._tagShare, function()
				UIStateManager.instance:push(ViewName.BuddyLuckyBagShareView, self._activityId)
			end, self)
			GameUtil.addClickHandler(cell._btnPrizeShare, function()
				local bagInfo = {}

				bagInfo.buddyId = RoleModel.instance:getUserId()
				bagInfo.bagId = bagId
				bagInfo.prizeId = prizeId

				UIStateManager.instance:push(ViewName.BuddyLuckyBagSharePrizeView, self._activityId, bagInfo)
			end, self)
			GameUtil.addClickHandler(cell._btnGain, function()
				if isGain then
					FloatWordMgr.instance:show("已领取")

					return
				end

				if not isUnlock then
					FloatWordMgr.instance:show("未解锁")

					return
				end

				local leftGainBagTimes = self._subMo:getLeftGainBagTimes()

				if leftGainBagTimes <= 0 then
					FloatWordMgr.instance:show("次数不足")

					return
				end

				local tipsContent = string.format("是否确认领取【%s×%s】？\n剩余领取福袋次数：%s / %s", matName, matNum, leftGainBagTimes, maxGainBagTimes)

				local function okFunc()
					BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagGainBagPrizeReq(self._activityId, bagId)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
			end, self)
			GameUtil.addClickHandler(cell._btnPop, function()
				return
			end, self)
		end
	end
end

function BuddyLuckyBagMainView:_clearBagCell(cell)
	MaterialMgr.clearIcon(cell._icon)
	GameUtil.rmClickHandler(cell._icon)
	GameUtil.rmClickHandler(cell._tagCard)
	GameUtil.rmClickHandler(cell._tagShare)
	GameUtil.rmClickHandler(cell._btnGain)
	GameUtil.rmClickHandler(cell._btnPrizeShare)
	self:stopViewEffectUniGo(cell._effRoot)
end

function BuddyLuckyBagMainView:_onClickBtnTip()
	UIStateManager.instance:push(ViewName.BuddyluckypreviewView, self._activityId)
end

function BuddyLuckyBagMainView:_onClickBtnShare()
	UIStateManager.instance:push(ViewName.BuddyLuckyBagHelpShareView, self._activityId)
end

function BuddyLuckyBagMainView:_onClickBtnCard()
	local jumpStr = self._actData.jumpStrToCard

	GotoMgr.gotoByString(jumpStr)
end

return BuddyLuckyBagMainView
