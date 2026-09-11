local CoreVerificationDoubleChallengeResultViewMode4 = class("CoreVerificationDoubleChallengeResultViewMode4", NewBattleSettlementView)

function CoreVerificationDoubleChallengeResultViewMode4:UIName()
	return "Widget/System/Core_verification_new/Mode4/Core_verification_ResultUI04"
end

function CoreVerificationDoubleChallengeResultViewMode4:Init()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:InitUI()
	self:AddListener()

	self.lockController = self.iconController_:GetController("lock")
end

function CoreVerificationDoubleChallengeResultViewMode4:AddListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		self:GoToBattleStatistics()
	end)
end

function CoreVerificationDoubleChallengeResultViewMode4:RenderScore()
	self.curScoreText_.text = CoreVerificationChallengeMode4Data:GetLastBattleScore()
	self.scoreText_.text = CoreVerificationChallengeMode4Data:GetCurPoint()
end

function CoreVerificationDoubleChallengeResultViewMode4:RenderTitleView()
	self.stageNameText_.text = GetI18NText(BattleStageTools.GetStageName(self.stageType, self.stageId)) or ""
	self.playerNameText_.text = PlayerData:GetPlayerInfo().nick

	self:RenderScore()

	local var_7_0 = CoreVerificationChallengeTools.GetIllustrated()

	if var_7_0 and #var_7_0 > 0 then
		local var_7_1 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_7_1 == 0 then
			self.lockController:SetSelectedIndex(1)
		else
			self.lockController:SetSelectedIndex(0)

			self.affixIcon_.spriteAsync = string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_7_1)
		end
	else
		self.lockController:SetSelectedIndex(1)
	end
end

function CoreVerificationDoubleChallengeResultViewMode4:onRenderMissionContent()
	return
end

function CoreVerificationDoubleChallengeResultViewMode4:RenderMaskBg()
	return
end

function CoreVerificationDoubleChallengeResultViewMode4:RefreshBottomBtn()
	return
end

function CoreVerificationDoubleChallengeResultViewMode4:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData, false)
		end)
	end)
end

return CoreVerificationDoubleChallengeResultViewMode4
