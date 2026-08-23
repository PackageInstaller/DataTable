local var_0_0 = g.core.config.celebration_login_gift_info
local var_0_2 = g.core.model.User.activityCelebrationLoginData
local ActivityWakeLoginCumulateCell = class("ActivityWakeLoginCumulateCell", require("app.fairyGUI.activity.UI_ActivityWakeLoginCumulateCell"))

function ActivityWakeLoginCumulateCell:ctor()
	self._effCard = nil
	self._effDot = nil
	self._cumulateReward = nil
	self._canRecv = false
	self._reward = nil
	self._good = nil

	self.m_recvBtn:addClickListener(handler(self, self._onClickReward))
end

function ActivityWakeLoginCumulateCell:updateCumulateCell(arg_2_1)
	local var_2_0 = var_0_2:getSignInDaysByActId((var_0_2:getActivityIdByGroup(arg_2_1.cfg.group)))

	self._cumulateReward = arg_2_1
	self._reward = arg_2_1.reward

	self.m_effCard:setVisible(false)
	self.m_effDot:setVisible(false)

	self._canRecv = false

	if self._reward then
		self.m_isRecvController:setSelectedIndex(1)
		self.m_isSatisfyController:setSelectedIndex(1)
	else
		self.m_isRecvController:setSelectedIndex(0)

		if var_2_0 >= arg_2_1.cfg.day then
			self._canRecv = true

			self.m_isSatisfyController:setSelectedIndex(1)

			self._effCard = self._effCard or self.m_effCard:addEffectSpine({
				anim = "play_0",
				name = "eff_ui_common_iconget",
				scale = 0.75,
				isLoop = true
			})
			self._effDot = self._effDot or self.m_effDot:addEffectSpine({
				anim = "dot",
				name = "eff_ui_activityWake_totalglow",
				isLoop = true
			})

			self.m_effCard:setVisible(true)
			self.m_effDot:setVisible(true)
		else
			self.m_isSatisfyController:setSelectedIndex(0)
		end
	end

	self.m_dayTxt:setText(arg_2_1.cfg.day)

	local var_2_1 = arg_2_1.cfg.day - (arg_2_1.cfg.prev_id > 0 and var_0_0.get(arg_2_1.cfg.prev_id).day or 0)
	local var_2_2 = 0

	var_2_2 = var_2_0 >= arg_2_1.cfg.day and var_2_1 or 5 - (arg_2_1.cfg.day - var_2_0)

	self.m_progBar:setPercent({
		cur = var_2_2,
		max = var_2_1
	})

	self._good = g.core.common.Drops:getGoodsArray(arg_2_1.cfg.pack)[1]

	self.m_icon:updateIcon(self._good)
end

function ActivityWakeLoginCumulateCell:_onClickReward()
	if not self._cumulateReward then
		return
	end

	local var_3_0 = self._cumulateReward.cfg

	if self._canRecv then
		g.core.network.GameNetProxy:send_C2S_CelebrationLogin_DrawGift({
			id = var_0_2:getSvrIdByActivityId((var_0_2:getActivityIdByGroup(self._cumulateReward.cfg.group))),
			day = var_3_0.day
		})
	else
		g.core.common.GlobalFunc.pushInfoPop(self._good)
	end
end

return ActivityWakeLoginCumulateCell
