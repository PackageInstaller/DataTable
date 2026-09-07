local VampireSkinPage = class("VampireSkinPage", import(".TemplatePage.SkinTemplatePage"))

function VampireSkinPage:OnUpdateFlush()
	VampireSkinPage.super.OnUpdateFlush(self)
	setText(self.bg:Find("total_day"), #self.taskGroup)

	return
end

return VampireSkinPage
