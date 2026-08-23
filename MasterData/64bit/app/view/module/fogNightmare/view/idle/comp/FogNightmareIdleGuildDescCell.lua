local var_0_0 = g.core.config.fog_guild_buff_info
local FogNightmareIdleGuildDescCell = class("FogNightmareIdleGuildDescCell", require("app.fairyGUI.fogNightmare.UI_FogNightmareIdleGuildDescCell"))

function FogNightmareIdleGuildDescCell:updateDescComp(arg_1_1, arg_1_2, arg_1_3)
	self.m_descText:setText(g.core.lang:get(500260, {
		num = arg_1_2
	}))
	self.m_valueText:setText(g.core.lang:get(500261, {
		num = var_0_0.get(arg_1_1, arg_1_2).rate * 0.1
	}))
	self.m_stateController:setSelectedIndex(arg_1_3)
end

return FogNightmareIdleGuildDescCell
