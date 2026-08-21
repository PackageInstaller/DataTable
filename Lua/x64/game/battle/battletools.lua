return {
	GetBattleStatisticsData = function()
		local var_1_0 = LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()
		local var_1_1 = {
			{
				damage = int64.zero,
				hurt = int64.zero,
				cure = int64.zero
			},
			{
				damage = int64.zero,
				hurt = int64.zero,
				cure = int64.zero
			},
			{
				damage = int64.zero,
				hurt = int64.zero,
				cure = int64.zero
			}
		}

		for iter_1_0 = 0, var_1_0.hurtInfos.Count - 1 do
			local var_1_2 = var_1_0.hurtInfos[iter_1_0]

			if var_1_2.agentOrder ~= 0 and var_1_2.damageValue < int64.zero then
				var_1_1[var_1_2.agentOrder].hurt = var_1_1[var_1_2.agentOrder].hurt + -1 * var_1_2.damageValue
			end

			if var_1_2.casterOrder ~= 0 then
				if var_1_2.damageValue < int64.zero then
					var_1_1[var_1_2.casterOrder].damage = var_1_1[var_1_2.casterOrder].damage + -1 * var_1_2.damageValue
				else
					var_1_1[var_1_2.casterOrder].cure = var_1_1[var_1_2.casterOrder].cure + var_1_2.damageValue
				end
			end
		end

		local var_1_3 = {
			damage = int64.zero,
			hurt = int64.zero,
			cure = int64.zero
		}
		local var_1_4 = {
			damage = int64.zero,
			hurt = int64.zero,
			cure = int64.zero
		}

		for iter_1_1 = 1, 3 do
			var_1_3.damage = var_1_3.damage + var_1_1[iter_1_1].damage
			var_1_3.hurt = var_1_3.hurt + var_1_1[iter_1_1].hurt
			var_1_3.cure = var_1_3.cure + var_1_1[iter_1_1].cure

			if var_1_1[iter_1_1].damage > var_1_4.damage then
				var_1_4.damage = var_1_1[iter_1_1].damage
			end

			if var_1_1[iter_1_1].hurt > var_1_4.hurt then
				var_1_4.hurt = var_1_1[iter_1_1].hurt
			end

			if var_1_1[iter_1_1].cure > var_1_4.cure then
				var_1_4.cure = var_1_1[iter_1_1].cure
			end
		end

		return var_1_1, var_1_3, var_1_4
	end,
	FixBattleAttributeListAndWeaponModule = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = LuaExchangeHelper.GetBattleModuleBuffEnum()
		local var_2_1 = SkinCfg[arg_2_2].hero
		local var_2_2 = HeroTools.GetModuleEffectByHeroAndLevel(var_2_1, arg_2_3)

		for iter_2_0, iter_2_1 in pairs(var_2_2) do
			table.insert(arg_2_0, var_2_0 + iter_2_0 - 1)
			table.insert(arg_2_1, iter_2_1)
		end

		return arg_2_0, arg_2_1
	end,
	GetAffixPlayerTargetByPos = function(arg_3_0)
		if arg_3_0 == 1 then
			return BattleConst.ENEMY_TYPE.PLAYER_1
		elseif arg_3_0 == 2 then
			return BattleConst.ENEMY_TYPE.PLAYER_2
		elseif arg_3_0 == 3 then
			return BattleConst.ENEMY_TYPE.PLAYER_3
		else
			error("GetAffixPlayerTargetByPos error pos")
		end
	end,
	GetMaxRaceData = function(arg_4_0)
		local var_4_0 = {}
		local var_4_1 = 0
		local var_4_2 = false

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1 ~= 0 then
				local var_4_3 = HeroCfg[iter_4_1].race

				var_4_0[var_4_3] = (var_4_0[var_4_3] or 0) + 1

				if var_4_0[var_4_3] == 2 then
					var_4_1 = var_4_3
				elseif var_4_0[var_4_3] == 3 then
					var_4_2 = true
				end
			end
		end

		return var_4_1, var_4_0[var_4_1] or 1, var_4_2
	end
}
