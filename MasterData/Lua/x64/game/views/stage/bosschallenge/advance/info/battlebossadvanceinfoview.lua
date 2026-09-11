local BattleBossAdvanceInfoView = class("BattleBossAdvanceInfoView", (import("game.views.stage.bossChallenge.BattleBossInfoBaseView")))

function BattleBossAdvanceInfoView:UIName()
	return "Widget/System/Challenge_Boss/BossAdvanceInformationUI"
end

function BattleBossAdvanceInfoView:OnEnterExtend()
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")

	self.bossIndex_ = self.params_.bossIndex or BattleBossChallengeData:GetCacheSelectBossIndex()

	BattleBossChallengeData:SaveCacheSelectBossIndex(self.bossIndex_)
	manager.redPoint:bindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
end

function BattleBossAdvanceInfoView:OnExit()
	BattleBossAdvanceInfoView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
end

function BattleBossAdvanceInfoView:OnUpdate()
	BattleBossAdvanceInfoView.super.OnUpdate(self)
	self:RefreshResetBtn()
end

function BattleBossAdvanceInfoView:AddListeners()
	self:AddBtnListener(self.startBattleBtn_, nil, function()
		self:Go("/bossAdvanceTarget", {
			bossIndex = self.bossIndex_
		})
	end)
	self:AddBtnListener(self.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossAdvanceReward")
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetHardModeBoss(self.bossIndex_, function(arg_10_0)
					if isSuccess(arg_10_0.result) then
						self:RefreshData()
						self:RefreshUI()
					else
						ShowTips(arg_10_0.result)
					end
				end)
			end
		})
	end)
end

function BattleBossAdvanceInfoView:RefreshData()
	self.templateID_ = BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].templateID
	self.lockHeroGroup_ = BossTools.GetLockHero()
end

function BattleBossAdvanceInfoView:RefreshUI()
	BattleBossAdvanceInfoView.super.RefreshUI(self)

	self.pointText_.text = BattleBossChallengeAdvanceData:GetMaxPoint(self.bossIndex_)

	self:RefreshResetBtn()
end

function BattleBossAdvanceInfoView:RefreshResetBtn()
	if #BattleBossChallengeAdvanceData:GetReceiveRewardList() > 0 then
		SetActive(self.resetGo_, false)

		return
	end

	if BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].maxPoint > 0 then
		SetActive(self.resetGo_, true)
	else
		SetActive(self.resetGo_, false)
	end
end

return BattleBossAdvanceInfoView
