local ActivityRhythmGameStageView = class("ActivityRhythmGameStageView", ReduxView)

function ActivityRhythmGameStageView:UIName()
	return "Widget/System/Summer2024/Summer2024_MuiscUI/SummerUI_3_4_MuiscUI"
end

function ActivityRhythmGameStageView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRhythmGameStageView:Init()
	self:InitOwnData()
	self:BindCfgUI()

	self.scrollView_ = StageScrollView.New(self.scrollViewGo_)

	self.scrollView_:RegistPointerUp(handler(self, self.TryCloseSectionView))
	self.scrollView_:RegistBeginDrag(handler(self, self.TryCloseSectionView))
	self:BindController()
	self:AddUIListeners()
end

function ActivityRhythmGameStageView:InitOwnData()
	self.activityID_ = -1
	self.stageNodeList_ = {}
end

function ActivityRhythmGameStageView:BindController()
	self.stageController_ = self.controllerEx_:GetController("stageState")
	self.canswitchController_ = self.controllerEx_:GetController("chapterNum")
	self.chapterController_ = self.switchControllerEx_:GetController("chapter")
end

function ActivityRhythmGameStageView:AddUIListeners()
	self:AddBtnListener(nil, self.taskBtn_, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
		end

		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_TASK
		})
	end)
	self:AddBtnListener(nil, self.commandBtn_, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
		end

		JumpTools.OpenPageByJump("/activityRhythmGameCommandView", {
			chapterID = ActivityRhythmGameData:GetCurPage(),
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(nil, self.switchHeroBtn_, function()
		self:SwtichChapter((ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE or nil) and (ActivityRhythmGameConst.Chapter_ID.TWO or ActivityRhythmGameConst.Chapter_ID.ONE))
	end)
end

function ActivityRhythmGameStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RHYTHM_DESCRIPE")

	self.switchHeroBtn_.interactable = not not ActivityRhythmGameData:GetCanSwitchChapter()

	self:ChangeStageController(0)

	for iter_10_0, iter_10_1 in ipairs(self.stageNodeList_) do
		if iter_10_1 and iter_10_1.ChangeSelectController then
			iter_10_1:ChangeSelectController(0)
		end
	end

	self.curSelectStageID_ = nil

	self:RefreshSelectStage()
	self.scrollView_:Recover()
end

function ActivityRhythmGameStageView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityRhythmGameStageView:OnEnter()
	if not self.params_.isBack or not not self.params_.activityID then
		self.activityID_ = self.params_.activityID
	end

	if not ActivityData:GetActivityIsOpen(self.activityID_) then
		ShowTips("TIME_OVER")

		return
	end

	self:CheckPlayStory()
end

function ActivityRhythmGameStageView:CheckPlayStory()
	local var_13_0 = false
	local var_13_1 = -1

	ActivityRhythmGameData:InitUnlockStageData()
	ActivityRhythmGameData:InitUnlockCommandData()

	for iter_13_0, iter_13_1 in ipairs(GameSetting.activity_rhythm_game_story.value) do
		if IsConditionAchieved(iter_13_1[1]) then
			var_13_1 = iter_13_1[2]

			if iter_13_1[2] ~= -1 and not ActivityRhythmGameData:IsStroyPlayed(var_13_1) then
				var_13_0 = true

				break
			end
		end
	end

	if var_13_0 and var_13_1 then
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_13_1, function()
			ActivityRhythmGameAction.PlayStory(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_MAIN, var_13_1, function()
				self:EnterOther()
				gameContext:Back()
			end)
		end)
	else
		self:EnterOther()
	end
end

function ActivityRhythmGameStageView:EnterOther()
	ActivityRhythmGameStageView.super.OnEnter(self)
	self:RefreshUI()
	self:RefreshNodePos()
	self:BindRedPoint()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.SUMMER_CHESS_BOARD_RHYTHM, 0, RedPointStyle.NORMAL)
end

function ActivityRhythmGameStageView:OnExit()
	for iter_17_0, iter_17_1 in ipairs(self.stageNodeList_) do
		if iter_17_1 and iter_17_1.OnExit then
			iter_17_1:OnExit()
		end
	end

	self.scrollView_:OnExit()
	self:UnbindRedPoint()
	ActivityRhythmGameStageView.super.OnExit(self)
end

function ActivityRhythmGameStageView:Dispose()
	for iter_18_0, iter_18_1 in ipairs(self.stageNodeList_) do
		if iter_18_1 and iter_18_1.Dispose then
			iter_18_1:Dispose()
		end
	end

	if self.firstTimer then
		self.firstTimer:Stop()
		manager.ui:UIEventEnabledByUI(true, false)

		self.firstTimer = nil
	end

	self.scrollView_:Dispose()

	self.scrollView_ = nil

	ActivityRhythmGameStageView.super.Dispose(self)
end

function ActivityRhythmGameStageView:ChangeChapterController(arg_19_1)
	self.chapterController_:SetSelectedIndex(arg_19_1)
end

function ActivityRhythmGameStageView:ChangeStageController(arg_20_1)
	self.stageController_:SetSelectedIndex(arg_20_1)

	self.heroNodeCanvasGroup_.blocksRaycasts = arg_20_1 ~= 1
end

function ActivityRhythmGameStageView:ChangeCanSwitchController(arg_21_1)
	self.canswitchController_:SetSelectedIndex(arg_21_1)
end

function ActivityRhythmGameStageView:RefreshUI()
	self:RefreshStageNode()
	self:RefreshChapter()
end

function ActivityRhythmGameStageView:RefreshChapter()
	if ActivityRhythmGameData:GetCanSwitchChapter() then
		SetActive(self.switchHeroGo_, true)

		self.switchHeroBtn_.interactable = true

		self:ChangeCanSwitchController(1)
		self:RefreshSwitchHeroEffect()
	else
		SetActive(self.switchHeroGo_, false)

		self.switchHeroBtn_.interactable = false

		self:ChangeCanSwitchController(0)
	end

	if ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE then
		self.heroAnimator_:Play("RoleChange02")
	else
		self.heroAnimator_:Play("RoleChange01")
	end

	self:ChangeChapterController(ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE and 0 or 1)

	for iter_23_0, iter_23_1 in ipairs(self.stageNodeList_) do
		if iter_23_1 and iter_23_1.ChangeSelectController then
			iter_23_1:ChangeStageController(ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE and 0 or 1)
		end
	end

	self.stageAnimator_:Play("Stage")
end

function ActivityRhythmGameStageView:RefreshStageNode()
	local var_24_0 = ActivityRhythmGameData:GetShowCfgIDsByChapterID(ActivityRhythmGameData:GetCurPage())

	for iter_24_0 = #var_24_0 + 1, #self.stageNodeList_ do
		self.stageNodeList_[iter_24_0]:Show(false)
	end

	self.stageContentTrs_.sizeDelta = Vector2(892, self.stageContentTrs_.rect.height)

	for iter_24_1 = 1, #var_24_0 do
		self.stageContentTrs_.sizeDelta = Vector2(self.stageContentTrs_.rect.width + 210, self.stageContentTrs_.rect.height)

		local var_24_1 = self.stageNodeList_[iter_24_1]

		if self.stageNodeList_[iter_24_1] == nil then
			var_24_1 = ActivityRhythmGameStageItem.New(self.stageItemGo_, self.stageContentGo_)

			var_24_1:SetAddPos(ActivityRhythmGameTools.GetAddPos(iter_24_1))

			self.stageNodeList_[iter_24_1] = var_24_1

			var_24_1:SetClickHandler(function(arg_25_0, arg_25_1, arg_25_2)
				self:OnClickSectionItem(arg_25_0, arg_25_1, arg_25_2)
			end)
		else
			var_24_1:Show(true)
		end

		var_24_1:SetData(var_24_0[iter_24_1])

		if iter_24_1 == 1 then
			if #var_24_0 == 1 then
				var_24_1:SetLine(5)
			else
				var_24_1:SetLine(0)
			end
		elseif iter_24_1 == #var_24_0 then
			var_24_1:SetLine(iter_24_1 % 2 == 0 and 3 or 4)
		else
			var_24_1:SetLine(iter_24_1 % 2 == 0 and 2 or 1)
		end

		var_24_1:RefreshUI()
	end
end

function ActivityRhythmGameStageView:RefreshNodePos()
	if self.params_.stageID then
		for iter_26_0, iter_26_1 in ipairs(self.stageNodeList_) do
			if iter_26_1 and iter_26_1.stageID_ and iter_26_1.stageID_ == self.params_.stageID then
				self:MoveStageContent((iter_26_1:GetPosition()))
			end
		end
	end
end

function ActivityRhythmGameStageView:RefreshSwitchHeroEffect()
	if not getData("activity_rhythm_game_main", "switchHeroEffect") then
		SetActive(self.switchBtnEffect_, true)

		if self.firstTimer then
			self.firstTimer:Stop()
			manager.ui:UIEventEnabledByUI(true, false)

			self.firstTimer = nil
		end

		self.firstTimer = Timer.New(function()
			manager.ui:UIEventEnabledByUI(false, true)

			local var_28_0 = self.switchBtnAni_:GetCurrentAnimatorStateInfo(0)

			if var_28_0:IsName("eff_unlock") and var_28_0.normalizedTime >= 1 and self.firstTimer then
				self.firstTimer:Stop()

				self.firstTimer = nil

				saveData("activity_rhythm_game_main", "switchHeroEffect", true)
				self:SwtichChapter(ActivityRhythmGameConst.Chapter_ID.TWO)
				manager.ui:UIEventEnabledByUI(true, false)
			end
		end, 0.033, -1)

		self.firstTimer:Start()
	else
		SetActive(self.switchBtnEffect_, false)
	end
end

function ActivityRhythmGameStageView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_RHYTHM_GIFT)
end

