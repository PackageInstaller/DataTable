local ActivityFactoryStoryItem = class("ActivityFactoryStoryItem", ReduxView)

function ActivityFactoryStoryItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.clearController_ = ControllerUtil.GetController(self.transform_, "clear")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.lineController_ = ControllerUtil.GetController(self.transform_, "line")
end

function ActivityFactoryStoryItem:OnExit()
	if self.archiveView_ then
		self.archiveView_:OnExit()
	end

	self:Show(false)
end

function ActivityFactoryStoryItem:Dispose()
	if self.archiveView_ then
		self.archiveView_:Dispose()

		self.archiveView_ = nil
	end

	ActivityFactoryStoryItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityFactoryStoryItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		BattleFieldData:SetCacheStage(self.chapterID_, self.stageID_)
		self:Go("subPlotSectionInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT,
			chapterID = self.chapterID_,
			section = self.stageID_
		})
	end)
end

function ActivityFactoryStoryItem:SetData(arg_6_1, arg_6_2)
	self.stageID_ = arg_6_1
	self.chapterID_ = arg_6_2

	local var_6_0 = BattleStageData:GetStageData()[self.stageID_]

	self.isClear_ = false

	if var_6_0 and var_6_0.clear_times > 0 then
		self.isClear_ = true
	end

	self:RefreshUI()
end

function ActivityFactoryStoryItem:RefreshUI()
	local var_7_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_7_0[1], var_7_0[2], 0)
	self.textIndex_.text = string.format("%02d", (table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)))
	self.textName_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)

	self:RefreshClear()
	self:RefreshArchive()
	self:Show(true)
end

function ActivityFactoryStoryItem:GetPosition()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function ActivityFactoryStoryItem:SelectorItem(arg_9_1)
	if self.stageID_ == arg_9_1 and self:IsOpenSectionInfo() then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function ActivityFactoryStoryItem:RefreshClear()
	if self.isClear_ then
		self.clearController_:SetSelectedState("on")
	else
		self.clearController_:SetSelectedState("off")
	end
end

function ActivityFactoryStoryItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function ActivityFactoryStoryItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function ActivityFactoryStoryItem:RefreshArchive()
	self.lineController_:SetSelectedState("hide")
end

function ActivityFactoryStoryItem:GetLocalPosition()
	return self.transform_.localPosition
end

return ActivityFactoryStoryItem
