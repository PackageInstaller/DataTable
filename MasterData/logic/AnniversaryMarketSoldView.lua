-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketSoldView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketSoldView", package.seeall)

local AnniversaryMarketSoldView = class("AnniversaryMarketSoldView", ViewComponent)

function AnniversaryMarketSoldView:ctor()
	AnniversaryMarketSoldView.super.ctor(self)
end

function AnniversaryMarketSoldView:unbindEvents()
	AnniversaryMarketSoldView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLessTen)
	GameUtil.rmClickHandler(self._btnAddTen)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnSold)
	GameUtil.rmClickHandler(self._btnGoldBar)
	self._inputComp:RemoveOnValueChanged()
end

function AnniversaryMarketSoldView:bindEvents()
	AnniversaryMarketSoldView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLessTen, self._onClickBtnLessTen, self)
	GameUtil.addClickHandler(self._btnAddTen, self._onClickBtnAddTen, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickBtnAdd, self)
	GameUtil.addClickHandler(self._btnLess, self._onClickBtnLess, self)
	GameUtil.addClickHandler(self._btnSold, self._onClickBtnSold, self)
	GameUtil.addClickHandler(self._btnGoldBar, self._onClickBtnGoldBar, self)
	self._inputComp:AddOnValueChanged(self._onValueChanged, self)
end

function AnniversaryMarketSoldView:buildUI()
	AnniversaryMarketSoldView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._imgSold = self:getGo("soldBar/imgSold")
	self._txtPrice = self:getTxt("soldBar/txtPrice")
	self._highPrizeTag = self:getGo("soldBar/highPrizeTag")
	self._lowPrizeTag = self:getGo("soldBar/lowPrizeTag")
	self._txtSoldNum = self:getTxt("addBar/inputField/Text")
	self._btnLessTen = self:getGo("addBar/adjust/btnLessTen")
	self._btnAddTen = self:getGo("addBar/adjust/btnAddTen")
	self._btnAdd = self:getGo("addBar/adjust/btnAdd")
	self._btnLess = self:getGo("addBar/adjust/btnLess")
	self._btnSold = self:getGo("btnSold")
	self._txtSoldFriendNum = self:getTxt("friend/txtNum")
	self._txtNum = self:getTxt("goldBar/txtNum")
	self._item = self:getGo("goldBar/item")
	self._btnGoldBar = self:getGo("goldBar")
	self._friendGo = self:getGo("friend")
	self._inputComp = self:getInput("addBar/inputField")
end

function AnniversaryMarketSoldView:onExit()
	AnniversaryMarketSoldView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgSold)
	MaterialMgr.clearIcon(self._item)
end

function AnniversaryMarketSoldView:onEnter()
	AnniversaryMarketSoldView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetInfoRes, self._getInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetOtherInfoRes, self._getOtherInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetMyShareCodeRes, self._getMyShareCode, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._isFriend = params[2]
	self._shareCode = params[3]
	self._actCfg = AnniversaryMarketConfig.instance:getActCfg(self._activityId)
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self._soldNum = 0

	AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetMyShareCodeReq(self._activityId)
end

