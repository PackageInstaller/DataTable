local var_0_0 = class("ChapterSectionView", import("..SectionBaseView"))
local var_0_1 = 10301
local var_0_2 = 1030102
local var_0_3 = "bgm_activity_5_2_remake_ui"
local var_0_4 = "bgm_activity_5_2_remake_ui_before"
local var_0_5 = "bgm_activity_5_2_remake_ui_after"

function var_0_0.Init(arg_1_0)
	arg_1_0.hardLevelItems_ = {}
	arg_1_0.currentAttachView_ = nil
	arg_1_0.attachViewList_ = {}

	var_0_0.super.Init(arg_1_0)
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)

	arg_2_0.hardLevelView_ = HardLevelSectionView.New(arg_2_0.selectDifficultPanel_)
	arg_2_0.skuldBtnController_ = ControllerUtil.GetController(arg_2_0.skuldbtn_.transform, "isbreach")
	arg_2_0.chapterPartBtnView_ = ChapterPartBtnView.New(arg_2_0.chapterBranchGo_)
	arg_2_0.stopMoveHandler_ = handler(arg_2_0, arg_2_0.StopMove)
	arg_2_0.bgTypeController_ = arg_2_0.controller_:GetController("bgType")
end

function var_0_0.RefreshData(arg_3_0)
	var_0_0.super.RefreshData(arg_3_0)

	local var_3_0 = arg_3_0:GetAttachView()

	if arg_3_0.currentAttachView_ then
		if arg_3_0.currentAttachView_ ~= var_3_0 then
			arg_3_0.currentAttachView_:OnExit()

			arg_3_0.currentAttachView_ = var_3_0

			var_3_0:OnEnter()
		end
	elseif var_3_0 then
		arg_3_0.currentAttachView_ = var_3_0

		var_3_0:OnEnter()
	end
end

function var_0_0.GetAttachView(arg_4_0)
	local var_4_0 = ChapterCfg[arg_4_0.chapterID_]

	if var_4_0.attach_prefab ~= "" then
		if arg_4_0.chapterID_ == 10112 then
			if not arg_4_0.attachViewList_[arg_4_0.chapterID_] then
				arg_4_0.attachViewList_[arg_4_0.chapterID_] = SectionExtraAttachSkuldView.New(arg_4_0, var_4_0.attach_prefab, arg_4_0.setionAttachGo_)
			end

			return arg_4_0.attachViewList_[arg_4_0.chapterID_]
		else
			if not arg_4_0.attachViewList_[arg_4_0.chapterID_] then
				arg_4_0.attachViewList_[arg_4_0.chapterID_] = SectionExtraAttachTimelineView.New(arg_4_0, var_4_0.attach_prefab, arg_4_0.setionAttachGo_)
			end

			return arg_4_0.attachViewList_[arg_4_0.chapterID_]
		end
	end
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0:RefreshText()
	var_0_0.super.RefreshUI(arg_5_0)
	arg_5_0:RefreshHardLevelUI()
	arg_5_0:RefreshCollectProgress()
	arg_5_0:SwitchRewardShow()
	arg_5_0:RefreshTogglePanel()
	arg_5_0:SwitchBG()
	arg_5_0:RefreshChapter10301BGM()
	arg_5_0:CheckSkuldBtn()
	arg_5_0:RefreshPartBtn()
	arg_5_0:HideActivityRedPoint()

	if arg_5_0.currentAttachView_ then
		arg_5_0.currentAttachView_:RefreshUI()
	end
end

function var_0_0.RefreshText(arg_6_0)
	SetActive(arg_6_0.titleGo_, true)

	local var_6_0 = arg_6_0.chapterID_
	local var_6_1 = ChapterCfg[var_6_0]
	local var_6_2 = ChapterClientCfg[var_6_1.clientID]

	arg_6_0.chapterIndexText_.text = var_6_2.desc
	arg_6_0.chapterNameText_.text = var_6_2.name
end

function var_0_0.RefreshBGM(arg_7_0)
	if arg_7_0:RefreshChapter10301BGM(true) then
		return
	end

	var_0_0.super.RefreshBGM(arg_7_0)
end

