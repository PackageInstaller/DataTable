local var_0_0 = import("game.views.chapterTimeLine.StoryTimelineBaseView")
local var_0_1 = class("IlluStoryTimeLineView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/Illustrated_StoryLine/Illustrated_StoryLineMainUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	var_0_1.super.Init(arg_3_0)
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tabController_ = arg_4_0.controller_:GetController("tab")
	arg_4_0.tabSelectController_ = arg_4_0.tabControllerEx_:GetController("tab")
	arg_4_0.itemList_ = {}
	arg_4_0.normalItemList_ = {}
	arg_4_0.collectItemList_ = {}

	local var_4_0 = math.ceil(_G.SCREEN_WIDTH / (arg_4_0.itemTrs_.rect.width * 0.6)) + 2

	arg_4_0.itemClickCallBack_ = handler(arg_4_0, arg_4_0.ItemClickCallBack)

	for iter_4_0 = 1, var_4_0 do
		arg_4_0.normalItemList_[iter_4_0] = StoryTimeLineNormalIllutItemView.New(arg_4_0.item_, arg_4_0.itemContentTrs_)

		arg_4_0.normalItemList_[iter_4_0]:SetClickCallBack(arg_4_0.itemClickCallBack_)
	end

	for iter_4_1 = 1, var_4_0 do
		arg_4_0.collectItemList_[iter_4_1] = StoryTimeLineIllutItemView.New(arg_4_0.item_, arg_4_0.itemContentTrs_)

		arg_4_0.collectItemList_[iter_4_1]:SetClickCallBack(arg_4_0.itemClickCallBack_)
	end

	arg_4_0:AddListeners()

	arg_4_0.preLayoutSpacing = arg_4_0.layoutGroup_.spacing
end

function var_0_1.InitData(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}

	arg_5_0.cacaheChapterPlotInfoList_ = {}

	local var_5_3 = 0

	for iter_5_0, iter_5_1 in ipairs(CollectStoryCfg.get_id_list_by_type[1]) do
		local var_5_4 = StoryCfg[iter_5_1]

		if var_5_4 and var_5_4.trigger[2] then
			local var_5_5 = var_5_4.trigger[2]
			local var_5_6 = getChapterIDByStageID(var_5_5)

			if var_5_6 then
				if not var_5_0[var_5_6] then
					var_5_0[var_5_6] = {
						chapterID = var_5_6,
						storyList = {}
					}
				end

				table.insert(var_5_0[var_5_6].storyList, var_5_4.id)
			end
		end
	end

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		local var_5_7 = ChapterClientCfg[iter_5_2]

		if var_5_7 then
			local var_5_8 = {
				chapterID = iter_5_2,
				storyList = {}
			}

			for iter_5_4, iter_5_5 in ipairs(var_5_7.chapter_list) do
				if var_5_0[iter_5_5] then
					table.insertto(var_5_8.storyList, var_5_0[iter_5_5].storyList)
				end
			end

			table.insert(arg_5_0.cacaheChapterPlotInfoList_, var_5_8)

			var_5_2[iter_5_2] = #var_5_8.storyList
		end
	end

	for iter_5_6, iter_5_7 in ipairs(arg_5_0.cacaheChapterPlotInfoList_) do
		iter_5_7.all = var_5_2[iter_5_7.chapterID]
		iter_5_7.selType = 1
		iter_5_7.unlockNum = 0

		for iter_5_8, iter_5_9 in ipairs(arg_5_0.cacaheChapterPlotInfoList_[iter_5_6].storyList) do
			if IllustratedData:GetPlotInfo()[iter_5_9] then
				iter_5_7.unlockNum = iter_5_7.unlockNum + 1
			end
		end
	end

	local var_5_9 = #arg_5_0.cacaheChapterPlotInfoList_

	unlockNum = 0

	for iter_5_10, iter_5_11 in ipairs(CollectStoryCfg.get_id_list_by_type[2]) do
		local var_5_10 = CollectStoryCfg[iter_5_11].chapter_client_id

		if not var_5_1[var_5_10] then
			var_5_1[var_5_10] = {}
		end

		table.insert(var_5_1[var_5_10], iter_5_11)
	end

	for iter_5_12, iter_5_13 in pairs(var_5_1) do
		for iter_5_14, iter_5_15 in ipairs(iter_5_13) do
			if IllustratedData:GetPlotInfo()[iter_5_15] then
				unlockNum = unlockNum + 1
			end
		end

		var_5_2[iter_5_12] = #iter_5_13

		table.insert(arg_5_0.cacaheChapterPlotInfoList_, {
			chapterID = iter_5_12,
			storyList = iter_5_13
		})
	end

	for iter_5_16 = var_5_9, #arg_5_0.cacaheChapterPlotInfoList_ do
		local var_5_11 = arg_5_0.cacaheChapterPlotInfoList_[iter_5_16]

		var_5_11.all = var_5_2[var_5_11.chapterID]
		var_5_11.selType = 2
		var_5_11.unlockNum = unlockNum
		var_5_11.chapterClientID = var_5_11.chapterID
	end

	local var_5_12 = #arg_5_0.cacaheChapterPlotInfoList_

	unlockNum = 0

	for iter_5_17, iter_5_18 in ipairs(CollectStoryCfg.get_id_list_by_type[3]) do
		local var_5_13 = iter_5_18

		table.insert(arg_5_0.cacaheChapterPlotInfoList_, {
			chapterID = var_5_13,
			storyList = {
				iter_5_18
			}
		})

		var_5_2[var_5_13] = 1
		unlockNum = 1
	end

	for iter_5_19 = var_5_12, #arg_5_0.cacaheChapterPlotInfoList_ do
		local var_5_14 = arg_5_0.cacaheChapterPlotInfoList_[iter_5_19]

		var_5_14.all = var_5_2[var_5_14.chapterID]
		var_5_14.selType = 3
		var_5_14.unlockNum = unlockNum
	end

	arg_5_0.plotInfoMap_ = {}

	for iter_5_20, iter_5_21 in ipairs(arg_5_0.cacaheChapterPlotInfoList_) do
		arg_5_0.plotInfoMap_[iter_5_21.chapterID] = iter_5_21
	end
end

function var_0_1.AddListeners(arg_6_0)
	var_0_1.super.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.tabBtn1_, nil, function()
		arg_6_0.selectTopTabIndex_ = 1

		arg_6_0:HideOldItem()
		arg_6_0:HideLeftList()
		arg_6_0:RefreshData()
		arg_6_0:RefreshSizeState()
		arg_6_0:RefreshUI(true)
		SetActive(arg_6_0.dropDown_.gameObject, true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.tabBtn2_, nil, function()
		arg_6_0.selectTopTabIndex_ = 2

		arg_6_0:HideOldItem()
		arg_6_0:HideLeftList()
		arg_6_0:RefreshData()
		arg_6_0:RefreshSizeState()
		arg_6_0:RefreshUI(true)
		SetActive(arg_6_0.dropDown_.gameObject, false)
	end)
end

function var_0_1.OnEnter(arg_9_0)
	if not arg_9_0.params_.isBack then
		arg_9_0.selectTopTabIndex_ = arg_9_0.params_.selectTopTabIndex_ or 1
	end

	arg_9_0.tabController_:SetSelectedState("on")
	arg_9_0:InitData()
	var_0_1.super.OnEnter(arg_9_0)
end

function var_0_1.HideOldItem(arg_10_0)
	if arg_10_0.selectTopTabIndex_ == 1 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.collectItemList_) do
			iter_10_1:Show(false)
		end
	else
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.normalItemList_) do
			iter_10_3:Show(false)
		end
	end
