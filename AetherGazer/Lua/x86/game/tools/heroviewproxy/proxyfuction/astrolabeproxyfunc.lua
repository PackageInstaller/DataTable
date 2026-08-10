return {
	GetHeroAstrolabeS = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0:GetHeroData(arg_1_1)
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in ipairs(HeroCfg[var_1_0.id].astrolabe) do
			local var_1_2 = {
				suitId = iter_1_1,
				astrolabe = {}
			}

			for iter_1_2, iter_1_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1]) do
				local var_1_3 = false
				local var_1_4 = false
				local var_1_5 = AstrolabeTools.GetIsUnlock(var_1_0.unlocked_astrolabe, iter_1_3)
				local var_1_6

				var_1_6 = AstrolabeTools.GetIsCanUnlock(iter_1_3, var_1_0.id) and var_1_0.unlock == 1

				if HeroTools.IsSpHero(var_1_0.id) then
					var_1_5 = AstrolabeTools.GetIsUnlock(var_1_0.unlocked_astrolabe, iter_1_3) and arg_1_0:GetLastIsEquiped(iter_1_3, var_1_0.id)

					local var_1_7 = false
				end

				local var_1_8 = {
					id = iter_1_3,
					heroId = var_1_0.id,
					isUnlock = var_1_5,
					isEquiped = AstrolabeTools.GetIsEquiped(var_1_0.using_astrolabe, iter_1_3),
					isCanLock = AstrolabeTools.GetIsCanUnlock(iter_1_3, var_1_0.id) and var_1_0.unlock == 1,
					posX = iter_1_0,
					posY = iter_1_2
				}

				if arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
					var_1_8.isUnlock = true
					var_1_8.isEquiped = false
					var_1_8.isCanLock = false
				elseif arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
					var_1_8.isCanLock = false
				elseif arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.TRIAL then
					var_1_8.isCanLock = false
				end

				table.insert(var_1_2.astrolabe, var_1_8)
			end

			table.insert(var_1_1, var_1_2)
		end

		return var_1_1
	end,
	GetAcitveEffect = function(arg_2_0, arg_2_1)
		if arg_2_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			if iter_2_1 ~= 0 then
				local var_2_1 = HeroAstrolabeCfg[iter_2_1].hero_astrolabe_suit_id

				if var_2_0[var_2_1] == nil then
					var_2_0[var_2_1] = {
						num = 1,
						id = var_2_1
					}
				else
					var_2_0[var_2_1].num = var_2_0[var_2_1].num + 1
				end
			end
		end

		local var_2_2 = {}

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			table.insert(var_2_2, iter_2_3)
		end

		return var_2_2
	end,
	GetUsingAstrolabe = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:GetHeroData(arg_3_1)

		if arg_3_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		else
			return var_3_0.using_astrolabe
		end
	end,
	GetAstrolabeDesc = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = AstrolabeEffectCfg[arg_4_1]

		if not var_4_0 then
			print("id:" .. arg_4_1 .. "没有配置")
		end

		if var_4_0 and var_4_0.desc and type(var_4_0.desc) == "table" then
			local var_4_1 = var_4_0.desc[1]
			local var_4_2 = arg_4_0:GetServantId(arg_4_2)
			local var_4_3 = arg_4_0:GetModuleEffectList(arg_4_2)
			local var_4_4 = false

			if var_4_0.equip_orange_desc and type(var_4_0.equip_orange_desc) == "table" then
				for iter_4_0, iter_4_1 in ipairs(var_4_0.equip_orange_desc) do
					if iter_4_1[1] > 0 and iter_4_1[3] > 0 and iter_4_1[1] == var_4_2 and table.indexof(var_4_3, iter_4_1[3]) then
						var_4_1 = iter_4_1[2]
						var_4_4 = true
					end
				end

				if not var_4_4 then
					for iter_4_2, iter_4_3 in ipairs(var_4_0.equip_orange_desc) do
						if iter_4_3[1] > 0 and iter_4_3[3] == 0 and iter_4_3[1] == var_4_2 then
							var_4_1 = iter_4_3[2]
							var_4_4 = true
						end
					end

					if not var_4_4 then
						for iter_4_4, iter_4_5 in ipairs(var_4_0.equip_orange_desc) do
							if iter_4_5[1] == 0 and iter_4_5[3] > 0 and table.indexof(var_4_3, iter_4_5[3]) then
								var_4_1 = iter_4_5[2]

								local var_4_5 = true
							end
						end
					end
				end
			end

			return GetCfgDescription(var_4_1, 1)
		end

		return ""
	end,
	GetServantId = function(arg_5_0, arg_5_1)
		local var_5_0 = 0
		local var_5_1 = arg_5_0:GetHeroServantInfo(arg_5_1)

		if var_5_1 then
			var_5_0 = var_5_1.id
		end

		return var_5_0
	end,
	GetModuleEffectList = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:GetHeroData(arg_6_1)
		local var_6_1 = {}

		return (HeroTools:GetModulePowersByHeroIDAndLevel(var_6_0.id, var_6_0.moduleLevel))
	end,
	GetAstrolabeAction = function(arg_7_0, arg_7_1)
		local var_7_0 = AstrolabeAction

		if arg_7_0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			var_7_0 = PolyhedronAction
		end

		return var_7_0
	end,
	AstrolabeUnlock = function(arg_8_0, arg_8_1, arg_8_2)
		AstrolabeAction.AstrolabeUnlock(arg_8_1, arg_8_2)
	end,
	AstrolabeEquip = function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_0:GetAstrolabeAction().AstrolabeEquip(arg_9_1, arg_9_2)
	end,
	AstrolabeUnload = function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_0:GetAstrolabeAction().AstrolabeUnload(arg_10_1, arg_10_2)
	end,
	AstrolabeEquipAll = function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_0:GetAstrolabeAction().AstrolabeEquipAll(arg_11_1, arg_11_2)
	end,
	AstrolabeUnlock = function(arg_12_0, arg_12_1, arg_12_2)
		AstrolabeAction.AstrolabeUnlock(arg_12_1, arg_12_2)
	end,
	AstrolabeUnloadAll = function(arg_13_0, arg_13_1)
		arg_13_0:GetAstrolabeAction().AstrolabeUnloadAll(arg_13_1)
	end,
	GetNextIsEquiped = function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = HeroAstrolabeCfg[arg_14_1]
		local var_14_1 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_14_1] or {}

		if var_14_0.pos == 3 then
			return false
		end

		local var_14_2 = arg_14_0:GetHeroData(arg_14_2)

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			if not HeroAstrolabeCfg[iter_14_1] then
				return false
			else
				return AstrolabeTools.GetIsEquiped(var_14_2.using_astrolabe, iter_14_1)
			end
		end

		return false
	end,
	GetLastIsEquiped = function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = HeroAstrolabeCfg[arg_15_1].pre_astrolabe_id
		local var_15_1 = arg_15_0:GetHeroData(arg_15_2)

		if var_15_0 == 0 then
			return true
		end

		if HeroAstrolabeCfg[var_15_0] then
			return AstrolabeTools.GetIsEquiped(var_15_1.using_astrolabe, var_15_0)
		end

		return false
	end,
	GetLastIsUnlock = function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = HeroAstrolabeCfg[arg_16_1].pre_astrolabe_id
		local var_16_1 = arg_16_0:GetHeroData(arg_16_2)

		if var_16_0 == 0 then
			return true
		end

		if HeroAstrolabeCfg[var_16_0] then
			return AstrolabeTools.GetIsUnlock(var_16_1.unlocked_astrolabe, var_16_0)
		end

		return false
	end,
	GetNextSPNodeIsEquiped = function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = HeroAstrolabeCfg[arg_17_1]
		local var_17_1 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_17_1] or {}

		if var_17_0.pos == 3 then
			return false
		end

		local var_17_2 = arg_17_0:GetHeroData(arg_17_2)

		for iter_17_0, iter_17_1 in ipairs(var_17_1) do
			if not HeroAstrolabeCfg[iter_17_1] then
				return false
			else
				local var_17_3 = arg_17_0:GetHeroData(arg_17_2)

				return AstrolabeTools.GetIsEquiped(var_17_3.using_astrolabe, iter_17_1)
			end
		end

		return false
	end
}
