local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP
local var_0_3 = g.core.const.ConstMgr.ActivityConst.ROUND_STATE
local var_0_4 = g.core.model.User.activityMonthGachaData
local ActivityGachaComp = class("ActivityGachaComp", require("app.fairyGUI.activity.UI_ActivityGachaComp"))

function ActivityGachaComp:ctor()
	self.m_oneBtn:addClickListener(handler(self, self._onOneDrawClick))
	self.m_tenBtn:addClickListener(handler(self, self._onTenDrawClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskClick))
end

function ActivityGachaComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_ACTIVITYINFO, handler(self, self._onInfoBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_RESET, handler(self, self._onInfoBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_DRAW, handler(self, self.onShowAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_CHOSEAWARD, handler(self, self.onSelRewardItem), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKAWARD, handler(self, self.onRewardTask), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKNOTIFY, handler(self, self.updateRewardTask), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKINFO, handler(self, self.updateRewardTask), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp1
	})
	g.core.network.GameNetProxy:send_C2S_MonthGacha_ActivityInfo({})
	g.core.network.GameNetProxy:send_C2S_MonthGacha_TaskInfo({})
end

function ActivityGachaComp:_onInfoBack(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:updateCompView()
end

function ActivityGachaComp:onSelRewardItem()
	if not self._groupRewards then
		return
	end

	self.m_SComp:updateGachaSRewardComp(self._groupRewards[var_0_2.SSR])
	self.m_AComp:updateGachaARewardComp(self._groupRewards[var_0_2.SR])
end

function ActivityGachaComp:updateComp()
	self:updateCompView()
end

function ActivityGachaComp:onRewardTask(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	self.m_progressTaskComp:updateProgressView()
end

function ActivityGachaComp:updateRewardTask()
	self.m_progressTaskComp:updateProgressView()
end

function ActivityGachaComp:updateCompView()
	if not self._isInited then
		self._groupRewards = {}

		for iter_8_0, iter_8_1 in ipairs((var_0_4:getAllRewardData())) do
			self._groupRewards[iter_8_1.quality] = self._groupRewards[iter_8_1.quality] or {}

			table.insert(self._groupRewards[iter_8_1.quality], iter_8_1)
		end

		table.sort(self._groupRewards[var_0_2.R], function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1.good

			if arg_9_0.good.quality ~= arg_9_1.good.quality then
				return arg_9_0.good.quality > var_9_0.quality
			end

			if arg_9_0.good.value ~= var_9_0.value then
				return arg_9_0.good.value > var_9_0.value
			end

			return false
		end)

		self._isInited = true
	end

	self.m_SComp:updateGachaSRewardComp(self._groupRewards[var_0_2.SSR])
	self.m_AComp:updateGachaARewardComp(self._groupRewards[var_0_2.SR])
	self.m_BComp:updateGroup(self._groupRewards[var_0_2.R], var_0_2.R)
	self.m_progressTaskComp:updateProgressView()
	self:onSelRewardItem()
	self:updateSATips()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_activityGacha_txt",
		remove = true,
		isLoop = false
	})

	if self._groupRewards[var_0_2.SSR][1].lastNum == 0 then
		self.m_sRewardTimesTxt:setText(g.core.lang:get(408118))
	else
		self.m_sRewardTimesTxt:setText(g.core.lang:get(408117, {
			num = var_0_4:getLastRewardSNum()
		}))
	end

	local var_8_0, var_8_1 = var_0_4:getActivityTime()

	self.m_timeTxt:setText(os.date("%Y/%m/%d", g.core.common.ServerTime:getRealTimeZone(var_8_0)) .. " - " .. os.date("%Y/%m/%d", g.core.common.ServerTime:getRealTimeZone(var_8_1)))

	local var_8_2, var_8_3 = var_0_4:getCurRoundAndState()

	if var_8_3 == var_0_3.STATE_FIRST_ROUND and not var_0_4:isBigRewardGet() then
		self.m_nextStageComp:setVisible(false)
	else
		self.m_nextStageComp:setVisible(true)
		self.m_nextStageComp:updateRound()
	end
end

function ActivityGachaComp:updateSATips()
	return
end

function ActivityGachaComp:onShowAward(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityGacha.ActivityGachaRewardAnimPop").new(arg_11_4, handler(self, self._onShowAinmFinish))))
	self:updateCompView()
end

function ActivityGachaComp:_onShowAinmFinish(arg_12_1)
	local var_12_0 = {}

	var_12_0.touchDisappear = true
	var_12_0.hideContinue = false
	var_12_0.blackOpacity = 0.7
	var_12_0.withoutAni = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = false,
		data = arg_12_1.reward_ids,
		func = handler(self, self.onRewardPopFinish),
		showComp = fgui.UIPackage:createObject("activity", "ActivityGachaRewardComp")
	}), var_12_0)
