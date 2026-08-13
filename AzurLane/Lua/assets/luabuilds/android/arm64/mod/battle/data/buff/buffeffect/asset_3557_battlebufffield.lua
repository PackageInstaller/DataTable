ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffField", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffField = var_0_1
var_0_1.__name = "BattleBuffField"

local var_0_2 = var_0.Battle.BattleConst

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._level = arg_2_2:GetLv()

	local var_2_0 = arg_2_2

	arg_2_0._caster = arg_2_2.GetCaster(var_2_0)
	arg_2_0._auraBuffID = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._target = var_3.target

	local var_2_1

	if not var_3.check_target then
		var_2_1 = "TargetNull"
	end

	arg_2_0._check_target = var_2_1
	arg_2_0._isUpdateAura = var_3.FAura

	local var_2_2 = true

	type = var_2_0

	if var_2_0(arg_2_0._target) ~= "string" or arg_2_0._target ~= "TargetAllHarm" then
		if var_5 == "table" then
			table = var_1_10006

			if not var_1_10006.contains(arg_2_0._target, "TargetAllHarm") then
				if var_5 ~= "string" or arg_2_0._target ~= "TargetAllFoe" then
					if var_5 == "table" then
						table = var_1_10006

						if var_1_10006.contains(arg_2_0._target, "TargetAllFoe") then
							var_2_2 = false
						end
					end

					local function var_2_3(arg_3_0)
						ipairs = var_2_10001

						for iter_3_0, iter_3_1 in var_2_10001(arg_3_0) do
							if iter_3_1.Active then
								local var_3_0 = arg_2_0
								local var_3_1 = var_6.getTargetList(var_3_0, arg_2_1, arg_2_0._target, arg_2_0._tempData.arg_list)

								ipairs = var_2_10007

								for iter_3_2, iter_3_3 in var_2_10007(var_3_1) do
									if iter_3_3:GetUniqueID() == iter_3_1.UID then
										local var_3_2 = var_0.Battle.BattleBuffUnit.New(arg_2_0._auraBuffID, arg_2_0._level, arg_2_0._caster)

										iter_3_3:AddBuff(var_3_2)

										break
									end
								end
							end
						end

						return
					end

					local function var_2_4(arg_4_0)
						if arg_4_0.Active then
							local var_4_0 = arg_2_0
							local var_4_1 = var_1.getTargetList(var_4_0, arg_2_1, arg_2_0._target, arg_2_0._tempData.arg_list)

							ipairs = var_2_10002

							for iter_4_0, iter_4_1 in var_2_10002(var_4_1) do
								if iter_4_1:GetUniqueID() == arg_4_0.UID then
									iter_4_1:RemoveBuff(arg_2_0._auraBuffID)

									break
								end
							end
						end

						return
					end

					local var_2_5 = arg_2_0._isUpdateAura and var_2_4 or nil
					local var_2_6 = arg_2_0._isUpdateAura and true or false
					local var_2_7 = var_0.Battle.BattleDataProxy.GetInstance()
					local var_2_8, var_2_9, var_2_10, var_2_11 = var_10.GetFieldBound(var_2_7)

					Vector3 = var_1_10015

					local var_2_12 = var_1_10015((var_2_10 + var_2_11) * 0.5, 0, (var_2_8 + var_2_9) * 0.5)

					math = var_1_10016

					local var_2_13 = var_1_10016.abs(var_2_11 - var_2_10)

					math = var_17

					local var_2_14 = var_17.abs(var_2_8 - var_2_9)

					arg_2_0._aura = var_10:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, arg_2_1:GetIFF(), var_2_12, var_2_13, var_2_14, 0, var_2_3, var_2_4, var_2_2, nil, var_2_5, var_2_6)

					return
				end
			end
		end
	end
end

function var_0_1.Clear(arg_5_0)
	local var_5_0 = arg_5_0._aura

	var_1.SetActiveFlag(var_5_0, false)

	arg_5_0._aura = nil

	var_0_1.super.Clear(arg_5_0)

	return
end

return
