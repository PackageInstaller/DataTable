local var_0_0 = {
	GetTotalAddAttribute = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			if iter_1_1.astrolabe_id ~= 0 then
				for iter_1_2, iter_1_3 in ipairs(HeroAstrolabeCfg[iter_1_1.astrolabe_id].ability) do
					var_1_0[iter_1_3[1]] = var_1_0[iter_1_3[1]] == nil and iter_1_3[2] or var_1_0[iter_1_3[1]] + iter_1_3[2]
				end
			end
		end

		return var_1_0
	end,
	GetTotalEffect = function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			table.insert(var_2_0, iter_2_1)
		end

		return var_2_0
	end,
	GetAcitveEffect = function(arg_3_0, arg_3_1)
		if arg_3_1 == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1 ~= 0 then
				if var_3_0[HeroAstrolabeCfg[iter_3_1].hero_astrolabe_suit_id] == nil then
					var_3_0[HeroAstrolabeCfg[iter_3_1].hero_astrolabe_suit_id] = {
						num = 1,
						id = HeroAstrolabeCfg[iter_3_1].hero_astrolabe_suit_id
					}
				else
					var_3_0[HeroAstrolabeCfg[iter_3_1].hero_astrolabe_suit_id].num = var_3_0[HeroAstrolabeCfg[iter_3_1].hero_astrolabe_suit_id].num + 1
				end
			end
		end

		local var_3_1 = {}

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			table.insert(var_3_1, iter_3_3)
		end

		return var_3_1
	end
}

function var_0_0.GetLastIsUnlock(arg_4_0, arg_4_1)
	if HeroAstrolabeCfg[arg_4_0].pre_astrolabe_id == 0 then
		return true
	end

	if HeroAstrolabeCfg[HeroAstrolabeCfg[arg_4_0].pre_astrolabe_id] then
		return var_0_0.GetIsUnlock(HeroData:GetHeroData(arg_4_1).unlocked_astrolabe, HeroAstrolabeCfg[arg_4_0].pre_astrolabe_id)
	end

	return false
end

function var_0_0.GetLastIsEquiped(arg_5_0, arg_5_1)
	if HeroAstrolabeCfg[arg_5_0].pre_astrolabe_id == 0 then
		return true
	end

	if HeroAstrolabeCfg[HeroAstrolabeCfg[arg_5_0].pre_astrolabe_id] then
		return var_0_0.GetIsEquiped(HeroData:GetHeroData(arg_5_1).using_astrolabe, HeroAstrolabeCfg[arg_5_0].pre_astrolabe_id)
	end

	return false
end

