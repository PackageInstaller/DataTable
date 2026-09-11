local OsirisStoryStageItem = class("OsirisStoryStageItem", ReduxView)

function OsirisStoryStageItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.transform_.name = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.clearController_ = ControllerUtil.GetController(self.transform_, "clear")

	self:SetData(arg_1_2, arg_1_3)
end

function OsirisStoryStageItem:Dispose()
	OsirisStoryStageItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function OsirisStoryStageItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:OnClick()
	end)
end

function OsirisStoryStageItem:SetData(arg_5_1, arg_5_2)
	self.stageID_ = arg_5_1
	self.chapterID_ = arg_5_2
	self.preStageID_ = nil

	for iter_5_0, iter_5_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_5_1[1][1] == arg_5_2 and iter_5_1[1][2] == arg_5_1 then
			self.preStageID_ = iter_5_1[2][1]
		end
	end

	self:RefreshData()
	self:RefreshUI()
end

function OsirisStoryStageItem:IsOpenSectionInfo()
	return self:IsOpenRoute("osirisStoryStageInfo")
end

function OsirisStoryStageItem:GetPosition()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function OsirisStoryStageItem:RefreshData()
	local var_8_0 = StoryStageActivityData:GetStageData(self.chapterID_)[self.stageID_]

	if var_8_0 then
		local var_8_1 = 100

		if self.preStageID_ then
			var_8_1 = ChessTools.GetChapterProgress(self.preStageID_)
		end

		self.isLock_ = false
		self.isOpen_ = var_8_1 >= 100
		self.isClear_ = var_8_0.clear_times > 0
	else
		self.isLock_ = true
		self.isOpen_ = false
		self.isClear_ = false
	end
end

function OsirisStoryStageItem:OnClick()
	if not self.isOpen_ then
		ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityCfg[WarchessLevelCfg[self.preStageID_].type].remark), WarchessLevelCfg[self.preStageID_].name_level))
	else
		StoryStageActivityData:SaveHistoryStage(self.chapterID_, self.stageID_)
		self:Go("osirisStoryStageInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
			section = self.stageID_,
			chapterID = self.chapterID_
		})
	end
end

function OsirisStoryStageItem:RefreshUI()
	local var_10_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_10_0[1], var_10_0[2], 0)
	self.textIndex_.text = string.format("%02d", (table.keyof(ActivityStoryChapterCfg[self.chapterID_].stage_list, self.stageID_)))
	self.textName_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)
	self.imageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityStoryStageCfg[self.stageID_].background_1))

	self:Show(not self.isLock_)
	self:RefreshClear()
end

function OsirisStoryStageItem:GetLocalPosition()
	return self.transform_.localPosition
end

function OsirisStoryStageItem:SelectorItem(arg_12_1)
	if self.stageID_ == arg_12_1 and self:IsOpenSectionInfo() then
		SetActive(self.selectGo_, true)
	else
		SetActive(self.selectGo_, false)
	end
end

function OsirisStoryStageItem:RefreshClear()
	if self.isClear_ then
		self.clearController_:SetSelectedState("on")
	else
		self.clearController_:SetSelectedState("off")
	end
end

function OsirisStoryStageItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

return OsirisStoryStageItem
