local var_0_0 = class("ChapterPlot19MapView", ReduxView)

var_0_0.SCALE_VALUE = 1.2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.mapItemList_ = {}
	arg_1_0.locationViewList_ = {}
	arg_1_0.clueViewList_ = {}
	arg_1_0.chapterMapScrollView_ = ChapterMapScrollView.New(arg_1_0, arg_1_1)
	arg_1_0.chapterSelectLocationHandler_ = handler(arg_1_0, arg_1_0.ChapterSelectLocation)
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(CHAPTER_SELECT_LOCATION, arg_2_0.chapterSelectLocationHandler_)

	if arg_2_0:GetBackCnt() > 0 then
		arg_2_0.scrollViewTf_.localScale = Vector3(var_0_0.SCALE_VALUE, var_0_0.SCALE_VALUE, 1)

		arg_2_0:ChapterSelectLocation()
	else
		arg_2_0.scrollViewTf_.localScale = Vector3(1, 1, 1)

		arg_2_0:RefreshItemSelectState(false)
	end
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHAPTER_SELECT_LOCATION, arg_3_0.chapterSelectLocationHandler_)
	arg_3_0.chapterMapScrollView_:OnExit()
end

function var_0_0.OnUpdate(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.locationViewList_) do
		if not iter_4_1:IsDisabled() then
			iter_4_1:OnUpdate()
		end
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.clueViewList_) do
		if not iter_4_3:IsDisabled() then
			iter_4_3:OnUpdate()
		end
	end

	arg_4_0:ScaleMap()
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.chapterSelectLocationHandler_ = nil

	for iter_5_0, iter_5_1 in pairs(arg_5_0.mapItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.mapItemList_ = nil

	for iter_5_2, iter_5_3 in pairs(arg_5_0.locationViewList_) do
		iter_5_3:Dispose()
	end

	arg_5_0.locationViewList_ = nil

	for iter_5_4, iter_5_5 in pairs(arg_5_0.clueViewList_) do
		iter_5_5:Dispose()
	end

	arg_5_0.clueViewList_ = nil

	arg_5_0.chapterMapScrollView_:Dispose()

	arg_5_0.chapterMapScrollView_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	return
end

function var_0_0.SetMapID(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.chapterID_ = arg_7_1
	arg_7_0.mapID_ = arg_7_2

	local var_7_0 = ChapterMapCfg[arg_7_0.mapID_].map_prefab

	if not arg_7_0.mapItemList_[var_7_0] then
		arg_7_0.mapItemList_[var_7_0] = ChapterPlot19MapItem.New(var_7_0, arg_7_0.mapParentTf_)
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.mapItemList_) do
		iter_7_1:Show(iter_7_0 == var_7_0)
	end

	arg_7_0.mapItemList_[var_7_0]:SetSelectState(ChapterTools.GetChapter19MapState(arg_7_2))
	arg_7_0.mapItemList_[var_7_0]:PlayAnimator(arg_7_3)

	if ChapterTools.IsNeedShowFog() then
		arg_7_0:ShowFog(true)
	else
		arg_7_0:ShowFog(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.mapParentTf_)

	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_2, iter_7_3 in ipairs(ChapterMapCfg[arg_7_0.mapID_].location_list) do
		if ChapterLocationCfg[iter_7_3].type == BattleConst.LOCATION_TYPE.BUILDING then
			table.insert(var_7_1, iter_7_3)
		else
			table.insert(var_7_2, iter_7_3)
		end
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_1) do
		if arg_7_0.locationViewList_[iter_7_4] == nil then
			arg_7_0.locationViewList_[iter_7_4] = ChapterPlot19MapNormalLocation.New(arg_7_0.stageItem_, arg_7_0.itemParent_)
		end

		arg_7_0.locationViewList_[iter_7_4]:SetLocationID(arg_7_0.chapterID_, arg_7_2, iter_7_5)
	end

	for iter_7_6 = #var_7_1 + 1, #arg_7_0.locationViewList_ do
		arg_7_0.locationViewList_[iter_7_6]:Disabled()
	end

	for iter_7_7, iter_7_8 in ipairs(var_7_2) do
		if arg_7_0.clueViewList_[iter_7_7] == nil then
			arg_7_0.clueViewList_[iter_7_7] = ChapterPlot19MapClueLocation.New(arg_7_0.clueItem_, arg_7_0.itemParent_)
		end

		arg_7_0.clueViewList_[iter_7_7]:SetLocationID(arg_7_0.chapterID_, arg_7_2, iter_7_8)
	end

	for iter_7_9 = #var_7_2 + 1, #arg_7_0.clueViewList_ do
		arg_7_0.clueViewList_[iter_7_9]:Disabled()
	end
