local YidaliV4SkinPage = class("YidaliV4SkinPage", import(".TemplatePage.SkinTemplatePage"))

function YidaliV4SkinPage:OnUpdateFlush()
	YidaliV4SkinPage.super.OnUpdateFlush(self)

	if self.dayTF then
		setText(self.dayTF, setColorStr(self.nday, "#b98959") .. setColorStr("/" .. #self.taskGroup, "#5a4439"))
	end

	return
end

function YidaliV4SkinPage:GetProgressColor()
	return "#cead74"
end

return YidaliV4SkinPage
