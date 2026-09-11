local ChapterPlot19MapView = class("ChapterPlot19MapView", ReduxView)

ChapterPlot19MapView.SCALE_VALUE = 1.2

function ChapterPlot19MapView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.mapItemList_ = {}
	self.locationViewList_ = {}
	self.clueViewList_ = {}
	self.chapterMapScrollView_ = ChapterMapScrollView.New(self, arg_1_1)
	self.chapterSelectLocationHandler_ = handler(self, self.ChapterSelectLocation)
end

function ChapterPlot19MapView:OnEnter()
	manager.notify:RegistListener(CHAPTER_SELECT_LOCATION, self.chapterSelectLocationHandler_)

	if self:GetBackCnt() > 0 then
		self.scrollViewTf_.localScale = Vector3(ChapterPlot19MapView.SCALE_VALUE, ChapterPlot19MapView.SCALE_VALUE, 1)

		self:ChapterSelectLocation()
	else
		self.scrollViewTf_.localScale = Vector3(1, 1, 1)

		self:RefreshItemSelectState(false)
	end
end

function ChapterPlot19MapView:OnExit()
	manager.notify:RemoveListener(CHAPTER_SELECT_LOCATION, self.chapterSelectLocationHandler_)
	self.chapterMapScrollView_:OnExit()
end

function ChapterPlot19MapView:OnUpdate()
	for iter_4_0, iter_4_1 in pairs(self.locationViewList_) do
		if not iter_4_1:IsDisabled() then
			iter_4_1:OnUpdate()
		end
	end

	for iter_4_2, iter_4_3 in pairs(self.clueViewList_) do
		if not iter_4_3:IsDisabled() then
			iter_4_3:OnUpdate()
		end
	end

	self:ScaleMap()
end

function ChapterPlot19MapView:Dispose()
	self.chapterSelectLocationHandler_ = nil

	for iter_5_0, iter_5_1 in pairs(self.mapItemList_) do
		iter_5_1:Dispose()
	end

	self.mapItemList_ = nil

	for iter_5_2, iter_5_3 in pairs(self.locationViewList_) do
		iter_5_3:Dispose()
	end

	self.locationViewList_ = nil

	for iter_5_4, iter_5_5 in pairs(self.clueViewList_) do
		iter_5_5:Dispose()
	end

	self.clueViewList_ = nil

	self.chapterMapScrollView_:Dispose()

	self.chapterMapScrollView_ = nil

	ChapterPlot19MapView.super.Dispose(self)
end

function ChapterPlot19MapView:AddListeners()
	return
end

function ChapterPlot19MapView:SetMapID(arg_7_1, arg_7_2, arg_7_3)
	self.chapterID_ = arg_7_1
	self.mapID_ = arg_7_2

	local var_7_0 = ChapterMapCfg[self.mapID_].map_prefab

	if not self.mapItemList_[ChapterMapCfg[self.mapID_].map_prefab] then
		self.mapItemList_[var_7_0] = ChapterPlot19MapItem.New(var_7_0, self.mapParentTf_)
	end

	for iter_7_0, iter_7_1 in pairs(self.mapItemList_) do
		iter_7_1:Show(iter_7_0 == var_7_0)
	end

	self.mapItemList_[var_7_0]:SetSelectState(ChapterTools.GetChapter19MapState(arg_7_2))
	self.mapItemList_[var_7_0]:PlayAnimator(arg_7_3)

	if ChapterTools.IsNeedShowFog() then
		self:ShowFog(true)
	else
		self:ShowFog(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.mapParentTf_)

	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_2, iter_7_3 in ipairs(ChapterMapCfg[self.mapID_].location_list) do
		if ChapterLocationCfg[iter_7_3].type == BattleConst.LOCATION_TYPE.BUILDING then
			table.insert(var_7_1, iter_7_3)
		else
			table.insert(var_7_2, iter_7_3)
		end
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_1) do
		if self.locationViewList_[iter_7_4] == nil then
			self.locationViewList_[iter_7_4] = ChapterPlot19MapNormalLocation.New(self.stageItem_, self.itemParent_)
		end

		self.locationViewList_[iter_7_4]:SetLocationID(self.chapterID_, arg_7_2, iter_7_5)
	end

	for iter_7_6 = #var_7_1 + 1, #self.locationViewList_ do
		self.locationViewList_[iter_7_6]:Disabled()
	end

	for iter_7_7, iter_7_8 in ipairs(var_7_2) do
		if self.clueViewList_[iter_7_7] == nil then
			self.clueViewList_[iter_7_7] = ChapterPlot19MapClueLocation.New(self.clueItem_, self.itemParent_)
		end

		self.clueViewList_[iter_7_7]:SetLocationID(self.chapterID_, arg_7_2, iter_7_8)
	end

	for iter_7_9 = #var_7_2 + 1, #self.clueViewList_ do
		self.clueViewList_[iter_7_9]:Disabled()
	end
