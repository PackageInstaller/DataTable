NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local CoreVerificationChallengeResultWinViewMode3 = class("CoreVerificationChallengeResultWinViewMode3", NewBattleSettlementView)

function CoreVerificationChallengeResultWinViewMode3:UIName()
	return "Widget/System/Core_verification_new/Mode3/Core_verification_ResultWinUI03"
end

function CoreVerificationChallengeResultWinViewMode3:Init()
	self.super.Init(self)
end

function CoreVerificationChallengeResultWinViewMode3:OnEnter()
	self.super.OnEnter(self)
	self:RederScore()

	self.titleTxt_.text = GetI18NText(CoreVerificationClMode3Cfg[self.stageId].stage_name)
end

function CoreVerificationChallengeResultWinViewMode3:RederScore()
	local var_4_0 = CoreVerificationChallengeMode3Data:GetCommonStageByIndex(self.stageId)

	if var_4_0 then
		self.scoreText_.text = var_4_0.recently_normal_value or 0
	end
end

function CoreVerificationChallengeResultWinViewMode3:RenderTitleView()
	return
end

function CoreVerificationChallengeResultWinViewMode3:onRenderMissionContent()
	return
end

function CoreVerificationChallengeResultWinViewMode3:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData, false)
		end)
	end)
end

function CoreVerificationChallengeResultWinViewMode3:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return CoreVerificationChallengeResultWinViewMode3
