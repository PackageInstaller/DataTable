SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local SubPlotTyrItem = class("SubPlotTyrItem", SubPlotBaseItem)

function SubPlotTyrItem:Ctor(...)
	SubPlotTyrItem.super.Ctor(self, ...)

	self.lineController_ = ControllerUtil.GetController(self.transform_, "connect")
end

function SubPlotTyrItem:RefreshCustomUI()
	self.textIndex_.text = GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)

	local var_2_0 = table.keyof(ChapterCfg[self.chapterID_].section_id_list, self.stageID_)

	if var_2_0 == 1 then
		self.lineController_:SetSelectedState("01")
	elseif var_2_0 % 2 == 0 then
		self.lineController_:SetSelectedState("02")
	else
		self.lineController_:SetSelectedState("03")
	end
end

return SubPlotTyrItem
