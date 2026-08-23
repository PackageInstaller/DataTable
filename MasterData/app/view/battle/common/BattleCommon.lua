local BattleConst = require("app.view.battle.const.BattleConst")

return {
	isCanOpeExitBattle = function(arg_1_0)
		if not g.core.battle.BattleProxy:isInBattle() then
			return false
		end

		local var_1_0 = g.core.battle.BattleProxy:getType()

		if BattleConst.TYPE_BIOTEAM == var_1_0 or BattleConst.TYPE_MINE == var_1_0 or BattleConst.TYPE_GUILD_BOSS == var_1_0 or BattleConst.TYPE_GUILD_BOSS_ROB == var_1_0 or BattleConst.TYPE_MYSTERY_BOSS == var_1_0 or BattleConst.TYPE_STORM == var_1_0 or BattleConst.TYPE_STORM_CITY == var_1_0 or BattleConst.TYPE_GUILDFIGHT_PVP == var_1_0 or BattleConst.TYPE_GUILDWAR == var_1_0 or BattleConst.TYPE_GVE_BASE == var_1_0 or BattleConst.TYPE_GVE_BOSS == var_1_0 or BattleConst.TYPE_RICHMAN_ROB == var_1_0 or BattleConst.TYPE_TEAM_BATTLE == var_1_0 then
			return false
		end

		return true
	end
}
