local StoryStageItemView = class("StoryStageItemView", ReduxView)

function StoryStageItemView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
	self.clearController_ = ControllerUtil.GetController(self.transform_, "clear")
end

function StoryStageItemView:SetData(arg_2_1, arg_2_2)
	self.selectChapterID_ = arg_2_2
	self.stageID_ = arg_2_1

	self:RefreshLockData(arg_2_1, arg_2_2)
	self:RefreshClearData(arg_2_1)
	self:RefreshUI()
end

function StoryStageItemView:RefreshClearData(arg_3_1, arg_3_2)
	local var_3_0 = StoryStageActivityData:GetStageData(arg_3_2)[arg_3_1]

	self.isClear_ = not not (var_3_0 and var_3_0.clear_times > 0)
end

function StoryStageItemView:RefreshLockData(arg_4_1, arg_4_2)
	self.isLock_ = false

	for iter_4_0, iter_4_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_4_1[1][1] == arg_4_2 and iter_4_1[1][2] == arg_4_1 then
			for iter_4_2, iter_4_3 in ipairs(iter_4_1[2]) do
				self.isLock_ = ChessTools.GetChapterProgress(iter_4_3) < 100

				if self.isLock_ then
					self.preStageID_ = iter_4_3

					return
				end
			end

			return
		end
	end
end

function StoryStageItemView:Dispose()
	StoryStageItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function StoryStageItemView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:OnClick()
	end)
end

function StoryStageItemView:RefreshUI()
	self.transform_.localPosition = Vector3(BattleActivityStoryStageCfg[self.stageID_].position[1], BattleActivityStoryStageCfg[self.stageID_].position[2], 0)
	self.textName_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)

	self:RefreshClear()
	self:Show(true)
end

function StoryStageItemView:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function StoryStageItemView:GetLocalPosition()
	return self.transform_.localPosition
end

function StoryStageItemView:OnClick()
	if self.isLock_ then
		ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[WarchessLevelCfg[self.preStageID_].type].remark, WarchessLevelCfg[self.preStageID_].name_level))
	else
		StoryStageActivityData:SaveHistoryStage(self.selectChapterID_, self.stageID_)
		self:Go("storyStageInfoActivity", {
			chapterID = self.selectChapterID_,
			section = self.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY
		})
	end
end

function StoryStageItemView:SelectorItem(arg_12_1)
	if self.stageID_ == arg_12_1 and self:IsOpenSectionInfo() then
		self.controller_:SetSelectedState("Select")
	else
		self.controller_:SetSelectedState("normal")
	end
end

function StoryStageItemView:RefreshClear()
	if self.isClear_ then
		self.clearController_:SetSelectedState("on")
	else
		self.clearController_:SetSelectedState("off")
	end
end

function StoryStageItemView:IsOpenSectionInfo()
	return self:IsOpenRoute("storyStageInfoActivity")
end

return StoryStageItemView
