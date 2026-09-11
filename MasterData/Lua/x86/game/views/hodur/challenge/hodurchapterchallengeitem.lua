local HodurChapterChallengeItem = class("HodurChapterChallengeItem", ReduxView)

function HodurChapterChallengeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurChapterChallengeItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")
end

function HodurChapterChallengeItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if HodurTools.GetChapterState(self.chapterID_) == HodurConst.COMMON_STATE.LOCK then
			ShowTips(string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), ActivityHodurChapterCfg[ActivityHodurChapterCfg[self.chapterID_].previous_chapter].chapter_name))

			return
		end

		JumpTools.OpenPageByJump("/hodurChallengeView", {
			chapter_id = 4,
			activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function HodurChapterChallengeItem:SetData(arg_5_1)
	self.chapterID_ = arg_5_1
	self.unlockMode_ = false

	self:RefreshUI()
end

function HodurChapterChallengeItem:SetUnlockMode()
	self.unlockMode_ = true
end

function HodurChapterChallengeItem:PlayUnlockAnim()
	self.stateController_:SetSelectedState("lock")

	self.animator_.enabled = true

	self.animator_:Play("UI_itemChallenge_unlock_cx", 0, 0)

	self.aniTimer_ = Timer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self.stateController_:SetSelectedState("unlock")

			self.animator_.enabled = false
			self.unlockMode_ = false

			manager.ui:UIEventEnabled(true)

			if self.aniTimer_ then
				self.aniTimer_:Stop()

				self.aniTimer_ = nil
			end
		end
	end, 0.033, -1)

	self.aniTimer_:Start()
	manager.ui:UIEventEnabled(false)
end

function HodurChapterChallengeItem:RefreshUI()
	self.chapterNameText_.text = ActivityHodurChapterCfg[self.chapterID_].chapter_name

	if self.unlockMode_ or HodurTools.GetChapterState(self.chapterID_) == HodurConst.COMMON_STATE.LOCK then
		self.stateController_:SetSelectedState("lock")
	else
		self.stateController_:SetSelectedState("unlock")
	end

	self.scoreText_.text = HodurTools.GetChallengeMaxScore()
end

function HodurChapterChallengeItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	HodurChapterChallengeItem.super.Dispose(self)
end

return HodurChapterChallengeItem
