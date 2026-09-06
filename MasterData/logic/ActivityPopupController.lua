-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/controller/ActivityPopupController.lua

module("logic.extensions.activitypopup.controller.ActivityPopupController", package.seeall)

local ActivityPopupController = class("ActivityPopupController", BaseController)

function ActivityPopupController:ctor()
	return
end

function ActivityPopupController:onInit()
	self:onReset()
	GameUtil.whenLocalDataInited(function()
		local isNotShow = GameUtil.getUserDayData(ActivityPopupModel.instance:getSignString())

		if not isNotShow then
			ActivityPopupModel.instance:initActivityPopup()
		end

		ViewAutoShowController.instance:setAutoCheckOp("checkHasActPopup", ActivityPopupModel.instance:getHasActView())
		ViewAutoShowController.instance:setAutoCheckOp("checkHasAutoMall", ActivityPopupModel.instance:getHasAutoMall())
	end)
	GlobalDispatcher:addListener(MonthCardModel.CarStatesChange, self.onCheckLuoshiqi, self)
	GlobalDispatcher:addListener(NewHandCardAgent.NewHandCardInfoRes, self.onCheckLuoshiqi, self)
	GlobalDispatcher:addListener(PayShopModel.GetAllPayShopBuyTimesRes, self.onCheckLuoshiqi, self)
end

function ActivityPopupController:onCheckLuoshiqi()
	local isCanBuy = true

	for k, cfg in pairs(HdluoshiqiView.config) do
		if cfg.payType == GameEnum.PaySubGoodsType.PAY_SHOP then
			local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

			isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(cfg.shopId)
		elseif cfg.payType == GameEnum.PaySubGoodsType.NEW_HAND_CARD then
			local newCfg = NewHandCardConfig.instance:getCfgById(cfg.shopId)
			local buyNewhandcard = NewHandCardModel.instance:isBuyCard()
			local inAct = NewHandCardModel.instance:isInAct()

			isCanBuy = not buyNewhandcard and inAct
		elseif cfg.payType == GameEnum.PaySubGoodsType.MONTH_CARD then
			local newCfg = MonthCardConfig.instance:getCfgById(cfg.shopId)

			isCanBuy = not MonthCardModel.instance:isCardActive(cfg.shopId)
		end

		if isCanBuy == true then
			break
		end
	end

	self._zqtjCanBuy = isCanBuy

	GlobalDispatcher:dispatch(PayShopModel.ChangeZQTHState)
end

function ActivityPopupController:onBuyCheckLuoshiqi()
	if self._zqtjCanBuy then
		self:onCheckLuoshiqi()
	end
end

function ActivityPopupController:getZQTJCanBuy()
	return self._zqtjCanBuy
end

function ActivityPopupController:onReset()
	self._zqtjCanBuy = false
end

ActivityPopupController.instance = ActivityPopupController.New()

return ActivityPopupController
