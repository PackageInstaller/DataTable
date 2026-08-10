return {
	GetHeroSkillInfo = function(arg_1_0, arg_1_1)
		local var_1_0 = {}
		local var_1_1 = arg_1_0:GetHeroData(arg_1_1)

		for iter_1_0, iter_1_1 in ipairs(var_1_1.skill) do
			var_1_0[iter_1_1.skill_id] = iter_1_1.skill_level
		end

		local var_1_2 = {}

		for iter_1_2, iter_1_3 in ipairs(HeroCfg[arg_1_1].skills) do
			local var_1_3 = HeroTools.GetHeroSkillAddLevel(var_1_1, iter_1_3)

			if SkillTools.GetIsDodgeSkill(iter_1_3) then
				var_1_3 = 0
			end

			table.insert(var_1_2, {
				id = iter_1_3,
				heroId = arg_1_1,
				lv = var_1_0[iter_1_3],
				isCanStarUp = SkillTools.GetIsCanUpNew(iter_1_3, var_1_0[iter_1_3], false),
				isCanAttrUp = SkillTools.GetIsCanUpNew(iter_1_3, var_1_0[iter_1_3], true),
				addSkillLv = var_1_3,
				addEquipSkillLv = arg_1_0:GetTransitionAddLevel(arg_1_1, iter_1_3)
			})
		end

		if arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			for iter_1_4, iter_1_5 in ipairs(var_1_2) do
				iter_1_5.lv = 1
				iter_1_5.isCanUp = false
				iter_1_5.addSkillLv = 0
			end
		elseif arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.FORIEGN then
			for iter_1_6, iter_1_7 in ipairs(var_1_2) do
				iter_1_7.isCanUp = false
			end
		elseif arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
			for iter_1_8, iter_1_9 in ipairs(var_1_2) do
				iter_1_9.isCanUp = false
			end
		elseif arg_1_0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			for iter_1_10, iter_1_11 in ipairs(var_1_2) do
				iter_1_11.isCanUp = false
			end
		end

		return var_1_2
	end,
	GetSkillLv = function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return 1
		else
			local var_2_0 = arg_2_0:GetHeroSkillInfoList(arg_2_1)

			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				if iter_2_1.skill_id == arg_2_2 then
					return iter_2_1.skill_level
				end
			end
		end

		return 0
	end,
	GetRealSkillId = function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = HeroCfg[arg_3_1]
		local var_3_1 = arg_3_0:GetHeroData(arg_3_1)
		local var_3_2 = arg_3_2
		local var_3_3 = 0
		local var_3_4 = arg_3_0:GetHeroServantInfo(arg_3_1)

		if var_3_4 then
			var_3_3 = var_3_4.id
		end

		for iter_3_0, iter_3_1 in pairs(var_3_0.equip_orange_skill) do
			if iter_3_1[1] == arg_3_2 and var_3_3 == iter_3_1[2] then
				var_3_2 = iter_3_1[3]
			end
		end

		for iter_3_2, iter_3_3 in pairs(var_3_0.astrolabe_skill) do
			if iter_3_3[1] == arg_3_2 then
				for iter_3_4, iter_3_5 in pairs(var_3_1.using_astrolabe) do
					if iter_3_3[2] == iter_3_5 then
						var_3_2 = iter_3_3[3]
					end
				end
			end
		end

		return var_3_2
	end,
	GetTransitionAddLevel = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_0:GetHeroData(arg_4_1)
		local var_4_1 = HeroCfg[arg_4_1]
		local var_4_2 = table.indexof(var_4_1.skills, arg_4_2)

		if not var_4_2 then
			return 0
		end

		local var_4_3 = HeroTools.GetHeroEquipTransitionAddLevel(var_4_0)
		local var_4_4 = GameSetting.exclusive_skill_level_up_type.value
		local var_4_5 = var_4_0:GetTransitionInfoList()
		local var_4_6 = arg_4_0:GetEquipDataList(arg_4_1)
		local var_4_7 = 0
		local var_4_8 = 0

		for iter_4_0, iter_4_1 in ipairs(var_4_5) do
			local var_4_9 = var_4_6[iter_4_1.slot_id]

			if var_4_9.equip_id ~= 0 and var_4_9:GetLevel() >= GameSetting.exclusive_open_need.value[1] then
				local var_4_10 = iter_4_1.skill_list

				for iter_4_2, iter_4_3 in ipairs(var_4_10) do
					local var_4_11 = iter_4_3.skill_id

					for iter_4_4, iter_4_5 in ipairs(var_4_4) do
						if var_4_11 == iter_4_5[1] and iter_4_5[2] == var_4_2 then
							var_4_8 = var_4_8 + iter_4_3.skill_level
							var_4_7 = var_4_11
						end
					end
				end
			end
		end

		if var_4_7 ~= 0 then
			local var_4_12 = EquipSkillCfg[var_4_7]

			return var_4_12.upgrade / var_4_12.percent * (var_4_8 + var_4_3)
		end

		return 0
	end,
	GetSkillAttrLv = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_5_0:GetHeroData(arg_5_1)

		for iter_5_0, iter_5_1 in ipairs(var_5_0.skillAttrList or {}) do
			if iter_5_1.index == arg_5_2 then
				return iter_5_1.level
			end
		end

		return 0
	end,
	GetSkillAtrrProgressValue = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		if arg_6_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return 0
		end

		local var_6_0 = (arg_6_3 or arg_6_0:GetSkillAttrLv(arg_6_1, arg_6_2)) / HeroConst.MAX_SKILL_ATTR_LEVEL

		if var_6_0 > 1 then
			var_6_0 = 1
		end

		return var_6_0
	end,
	GetAdditionShowTextByType = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = true
		local var_7_1 = arg_7_0:GetHeroData(arg_7_2)
		local var_7_2 = SkillAdditionCfg[arg_7_1]

		if (arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT or arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE) and not var_7_2 then
			return nil, false
		end

		local var_7_3 = {}

		if arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT then
			var_7_3 = arg_7_0:GetWeaponServantData(var_7_1, var_7_2)
		elseif arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE then
			var_7_3 = arg_7_0:GetWeaponModuleData(arg_7_2, arg_7_1)
		elseif arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE then
			var_7_3 = arg_7_0:GetAstrolabeData(var_7_2, var_7_1)
		elseif arg_7_3 == HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE then
			var_7_3 = {}
		end

		if not var_7_3 or not next(var_7_3) then
			var_7_0 = false
		end

		return var_7_3, var_7_0
	end,
	GetWeaponServantData = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = {}
		local var_8_1
		local var_8_2 = arg_8_1:GetServantInfo()
		local var_8_3 = var_8_2.id
		local var_8_4 = WeaponServantCfg[var_8_3]

		if var_8_4 then
			local var_8_5 = var_8_4.effect
			local var_8_6 = false

			for iter_8_0, iter_8_1 in pairs(arg_8_2.weapon_servant_id or {}) do
				for iter_8_2, iter_8_3 in pairs(var_8_5) do
					if iter_8_1 == iter_8_3 then
						var_8_6 = true
					end
				end
			end

			if var_8_6 then
				local var_8_7 = var_8_2.stage
				local var_8_8 = GetI18NText(ItemCfg[var_8_3].name)
				local var_8_9 = HeroTools.GetHeroWeaponAddLevel(arg_8_1) or 0
				local var_8_10 = arg_8_0:GetServantEffect(var_8_3, var_8_7 + var_8_9)

				table.insert(var_8_0, {
					titleName = var_8_8,
					showDesc = var_8_10
				})
			end
		end

		return var_8_0
	end,
	GetWeaponModuleData = function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = {}
		local var_9_1 = arg_9_0:GetHeroData(arg_9_1).moduleLevel
		local var_9_2 = {}
		local var_9_3 = true

		if var_9_1 > 0 then
			local var_9_4 = HeroTools:GetModulePowersByHeroIDAndLevel(arg_9_1, var_9_1)
			local var_9_5 = {}

			for iter_9_0, iter_9_1 in pairs(var_9_4) do
				if getSkillAffectByModule(iter_9_1) == arg_9_2 then
					table.insert(var_9_5, iter_9_1)
				end
			end

			local var_9_6, var_9_7, var_9_8, var_9_9 = HeroTools.GetModuleAllDes(var_9_5, arg_9_1)

			if var_9_7 then
				table.insert(var_9_0, {
					titleName = GetI18NText(WeaponModuleCfg[arg_9_1].name),
					showDesc = var_9_7
				})
			else
				var_9_3 = false
			end
		end

		return var_9_0, var_9_3
	end,
	GetAstrolabeData = function(arg_10_0, arg_10_1, arg_10_2)
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
			local var_10_2 = HeroAstrolabeCfg[iter_10_5]
			local var_10_3 = AstrolabeEffectCfg[iter_10_5]

			if var_10_2 and var_10_3 then
				local var_10_4 = string.format("%s·%s", GetI18NText(var_10_2.suit_name), GetI18NText(var_10_2.name))
				local var_10_5 = AstrolabeEffectCfg[iter_10_5] and AstrolabeEffectCfg[iter_10_5].desc[1] or nil

				if DescriptionCfg[var_10_5] then
					table.insert(var_10_0, {
						titleName = var_10_4,
						showDesc = arg_10_0:GetAstrolabeDesc(iter_10_5, arg_10_2.id)
					})
				end
			end
		end

		return var_10_0
	end,
	GetSkillAttrData = function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = {}

		if SkillTools.GetIsDodgeSkill(arg_11_1) then
			return var_11_0
		end

		local var_11_1 = SkillTools.GetSkillIdIndex(arg_11_1)
		local var_11_2 = arg_11_0:GetSkillAttrLv(arg_11_2, var_11_1)

		for iter_11_0 = 1, var_11_2 do
			local var_11_3 = SkillTools.GetSkillAttrCfg(arg_11_2, var_11_1, iter_11_0)

			if var_11_3 then
				local var_11_4 = {
					titleName = string.format("%s%s", GetTips("LEVEL"), iter_11_0)
				}

				showDesc = ""

				for iter_11_1, iter_11_2 in pairs(var_11_3.attr) do
					local var_11_5 = iter_11_2[1]
					local var_11_6 = iter_11_2[2] / 10
					local var_11_7 = PublicAttrCfg[var_11_5] and GetI18NText(PublicAttrCfg[var_11_5].name) or ""

					showDesc = string.format("%s%s<color=#F48800>%s%%</color>\n", showDesc, var_11_7, var_11_6)
				end

				var_11_4.showDesc = showDesc

				table.insert(var_11_0, var_11_4)
			end
		end

		return var_11_0
	end,
	GetSkillDesc = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = HeroSkillCfg[arg_12_1]

		if not var_12_0 then
			print("技能 id" .. arg_12_1 .. "没有配置")
		end

		arg_12_2 = arg_12_2 or 1

		local var_12_1 = ""
		local var_12_2 = SkillTools.GetHeroIDBySkillID(arg_12_1)

		if var_12_0 and var_12_0.desc and type(var_12_0.desc) == "table" then
			local var_12_3 = var_12_0.desc[1]
			local var_12_4 = arg_12_0:GetHeroData(var_12_2)
			local var_12_5 = HeroTools:GetModulePowersByHeroIDAndLevel(var_12_2, var_12_4.moduleLevel)

			if var_12_0.strengthen_desc and var_12_0.strengthen_desc ~= "" then
				for iter_12_0, iter_12_1 in ipairs(var_12_0.strengthen_desc) do
					local var_12_6 = iter_12_1[1]

					if var_12_6 and table.indexof(var_12_5, var_12_6) then
						var_12_3 = iter_12_1[2]
					end
				end
			end

			var_12_1 = GetCfgDescription(var_12_3, arg_12_2)
		end

		if arg_12_3 then
			return string.gsub(var_12_1, "%(" .. GetTips("SKILL_NEXT_LEVEL") .. ".-%)", "")
		end

		return (string.gsub(var_12_1, "下一级", GetTips("SKILL_NEXT_LEVEL")))
	end,
	CheckIsSelf = function(arg_13_0)
		return arg_13_0.isSelf == true
	end
}
