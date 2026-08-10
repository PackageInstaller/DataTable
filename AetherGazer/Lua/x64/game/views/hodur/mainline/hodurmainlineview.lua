local var_0_0 = class("HodurMainlineView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Activity_Hodur_CheckpointMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.chapterID_ = nil
	arg_3_0.stageList_ = {}
	arg_3_0.contentItemList_ = {}
	arg_3_0.heroInfoModule_ = HodurMainlineHeroModule.New(arg_3_0.heroModuleGo_)
	arg_3_0.selectModule_ = HodurSelectModule.New(arg_3_0.eventModuleGo_)
	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0.scrollView_.enabled = true

		if arg_5_0.isOpenInfoView_ then
			arg_5_0:ShowSelectView(false)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("HODUR_RESET_CHAPTER_TIP"),
			OkCallback = function()
				HodurAction.ResetChapter(arg_5_0.chapterID_)
				arg_5_0:RefreshUI()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.scrollView_.enabled = true

	SetActive(arg_10_0.affixFlyGo_, false)

	arg_10_0.chapterID_ = arg_10_0.params_.chapter_id
	arg_10_0.activityID_ = arg_10_0.params_.activity_id
	arg_10_0.stageList_ = ActivityHodurChapterCfg[arg_10_0.chapterID_].stage_list

	arg_10_0:RefreshUI()
	arg_10_0:ShowSelectView(false)

	local var_10_0 = HodurSystemData:GetCachePos(arg_10_0.chapterID_) or 0

	if not arg_10_0.isSelect then
		arg_10_0.content1_.transform.localPosition = Vector3(var_10_0, arg_10_0.content1_.transform.localPosition.y, arg_10_0.content1_.transform.localPosition.z)
	end
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0.heroInfoModule_:ShowTips(false)
	arg_13_0:RemoveTween()
	arg_13_0:CachePos()
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshStageList()
	arg_14_0:RefreshHeroInfo()
end

function var_0_0.RefreshStageList(arg_15_0)
	local var_15_0 = #arg_15_0.stageList_ or 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.stageList_) do
		if arg_15_0.contentItemList_[iter_15_0] == nil then
			local var_15_1 = Object.Instantiate(arg_15_0.contentItemGo_, arg_15_0.contentTrs_)

			arg_15_0.contentItemList_[iter_15_0] = HodurMainlineContentItem.New(var_15_1)
		end

		local var_15_2 = iter_15_1[1]
		local var_15_3 = iter_15_1[2] or nil
		local var_15_4 = false

		if iter_15_0 == var_15_0 then
			var_15_4 = true
		end

		local var_15_5 = iter_15_0

		arg_15_0.contentItemList_[iter_15_0]:SetData(var_15_2, var_15_3, var_15_5, var_15_4, arg_15_0.chapterID_)
		arg_15_0.contentItemList_[iter_15_0]:SetCallback(handler(arg_15_0, arg_15_0.OnClickStage), handler(arg_15_0, arg_15_0.OnClickEvent))
		arg_15_0.contentItemList_[iter_15_0]:SetActive(true)
	end

	for iter_15_2 = var_15_0 + 1, #arg_15_0.contentItemList_ do
		arg_15_0.contentItemList_[iter_15_2]:SetActive(false)
	end

	if HodurTools.GetChapterStateEmpty(arg_15_0.chapterID_) then
		SetActive(arg_15_0.resetBtn_.gameObject, false)
	else
		SetActive(arg_15_0.resetBtn_.gameObject, true)
	end
end

function var_0_0.RefreshHeroInfo(arg_16_0)
	arg_16_0.heroInfoModule_:SetData(arg_16_0.chapterID_)
end

function var_0_0.OnClickStage(arg_17_0, arg_17_1)
	if not HodurTools.GetStageUnlock(arg_17_1, arg_17_0.chapterID_) then
		local var_17_0, var_17_1, var_17_2 = HodurTools.GetStageUnlock(arg_17_1, arg_17_0.chapterID_)

		if var_17_1 and not var_17_2 then
			local var_17_3 = ActivityHodurCfg[arg_17_1].event_lock
			local var_17_4 = ActivityHodurEventCfg[var_17_3]

			ShowTips(string.format(GetTips("HODUR_STAGE_LOCK"), var_17_4.event_title))

			return
		end

		ShowTips(GetTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION"))

		return
	end

	arg_17_0.selectModule_:SetData(HodurConst.INFO_VIEW_TYPE.STAGE, arg_17_1, arg_17_0.chapterID_)

	for iter_17_0, iter_17_1 in pairs(arg_17_0.contentItemList_) do
		if iter_17_1:SetSelect(HodurConst.INFO_VIEW_TYPE.STAGE, arg_17_1) then
			arg_17_0:OnSelectLevelItem(iter_17_1)
		end
	end

	arg_17_0:ShowSelectView(true)
end

function var_0_0.OnClickEvent(arg_18_0, arg_18_1)
	arg_18_0.selectModule_:SetData(HodurConst.INFO_VIEW_TYPE.EVENT, arg_18_1, arg_18_0.chapterID_)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.contentItemList_) do
		if iter_18_1:SetSelect(HodurConst.INFO_VIEW_TYPE.EVENT, arg_18_1) then
			arg_18_0:OnSelectLevelItem(iter_18_1)
		end
	end

	arg_18_0:ShowSelectView(true)
end

function var_0_0.ShowSelectView(arg_19_0, arg_19_1)
	arg_19_0.isOpenInfoView_ = arg_19_1

	if arg_19_1 then
		arg_19_0.selectController_:SetSelectedState("show")
		arg_19_0.selectModule_:OnEnter()
	else
		arg_19_0.selectController_:SetSelectedState("hide")

		for iter_19_0, iter_19_1 in pairs(arg_19_0.contentItemList_) do
			iter_19_1:SetSelectFalse()
		end

		arg_19_0.selectModule_:OnExit()
	end

	arg_19_0.isSelect = arg_19_1
end

function var_0_0.OnSelectLevelItem(arg_20_0, arg_20_1)
	if arg_20_1 then
		arg_20_0.isSelect = true
		arg_20_0.scrollView_.enabled = false

		local var_20_0 = -arg_20_1.transform_.localPosition.x + arg_20_0.scrollViewTrans_.rect.width / 2 - arg_20_1.transform_.rect.width / 2

		arg_20_0:RemoveTween()

		arg_20_0.tween_ = LeanTween.value(arg_20_0.content1_, arg_20_0.content1_.transform.localPosition.x, var_20_0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
			arg_20_0.content1_.transform.localPosition = Vector3(arg_21_0, 0, 0)
		end))
	end
