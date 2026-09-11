function getHeroPower(arg_1_0, arg_1_1)
	if arg_1_1 then
		return TempHeroData:GetBattlePower(arg_1_0)
	end

	return getBattlePower(HeroData:GetHeroData(arg_1_0))
end

function getBattlePower(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.equip) do
		if iter_2_1.equip_id ~= 0 then
			table.insert(var_2_0, EquipData:GetEquipList()[iter_2_1.equip_id])
		end
	end

	local var_2_1

	if arg_2_0.servant_uid ~= nil and arg_2_0.servant_uid ~= 0 then
		local var_2_2 = WeaponServantData.GetWeaponServantList()[arg_2_0.servant_uid]

		var_2_1 = {
			id = var_2_2.id,
			stage = var_2_2.stage
		}
	end

	return calcBattlePower(arg_2_0, var_2_1, var_2_0)
end

function GetPracticalData(arg_3_0)
	return HeroTools.GetConstructHero(arg_3_0), arg_3_0.equip_list
end

function GetVirtualData(arg_4_0)
	local var_4_0 = deepClone(TempHeroData:GetTempHeroDataByTempID(arg_4_0))

	for iter_4_0, iter_4_1 in ipairs(var_4_0.skill) do
		iter_4_1.skill_level = iter_4_1.skill_level + HeroTools.GetHeroSkillAddLevel(var_4_0, iter_4_1.skill_id)
	end

	return var_4_0, var_4_0.equip_list
end

