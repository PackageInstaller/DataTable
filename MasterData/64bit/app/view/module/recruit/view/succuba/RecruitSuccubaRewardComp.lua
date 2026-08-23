local RecruitSuccubaRewardComp = class("RecruitSuccubaRewardComp", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaRewardComp"))

function RecruitSuccubaRewardComp:updateRewardComp(arg_1_1)
	self._param = arg_1_1

	self.m_nameTxt:setText(arg_1_1.name)
	self.m_qualityController:setSelectedIndex(arg_1_1.quality - 1)
	self.m_itemIcon:updateSuccubaReward(arg_1_1)
	self.m_sizeText:setText("x" .. arg_1_1.size)
end

function RecruitSuccubaRewardComp:playEnterTran()
	self.m_enterTransition:play()

	local var_2_0

	if self._param then
		var_2_0 = self._param.quality + 1 or 2
	end

	self.m_effUp:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_succubaRecruit_enter",
		anim = "play_" .. var_2_0
	})
	self.m_effIdle:removeAllEffect()
	self.m_effIdle:addEffectSpine({
		isLoop = true,
		name = "eff_ui_succubaRecruit_idle",
		anim = "play_" .. var_2_0
	})
end

return RecruitSuccubaRewardComp
