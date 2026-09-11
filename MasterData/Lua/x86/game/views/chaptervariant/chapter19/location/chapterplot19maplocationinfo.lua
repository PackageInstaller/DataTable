local ChapterPlot19MapLocationInfo = class("ChapterPlot19MapLocationInfo", ReduxView)

function ChapterPlot19MapLocationInfo:UIName()
	return "Widget/System/Operation/ChapterVerStageListInfoUI"
end

function ChapterPlot19MapLocationInfo:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterPlot19MapLocationInfo:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.titleView_ = ChapterPlot19MapLocationTitleItem.New(self.titleItem_)
	self.eventTitleView_ = ChapterPlot19MapLocationTitleItem.New(self.eventTitleItem_)
	self.finishTitleView_ = ChapterPlot19MapLocationTitleItem.New(self.finishTitleItem_)
	self.stageItemList_ = {}
end

function ChapterPlot19MapLocationInfo:OnEnter()
	self:SetData()
	self:RefreshUI()
end

function ChapterPlot19MapLocationInfo:SetData()
	self.chapterID_ = self.params_.chapterID
	self.locationID_ = self.params_.locationID
end

function ChapterPlot19MapLocationInfo:OnUpdate()
	self:SetData()
	self:RefreshUI()
end

function ChapterPlot19MapLocationInfo:OnExit()
	return
end

function ChapterPlot19MapLocationInfo:Dispose()
	ChapterPlot19MapLocationInfo.super.Dispose(self)
	self.titleView_:Dispose()

	self.titleView_ = nil

	self.eventTitleView_:Dispose()

	self.eventTitleView_ = nil

	self.finishTitleView_:Dispose()

	self.finishTitleView_ = nil

	for iter_8_0, iter_8_1 in ipairs(self.stageItemList_) do
		iter_8_1:Dispose()
	end

	self.stageItemList_ = nil
end

function ChapterPlot19MapLocationInfo:AddListeners()
	return
end

function ChapterPlot19MapLocationInfo:RefreshUI()
	self.nameText_.text = ChapterLocationCfg[self.locationID_].name

	local var_10_0, var_10_1, var_10_2 = self:GetSortStageList()

	if #var_10_0 > 0 then
		self.titleView_:Show(true)
	else
		self.titleView_:Show(false)
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		self.stageItemList_[iter_10_0] = self.stageItemList_[iter_10_0] or ChapterPlot19MapLocationStageItem.New(self.stageItem_, self.parentGo_)

		self.stageItemList_[iter_10_0]:SetData(self.chapterID_, iter_10_1)
	end

	if #var_10_1 > 0 then
		self.eventTitleView_:Show(true)
	else
		self.eventTitleView_:Show(false)
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_1) do
		self.stageItemList_[iter_10_2 + #var_10_0] = self.stageItemList_[iter_10_2 + #var_10_0] or ChapterPlot19MapLocationStageItem.New(self.stageItem_, self.parentGo_)

		self.stageItemList_[iter_10_2 + #var_10_0]:SetData(self.chapterID_, iter_10_3)
	end

	if #var_10_2 > 0 then
		self.finishTitleView_:Show(true)
	else
		self.finishTitleView_:Show(false)
	end

	for iter_10_4, iter_10_5 in ipairs(var_10_2) do
		self.stageItemList_[iter_10_4 + #var_10_0 + #var_10_1] = self.stageItemList_[iter_10_4 + #var_10_0 + #var_10_1] or ChapterPlot19MapLocationStageItem.New(self.stageItem_, self.parentGo_)

		self.stageItemList_[iter_10_4 + #var_10_0 + #var_10_1]:SetData(self.chapterID_, iter_10_5)
	end

	for iter_10_6 = #var_10_0 + #var_10_1 + #var_10_2 + 1, #self.stageItemList_ do
		self.stageItemList_[iter_10_6]:Show(false)
	end
end

function ChapterPlot19MapLocationInfo:OnTop()
	self:Show(true)
end

function ChapterPlot19MapLocationInfo:OnBehind()
	self:Show(false)
end

function ChapterPlot19MapLocationInfo:Show(arg_13_1)
	SetActive(self.gameObjet_, arg_13_1)
end

function ChapterPlot19MapLocationInfo:GetSortStageList()
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(ChapterLocationCfg[self.locationID_].stage_list) do
		local var_14_3 = BattleStageData:GetStageData()[iter_14_1]

		if var_14_3 and var_14_3.clear_times > 0 then
			table.insert(var_14_2, {
				id = iter_14_1,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY
			})
		elseif var_14_3 then
			table.insert(var_14_0, {
				id = iter_14_1,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY
			})
		end
	end

	for iter_14_2, iter_14_3 in ipairs(ChapterLocationCfg[self.locationID_].sub_stage_list) do
		local var_14_4 = BattleStageData:GetStageData()[iter_14_3]

		if var_14_4 and var_14_4.clear_times > 0 then
			table.insert(var_14_2, {
				id = iter_14_3,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.SIDE_STORY
			})
		elseif var_14_4 then
			table.insert(var_14_0, {
				id = iter_14_3,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.SIDE_STORY
			})
		end
	end

	for iter_14_4, iter_14_5 in ipairs(ChapterLocationCfg[self.locationID_].event_list) do
		if BattleStageData:HasReadLocationEvent(iter_14_5) then
			table.insert(var_14_2, {
				id = iter_14_5,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.EVENT
			})
		elseif ChapterTools.IsUnlockEvent(iter_14_5) then
			table.insert(var_14_1, {
				id = iter_14_5,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.EVENT
			})
		end
	end

	return var_14_0, var_14_1, var_14_2
end

return ChapterPlot19MapLocationInfo
