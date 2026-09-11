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

function var_0_0:GetOrCreateGotoStageStartegy(arg_2_1)
	local var_2_0 = arg_2_1 or CooperationStageStrategyType.GotoCooperationStage

	if not CooperationStageStrategyType[arg_2_1] then
		var_2_0 = CooperationStageStrategyType.GotoCooperationStage
	end

	if not self.StrategyInstance[var_2_0] then
		self.StrategyInstance[var_2_0] = require(self.StrategyPathPrefix .. var_2_0)

		if self.StrategyInstance[var_2_0].Init then
			self.StrategyInstance[var_2_0]:Init()
		end
	end

	return self.StrategyInstance[var_2_0]
end

function var_0_0:GotoResult(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_1:GetType()

	self:GetOrCreateGotoStageStartegy((var_3_0 or nil) and (self.CustomStageStrategy[var_3_0] or CooperationStageStrategyType.GotoCooperationStage)):GotoSettlement(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
end

return var_0_0
