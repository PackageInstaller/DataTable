SummerStageBaseItem = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseItem")

local SummerStageMainItem = class("SummerStageMainItem", SummerStageBaseItem)

function SummerStageMainItem:InitUI()
	SummerStageMainItem.super.InitUI(self)

	self.lineController_ = ControllerUtil.GetController(self.transform_, "Item")
end

function SummerStageMainItem:RefreshText()
	local var_2_0 = table.keyof(ActivityStoryChapterCfg[self.chapterID_].stage_list, self.stageID_)

	self.text_.text = string.format("%d", var_2_0)

	if var_2_0 - 1 == 0 then
		self.lineController_:SetSelectedState("-1")
	elseif (var_2_0 - 1) % 2 == 0 then
		self.lineController_:SetSelectedState(tostring((var_2_0 - 1) % 2))
	else
		self.lineController_:SetSelectedState(tostring((var_2_0 - 1) % 4))
	end
end

return SummerStageMainItem
