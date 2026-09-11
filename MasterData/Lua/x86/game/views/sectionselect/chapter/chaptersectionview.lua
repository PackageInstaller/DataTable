local ChapterSectionView = class("ChapterSectionView", import("..SectionBaseView"))
local var_0_1 = 10301
local var_0_2 = 1030102
local var_0_3 = "bgm_activity_5_2_remake_ui"
local var_0_4 = "bgm_activity_5_2_remake_ui_before"
local var_0_5 = "bgm_activity_5_2_remake_ui_after"

function ChapterSectionView:Init()
	self.hardLevelItems_ = {}
	self.currentAttachView_ = nil
	self.attachViewList_ = {}

	ChapterSectionView.super.Init(self)
end

function ChapterSectionView:InitUI()
	ChapterSectionView.super.InitUI(self)

	self.hardLevelView_ = HardLevelSectionView.New(self.selectDifficultPanel_)
	self.skuldBtnController_ = ControllerUtil.GetController(self.skuldbtn_.transform, "isbreach")
	self.chapterPartBtnView_ = ChapterPartBtnView.New(self.chapterBranchGo_)
	self.stopMoveHandler_ = handler(self, self.StopMove)
	self.bgTypeController_ = self.controller_:GetController("bgType")
end

function ChapterSectionView:RefreshData()
	ChapterSectionView.super.RefreshData(self)

	local var_3_0 = self:GetAttachView()

	if self.currentAttachView_ then
		if self.currentAttachView_ ~= var_3_0 then
			self.currentAttachView_:OnExit()

			self.currentAttachView_ = var_3_0

			var_3_0:OnEnter()
		end
	elseif var_3_0 then
		self.currentAttachView_ = var_3_0

		var_3_0:OnEnter()
	end
end

function ChapterSectionView:GetAttachView()
	if ChapterCfg[self.chapterID_].attach_prefab ~= "" then
		if self.chapterID_ == 10112 then
			self.attachViewList_[self.chapterID_] = self.attachViewList_[self.chapterID_] or SectionExtraAttachSkuldView.New(self, ChapterCfg[self.chapterID_].attach_prefab, self.setionAttachGo_)

			return self.attachViewList_[self.chapterID_]
		else
			self.attachViewList_[self.chapterID_] = self.attachViewList_[self.chapterID_] or SectionExtraAttachTimelineView.New(self, ChapterCfg[self.chapterID_].attach_prefab, self.setionAttachGo_)

			return self.attachViewList_[self.chapterID_]
		end
	end
end

function ChapterSectionView:RefreshUI()
	self:RefreshText()
	ChapterSectionView.super.RefreshUI(self)
	self:RefreshHardLevelUI()
	self:RefreshCollectProgress()
	self:SwitchRewardShow()
	self:RefreshTogglePanel()
	self:SwitchBG()
	self:RefreshChapter10301BGM()
	self:CheckSkuldBtn()
	self:RefreshPartBtn()
	self:HideActivityRedPoint()

	if self.currentAttachView_ then
		self.currentAttachView_:RefreshUI()
	end
end

function ChapterSectionView:RefreshText()
	SetActive(self.titleGo_, true)

	self.chapterIndexText_.text = ChapterClientCfg[ChapterCfg[self.chapterID_].clientID].desc
	self.chapterNameText_.text = ChapterClientCfg[ChapterCfg[self.chapterID_].clientID].name
end

function ChapterSectionView:RefreshBGM()
	if self:RefreshChapter10301BGM(true) then
		return
	end

	ChapterSectionView.super.RefreshBGM(self)
end

function ChapterSectionView:RefreshChapter10301BGM(arg_8_1)
	if self.chapterID_ ~= var_0_1 then
		self.chapter10301BgmCueName_ = nil

		return false
	end

	if ChapterTools.IsClearStage(var_0_2) then
		local var_8_0 = var_0_5 or var_0_4

		if arg_8_1 or self.chapter10301BgmCueName_ ~= var_8_0 then
			manager.audio:PlayBGM(var_0_3, var_8_0, var_0_3)

			self.chapter10301BgmCueName_ = var_8_0
		end
	end

	return true
end

function ChapterSectionView:AddListeners()
	ChapterSectionView.super.AddListeners(self)
	self:AddBtnListener(self.collectBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			JumpTools.Back()

			return
		end

		self.stopMove_ = true

		JumpTools.OpenPageByJump("chapterSectionReward", {
			chapterID = self.chapterID_,
			level = self.hardLevel_
		})
	end)
	self:AddBtnListener(self.skuldbtn_, nil, function()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			local var_11_0, var_11_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, GameSetting.travel_skuld_unlock.value[1])

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(GameSetting.travel_skuld_unlock.value[1]), GetI18NText(var_11_0) .. "-" .. GetI18NText(var_11_1)))
		end
	end)
end

function ChapterSectionView:RefreshCustomData()
	self.hardLevel_ = ChapterCfg[self.chapterID_].difficulty
	self.curStar_ = ChapterTools.GetChapterStarCnt(self.chapterID_)
	self.totalStar_ = ChapterTools.GetChapterTotalStarCnt(self.chapterID_)

	self.hardLevelView_:SetData(self.hardLevel_, self.curStar_ / self.totalStar_)
	BattleFieldAction.ChangePlotHardLevel(self.hardLevel_)
