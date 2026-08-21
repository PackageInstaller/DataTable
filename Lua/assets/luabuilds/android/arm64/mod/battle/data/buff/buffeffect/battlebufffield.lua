ys = ys or {}

local var_0_0 = ys
local var_0_1 = class("BattleBuffField", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffField = var_0_1
var_0_1.__name = "BattleBuffField"

local var_0_2 = ys.Battle.BattleConst

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._level = arg_2_2:GetLv()
	arg_2_0._caster = arg_2_2:GetCaster()
	arg_2_0._auraBuffID = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._target = arg_2_0._tempData.arg_list.target
	arg_2_0._check_target = arg_2_0._tempData.arg_list.check_target or "TargetNull"
	arg_2_0._isUpdateAura = arg_2_0._tempData.arg_list.FAura

	local var_2_0 = true
	local var_2_1 = type(arg_2_0._target)

	if var_2_1 == "string" and arg_2_0._target == "TargetAllHarm" or var_2_1 == "table" and table.contains(arg_2_0._target, "TargetAllHarm") or var_2_1 == "string" and arg_2_0._target == "TargetAllFoe" or var_2_1 == "table" and table.contains(arg_2_0._target, "TargetAllFoe") then
		var_2_0 = false
	end

	local function var_2_2(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1.Active then
				for iter_3_2, iter_3_3 in ipairs((arg_2_0:getTargetList(arg_2_1, arg_2_0._target, arg_2_0._tempData.arg_list))) do
					if iter_3_3:GetUniqueID() == iter_3_1.UID then
						iter_3_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(arg_2_0._auraBuffID, arg_2_0._level, arg_2_0._caster)))

						break
					end
				end
			end
		end

		return
	end

	local function var_2_3(arg_4_0)
		if arg_4_0.Active then
			for iter_4_0, iter_4_1 in ipairs((arg_2_0:getTargetList(arg_2_1, arg_2_0._target, arg_2_0._tempData.arg_list))) do
				if iter_4_1:GetUniqueID() == arg_4_0.UID then
					iter_4_1:RemoveBuff(arg_2_0._auraBuffID)

					break
				end
			end
		end

		return
	end

	local var_2_4 = arg_2_0._isUpdateAura and var_2_3 or nil
	local var_2_5 = not not arg_2_0._isUpdateAura
	local var_2_6 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_2_7, var_2_8, var_2_9, var_2_10 = var_2_6:GetFieldBound()

	arg_2_0._aura = var_2_6:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, arg_2_1:GetIFF(), Vector3((var_2_9 + var_2_10) * 0.5, 0, (var_2_7 + var_2_8) * 0.5), math.abs(var_2_10 - var_2_9), math.abs(var_2_7 - var_2_8), 0, var_2_2, var_2_3, var_2_0, nil, var_2_4, var_2_5)

	return
end

function var_0_1.Clear(arg_5_0)
	arg_5_0._aura:SetActiveFlag(false)

	arg_5_0._aura = nil

	var_0_1.super.Clear(arg_5_0)

	return
end

return
