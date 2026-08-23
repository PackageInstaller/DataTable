local var_0_0 = g.core.config.guild_alliance_trial_reward_info
local var_0_1 = g.core.model.User.allianceTrialData
local AllianceTrialBoxCell = class("AllianceTrialBoxCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialBoxCell"))

function AllianceTrialBoxCell:ctor()
	self._level = 0
	self._index = 0

	self.m_clickLoader:addClickListener(handler(self, self._onClickLoader))
end

function AllianceTrialBoxCell:_onClickLoader()
	if not var_0_1:isLevelFinish(self._level) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430404))

		return
	end

	if var_0_1:isBoxAwarded(self._level) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430408))

		return
	end

	if var_0_1:getLastWeeklyOpenCount() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430413))

		return
	end

	if self._level > 0 and self._index > 0 then
		g.core.network.GameNetProxy:send_C2S_AllianceTrial_BoxAward({
			level = self._level,
			index = self._index
		})
	end
end

function AllianceTrialBoxCell:updateBoxCell(arg_3_1, arg_3_2)
	self._level = arg_3_1
	self._index = arg_3_2

	local var_3_0 = var_0_1:getBoxAwardData(arg_3_1, arg_3_2)

	if var_3_0 then
		self.m_isOpenController:setSelectedIndex(1)
		self.m_userName:setText(var_3_0.user_name)
		self.m_isSelfController:setSelectedIndex(g.core.model.User:getId() == var_3_0.user_id and 1 or 0)

		local var_3_1 = var_0_0.get(var_3_0.reward_id)

		self.m_isBigController:setSelectedIndex(var_3_1.grand_prize == 1 and 1 or 0)
		self.m_itemNum:setText(var_3_1.size)
		self.m_icon:setURL(g.core.common.Path:getIconByTypeValue(var_3_1.type, var_3_1.value))
	else
		self.m_isBigController:setSelectedIndex(0)
		self.m_isOpenController:setSelectedIndex(0)
	end
end

function AllianceTrialBoxCell:showEffect(arg_4_1, arg_4_2)
	if arg_4_1 == self._index then
		if self.m_isBigController:getSelectedIndex() == 1 then
			self.m_effBig:addEffectSpine({
				remove = true,
				anim = "play",
				name = "eff_ui_allianceTrial_bigBox",
				isLoop = false,
				eventHandler = arg_4_2
			})
		else
			self.m_eff:addEffectSpine({
				remove = true,
				anim = "play",
				name = "eff_ui_allianceTrial_box",
				isLoop = false,
				eventHandler = arg_4_2
			})
		end

		return true
	end

	return false
end

return AllianceTrialBoxCell
