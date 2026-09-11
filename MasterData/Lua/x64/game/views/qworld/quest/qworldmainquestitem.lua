local QWorldMainQuestItem = class("QWorldMainQuestItem", ReduxView)

function QWorldMainQuestItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldMainQuestItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldMainQuestItem:InitUI()
	self:BindCfgUI()

	self.trackingController_ = self.conEx_:GetController("tracking")
	self.seriesController_ = self.conEx_:GetController("series")
	self.selectController_ = self.conEx_:GetController("select")
end

function QWorldMainQuestItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.mainQuestId_)
		end
	end)
end

function QWorldMainQuestItem:SetData(arg_6_1)
	self.mainQuestId_ = arg_6_1

	self:RefreshUI()
end

function QWorldMainQuestItem:SetSelected(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function QWorldMainQuestItem:SetClickHandler(arg_8_1)
	self.clickFunc = arg_8_1
end

function QWorldMainQuestItem:RefreshUI()
	local var_9_0 = SandplayTaskMainCfg[self.mainQuestId_]

	if SandplayTaskChapterCfg[SandplayTaskMainCfg[self.mainQuestId_].chapter_task_id] then
		self.seriesText_.text = SandplayTaskChapterCfg[SandplayTaskMainCfg[self.mainQuestId_].chapter_task_id].chapter_name

		self.seriesController_:SetSelectedState("true")
	else
		self.seriesController_:SetSelectedState("false")
	end

	self.titleText_.text = var_9_0.title

	self.trackingController_:SetSelectedState(self.mainQuestId_ == QWorldQuestTool.GetMainQuestTrackingId() and "true" or "false")
end

function QWorldMainQuestItem:Dispose()
	QWorldMainQuestItem.super.Dispose(self)
end

return QWorldMainQuestItem
