local var_0_0 = {
	LI_JIN = 4,
	DONG_XI = 3,
	LIN_DONG = 2,
	JIAO_GUO = 1
}
local var_0_1 = {
	[var_0_0.JIAO_GUO] = "ui://base_new/icon_jiaoguo_4",
	[var_0_0.LIN_DONG] = "ui://base_new/icon_lindonggongye_4",
	[var_0_0.DONG_XI] = "ui://base_new/icon_dongxi_4",
	[var_0_0.LI_JIN] = "ui://base_new/icon_lijinlianmeng_4"
}
local BattleResultPvpBgComp = class("BattleResultPvpBgComp", require("app.fairyGUI.battleResult.UI_BattleResultPvpBgComp"))

function BattleResultPvpBgComp:update(arg_1_1)
	if arg_1_1.isWin and arg_1_1.knight_id then
		self.m_campIcon:setURL(var_0_1[g.core.config.knight_info.get(arg_1_1.knight_id).group])
	else
		self:_showFailureState(arg_1_1)
	end
end

function BattleResultPvpBgComp:_showFailureState(arg_2_1)
	if self.m_failEnterTransition then
		self.m_failEnterTransition:setHook("failDot", handler(self, self._onFailDotBegin))
	end
end

function BattleResultPvpBgComp:_onFailDotBegin()
	self.m_failDot:addEffectSpine({
		isLoop = false,
		name = "eff_ui_dungeon_failDot",
		remove = true
	})
end

return BattleResultPvpBgComp