end

function var_0_0.CachePos(arg_22_0)
	HodurSystemData:CachePos(arg_22_0.chapterID_, arg_22_0.content1_.transform.localPosition.x)
end

function var_0_0.AffixFly(arg_23_0, arg_23_1)
	arg_23_0.affixFlyGo_.transform.position = arg_23_0["affixFlyFormTrs_" .. arg_23_1].position

	SetActive(arg_23_0.affixFlyGo_, true)
	LeanTween.move(arg_23_0.affixFlyGo_, arg_23_0.affixFlyTargetTrs_.position, 0.4):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		SetActive(arg_23_0.affixFlyGo_, false)
	end))
end

function var_0_0.RemoveTween(arg_25_0)
	if arg_25_0.tween_ then
		arg_25_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_25_0.content1_)

		arg_25_0.tween_ = nil
	end
end

function var_0_0.OnHodurSelectEvent(arg_26_0, arg_26_1)
	arg_26_0:AffixFly(arg_26_1)
	arg_26_0.selectModule_:RefreshEventUI()
	arg_26_0:RefreshUI()
end

function var_0_0.OnHodurResetChapter(arg_27_0)
	arg_27_0:RefreshUI()
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0:RemoveTween()

	if arg_28_0.heroInfoModule_ then
		arg_28_0.heroInfoModule_:Dispose()

		arg_28_0.heroInfoModule_ = nil
	end

	if arg_28_0.eventModule_ then
		arg_28_0.eventModule_:Dispose()

		arg_28_0.eventModule_ = nil
	end

	if arg_28_0.selectModule_ then
		arg_28_0.selectModule_:Dispose()

		arg_28_0.selectModule_ = nil
	end

	for iter_28_0, iter_28_1 in pairs(arg_28_0.contentItemList_) do
		iter_28_1:Dispose()
	end

	arg_28_0.contentItemList_ = {}

	var_0_0.super.Dispose(arg_28_0)
	arg_28_0:RemoveAllListeners()
end

return var_0_0
