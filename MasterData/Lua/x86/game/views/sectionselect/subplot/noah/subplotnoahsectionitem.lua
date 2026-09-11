local SubPlotNoahSectionItem = class("SubPlotNoahSectionItem", ReduxView)

function SubPlotNoahSectionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SubPlotNoahSectionItem:Init()
	self:InitUI()
	self:AddListeners()
end

function SubPlotNoahSectionItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClick()
	end)
end

function SubPlotNoahSectionItem:OnClick()
	if self.isLock_ then
		-- block empty
	else
		self:Go("subPlotSectionInfo", {
			section = self.stageID_,
			chapterID = self.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function SubPlotNoahSectionItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controller_:GetController("select")
	self.lockController_ = self.controller_:GetController("lock")
	self.threeStarBarList_ = {}

	for iter_6_0 = 1, 3 do
		self.threeStarBarList_[iter_6_0] = SectionThreeStarBar.New(self[string.format("starGo%s_", iter_6_0)])
	end
end

function SubPlotNoahSectionItem:SetData(arg_7_1, arg_7_2)
	self.chapterID_ = arg_7_1
	self.stageID_ = arg_7_2

	self:UpdateData()
	self:RefreshUI()
end

function SubPlotNoahSectionItem:UpdateData()
	local var_8_0 = BattleStageData:GetStageData()[self.stageID_]

	if var_8_0 then
		self.isLock_ = false
		self.clearTimes_ = var_8_0.clear_times
	else
		self.clearTimes_ = 0

		if table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_) == 1 then
			self.isLock_ = false
		else
			self.isLock_ = not self:IsUnlockPreStage()
		end

		self.clearTimes_ = 0
	end
end

function SubPlotNoahSectionItem:IsUnlockPreStage()
	local var_9_0 = BattleStageData:GetStageData()

	if BattleActivityStoryStageCfg[self.stageID_].pre_show_id_list == nil then
		print(string.format("关卡 %s 未配置前置关卡", self.stageID_))

		return true
	end

	for iter_9_0, iter_9_1 in pairs(BattleActivityStoryStageCfg[self.stageID_].pre_show_id_list) do
		if var_9_0[iter_9_1] and var_9_0[iter_9_1].clear_times > 0 then
			return true
		end
	end

	return false
end

function SubPlotNoahSectionItem:RefreshUI()
	self:RefreshText()
	self:RefreshStar()
	self:RefreshLock()
end

function SubPlotNoahSectionItem:RefreshStar()
	if self.clearTimes_ >= 1 then
		for iter_11_0 = 1, 3 do
			self.threeStarBarList_[iter_11_0]:SetData(true)
		end
	else
		for iter_11_1 = 1, 3 do
			self.threeStarBarList_[iter_11_1]:SetData(false)
		end
	end
end

function SubPlotNoahSectionItem:RefreshText()
	if self.stageID_ then
		self.nameText_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)
	end
end

function SubPlotNoahSectionItem:RefreshLock()
	self.lockController_:SetSelectedState(self.isLock_ and "lock" or "normal")
end

function SubPlotNoahSectionItem:SelectorItem(arg_14_1)
	if self.stageID_ == arg_14_1 and self:IsOpenSectionInfo() then
		self.selectController_:SetSelectedState("state1")
	else
		self.selectController_:SetSelectedState("state0")
	end
end

function SubPlotNoahSectionItem:OnExit()
	return
end

function SubPlotNoahSectionItem:Dispose()
	for iter_16_0, iter_16_1 in ipairs(self.threeStarBarList_) do
		iter_16_1:Dispose()
	end

	self.threeStarBarList_ = nil

	SubPlotNoahSectionItem.super.Dispose(self)
end

function SubPlotNoahSectionItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

return SubPlotNoahSectionItem
