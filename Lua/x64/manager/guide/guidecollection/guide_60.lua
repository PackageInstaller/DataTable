local var_0_0 = class("Guide_60", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()

	arg_1_0.nowEquipData_ = arg_1_0:CheckNowHeroData()
	arg_1_0.targetEquip_ = EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.DOWN, EquipConst.EQUIP_SORT.LEVEL, 1)[1]

	table.insert(var_1_0, 6001)
	table.insert(var_1_0, 6002)
	table.insert(var_1_0, 6003)
	table.insert(var_1_0, 6004)

	if arg_1_0.nowEquipData_ then
		table.insert(var_1_0, 6005)
	end

	local var_1_1 = not arg_1_0.nowEquipData_

	if arg_1_0.nowEquipData_ and arg_1_0.nowEquipData_.star == 2 and arg_1_0.nowEquipData_.equipConfig.suit == 29 and arg_1_0.nowEquipData_.equip_id ~= arg_1_0.targetEquip_.equip_id then
		var_1_1 = true
	end

	if var_1_1 then
		table.insert(var_1_0, 6006)
		table.insert(var_1_0, 6007)

		if arg_1_0.targetEquip_:GetEquipHero() then
			print("HERO")
			table.insert(var_1_0, 6008)
		end

		arg_1_0.nowEquipData_ = arg_1_0.targetEquip_
	end

	table.insert(var_1_0, 6009)
	table.insert(var_1_0, 6010)

	if arg_1_0.nowEquipData_ and arg_1_0.nowEquipData_:GetLevel() <= 1 and arg_1_0:HaveAddEquipExpMaterial() then
		table.insert(var_1_0, 6011)
		table.insert(var_1_0, 6012)
	end

	arg_1_0._steps = {}

	local var_1_2 = #var_1_0

	for iter_1_0 = 1, var_1_2 do
		local var_1_3 = var_1_0[iter_1_0]
		local var_1_4 = arg_1_0:ProduceStep(var_1_3)

		if var_1_4 then
			table.insert(arg_1_0._steps, var_1_4)
		end
	end
end

function var_0_0.CheckNowHeroData(arg_2_0)
	local var_2_0 = HeroData:GetHeroList()

	if var_2_0[1084] and var_2_0[1084].equip then
		local var_2_1 = var_2_0[1084].equip[1]

		if var_2_1.equip_id and var_2_1.equip_id ~= 0 then
			return EquipData:GetEquipData(var_2_1.equip_id)
		end
	end

	return nil
end

function var_0_0.HaveAddEquipExpMaterial(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_3_0 = ItemTools.getItemNum(iter_3_1)

		if ItemCfg[iter_3_1].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and var_3_0 > 0 then
			return true
		end
	end

	return false
end

function var_0_0.CheckGuide(arg_4_0)
	if not GuideTool.SatisfyCondition(arg_4_0.open_condition) then
		return false
	end

	local var_4_0 = EquipData:GetEquipList()

	return next(var_4_0) ~= nil
end

return var_0_0
