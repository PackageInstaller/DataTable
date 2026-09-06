-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupBuyView.lua

module("logic.extensions.brothergroup.view.BrotherGroupBuyView", package.seeall)

local BrotherGroupBuyView = class("BrotherGroupBuyView", PassportwpbuyView)

function BrotherGroupBuyView:buildUI()
	BrotherGroupBuyView.super.buildUI(self)

	self._discountTip = self:getGo("discountTip")
	self._btnDiscount = goutil.findChild(self._discountTip, "btnBuy")
	self._txtDiscount = goutil.findChildTextComponent(self._btnDiscount, "txt")
	self._txtDiscount_1 = goutil.findChildTextComponent(self._btnDiscount, "txt_1")
end

function BrotherGroupBuyView:bindEvents()
	BrotherGroupBuyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnDiscount, self._onClickBtnBuy, self)
end

function BrotherGroupBuyView:unbindEvents()
	BrotherGroupBuyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnDiscount)
end

function BrotherGroupBuyView:onEnter()
	BrotherGroupBuyView.super.onEnter(self)
	GameUtil.SetActive(self._discountTip, false)
	GameUtil.SetActive(self._btnBuy.gameObject, false)

	local isTimeDiscount = not string.nilorempty(self._actCfg.discountTime) and GameUtil.checkTimeStr(self._actCfg.discountTime)

	if isTimeDiscount then
		GameUtil.SetActive(self._discountTip, true)
	else
		GameUtil.SetActive(self._btnBuy.gameObject, true)
	end

	self._txtDiscount.text = string.format("¥%s", PayConfig.instance:getPayMoneyYuan(self._actCfg.discountGoodsId))
	self._txtDiscount_1.text = string.format("¥%s", PayConfig.instance:getPayMoneyYuan(self._actCfg.goodsId))
end

return BrotherGroupBuyView
