local AncientsAgainstLineComp = class("AncientsAgainstLineComp", require("app.fairyGUI.ancients.UI_AncientsAgainstLineComp"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateLine(arg_2_1, arg_2_2)
	local var_2_0 = not not arg_2_2

	self.m_stateController:setSelectedIndex(arg_2_1)

	local var_2_1 = self.m_typeController:getSelectedIndex()

	self.m_effDi:removeAllEffect()

	if var_2_0 and arg_2_1 == 2 and var_2_1 ~= 3 then
		self.m_effDi:addEffectSpine({
			name = "eff_ui_ancients_progressline",
			remove = false,
			isLoop = true,
			anim = var_2_1 == 0 and "play_2" or var_2_1 == 1 and "play_1" or "play_3"
		})
	end
end

return var_0_0
