ActivityStoryStageBaseItem = import("game.views.activity.Submodule.storyStage.base.ActivityStoryStageBaseItem")

local ActivityAthenaStoryItem = class("ActivityAthenaStoryItem", ActivityStoryStageBaseItem)

function ActivityAthenaStoryItem:Ctor(...)
	ActivityAthenaStoryItem.super.Ctor(self, ...)

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityAthenaStoryItem:RefreshUI()
	local var_2_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_2_0[1], var_2_0[2], 0)
	self.textIndex_.text = string.format("%02d", (table.keyof(ActivityStoryChapterCfg[self.chapterID_].stage_list, self.stageID_)))

	self:RefreshClear()
end

function ActivityAthenaStoryItem:SelectorItem(arg_3_1)
	if self.stageID_ == arg_3_1 and self:IsOpenSectionInfo() then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

return ActivityAthenaStoryItem
