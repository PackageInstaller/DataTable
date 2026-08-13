ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleTargetChoise

class = var_0_10004

local var_0_4 = var_0_10004("BattleManualAAMissileUnit", var_0.Battle.BattleManualTorpedoUnit)

var_0.Battle.BattleManualAAMissileUnit = var_0_4
var_0_4.__name = "BattleManualAAMissileUnit"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	arg_1_0._strikeMode = nil
	arg_1_0._strikeModeData = nil

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

		pairs = var_8

		for iter_3_0, iter_3_1 in var_8(arg_2_0._strikeModeData) do
			var_3_11[iter_3_0] = iter_3_1
		end

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

		var_0.DispatchEvent(var_4_0, var_0.Event.New(var_0_2.MANUAL_WEAPON_FIRE, {}))

		arg_2_0._strikeModeData = nil

		return
	end

	arg_2_3 = arg_2_3 or var_0_4.EMITTER_NORMAL

	local var_2_2 = var_0.Battle[arg_2_3].New(var_2_0, var_2_1, arg_2_1)

	arg_2_0._majorEmitterList[#arg_2_0._majorEmitterList + 1] = var_2_2

	return var_2_2
end

function var_0_4.IsStrikeMode(arg_5_0)
	return arg_5_0._strikeMode
end

function var_0_4.IsAttacking(arg_6_0)
	return arg_6_0._currentState == var_0_4.STATE_ATTACK
end

function var_0_4.Update(arg_7_0)
	arg_7_0:UpdateReload()

	if arg_7_0:IsStrikeMode() then
		arg_7_0:MarkTarget()
	end

	return
end

function var_0_4.EnterStrikeMode(arg_8_0)
	arg_8_0._strikeMode = true
	arg_8_0._strikeModeData = {}
	arg_8_0._strikeModeData.fxName = arg_8_0._preCastInfo.fx

	arg_8_0:MarkTarget()

	return
end

function var_0_4.MarkTarget(arg_9_0)
	local var_9_0 = arg_9_0._strikeModeData.aimingTarget

	arg_9_0:updateMovementInfo()

	if var_9_0 == arg_9_0:Tracking() then
		return
	end

	local var_9_1 = var_0.Battle.BattleState.GetInstance()
	local var_9_2 = var_3.GetSceneMediator(var_9_1)

	if arg_9_0._strikeModeData.aimingTarget and arg_9_0._strikeModeData.aimingFX and var_9_2:GetCharacter(var_9_0:GetUniqueID()) then
		var_4:RemoveFX(arg_9_0._strikeModeData.aimingFX)
	end

	table = var_4

	var_4.clear(arg_9_0._strikeModeData)

	if not var_2 then
		return
	end

	local var_9_3 = var_9_2:GetCharacter(var_2:GetUniqueID())
	local var_9_4

	if arg_9_0._preCastInfo.fx and #arg_9_0._preCastInfo.fx > 0 then
		var_9_4 = var_9_3:AddFX(arg_9_0._preCastInfo.fx)
	end

	arg_9_0._strikeModeData.aimingTarget = var_2
	arg_9_0._strikeModeData.aimingFX = var_9_4

	return
end

function var_0_4.CancelStrikeMode(arg_10_0)
	if arg_10_0._strikeModeData.aimingTarget and arg_10_0._strikeModeData.aimingFX then
		local var_10_0 = var_0.Battle.BattleState.GetInstance()
		local var_10_1 = var_1.GetSceneMediator(var_10_0)
		local var_10_2 = var_1.GetCharacter
		local var_10_3 = arg_10_0._strikeModeData.aimingTarget

		if var_10_2(var_10_1, var_5.GetUniqueID(var_10_3)) then
			var_2:RemoveFX(arg_10_0._strikeModeData.aimingFX)
		end
	end

	arg_10_0._strikeMode = nil
	arg_10_0._strikeModeData = nil

	return
end

function var_0_4.Tracking(arg_11_0)
	return var_0_3.TargetWeightiest(arg_11_0, nil, arg_11_0:GetFilteredList())[1]
end

function var_0_4.Fire(arg_12_0)
	arg_12_0._strikeMode = nil

	var_0.Battle.BattleWeaponUnit.Fire(arg_12_0, arg_12_0._strikeModeData.aimingTarget)

	return true
end

function var_0_4.DoAttack(arg_13_0, arg_13_1, ...)
	if arg_13_1 == nil or not arg_13_1:IsAlive() or arg_13_0:outOfFireRange(arg_13_1) then
		arg_13_1 = nil

		if arg_13_0._strikeModeData.aimingTarget and arg_13_0._strikeModeData.aimingFX then
			local var_13_0 = var_0.Battle.BattleState.GetInstance()
			local var_13_1 = var_2.GetSceneMediator(var_13_0)
			local var_13_2 = var_2.GetCharacter
			local var_13_3 = arg_13_0._strikeModeData.aimingTarget

			if var_13_2(var_13_1, var_6.GetUniqueID(var_13_3)) then
				var_3:RemoveFX(arg_13_0._strikeModeData.aimingFX)
			end
		end

		arg_13_0._strikeModeData.aimingTarget = nil
		arg_13_0._strikeModeData.aimingFX = nil
	end

	var_0.Battle.BattleWeaponUnit.DoAttack(arg_13_0, arg_13_1, ...)

	return
end

function var_0_4.Prepar(arg_14_0)
	arg_14_0._currentState = arg_14_0.STATE_PRECAST

	arg_14_0:EnterStrikeMode()

	return
end

function var_0_4.Cancel(arg_15_0)
	arg_15_0._currentState = arg_15_0.STATE_READY

	arg_15_0:CancelStrikeMode()

	return
end

return