function AnniversaryMarketSoldView:_onSetUI()
	local sellScoreMpKey = self._actCfg.sellScoreMpKey
	local matType, matId, matNum = MaterialMgr.getMatParams(sellScoreMpKey)
	local refreshMatType, refreshMatId, refreshMatNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local curPriceCfgs = AnniversaryMarketConfig.instance:getPriceRangesCfg(self._actCfg.commonPricePlanId)
	local curPriceCfg = curPriceCfgs[#curPriceCfgs]
	local maxRange = curPriceCfg.priceRange
	local isHighPrize = false
	local sellForOtherDailyLimit = self._actCfg.sellForOtherDailyLimit
	local soldName = ""

	soldName = self._friendParams and self._friendParams.otherName or RoleModel.instance:getUserName()
	self._txtTitle.text = string.format("%s的市集", soldName)
	self._txtSoldNum.text = self._soldNum
	self._txtNum.text = hasSellMatNum

	if self._isFriend then
		self._txtSoldFriendNum.text = string.format("%s今日剩余收购数：<color=#FF0000FF>%d/%d</color>", soldName, sellForOtherDailyLimit - self._friendParams.otherSellCount, sellForOtherDailyLimit)
		self._txtPrice.text = self._friendParams.todayPrice
		isHighPrize = self._friendParams.todayPrice >= maxRange[1]
	else
		self._txtPrice.text = self._info.todayPrice
		isHighPrize = self._info.todayPrice >= maxRange[1]
	end

	self._inputComp:SetText(self._soldNum)
	MaterialMgr.setIcon(self._imgSold, refreshMatType, refreshMatId, nil, nil)
	MaterialMgr.setIcon(self._item, matType, matId, nil, nil)
	GameUtil.SetActive(self._highPrizeTag, isHighPrize)
	GameUtil.SetActive(self._lowPrizeTag, not isHighPrize)
	GameUtil.SetActive(self._friendGo, self._isFriend)
end

function AnniversaryMarketSoldView:_onClickBtnLessTen()
	self._soldNum = self._soldNum < 10 and 0 or self._soldNum - 10

	self._inputComp:SetText(self._soldNum)
end

function AnniversaryMarketSoldView:_onClickBtnAddTen()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if self._isFriend then
		local soldNumLimit = self._actCfg.sellForOtherDailyLimit
		local leftCanSoldNum = soldNumLimit - self._friendParams.otherSellCount

		self._soldNum = leftCanSoldNum < self._soldNum + 10 and math.min(leftCanSoldNum, hasSellMatNum) or math.min(self._soldNum + 10, hasSellMatNum)
	else
		self._soldNum = math.min(self._soldNum + 10, hasSellMatNum)
	end

	self._inputComp:SetText(self._soldNum)
end

function AnniversaryMarketSoldView:_onClickBtnAdd()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if self._isFriend then
		local soldNumLimit = self._actCfg.sellForOtherDailyLimit
		local leftCanSoldNum = soldNumLimit - self._friendParams.otherSellCount
		local finalCanSoldNum = math.min(leftCanSoldNum, hasSellMatNum)

		if finalCanSoldNum > self._soldNum then
			self._soldNum = self._soldNum + 1
		end
	elseif hasSellMatNum > self._soldNum then
		self._soldNum = self._soldNum + 1
	end

	self._inputComp:SetText(self._soldNum)
end

function AnniversaryMarketSoldView:_onClickBtnLess()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if self._soldNum > 0 then
		self._soldNum = self._soldNum - 1
	end

	self._inputComp:SetText(self._soldNum)
end

function AnniversaryMarketSoldView:_onValueChanged(numStr)
	local sellNum = checkint(numStr)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local maxSellNum = 0

	if self._isFriend then
		local soldNumLimit = self._actCfg.sellForOtherDailyLimit
		local leftCanSoldNum = soldNumLimit - self._friendParams.otherSellCount

		maxSellNum = math.min(leftCanSoldNum, hasSellMatNum)
	else
		maxSellNum = hasSellMatNum
	end

	sellNum = Mathf.Clamp(sellNum, 0, maxSellNum)
	self._soldNum = sellNum

	self._inputComp:SetText(tostring(self._soldNum))
end

function AnniversaryMarketSoldView:_onClickBtnSold()
	if self._isFriend then
		local soldNumLimit = self._actCfg.sellForOtherDailyLimit
		local leftCanSoldNum = soldNumLimit - self._friendParams.otherSellCount

		if leftCanSoldNum <= 0 then
			FloatWordMgr.instance:show("今日收购已达上限，下次再来吧~")

			return
		end

		if checknumber(self._soldNum) == 0 then
			FloatWordMgr.instance:show("无法卖出0个")

			return
		end

		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
		local refreshMatName = MaterialMgr.getMaterialsName(matType, matId)
		local hasRefreshMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
		local sellMatName = MaterialMgr.getMaterialsName(matType, matId)
		local getPrice = self._soldNum * self._friendParams.todayPrice
		local tipsContent = string.format("是否出售%s×%d?\n本次可获得%s×%d", sellMatName, self._soldNum, refreshMatName, getPrice)

		local function okFunc()
			AnniversaryMarketController.instance:sendPM_AnniversaryMarketSellInOtherMarketReq(self._activityId, self._shareCode, self._soldNum)
			self:close()
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc)
	else
		if checknumber(self._soldNum) == 0 then
			FloatWordMgr.instance:show("无法卖出0个")

			return
		end

		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
		local refreshMatName = MaterialMgr.getMaterialsName(matType, matId)
		local hasRefreshMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
		local sellMatName = MaterialMgr.getMaterialsName(matType, matId)
		local getPrice = self._soldNum * self._info.todayPrice
		local tipsContent = string.format("是否出售%s×%d?\n本次可获得%s×%d", sellMatName, self._soldNum, refreshMatName, getPrice)

		local function okFunc()
			AnniversaryMarketController.instance:sendPM_AnniversaryMarketSellInMyMarketReq(self._activityId, self._soldNum)
			self:close()
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc)
	end
end

function AnniversaryMarketSoldView:_onClickBtnGoldBar()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)

	CommonTipsMgr.instance:openMaterialTips(self._btnGoldBar, checknumber(matType), checknumber(matId), checknumber(self._info.curScore))
end

function AnniversaryMarketSoldView:_getInfoRes()
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)

	if self._isFriend then
		AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetOtherInfoReq(self._activityId, self._shareCode)
	else
		self:_onSetUI()
	end
end

function AnniversaryMarketSoldView:_getOtherInfoRes(msg, isCorrectShareCode)
	if isCorrectShareCode then
		self._friendParams = msg

		self:_onSetUI()
	end
end

function AnniversaryMarketSoldView:_getMyShareCode(shareCode)
	if self._shareCode and shareCode == self._shareCode then
		self._isFriend = false
	end

	if not self._isFriend then
		AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetInfoReq(self._activityId)
	else
		AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetOtherInfoReq(self._activityId, self._shareCode)
	end
end

return AnniversaryMarketSoldView
