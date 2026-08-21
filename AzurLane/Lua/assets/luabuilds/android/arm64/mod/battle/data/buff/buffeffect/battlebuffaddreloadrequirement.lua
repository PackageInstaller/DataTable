ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleAttr
local var_0_2 = class("BattleBuffAddReloadRequirement", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddReloadRequirement = var_0_2
var_0_2.__name = "BattleBuffAddReloadRequirement"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._weaponIndex = arg_2_0._tempData.arg_list.index
	arg_2_0._weaponType = arg_2_0._tempData.arg_list.type
	arg_2_0._value = arg_2_0._tempData.arg_list.number or 0
	arg_2_0._convertAttr = arg_2_0._tempData.arg_list.convert_attr
	arg_2_0._convertValue = arg_2_0._tempData.arg_list.convert_value

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._weaponType then
		local var_3_0 = arg_3_0._weaponType == var_0_0.EquipmentType.POINT_HIT_AND_LOCK and arg_3_1:GetChargeList() or arg_3_0._weaponType == var_0_0.EquipmentType.MANUAL_TORPEDO and arg_3_1:GetTorpedoList() or (arg_3_0._weaponType == var_0_0.EquipmentType.INTERCEPT_AIRCRAFT or arg_3_0._weaponType == var_0_0.EquipmentType.STRIKE_AIRCRAFT) and arg_3_1:GetHiveList() or arg_3_0._weaponType == var_0_0.EquipmentType.AIR_ASSIST and arg_3_1:GetAirAssistList() or arg_3_1:GetAutoWeapons()

		if var_3_0 then
			for iter_3_0, iter_3_1 in ipairs(var_3_0) do
				({})[#{} + 1] = iter_3_1
			end
		end
	elseif arg_3_0._weaponIndex then
		for iter_3_2, iter_3_3 in ipairs((arg_3_1:GetTotalWeapon())) do
			if iter_3_3:GetEquipmentIndex() == arg_3_0._weaponIndex then
				({})[#{} + 1] = iter_3_3
			end
		end
	else
		assert(false, "BattleBuffAddReloadRequirement：缺少指定类型或索引")
	end

	for iter_3_4, iter_3_5 in ipairs({}) do
		iter_3_5:AppendReloadFactor(arg_3_2, arg_3_0:calcFactor(arg_3_2:GetCaster()))

		local var_3_1 = 1

		for iter_3_6, iter_3_7 in pairs((iter_3_5:GetReloadFactorList())) do
			var_3_1 = var_3_1 + iter_3_7
		end

		iter_3_5:FlushReloadMax(var_3_1)
	end

	arg_3_0._targetWeaponList = {}

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._targetWeaponList) do
		iter_4_1:RemoveReloadFactor(arg_4_2)

		local var_4_0 = 1

		for iter_4_2, iter_4_3 in pairs((iter_4_1:GetReloadFactorList())) do
			var_4_0 = var_4_0 + iter_4_3
		end

		iter_4_1:FlushReloadMax(var_4_0)
	end

	return
end

function var_0_2.calcFactor(arg_5_0, arg_5_1)
	local var_5_0 = 0

	if arg_5_0._convertAttr == nil then
		-- block empty
	else
		var_5_0 = (arg_5_0._convertAttr == "HPRate" or arg_5_0._convertAttr == "DMGRate") and var_0_1.GetCurrent(arg_5_1, arg_5_0._convertAttr) * arg_5_0._convertValue or var_0_1.GetBase(arg_5_1, arg_5_0._convertAttr) * arg_5_0._convertValue
	end

	return arg_5_0._value + var_5_0
end

return
