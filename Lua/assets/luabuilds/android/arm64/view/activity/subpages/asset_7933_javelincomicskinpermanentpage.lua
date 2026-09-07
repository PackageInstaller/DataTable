local JavelinComicSkinPermanentPage = class("JavelinComicSkinPermanentPage", import(".TemplatePage.SkinTemplatePage"))

function JavelinComicSkinPermanentPage:OnUpdateFlush()
	JavelinComicSkinPermanentPage.super.OnUpdateFlush(self)

	if self.nday < #self.taskGroup then
		setText(self.dayTF, "<color=#E75198><size=48>" .. self.nday .. "</size></color><color=#00B8FF><size=28>     " .. #self.taskGroup .. "</size></color>")
	else
		setText(self.dayTF, "<color=#00FF00><size=48>" .. self.nday .. "</size></color><color=#00B8FF><size=28>     " .. #self.taskGroup .. "</size></color>")
	end

	return
end

return JavelinComicSkinPermanentPage
