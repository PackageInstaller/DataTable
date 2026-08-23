local BattleBgComp = class("BattleBgComp", require("app.fairyGUI.battleResult.UI_BattleBgComp"))
local var_0_1 = {
	LIN_DONG = 2,
	JIAO_GUO = 1,
	LI_JIN = 4,
	DONG_XI = 3
}
local var_0_2 = {
	[var_0_1.JIAO_GUO] = "ui://base_new/icon_jiaoguo_4",
	[var_0_1.LIN_DONG] = "ui://base_new/icon_lindonggongye_4",
	[var_0_1.DONG_XI] = "ui://base_new/icon_dongxi_4",
	[var_0_1.LI_JIN] = "ui://base_new/icon_lijinlianmeng_4"
}

function BattleBgComp:update(arg_1_1)
	if not arg_1_1.knight_id then
		return
	end

	local var_1_0 = g.core.config.knight_info.get(arg_1_1.knight_id).group

	if var_1_0 and var_0_2[var_1_0] then
		self.m_campIcon:setURL(var_0_2[var_1_0])
	end
end

return BattleBgComp
