local DailyReportFurnitureComp = class("DailyReportFurnitureComp", require("app.fairyGUI.dailyReport.UI_DailyReportFurnitureComp"))

function DailyReportFurnitureComp:ctor()
	fgui.UIPackage:addPackage("ui/furniture/furniture")
	self.m_furnitureComp:setVisible(false)
end

function DailyReportFurnitureComp:updateFurniture(arg_2_1)
	g.core.model.User.furnitureData:setDailyReportFurniture(arg_2_1)
	self.m_furnitureComp:setVisible(true)
	self.m_furnitureComp:updateFurnitureCompWithDailyReport()
end

return DailyReportFurnitureComp
