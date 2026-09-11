return {
	GetHeroAstrolabeS = function(self, arg_1_1)
		local var_1_0 = self:GetHeroData(arg_1_1)
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in ipairs(HeroCfg[var_1_0.id].astrolabe) do
			local var_1_2 = {
				suitId = iter_1_1,
				astrolabe = {}
			}

			for iter_1_2, iter_1_3 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1]) do
				local var_1_5 = AstrolabeTools.GetIsUnlock(var_1_0.unlocked_astrolabe, iter_1_3)
				local var_1_6 = AstrolabeTools.GetIsCanUnlock(iter_1_3, var_1_0.id) and var_1_0.unlock == 1
				local var_1_8 = {
					id = iter_1_3,
					heroId = var_1_0.id,
					isUnlock = (HeroTools.IsSpHero(var_1_0.id) or nil) and AstrolabeTools.GetIsUnlock(var_1_0.unlocked_astrolabe, iter_1_3) and self:GetLastIsEquiped(iter_1_3, var_1_0.id),
					isEquiped = AstrolabeTools.GetIsEquiped(var_1_0.using_astrolabe, iter_1_3)
				}

				var_1_8.isCanLock = AstrolabeTools.GetIsCanUnlock(iter_1_3, var_1_0.id) and var_1_0.unlock == 1
				var_1_8.posX = iter_1_0
				var_1_8.posY = iter_1_2

				if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
					var_1_8.isUnlock = true
					var_1_8.isEquiped = false
					var_1_8.isCanLock = false
				elseif self.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
					var_1_8.isCanLock = false
				elseif self.viewDataType == HeroConst.HERO_DATA_TYPE.TRIAL then
					var_1_8.isCanLock = false
				end

				table.insert(var_1_2.astrolabe, var_1_8)
			end

			table.insert(var_1_1, var_1_2)
		end

		return var_1_1
	end,
	GetAcitveEffect = function(self, arg_2_1)
		if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			if iter_2_1 ~= 0 then
				if var_2_0[HeroAstrolabeCfg[iter_2_1].hero_astrolabe_suit_id] == nil then
					var_2_0[HeroAstrolabeCfg[iter_2_1].hero_astrolabe_suit_id] = {
						num = 1,
						id = HeroAstrolabeCfg[iter_2_1].hero_astrolabe_suit_id
					}
				else
					var_2_0[HeroAstrolabeCfg[iter_2_1].hero_astrolabe_suit_id].num = var_2_0[HeroAstrolabeCfg[iter_2_1].hero_astrolabe_suit_id].num + 1
				end
			end
		end

		local var_2_1 = {}

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			table.insert(var_2_1, iter_2_3)
		end

		return var_2_1
	end,
	GetUsingAstrolabe = function(self, arg_3_1)
		if self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		else
			return self:GetHeroData(arg_3_1).using_astrolabe
		end
	end,
	GetAstrolabeDesc = function(self, arg_4_1, arg_4_2)
		if not AstrolabeEffectCfg[arg_4_1] then
			print("id:" .. arg_4_1 .. "没有配置")
		end

		if AstrolabeEffectCfg[arg_4_1] and AstrolabeEffectCfg[arg_4_1].desc and type(AstrolabeEffectCfg[arg_4_1].desc) == "table" then
			local var_4_0 = AstrolabeEffectCfg[arg_4_1].desc[1]
			local var_4_1 = self:GetServantId(arg_4_2)
			local var_4_2 = self:GetModuleEffectList(arg_4_2)
			local var_4_3 = false

			if AstrolabeEffectCfg[arg_4_1].equip_orange_desc and type(AstrolabeEffectCfg[arg_4_1].equip_orange_desc) == "table" then
				for iter_4_0, iter_4_1 in ipairs(AstrolabeEffectCfg[arg_4_1].equip_orange_desc) do
					if iter_4_1[1] > 0 and iter_4_1[3] > 0 and iter_4_1[1] == var_4_1 and table.indexof(var_4_2, iter_4_1[3]) then
						var_4_0 = iter_4_1[2]
						var_4_3 = true
					end
				end

				if not var_4_3 then
					for iter_4_2, iter_4_3 in ipairs(AstrolabeEffectCfg[arg_4_1].equip_orange_desc) do
						if iter_4_3[1] > 0 and iter_4_3[3] == 0 and iter_4_3[1] == var_4_1 then
							var_4_0 = iter_4_3[2]
							var_4_3 = true
						end
					end

					if not var_4_3 then
						for iter_4_4, iter_4_5 in ipairs(AstrolabeEffectCfg[arg_4_1].equip_orange_desc) do
							if iter_4_5[1] == 0 and iter_4_5[3] > 0 and table.indexof(var_4_2, iter_4_5[3]) then
								var_4_0 = iter_4_5[2]
							end
						end
					end
				end
			end

			return GetCfgDescription(var_4_0, 1)
		end

		return ""
	end,
	GetServantId = function(self, arg_5_1)
		local var_5_1 = self:GetHeroServantInfo(arg_5_1)

		return (var_5_1 or nil) and var_5_1.id
	end,
	GetModuleEffectList = function(self, arg_6_1)
		local var_6_0 = self:GetHeroData(arg_6_1)

		return (HeroTools:GetModulePowersByHeroIDAndLevel(var_6_0.id, var_6_0.moduleLevel))
	end,
	GetAstrolabeAction = function(self, arg_7_1)
		return (self.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON or nil) and PolyhedronAction
	end,
	AstrolabeUnlock = function(arg_8_0, arg_8_1, arg_8_2)
		AstrolabeAction.AstrolabeUnlock(arg_8_1, arg_8_2)
	end,
	AstrolabeEquip = function(self, arg_9_1, arg_9_2)
		self:GetAstrolabeAction().AstrolabeEquip(arg_9_1, arg_9_2)
	end,
	AstrolabeUnload = function(self, arg_10_1, arg_10_2)
		self:GetAstrolabeAction().AstrolabeUnload(arg_10_1, arg_10_2)
	end,
	AstrolabeEquipAll = function(self, arg_11_1, arg_11_2)
		self:GetAstrolabeAction().AstrolabeEquipAll(arg_11_1, arg_11_2)
	end,
	AstrolabeUnlock = function(arg_12_0, arg_12_1, arg_12_2)
		AstrolabeAction.AstrolabeUnlock(arg_12_1, arg_12_2)
	end,
	AstrolabeUnloadAll = function(self, arg_13_1)
		self:GetAstrolabeAction().AstrolabeUnloadAll(arg_13_1)
	end,
	GetNextIsEquiped = function(self, arg_14_1, arg_14_2)
		local var_14_0 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_14_1] or {}

		if HeroAstrolabeCfg[arg_14_1].pos == 3 then
			return false
		end

		local var_14_1 = self:GetHeroData(arg_14_2)

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if not HeroAstrolabeCfg[iter_14_1] then
				return false
			else
				return AstrolabeTools.GetIsEquiped(var_14_1.using_astrolabe, iter_14_1)
			end
		end

		return false
	end,
	GetLastIsEquiped = function(self, arg_15_1, arg_15_2)
		if HeroAstrolabeCfg[arg_15_1].pre_astrolabe_id == 0 then
			return true
		end

		if HeroAstrolabeCfg[HeroAstrolabeCfg[arg_15_1].pre_astrolabe_id] then
			return AstrolabeTools.GetIsEquiped(self:GetHeroData(arg_15_2).using_astrolabe, HeroAstrolabeCfg[arg_15_1].pre_astrolabe_id)
		end

		return false
	end,
	GetLastIsUnlock = function(self, arg_16_1, arg_16_2)
		if HeroAstrolabeCfg[arg_16_1].pre_astrolabe_id == 0 then
			return true
		end

		if HeroAstrolabeCfg[HeroAstrolabeCfg[arg_16_1].pre_astrolabe_id] then
			return AstrolabeTools.GetIsUnlock(self:GetHeroData(arg_16_2).unlocked_astrolabe, HeroAstrolabeCfg[arg_16_1].pre_astrolabe_id)
		end

		return false
	end,
	GetNextSPNodeIsEquiped = function(self, arg_17_1, arg_17_2)
		local var_17_0 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[arg_17_1] or {}

		if HeroAstrolabeCfg[arg_17_1].pos == 3 then
			return false
		end

		local var_17_1 = self:GetHeroData(arg_17_2)

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if not HeroAstrolabeCfg[iter_17_1] then
				return false
			else
				return AstrolabeTools.GetIsEquiped(self:GetHeroData(arg_17_2).using_astrolabe, iter_17_1)
			end
		end

		return false
	end
}
