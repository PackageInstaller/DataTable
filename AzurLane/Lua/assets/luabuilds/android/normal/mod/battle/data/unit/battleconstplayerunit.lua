ys = var_0_10000

local var_0_0 = var_0_10000.Battle

class = var_0_10001

local var_0_1 = "BattleConstPlayerUnit"

ys = var_0_10003
var_0_0.BattleConstPlayerUnit = var_0_10001(var_0_1, var_0_10003.Battle.BattlePlayerUnit)
ys = var_0_0

local var_0_2 = var_0_0.Battle.BattleConstPlayerUnit

var_0_2.__name = "BattleConstPlayerUnit"
ys = var_0_2

local var_0_3 = var_0_2.Battle.BattleConstPlayerUnit

ys = var_1

local var_0_4 = var_1.Battle.BattleConst.EquipmentType

function var_0_3.setWeapon(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._tmpData.default_equip_list
	local var_1_1 = arg_1_0._tmpData.base_list

	arg_1_0._proficiencyList = {}

	for iter_1_0 = 1, #var_1_0 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_1_2 = arg_1_0._proficiencyList
		local var_1_3

		if not arg_1_0._tmpData.equipment_proficiency[iter_1_0] then
			var_1_3 = 1
		end

		var_1_10008(var_1_2, var_1_3)
	end

	local var_1_4 = arg_1_0._proficiencyList
	local var_1_5 = arg_1_0._tmpData.preload_count

	ipairs = var_6

	for iter_1_1, iter_1_2 in var_6(var_1_0) do
		Ship = var_1_10011

		if iter_1_1 <= var_1_10011.WEAPON_COUNT then
			var_1_10011 = var_1_4[iter_1_1]

			local var_1_6 = var_1_5[iter_1_1]

			local function var_1_7(arg_2_0, arg_2_1, arg_2_2)
				local var_2_0 = var_1_1[iter_1_1]

				for iter_2_0 = 1, var_2_0 do
					local var_2_1 = arg_1_0
					local var_2_2 = var_8.AddWeapon(var_2_1, arg_2_0, arg_2_1, arg_2_2, var_1_10011, iter_1_1)
					local var_2_3 = var_8.GetTemplateData(var_2_2).type

					if iter_2_0 <= var_1_6 and (var_2_3 == var_0_4.POINT_HIT_AND_LOCK or var_2_3 == var_0_4.MANUAL_TORPEDO or var_2_3 == var_0_4.DISPOSABLE_TORPEDO) then
						var_8:SetModifyInitialCD()
					end
				end

				return
			end

			local var_1_8

			if not arg_1_1[iter_1_1] then
				var_1_8 = var_1_0[iter_1_1]
			end

			var_1_7(var_1_8)
		end
	end

	local var_1_9 = #var_1_0
	local var_1_10 = arg_1_0._tmpData.fix_equip_list

	ipairs = var_8

	for iter_1_3, iter_1_4 in var_8(var_1_10) do
		if iter_1_4 and iter_1_4 ~= -1 then
			local var_1_11

			if not var_1_4[iter_1_3 + var_1_9] then
				var_1_11 = 1
			end

			arg_1_0:AddWeapon(iter_1_4, nil, nil, var_1_11, iter_1_3 + var_1_9)
		end
	end

	return
end

function var_0_3.IsAlive(arg_3_0)
	return true
end

function var_0_3.HideWaveFx(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.DispatchEvent

	ys = var_1_10003

	local var_4_2 = var_1_10003.Event.New

	ys = var_1_10004

	var_4_1(var_4_0, var_4_2(var_1_10004.Battle.BattleUnitEvent.HIDE_WAVE_FX))

	return
end

function var_0_3.UpdateHPAction(arg_5_0, arg_5_1, ...)
	var_0_3.super.UpdateHPAction(arg_5_0, arg_5_1, ...)

	if arg_5_1.dHP <= 0 then
		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.DispatchEvent

		ys = var_4

		local var_5_2 = var_4.Event.New

		ys = var_5

		var_5_1(var_5_0, var_5_2(var_5.Battle.BattleUnitEvent.ADD_BLINK, {
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
