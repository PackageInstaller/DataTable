ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_4 = ys.Battle.BattleConst

ys.Battle.BattleSubUnit = class("BattleSubUnit", ys.Battle.BattlePlayerUnit)
ys.Battle.BattleSubUnit.__name = "BattleSubUnit"

local var_0_7 = ys.Battle.BattleSubUnit

function ys.Battle.BattleSubUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0_4.UnitType.PLAYER_UNIT

	return
end

function ys.Battle.BattleSubUnit:setWeapon(arg_2_1)
	local var_2_0 = self._tmpData.base_list
	local var_2_1 = self._proficiencyList
	local var_2_3 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_0 > Ship.WEAPON_COUNT and iter_2_1 then
			var_2_3 = var_2_3 + iter_2_1.torpedoAmmo
		end
	end

	local var_2_4 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
		if iter_2_3 and iter_2_3.skin and iter_2_3.skin ~= 0 and Equipment.IsOrbitSkin(iter_2_3.skin) then
			self._orbitSkinIDList = self._orbitSkinIDList or {}

			table.insert(self._orbitSkinIDList, iter_2_3.skin)
		end

		if iter_2_2 <= Ship.WEAPON_COUNT then
			local var_2_5 = self._proficiencyList[iter_2_2]

			local function var_2_6(arg_3_0, arg_3_1, arg_3_2)
				local var_3_0 = var_0_1.GetWeaponPropertyDataFromID(arg_3_0)

				if var_3_0.type == var_0_4.EquipmentType.TORPEDO then
					return var_3_0.torpedo_ammo
				else
					for iter_3_0 = 1, var_2_0[iter_2_2] do
						self:AddWeapon(arg_3_0, arg_3_1, arg_3_2, var_2_5, iter_2_2)
					end

					return false
				end

				return
			end

			if iter_2_3.equipment then
				for iter_2_4, iter_2_5 in ipairs(iter_2_3.equipment.weapon_id) do
					if iter_2_5 and iter_2_5 ~= -1 then
						local var_2_7 = var_2_6(iter_2_5, iter_2_3.equipment.label, iter_2_3.skin)

						if var_2_7 then
							table.insert(var_2_4, {
								id = iter_2_5,
								ammo = var_2_7,
								index = iter_2_2
							})
						end
					end
				end
			else
				local var_2_8 = self._tmpData.default_equip_list[iter_2_2]
				local var_2_9 = var_2_6(self._tmpData.default_equip_list[iter_2_2])

				if var_2_9 then
					table.insert(var_2_4, {
						id = var_2_8,
						ammo = var_2_9,
						index = iter_2_2
					})
				end
			end
		end
	end

	local function var_2_10(arg_4_0, arg_4_1)
		local var_4_0
		local var_4_1

		if arg_2_1[arg_4_1].equipment then
			var_4_0 = arg_2_1[arg_4_1].equipment.label
			var_4_1 = arg_2_1[arg_4_1].skin
		end

		self:AddDisposableTorpedo(arg_4_0, var_4_0, var_4_1, var_2_1[arg_4_1], arg_4_1):SetModifyInitialCD()

		return
	end

	repeat
		local var_2_11 = 0

		for iter_2_6, iter_2_7 in ipairs(var_2_4) do
			if iter_2_7.ammo <= 0 and var_2_3 > 0 then
				iter_2_7.ammo = iter_2_7.ammo + 1
				var_2_3 = var_2_3 - 1
			end

			if iter_2_7.ammo > 0 then
				var_2_10(iter_2_7.id, iter_2_7.index)

				iter_2_7.ammo = iter_2_7.ammo - 1
			end

			var_2_11 = var_2_11 + iter_2_7.ammo
		end
	until var_2_11 == 0 and var_2_3 == 0

	return
end

function ys.Battle.BattleSubUnit:AddDisposableTorpedo(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_5_1, self, arg_5_4, arg_5_5, var_0_4.EquipmentType.DISPOSABLE_TORPEDO)

	self._totalWeapon[#self._totalWeapon + 1] = var_5_0

	if arg_5_2 then
		var_5_0:SetEquipmentLabel(arg_5_2)
	end

	self._manualTorpedoList[#self._manualTorpedoList + 1] = var_5_0

	self._weaponQueue:AppendManualTorpedo(var_5_0)

	if arg_5_3 and arg_5_3 ~= 0 then
		var_5_0:SetSkinData(arg_5_3)
		self:SetPriorityWeaponSkin(arg_5_3)
	end

	return var_5_0
end

return
