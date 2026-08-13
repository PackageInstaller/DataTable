local var_0_0 = {}

pg = var_0_10001
setmetatable = var_0_10002
var_0_10001.skillCfg = var_0_10002({}, {
	__index = function(arg_1_0, arg_1_1)
		if var_0_0[arg_1_1] then
			return nil
		else
			var_0_0[arg_1_1] = true

			local var_1_0 = {
				"GameCfg.skill." .. arg_1_1
			}

			LUA_CONFIG_EXTRA = var_3

			if var_3 then
				table = var_3

				var_3.insert(var_1_0, "GameCfg.battle_lua.skill_extra." .. arg_1_1)
			end

			ipairs = var_3

			for iter_1_0, iter_1_1 in var_3(var_1_0) do
				pcall = var_1_10008

				if var_1_10008(function()
					local var_2_0 = arg_1_0
					local var_2_1 = arg_1_1

					require = var_2_10002
					var_2_0[var_2_1] = var_2_10002(iter_1_1)

					return
				end) then
					return arg_1_0[arg_1_1]
				end
			end

			IsUnityEditor = var_3

			if var_3 then
				warning = var_3

				var_3("找不到技能配置: " .. "GameCfg.skill." .. arg_1_1)
			end

			return nil
		end

		return
	end
})
ys = var_0_10001

var_0_10001.Battle.BattleDataFunction.ConvertSkillTemplate()

return
