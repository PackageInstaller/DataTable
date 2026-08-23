local var_0_0 = g.core.model.User
local var_0_1 = g.core.config.monster_team_switch_info
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_MonsterSwitch_Flush = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = arg_1_2.monster_switch.version

		local function var_1_1(arg_2_0)
			local var_2_0 = var_1_0

			if var_1_0 == 1 then
				return 1
			elseif var_2_0 > 1 then
				while not var_0_1.hasKey("id_" .. var_2_0) or var_0_1.get(arg_2_0)["id_" .. var_2_0] == 0 do
					var_2_0 = var_2_0 - 1

					if var_2_0 == 1 then
						return 1
					end
				end

				return var_2_0
			end
		end

		local function var_1_2(arg_3_0)
			local var_3_0 = var_0_1.get(arg_3_0)

			if var_1_0 == 1 then
				return 1
			elseif var_1_0 > 1 then
				local var_3_1 = 1

				for iter_3_0 = 2, var_1_0 do
					if var_0_1.hasKey("id_" .. iter_3_0) and var_3_0["id_" .. iter_3_0] ~= 0 then
						var_3_1 = var_3_1 + 1
					end
				end

				return var_3_1
			end
		end

		var_0_0.dungeonData:setDisplayVersion(var_1_2(200101))
		var_0_0.wushData:setDisplayVersion(var_1_2(70001))
		var_0_0.wushTowerData:setDisplayVersion(var_1_2(400011))
		var_0_0.rebelData:setMonsterVersion(var_1_1(2001))
		var_0_0.rebelData:setDisplayVersion(var_1_2(2001))
		var_0_0.towerData:setMonsterVersion(var_1_1(10000001))
		var_0_0.towerData:setDisplayVersion(var_1_2(10000001))
		var_0_0.towerHardData:setMonsterVersion(var_1_1(40016001))
		var_0_0.towerHardData:setDisplayVersion(var_1_2(40016001))
		var_0_0.mysteryData:setMonsterVersion(var_1_1(700001))
		var_0_0.guildDungeonData:setDisplayVersion(var_1_2(80001))
		var_0_0.bioData:setDisplayVersion(var_1_2(100001))
	end
}