end

function var_0_1.RefreshData(arg_11_0)
	arg_11_0.chapterList_ = {}

	if arg_11_0.selectTopTabIndex_ == 1 then
		if arg_11_0.filterType_ == 0 then
			if arg_11_0.sizeState_ == 0 or arg_11_0.sizeState_ == 1 then
				arg_11_0.chapterList_ = ChapterTools.GetNormalPlotAndSubPlotChapterList()
			elseif arg_11_0.sizeState_ == 2 then
				arg_11_0.chapterList_ = ChapterTools.GetChapterClassIDList()
			elseif arg_11_0.sizeState_ == 3 then
				arg_11_0.chapterList_ = ChapterTools.GetBigChapterClassIDList()
			end
		elseif arg_11_0.filterType_ ~= 0 then
			arg_11_0.chapterList_ = ChapterClassSiftCfg[ChapterClassSiftCfg.get_id_list_by_sift_id[arg_11_0.filterType_][arg_11_0.selectTabIndex_]].class_chapter
			arg_11_0.normalIDList_ = ChapterClassSiftCfg.get_id_list_by_sift_id[arg_11_0.filterType_]
		end

		arg_11_0.itemList_ = arg_11_0.normalItemList_
	else
		arg_11_0.normalIDList_ = ChapterClassSiftCfg.get_id_list_by_type[2]
		arg_11_0.chapterList_ = ChapterClassSiftCfg[ChapterClassSiftCfg.get_id_list_by_sift_id[arg_11_0.filterType_][arg_11_0.selectTabIndex_]].collect_story_id
		arg_11_0.itemList_ = arg_11_0.collectItemList_
	end