function var_0_0.RefreshChapter10301BGM(arg_8_0, arg_8_1)
	if arg_8_0.chapterID_ ~= var_0_1 then
		arg_8_0.chapter10301BgmCueName_ = nil

		return false
	end

	local var_8_0 = ChapterTools.IsClearStage(var_0_2) and var_0_5 or var_0_4

	if arg_8_1 or arg_8_0.chapter10301BgmCueName_ ~= var_8_0 then
		manager.audio:PlayBGM(var_0_3, var_8_0, var_0_3)

		arg_8_0.chapter10301BgmCueName_ = var_8_0
	end

	return true
end

function var_0_0.AddListeners(arg_9_0)
	var_0_0.super.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.collectBtn_, nil, function()
		if arg_9_0:IsOpenSectionInfo() then
			JumpTools.Back()

			return
		end

		arg_9_0.stopMove_ = true

		JumpTools.OpenPageByJump("chapterSectionReward", {
			chapterID = arg_9_0.chapterID_,
			level = arg_9_0.hardLevel_
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.skuldbtn_, nil, function()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			local var_11_0 = GameSetting.travel_skuld_unlock.value[1]
			local var_11_1 = getChapterDifficulty(var_11_0)
			local var_11_2, var_11_3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_11_0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), var_11_1, GetI18NText(var_11_2) .. "-" .. GetI18NText(var_11_3)))
		end
	end)
end

function var_0_0.RefreshCustomData(arg_12_0)
	arg_12_0.hardLevel_ = ChapterCfg[arg_12_0.chapterID_].difficulty
	arg_12_0.curStar_ = ChapterTools.GetChapterStarCnt(arg_12_0.chapterID_)
	arg_12_0.totalStar_ = ChapterTools.GetChapterTotalStarCnt(arg_12_0.chapterID_)

	arg_12_0.hardLevelView_:SetData(arg_12_0.hardLevel_, arg_12_0.curStar_ / arg_12_0.totalStar_)
	BattleFieldAction.ChangePlotHardLevel(arg_12_0.hardLevel_)
end

function var_0_0.SwitchRewardShow(arg_13_0)
	if arg_13_0:IsOpenRoute("chapterSectionReward") then
		SetActive(arg_13_0.difficultPanel_, false)
		SetActive(arg_13_0.collectBtnGo_, false)

		arg_13_0.viewportRect_.localScale = Vector3.zero
	else
		SetActive(arg_13_0.collectBtnGo_, true)

		arg_13_0.viewportRect_.localScale = Vector3(1, 1, 1)
	end
end

function var_0_0.GetSectionItemClass(arg_14_0)
	return ChapterSectionItem
end

function var_0_0.IsOpenSectionInfo(arg_15_0)
	return arg_15_0:IsOpenRoute("chapterSectionInfo")
end

function var_0_0.GetCfgName(arg_16_0)
	return BattleChapterStageCfg
end

function var_0_0.RefreshHardLevelUI(arg_17_0)
	arg_17_0:RefreshSelectDifficult()
end

function var_0_0.RefreshTogglePanel(arg_18_0)
	local var_18_0 = ChapterCfg[arg_18_0.params_.chapterID].sub_type

	if not getChapterNumList(var_18_0)[2] then
		SetActive(arg_18_0.selectDifficultGo_, false)

		return
	end

	local var_18_1 = getChapterNumList(var_18_0)[2][1]

	if #ChapterCfg[var_18_1].section_id_list < 1 then
		SetActive(arg_18_0.selectDifficultGo_, false)

		return
	end

	if arg_18_0:IsOpenSectionInfo() or arg_18_0:IsOpenRoute("chapterSectionReward") then
		SetActive(arg_18_0.selectDifficultGo_, false)
	else
		SetActive(arg_18_0.selectDifficultGo_, true)
	end
end

function var_0_0.RefreshCollectProgress(arg_19_0)
	arg_19_0.collectTotalText_.text = string.format("/%s", arg_19_0.totalStar_)
	arg_19_0.collectCurText_.text = arg_19_0.curStar_
end

function var_0_0.RefreshSelectDifficult(arg_20_0)
	local var_20_0 = arg_20_0.curStar_ / arg_20_0.totalStar_

	arg_20_0.collectProgress_.fillAmount = var_20_0
