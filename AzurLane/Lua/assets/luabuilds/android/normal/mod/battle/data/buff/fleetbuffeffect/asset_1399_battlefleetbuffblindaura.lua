ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleFleetBuffBlindAura = var_0_10003("BattleFleetBuffBlindAura", var_0.Battle.BattleFleetBuffEffect)
var_0.Battle.BattleFleetBuffBlindAura.__name = "BattleFleetBuffBlindAura"

local var_0_3 = var_0.Battle.BattleFleetBuffBlindAura

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._tempData.arg_list.target
	local var_2_1 = arg_2_1:GetIFF()

	local function var_2_2(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.getTargetList(var_3_0, arg_2_1, var_2_0, arg_2_0._tempData.arg_list)

		ipairs = var_3_0

		for iter_3_0, iter_3_1 in var_3_0(arg_3_0) do
			if iter_3_1.Active then
				ipairs = var_7

				for iter_3_2, iter_3_3 in var_7(var_3_1) do
					if iter_3_3:GetUniqueID() == iter_3_1.UID then
						iter_3_3:SetBlindInvisible(true)

						break
					end
				end
			end
		end

		return
	end

	local function var_2_3(arg_4_0)
		if arg_4_0.Active then
			local var_4_0 = arg_2_0
			local var_4_1 = var_1.getTargetList(var_4_0, arg_2_1, var_2_0, arg_2_0._tempData.arg_list)

			ipairs = var_4_0

			for iter_4_0, iter_4_1 in var_4_0(var_4_1) do
				if iter_4_1:GetUniqueID() == arg_4_0.UID then
					iter_4_1:SetBlindInvisible(false)

					break
				end
			end
		end

		return
	end

	local var_2_4 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_2_5 = var_7.SpawnLastingCubeArea
	local var_2_6 = var_0_1.AOEField.SURFACE
	local var_2_7 = var_2_1

	Vector3 = var_1_10012
	arg_2_0._aura = var_2_5(var_2_4, var_2_6, var_2_7, var_1_10012(-55, 0, 55), 180, 70, 0, var_2_2, var_2_3, false)

	return
end

function var_0_3.Clear(arg_5_0)
	local var_5_0 = arg_5_0._aura

	var_1.SetActiveFlag(var_5_0, false)

	arg_5_0._aura = nil

	var_0_3.super.Clear(arg_5_0)

	return
end

return
