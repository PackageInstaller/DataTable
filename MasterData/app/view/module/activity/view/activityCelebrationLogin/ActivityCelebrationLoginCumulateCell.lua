local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.model.User.activityCelebrationLoginData
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.common.Path
local ActivityCelebrationLoginCumulateCell = class("ActivityCelebrationLoginCumulateCell", require("app.fairyGUI.activity.UI_ActivityCelebrationLoginCumulateCell"))

function ActivityCelebrationLoginCumulateCell:ctor()
	self._cumulateReward = nil
	self._canRecv = false
	self._effCanRecv = nil
	self._reward = nil

	self.m_recvBtn:addClickListener(handler(self, self._onClickReward))
end

function ActivityCelebrationLoginCumulateCell:updateCumulateCell(arg_2_1)
	local var_2_0 = var_0_2:getActivityIdByGroup(arg_2_1.cfg.group)
	local var_2_1 = var_0_2:getSignInDaysByActId(var_2_0)

	self._cumulateReward = arg_2_1
	self._reward = arg_2_1.reward

	self.m_isSpecialController:setSelectedIndex(arg_2_1.cfg.mark == 1 and 1 or 0)
	self.m_eff:setVisible(false)

	self._canRecv = false

	if self._reward then
		self.m_isRecvController:setSelectedIndex(1)
		self.m_isSatisfyController:setSelectedIndex(1)

		local var_2_2 = self.m_rewardIcon:getChild("knightPic")

		if self._reward.type ~= var_0_3.TYPE_SUCCUBA then
			var_2_2:setURL(var_0_4:getKnightBookPicRes(var_0_1.get(self._reward.value).painted_id))
		else
			var_2_2:setURL((var_0_4:getKnightBookPicRes(self._reward.value)))
		end
	else
		self.m_isRecvController:setSelectedIndex(0)

		if var_2_1 >= arg_2_1.cfg.day then
			self._canRecv = true

			self.m_isSatisfyController:setSelectedIndex(1)

			self._effCanRecv = self._effCanRecv or self.m_eff:addEffectSpine({
				name = "eff_ui_activity_cele_get",
				isLoop = true,
				anim = "play" .. math.min(1, arg_2_1.cfg.mark) .. "_4"
			})

			self.m_eff:setVisible(true)
		else
			self.m_isSatisfyController:setSelectedIndex(0)
		end
	end

	self.m_dayTxt:setText(arg_2_1.cfg.day)
	self.m_progBar:updateProgress(arg_2_1.cfg, var_2_1)

	local var_2_3 = arg_2_1.cfg.next_id == 0

	self.m_lastSquare:setVisible(arg_2_1.cfg.next_id == 0)
	self.m_otherSquare:setVisible(not var_2_3)
	self.m_cardBg:setURL(var_0_4:getCelebrationLoginImage(arg_2_1.cfg.bag_pic, var_2_0))
	self.m_tagPic:setURL(var_0_4:getCelebrationLoginImage(arg_2_1.cfg.mark_bg, var_2_0))
	self.m_descTxt:setText(arg_2_1.cfg.marl_des)
end

function ActivityCelebrationLoginCumulateCell:_onClickReward()
	if not self._cumulateReward then
		return
	end

	local var_3_0 = self._cumulateReward.cfg
	local var_3_1 = var_0_2:getActivityIdByGroup(self._cumulateReward.cfg.group)

	if self._canRecv then
		g.core.network.GameNetProxy:send_C2S_CelebrationLogin_DrawGift({
			id = var_0_2:getSvrIdByActivityId(var_3_1),
			day = var_3_0.day
		})
	else
		local var_3_2 = var_3_0.day - var_0_2:getSignInDaysByActId(var_3_1)

		if var_3_2 > 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(427501, {
				day = var_3_2
			}))
		else
			g.core.common.GlobalFunc.pushInfoPop((g.core.common.Goods:convert(self._reward)))
		end
	end
end

return ActivityCelebrationLoginCumulateCell