function var_0_0.GetNextIsEquiped(arg_6_0, arg_6_1)
	local var_6_0 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_6_0] or {}

	if HeroAstrolabeCfg[arg_6_0].pos == 3 then
		return false
	end

	local var_6_1 = HeroData:GetHeroData(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if not HeroAstrolabeCfg[iter_6_1] then
			return false
		else
			return var_0_0.GetIsEquiped(HeroData:GetHeroData(arg_6_1).using_astrolabe, iter_6_1)
		end
	end

	return false
end

function var_0_0.GetIsUnlock(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0 or {}) do
		if iter_7_1 == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsEquiped(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0) do
		if iter_8_1 == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsHaveCanUnlock(arg_9_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
		return false
	end

	local var_9_0 = HeroData:GetHeroData(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(HeroCfg[var_9_0.id].astrolabe) do
		for iter_9_2, iter_9_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_9_1]) do
			local var_9_1 = var_0_0.GetIsUnlock(var_9_0.unlocked_astrolabe, iter_9_3)

			if HeroTools.IsSpHero(arg_9_0) then
				local var_9_2 = var_0_0.GetSpAstrolabeNodeCanEquiped(iter_9_3, arg_9_0)

				if var_9_2 then
					return var_9_2
				end
			elseif not var_9_1 and var_0_0.GetIsCanUnlock(iter_9_3, arg_9_0) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetIsCanUnlock(arg_10_0, arg_10_1)
	if not HeroTools.IsSpHero(arg_10_1) and var_0_0.GetIsUnlock(HeroData:GetHeroData(arg_10_1).unlocked_astrolabe, arg_10_0) then
		return false
	end

	if HeroAstrolabeCfg[arg_10_0].unlock[1] and ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < HeroAstrolabeCfg[arg_10_0].unlock[1][2] then
		return false
	end

	if not var_0_0.GetLastIsUnlock(arg_10_0, arg_10_1) then
		return false
	end

	return IsConditionAchieved(HeroAstrolabeCfg[arg_10_0].unlock_condition, {
		heroId = arg_10_1
	})
end

function var_0_0.GetAstrolabeModuleDes(arg_11_0, arg_11_1)
	local var_11_0 = getAstrolabeID(arg_11_0, arg_11_1)
	local var_11_1

	for iter_11_0, iter_11_1 in pairs(AstrolabeEffectCfg[var_11_0].equip_orange_desc) do
		if iter_11_1[1] == arg_11_1 and iter_11_1[3] == arg_11_0 then
			var_11_1 = iter_11_1[2]
		end
	end

	return string.format(GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_3"), GetI18NText(HeroAstrolabeCfg[var_11_0].suit_name), GetI18NText(HeroAstrolabeCfg[var_11_0].name), (GetCfgDescription(var_11_1, 1)))
end

function var_0_0.GetAstrolabePrafabName(arg_12_0)
	local var_12_0 = 1

	if HeroCfg[arg_12_0] then
		var_12_0 = HeroCfg[arg_12_0].race
	end

	if not HeroTools.IsSpHero(arg_12_0) then
		return string.format("TX_GodHood_0%s", var_12_0)
	else
		return string.format("TX_GodHood_SP_0%s", var_12_0)
	end
end

function var_0_0:GetHeroAstrolabeS(arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(HeroCfg[self.id].astrolabe) do
		local var_13_1 = {
			suitId = iter_13_1,
			astrolabe = {}
		}

		for iter_13_2, iter_13_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_13_1]) do
			local var_13_2 = false
			local var_13_3 = false

			if HeroTools.IsSpHero(self.id) then
				var_13_2 = AstrolabeTools.GetIsUnlock(iter_13_3, self.id)
			else
				var_13_2 = AstrolabeTools.GetIsUnlock(self.unlocked_astrolabe, iter_13_3)
				var_13_3 = AstrolabeTools.GetIsCanUnlock(iter_13_3, self.id) and self.unlock == 1
			end

			local var_13_4 = {
				id = iter_13_3,
				heroId = self.id,
				isUnlock = var_13_2,
				isEquiped = AstrolabeTools.GetIsEquiped(self.using_astrolabe, iter_13_3),
				isCanLock = var_13_3,
				posX = iter_13_0,
				posY = iter_13_2
			}

			if arg_13_1 == AstrolabeConst.VIEW_TYPE.ISPREVIEW then
				var_13_4.isUnlock = true
				var_13_4.isEquiped = true
				var_13_4.isCanLock = false
			elseif arg_13_1 == AstrolabeConst.VIEW_TYPE.ISPOLYHEDRON then
				var_13_4.isUnlock = true
				var_13_4.isCanLock = false
			end

			table.insert(var_13_1.astrolabe, var_13_4)
		end

		table.insert(var_13_0, var_13_1)
	end

	return var_13_0
end

function var_0_0.GetAstrolabeItemPos(arg_14_0, arg_14_1)
	local var_14_0

	if HeroCfg[arg_14_1] then
		var_14_0 = HeroCfg[arg_14_1].astrolabe or {}
	end

	local var_14_1 = HeroAstrolabeCfg[arg_14_0] and HeroAstrolabeCfg[arg_14_0].hero_astrolabe_suit_id
	local var_14_2 = 1

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1 == var_14_1 then
			var_14_2 = iter_14_0
		end
	end

	return var_14_2
end

function var_0_0.GetSpAstrolabeNodeCanEquiped(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.GetLastIsEquiped(arg_15_0, arg_15_1)
	local var_15_1 = HeroData:GetHeroData(arg_15_1)

	return var_15_0 and AstrolabeTools.GetIsUnlock(var_15_1 and var_15_1.unlocked_astrolabe, arg_15_0) and not AstrolabeTools.GetIsEquiped((var_15_1 or nil) and (var_15_1.using_astrolabe or {}), arg_15_0)
end

function var_0_0.GetSpAstrolabeNodeBySurpass(arg_16_0, arg_16_1)
	if HeroTools.IsSpHero(arg_16_0) then
		for iter_16_0, iter_16_1 in ipairs(HeroCfg[arg_16_0].astrolabe or {}) do
			for iter_16_2, iter_16_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_16_1] or {}) do
				if HeroAstrolabeCfg[iter_16_3] then
					if ConditionCfg[HeroAstrolabeCfg[iter_16_3].unlock_condition].type == 1024 then
						if ConditionCfg[HeroAstrolabeCfg[iter_16_3].unlock_condition].params then
							if arg_16_1 == (ConditionCfg[HeroAstrolabeCfg[iter_16_3].unlock_condition].params[1] or 0) then
								return iter_16_3
							end
						end
					end
				end
			end
		end
	end

	return 0
end

return var_0_0
