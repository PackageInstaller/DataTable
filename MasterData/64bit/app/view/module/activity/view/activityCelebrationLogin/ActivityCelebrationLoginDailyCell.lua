local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.activityCelebrationLoginData
local var_0_2 = g.core.common.Path
local ActivityCelebrationLoginDailyCell = class("ActivityCelebrationLoginDailyCell", require("app.fairyGUI.activity.UI_ActivityCelebrationLoginDailyCell"))

function ActivityCelebrationLoginDailyCell:ctor()
	self._dailyReward = nil
	self._canRecv = false

	self.m_rewardIcon:addClickListener(handler(self, self._onClickRecv))
end

function ActivityCelebrationLoginDailyCell:updateDailyCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = var_0_1:getActivityIdByGroup(arg_2_1.group)
	local var_2_1 = var_0_1:getSignInDaysByActId(var_2_0)

	self._dailyReward = arg_2_1

	self.m_dayTxt:setText(arg_2_1.day)

	self._canRecv = var_0_1:isDailyRewardCanRecv(arg_2_1.day)

	self.m_isRecvController:setSelectedIndex(var_2_1 >= arg_2_1.day and 1 or 0)

	local var_2_2 = var_0_0:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value,
		size = arg_2_1.reward_size
	})

	self.m_rewardIcon:updateIcon(var_2_2)
	self.m_bgLoader:setURL(var_0_2:getCelebrationLoginImage("pic_hd_znqqd_jianglidi", var_2_0))
	self.m_rewardIcon:setIconQualityBgVisible(false)
	self.m_qualityLoader:setURL(g.core.common.Path:getCelebrationLoginDailyQualityLine(var_2_2.quality))
	self.m_numTxt:setText("x" .. var_2_2.size)
end

return ActivityCelebrationLoginDailyCell
