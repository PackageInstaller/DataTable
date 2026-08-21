ys.Battle.BattleConstPlayerUnit = class("BattleConstPlayerUnit", ys.Battle.BattlePlayerUnit)
ys.Battle.BattleConstPlayerUnit.__name = "BattleConstPlayerUnit"

local var_0_0 = ys.Battle.BattleConstPlayerUnit
local var_0_1 = ys.Battle.BattleConst.EquipmentType

function ys.Battle.BattleConstPlayerUnit.setWeapon(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._tmpData.base_list

	arg_1_0._proficiencyList = {}

	for iter_1_0 = 1, #arg_1_0._tmpData.default_equip_list do
		local var_1_1 = arg_1_0._tmpData.equipment_proficiency[iter_1_0] or 1

		table.insert(arg_1_0._proficiencyList, var_1_1)
	end

	for iter_1_1, iter_1_2 in ipairs(arg_1_0._tmpData.default_equip_list) do
		if iter_1_1 <= Ship.WEAPON_COUNT then
			local var_1_2 = arg_1_0._proficiencyList[iter_1_1]
			local var_1_3 = arg_1_0._tmpData.preload_count[iter_1_1]
			local var_1_4 = arg_1_1[iter_1_1] or arg_1_0._tmpData.default_equip_list[iter_1_1]

			;(function(arg_2_0, arg_2_1, arg_2_2)
				for iter_2_0 = 1, var_1_0[iter_1_1] do
					local var_2_0 = arg_1_0:AddWeapon(arg_2_0, arg_2_1, arg_2_2, var_1_2, iter_1_1)
					local var_2_1 = var_2_0:GetTemplateData().type

					if iter_2_0 <= var_1_3 and (var_2_1 == var_0_1.POINT_HIT_AND_LOCK or var_2_1 == var_0_1.MANUAL_TORPEDO or var_2_1 == var_0_1.DISPOSABLE_TORPEDO) then
						var_2_0:SetModifyInitialCD()
					end
				end

				return
			end)(var_1_4)
		end
	end

	for iter_1_3, iter_1_4 in ipairs(arg_1_0._tmpData.fix_equip_list) do
		if iter_1_4 and iter_1_4 ~= -1 then
			local var_1_5 = arg_1_0._proficiencyList[iter_1_3 + #arg_1_0._tmpData.default_equip_list] or 1

			arg_1_0:AddWeapon(iter_1_4, nil, nil, var_1_5, iter_1_3 + #arg_1_0._tmpData.default_equip_list)
		end
	end

	return
end

function ys.Battle.BattleConstPlayerUnit.IsAlive(arg_3_0)
	return true
end

function ys.Battle.BattleConstPlayerUnit.HideWaveFx(arg_4_0)
	arg_4_0:DispatchEvent(ys.Event.New(ys.Battle.BattleUnitEvent.HIDE_WAVE_FX))

	return
end

function ys.Battle.BattleConstPlayerUnit.UpdateHPAction(arg_5_0, arg_5_1, ...)
	var_0_0.super.UpdateHPAction(arg_5_0, arg_5_1, ...)

	if arg_5_1.dHP <= 0 then
		arg_5_0:DispatchEvent(ys.Event.New(ys.Battle.BattleUnitEvent.ADD_BLINK, {
			blink = {
				blue = 1,
				peroid = 0.1,
				red = 1,
				green = 1,
				duration = 0.1
			}
		}))
	end

	return
end

return
