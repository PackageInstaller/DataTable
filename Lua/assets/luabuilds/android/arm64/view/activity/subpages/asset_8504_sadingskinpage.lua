local SaDingSkinPage = class("SaDingSkinPage", import(".TemplatePage.SkinTemplatePage"))

function SaDingSkinPage:OnUpdateFlush()
	SaDingSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#ABA9FF") .. "/" .. #self.taskGroup)

	return
end

function SaDingSkinPage:GetProgressColor()
	return "#ABA9FF", "#EBEAF7"
end

return SaDingSkinPage
