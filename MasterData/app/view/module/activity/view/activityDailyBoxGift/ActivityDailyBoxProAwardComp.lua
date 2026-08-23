local var_0_0 = g.core.model.User.activityDailyBoxData
local var_0_1 = g.core.config.daily_box_reward_info
local ActivityDailyBoxProAwardComp = class("ActivityDailyBoxProAwardComp", require("app.fairyGUI.activity.UI_ActivityDailyBoxProAwardComp"))

function ActivityDailyBoxProAwardComp:ctor()
	self._curAwardId = 0
	self._rewardData = {}

	self:addClickListener(handler(self, self._onClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function ActivityDailyBoxProAwardComp:updateProgresAward()
	self._curAwardId = var_0_0:getCurProgressDailyAwardId()
	self._rewardData = var_0_0:getDailyBoxTurnAwardData(self._curAwardId)
	self._state = self:_getAwardsState()

	self.m_awardList:setNumItems(#self._rewardData)
	self.m_stateController:setSelectedIndex(self._state == 2 and 1 or 0)

	local var_2_0 = var_0_0:getPreDailyAwardScore()
	local var_2_1 = var_0_1.get(self._curAwardId).score
	local var_2_2 = var_0_0:getCurDailyBoxAwardScore()

	self.m_progressBar:setPercent({
		cur = var_2_2 - var_2_0,
		max = var_2_1 - var_2_0
	})
	self.m_progressTxt:setText(var_2_2 .. "/" .. var_2_1)
end

function ActivityDailyBoxProAwardComp:_onAwardItemRender(arg_3_1, arg_3_2)
	if self._state == 2 then
		local var_3_0 = arg_3_2:getSize()

		arg_3_2:removeAllEffect()
		arg_3_2:addEffectSpine({
			scale = 0.54,
			name = "eff_ui_common_iconget",
			isLoop = true,
			anim = "play_0",
			x = var_3_0.width / 2 - 2,
			y = var_3_0.height / 2 + 5
		})
	else
		arg_3_2:removeAllEffect()
	end

	arg_3_2:updateIcon(self._rewardData[arg_3_1 + 1])
end

function ActivityDailyBoxProAwardComp:_getAwardsState()
	local var_4_1 = var_0_0:getPreDailyAwardScore()

	return var_0_1.get(self._curAwardId).score - var_4_1 <= var_0_0:getCurDailyBoxAwardScore() - var_4_1 and (var_0_0:isGetDailyBoxTurnAward(self._curAwardId) and 3 or 2) or 1
end

function ActivityDailyBoxProAwardComp:_onClick()
	if self._state == 2 then
		g.core.network.GameNetProxy:send_C2S_Recharge_DailyBoxTurnAward({
			id = var_0_0:getDailyBoxTurnId(),
			reward_id = self._curAwardId
		})
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityDailyBoxGift.ActivityDailyProgPop").new()))
	end
end

return ActivityDailyBoxProAwardComp
