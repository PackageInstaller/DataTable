local U73SkinPage = class("U73SkinPage", import(".TemplatePage.SkinTemplatePage"))

function U73SkinPage:OnUpdateFlush()
	U73SkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, COLOR_GREEN) .. "/" .. #self.taskGroup)

	return
end

return U73SkinPage
