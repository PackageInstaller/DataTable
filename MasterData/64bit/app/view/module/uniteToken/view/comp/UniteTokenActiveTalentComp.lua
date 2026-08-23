local UniteTokenActiveTalentComp = class("UniteTokenActiveTalentComp", require("app.fairyGUI.uniteToken.UI_UniteTokenActiveTalentComp"))
local var_0_1 = g.core.lang

function UniteTokenActiveTalentComp:ctor()
	return
end

function UniteTokenActiveTalentComp:update(arg_2_1)
	if not arg_2_1.talent then
		return
	end

	local var_2_0 = string.split(arg_2_1.talent.info.description, "+")

	self.m_value:setText(var_0_1:get(202523, {
		name = var_2_0[1],
		value = var_2_0[2]
	}))
	self.m_name:setText(arg_2_1.talent.info.name)
end

return UniteTokenActiveTalentComp
