ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffAddBulletAttr = var_0_10002("BattleBuffAddBulletAttr", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffAddBulletAttr.__name = "BattleBuffAddBulletAttr"

local var_0_2 = var_0.Battle.BattleBuffAddBulletAttr

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._attr = arg_2_0._tempData.arg_list.attr
	arg_2_0._number = arg_2_0._tempData.arg_list.number

	local var_2_0

	if not arg_2_0._tempData.arg_list.rate then
		var_2_0 = 10000
	end

	arg_2_0._rate = var_2_0
	arg_2_0._bulletID = arg_2_0._tempData.arg_list.bulletID
	arg_2_0._weaponIndexList = arg_2_0._tempData.arg_list.index
	arg_2_0._numberBase = arg_2_0._number
	arg_2_0._displacementConvert = arg_2_0._tempData.arg_list.displacement_convert
	arg_2_0._displacementDynamic = arg_2_0._tempData.arg_list.displacement_convert_dynamic

	return
end

function var_0_2.onStack(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._number = arg_3_0._numberBase * arg_3_2._stack

	return
end

function var_0_2.onBulletCreate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0:equipIndexRequire(arg_4_3.equipIndex) then
		return
	end

	arg_4_0:calcBulletAttr(arg_4_3)

	return
end

function var_0_2.onInternalBulletCreate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0:equipIndexRequire(arg_5_3.equipIndex) then
		return
	end

	arg_5_0:calcBulletAttr(arg_5_3)

	return
end

function var_0_2.onManualBulletCreate(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0:equipIndexRequire(arg_6_3.equipIndex) then
		return
	end

	arg_6_0:calcBulletAttr(arg_6_3)

	return
end

function var_0_2.onBulletCollideBefore(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0:equipIndexRequire(arg_7_3.equipIndex) then
		return
	end

	arg_7_0:displacementConvert(arg_7_3, arg_7_1)
	arg_7_0:calcBulletAttr(arg_7_3)

	return
end

function var_0_2.onBombBulletBang(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:equipIndexRequire(arg_8_3.equipIndex) then
		return
	end

	arg_8_0:displacementConvert(arg_8_3, arg_8_1)
	arg_8_0:calcBulletAttr(arg_8_3)

	return
end

function var_0_2.onTorpedoBulletBang(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0:equipIndexRequire(arg_9_3.equipIndex) then
		return
	end

	arg_9_0:displacementConvert(arg_9_3, arg_9_1)
	arg_9_0:calcBulletAttr(arg_9_3)

	return
end

function var_0_2.displacementConvert(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1._bullet

	if arg_10_0._displacementConvert then
		local var_10_1 = var_10_0:GetCurrentDistance()
		local var_10_2 = arg_10_0._displacementConvert.base
		local var_10_3 = arg_10_0._displacementConvert.rate
		local var_10_4 = arg_10_0._displacementConvert.max

		if 0 < var_10_3 then
			math = var_8

			local var_10_5 = var_8.min

			math = var_1_10010
			arg_10_0._number = var_10_5(var_1_10010.max(var_10_1 - var_10_2, 0) * var_10_3, var_10_4)
		elseif var_10_3 < 0 then
			math = var_8

			local var_10_6 = var_8.min

			math = var_1_10010
			arg_10_0._number = var_10_6(var_1_10010.max(0, var_10_4 + (var_10_1 - var_10_2) * var_10_3), var_10_4)
		elseif var_10_3 == 0 then
			arg_10_0._number = 0
		end
	elseif arg_10_0._displacementDynamic then
		local var_10_7 = arg_10_0._displacementDynamic.check_caster
		local var_10_8 = arg_10_0._displacementDynamic.base
		local var_10_9 = arg_10_0._displacementDynamic.rate
		local var_10_10 = arg_10_0._displacementDynamic.max

		if arg_10_0:getTargetList(arg_10_2, var_10_7, arg_10_0._displacementDynamic) and #var_8 > 0 then
			local var_10_11 = var_8[1]
			local var_10_12 = var_9.GetPosition(var_10_11)
			local var_10_13 = var_10_0
			local var_10_14 = var_10_0.GetPosition(var_10_13)

			Vector3 = var_10_11

			local var_10_15 = var_10_11.Distance(var_10_12, var_10_14)

			math = var_10_13

			local var_10_16 = var_10_13.min

			math = var_14
			arg_10_0._number = var_10_16(var_14.max(var_10_15 - var_10_8, 0) * var_10_9, var_10_10)
		else
			arg_10_0._number = 0
		end
	end

	return
end

function var_0_2.calcBulletAttr(arg_11_0, arg_11_1)
	if var_0.Battle.BattleFormulas.IsHappen(arg_11_0._rate) then
		local var_11_0 = arg_11_1._bullet
		local var_11_1 = var_2.GetWeapon(var_11_0)
		local var_11_2 = var_3.GetEquipmentIndex(var_11_1)
		local var_11_3 = false

		if not arg_11_0._weaponIndexList then
			var_11_3 = true
		elseif #arg_11_0._weaponIndexList == 0 and var_11_2 == nil then
			var_11_3 = true
		else
			table = var_5

			if var_5.contains(arg_11_0._weaponIndexList, var_11_2) then
				var_11_3 = true
			end
		end

		if var_11_3 then
			if arg_11_0._bulletID then
				if var_2:GetTemplate().id == arg_11_0._bulletID then
					var_0.Battle.BattleAttr.Increase(var_2, arg_11_0._attr, arg_11_0._number)
				end
			else
				var_0.Battle.BattleAttr.Increase(var_2, arg_11_0._attr, arg_11_0._number)
			end
		end
	end

	return
end

return
