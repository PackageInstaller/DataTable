local IlluPlotDetailItem = class("IlluPlotDetailItem", ReduxView)

function IlluPlotDetailItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluPlotDetailItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluPlotDetailItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "ButItem")
end

function IlluPlotDetailItem:RefreshUI(arg_4_1, arg_4_2)
	self.storyID_ = arg_4_1
	self.type_ = arg_4_2
	self.unlock_ = self:GetIsUnLock(arg_4_1)

	if self.unlock_ then
		local var_4_0 = StoryCfg[arg_4_1]

		if StoryCfg[arg_4_1].videoPath ~= nil and var_4_0.videoPath ~= "" or var_4_0.videoType ~= nil and var_4_0.videoType == 1 or VideoTrackCfg[arg_4_1 .. ".usm"] ~= nil and self.unlock_ ~= nil then
			self.controller_:SetSelectedState("video")
		else
			self.controller_:SetSelectedState("normal")
		end
	else
		self.controller_:SetSelectedState("empty")
	end

	self.nameText_.text = GetI18NText(StoryCfg[arg_4_1].name)
end

function IlluPlotDetailItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:StoryShowTip()
	end)
end

function IlluPlotDetailItem:GetIsUnLock(arg_7_1)
	if arg_7_1 == 101110501 then
		arg_7_1 = 101110401
	end

	return IllustratedData:GetPlotInfo()[arg_7_1]
end

function IlluPlotDetailItem:StoryShowTip()
	if self:GetIsUnLock(self.storyID_) then
		manager.story:StartStoryById(self.storyID_, function(arg_9_0)
			IllustratedAction.ViewIllustration(self.storyID_, CollectConst.PLOT)
			gameContext:Go("/blank")
			gameContext:Back()
		end)
	elseif self.type_ == 1 then
		local var_8_0 = getStageViaStoryID(self.storyID_)
		local var_8_1, var_8_2 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(var_8_0).toggle, var_8_0)

		ShowTips((string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(var_8_0), GetI18NText(var_8_1), GetI18NText(var_8_2))))
	elseif self.type_ == 2 then
		local var_8_3 = string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(StoryCfg[self.storyID_].name))

		ShowTips((self.storyID_ == 101110501 or nil) and string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(StoryCfg[101110401].name)))
	end
end

function IlluPlotDetailItem:Dispose()
	IlluPlotDetailItem.super.Dispose(self)
end

return IlluPlotDetailItem
