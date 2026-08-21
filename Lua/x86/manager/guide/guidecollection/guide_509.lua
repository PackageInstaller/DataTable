local var_0_0 = class("Guide_509", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 50901)
	table.insert(var_1_0, 50902)
	table.insert(var_1_0, 50903)

	local var_1_1 = HeroData:GetHeroData(1084)

	if var_1_1.weapon_info and var_1_1.weapon_info.level == 1 and arg_1_0:HaveAddWeaponExpMaterial() then
		table.insert(var_1_0, 50904)
		table.insert(var_1_0, 50905)
		table.insert(var_1_0, 50906)

		if not arg_1_0.skipLevelUpClick_ then
			table.insert(var_1_0, 50907)
		end

		table.insert(var_1_0, 50908)
	end

	local var_1_2 = HeroTools.GetHeroServantInfo(1084)

	if (not var_1_2 or var_1_2 == 0) and arg_1_0:GetSameRaceServant() then
		table.insert(var_1_0, 50909)
		table.insert(var_1_0, 50910)
		table.insert(var_1_0, 50911)
		table.insert(var_1_0, 50912)
		table.insert(var_1_0, 50913)
		table.insert(var_1_0, 50914)
	end

	table.insert(var_1_0, 50915)
	table.insert(var_1_0, 50916)
	table.insert(var_1_0, 50917)
	table.insert(var_1_0, 50918)

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
