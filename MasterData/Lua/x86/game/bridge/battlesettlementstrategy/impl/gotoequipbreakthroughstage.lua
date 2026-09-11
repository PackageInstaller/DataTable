local GotoEquipBreakThroughStage = class("GotoEquipBreakThroughStage", BattleSettlementStrategyBase)

function GotoEquipBreakThroughStage:OnGotoSettlement(arg_1_1)
	self:GotoEquipBreakThroughStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoEquipBreakThroughStage:GotoEquipBreakThroughStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/equipBreakThroughResult", {
				result = arg_2_1,
				rewardList = var_2_0,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoEquipBreakThroughStage
