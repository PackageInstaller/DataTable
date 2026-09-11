NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local CoreVerificationChallengeResultWinViewMode4 = class("CoreVerificationChallengeResultWinViewMode4", NewBattleSettlementView)

function CoreVerificationChallengeResultWinViewMode4:UIName()
	return "Widget/System/Core_verification_new/Mode4/Core_verification_ResultWinUI04"
end

function CoreVerificationChallengeResultWinViewMode4:Init()
	self.super.Init(self)
end

function CoreVerificationChallengeResultWinViewMode4:OnEnter()
	self.super.OnEnter(self)
	self:RenderScore()

	self.titleTxt_.text = GetI18NText(CoreVerificationClMode4Cfg[self.stageId].stage_name)
end

function CoreVerificationChallengeResultWinViewMode4:RenderScore()
	self.scoreText_.text = CoreVerificationChallengeMode4Data:GetLastBattleScore()
end

function CoreVerificationChallengeResultWinViewMode4:RenderTitleView()
	self.titleTxt_.text = GetI18NText(BattleStageTools.GetStageName(self.stageType, self.stageId)) or ""
end

function CoreVerificationChallengeResultWinViewMode4:onRenderMissionContent()
	return
end

function CoreVerificationChallengeResultWinViewMode4:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData, false)
		end)
	end)
end

function CoreVerificationChallengeResultWinViewMode4:Dispose()
	self.super.Dispose(self)
end

return CoreVerificationChallengeResultWinViewMode4
