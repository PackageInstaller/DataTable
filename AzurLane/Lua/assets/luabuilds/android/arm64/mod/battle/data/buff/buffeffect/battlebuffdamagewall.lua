ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffDamageWall = var_0_10002("BattleBuffDamageWall", var_0.Battle.BattleBuffShieldWall)
var_0.Battle.BattleBuffDamageWall.__name = "BattleBuffDamageWall"

local var_0_2 = var_0.Battle.BattleBuffDamageWall

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._cldList = {}

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	var_0_2.super.SetArgs(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_0._wall

	var_3.SetCldObjType(var_2_0, var_0.Battle.BattleWallData.CLD_OBJ_TYPE_SHIP)

	setmetatable = var_3
	arg_2_0._attr = var_3({}, {
		__index = arg_2_1._attr
	})
	arg_2_0._atkAttrType = arg_2_0._tempData.arg_list.attack_attribute
	arg_2_0._damage = arg_2_0._tempData.arg_list.damage
	arg_2_0._forgeTmp = {
		ammo_type = 1,
		antisub_enhancement = 0,
		random_damage_rate = 0,
		damage_type = {
			1,
			1,
			1
		},
		DMG_font = {
			{
				2,
				1.2
			},
			{
				2,
				1.2
			},
			{
				2,
				1.2
			}
		},
		hit_type = {}
	}
	arg_2_0._forgeWeapon = {
		GetConvertedAtkAttr = function()
			return 0.01
		end,
		GetFixAmmo = function()
			return nil
		end
	}
	arg_2_0._forgeWeaponTmp = {
		attack_attribute = arg_2_0._atkAttrType
	}
	arg_2_0._atkAttr = var_0.Battle.BattleAttr.GetAtkAttrByType(arg_2_0._attr, arg_2_0._atkAttrType)

	return
end

function var_0_2.onWallCld(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1) do
		table = var_1_10007

		if not var_1_10007.contains(arg_5_0._cldList, iter_5_1) then
			local var_5_0 = arg_5_0._dataProxy

			var_1_10007.HandleWallDamage(var_5_0, arg_5_0, iter_5_1)

			table = var_1_10007

			var_1_10007.insert(arg_5_0._cldList, iter_5_1)

			arg_5_0._count = arg_5_0._count - 1

			if arg_5_0._count <= 0 then
				break
			end
		end
	end

	local var_5_1 = #arg_5_0._cldList

	while var_5_1 > 0 do
		local var_5_2 = arg_5_0._cldList[var_5_1]

		table = var_4

		if not var_4.contains(arg_5_1, var_5_2) then
			table = var_4

			var_4.remove(arg_5_0._cldList, var_5_1)
		end

		var_5_1 = var_5_1 - 1
	end

	if arg_5_0._count <= 0 then
		arg_5_0:Deactive()
	end

	return
end

function var_0_2.GetDamageEnhance(arg_6_0)
	return 1
end

function var_0_2.GetHost(arg_7_0)
	return arg_7_0._unit
end

function var_0_2.GetWeaponHostAttr(arg_8_0)
	return var_0.Battle.BattleAttr.GetAttr(arg_8_0)
end

function var_0_2.GetWeapon(arg_9_0)
	return arg_9_0._forgeWeapon
end

function var_0_2.GetWeaponTempData(arg_10_0)
	return arg_10_0._forgeWeaponTmp
end

function var_0_2.GetWeaponAtkAttr(arg_11_0)
	return arg_11_0._atkAttr
end

function var_0_2.GetCorrectedDMG(arg_12_0)
	return arg_12_0._damage
end

function var_0_2.GetTemplate(arg_13_0)
	return arg_13_0._forgeTmp
end

function var_0_2.Clear(arg_14_0)
	arg_14_0._cldList = nil

	var_0_2.super.Clear(arg_14_0)

	return
end

return
