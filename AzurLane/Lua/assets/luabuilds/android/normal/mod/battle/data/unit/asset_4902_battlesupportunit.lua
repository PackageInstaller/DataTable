ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleAttr
local var_0_4 = var_0.Battle.BattleConst.EquipmentType
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle

class = var_0_10008
var_0_6.BattleSupportUnit = var_0_10008("BattleSupportUnit", var_0.Battle.BattlePlayerUnit)
var_0.Battle.BattleSupportUnit.__name = "BattleSupportUnit"

local var_0_7 = var_0.Battle.BattleSupportUnit

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0.UnitType.SUPPORT_UNIT

	return
end

function var_0_7.setWeapon(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tmpData.default_equip_list
	local var_2_1 = arg_2_0._tmpData.base_list
	local var_2_2 = arg_2_0._proficiencyList
	local var_2_3 = arg_2_0._tmpData.preload_count

	ipairs = var_1_10006

	for iter_2_0, iter_2_1 in var_1_10006(arg_2_1) do
		if iter_2_1 and iter_2_1.skin and iter_2_1.skin ~= 0 then
			Equipment = var_1_10011

			if var_1_10011.IsOrbitSkin(iter_2_1.skin) then
				if not arg_2_0._orbitSkinIDList then
					var_1_10011 = {}
				end

				arg_2_0._orbitSkinIDList = var_1_10011
				table = var_1_10011

				var_1_10011.insert(arg_2_0._orbitSkinIDList, iter_2_1.skin)
			end
		end

		Ship = var_1_10011

		if iter_2_0 <= var_1_10011.WEAPON_COUNT then
			var_1_10011 = var_2_2[iter_2_0]

			local var_2_4 = var_2_3[iter_2_0]

			local function var_2_5(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.GetWeaponPropertyDataFromID(arg_3_0).type == var_0.EquipmentType.INTERCEPT_AIRCRAFT or var_3 == var_0.EquipmentType.TORPEDO then
					local var_3_0 = var_2_1[iter_2_0]

					for iter_3_0 = 1, var_3_0 do
						local var_3_1 = arg_2_0
						local var_3_2 = var_9.AddWeapon(var_3_1, arg_3_0, arg_3_1, arg_3_2, var_1_10011, iter_2_0)
						local var_3_3 = var_9.GetTemplateData(var_3_2).type

						if iter_2_1.equipment then
							var_9:SetSrcEquipmentID(iter_2_1.equipment.id)
						end
					end
				end

				return
			end

			if iter_2_1.equipment then
				local var_2_6 = #iter_2_1.equipment.weapon_id

				if 0 < var_2_6 then
					local var_2_7 = iter_2_1.equipment.type

					EquipType = var_15

					if var_2_7 ~= var_15.FighterAircraft then
						local var_2_8 = iter_2_1.equipment.type

						EquipType = var_15

						if var_2_8 == var_15.SubmarineTorpedo then
							local var_2_9 = iter_2_1.equipment.weapon_id

							ipairs = var_15

							for iter_2_2, iter_2_3 in var_15(var_2_9) do
								local var_2_10 = var_0_1.GetWeaponPropertyDataFromID(iter_2_3).type

								if var_0_5.EQUIPMENT_ACTIVE_LIMITED_BY_TYPE[var_2_10] then
									table = var_1_10022

									if var_1_10022.contains(var_21, arg_2_0._tmpData.type) then
										if iter_2_3 and iter_2_3 ~= -1 then
											var_2_5(iter_2_3, iter_2_1.equipment.label, iter_2_1.skin)
										end
									end
								end
							end

							goto label_2_0

							local var_2_11 = var_2_0[iter_2_0]
							local var_2_12 = var_0_1.GetWeaponDataFromID(var_2_11).type

							EquipType = var_1_10017

							if var_2_12 ~= var_1_10017.FighterAircraft then
								do
									local var_2_13 = var_15.type

									EquipType = var_1_10017

									if var_2_13 == var_1_10017.SubmarineTorpedo then
										var_2_5(var_2_11, var_15.label)
									end
								end

								::label_2_0::
							end
						end
					end
				end
			end
		end
	end

	local var_2_14 = #var_2_0
	local var_2_15 = arg_2_0._tmpData.fix_equip_list

	ipairs = var_8

	for iter_2_4, iter_2_5 in var_8(var_2_15) do
		if iter_2_5 and iter_2_5 ~= -1 and (var_0_1.GetWeaponPropertyDataFromID(iter_2_5).type == var_0.EquipmentType.INTERCEPT_AIRCRAFT or var_13 == var_0.EquipmentType.TORPEDO) then
			local var_2_16

			if not var_2_2[iter_2_4 + var_2_14] then
				var_2_16 = 1
			end

			local var_2_17 = arg_2_0:AddWeapon(iter_2_5, nil, nil, var_2_16, iter_2_4 + var_2_14)

			var_15.SetFixedFlag(var_2_17)
		end
	end

	return
end

function var_0_7.AddWeapon(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = var_0_1.CreateWeaponUnit(arg_4_1, arg_4_0, arg_4_4, arg_4_5)

	arg_4_0._totalWeapon[#arg_4_0._totalWeapon + 1] = var_4_0

	if arg_4_2 then
		var_4_0:SetEquipmentLabel(arg_4_2)
	end

	var_4_0:SetSupportWeapon()
	arg_4_0:AddAutoWeapon(var_4_0)

	if arg_4_3 and arg_4_3 ~= 0 then
		var_4_0:SetSkinData(arg_4_3)
		arg_4_0:SetPriorityWeaponSkin(arg_4_3)
	end

	return var_4_0
end

return
