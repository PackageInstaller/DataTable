local IDOLMMainPage = class("IDOLMMainPage", import(".TemplatePage.PreviewTemplatePage"))

function IDOLMMainPage:OnFirstFlush()
	IDOLMMainPage.super.OnFirstFlush(self)

	self.mountainBtn = self.btnList:Find("mountain")

	onButton(self, self.mountainBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.IMAS_STAGE)

		return
	end, SFX_PANEL)

	return
end

return IDOLMMainPage
