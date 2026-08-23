local var_0_0 = require
local var_0_1 = ...
local var_0_2 = string.sub(var_0_1, 1, string.len(var_0_1) - 4)

function load(arg_1_0)
	return var_0_0(var_0_2 .. arg_1_0)
end

load("config")
load("foundation.init")

loadCfg = BATTLE_PLATFORM == CLIENT and function(arg_2_0)
	if arg_2_0 == "core.config.cfg.language_info" then
		return g.core.config.language_info
	end

	local var_2_0 = BATTLE_CONFIG_TYPE.isOs and (BATTLE_CONFIG_TYPE.config[arg_2_0] or arg_2_0) or arg_2_0

	return var_0_0(table.concat({
		"app.",
		var_2_0
	}, ""))
end or function(arg_3_0)
	local var_3_0 = BATTLE_CONFIG_TYPE.isOs and (BATTLE_CONFIG_TYPE.config[arg_3_0] or arg_3_0) or arg_3_0

	return var_0_0(table.concat({
		var_0_2,
		var_3_0
	}, ""))
end

load("core.BattleLog")

if BATTLE_PLATFORM == CLIENT then
	var_0_0("app.view.module.debug.BattleLog.BattleLog")
end
