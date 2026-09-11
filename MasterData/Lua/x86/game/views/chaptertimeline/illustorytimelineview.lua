local IlluStoryTimeLineView = class("IlluStoryTimeLineView", (import("game.views.chapterTimeLine.StoryTimelineBaseView")))

function IlluStoryTimeLineView:UIName()
	return "Widget/System/IllustratedHandbook/Illustrated_StoryLine/Illustrated_StoryLineMainUI"
end

function IlluStoryTimeLineView:UIParent()
	return manager.ui.uiMain.transform
end

function IlluStoryTimeLineView:Init()
	IlluStoryTimeLineView.super.Init(self)
end

function IlluStoryTimeLineView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.controller_:GetController("tab")
	self.tabSelectController_ = self.tabControllerEx_:GetController("tab")
	self.itemList_ = {}
	self.normalItemList_ = {}
	self.collectItemList_ = {}

	local var_4_0 = math.ceil(_G.SCREEN_WIDTH / (self.itemTrs_.rect.width * 0.6)) + 2

	self.itemClickCallBack_ = handler(self, self.ItemClickCallBack)

	for iter_4_0 = 1, var_4_0 do
		self.normalItemList_[iter_4_0] = StoryTimeLineNormalIllutItemView.New(self.item_, self.itemContentTrs_)

		self.normalItemList_[iter_4_0]:SetClickCallBack(self.itemClickCallBack_)
	end

	for iter_4_1 = 1, var_4_0 do
		self.collectItemList_[iter_4_1] = StoryTimeLineIllutItemView.New(self.item_, self.itemContentTrs_)

		self.collectItemList_[iter_4_1]:SetClickCallBack(self.itemClickCallBack_)
	end

	self:AddListeners()

	self.preLayoutSpacing = self.layoutGroup_.spacing
end

function IlluStoryTimeLineView:InitData()
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}

	self.cacaheChapterPlotInfoList_ = {}

	for iter_5_0, iter_5_1 in ipairs(CollectStoryCfg.get_id_list_by_type[1]) do
		if StoryCfg[iter_5_1] and StoryCfg[iter_5_1].trigger[2] then
			local var_5_4 = getChapterIDByStageID(StoryCfg[iter_5_1].trigger[2])

			if var_5_4 then
				var_5_0[var_5_4] = var_5_0[var_5_4] or {
					chapterID = var_5_4,
					storyList = {}
				}

				table.insert(var_5_0[var_5_4].storyList, StoryCfg[iter_5_1].id)
			end
		end
	end

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		if ChapterClientCfg[iter_5_2] then
			local var_5_5 = {
				chapterID = iter_5_2,
				storyList = {}
			}

			for iter_5_4, iter_5_5 in ipairs(ChapterClientCfg[iter_5_2].chapter_list) do
				if var_5_0[iter_5_5] then
					table.insertto(var_5_5.storyList, var_5_0[iter_5_5].storyList)
				end
			end

			table.insert(self.cacaheChapterPlotInfoList_, var_5_5)

			var_5_2[iter_5_2] = #var_5_5.storyList
		end
	end

	for iter_5_6, iter_5_7 in ipairs(self.cacaheChapterPlotInfoList_) do
		iter_5_7.all = var_5_2[iter_5_7.chapterID]
		iter_5_7.selType = 1
		iter_5_7.unlockNum = 0

		for iter_5_8, iter_5_9 in ipairs(self.cacaheChapterPlotInfoList_[iter_5_6].storyList) do
			if IllustratedData:GetPlotInfo()[iter_5_9] then
				iter_5_7.unlockNum = iter_5_7.unlockNum + 1
			end
		end
	end

	unlockNum = 0

	for iter_5_10, iter_5_11 in ipairs(CollectStoryCfg.get_id_list_by_type[2]) do
		var_5_1[CollectStoryCfg[iter_5_11].chapter_client_id] = var_5_1[CollectStoryCfg[iter_5_11].chapter_client_id] or {}

		table.insert(var_5_1[CollectStoryCfg[iter_5_11].chapter_client_id], iter_5_11)
	end

	for iter_5_12, iter_5_13 in pairs(var_5_1) do
		for iter_5_14, iter_5_15 in ipairs(iter_5_13) do
			if IllustratedData:GetPlotInfo()[iter_5_15] then
				unlockNum = unlockNum + 1
			end
		end

		var_5_2[iter_5_12] = #iter_5_13

		table.insert(self.cacaheChapterPlotInfoList_, {
			chapterID = iter_5_12,
			storyList = iter_5_13
		})
	end

	for iter_5_16 = #self.cacaheChapterPlotInfoList_, #self.cacaheChapterPlotInfoList_ do
		self.cacaheChapterPlotInfoList_[iter_5_16].all = var_5_2[self.cacaheChapterPlotInfoList_[iter_5_16].chapterID]
		self.cacaheChapterPlotInfoList_[iter_5_16].selType = 2
		self.cacaheChapterPlotInfoList_[iter_5_16].unlockNum = unlockNum
		self.cacaheChapterPlotInfoList_[iter_5_16].chapterClientID = self.cacaheChapterPlotInfoList_[iter_5_16].chapterID
	end

	unlockNum = 0

	for iter_5_17, iter_5_18 in ipairs(CollectStoryCfg.get_id_list_by_type[3]) do
		table.insert(self.cacaheChapterPlotInfoList_, {
			chapterID = iter_5_18,
			storyList = {
				iter_5_18
			}
		})

		var_5_2[iter_5_18] = 1
		unlockNum = 1
	end

	for iter_5_19 = #self.cacaheChapterPlotInfoList_, #self.cacaheChapterPlotInfoList_ do
		self.cacaheChapterPlotInfoList_[iter_5_19].all = var_5_2[self.cacaheChapterPlotInfoList_[iter_5_19].chapterID]
		self.cacaheChapterPlotInfoList_[iter_5_19].selType = 3
		self.cacaheChapterPlotInfoList_[iter_5_19].unlockNum = unlockNum
	end

	self.plotInfoMap_ = {}

	for iter_5_20, iter_5_21 in ipairs(self.cacaheChapterPlotInfoList_) do
		self.plotInfoMap_[iter_5_21.chapterID] = iter_5_21
	end
