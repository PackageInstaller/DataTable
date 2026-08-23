local var_0_0 = g.core.model.User
local var_0_1 = g.core.model.User.activityDailyBoxData
local var_0_2 = g.core.const.ConstMgr.SpineConst
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.const.ConstMgr.ActivityConst.DAILY_SALE_INFO_INDEX
local ActivityDailyBoxGiftComp = class("ActivityDailyBoxGiftComp", require("app.fairyGUI.activity.UI_ActivityDailyBoxGiftComp"))

function ActivityDailyBoxGiftComp:ctor()
	self._dailyBoxInfo = nil

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_BOX)
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FIRST_DAILY_COST_ENTER)
	self:_initView()
end

function ActivityDailyBoxGiftComp:_initView()
	self.m_knightPicComp:updateKnight({
		resId = 400010
	})
	self.m_knightPicComp:setAlphaRect(var_0_2.MASK_TYPE.HORIZON, cc.rect(-250 / 2, 0, 250 * 2, 0), 250)
	self.m_oneKeyBuyBtn:addClickListener(handler(self, self._onClickOneKeyBuy))
	self.m_stepComp:addClickListener(handler(self, self._onClickStepProgressComp))
end

function ActivityDailyBoxGiftComp:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self.updateComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onRecOpRecharge), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_RECHARGE_DAILYBOXTURNAWARD, handler(self, self._onS2CGetTurnAward), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_RECHARGE_GETALLDAILYSALEAWARD, handler(self, self._onGetAllDailySaleAward), self)
	g.core.network.GameNetProxy:send_C2S_Recharge_GetRecharge({})
end

function ActivityDailyBoxGiftComp:updateComp()
	self._dailyBoxInfo = var_0_1:getDailyBoxData()

	for iter_4_0 = 1, 4 do
		if self["m_gift" .. iter_4_0] then
			self["m_gift" .. iter_4_0]:updateGift(self._dailyBoxInfo[iter_4_0], iter_4_0)
		end
	end

	if var_0_1:isWeekCardValid() then
		self.m_hasWeekCardController:setSelectedIndex(1)
	else
		self.m_hasWeekCardController:setSelectedIndex(0)
		self.m_isCanOneKeyController:setSelectedIndex(0)

		if not var_0_0.activityDailyBoxData:isCanOneKeyBuy() then
			self.m_isCanOneKeyController:setSelectedIndex(1)
		end

		local var_4_0 = self._dailyBoxInfo[var_0_6.ALL_BUY]

		self.m_allDiscount:setText(self._dailyBoxInfo[var_0_6.ALL_BUY].info.off .. "%")

		local var_4_1 = var_4_0.chargeInfo.realMoney or ""
		local var_4_2 = var_4_0.chargeInfo.moneyUnit or ""

		self.m_oneKeyBuyBtn:updateView({
			unit = var_4_2,
			price = var_4_1
		})
		self.m_weekCardDiscount:setText(self._dailyBoxInfo[var_0_6.WEEK_CARD].info.off .. "%")
	end

	self.m_weekCardBuyBtn:updateView()
	self:_updateMainCells()
	self.m_gameComp:updateGameCompView()

	if self.m_enterTransition and not self.m_enterTransition:isPlaying() then
		self.m_enterTransition:play()
	end
end

function ActivityDailyBoxGiftComp:_onClickOneKeyBuy()
	if var_0_1:isCanOneKeyBuy() then
		local var_5_0 = var_0_1:convertChargeInfo(self._dailyBoxInfo[var_0_6.ALL_BUY].info)

		var_5_0.buyTimes = 0
		var_5_0.clickCall = handler(self, self.onClickBuyCallBack)

		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(var_5_0))
	elseif var_0_0.activityDailyBoxData:isBuyFullGift() then
		g.core.module.ModuleManager:tip(g.core.lang:get(404010))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(404009))
	end
end

function ActivityDailyBoxGiftComp:onClickBuyCallBack()
	local var_6_0 = self._dailyBoxInfo[var_0_6.ALL_BUY].chargeInfo
	local var_6_1 = self._dailyBoxInfo[var_0_6.ALL_BUY].info.id

	if config.PCSDK_ENABLED then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._dailyBoxInfo[var_0_6.ALL_BUY].chargeInfo, self._dailyBoxInfo[var_0_6.ALL_BUY].info.id, 0)
	else
		local var_6_2 = require("app.view.base.pop.BaseConfirmPop").new

		var_0_5:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(404004),
			desc = g.core.lang:get(404005, {
				priceUnit = self._dailyBoxInfo[var_0_6.ALL_BUY].chargeInfo.moneyUnit,
				price = self._dailyBoxInfo[var_0_6.ALL_BUY].chargeInfo.realMoney
			}),
			onConfirm = handler(self, function()
				g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, var_6_0, var_6_1, 0)
			end)
		}))
	end
end

function ActivityDailyBoxGiftComp:_onRecOpRecharge(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.network.GameNetProxy:send_C2S_Recharge_GetRecharge({})

	if arg_8_4 and arg_8_4.daily_sale then
		var_0_5:awardSummary(arg_8_4.daily_sale.awards or {})
	end

	self:_updateMainCells()
end

function ActivityDailyBoxGiftComp:_onClickStepProgressComp()
	var_0_5:pushPopup((require("app.view.module.activity.view.activityDailyBoxGift.ActivityDailyProgPop").new()))
end

function ActivityDailyBoxGiftComp:_updateMainCells()
	self.m_stepComp:updateStepProgress()
	self.m_proAwardComp:updateProgresAward()
end

function ActivityDailyBoxGiftComp:_onGetRecharge()
	self:_updateMainCells()
end

function ActivityDailyBoxGiftComp:_onS2CGetTurnAward(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_12_4.awards)
		self:_updateMainCells()
	end
end

function ActivityDailyBoxGiftComp:_onGetAllDailySaleAward(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4 and arg_13_4.award then
		var_0_5:awardSummary(arg_13_4.award)
		g.core.network.GameNetProxy:send_C2S_Recharge_GetRecharge({})
	end
end

return ActivityDailyBoxGiftComp
