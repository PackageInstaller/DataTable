local var_0_0 = {}

pg.skillCfg = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		if var_0_0[arg_1_1] then
			return nil
		else
			var_0_0[arg_1_1] = true

			if LUA_CONFIG_EXTRA then
				table.insert({
					"GameCfg.skill." .. arg_1_1
				}, "GameCfg.battle_lua.skill_extra." .. arg_1_1)
			end

			for iter_1_0, iter_1_1 in ipairs({
				"GameCfg.skill." .. arg_1_1
			}) do
				if pcall(function()
					arg_1_0[arg_1_1] = require(iter_1_1)

					return
				end) then
					return arg_1_0[arg_1_1]
				end
			end

			if IsUnityEditor then
				warning("找不到技能配置: " .. "GameCfg.skill." .. arg_1_1)
			end

			return nil
		end

		return
	end
})

ys.Battle.BattleDataFunction.ConvertSkillTemplate()

return
