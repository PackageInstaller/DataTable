local U73SkinRePage = class("U73SkinRePage", import(".TemplatePage.SkinTemplatePage"))

function U73SkinRePage:OnUpdateFlush()
	U73SkinRePage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, COLOR_GREEN) .. "/" .. #self.taskGroup)

	return
end

return U73SkinRePage
