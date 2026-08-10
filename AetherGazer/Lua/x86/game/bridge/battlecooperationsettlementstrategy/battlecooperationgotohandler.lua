local var_0_0 = {}

BattleCooperationSettlementStrategyBase = require("game/bridge/BattleCooperationSettlementStrategy/BattleCooperationSettlementStrategyBase")
var_0_0.StrategyPathPrefix = "game/bridge/BattleCooperationSettlementStrategy/Impl/"
CooperationStageStrategyType = {
	GotoSnowBallStage = "GotoSnowBallStage",
	GotoCooperationStage = "GotoCooperationStage",
	GotoActivityWaterCooperationStage = "GotoActivityWaterCooperationStage",
	GotoStrongHoldStage = "GotoStrongHoldStage"
}
var_0_0.CustomStageStrategy = {
	[BattleConst.STAGE_TYPE_NEW.STRONGHOLD] = CooperationStageStrategyType.GotoStrongHoldStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION] = CooperationStageStrategyType.GotoActivityWaterCooperationStage,
	[BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS] = CooperationStageStrategyType.GotoSnowBallStage,
	[BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL] = CooperationStageStrategyType.GotoSnowBallStage
}

function var_0_0.Init(arg_1_0)
	arg_1_0.StrategyInstance = {}
end

function var_0_0.GetOrCreateGotoStageStartegy(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 or CooperationStageStrategyType.GotoCooperationStage

	if not CooperationStageStrategyType[arg_2_1] then
		var_2_0 = CooperationStageStrategyType.GotoCooperationStage
	end

	if not arg_2_0.StrategyInstance[var_2_0] then
		arg_2_0.StrategyInstance[var_2_0] = require(arg_2_0.StrategyPathPrefix .. var_2_0)

		if arg_2_0.StrategyInstance[var_2_0].Init then
			arg_2_0.StrategyInstance[var_2_0]:Init()
		end
	end

	return arg_2_0.StrategyInstance[var_2_0]
end

function var_0_0.GotoResult(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_1:GetType()
	local var_3_1 = CooperationStageStrategyType.GotoCooperationStage

	if var_3_0 then
		var_3_1 = arg_3_0.CustomStageStrategy[var_3_0] or CooperationStageStrategyType.GotoCooperationStage
	end

	arg_3_0:GetOrCreateGotoStageStartegy(var_3_1):GotoSettlement(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
end

return var_0_0