end

function var_0_1.RefreshUI(arg_12_0, arg_12_1)
	var_0_1.super.RefreshUI(arg_12_0, arg_12_1)
	arg_12_0.tabSelectController_:SetSelectedState(arg_12_0.selectTopTabIndex_)
end

function var_0_1.RefreshListState(arg_13_0)
	var_0_1.super.RefreshListState(arg_13_0)

	if arg_13_0.selectTopTabIndex_ == 2 then
		arg_13_0.listStateController_:SetSelectedState("normalList")
		arg_13_0.normalScrollList_:StartScroll(#arg_13_0.normalIDList_)
	end
end

function var_0_1.ItemClickCallBack(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.sizeState_ == 0 or arg_14_0.sizeState_ == 1 then
		if arg_14_0.selectTopTabIndex_ == 1 then
			local var_14_0 = arg_14_1

			if var_14_0 and ChapterClientCfg[var_14_0] then
				local var_14_1 = ChapterClientCfg[var_14_0].asset_pend_key

				if not manager.assetPend:CheckAssetPend(var_14_1) then
					manager.assetPend:ShowAssetPendMessageBox(var_14_1)

					return
				end
			end
		end

		local var_14_2 = arg_14_2.unlockNum_
		local var_14_3 = arg_14_2.info_

		ChapterTools.SetCacheSelectFilterType(arg_14_0.filterType_, arg_14_0:UIName())
		ChapterTools.SetCacheSelectTabIndex(arg_14_0.selectTabIndex_, arg_14_0:UIName())
		ChapterTools.SetCacheSelectChapterClientID(chapterClientID, arg_14_0:UIName())
		ChapterTools.SetCacheSelectChapterID(cacheChapterID, arg_14_0:UIName())
		JumpTools.OpenPageByJump("/illuPlotDetail", {
			storyList = var_14_3.storyList,
			chapterID = var_14_3.chapterID,
			selType = var_14_3.selType,
			chapterClientID = var_14_3.chapterClientID
		})

		if false then
			if arg_14_0.selectTopTabIndex_ == 1 then
				local var_14_4 = sinfo.storyList[1]
				local var_14_5 = getStageViaStoryID(var_14_4)
				local var_14_6 = getChapterDifficulty(var_14_5)
				local var_14_7 = getChapterClientCfgByStageID(var_14_5).toggle
				local var_14_8, var_14_9 = BattleStageTools.GetChapterSectionIndex(var_14_7, var_14_5)
				local var_14_10 = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_14_6, GetI18NText(var_14_8), GetI18NText(var_14_9))

				ShowTips(var_14_10)
			end
		end
	else
		arg_14_0.slider_.value = arg_14_0.scaleConfig[arg_14_0.sizeState_ - 1].minValue + 0.01
	end
end

function var_0_1.Dispose(arg_15_0)
	var_0_1.super.Dispose(arg_15_0)

	if arg_15_0.normalItemList_ then
		arg_15_0.normalItemList_ = nil

		for iter_15_0, iter_15_1 in ipairs(arg_15_0.collectItemList_) do
			iter_15_1:Dispose()
		end
	end

	if arg_15_0.collectItemList_ then
		arg_15_0.collectItemList_ = nil

		for iter_15_2, iter_15_3 in ipairs(arg_15_0.normalItemList_) do
			iter_15_3:Dispose()
		end
	end

	arg_15_0.itemList_ = nil
	arg_15_0.collectItemList_ = nil
	arg_15_0.normalItemList_ = nil
end

function var_0_1.RefreshSizeState(arg_16_0)
	if arg_16_0.selectTopTabIndex_ == 1 then
		arg_16_0.scaleConfig[3].fixedScale = 1
	else
		arg_16_0.scaleConfig[3].fixedScale = 0.7
	end

	var_0_1.super.RefreshSizeState(arg_16_0)

	if arg_16_0.selectTopTabIndex_ == 2 then
		arg_16_0:RefreshItemSizeState(0)
	end
end

function var_0_1.RefreshItemPosition(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0:CalcStartToEndIndex()
	local var_17_2 = {}
	local var_17_3 = {}

	for iter_17_0 = var_17_0, var_17_1 do
		local var_17_4 = arg_17_0.chapterList_[iter_17_0]
		local var_17_5 = arg_17_0:IsDisplayItem(var_17_4)

		if var_17_5 then
			local var_17_6 = arg_17_0.plotInfoMap_[arg_17_0.chapterList_[iter_17_0]]

			if arg_17_0.selectTopTabIndex_ == 2 then
				arg_17_0.itemList_[var_17_5]:SetSizeState(0)
			end

			arg_17_0.itemList_[var_17_5]:SetID(arg_17_0.chapterList_[iter_17_0])
			arg_17_0.itemList_[var_17_5]:SetLocalPosition(arg_17_0.positionList_[iter_17_0])

			if (arg_17_0.sizeState_ == 0 or arg_17_0.sizeState_ == 1) and var_17_6 then
				arg_17_0.itemList_[var_17_5]:SetInfo(var_17_6)
				arg_17_0.itemList_[var_17_5]:SetUnlockNum(var_17_6.unlockNum)
			end

			table.insert(var_17_2, var_17_5)
		else
			table.insert(var_17_3, iter_17_0)
		end
	end

	for iter_17_1, iter_17_2 in ipairs(var_17_3) do
		for iter_17_3, iter_17_4 in ipairs(arg_17_0.itemList_) do
			if not table.keyof(var_17_2, iter_17_3) then
				local var_17_7 = arg_17_0.plotInfoMap_[arg_17_0.chapterList_[iter_17_2]]

				table.insert(var_17_2, iter_17_3)

				if arg_17_0.selectTopTabIndex_ == 2 then
					iter_17_4:SetSizeState(0)
				end

				iter_17_4:SetID(arg_17_0.chapterList_[iter_17_2])
				iter_17_4:SetLocalPosition(arg_17_0.positionList_[iter_17_2])

				if (arg_17_0.sizeState_ == 0 or arg_17_0.sizeState_ == 1) and var_17_7 then
					iter_17_4:SetInfo(var_17_7)
					iter_17_4:SetUnlockNum(var_17_7.unlockNum)
				end

				break
			end
		end
	end

	for iter_17_5 = 1, #arg_17_0.itemList_ do
		if not table.keyof(var_17_2, iter_17_5) then
			arg_17_0.itemList_[iter_17_5]:Show(false)
		end
	end

	arg_17_0.lineContent_.localPosition = Vector3.New(arg_17_0.itemContentTrs_.localPosition.x, arg_17_0.lineContent_.localPosition.y, arg_17_0.itemContentTrs_.localPosition.z)

	arg_17_0:RefreshAxis()
end

return var_0_1
