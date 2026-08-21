local var_0_0 = class("Guide_8", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 801)
	table.insert(var_1_0, 802)
	table.insert(var_1_0, 804)

	local var_1_1 = HeroData:GetHeroData(1084)

	if var_1_1.weapon_info and var_1_1.weapon_info.level == 1 and arg_1_0:HaveAddWeaponExpMaterial() then
		table.insert(var_1_0, 805)
		table.insert(var_1_0, 806)
		table.insert(var_1_0, 807)

		if not arg_1_0.skipLevelUpClick_ then
			table.insert(var_1_0, 808)
		end

		table.insert(var_1_0, 809)
	end

	local var_1_2 = HeroTools.GetHeroServantInfo(1084)

	if (not var_1_2 or var_1_2 == 0) and arg_1_0:GetSameRaceServant() then
		table.insert(var_1_0, 810)
		table.insert(var_1_0, 811)
		table.insert(var_1_0, 812)
		table.insert(var_1_0, 813)
		table.insert(var_1_0, 814)
		table.insert(var_1_0, 815)
	end

	table.insert(var_1_0, 816)
	table.insert(var_1_0, 817)
	table.insert(var_1_0, 818)

	arg_1_0._steps = {}

	local var_1_3 = #var_1_0

	for iter_1_0 = 1, var_1_3 do
		local var_1_4 = var_1_0[iter_1_0]
		local var_1_5 = arg_1_0:ProduceStep(var_1_4)

		if var_1_5 then
			table.insert(arg_1_0._steps, var_1_5)
		end
	end
end

function var_0_0.HaveAddWeaponExpMaterial(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_2_0 = ItemTools.getItemNum(iter_2_1)
		local var_2_1 = ItemCfg[iter_2_1]

		if var_2_1.sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and var_2_0 > 0 then
			if var_2_1.param[1] < GameLevelSetting[1].weapon_level_exp then
				arg_2_0.skipLevelUpClick_ = true
			end

			return true
		end
	end

	return false
end

function var_0_0.GetSameRaceServant(arg_3_0)
	local var_3_0 = WeaponServantData:GetWeaponServantList()
	local var_3_1 = HeroCfg[1084].race
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if WeaponServantCfg[iter_3_1.id].race == var_3_1 then
			return true
		end
	end
end

return var_0_0
