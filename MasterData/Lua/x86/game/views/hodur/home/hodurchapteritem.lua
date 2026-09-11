local HodurChapterItem = class("HodurChapterItem", ReduxView)

function HodurChapterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurChapterItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")

	for iter_2_0 = 1, 3 do
		self["starController_" .. iter_2_0] = self["starControllerEx_" .. iter_2_0]:GetController("star")
	end
end

function HodurChapterItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if HodurTools.GetChapterState(self.chapterID_) == HodurConst.COMMON_STATE.LOCK then
			ShowTips(string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), ActivityHodurChapterCfg[ActivityHodurChapterCfg[self.chapterID_].previous_chapter].chapter_name))

			return
		end

		JumpTools.OpenPageByJump("/hodurMainlineView", {
			chapter_id = self.chapterID_,
			activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function HodurChapterItem:SetData(arg_5_1)
	self.unlockMode_ = false
	self.chapterID_ = arg_5_1

	self:RefreshUI()
end

function HodurChapterItem:RefreshUI()
	if self.unlockMode_ or HodurTools.GetChapterState(self.chapterID_) == HodurConst.COMMON_STATE.LOCK then
		self.stateController_:SetSelectedState("lock")
	elseif HodurTools.GetChapterState(self.chapterID_) == HodurConst.COMMON_STATE.UNLOCK then
		self.stateController_:SetSelectedState("lock")
		self.stateController_:SetSelectedState("unlock")
	else
		self.stateController_:SetSelectedState("pass")
	end

	local var_6_0 = #ActivityHodurChapterCfg[self.chapterID_].stage_list
	local var_6_1 = HodurTools.GetChapterProgress(self.chapterID_)

	for iter_6_0 = 1, 3 do
		if iter_6_0 <= var_6_0 then
			SetActive(self["starGo_" .. iter_6_0], true)
		else
			SetActive(self["starGo_" .. iter_6_0], false)
		end
	end

	for iter_6_1 = 1, var_6_0 do
		if iter_6_1 <= var_6_1 then
			self["starController_" .. iter_6_1]:SetSelectedState("on")
		else
			self["starController_" .. iter_6_1]:SetSelectedState("off")
		end
	end

	self.chapterNameText_.text = ActivityHodurChapterCfg[self.chapterID_].chapter_name
end

function HodurChapterItem:SetUnlockMode()
	self.unlockMode_ = true
end

function HodurChapterItem:PlayUnlockAnim()
	self.stateController_:SetSelectedState("lock")

	self.animator_.enabled = true

	self.animator_:Play("UI_itemNormal01_unlock_cx", 0, 0)

	self.aniTimer_ = Timer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self.animator_.enabled = false

			self.stateController_:SetSelectedState("unlock")
			manager.ui:UIEventEnabled(true)

			self.unlockMode_ = false

			if self.aniTimer_ then
				self.aniTimer_:Stop()

				self.aniTimer_ = nil
			end
		end
	end, 0.033, -1)

	self.aniTimer_:Start()
	manager.ui:UIEventEnabled(false)
end

function HodurChapterItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	HodurChapterItem.super.Dispose(self)
end

return HodurChapterItem
