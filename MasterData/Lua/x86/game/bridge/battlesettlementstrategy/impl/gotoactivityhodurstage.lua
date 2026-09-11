local GotoActivityHodurStage = class("GotoActivityHodurStage", BattleSettlementStrategyBase)

function GotoActivityHodurStage:OnGotoSettlement(arg_1_1)
	self:GotoHodurBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoActivityHodurStage:GotoHodurBattleStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	LuaHidTools.ForceSelectKeyboard(nil)

	if isSuccess(arg_2_1) then
		self:GotoHodurBattleSuccess(arg_2_4, arg_2_1, arg_2_2, arg_2_3)
	else
		self:GotoHodurBattleFailed(arg_2_1, arg_2_2)
	end
end

function GotoActivityHodurStage:GotoHodurBattleSuccess(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_1 == true then
		arg_3_2 = 3
	end

	if isSuccess(arg_3_2) then
		function BattleCallLuaCallBack()
			local var_4_0 = arg_3_3:GetStageId()
			local var_4_1 = arg_3_3:GetChapterID()

			if HodurTools.IsChallenge(var_4_1) then
				JumpTools.OpenPageByJump("/battleHodurResultChallengeView", {
					stageData = arg_3_3,
					battleResult = arg_3_4,
					chapterID = var_4_1
				})
			else
				JumpTools.OpenPageByJump("/battleHodurResultMainlineView", {
					stageData = arg_3_3,
					battleResult = arg_3_4,
					chapterID = var_4_1
				})
			end

			EndBattleLogic(arg_3_2)
		end
	end
end

function GotoActivityHodurStage:GotoHodurBattleFailed(arg_5_1, arg_5_2)
	function BattleCallLuaCallBack()
		local var_6_0 = arg_5_2:GetStageId()

		JumpTools.OpenPageByJump("/battlefailed", {
			stageData = arg_5_2
		})
		EndBattleLogic(arg_5_1)
	end
end

return GotoActivityHodurStage
