local LuXieErSkinPage = class("LuXieErSkinPage", import(".TemplatePage.SkinTemplatePage"))

function LuXieErSkinPage:OnUpdateFlush()
	LuXieErSkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#ffffff") .. setColorStr("/" .. #self.taskGroup, "#ffffff"))

	return
end

return LuXieErSkinPage