end

function var_0_0.OnEnter(arg_21_0)
	var_0_0.super.OnEnter(arg_21_0)
	arg_21_0.bgTypeController_:SetSelectedState("normal")
	arg_21_0.hardLevelView_:OnEnter()
	arg_21_0.chapterPartBtnView_:OnEnter()
	arg_21_0:SwitchRewardShow()
	manager.notify:RegistListener(CHAPTER_SCROLL_STOP, arg_21_0.stopMoveHandler_)
	manager.redPoint:bindUIandKey(arg_21_0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, arg_21_0.chapterID_))

	local var_21_0 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:bindUIandKey(arg_21_0.skuldbtn_.transform, var_21_0)
end

function var_0_0.CheckSkuldBtn(arg_22_0)
	if not arg_22_0:IsOpenSectionInfo() and not arg_22_0:IsOpenRoute("chapterSectionReward") and ChapterCfg[arg_22_0.params_.chapterID].sub_type == 13 then
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			SetActive(arg_22_0.skuldbtn_.gameObject, true)
		else
			SetActive(arg_22_0.skuldbtn_.gameObject, false)
		end

		arg_22_0.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	else
		SetActive(arg_22_0.skuldbtn_.gameObject, false)
	end
end

function var_0_0.RefreshPartBtn(arg_23_0)
	if not arg_23_0:IsOpenSectionInfo() and not arg_23_0:IsOpenRoute("chapterSectionReward") then
		arg_23_0.chapterPartBtnView_:RefreshUI(arg_23_0.chapterID_)
	else
		SetActive(arg_23_0.chapterBranchGo_, false)
	end
end

function var_0_0.OnUpdate(arg_24_0)
	if arg_24_0.chapterID_ ~= arg_24_0.params_.chapterID then
		manager.redPoint:unbindUIandKey(arg_24_0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, arg_24_0.chapterID_))
		manager.redPoint:bindUIandKey(arg_24_0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, arg_24_0.params_.chapterID))
	end

	var_0_0.super.OnUpdate(arg_24_0)
end

function var_0_0.OnExit(arg_25_0)
	if arg_25_0.currentAttachView_ then
		arg_25_0.currentAttachView_:OnExit()

		arg_25_0.currentAttachView_ = nil
	end

	var_0_0.super.OnExit(arg_25_0)
	arg_25_0.hardLevelView_:OnExit()
	arg_25_0.chapterPartBtnView_:OnExit()
	manager.redPoint:unbindUIandKey(arg_25_0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, arg_25_0.chapterID_))

	local var_25_0 = arg_25_0:GetStayTime()

	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", var_25_0, arg_25_0.chapterID_)
	manager.notify:RemoveListener(CHAPTER_SCROLL_STOP, arg_25_0.stopMoveHandler_)
	manager.redPoint:unbindUIandKey(arg_25_0.skuldbtn_.transform, TravelSkuldBattleBtnKey)
end

function var_0_0.Dispose(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.attachViewList_) do
		iter_26_1:Dispose()
	end

	arg_26_0.attachViewList_ = nil

	arg_26_0.hardLevelView_:Dispose()

	arg_26_0.hardLevelView_ = nil

	arg_26_0.chapterPartBtnView_:Dispose()

	arg_26_0.chapterPartBtnView_ = nil
	arg_26_0.stopMoveHandler_ = nil

	var_0_0.super.Dispose(arg_26_0)
end

function var_0_0.HideActivityRedPoint(arg_27_0)
	local var_27_0 = arg_27_0.chapterID_
	local var_27_1 = ChapterCfg[var_27_0]
	local var_27_2

	if var_27_1.unlock_activity_id ~= 0 then
		var_27_2 = var_27_1.unlock_activity_id
	else
		var_27_2 = var_27_1.activity_id
	end

	if var_27_2 ~= 0 and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + var_27_2) and ActivityTools.GetActivityStatus(var_27_2) == 1 then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + var_27_2)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_27_2), var_27_2), 0)
	end
end

function var_0_0.StopMove(arg_28_0)
	arg_28_0.stopMove_ = true
end

return var_0_0
