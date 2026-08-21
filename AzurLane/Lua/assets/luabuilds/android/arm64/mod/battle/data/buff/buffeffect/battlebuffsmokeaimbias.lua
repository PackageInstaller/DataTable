ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = ys.Battle.BattleAttr

ys.Battle.BattleBuffSmokeAimBias = class("BattleBuffSmokeAimBias", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffSmokeAimBias.__name = "BattleBuffSmokeAimBias"

local var_0_4 = ys.Battle.BattleBuffSmokeAimBias
local var_0_5 = ys.Battle.BattleAttr

ys.Battle.BattleBuffSmokeAimBias.ATTR_SMOKE = "smoke_aim_bias"

function ys.Battle.BattleBuffSmokeAimBias.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffSmokeAimBias.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.BattleBuffSmokeAimBias.onAttach(arg_3_0, arg_3_1, arg_3_2)
	var_0_5.SetCurrent(arg_3_1, var_0_4.ATTR_SMOKE, 1)
	var_0_1.AttachSmoke(arg_3_1)

	if BATTLE_ENEMY_AIMBIAS_RANGE then
		var_0_0.Battle.BattleDataProxy.GetInstance():DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleEvent.ADD_AIM_BIAS, {
			aimBias = arg_3_1:GetAimBias()
		}))
	end

	return
end

function ys.Battle.BattleBuffSmokeAimBias.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	for iter_4_0, iter_4_1 in pairs((var_0_0.Battle.BattleDataProxy.GetInstance():GetUnitList())) do
		local var_4_0 = iter_4_1:GetIFF()
		local var_4_1 = var_0_3.GetCurrent(iter_4_1, "aimBiasExtraACC")

		;({
			[var_0_2.FRIENDLY_CODE] = 0,
			[var_0_2.FOE_CODE] = 0
		})[var_4_0] = math.max(({
			[var_0_2.FRIENDLY_CODE] = 0,
			[var_0_2.FOE_CODE] = 0
		})[var_4_0], (var_0_3.GetCurrent(iter_4_1, "attackRating")))
		;({
			[var_0_2.FRIENDLY_CODE] = 0,
			[var_0_2.FOE_CODE] = 0
		})[var_4_0] = ({
			[var_0_2.FRIENDLY_CODE] = 0,
			[var_0_2.FOE_CODE] = 0
		})[var_4_0] + var_4_1
	end

	local var_4_2 = arg_4_1:GetAimBias()

	var_4_2:SetDecayFactor(({
		[var_0_2.FRIENDLY_CODE] = 0,
		[var_0_2.FOE_CODE] = 0
	})[var_0_2.FRIENDLY_CODE], ({
		[var_0_2.FRIENDLY_CODE] = 0,
		[var_0_2.FOE_CODE] = 0
	})[var_0_2.FRIENDLY_CODE])
	var_4_2:Update(arg_4_3.timeStamp)

	return
end

function ys.Battle.BattleBuffSmokeAimBias.onRemove(arg_5_0, arg_5_1, arg_5_2)
	if BATTLE_ENEMY_AIMBIAS_RANGE then
		var_0_0.Battle.BattleDataProxy.GetInstance():DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleEvent.REMOVE_AIM_BIAS, {
			aimBias = arg_5_1:GetAimBias()
		}))
	end

	var_0_5.SetCurrent(arg_5_1, var_0_4.ATTR_SMOKE, 0)
	arg_5_1:ExitSmokeArea()

	return
end

return