function GetHeroPracticalAttr(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = HeroTools.GetHeroAttribute(arg_5_0)

	for iter_5_0, iter_5_1 in pairs(DormTools:GetDormAdditionByHeroID(arg_5_0.id, arg_5_0.dormLevel, arg_5_4).attribute) do
		if var_5_0[iter_5_0] == nil then
			var_5_0[iter_5_0] = 0
		end

		var_5_0[iter_5_0] = var_5_0[iter_5_0] + iter_5_1
	end

	local var_5_1 = {}

	if arg_5_0.relation then
		var_5_1 = arg_5_0.relation:GetRelationNetAttr()
	end

	for iter_5_2, iter_5_3 in pairs((EquipTools.CalHeroVirtualEquipAttribute(arg_5_2, arg_5_0, arg_5_3))) do
		var_5_0[iter_5_2] = HeroTools.AttributeAdd(iter_5_2, var_5_0[iter_5_2], iter_5_3)
	end

	for iter_5_4, iter_5_5 in pairs((HeroTools.CalTransitionSkillAttribute(arg_5_0, arg_5_2))) do
		var_5_0[iter_5_4] = HeroTools.AttributeAdd(iter_5_4, var_5_0[iter_5_4], iter_5_5)
	end

	for iter_5_6, iter_5_7 in pairs((WeaponTools.CalWeaponAttribute(arg_5_0.id, arg_5_0.weapon_info, arg_5_1))) do
		var_5_0[iter_5_6] = HeroTools.AttributeAdd(iter_5_6, var_5_0[iter_5_6], iter_5_7)
	end

	for iter_5_8, iter_5_9 in pairs((HeroTools.GetModuleAttribute(arg_5_0))) do
		var_5_0[iter_5_8] = HeroTools.AttributeAdd(iter_5_8, var_5_0[iter_5_8], iter_5_9)
	end

	for iter_5_10, iter_5_11 in pairs((HeroTools.GetSkillAttribute(arg_5_0))) do
		var_5_0[iter_5_10] = HeroTools.AttributeAdd(iter_5_10, var_5_0[iter_5_10], iter_5_11)
	end

	for iter_5_12, iter_5_13 in pairs(var_5_1) do
		var_5_0[iter_5_12] = HeroTools.AttributeAdd(iter_5_12, var_5_0[iter_5_12], iter_5_13)
	end

	HeroTools.CalFinalAttribute(var_5_0)

	return var_5_0
end

function GetMatrixtHeroPracticalAttr(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = HeroTools.GetHeroAttribute(arg_6_0)

	if not arg_6_4:GetIsOwnerHero() then
		if type(HeroStandardSystemCfg[arg_6_2].hero_attrib) == "table" then
			for iter_6_0, iter_6_1 in pairs(HeroStandardSystemCfg[arg_6_2].hero_attrib) do
				var_6_0[iter_6_1[1]] = iter_6_1[2]
			end
		end
	else
		for iter_6_2, iter_6_3 in pairs((EquipTools.CalHeroVirtualEquipAttribute(arg_6_1, arg_6_0))) do
			var_6_0[iter_6_2] = HeroTools.AttributeAdd(iter_6_2, var_6_0[iter_6_2], iter_6_3)
		end

		for iter_6_4, iter_6_5 in pairs((HeroTools.CalTransitionSkillAttribute(arg_6_0, arg_6_1))) do
			var_6_0[iter_6_4] = HeroTools.AttributeAdd(iter_6_4, var_6_0[iter_6_4], iter_6_5)
		end

		for iter_6_6, iter_6_7 in pairs((WeaponTools.CalWeaponAttribute(arg_6_0.id, arg_6_0.weapon_info, arg_6_0.servantInfo))) do
			var_6_0[iter_6_6] = HeroTools.AttributeAdd(iter_6_6, var_6_0[iter_6_6], iter_6_7)
		end
	end

	local var_6_1 = {}

	if arg_6_3 then
		local var_6_2 = ActivityTools.GetActivityType(arg_6_3)

		if var_6_2 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
			var_6_1 = ActivityMatrixData:CalMatrixAttribute(arg_6_3)
		elseif var_6_2 == ActivityTemplateConst.STRATEGY_MATRIX then
			var_6_1 = StrategyMatrixData:CalMatrixAttribute(arg_6_3)
		else
			error("GetMatrixtHeroPracticalAttr can not find current matrixAttr")
		end
	else
		var_6_1 = MatrixData:CalMatrixAttribute()
	end

	for iter_6_8, iter_6_9 in pairs(var_6_1) do
		var_6_0[iter_6_8] = HeroTools.AttributeAdd(iter_6_8, var_6_0[iter_6_8], iter_6_9)
	end

	HeroTools.CalFinalAttribute(var_6_0)

	return var_6_0
end

function GetPolyhedronHeroPracticalAttr(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = HeroTools.GetHeroAttribute(arg_7_1)
	local var_7_1 = clone(arg_7_1.weapon_info)

	var_7_1.exp = 0

	for iter_7_0, iter_7_1 in pairs((EquipTools.CalHeroVirtualEquipAttribute(arg_7_2, arg_7_1))) do
		var_7_0[iter_7_0] = HeroTools.AttributeAdd(iter_7_0, var_7_0[iter_7_0], iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs((HeroTools.CalTransitionSkillAttribute(arg_7_1, arg_7_2))) do
		var_7_0[iter_7_2] = HeroTools.AttributeAdd(iter_7_2, var_7_0[iter_7_2], iter_7_3)
	end

	for iter_7_4, iter_7_5 in pairs((WeaponTools.CalWeaponAttribute(arg_7_1.id, var_7_1, arg_7_1.servantInfo))) do
		var_7_0[iter_7_4] = HeroTools.AttributeAdd(iter_7_4, var_7_0[iter_7_4], iter_7_5)
	end

	for iter_7_6, iter_7_7 in pairs((arg_7_0:CalPolyhedronAttribute(arg_7_1.id))) do
		var_7_0[iter_7_6] = HeroTools.AttributeAdd(iter_7_6, var_7_0[iter_7_6], iter_7_7)
	end

	if type(HeroStandardSystemCfg[arg_7_3].hero_attrib) == "table" then
		for iter_7_8, iter_7_9 in pairs(HeroStandardSystemCfg[arg_7_3].hero_attrib) do
			var_7_0[iter_7_9[1]] = iter_7_9[2]
		end
	end

	HeroTools.CalFinalAttribute(var_7_0)

	return var_7_0
end

function GetHeroFinalAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 and arg_8_3 ~= 0 then
		if type(HeroStandardSystemCfg[arg_8_3].hero_attrib) == "table" and not table.isEmpty(HeroStandardSystemCfg[arg_8_3].hero_attrib) then
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in pairs(HeroStandardSystemCfg[arg_8_3].hero_attrib) do
				var_8_0[iter_8_1[1]] = iter_8_1[2]
			end

			return var_8_0
		else
			return GetHeroPracticalAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_4, true)
		end
	end

	return GetHeroPracticalAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_4, false)
end

function calcBattlePower(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_1 = arg_9_4 and arg_9_4 or GetHeroFinalAttr(arg_9_0, arg_9_1, arg_9_2, arg_9_3, true)
	local var_9_2 = var_9_1[HeroConst.HERO_ATTRIBUTE.ATK] or 0
	local var_9_3 = var_9_1[HeroConst.HERO_ATTRIBUTE.STA] or 0
	local var_9_4 = var_9_1[HeroConst.HERO_ATTRIBUTE.ARM] or 0
	local var_9_5 = (var_9_1[HeroConst.HERO_ATTRIBUTE.CRITICAL_RATE] or 5000) / 1000 or 0
	local var_9_6 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.skill) do
		var_9_6 = var_9_6 + iter_9_1.skill_level + HeroTools.GetHeroSkillAddLevel(arg_9_0, iter_9_1.skill_id)
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.skillAttrList) do
		var_9_6 = var_9_6 + iter_9_3.level
	end

	local var_9_7 = 0

	for iter_9_4, iter_9_5 in pairs((EquipTools.CountHeroTotalSkill(arg_9_2, arg_9_0))) do
		var_9_7 = var_9_7 + iter_9_5
	end

	local var_9_8 = 0
	local var_9_9 = {}

	for iter_9_6, iter_9_7 in pairs(arg_9_2) do
		if iter_9_7.prefab_id ~= 0 then
			var_9_9[EquipCfg[iter_9_7.prefab_id].suit] = 1 + (var_9_9[EquipCfg[iter_9_7.prefab_id].suit] or 0)
		end
	end

	local var_9_11 = HeroTools.GetIsSuitNumCut(arg_9_0)

	for iter_9_8, iter_9_9 in pairs(var_9_9) do
		for iter_9_10, iter_9_11 in ipairs(EquipSuitCfg.get_id_list_by_suit[iter_9_8]) do
			if iter_9_9 >= EquipTools.GetSuitNeedNum(iter_9_11, var_9_11) then
				var_9_8 = var_9_8 + 1
			end
		end
	end

	local var_9_12 = 0

	for iter_9_12, iter_9_13 in pairs(arg_9_0.using_astrolabe) do
		if iter_9_13 ~= 0 then
			var_9_12 = var_9_12 + 1
		end
	end

	local var_9_13 = 0

	if arg_9_1 ~= nil then
		local var_9_14 = WeaponServantCfg[arg_9_1.id]

		if WeaponServantCfg[arg_9_1.id] and var_9_14.type ~= 3 then
			local var_9_15 = 0.3

			if var_9_14.starlevel == 3 then
				var_9_15 = 0.3
			elseif var_9_14.starlevel == 4 then
				var_9_15 = 0.6
			elseif var_9_14.starlevel == 5 then
				var_9_15 = 0.8
			end

			if var_9_14.type == 2 and math.floor(var_9_14.effect[1] / 100) == arg_9_0.id then
				var_9_15 = 1
			end

			var_9_13 = 214 * (arg_9_1.stage + HeroTools.GetHeroWeaponAddLevel(arg_9_0)) + 746
			var_9_13 = var_9_15 * (214 * (arg_9_1.stage + HeroTools.GetHeroWeaponAddLevel(arg_9_0)) + 746)
		end
	end

	local var_9_16 = 8

	if HeroCfg[arg_9_0.id].unlock_star / 100 == 1 then
		var_9_16 = 8
	elseif HeroCfg[arg_9_0.id].unlock_star / 100 == 2 then
		var_9_16 = 10
	elseif HeroCfg[arg_9_0.id].unlock_star / 100 == 3 then
		var_9_16 = 16
	end

	return math.floor(var_9_2 * 1 + var_9_3 * 0.15 + var_9_4 * 0.8 + var_9_5 * 2400 + var_9_6 * var_9_16 + var_9_12 * (HeroTools.IsSpHero(arg_9_0.id) and 133 or 355) + var_9_7 * 128 + var_9_8 * 400 + var_9_13 + HeroTools.CountTransitionTotalSkill(arg_9_0, arg_9_2) * 60)
end
