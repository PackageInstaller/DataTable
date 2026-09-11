local GotoOsirisPlayGameStage = class("GotoOsirisPlayGameStage", BattleSettlementStrategyBase)

function GotoOsirisPlayGameStage:OnGotoSettlement(arg_1_1)
	self:GotoOsirisPlayGameFinalStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoOsirisPlayGameStage:GotoOsirisPlayGameFinalStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	BattleCallLuaCallBack = isSuccess(arg_2_1) and not isHalfWay_ and function()
		manager.story:RemovePlayer()
		OsirisPlayGameData:SetPassStageClearTimes(arg_2_2.id)
		gameContext:Go("/osirisPlayGameSettlementWinView", {
			multiple = 1,
			stageData = arg_2_2,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end or function()
		JumpTools.OpenPageByJump("/battlefailed", {
			stageData = arg_2_2,
			battleResult = arg_2_4,
			isHalfWay_ = self.tempData.isHalfWay_
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoOsirisPlayGameStage
