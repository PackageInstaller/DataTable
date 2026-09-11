local GotoMythicFinalStage = class("GotoMythicFinalStage", BattleSettlementStrategyBase)

function GotoMythicFinalStage:OnGotoSettlement(arg_1_1)
	self:GotoMythicFinalStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoMythicFinalStage:GotoMythicFinalStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	BattleCallLuaCallBack = isSuccess(arg_2_1) and not arg_2_5 and function()
		manager.story:RemovePlayer()
		gameContext:Go("/battleMythicFinalResultView", {
			multiple = 1,
			stageData = arg_2_2,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end or function()
		JumpTools.OpenPageByJump("/battleMythicOmegaFailedView", {
			stageData = arg_2_2,
			battleResult = arg_2_4,
			isHalfWay_ = self.tempData.isHalfWay_
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoMythicFinalStage
