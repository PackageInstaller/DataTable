SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local SubPlotHeraItem = class("SubPlotHeraItem", SubPlotBaseItem)

function SubPlotHeraItem:Ctor(...)
	SubPlotHeraItem.super.Ctor(self, ...)

	self.lineController_ = ControllerUtil.GetController(self.transform_, "connect")
end

function SubPlotHeraItem:RefreshCustomUI()
	local var_2_0 = table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)

	self.textIndex_.text = string.format("%02d", var_2_0)

	if var_2_0 == 1 then
		self.lineController_:SetSelectedState("01")
	elseif var_2_0 % 2 == 0 then
		self.lineController_:SetSelectedState("02")
	else
		self.lineController_:SetSelectedState("03")
	end
end

return SubPlotHeraItem
