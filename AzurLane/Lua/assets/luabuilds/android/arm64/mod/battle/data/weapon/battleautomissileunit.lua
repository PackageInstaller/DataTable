ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleTargetChoise
local var_0_3 = class("BattleAutoMissileUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleAutoMissileUnit = var_0_3
var_0_3.__name = "BattleAutoMissileUnit"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.createMajorEmitter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_3 = arg_2_3 or var_0_3.EMITTER_NORMAL

	local var_2_0 = var_0.Battle[arg_2_3].New(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = arg_2_0:Spawn(arg_2_0._emitBulletIDList[arg_2_2], arg_3_4, var_0_3.INTERNAL)

		var_3_0:SetOffsetPriority(arg_3_3)
		var_3_0:SetShiftInfo(arg_3_0, arg_3_1)

		if arg_2_0._tmpData.aim_type == var_0_0.WeaponAimType.AIM and arg_3_4 ~= nil then
			var_3_0:SetRotateInfo(arg_3_4:GetBeenAimedPosition(), arg_2_0:GetBaseAngle(), arg_3_2)
		else
			var_3_0:SetRotateInfo(nil, arg_2_0:GetBaseAngle(), arg_3_2)
		end

		var_3_0:setTrackingTarget(arg_3_4)
		var_3_0:SetTrackingFXData({})
		arg_2_0:DispatchBulletEvent(var_3_0)

		return var_3_0
	end, function()
		for iter_4_0, iter_4_1 in ipairs(arg_2_0._majorEmitterList) do
			if iter_4_1:GetState() ~= iter_4_1.STATE_STOP then
				return
			end
		end

		arg_2_0:EnterCoolDown()

		return
	end, arg_2_1)

	arg_2_0._majorEmitterList[#arg_2_0._majorEmitterList + 1] = var_2_0

	return var_2_0
end

function var_0_3.Tracking(arg_5_0)
	return var_0_2.TargetWeightiest(arg_5_0, nil, arg_5_0:GetFilteredList())[1]
end

return
