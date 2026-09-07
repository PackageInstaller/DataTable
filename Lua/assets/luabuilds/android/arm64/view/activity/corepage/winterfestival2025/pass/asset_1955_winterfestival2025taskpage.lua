local WinterFestival2025TaskPage = class("WinterFestival2025TaskPage", import("...PSS.Hei5.PSSHei5TaskPage"))

function WinterFestival2025TaskPage:getUIName()
	return "WinterFestival2025TaskPage"
end

function WinterFestival2025TaskPage:initTplVar()
	self.btnGoText = "task_go"
	self.btnGetText = "winter_cruise_task_tips"
	self.taskDayText = "winter_cruise_task_day"
	self.pticonAtlas = nil
	self.pticonName = nil

	return
end

return WinterFestival2025TaskPage
