local ActivityAutoCookLevelView = class("ActivityAutoCookLevelView", ReduxView)

function ActivityAutoCookLevelView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteenUI/SandPlay_Com_IdleCanteenSelectStageUI"
end

function ActivityAutoCookLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityAutoCookLevelView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityAutoCookLevelView:InitUI()
	self:BindCfgUI()

	self.stageFinishController1_ = self.stageControllerEx1_:GetController("state")
	self.stageFinishController2_ = self.stageControllerEx2_:GetController("state")
	self.stageFinishController3_ = self.stageControllerEx3_:GetController("state")
	self.stageSelectController1_ = self.stageControllerEx1_:GetController("select")
	self.stageSelectController2_ = self.stageControllerEx2_:GetController("select")
	self.stageSelectController3_ = self.stageControllerEx3_:GetController("select")
	self.heroStateController_ = self.heroStateControllerEx_:GetController("status")
	self.heroController_ = self.heroStateControllerEx_:GetController("hero")
end

function ActivityAutoCookLevelView:AddUIListeners()
	for iter_5_0 = 1, 3 do
		self:AddBtnListener(self["stageBtn" .. iter_5_0 .. "_"], nil, function()
			if self.curSelectIndex_ == iter_5_0 then
				JumpTools.OpenPageByJump("/activityAutoCookPlayView", {
					battleHeroID = self.battleHeroID_,
					activityStageID = ActivityAutoCookStageCfg.get_id_list_by_hero[self.battleHeroID_][iter_5_0]
				})
			else
				self.curSelectIndex_ = iter_5_0

				self:RefreshStageSelectUI()
			end
		end)
	end

	self:AddBtnListener(self.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityConst.AUTO_COOK, "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
end

function ActivityAutoCookLevelView:OnEnter()
	self.activityID_ = ActivityConst.AUTO_COOK
	self.battleHeroID_ = self.params_.battleHeroID

	self.heroController_:SetSelectedState(self.battleHeroID_)

	self.curSelectIndex_ = 0

	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_))
end

function ActivityAutoCookLevelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function ActivityAutoCookLevelView:RefreshUI()
	self:PlayEnterAnimator()
	self:RefreshStageSelectUI()
	self:RefreshHeroState()
	self:RefreshBubble()

	self.firstFinishStageID_ = ActivityAutoCookData:GetFirstFinishStageID()

	for iter_10_0, iter_10_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[self.battleHeroID_]) do
		self["stageImage" .. iter_10_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/Cuisine/" .. ActivityAutoCookFoodCfg[ActivityAutoCookStageCfg[iter_10_1].food].icon_path)

		if ActivityAutoCookStageCfg[iter_10_1].condition ~= 0 then
			if IsConditionAchieved(ActivityAutoCookStageCfg[iter_10_1].condition) then
				SetActive(self["stageBtn" .. iter_10_0 .. "_"], true)
			else
				SetActive(self["stageBtn" .. iter_10_0 .. "_"], false)
			end
		else
			SetActive(self["stageBtn" .. iter_10_0 .. "_"], true)
		end

		if ActivityAutoCookData:GetStageIsFinish(iter_10_1) then
			if self.firstFinishStageID_ == iter_10_1 then
				self["stageFinishController" .. iter_10_0 .. "_"]:SetSelectedState("finish")
				self:PlayFirstClearStageAnimator(iter_10_0)
				self[string.format("itemAnimator%s_", iter_10_0)]:Play("Stage_finish", 0, 0)
				self[string.format("itemAnimator%s_", iter_10_0)]:Update(0)
			else
				self["stageFinishController" .. iter_10_0 .. "_"]:SetSelectedState("finish")
				self[string.format("itemAnimator%s_", iter_10_0)]:Play("Stage_finish", 0, 1)
				self[string.format("itemAnimator%s_", iter_10_0)]:Update(0)
			end
		else
			self["stageFinishController" .. iter_10_0 .. "_"]:SetSelectedState("unlock")
		end
	end
end

function ActivityAutoCookLevelView:RefreshStageSelectUI()
	for iter_11_0, iter_11_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[self.battleHeroID_]) do
		if iter_11_0 == self.curSelectIndex_ then
			self["stageSelectController" .. iter_11_0 .. "_"]:SetSelectedState("on")
		else
			self["stageSelectController" .. iter_11_0 .. "_"]:SetSelectedState("off")
		end
	end
end

function ActivityAutoCookLevelView:RefreshBubble()
	self.bubbleText_.text = ActivityAutoCookStageCfg[ActivityAutoCookStageCfg.get_id_list_by_hero[self.battleHeroID_][math.random(1, #ActivityAutoCookStageCfg.get_id_list_by_hero[self.battleHeroID_])]].start_challenge_tips
end

function ActivityAutoCookLevelView:RefreshHeroState()
	self.heroStateController_:SetSelectedState(self:IsFinishAllStage() and "finish" or "unFinish")
end

function ActivityAutoCookLevelView:IsFinishAllStage()
	for iter_14_0, iter_14_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[self.battleHeroID_]) do
		if not ActivityAutoCookData:GetStageIsFinish(iter_14_1) then
			return false
		end
	end

	return true
end

function ActivityAutoCookLevelView:PlayFirstClearStageAnimator(arg_15_1)
	ActivityAutoCookData:SetFirstFinishStageID(0)
	self:StopFinishTimer()

	self.finishTimer_ = FrameTimer.New(function()
		if self[string.format("itemAnimator%s_", arg_15_1)]:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:StopFinishTimer()

			local var_16_0 = ActivityAutoCookData:GetSpeedTipsID()

			if var_16_0 ~= 0 then
				QWorldMgr:GetQWorldHintMgr():DisplayHintImmediate(var_16_0)
				ActivityAutoCookData:ClearSpeedTipsID()
			end
		end
	end, 1, -1)

	self.finishTimer_:Start()
end

function ActivityAutoCookLevelView:StopFinishTimer()
	if self.finishTimer_ then
		self.finishTimer_:Stop()

		self.finishTimer_ = nil
	end
end

function ActivityAutoCookLevelView:PlayEnterAnimator()
	if not self.params_.isBack then
		self.animator_:Play("Exit_02", 0, 0)
		self.animator_:Update(0)
	else
		self.animator_:Play("Exit_02", 0, 1)
		self.animator_:Update(0)
	end
end

function ActivityAutoCookLevelView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_))
	self:StopFinishTimer()
end

function ActivityAutoCookLevelView:Dispose()
	self.super.Dispose(self)
end

return ActivityAutoCookLevelView