end

function ActivityGachaComp:onRewardPopFinish()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_activityGacha_txt",
		remove = true,
		isLoop = false
	})

	if var_0_4:isNeedShowPop() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			singleButton = true,
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(408106),
			onConfirm = function()
				return
			end
		})))
	end
end

function ActivityGachaComp:_onNewRoundTipClickNotify(arg_15_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_ACTIVITY_GACHA_NEW_ROUND_TIP, arg_15_1)
end

function ActivityGachaComp:playEnterAni()
	self.m_enterTransition:play()
end

function ActivityGachaComp:onDraw(arg_17_1, arg_17_2)
	if not var_0_4:isHasLeftReward() then
		g.core.module.ModuleManager:tip(g.core.lang:get(408104))

		return
	end

	if not var_0_4:isAllRewardAllChoose() then
		g.core.module.ModuleManager:tip(g.core.lang:get(408114))

		return
	end

	if self:isCanDrawThisTimes(arg_17_1) then
		g.core.network.GameNetProxy:send_C2S_MonthGacha_Draw({
			recruit_type = arg_17_2
		})
	else
		g.core.common.GlobalFunc.pushInfoPop({
			type = g.core.common.Goods.TYPE_ITEM,
			value = var_0_4:getNormalDrawItemId()
		})
	end
end

function ActivityGachaComp:_onOneDrawClick()
	local var_18_0, var_18_1 = var_0_4:getCurRoundAndState()

	if var_0_4:isBigRewardGet() then
		if g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_ACTIVITY_GACHA_NEW_ROUND_CHECK_DRAW .. var_0_4:getActId() .. "_" .. var_18_0) then
			self:oneDraw()
		else
			local var_18_2 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(408119),
				onConfirm = handler(self, self.oneDraw),
				onCancel = function()
					return
				end,
				tip = {
					txt = g.core.lang:get(408116)
				},
				onCheck = handler(self, self._saveDrawNotify)
			})))
		end

		return
	end

	self:oneDraw()
end

function ActivityGachaComp:oneDraw()
	self:onDraw(1, 1)
end

function ActivityGachaComp:tenDraw()
	self:onDraw(10, 2)
end

function ActivityGachaComp:_onTenDrawClick()
	local var_22_0, var_22_1 = var_0_4:getCurRoundAndState()

	if var_0_4:isBigRewardGet() then
		if g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_ACTIVITY_GACHA_NEW_ROUND_CHECK_DRAW .. var_0_4:getActId() .. "_" .. var_22_0) then
			self:tenDraw()
		else
			local var_22_2 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(408119),
				onConfirm = handler(self, self.tenDraw),
				onCancel = function()
					return
				end,
				tip = {
					txt = g.core.lang:get(408116)
				},
				onCheck = handler(self, self._saveDrawNotify)
			})))
		end

		return
	end

	self:tenDraw()
end

function ActivityGachaComp:_saveDrawNotify(arg_24_1)
	local var_24_0, var_24_1 = var_0_4:getCurRoundAndState()

	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_ACTIVITY_GACHA_NEW_ROUND_CHECK_DRAW .. var_0_4:getActId() .. "_" .. var_24_0, arg_24_1)
end

function ActivityGachaComp:_onShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
		shopType = var_0_1.SHOP_TYPE.GIFT,
		shopValue = var_0_1.RECHARGE_HOT_VALUE.HOT_GACHA
	})
end

function ActivityGachaComp:isCanDrawThisTimes(arg_26_1)
	if arg_26_1 < 1 then
		return false
	end

	return arg_26_1 <= var_0_4:getAllDrawNums()
end

function ActivityGachaComp:_onTaskClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityGacha.ActivitygachaTaskPop").new()))
end

return ActivityGachaComp
