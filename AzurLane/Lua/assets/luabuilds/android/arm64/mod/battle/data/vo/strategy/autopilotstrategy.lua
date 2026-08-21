ys = ys or {}

local var_0_0 = ys

ys.Battle.AutoPilotStrategy = class("AutoPilotStrategy", ys.Battle.BattleJoyStickBotBaseStrategy)

local var_0_3 = ys.Battle.AutoPilotStrategy

ys.Battle.AutoPilotStrategy.__name = "AutoPilotStrategy"
ys.Battle.AutoPilotStrategy.FIX_FRONT = 0.5

function ys.Battle.AutoPilotStrategy.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._autoPilot = var_0_0.Battle.AutoPilot.New(arg_1_1:GetMotionReferenceUnit(), (var_0_0.Battle.BattleDataFunction.GetAITmpDataFromID((arg_1_1:GetAutoBotAIID()))))

	return
end

function ys.Battle.AutoPilotStrategy.GetStrategyType(arg_2_0)
	return var_0_0.Battle.BattleJoyStickAutoBot.AUTO_PILOT
end

function ys.Battle.AutoPilotStrategy.analysis(arg_3_0)
	local var_3_0 = arg_3_0._autoPilot:GetDirection()

	arg_3_0._hrz = var_3_0.x
	arg_3_0._vtc = var_3_0.z

	return
end

return