end

function IlluStoryTimeLineView:AddListeners()
	IlluStoryTimeLineView.super.AddListeners(self)
	self:AddBtnListener(self.tabBtn1_, nil, function()
		self.selectTopTabIndex_ = 1

		self:HideOldItem()
		self:HideLeftList()
		self:RefreshData()
		self:RefreshSizeState()
		self:RefreshUI(true)
		SetActive(self.dropDown_.gameObject, true)
	end)
	self:AddBtnListener(self.tabBtn2_, nil, function()
		self.selectTopTabIndex_ = 2

		self:HideOldItem()
		self:HideLeftList()
		self:RefreshData()
		self:RefreshSizeState()
		self:RefreshUI(true)
		SetActive(self.dropDown_.gameObject, false)
	end)
end

function IlluStoryTimeLineView:OnEnter()
	if not self.params_.isBack then
		self.selectTopTabIndex_ = self.params_.selectTopTabIndex_ or 1
	end

	self.tabController_:SetSelectedState("on")
	self:InitData()
	IlluStoryTimeLineView.super.OnEnter(self)
end

function IlluStoryTimeLineView:HideOldItem()
	if self.selectTopTabIndex_ == 1 then
		for iter_10_0, iter_10_1 in ipairs(self.collectItemList_) do
			iter_10_1:Show(false)
		end
	else
		for iter_10_2, iter_10_3 in ipairs(self.normalItemList_) do
			iter_10_3:Show(false)
		end
	end
end

function IlluStoryTimeLineView:RefreshData()
	self.chapterList_ = {}

	if self.selectTopTabIndex_ == 1 then
		if self.filterType_ == 0 then
			if self.sizeState_ == 0 or self.sizeState_ == 1 then
				self.chapterList_ = ChapterTools.GetNormalPlotAndSubPlotChapterList()
			elseif self.sizeState_ == 2 then
				self.chapterList_ = ChapterTools.GetChapterClassIDList()
			elseif self.sizeState_ == 3 then
				self.chapterList_ = ChapterTools.GetBigChapterClassIDList()
			end
		elseif self.filterType_ ~= 0 then
			self.chapterList_ = ChapterClassSiftCfg[ChapterClassSiftCfg.get_id_list_by_sift_id[self.filterType_][self.selectTabIndex_]].class_chapter
			self.normalIDList_ = ChapterClassSiftCfg.get_id_list_by_sift_id[self.filterType_]
		end

		self.itemList_ = self.normalItemList_
	else
		self.normalIDList_ = ChapterClassSiftCfg.get_id_list_by_type[2]
		self.chapterList_ = ChapterClassSiftCfg[ChapterClassSiftCfg.get_id_list_by_sift_id[self.filterType_][self.selectTabIndex_]].collect_story_id
		self.itemList_ = self.collectItemList_
	end
end

function IlluStoryTimeLineView:RefreshUI(arg_12_1)
	IlluStoryTimeLineView.super.RefreshUI(self, arg_12_1)
	self.tabSelectController_:SetSelectedState(self.selectTopTabIndex_)
end