end

function ChapterSectionView:SwitchRewardShow()
	if self:IsOpenRoute("chapterSectionReward") then
		SetActive(self.difficultPanel_, false)
		SetActive(self.collectBtnGo_, false)

		self.viewportRect_.localScale = Vector3.zero
	else
		SetActive(self.collectBtnGo_, true)

		self.viewportRect_.localScale = Vector3(1, 1, 1)
	end
end

function ChapterSectionView:GetSectionItemClass()
	return ChapterSectionItem
end

function ChapterSectionView:IsOpenSectionInfo()
	return self:IsOpenRoute("chapterSectionInfo")
end

function ChapterSectionView:GetCfgName()
	return BattleChapterStageCfg
end

function ChapterSectionView:RefreshHardLevelUI()
	self:RefreshSelectDifficult()
end

function ChapterSectionView:RefreshTogglePanel()
	if not getChapterNumList(ChapterCfg[self.params_.chapterID].sub_type)[2] then
		SetActive(self.selectDifficultGo_, false)

		return
	end

	if #ChapterCfg[getChapterNumList(ChapterCfg[self.params_.chapterID].sub_type)[2][1]].section_id_list < 1 then
		SetActive(self.selectDifficultGo_, false)

		return
	end

	if self:IsOpenSectionInfo() or self:IsOpenRoute("chapterSectionReward") then
		SetActive(self.selectDifficultGo_, false)
	else
		SetActive(self.selectDifficultGo_, true)
	end
end

function ChapterSectionView:RefreshCollectProgress()
	self.collectTotalText_.text = string.format("/%s", self.totalStar_)
	self.collectCurText_.text = self.curStar_
end

function ChapterSectionView:RefreshSelectDifficult()
	self.collectProgress_.fillAmount = self.curStar_ / self.totalStar_
end

function ChapterSectionView:OnEnter()
	ChapterSectionView.super.OnEnter(self)
	self.bgTypeController_:SetSelectedState("normal")
	self.hardLevelView_:OnEnter()
	self.chapterPartBtnView_:OnEnter()
	self:SwitchRewardShow()
	manager.notify:RegistListener(CHAPTER_SCROLL_STOP, self.stopMoveHandler_)
	manager.redPoint:bindUIandKey(self.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, self.chapterID_))
	manager.redPoint:bindUIandKey(self.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function ChapterSectionView:CheckSkuldBtn()
	if not self:IsOpenSectionInfo() and not self:IsOpenRoute("chapterSectionReward") and ChapterCfg[self.params_.chapterID].sub_type == 13 then
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			SetActive(self.skuldbtn_.gameObject, true)
		else
			SetActive(self.skuldbtn_.gameObject, false)
		end

		self.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	else
		SetActive(self.skuldbtn_.gameObject, false)
	end
end

function ChapterSectionView:RefreshPartBtn()
	if not self:IsOpenSectionInfo() and not self:IsOpenRoute("chapterSectionReward") then
		self.chapterPartBtnView_:RefreshUI(self.chapterID_)
	else
		SetActive(self.chapterBranchGo_, false)
	end
end

function ChapterSectionView:OnUpdate()
	if self.chapterID_ ~= self.params_.chapterID then
		manager.redPoint:unbindUIandKey(self.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, self.chapterID_))
		manager.redPoint:bindUIandKey(self.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, self.params_.chapterID))
	end

	ChapterSectionView.super.OnUpdate(self)
end

function ChapterSectionView:OnExit()
	if self.currentAttachView_ then
		self.currentAttachView_:OnExit()

		self.currentAttachView_ = nil
	end

	ChapterSectionView.super.OnExit(self)
	self.hardLevelView_:OnExit()
	self.chapterPartBtnView_:OnExit()
	manager.redPoint:unbindUIandKey(self.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, self.chapterID_))
	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", self:GetStayTime(), self.chapterID_)
	manager.notify:RemoveListener(CHAPTER_SCROLL_STOP, self.stopMoveHandler_)
	manager.redPoint:unbindUIandKey(self.skuldbtn_.transform, TravelSkuldBattleBtnKey)
end

function ChapterSectionView:Dispose()
	for iter_26_0, iter_26_1 in pairs(self.attachViewList_) do
		iter_26_1:Dispose()
	end

	self.attachViewList_ = nil

	self.hardLevelView_:Dispose()

	self.hardLevelView_ = nil

	self.chapterPartBtnView_:Dispose()

	self.chapterPartBtnView_ = nil
	self.stopMoveHandler_ = nil

	ChapterSectionView.super.Dispose(self)
end

function ChapterSectionView:HideActivityRedPoint()
	local var_27_0 = ChapterCfg[self.chapterID_].unlock_activity_id ~= 0 and ChapterCfg[self.chapterID_].unlock_activity_id or ChapterCfg[self.chapterID_].activity_id

	if var_27_0 ~= 0 and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + var_27_0) and ActivityTools.GetActivityStatus(var_27_0) == 1 then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + var_27_0)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_27_0), var_27_0), 0)
	end
end

function ChapterSectionView:StopMove()
	self.stopMove_ = true
end

return ChapterSectionView
