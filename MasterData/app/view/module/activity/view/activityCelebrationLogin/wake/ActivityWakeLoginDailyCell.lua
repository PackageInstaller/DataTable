local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.activityCelebrationLoginData
local var_0_2 = g.core.common.Path
local ActivityWakeLoginDailyCell = class("ActivityWakeLoginDailyCell", require("app.fairyGUI.activity.UI_ActivityWakeLoginDailyCell"))

function ActivityWakeLoginDailyCell:ctor()
	self._activityId = 0
	self._good = {}

	self:addClickListener(handler(self, self._onClickSelf))
end

function ActivityWakeLoginDailyCell:updateDailyCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._activityId = var_0_1:getActivityIdByGroup(arg_2_1.group)

	local var_2_0 = var_0_1:getSignInDaysByActId(self._activityId)
	local var_2_1 = var_0_1:getLoginDaysByActId(self._activityId)

	self.m_dayTxt:setText(arg_2_1.day)
	self.m_eff:setVisible(false)

	if var_2_0 >= arg_2_1.day then
		self.m_stateController:setSelectedIndex(0)
	elseif var_2_1 < arg_2_1.day then
		self.m_stateController:setSelectedIndex(2)
	elseif var_2_0 < arg_2_1.day and var_2_1 >= arg_2_1.day then
		self.m_stateController:setSelectedIndex(1)
		self.m_eff:setVisible(true)
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_activityWake_singlelight",
			isLoop = true
		})
	end

	self._good = var_0_0:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value,
		size = arg_2_1.reward_size
	})

	self.m_rewardIcon:setURL(var_0_2:getIconByTypeValue(self._good.type, self._good.value, true, false))
	self.m_qualityLoader:setURL(g.core.common.Path:getWakeLoginDailyQualityLine(self._good.quality))
end

function ActivityWakeLoginDailyCell:_onClickSelf()
	if self.m_stateController:getSelectedIndex() == 1 then
		g.core.network.GameNetProxy:send_C2S_CelebrationLogin_SignReward({
			id = var_0_1:getSvrIdByActivityId(self._activityId)
		})
	else
		g.core.common.GlobalFunc.pushInfoPop(self._good)
	end
end

return ActivityWakeLoginDailyCell