function IlluStoryTimeLineView:RefreshListState()
	IlluStoryTimeLineView.super.RefreshListState(self)

	if self.selectTopTabIndex_ == 2 then
		self.listStateController_:SetSelectedState("normalList")
		self.normalScrollList_:StartScroll(#self.normalIDList_)
	end
end

function IlluStoryTimeLineView:ItemClickCallBack(arg_14_1, arg_14_2)
	if self.sizeState_ == 0 or self.sizeState_ == 1 then
		if self.selectTopTabIndex_ == 1 then
			if arg_14_1 and ChapterClientCfg[arg_14_1] then
				if not manager.assetPend:CheckAssetPend(ChapterClientCfg[arg_14_1].asset_pend_key) then
					manager.assetPend:ShowAssetPendMessageBox(ChapterClientCfg[arg_14_1].asset_pend_key)

					return
				end
			end
		end

		ChapterTools.SetCacheSelectFilterType(self.filterType_, self:UIName())
		ChapterTools.SetCacheSelectTabIndex(self.selectTabIndex_, self:UIName())
		ChapterTools.SetCacheSelectChapterClientID(chapterClientID, self:UIName())
		ChapterTools.SetCacheSelectChapterID(cacheChapterID, self:UIName())
		JumpTools.OpenPageByJump("/illuPlotDetail", {
			storyList = arg_14_2.info_.storyList,
			chapterID = arg_14_2.info_.chapterID,
			selType = arg_14_2.info_.selType,
			chapterClientID = arg_14_2.info_.chapterClientID
		})
	else
		self.slider_.value = self.scaleConfig[self.sizeState_ - 1].minValue + 0.01
	end
end

function IlluStoryTimeLineView:Dispose()
	IlluStoryTimeLineView.super.Dispose(self)

	if self.normalItemList_ then
		self.normalItemList_ = nil

		for iter_15_0, iter_15_1 in ipairs(self.collectItemList_) do
			iter_15_1:Dispose()
		end
	end

	if self.collectItemList_ then
		self.collectItemList_ = nil

		for iter_15_2, iter_15_3 in ipairs(self.normalItemList_) do
			iter_15_3:Dispose()
		end
	end

	self.itemList_ = nil
	self.collectItemList_ = nil
	self.normalItemList_ = nil
end

function IlluStoryTimeLineView:RefreshSizeState()
	self.scaleConfig[3].fixedScale = self.selectTopTabIndex_ == 1 and 1 or 0.7

	IlluStoryTimeLineView.super.RefreshSizeState(self)

	if self.selectTopTabIndex_ == 2 then
		self:RefreshItemSizeState(0)
	end
end

function IlluStoryTimeLineView:RefreshItemPosition()
	local var_17_0, var_17_1 = self:CalcStartToEndIndex()
	local var_17_2 = {}
	local var_17_3 = {}

	for iter_17_0 = var_17_0, var_17_1 do
		local var_17_4 = self:IsDisplayItem(self.chapterList_[iter_17_0])

		if var_17_4 then
			if self.selectTopTabIndex_ == 2 then
				self.itemList_[var_17_4]:SetSizeState(0)
			end

			self.itemList_[var_17_4]:SetID(self.chapterList_[iter_17_0])
			self.itemList_[var_17_4]:SetLocalPosition(self.positionList_[iter_17_0])

			if (self.sizeState_ == 0 or self.sizeState_ == 1) and self.plotInfoMap_[self.chapterList_[iter_17_0]] then
				self.itemList_[var_17_4]:SetInfo(self.plotInfoMap_[self.chapterList_[iter_17_0]])
				self.itemList_[var_17_4]:SetUnlockNum(self.plotInfoMap_[self.chapterList_[iter_17_0]].unlockNum)
			end

			table.insert(var_17_2, var_17_4)
		else
			table.insert(var_17_3, iter_17_0)
		end
	end

	for iter_17_1, iter_17_2 in ipairs(var_17_3) do
		for iter_17_3, iter_17_4 in ipairs(self.itemList_) do
			if not table.keyof(var_17_2, iter_17_3) then
				table.insert(var_17_2, iter_17_3)

				if self.selectTopTabIndex_ == 2 then
					iter_17_4:SetSizeState(0)
				end

				iter_17_4:SetID(self.chapterList_[iter_17_2])
				iter_17_4:SetLocalPosition(self.positionList_[iter_17_2])

				if (self.sizeState_ == 0 or self.sizeState_ == 1) and self.plotInfoMap_[self.chapterList_[iter_17_2]] then
					iter_17_4:SetInfo(self.plotInfoMap_[self.chapterList_[iter_17_2]])
					iter_17_4:SetUnlockNum(self.plotInfoMap_[self.chapterList_[iter_17_2]].unlockNum)
				end

				break
			end
		end
	end

	for iter_17_5 = 1, #self.itemList_ do
		if not table.keyof(var_17_2, iter_17_5) then
			self.itemList_[iter_17_5]:Show(false)
		end
	end

	self.lineContent_.localPosition = Vector3.New(self.itemContentTrs_.localPosition.x, self.lineContent_.localPosition.y, self.itemContentTrs_.localPosition.z)

	self:RefreshAxis()
end

return IlluStoryTimeLineView
