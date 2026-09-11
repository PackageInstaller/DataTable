NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local CoreVerificationChallengeResultWinViewMode2 = class("CoreVerificationChallengeResultWinViewMode2", NewBattleSettlementView)

function CoreVerificationChallengeResultWinViewMode2:UIName()
	return "Widget/System/Core_verification_new/Mode2/Core_verification_ResultWinUI02"
end

function CoreVerificationChallengeResultWinViewMode2:Init()
	self.super.Init(self)
end

function CoreVerificationChallengeResultWinViewMode2:OnEnter()
	self.super.OnEnter(self)
	self:RederAffix()

	self.titleTxt_.text = GetI18NText(CoreVerificationClMode2Cfg[self.stageId].stage_name)
end

function CoreVerificationChallengeResultWinViewMode2:RederAffix()
	self.limitText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_3"), "+" .. CoreVerificationClMode2Cfg[self.stageId].cost_limit_up)
	self.useText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_1"), (CoreVerificationChallengeMode2Data:GetPostLimitNum()))
end

function CoreVerificationChallengeResultWinViewMode2:RenderTitleView()
	return
end

function CoreVerificationChallengeResultWinViewMode2:onRenderMissionContent()
	return
end

function CoreVerificationChallengeResultWinViewMode2:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData, false)
		end)
	end)
end

function CoreVerificationChallengeResultWinViewMode2:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return CoreVerificationChallengeResultWinViewMode2
