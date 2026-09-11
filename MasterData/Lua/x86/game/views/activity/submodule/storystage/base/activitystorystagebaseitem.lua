local ActivityStoryStageBaseItem = class("ActivityStoryStageBaseItem", ReduxView)

function ActivityStoryStageBaseItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.clearController_ = ControllerUtil.GetController(self.transform_, "clear")
end

function ActivityStoryStageBaseItem:OnEnter()
	return
end

function ActivityStoryStageBaseItem:OnExit()
	return
end

function ActivityStoryStageBaseItem:Dispose()
	ActivityStoryStageBaseItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityStoryStageBaseItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.isOpen_ then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[WarchessLevelCfg[self.preStageID_].type].remark, WarchessLevelCfg[self.preStageID_].name_level))
		else
			StoryStageActivityData:SaveHistoryStage(self.chapterID_, self.stageID_)
			self:Go("storyStageInfoActivity", {
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
				section = self.stageID_,
				chapterID = self.chapterID_
			})
		end
	end)
end

function ActivityStoryStageBaseItem:SetData(arg_7_1, arg_7_2)
	self.stageID_ = arg_7_1
	self.chapterID_ = arg_7_2
	self.preStageID_ = nil

	for iter_7_0, iter_7_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_7_1[1][1] == arg_7_2 and iter_7_1[1][2] == arg_7_1 then
			self.preStageID_ = iter_7_1[2][1]
		end
	end

	local var_7_0 = StoryStageActivityData:GetStageData(self.chapterID_)[self.stageID_]

	if var_7_0 then
		local var_7_1 = 100

		if self.preStageID_ then
			var_7_1 = ChessTools.GetChapterProgress(self.preStageID_)
		end

		self.isLock_ = false
		self.isOpen_ = var_7_1 >= 100
		self.isClear_ = var_7_0.clear_times > 0
	else
		self.isLock_ = true
		self.isOpen_ = false
		self.isClear_ = false
	end

	self:RefreshUI()
end

function ActivityStoryStageBaseItem:RefreshUI()
	local var_8_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_8_0[1], var_8_0[2], 0)
	self.textIndex_.text = string.format("%02d", (table.keyof(ActivityStoryChapterCfg[self.chapterID_].stage_list, self.stageID_)))
	self.textName_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)
	self.imageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityStoryStageCfg[self.stageID_].background_1))

	self:Show(not self.isLock_)
	self:RefreshClear()
end

function ActivityStoryStageBaseItem:GetPosition()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function ActivityStoryStageBaseItem:SelectorItem(arg_10_1)
	return
end

function ActivityStoryStageBaseItem:RefreshClear()
	if self.isClear_ then
		self.clearController_:SetSelectedState("on")
	else
		self.clearController_:SetSelectedState("off")
	end
end

function ActivityStoryStageBaseItem:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function ActivityStoryStageBaseItem:IsOpenSectionInfo()
	return self:IsOpenRoute("storyStageInfoActivity")
end

return ActivityStoryStageBaseItem
