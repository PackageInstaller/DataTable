local var_0_0 = {}

pg.buffCfg = setmetatable({}, {
	__index = function(self, arg_1_1)
		if var_0_0[arg_1_1] then
			return true
		else
			var_0_0[arg_1_1] = true

			local var_1_0 = {
				"GameCfg.buff." .. arg_1_1
			}

			if LUA_CONFIG_EXTRA then
				table.insert(var_1_0, "GameCfg.battle_lua.buff_extra." .. arg_1_1)
			end

			for iter_1_0, iter_1_1 in ipairs(var_1_0) do
				if pcall(function()
					self[arg_1_1] = require(iter_1_1)

					return
				end) then
					return self[arg_1_1]
				end
			end

			if IsUnityEditor then
				warning("找不到技能配置: " .. "GameCfg.buff." .. arg_1_1)
			end

			return nil
		end

		return
	end
})

ys.Battle.BattleDataFunction.ConvertBuffTemplate()

return
