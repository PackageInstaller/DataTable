local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.model.User.gmFundData
local GmFundConst = require("app.view.module.newFund.const.GmFundConst")
local FundNewPop = class("FundNewPop", require("app.fairyGUI.newFund.UI_FundNewPop"), function()
	return fgui.GComponent:create({
		resName = "FundNewPop",
		pkgPath = "ui/newFund/newFund",
		isFullScreen = false,
		pkgName = "newFund"
	}, ...)
end)

function FundNewPop:ctor(arg_2_1)
	if arg_2_1 then
		self._fundType = arg_2_1.fundType or GmFundConst.FUND_TYPE.FOG_NIGHTMARE
	end

	self.m_closePnl:addClickListener(handler(self, self.closePnl))

	self._isFirstEnter = true

	self.m_descTxt:enableRich()
	self:showAtCenter()
	self:initFundView()
end

function FundNewPop:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FUND_ACTIVITY_GETINFO, handler(self, self.onFundActivityInfo), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FUND_ACTIVITY_UPDATEACTION, handler(self, self.onFundActivityInfo), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FUND_ACTIVITY_LEVELAWARD, handler(self, self.onGetLvUpAward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self.onFundRecharge), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	g.core.network.GameNetProxy:send_C2S_FundActivity_GetInfo({
		activity_id = var_0_3:getSvrIdByType(self._fundType)
	})
	self:_onUpdateTime()
	self:updateFundView()
	self:newSchedule(handler(self, self._onUpdateTime), 1)

	if self._fundType == GmFundConst.FUND_TYPE.FOG_NIGHTMARE then
		self.m_enter0Transition:play()
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_newFund_fogBg",
			remove = true,
			isLoop = false
		})
	elseif self._fundType == GmFundConst.FUND_TYPE.GVE then
		self.m_enter1Transition:play()
	elseif self._fundType == GmFundConst.FUND_TYPE.FOREST then
		self.m_enter2Transition:play()
		self.m_eff2:addEffectSpine({
			anim = "play",
			name = "eff_ui_newFund_explorationBg",
			remove = true,
			isLoop = false
		})
	end
end

function FundNewPop:_onCrossDay()
	if var_0_3:isFundInOpenTime((var_0_3:getActivityIdBySid(var_0_3:getSvrIdByType(self._fundType)))) then
		g.core.network.GameNetProxy:send_C2S_FundActivity_GetInfo({
			activity_id = var_0_3:getSvrIdByType(self._fundType)
		})
	else
		self:closePnl()
	end
end

function FundNewPop:initFundView()
	self.m_payBtn:addClickListener(handler(self, self._onPayBtnClick))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyRewardClick))
	self.m_typeController:setSelectedIndex(self._fundType - 1)

	local var_5_0 = var_0_3:getCfgByType(self._fundType)

	self.m_discountTxt:setText(var_5_0.ratio .. "%")

	local var_5_1 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.FUND_NEW, var_5_0.money)

	self._rechargeInfo = var_5_1

	self.m_payBtn:setTitle((var_5_1.moneyUnit or "") .. var_5_1.realMoney)
	self.m_descTxt:setText(var_5_0.slogan)
	self.m_taskNameTxt:setText(var_5_0.des)

	self._fundLvs = var_0_3:getFundRewardItems(self._fundType)

	self.m_fundList:setVirtual()
	self.m_fundList:doFairyBatching(false)
	self.m_fundList:setItemRenderer(handler(self, self._onFundRenderer))
	self.m_fundList:setNumItems(#self._fundLvs)
end

function FundNewPop:closePnl()
	self.m_backTransition:play(handler(self, self.onFinishClose))
end

function FundNewPop:onFinishClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function FundNewPop:_onUpdateTime()
	self._endTime = self._endTime or var_0_3:getActivityEndTime(self._fundType)

	local var_8_0, var_8_1, var_8_2, var_8_3 = var_0_2:getLeftTimeParts(self._endTime)

	self.m_timeTxt:setText(g.core.lang:get(422506, {
		day = var_8_0,
		hour = var_8_1
	}))
end

function FundNewPop:updateFundView()
	self.m_hasDataController:setSelectedIndex(1)
	self.m_isBuyController:setSelectedIndex(var_0_3:isActivityRecharge(self._fundType) and 1 or 0)

	local var_9_0, var_9_1 = var_0_3:getAllGetAwardNums(self._fundType)

	if var_9_1 then
		self.m_oneKeyController:setSelectedIndex(2)
	else
		self.m_oneKeyController:setSelectedIndex(var_9_0 > 2 and 1 or 0)
	end

	self.m_curStageTxt:setText(var_0_3:getCurFundValue(self._fundType))

	self._fundLvs = var_0_3:getFundRewardItems(self._fundType)

	self.m_fundList:setNumItems(#self._fundLvs)

	if self._isFirstEnter and var_0_3:getFundLevel(var_0_3:getCfgByType(self._fundType).id) > 0 then
		self._isFirstEnter = false

		self.m_fundList:scrollToView(var_0_3:getFirstCanRewardIndex(self._fundType) - 1)
	end
end

function FundNewPop:_onPayBtnClick()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, var_0_3:getSvrIdByType(self._fundType), 0)
end

function FundNewPop:_onOneKeyRewardClick()
	g.core.network.GameNetProxy:send_C2S_FundActivity_LevelAward({
		lv = 0,
		type = 0,
		activity_id = var_0_3:getSvrIdByType(self._fundType)
	})
end

function FundNewPop:_onFundRenderer(arg_12_1, arg_12_2)
	arg_12_2:updateFundNewCell(self._fundLvs[arg_12_1 + 1], self._fundType)
end

function FundNewPop:onFundRecharge(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	g.core.module.ModuleManager:awardSummary(arg_13_4.awards)
	self:updateFundView()
end

function FundNewPop:onFundActivityInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:updateFundView()
end

function FundNewPop:onGetLvUpAward(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	g.core.module.ModuleManager:awardSummary(arg_15_4.awards)
	self:updateFundView()
end

return FundNewPop
