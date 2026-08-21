ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_4 = ys.Battle.BattleConfig

ys.Battle.BattleSupportUnit = class("BattleSupportUnit", ys.Battle.BattlePlayerUnit)
ys.Battle.BattleSupportUnit.__name = "BattleSupportUnit"

local var_0_5 = ys.Battle.BattleSupportUnit

function ys.Battle.BattleSupportUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_5.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0.UnitType.SUPPORT_UNIT

	return
end

function ys.Battle.BattleSupportUnit.setWeapon(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tmpData.base_list

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1 and iter_2_1.skin and iter_2_1.skin ~= 0 and Equipment.IsOrbitSkin(iter_2_1.skin) then
			arg_2_0._orbitSkinIDList = arg_2_0._orbitSkinIDList or {}

			table.insert(arg_2_0._orbitSkinIDList, iter_2_1.skin)
		end

		if iter_2_0 <= Ship.WEAPON_COUNT then
			local var_2_1 = arg_2_0._proficiencyList[iter_2_0]

			if iter_2_1.equipment and #iter_2_1.equipment.weapon_id > 0 then
				if iter_2_1.equipment.type ~= EquipType.FighterAircraft then
					if iter_2_1.equipment.type == EquipType.SubmarineTorpedo then
						for iter_2_2, iter_2_3 in ipairs(iter_2_1.equipment.weapon_id) do
							local var_2_3 = var_0_4.EQUIPMENT_ACTIVE_LIMITED_BY_TYPE[var_0_0.GetWeaponPropertyDataFromID(iter_2_3).type]

							if (not var_2_3 or table.contains(var_2_3, arg_2_0._tmpData.type)) and iter_2_3 and iter_2_3 ~= -1 then
								(function(arg_3_0, arg_3_1, arg_3_2)
									local var_3_0 = var_0_0.GetWeaponPropertyDataFromID(arg_3_0).type

									if var_3_0 ~= var_0.EquipmentType.INTERCEPT_AIRCRAFT then
										if var_3_0 == var_0.EquipmentType.TORPEDO then
											for iter_3_0 = 1, var_2_0[iter_2_0] do
												local var_3_1 = arg_2_0:AddWeapon(arg_3_0, arg_3_1, arg_3_2, var_2_1, iter_2_0)
												local var_3_2 = var_3_1:GetTemplateData().type

												if iter_2_1.equipment then
													var_3_1:SetSrcEquipmentID(iter_2_1.equipment.id)
												end
											end
										end

										return
									end
								end)(iter_2_3, iter_2_1.equipment.label, iter_2_1.skin)
							end
						end

						goto label_2_0

						local var_2_4 = arg_2_0._tmpData.default_equip_list[iter_2_0]
						local var_2_5 = var_0_0.GetWeaponDataFromID(arg_2_0._tmpData.default_equip_list[iter_2_0])

						if var_2_5.type == EquipType.FighterAircraft or var_2_5.type == EquipType.SubmarineTorpedo then
							(function(arg_3_0, arg_3_1, arg_3_2)
								local var_3_0 = var_0_0.GetWeaponPropertyDataFromID(arg_3_0).type

								if var_3_0 ~= var_0.EquipmentType.INTERCEPT_AIRCRAFT then
									if var_3_0 == var_0.EquipmentType.TORPEDO then
										for iter_3_0 = 1, var_2_0[iter_2_0] do
											local var_3_1 = arg_2_0:AddWeapon(arg_3_0, arg_3_1, arg_3_2, var_2_1, iter_2_0)
											local var_3_2 = var_3_1:GetTemplateData().type

											if iter_2_1.equipment then
												var_3_1:SetSrcEquipmentID(iter_2_1.equipment.id)
											end
										end
									end

									return
								end
							end)(var_2_4, var_2_5.label)
						end
					end

					::label_2_0::
				end
			end
		end
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_0._tmpData.fix_equip_list) do
		if iter_2_5 and iter_2_5 ~= -1 then
			local var_2_6 = var_0_0.GetWeaponPropertyDataFromID(iter_2_5).type

			if var_2_6 == var_0.EquipmentType.INTERCEPT_AIRCRAFT or var_2_6 == var_0.EquipmentType.TORPEDO then
				arg_2_0:AddWeapon(iter_2_5, nil, nil, var_2_7, iter_2_4 + #arg_2_0._tmpData.default_equip_list):SetFixedFlag()
			end
		end
	end

	return
end

function ys.Battle.BattleSupportUnit.AddWeapon(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = var_0_0.CreateWeaponUnit(arg_4_1, arg_4_0, arg_4_4, arg_4_5)

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
