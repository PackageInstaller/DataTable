local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_1 = g.core.const.ConstMgr.ActivityConst.ROUND_STATE
local var_0_2 = g.core.model.User.activityMonthGachaData
local ActivityGachaNextRoundComp = class("ActivityGachaNextRoundComp", require("app.fairyGUI.activity.UI_ActivityGachaNextRoundComp"))

function ActivityGachaNextRoundComp:ctor()
	self:addClickListener(handler(self, self._onClickNextRound))
end

function ActivityGachaNextRoundComp:updateRound()
	local var_2_0, var_2_1 = var_0_2:getCurRoundAndState()

	self.m_eff:removeAllEffect()

	if var_2_1 == var_0_1.STATE_FIRST_ROUND then
		self.m_roundStateController:setSelectedIndex(0)
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_activityGacha_nextBtn",
			isLoop = true
		})
	elseif var_2_1 == var_0_1.STATE_IN_ROUND then
		if var_0_2:isBigRewardGet() then
			self.m_roundStateController:setSelectedIndex(0)
			self.m_eff:addEffectSpine({
				anim = "play",
				name = "eff_ui_activityGacha_nextBtn",
				isLoop = true
			})
		else
			self.m_roundStateController:setSelectedIndex(1)
		end
	else
		self.m_roundStateController:setSelectedIndex(2)
	end
end

function ActivityGachaNextRoundComp:_onClickNextRound()
	local var_3_0, var_3_1 = var_0_2:getCurRoundAndState()

	if var_0_2:isBigRewardGet() and var_3_1 ~= var_0_1.STATE_END_ROUND then
		if g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_ACTIVITY_GACHA_NEW_ROUND_START) then
			self:onClickNewRound()
		else
			local var_3_2 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(408107),
				onConfirm = handler(self, self.onClickNewRound),
				onCancel = function()
					return
				end,
				tip = {
					txt = g.core.lang:get(408110)
				},
				onCheck = handler(self, self._onNewRoundTipClickNotify)
			})))
		end
	elseif var_3_1 == var_0_1.STATE_END_ROUND then
		g.core.module.ModuleManager:tip(g.core.lang:get(408108))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408109))
	end
end

function ActivityGachaNextRoundComp:onClickNewRound()
	g.core.network.GameNetProxy:send_C2S_MonthGacha_Reset({})
end

function ActivityGachaNextRoundComp:_onNewRoundTipClickNotify(arg_6_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_ACTIVITY_GACHA_NEW_ROUND_START, arg_6_1)
end

return ActivityGachaNextRoundComp