end

function var_0_0.ChapterSelectLocation(arg_8_0)
	local var_8_0 = BattleFieldData:GetChapterLocationID(arg_8_0.chapterID_)

	if var_8_0 == nil then
		return
	end

	local var_8_1 = ChapterLocationCfg[var_8_0].position
	local var_8_2 = arg_8_0.viewPortRect_.rect.height / 2
	local var_8_3 = arg_8_0.viewPortRect_.rect.width / 2
	local var_8_4 = arg_8_0.contentRect_.rect.height / 2
	local var_8_5 = arg_8_0.contentRect_.rect.width / 2
	local var_8_6 = var_8_1[2]

	if var_8_2 > (var_8_4 - math.abs(var_8_6)) * var_0_0.SCALE_VALUE and var_8_2 <= var_8_4 and var_8_6 ~= 0 then
		var_8_6 = (var_8_4 * var_0_0.SCALE_VALUE - var_8_2) / var_0_0.SCALE_VALUE * math.abs(var_8_6) / var_8_6
	end

	local var_8_7 = var_8_1[1] + 200

	if var_8_3 > (var_8_5 - math.abs(var_8_7)) * var_0_0.SCALE_VALUE and var_8_3 <= var_8_5 and var_8_7 ~= 0 and math.abs(var_8_7) / var_8_7 < 0 then
		var_8_7 = (var_8_5 * var_0_0.SCALE_VALUE - var_8_3) / var_0_0.SCALE_VALUE * math.abs(var_8_7) / var_8_7
	end

	arg_8_0.chapterMapScrollView_:ScrollToPosition(Vector3(var_8_7, var_8_6, 0))
	arg_8_0:RefreshItemSelectState(true)
end

function var_0_0.ResetMapPosition(arg_9_0)
	arg_9_0.scrollView_.normalizedPosition = Vector2(0.5, 0.5)
end

function var_0_0.RefreshItemSelectState(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.locationViewList_) do
		iter_10_1:RefreshSelectState(arg_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.clueViewList_) do
		iter_10_3:RefreshSelectState(arg_10_1)
	end
end

function var_0_0.ScaleMap(arg_11_0)
	if arg_11_0:GetBackCnt() > 0 then
		arg_11_0:CancelTween()
		LeanTween.scale(arg_11_0.scrollViewTf_, Vector3(var_0_0.SCALE_VALUE, var_0_0.SCALE_VALUE, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
		arg_11_0:ChapterSelectLocation()
	else
		arg_11_0.chapterMapScrollView_:EnabledScroll(true)
		arg_11_0:CancelTween()
		LeanTween.scale(arg_11_0.scrollViewTf_, Vector3(1, 1, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
		arg_11_0:RefreshItemSelectState(false)
	end
end

function var_0_0.CancelTween(arg_12_0)
	if arg_12_0.leanTween_ then
		LeanTween.cancel(arg_12_0.scrollViewTf_)

		arg_12_0.leanTween_ = nil
	end
end

function var_0_0.ShowFog(arg_13_0, arg_13_1)
	local var_13_0 = ChapterMapCfg[arg_13_0.mapID_].map_prefab
	local var_13_1 = arg_13_0.mapItemList_[var_13_0]

	if arg_13_1 == false and ChapterTools.NeedPlayFogAnimator() then
		var_13_1:SetFogState(true)
		var_13_1:SetLineState(true)
		BattleStageData:SaveFogAnimatorFlag(true)
		var_13_1:PlayFogAnimator()
	else
		var_13_1:SetFogState(arg_13_1)
		var_13_1:SetLineState(arg_13_1)
	end
end

function var_0_0.GetBackCnt(arg_14_0)
	local var_14_0 = 0

	if arg_14_0:IsOpenRoute("chapterPlot19MapLocationInfo") then
		var_14_0 = var_14_0 + 1
	end

	if arg_14_0:IsOpenRoute("chapter19SectionInfo") then
		var_14_0 = var_14_0 + 1
	end

	return var_14_0
end

return var_0_0
