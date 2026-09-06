-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagHelpCardSureView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagHelpCardSureView", package.seeall)

local BuddyLuckyBagHelpCardSureView = class("BuddyLuckyBagHelpCardSureView", ViewComponent)

function BuddyLuckyBagHelpCardSureView:buildUI()
	BuddyLuckyBagHelpCardSureView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._curCardRoot = self:getGo("curCard")
	self._txtNameCurCard = self:getTxt("curCard/txtName")
	self._curCardIcon = self:getGo("curCard/mask/icon")
	self._newCardRoot = self:getGo("newCard")
	self._txtNameNewCard = self:getTxt("newCard/txtName")
	self._newCardIcon = self:getGo("newCard/mask/icon")
end

function BuddyLuckyBagHelpCardSureView:bindEvents()
	BuddyLuckyBagHelpCardSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BuddyLuckyBagHelpCardSureView:unbindEvents()
	BuddyLuckyBagHelpCardSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function BuddyLuckyBagHelpCardSureView:onEnter()
	BuddyLuckyBagHelpCardSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._oldBagInfo = params[2]
	self._newBagInfo = params[3]
	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGainLuckRes, self._handlePM_BuddyLuckyBagGainLuckRes, self)
	self:_onUpdateUI()
end

function BuddyLuckyBagHelpCardSureView:onExit()
	BuddyLuckyBagHelpCardSureView.super.onExit(self)
	GameUtil.rmClickHandler(self._curCardIcon)
	GameUtil.rmClickHandler(self._newCardIcon)
	MaterialMgr.clearIcon(self._curCardIcon)
	MaterialMgr.clearIcon(self._newCardIcon)
end

function BuddyLuckyBagHelpCardSureView:_handlePM_BuddyLuckyBagGainLuckRes()
	FloatWordMgr.instance:show("使用成功")
	self:close()
end

function BuddyLuckyBagHelpCardSureView:_onUpdateUI()
	if self._oldBagInfo then
		local bagId = self._oldBagInfo.bagId
		local prizeId = self._oldBagInfo.prizeId
		local bagData = BuddyLuckyBagConfig.instance:getBagData(self._activityId, bagId)
		local poolId = bagData.poolId
		local data = BuddyLuckyBagConfig.instance:getPoolPrizeData(poolId, prizeId)
		local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		MaterialMgr.setIcon(self._curCardIcon, matType, matId, nil, nil)
		GameUtil.addClickHandler(self._curCardIcon, function()
			CommonTipsMgr.instance:openMaterialTips(self._curCardIcon, matType, matId, matNum)
		end, self)

		self._txtNameCurCard.text = string.format("%s x %s", matName, matNum)
	end

	if self._newBagInfo then
		local bagId = self._newBagInfo.bagId
		local prizeId = self._newBagInfo.prizeId
		local bagData = BuddyLuckyBagConfig.instance:getBagData(self._activityId, bagId)
		local poolId = bagData.poolId
		local data = BuddyLuckyBagConfig.instance:getPoolPrizeData(poolId, prizeId)
		local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		MaterialMgr.setIcon(self._newCardIcon, matType, matId, nil, nil)
		GameUtil.addClickHandler(self._newCardIcon, function()
			CommonTipsMgr.instance:openMaterialTips(self._newCardIcon, matType, matId, matNum)
		end, self)

		self._txtNameNewCard.text = string.format("%s x %s", matName, matNum)
	end
end

function BuddyLuckyBagHelpCardSureView:_onClickBtnSure()
	local buddyId = checknumber(self._newBagInfo.buddyId)
	local bagId = checknumber(self._newBagInfo.bagId)
	local prizeId = checknumber(self._newBagInfo.prizeId)
	local isHasSelect = buddyId > 0 and bagId > 0 and prizeId > 0

	if not isHasSelect then
		FloatWordMgr.instance:show("未选择福袋")

		return
	end

	local cardCount = self._subMo:getCardCount()

	if cardCount <= 0 then
		FloatWordMgr.instance:show("剩余沾福卡不足")

		return
	end

	local tipsContent = "替换后，旧福袋消失，是否确定替换？"

	local function okFunc()
		BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagGainLuckReq(self._activityId, buddyId, bagId, prizeId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

return BuddyLuckyBagHelpCardSureView
