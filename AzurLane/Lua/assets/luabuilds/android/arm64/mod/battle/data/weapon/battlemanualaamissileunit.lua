ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleTargetChoise
local var_0_3 = class("BattleManualAAMissileUnit", ys.Battle.BattleManualTorpedoUnit)

ys.Battle.BattleManualAAMissileUnit = var_0_3
var_0_3.__name = "BattleManualAAMissileUnit"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._strikeMode = nil
	arg_1_0._strikeModeData = nil

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

		for iter_3_0, iter_3_1 in pairs(arg_2_0._strikeModeData) do
			({})[iter_3_0] = iter_3_1
		end

		var_3_0:SetTrackingFXData({})
		arg_2_0:DispatchBulletEvent(var_3_0)

		return var_3_0
	end, function()
		for iter_4_0, iter_4_1 in ipairs(arg_2_0._majorEmitterList) do
			if iter_4_1:GetState() ~= iter_4_1.STATE_STOP then
				return
			end
		end

		arg_2_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_WEAPON_FIRE, {}))

		arg_2_0._strikeModeData = nil

		return
	end, arg_2_1)

	arg_2_0._majorEmitterList[#arg_2_0._majorEmitterList + 1] = var_2_0

	return var_2_0
end

function var_0_3.IsStrikeMode(arg_5_0)
	return arg_5_0._strikeMode
end

function var_0_3.IsAttacking(arg_6_0)
	return arg_6_0._currentState == var_0_3.STATE_ATTACK
end

function var_0_3.Update(arg_7_0)
	arg_7_0:UpdateReload()

	if arg_7_0:IsStrikeMode() then
		arg_7_0:MarkTarget()
	end

	return
end

function var_0_3.EnterStrikeMode(arg_8_0)
	arg_8_0._strikeMode = true
	arg_8_0._strikeModeData = {}
	arg_8_0._strikeModeData.fxName = arg_8_0._preCastInfo.fx

	arg_8_0:MarkTarget()

	return
end

function var_0_3.MarkTarget(arg_9_0)
	arg_9_0:updateMovementInfo()

	local var_9_0 = arg_9_0:Tracking()

	if arg_9_0._strikeModeData.aimingTarget == var_9_0 then
		return
	end

	local var_9_1 = var_0.Battle.BattleState.GetInstance():GetSceneMediator()

	if arg_9_0._strikeModeData.aimingTarget and arg_9_0._strikeModeData.aimingFX then
		local var_9_2 = var_9_1:GetCharacter(arg_9_0._strikeModeData.aimingTarget:GetUniqueID())

		if var_9_2 then
			var_9_2:RemoveFX(arg_9_0._strikeModeData.aimingFX)
		end
	end

	table.clear(arg_9_0._strikeModeData)

	if not var_9_0 then
		return
	end

	local var_9_3 = var_9_1:GetCharacter(var_9_0:GetUniqueID())
	local var_9_4

	if arg_9_0._preCastInfo.fx and #arg_9_0._preCastInfo.fx > 0 then
		var_9_4 = var_9_3:AddFX(arg_9_0._preCastInfo.fx)
	end

	arg_9_0._strikeModeData.aimingTarget = var_9_0
	arg_9_0._strikeModeData.aimingFX = var_9_4

	return
end

function var_0_3.CancelStrikeMode(arg_10_0)
	if arg_10_0._strikeModeData.aimingTarget and arg_10_0._strikeModeData.aimingFX then
		local var_10_0 = var_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(arg_10_0._strikeModeData.aimingTarget:GetUniqueID())

		if var_10_0 then
			var_10_0:RemoveFX(arg_10_0._strikeModeData.aimingFX)
		end
	end

	arg_10_0._strikeMode = nil
	arg_10_0._strikeModeData = nil

	return
end

function var_0_3.Tracking(arg_11_0)
	return var_0_2.TargetWeightiest(arg_11_0, nil, arg_11_0:GetFilteredList())[1]
end

function var_0_3.Fire(arg_12_0)
	arg_12_0._strikeMode = nil

	var_0.Battle.BattleWeaponUnit.Fire(arg_12_0, arg_12_0._strikeModeData.aimingTarget)

	return true
end

function var_0_3.DoAttack(arg_13_0, arg_13_1, ...)
	if arg_13_1 == nil or not arg_13_1:IsAlive() or arg_13_0:outOfFireRange(arg_13_1) then
		arg_13_1 = nil

		if arg_13_0._strikeModeData.aimingTarget and arg_13_0._strikeModeData.aimingFX then
			local var_13_0 = var_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(arg_13_0._strikeModeData.aimingTarget:GetUniqueID())

			if var_13_0 then
				var_13_0:RemoveFX(arg_13_0._strikeModeData.aimingFX)
			end
		end

		arg_13_0._strikeModeData.aimingTarget = nil
		arg_13_0._strikeModeData.aimingFX = nil
	end

	var_0.Battle.BattleWeaponUnit.DoAttack(arg_13_0, arg_13_1, ...)

	return
end

function var_0_3.Prepar(arg_14_0)
	arg_14_0._currentState = arg_14_0.STATE_PRECAST

	arg_14_0:EnterStrikeMode()

	return
end

function var_0_3.Cancel(arg_15_0)
	arg_15_0._currentState = arg_15_0.STATE_READY

	arg_15_0:CancelStrikeMode()

	return
end

return
