local OutpostBuildDailyReportCell = class("OutpostBuildDailyReportCell", require("app.fairyGUI.outpost.UI_OutpostBuildDailyReportCell"))

function OutpostBuildDailyReportCell:updateDailyCell(arg_1_1)
	self.m_title:setText(arg_1_1)
end

return OutpostBuildDailyReportCell
