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

function ys.Battle.BattleBuffDamageWall:SetArgs(arg_2_1, arg_2_2)
	var_0_1.super.SetArgs(self, arg_2_1, arg_2_2)
	self._wall:SetCldObjType(var_0_0.Battle.BattleWallData.CLD_OBJ_TYPE_SHIP)

	self._attr = setmetatable({}, {
		__index = arg_2_1._attr
	})
	self._atkAttrType = self._tempData.arg_list.attack_attribute
	self._damage = self._tempData.arg_list.damage
	self._forgeTmp = {
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
	self._forgeWeapon = {
		GetConvertedAtkAttr = function()
			return 0.01
		end,
		GetFixAmmo = function()
			return nil
		end
	}
	self._forgeWeaponTmp = {
		attack_attribute = self._atkAttrType
	}
	self._atkAttr = var_0_0.Battle.BattleAttr.GetAtkAttrByType(self._attr, self._atkAttrType)

	return
end

function ys.Battle.BattleBuffDamageWall:onWallCld(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if not table.contains(self._cldList, iter_5_1) then
			self._dataProxy:HandleWallDamage(self, iter_5_1)
			table.insert(self._cldList, iter_5_1)

			self._count = self._count - 1

			if self._count <= 0 then
				break
			end
		end
	end

	local var_5_0 = #self._cldList

	while var_5_0 > 0 do
		if not table.contains(arg_5_1, self._cldList[var_5_0]) then
			table.remove(self._cldList, var_5_0)
		end

		var_5_0 = var_5_0 - 1
	end

	if self._count <= 0 then
		self:Deactive()
	end

	return
end

function ys.Battle.BattleBuffDamageWall.GetDamageEnhance(arg_6_0)
	return 1
end

function ys.Battle.BattleBuffDamageWall:GetHost()
	return self._unit
end

function ys.Battle.BattleBuffDamageWall.GetWeaponHostAttr(arg_8_0)
	return var_0_0.Battle.BattleAttr.GetAttr(arg_8_0)
end

function ys.Battle.BattleBuffDamageWall:GetWeapon()
	return self._forgeWeapon
end

function ys.Battle.BattleBuffDamageWall:GetWeaponTempData()
	return self._forgeWeaponTmp
end

function ys.Battle.BattleBuffDamageWall:GetWeaponAtkAttr()
	return self._atkAttr
end

function ys.Battle.BattleBuffDamageWall:GetCorrectedDMG()
	return self._damage
end

function ys.Battle.BattleBuffDamageWall:GetTemplate()
	return self._forgeTmp
end

function ys.Battle.BattleBuffDamageWall.Clear(arg_14_0)
	arg_14_0._cldList = nil

	var_0_1.super.Clear(arg_14_0)

	return
end

return
