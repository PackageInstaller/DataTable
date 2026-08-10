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
		local var_4_1 = HeroTools.GetHeroSkillAddLevel(var_4_0, iter_4_1.skill_id)

		iter_4_1.skill_level = iter_4_1.skill_level + var_4_1
	end

	return var_4_0, var_4_0.equip_list
end

function GetHeroPracticalAttr(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = HeroTools.GetHeroAttribute(arg_5_0)
	local var_5_1 = DormTools:GetDormAdditionByHeroID(arg_5_0.id, arg_5_0.dormLevel, arg_5_4).attribute

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if var_5_0[iter_5_0] == nil then
			var_5_0[iter_5_0] = 0
		end

		var_5_0[iter_5_0] = var_5_0[iter_5_0] + iter_5_1
	end

	local var_5_2 = EquipTools.CalHeroVirtualEquipAttribute(arg_5_2, arg_5_0, arg_5_3)
	local var_5_3 = HeroTools.CalTransitionSkillAttribute(arg_5_0, arg_5_2)
	local var_5_4 = WeaponTools.CalWeaponAttribute(arg_5_0.id, arg_5_0.weapon_info, arg_5_1)
	local var_5_5 = HeroTools.GetModuleAttribute(arg_5_0)
	local var_5_6 = HeroTools.GetSkillAttribute(arg_5_0)
	local var_5_7 = {}

	if arg_5_0.relation then
		var_5_7 = arg_5_0.relation:GetRelationNetAttr()
	end

	for iter_5_2, iter_5_3 in pairs(var_5_2) do
		var_5_0[iter_5_2] = HeroTools.AttributeAdd(iter_5_2, var_5_0[iter_5_2], iter_5_3)
	end

	for iter_5_4, iter_5_5 in pairs(var_5_3) do
		var_5_0[iter_5_4] = HeroTools.AttributeAdd(iter_5_4, var_5_0[iter_5_4], iter_5_5)
	end

	for iter_5_6, iter_5_7 in pairs(var_5_4) do
		var_5_0[iter_5_6] = HeroTools.AttributeAdd(iter_5_6, var_5_0[iter_5_6], iter_5_7)
	end

	for iter_5_8, iter_5_9 in pairs(var_5_5) do
		var_5_0[iter_5_8] = HeroTools.AttributeAdd(iter_5_8, var_5_0[iter_5_8], iter_5_9)
	end

	for iter_5_10, iter_5_11 in pairs(var_5_6) do
		var_5_0[iter_5_10] = HeroTools.AttributeAdd(iter_5_10, var_5_0[iter_5_10], iter_5_11)
	end

	for iter_5_12, iter_5_13 in pairs(var_5_7) do
		var_5_0[iter_5_12] = HeroTools.AttributeAdd(iter_5_12, var_5_0[iter_5_12], iter_5_13)
	end

	HeroTools.CalFinalAttribute(var_5_0)

	return var_5_0
end

function GetMatrixtHeroPracticalAttr(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = HeroTools.GetHeroAttribute(arg_6_0)

	if not arg_6_4:GetIsOwnerHero() then
		local var_6_1 = HeroStandardSystemCfg[arg_6_2].hero_attrib

		if type(var_6_1) == "table" then
			for iter_6_0, iter_6_1 in pairs(var_6_1) do
				var_6_0[iter_6_1[1]] = iter_6_1[2]
			end
		end
	else
		local var_6_2 = EquipTools.CalHeroVirtualEquipAttribute(arg_6_1, arg_6_0)
		local var_6_3 = WeaponTools.CalWeaponAttribute(arg_6_0.id, arg_6_0.weapon_info, arg_6_0.servantInfo)
		local var_6_4 = HeroTools.CalTransitionSkillAttribute(arg_6_0, arg_6_1)

		for iter_6_2, iter_6_3 in pairs(var_6_2) do
			var_6_0[iter_6_2] = HeroTools.AttributeAdd(iter_6_2, var_6_0[iter_6_2], iter_6_3)
		end

		for iter_6_4, iter_6_5 in pairs(var_6_4) do
			var_6_0[iter_6_4] = HeroTools.AttributeAdd(iter_6_4, var_6_0[iter_6_4], iter_6_5)
		end

		for iter_6_6, iter_6_7 in pairs(var_6_3) do
			var_6_0[iter_6_6] = HeroTools.AttributeAdd(iter_6_6, var_6_0[iter_6_6], iter_6_7)
		end
	end

	local var_6_5 = {}

	if arg_6_3 then
		local var_6_6 = ActivityTools.GetActivityType(arg_6_3)

		if var_6_6 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
			var_6_5 = ActivityMatrixData:CalMatrixAttribute(arg_6_3)
		elseif var_6_6 == ActivityTemplateConst.STRATEGY_MATRIX then
			var_6_5 = StrategyMatrixData:CalMatrixAttribute(arg_6_3)
		else
			error("GetMatrixtHeroPracticalAttr can not find current matrixAttr")
		end
	else
		var_6_5 = MatrixData:CalMatrixAttribute()
	end

	for iter_6_8, iter_6_9 in pairs(var_6_5) do
		var_6_0[iter_6_8] = HeroTools.AttributeAdd(iter_6_8, var_6_0[iter_6_8], iter_6_9)
	end

	HeroTools.CalFinalAttribute(var_6_0)

	return var_6_0
end

function GetPolyhedronHeroPracticalAttr(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = HeroTools.GetHeroAttribute(arg_7_1)
	local var_7_1 = EquipTools.CalHeroVirtualEquipAttribute(arg_7_2, arg_7_1)
	local var_7_2 = HeroTools.CalTransitionSkillAttribute(arg_7_1, arg_7_2)
	local var_7_3 = clone(arg_7_1.weapon_info)

	var_7_3.exp = 0

	local var_7_4 = WeaponTools.CalWeaponAttribute(arg_7_1.id, var_7_3, arg_7_1.servantInfo)

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		var_7_0[iter_7_0] = HeroTools.AttributeAdd(iter_7_0, var_7_0[iter_7_0], iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs(var_7_2) do
		var_7_0[iter_7_2] = HeroTools.AttributeAdd(iter_7_2, var_7_0[iter_7_2], iter_7_3)
	end

	for iter_7_4, iter_7_5 in pairs(var_7_4) do
		var_7_0[iter_7_4] = HeroTools.AttributeAdd(iter_7_4, var_7_0[iter_7_4], iter_7_5)
	end

	local var_7_5 = arg_7_0:CalPolyhedronAttribute(arg_7_1.id)

	for iter_7_6, iter_7_7 in pairs(var_7_5) do
		var_7_0[iter_7_6] = HeroTools.AttributeAdd(iter_7_6, var_7_0[iter_7_6], iter_7_7)
	end

	local var_7_6 = HeroStandardSystemCfg[arg_7_3].hero_attrib

	if type(var_7_6) == "table" then
		for iter_7_8, iter_7_9 in pairs(var_7_6) do
			var_7_0[iter_7_9[1]] = iter_7_9[2]
		end
	end

	HeroTools.CalFinalAttribute(var_7_0)

	return var_7_0
end

function GetHeroFinalAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 and arg_8_3 ~= 0 then
		local var_8_0 = HeroStandardSystemCfg[arg_8_3].hero_attrib

		if type(var_8_0) == "table" and not table.isEmpty(var_8_0) then
			local var_8_1 = {}

			for iter_8_0, iter_8_1 in pairs(var_8_0) do
				var_8_1[iter_8_1[1]] = iter_8_1[2]
			end

			return var_8_1
		else
			local var_8_2 = true

			return GetHeroPracticalAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_4, var_8_2)
		end
	end

	return GetHeroPracticalAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_4, false)
end

function calcBattlePower(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = 0
	local var_9_1

	if arg_9_4 then
		var_9_1 = arg_9_4
	else
		var_9_1 = GetHeroFinalAttr(arg_9_0, arg_9_1, arg_9_2, arg_9_3, true)
	end

	local var_9_2 = var_9_1[HeroConst.HERO_ATTRIBUTE.ATK] or 0
	local var_9_3 = var_9_1[HeroConst.HERO_ATTRIBUTE.STA] or 0
	local var_9_4 = var_9_1[HeroConst.HERO_ATTRIBUTE.ARM] or 0
	local var_9_5 = (var_9_1[HeroConst.HERO_ATTRIBUTE.CRITICAL_RATE] or 5000) / 1000 or 0
	local var_9_6 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.skill) do
		local var_9_7 = HeroTools.GetHeroSkillAddLevel(arg_9_0, iter_9_1.skill_id)

		var_9_6 = var_9_6 + iter_9_1.skill_level + var_9_7
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.skillAttrList) do
		var_9_6 = var_9_6 + iter_9_3.level
	end

	local var_9_8 = 0
	local var_9_9 = EquipTools.CountHeroTotalSkill(arg_9_2, arg_9_0)

	for iter_9_4, iter_9_5 in pairs(var_9_9) do
		var_9_8 = var_9_8 + iter_9_5
	end

	local var_9_10 = 0
	local var_9_11 = {}

	for iter_9_6, iter_9_7 in pairs(arg_9_2) do
		if iter_9_7.prefab_id ~= 0 then
			local var_9_12 = iter_9_7.prefab_id
			local var_9_13 = EquipCfg[var_9_12].suit

			var_9_11[var_9_13] = 1 + (var_9_11[var_9_13] or 0)
		end
	end

	local var_9_14 = HeroTools.GetIsSuitNumCut(arg_9_0)

	for iter_9_8, iter_9_9 in pairs(var_9_11) do
		local var_9_15 = EquipSuitCfg.get_id_list_by_suit[iter_9_8]

		for iter_9_10, iter_9_11 in ipairs(var_9_15) do
			if iter_9_9 >= EquipTools.GetSuitNeedNum(iter_9_11, var_9_14) then
				var_9_10 = var_9_10 + 1
			end
		end
	end

	local var_9_16 = 0

	for iter_9_12, iter_9_13 in pairs(arg_9_0.using_astrolabe) do
		if iter_9_13 ~= 0 then
			var_9_16 = var_9_16 + 1
		end
	end

	local var_9_17 = 0

	if arg_9_1 ~= nil then
		local var_9_18 = HeroTools.GetHeroWeaponAddLevel(arg_9_0)
		local var_9_19 = WeaponServantCfg[arg_9_1.id]

		if var_9_19 and var_9_19.type ~= 3 then
			local var_9_20 = 0.3

			if var_9_19.starlevel == 3 then
				var_9_20 = 0.3
			elseif var_9_19.starlevel == 4 then
				var_9_20 = 0.6
			elseif var_9_19.starlevel == 5 then
				var_9_20 = 0.8
			end

			local var_9_21 = math.floor(var_9_19.effect[1] / 100)

			if var_9_19.type == 2 and var_9_21 == arg_9_0.id then
				var_9_20 = 1
			end

			var_9_17 = 214 * (arg_9_1.stage + var_9_18) + 746
			var_9_17 = var_9_20 * var_9_17
		end
	end

	local var_9_22 = HeroTools.CountTransitionTotalSkill(arg_9_0, arg_9_2)
	local var_9_23 = HeroCfg[arg_9_0.id].unlock_star / 100
	local var_9_24 = 8

	if var_9_23 == 1 then
		var_9_24 = 8
	elseif var_9_23 == 2 then
		var_9_24 = 10
	elseif var_9_23 == 3 then
		var_9_24 = 16
	end

	local var_9_25
	local var_9_26 = HeroTools.IsSpHero(arg_9_0.id) and 133 or 355
	local var_9_27 = var_9_2 * 1 + var_9_3 * 0.15 + var_9_4 * 0.8 + var_9_5 * 2400 + var_9_6 * var_9_24 + var_9_16 * var_9_26 + var_9_8 * 128 + var_9_10 * 400 + var_9_17 + var_9_22 * 60

	return math.floor(var_9_27)
end
