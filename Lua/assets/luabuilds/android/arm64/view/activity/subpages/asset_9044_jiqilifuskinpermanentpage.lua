local JiqilifuSkinPermanentPage = class("JiqilifuSkinPermanentPage", import(".TemplatePage.SkinTemplatePage"))

function JiqilifuSkinPermanentPage:OnUpdateFlush()
	JiqilifuSkinPermanentPage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(self.nday, "#6CF7C1FF") .. "/" .. #self.taskGroup)

	return
end

return JiqilifuSkinPermanentPage
