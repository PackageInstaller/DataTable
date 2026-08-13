ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleTargetChoise

class = var_0_10004

local var_0_4 = var_0_10004("BattleAutoMissileUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleAutoMissileUnit = var_0_4
var_0_4.__name = "BattleAutoMissileUnit"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.createMajorEmitter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = arg_2_0._emitBulletIDList[arg_2_2]
		local var_3_1 = arg_2_0
		local var_3_2 = var_6.Spawn(var_3_1, var_3_0, arg_3_4, var_0_4.INTERNAL)

		var_6.SetOffsetPriority(var_3_2, arg_3_3)
		var_6:SetShiftInfo(arg_3_0, arg_3_1)

		if arg_2_0._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_3_4 ~= nil then
			local var_3_3 = var_6
			local var_3_4 = var_6.SetRotateInfo
			local var_3_5 = arg_3_4:GetBeenAimedPosition()
			local var_3_6 = arg_2_0

			var_3_4(var_3_3, var_3_5, var_11.GetBaseAngle(var_3_6), arg_3_2)
		else
			local var_3_7 = var_6
			local var_3_8 = var_6.SetRotateInfo
			local var_3_9
			local var_3_10 = arg_2_0

			var_3_8(var_3_7, var_3_9, var_11.GetBaseAngle(var_3_10), arg_3_2)
		end

		var_6:setTrackingTarget(arg_3_4)

		local var_3_11 = {}

		var_6:SetTrackingFXData(var_3_11)

		local var_3_12 = arg_2_0

		var_8.DispatchBulletEvent(var_3_12, var_6)

		return var_6
	end

	local function var_2_1()
		ipairs = var_2_10000

		for iter_4_0, iter_4_1 in var_2_10000(arg_2_0._majorEmitterList) do
			if iter_4_1:GetState() ~= iter_4_1.STATE_STOP then
				return
			end
		end

		local var_4_0 = arg_2_0

		var_0.EnterCoolDown(var_4_0)

		return
	end

	arg_2_3 = arg_2_3 or var_0_4.EMITTER_NORMAL

	local var_2_2 = var_0.Battle[arg_2_3].New(var_2_0, var_2_1, arg_2_1)

	arg_2_0._majorEmitterList[#arg_2_0._majorEmitterList + 1] = var_2_2

	return var_2_2
end

function var_0_4.Tracking(arg_5_0)
	return var_0_3.TargetWeightiest(arg_5_0, nil, arg_5_0:GetFilteredList())[1]
end

return
