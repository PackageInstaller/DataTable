local NagaraSkinPage = class("NagaraSkinPage", import(".TemplatePage.SkinTemplatePage"))

function NagaraSkinPage:OnUpdateFlush()
	NagaraSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)

	return
end

return NagaraSkinPage
