ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffDamageWall = class("BattleBuffDamageWall", ys.Battle.BattleBuffShieldWall)
ys.Battle.BattleBuffDamageWall.__name = "BattleBuffDamageWall"

local var_0_1 = ys.Battle.BattleBuffDamageWall

function ys.Battle.BattleBuffDamageWall.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._cldList = {}

	return
end

function ys.Battle.BattleBuffDamageWall.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._wall:SetCldObjType(var_0_0.Battle.BattleWallData.CLD_OBJ_TYPE_SHIP)

	arg_2_0._attr = setmetatable({}, {
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
	arg_2_0._atkAttr = var_0_0.Battle.BattleAttr.GetAtkAttrByType(arg_2_0._attr, arg_2_0._atkAttrType)

	return
end

function ys.Battle.BattleBuffDamageWall.onWallCld(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if not table.contains(arg_5_0._cldList, iter_5_1) then
			arg_5_0._dataProxy:HandleWallDamage(arg_5_0, iter_5_1)
			table.insert(arg_5_0._cldList, iter_5_1)

			arg_5_0._count = arg_5_0._count - 1

			if arg_5_0._count <= 0 then
				break
			end
		end
	end

	local var_5_0 = #arg_5_0._cldList

	while var_5_0 > 0 do
		if not table.contains(arg_5_1, arg_5_0._cldList[var_5_0]) then
			table.remove(arg_5_0._cldList, var_5_0)
		end

		var_5_0 = var_5_0 - 1
	end

	if arg_5_0._count <= 0 then
		arg_5_0:Deactive()
	end

	return
end

function ys.Battle.BattleBuffDamageWall.GetDamageEnhance(arg_6_0)
	return 1
end

function ys.Battle.BattleBuffDamageWall.GetHost(arg_7_0)
	return arg_7_0._unit
end

function ys.Battle.BattleBuffDamageWall.GetWeaponHostAttr(arg_8_0)
	return var_0_0.Battle.BattleAttr.GetAttr(arg_8_0)
end

function ys.Battle.BattleBuffDamageWall.GetWeapon(arg_9_0)
	return arg_9_0._forgeWeapon
end

function ys.Battle.BattleBuffDamageWall.GetWeaponTempData(arg_10_0)
	return arg_10_0._forgeWeaponTmp
end

function ys.Battle.BattleBuffDamageWall.GetWeaponAtkAttr(arg_11_0)
	return arg_11_0._atkAttr
end

function ys.Battle.BattleBuffDamageWall.GetCorrectedDMG(arg_12_0)
	return arg_12_0._damage
end

function ys.Battle.BattleBuffDamageWall.GetTemplate(arg_13_0)
	return arg_13_0._forgeTmp
end

function ys.Battle.BattleBuffDamageWall.Clear(arg_14_0)
	arg_14_0._cldList = nil

	var_0_1.super.Clear(arg_14_0)

	return
end

return