end

function ChapterPlot19MapView:ChapterSelectLocation()
	local var_8_0 = BattleFieldData:GetChapterLocationID(self.chapterID_)

	if var_8_0 == nil then
		return
	end

	local var_8_1 = ChapterLocationCfg[var_8_0].position
	local var_8_2 = ChapterLocationCfg[var_8_0].position[2]

	if self.viewPortRect_.rect.height / 2 > (self.contentRect_.rect.height / 2 - math.abs(ChapterLocationCfg[var_8_0].position[2])) * ChapterPlot19MapView.SCALE_VALUE and self.viewPortRect_.rect.height / 2 <= self.contentRect_.rect.height / 2 and var_8_2 ~= 0 then
		var_8_2 = (self.contentRect_.rect.height / 2 * ChapterPlot19MapView.SCALE_VALUE - self.viewPortRect_.rect.height / 2) / ChapterPlot19MapView.SCALE_VALUE * math.abs(var_8_2) / var_8_2
	end

	local var_8_3 = var_8_1[1] + 200

	if self.viewPortRect_.rect.width / 2 > (self.contentRect_.rect.width / 2 - math.abs(var_8_1[1] + 200)) * ChapterPlot19MapView.SCALE_VALUE and self.viewPortRect_.rect.width / 2 <= self.contentRect_.rect.width / 2 and var_8_3 ~= 0 and math.abs(var_8_3) / var_8_3 < 0 then
		var_8_3 = (self.contentRect_.rect.width / 2 * ChapterPlot19MapView.SCALE_VALUE - self.viewPortRect_.rect.width / 2) / ChapterPlot19MapView.SCALE_VALUE * math.abs(var_8_3) / var_8_3
	end

	self.chapterMapScrollView_:ScrollToPosition(Vector3(var_8_3, var_8_2, 0))
	self:RefreshItemSelectState(true)
end

function ChapterPlot19MapView:ResetMapPosition()
	self.scrollView_.normalizedPosition = Vector2(0.5, 0.5)
end

function ChapterPlot19MapView:RefreshItemSelectState(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.locationViewList_) do
		iter_10_1:RefreshSelectState(arg_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs(self.clueViewList_) do
		iter_10_3:RefreshSelectState(arg_10_1)
	end
end

function ChapterPlot19MapView:ScaleMap()
	if self:GetBackCnt() > 0 then
		self:CancelTween()
		LeanTween.scale(self.scrollViewTf_, Vector3(ChapterPlot19MapView.SCALE_VALUE, ChapterPlot19MapView.SCALE_VALUE, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
		self:ChapterSelectLocation()
	else
		self.chapterMapScrollView_:EnabledScroll(true)
		self:CancelTween()
		LeanTween.scale(self.scrollViewTf_, Vector3(1, 1, 1), 0.5):setEase(LeanTweenType.easeOutCubic)
		self:RefreshItemSelectState(false)
	end
end

function ChapterPlot19MapView:CancelTween()
	if self.leanTween_ then
		LeanTween.cancel(self.scrollViewTf_)

		self.leanTween_ = nil
	end
end

function ChapterPlot19MapView:ShowFog(arg_13_1)
	if arg_13_1 == false and ChapterTools.NeedPlayFogAnimator() then
		self.mapItemList_[ChapterMapCfg[self.mapID_].map_prefab]:SetFogState(true)
		self.mapItemList_[ChapterMapCfg[self.mapID_].map_prefab]:SetLineState(true)
		BattleStageData:SaveFogAnimatorFlag(true)
		self.mapItemList_[ChapterMapCfg[self.mapID_].map_prefab]:PlayFogAnimator()
	else
		self.mapItemList_[ChapterMapCfg[self.mapID_].map_prefab]:SetFogState(arg_13_1)
		self.mapItemList_[ChapterMapCfg[self.mapID_].map_prefab]:SetLineState(arg_13_1)
	end
end

function ChapterPlot19MapView:GetBackCnt()
	local var_14_0 = 0

	if self:IsOpenRoute("chapterPlot19MapLocationInfo") then
		var_14_0 = var_14_0 + 1
	end

	if self:IsOpenRoute("chapter19SectionInfo") then
		var_14_0 = var_14_0 + 1
	end

	return var_14_0
end

return ChapterPlot19MapView
