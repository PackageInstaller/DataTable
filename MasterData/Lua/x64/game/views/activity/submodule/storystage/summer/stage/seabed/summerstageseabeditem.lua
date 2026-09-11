SummerStageBaseItem = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseItem")

local SummerStageSeabedItem = class("SummerStageSeabedItem", SummerStageBaseItem)

function SummerStageSeabedItem:InitUI()
	SummerStageSeabedItem.super.InitUI(self)

	self.lineController_ = ControllerUtil.GetController(self.transform_, "Item")
end

function SummerStageSeabedItem:RefreshText()
	local var_2_1 = table.keyof(ActivityStoryChapterCfg[self.chapterID_].stage_list, self.stageID_)

	self.text_.text = string.format("%d", var_2_1)

	if var_2_1 - 1 == 0 then
		self.lineController_:SetSelectedState("3-1")
	elseif var_2_1 - 1 == 1 then
		self.lineController_:SetSelectedState("0-1")
	else
		self.lineController_:SetSelectedState(tostring((var_2_1 - 1 - 1) % 4))
	end
end

return SummerStageSeabedItem
