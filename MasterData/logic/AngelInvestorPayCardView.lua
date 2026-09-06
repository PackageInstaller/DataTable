-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorPayCardView.lua

module("logic.extensions.angelinvestor.view.AngelInvestorPayCardView", package.seeall)

local AngelInvestorPayCardView = class("AngelInvestorPayCardView", ViewComponent)

function AngelInvestorPayCardView:ctor()
	AngelInvestorPayCardView.super.ctor(self)
end

function AngelInvestorPayCardView:unbindEvents()
	AngelInvestorPayCardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function AngelInvestorPayCardView:bindEvents()
	AngelInvestorPayCardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function AngelInvestorPayCardView:buildUI()
	AngelInvestorPayCardView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtBtnSure = self:getTxt("btnSure/txt")
	self._txtTip = self:getTxt("txtTip")
end

function AngelInvestorPayCardView:onExit()
	AngelInvestorPayCardView.super.onExit(self)
end

function AngelInvestorPayCardView:onEnter()
	AngelInvestorPayCardView.super.onEnter(self)
	self.addGEvent(self, PayShopAgent.NotifyPayShopItemBuySucRes, self._onPayRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 588001
	end

	self._actCfg = AngelInvestorConfig.instance:getActivityCfg(self._activityId)

	self:_onSetUI()
end

function AngelInvestorPayCardView:_onSetUI()
	if self._actCfg then
		if not self._actCfg.payCardMoney then
			local payMoney = 12
			local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)

			if self._actCfg then
				self._txtTip.text = self._actCfg.payCardTip or ""
			end

			self._txtBtnSure.text = buyTime > 0 and lang("已售罄") or string.format("￥%s", payMoney)

			GameUtil.SetGray(self._btnSure, buyTime > 0)
		end
	end
end

function AngelInvestorPayCardView:_onClickBtnSure()
	if self._actCfg then
		if self._actCfg then
			local goodsId = self._actCfg.goodsId
			local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)

			if buyTime > 0 then
				FloatWordMgr.instance:show(lang("已购买，请勿重复操作"))

				return
			end

			if self._actCfg and goodsId then
				PayController.instance:pay(goodsId, GameEnum.PaySubGoodsType.PAY_SHOP, self._actCfg)
			end
		end
	end
end

function AngelInvestorPayCardView:_onPayRes()
	FloatWordMgr.instance:show(lang("支付成功！"))
	self:close()
end

return AngelInvestorPayCardView
