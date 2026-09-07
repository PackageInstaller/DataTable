local ExpoTicketTaskPage = class("ExpoTicketTaskPage", import(".TemplatePage.SkinTemplatePage"))

function ExpoTicketTaskPage:OnUpdateFlush()
	ExpoTicketTaskPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#70FFEC") .. "/" .. #self.taskGroup)

	return
end

function ExpoTicketTaskPage:GetProgressColor()
	return "#70FFFD", "#E1FFFF"
end

return ExpoTicketTaskPage
