local CravenCheeringSkinPage = class("CravenCheeringSkinPage", import(".TemplatePage.SkinTemplatePage"))

function CravenCheeringSkinPage:OnInit()
	CravenCheeringSkinPage.super.OnInit(self)

	self.step_txt = self.bg:Find("step_text")

	return
end

function CravenCheeringSkinPage:OnUpdateFlush()
	CravenCheeringSkinPage.super.OnUpdateFlush(self)
	setText(self.step_txt, setColorStr(self.nday, "#89FF59FF") .. "/" .. #self.taskGroup)

	return
end

return CravenCheeringSkinPage
