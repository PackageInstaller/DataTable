return {
	GetHeroSkillInfo = function(self, arg_1_1)
		local var_1_0 = {}
		local var_1_1 = self:GetHeroData(arg_1_1)

		for iter_1_0, iter_1_1 in ipairs(var_1_1.skill) do
			var_1_0[iter_1_1.skill_id] = iter_1_1.skill_level
		end

		local var_1_2 = {}

		for iter_1_2, iter_1_3 in ipairs(HeroCfg[arg_1_1].skills) do
			local var_1_3 = HeroTools.GetHeroSkillAddLevel(var_1_1, iter_1_3)

			table.insert(var_1_2, {
				id = iter_1_3,
				heroId = arg_1_1,
				lv = var_1_0[iter_1_3],
				isCanStarUp = SkillTools.GetIsCanUpNew(iter_1_3, var_1_0[iter_1_3], false),
				isCanAttrUp = SkillTools.GetIsCanUpNew(iter_1_3, var_1_0[iter_1_3], true),
				addSkillLv = (SkillTools.GetIsDodgeSkill(iter_1_3) or nil) and 0,
				addEquipSkillLv = self:GetTransitionAddLevel(arg_1_1, iter_1_3)
			})
		end

		if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			for iter_1_4, iter_1_5 in ipairs(var_1_2) do
				iter_1_5.lv = 1
				iter_1_5.isCanUp = false
				iter_1_5.addSkillLv = 0
			end
		elseif self.viewDataType == HeroConst.HERO_DATA_TYPE.FORIEGN then
			for iter_1_6, iter_1_7 in ipairs(var_1_2) do
				iter_1_7.isCanUp = false
			end
		elseif self.viewDataType == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
			for iter_1_8, iter_1_9 in ipairs(var_1_2) do
				iter_1_9.isCanUp = false
			end
		elseif self.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			for iter_1_10, iter_1_11 in ipairs(var_1_2) do
				iter_1_11.isCanUp = false
			end
		end

		return var_1_2
	end,
	GetSkillLv = function(self, arg_2_1, arg_2_2)
		if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return 1
		else
			for iter_2_0, iter_2_1 in ipairs((self:GetHeroSkillInfoList(arg_2_1))) do
				if iter_2_1.skill_id == arg_2_2 then
					return iter_2_1.skill_level
				end
			end
		end

		return 0
	end,
	GetRealSkillId = function(self, arg_3_1, arg_3_2)
		local var_3_0 = self:GetHeroData(arg_3_1)
		local var_3_1 = arg_3_2
		local var_3_3 = self:GetHeroServantInfo(arg_3_1)

		for iter_3_0, iter_3_1 in pairs(HeroCfg[arg_3_1].equip_orange_skill) do
			if iter_3_1[1] == arg_3_2 and ((var_3_3 or nil) and var_3_3.id) == iter_3_1[2] then
				var_3_1 = iter_3_1[3]
			end
		end

		for iter_3_2, iter_3_3 in pairs(HeroCfg[arg_3_1].astrolabe_skill) do
			if iter_3_3[1] == arg_3_2 then
				for iter_3_4, iter_3_5 in pairs(var_3_0.using_astrolabe) do
					if iter_3_3[2] == iter_3_5 then
						var_3_1 = iter_3_3[3]
					end
				end
			end
		end

		return var_3_1
	end,
	GetTransitionAddLevel = function(self, arg_4_1, arg_4_2)
		local var_4_0 = self:GetHeroData(arg_4_1)
		local var_4_1 = table.indexof(HeroCfg[arg_4_1].skills, arg_4_2)

		if not var_4_1 then
			return 0
		end

		local var_4_2 = HeroTools.GetHeroEquipTransitionAddLevel(var_4_0)
		local var_4_3 = self:GetEquipDataList(arg_4_1)
		local var_4_4 = 0
		local var_4_5 = 0

		for iter_4_0, iter_4_1 in ipairs((var_4_0:GetTransitionInfoList())) do
			if var_4_3[iter_4_1.slot_id].equip_id ~= 0 and var_4_3[iter_4_1.slot_id]:GetLevel() >= GameSetting.exclusive_open_need.value[1] then
				for iter_4_2, iter_4_3 in ipairs(iter_4_1.skill_list) do
					for iter_4_4, iter_4_5 in ipairs(GameSetting.exclusive_skill_level_up_type.value) do
						if iter_4_3.skill_id == iter_4_5[1] and iter_4_5[2] == var_4_1 then
							var_4_5 = var_4_5 + iter_4_3.skill_level
							var_4_4 = iter_4_3.skill_id
						end
					end
				end
			end
		end

		if var_4_4 ~= 0 then
			return EquipSkillCfg[var_4_4].upgrade / EquipSkillCfg[var_4_4].percent * (var_4_5 + var_4_2)
		end

		return 0
	end,
	GetSkillAttrLv = function(self, arg_5_1, arg_5_2)
		for iter_5_0, iter_5_1 in ipairs(self:GetHeroData(arg_5_1).skillAttrList or {}) do
			if iter_5_1.index == arg_5_2 then
				return iter_5_1.level
			end
		end

		return 0
	end,
	GetSkillAtrrProgressValue = function(self, arg_6_1, arg_6_2, arg_6_3)
		if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return 0
		end

		local var_6_0 = (arg_6_3 or self:GetSkillAttrLv(arg_6_1, arg_6_2)) / HeroConst.MAX_SKILL_ATTR_LEVEL

		return ((arg_6_3 or self:GetSkillAttrLv(arg_6_1, arg_6_2)) / HeroConst.MAX_SKILL_ATTR_LEVEL > 1 or nil) and 1
	end,
	GetAdditionShowTextByType = function(self, arg_7_1, arg_7_2, arg_7_3)
		local var_7_1 = self:GetHeroData(arg_7_2)
		local var_7_2 = SkillAdditionCfg[arg_7_1]

		if (arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT or arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE) and not var_7_2 then
			return nil, false
		end

		local var_7_3 = {}

		if arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT then
			var_7_3 = self:GetWeaponServantData(var_7_1, var_7_2)
		elseif arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE then
			var_7_3 = self:GetWeaponModuleData(arg_7_2, arg_7_1)
		elseif arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE then
			var_7_3 = self:GetAstrolabeData(var_7_2, var_7_1)
		else
			local var_7_4

			if arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE then
				var_7_3 = {}
				var_7_4 = var_7_3
			end
		end

		return var_7_4, var_7_3 and next(var_7_3) or false
	end,
	GetWeaponServantData = function(self, arg_8_1, arg_8_2)
		local var_8_0 = {}
		local var_8_2 = arg_8_1:GetServantInfo()

		if WeaponServantCfg[var_8_2.id] then
			local var_8_3 = false

			for iter_8_0, iter_8_1 in pairs(arg_8_2.weapon_servant_id or {}) do
				for iter_8_2, iter_8_3 in pairs(WeaponServantCfg[var_8_2.id].effect) do
					if iter_8_1 == iter_8_3 then
						var_8_3 = true
					end
				end
			end

			if var_8_3 then
				local var_8_4 = HeroTools.GetHeroWeaponAddLevel(arg_8_1) or 0

				table.insert(var_8_0, {
					titleName = GetI18NText(ItemCfg[var_8_2.id].name),
					showDesc = self:GetServantEffect(var_8_2.id, var_8_2.stage + var_8_4)
				})
			end
		end

		return var_8_0
	end,
	GetWeaponModuleData = function(self, arg_9_1, arg_9_2)
		local var_9_0 = {}
		local var_9_1 = self:GetHeroData(arg_9_1).moduleLevel
		local var_9_3 = true

		if var_9_1 > 0 then
			local var_9_4 = {}

			for iter_9_0, iter_9_1 in pairs((HeroTools:GetModulePowersByHeroIDAndLevel(arg_9_1, var_9_1))) do
				if getSkillAffectByModule(iter_9_1) == arg_9_2 then
					table.insert(var_9_4, iter_9_1)
				end
			end

			local var_9_5, var_9_6, var_9_7, var_9_8 = HeroTools.GetModuleAllDes(var_9_4, arg_9_1)

			if var_9_6 then
				table.insert(var_9_0, {
					titleName = GetI18NText(WeaponModuleCfg[arg_9_1].name),
					showDesc = var_9_6
				})
			else
				var_9_3 = false
			end
		end

		return var_9_0, var_9_3
	end,
	GetAstrolabeData = function(self, arg_10_1, arg_10_2)
		local var_10_0 = {}
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_1.astrolabe_id or {}) do
			for iter_10_2, iter_10_3 in pairs(arg_10_2.using_astrolabe) do
				if iter_10_3 == iter_10_1 then
					table.insert(var_10_1, iter_10_3)
				end
			end
		end

		for iter_10_4, iter_10_5 in pairs(var_10_1) do
			if HeroAstrolabeCfg[iter_10_5] and AstrolabeEffectCfg[iter_10_5] then
				local var_10_2 = string.format("%s·%s", GetI18NText(HeroAstrolabeCfg[iter_10_5].suit_name), GetI18NText(HeroAstrolabeCfg[iter_10_5].name))

				if AstrolabeEffectCfg[iter_10_5] then
					if DescriptionCfg[AstrolabeEffectCfg[iter_10_5].desc[1] or nil] then
						table.insert(var_10_0, {
							titleName = var_10_2,
							showDesc = self:GetAstrolabeDesc(iter_10_5, arg_10_2.id)
						})
					end
				end
			end
		end

		return var_10_0
	end,
	GetSkillAttrData = function(self, arg_11_1, arg_11_2)
		local var_11_0 = {}

		if SkillTools.GetIsDodgeSkill(arg_11_1) then
			return var_11_0
		end

		local var_11_1 = SkillTools.GetSkillIdIndex(arg_11_1)

		for iter_11_0 = 1, self:GetSkillAttrLv(arg_11_2, var_11_1) do
			local var_11_2 = SkillTools.GetSkillAttrCfg(arg_11_2, var_11_1, iter_11_0)

			if var_11_2 then
				local var_11_3 = {
					titleName = string.format("%s%s", GetTips("LEVEL"), iter_11_0)
				}

				showDesc = ""

				for iter_11_1, iter_11_2 in pairs(var_11_2.attr) do
					showDesc = string.format("%s%s<color=#F48800>%s%%</color>\n", showDesc, PublicAttrCfg[iter_11_2[1]] and GetI18NText(PublicAttrCfg[iter_11_2[1]].name) or "", iter_11_2[2] / 10)
				end

				var_11_3.showDesc = showDesc

				table.insert(var_11_0, var_11_3)
			end
		end

		return var_11_0
	end,
	GetSkillDesc = function(self, arg_12_1, arg_12_2, arg_12_3)
		if not HeroSkillCfg[arg_12_1] then
			print("技能 id" .. arg_12_1 .. "没有配置")
		end

		arg_12_2 = arg_12_2 or 1

		local var_12_0 = ""
		local var_12_1 = SkillTools.GetHeroIDBySkillID(arg_12_1)

		if HeroSkillCfg[arg_12_1] and HeroSkillCfg[arg_12_1].desc and type(HeroSkillCfg[arg_12_1].desc) == "table" then
			local var_12_2 = HeroSkillCfg[arg_12_1].desc[1]
			local var_12_3 = HeroTools:GetModulePowersByHeroIDAndLevel(var_12_1, self:GetHeroData(var_12_1).moduleLevel)

			if HeroSkillCfg[arg_12_1].strengthen_desc and HeroSkillCfg[arg_12_1].strengthen_desc ~= "" then
				for iter_12_0, iter_12_1 in ipairs(HeroSkillCfg[arg_12_1].strengthen_desc) do
					if iter_12_1[1] and table.indexof(var_12_3, iter_12_1[1]) then
						var_12_2 = iter_12_1[2]
					end
				end
			end

			var_12_0 = GetCfgDescription(var_12_2, arg_12_2)
		end

		if arg_12_3 then
			return string.gsub(var_12_0, "%(" .. GetTips("SKILL_NEXT_LEVEL") .. ".-%)", "")
		end

		return (string.gsub(var_12_0, "下一级", GetTips("SKILL_NEXT_LEVEL")))
	end,
	CheckIsSelf = function(self)
		return self.isSelf == true
	end
}
