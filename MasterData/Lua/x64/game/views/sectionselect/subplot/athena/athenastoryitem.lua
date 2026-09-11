SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local AthenaStoryItem = class("AthenaStoryItem", SubPlotBaseItem)

function AthenaStoryItem:Ctor(...)
	AthenaStoryItem.super.Ctor(self, ...)

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function AthenaStoryItem:RefreshCustomUI()
	local var_2_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_2_0[1], var_2_0[2], 0)
	self.textIndex_.text = string.format("%02d", (table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)))
end

function AthenaStoryItem:Show(arg_3_1)
	return
end

function AthenaStoryItem:SelectorItem(arg_4_1)
	if self.stageID_ == arg_4_1 and self:IsOpenSectionInfo() then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

return AthenaStoryItem
