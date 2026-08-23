local var_0_0 = g.core.const.ConstMgr.WeeklyCompetitionConst
local WeeklyCompetitionBoxComp = class("WeeklyCompetitionBoxComp", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionBoxComp")))

function WeeklyCompetitionBoxComp:ctor()
	self._rewardInfo = nil

	self:addClickListener(handler(self, self._onClick))
end

function WeeklyCompetitionBoxComp:updateBox(arg_2_1, arg_2_2)
	self._rewardInfo = arg_2_1

	self.m_drawStateController:setSelectedIndex(self._rewardInfo.state)
	self:clearAllEffect()

	local var_2_0 = self._rewardInfo.state

	if arg_2_2 and var_2_0 == var_0_0.REWARD_STATE.MATCH then
		var_2_0 = arg_2_2
	end

	if var_2_0 == var_0_0.REWARD_STATE.MATCH then
		self:playIdle()
	end

	self.m_value:setText(self._rewardInfo.cfg.score)
end

function WeeklyCompetitionBoxComp:clearAllEffect()
	self.m_boxRenewEffect:removeAllEffect()
	self.m_box1IdleEffect:removeAllEffect()
	self.m_box2IdleEffect:removeAllEffect()
	self.m_box2OpenEffect:removeAllEffect()
	self.m_boxActivationUpEffect:removeAllEffect()
end

function WeeklyCompetitionBoxComp:_onClick()
	self:dispatchCompEvent("boxClicked", {
		info = self._rewardInfo
	})
end

function WeeklyCompetitionBoxComp:playRenewEffect(arg_5_1, arg_5_2)
	self.m_drawStateController:setSelectedIndex(0)
	self.m_boxRenewEffect:addEffectSpine({
		anim = "renew",
		name = "eff_ui_weeklyCompetition_boxRenew",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, function(arg_6_0, arg_6_1, arg_6_2)
			if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_6_1.type then
				arg_6_0:_onPlayRenewEffectEnd(arg_5_1, arg_5_2)
			end
		end)
	})
end

function WeeklyCompetitionBoxComp:_onPlayRenewEffectEnd(arg_7_1, arg_7_2)
	if arg_7_1 then
		self:playActiveEffect(arg_7_2)
	else
		self:newScheduleOnce(handler(self, function(arg_8_0)
			arg_8_0:dispatchCompEvent("boxReNewEnd")
		end), 0)
	end
end

function WeeklyCompetitionBoxComp:playActiveEffect(arg_9_1)
	if arg_9_1 then
		self.m_boxActivationUpEffect:addEffectSpine({
			anim = "openDown",
			name = "eff_ui_weeklyCompetition_boxRenew",
			remove = true,
			isLoop = false
		})
	end

	self.m_boxActivationUpEffect:addEffectSpine({
		anim = "openUp",
		name = "eff_ui_weeklyCompetition_boxRenew",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._onActiveEffectHandler)
	})
end

function WeeklyCompetitionBoxComp:_onActiveEffectHandler(arg_10_1, arg_10_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_10_1.type then
		self:_onPlayActiveEffectEnd()
	end
end

function WeeklyCompetitionBoxComp:_onPlayActiveEffectEnd()
	self:playIdle()
	self:newScheduleOnce(handler(self, function(arg_12_0)
		arg_12_0:dispatchCompEvent("onProUpEffectEnd")
	end), 0)
end

function WeeklyCompetitionBoxComp:playIdle()
	self.m_box1IdleEffect:addEffectSpine({
		anim = "idle",
		remove = false,
		isLoop = true,
		name = "eff_ui_weeklyCompetition_box" .. self.m_boxLevelController:getSelectedIndex() + 1
	})
end

function WeeklyCompetitionBoxComp:playOpenEffect(arg_14_1)
	self._openEffectParams = arg_14_1

	self.m_box2OpenEffect:addEffectSpine({
		anim = "open",
		name = "eff_ui_weeklyCompetition_box2",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._onOpenEffectHandler)
	})
end

function WeeklyCompetitionBoxComp:_onOpenEffectHandler(arg_15_1, arg_15_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_15_1.type then
		self:newScheduleOnce(handler(self, self._onPlayOpenEffectEnd), 0)
	end
end

function WeeklyCompetitionBoxComp:_onPlayOpenEffectEnd()
	self:dispatchCompEvent("openBoxAwards", self._openEffectParams)
end

return WeeklyCompetitionBoxComp