function ActivityRhythmGameStageView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform)
end

function ActivityRhythmGameStageView:IsOpenSectionView()
	return self:IsOpenRoute("activityRhythmGameStageInfoView")
end

function ActivityRhythmGameStageView:TryCloseSectionView()
	if self:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function ActivityRhythmGameStageView:OnClickSectionItem(arg_33_1, arg_33_2, arg_33_3)
	if self.curSelectStageID_ == arg_33_1 then
		return
	end

	self.curSelectStageID_ = arg_33_1

	self:RefreshSelectStage(self.curSelectStageID_)
	JumpTools.OpenPageByJump("activityRhythmGameStageInfoView", {
		activityID = self.activityID_,
		stageID = arg_33_2,
		cfgID = arg_33_1
	})

	self.switchHeroBtn_.interactable = false

	self:ChangeStageController(1)
	self:MoveStageContent(arg_33_3)
end

function ActivityRhythmGameStageView:MoveStageContent(arg_34_1)
	self.scrollView_:MoveContentScreenPosXDelta(UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_34_1).x - Screen.width / 2)
end

function ActivityRhythmGameStageView:RefreshSelectStage(arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(self.stageNodeList_) do
		iter_35_1:RefreshSelect(arg_35_1)
	end
end

function ActivityRhythmGameStageView:SwtichChapter(arg_36_1)
	if self:IsOpenSectionView() then
		JumpTools.Back()
	end

	if arg_36_1 == ActivityRhythmGameData:GetCurPage() then
		return
	end

	ActivityRhythmGameData:SetCurPage(arg_36_1)
	self:RefreshUI()
end

return ActivityRhythmGameStageView
