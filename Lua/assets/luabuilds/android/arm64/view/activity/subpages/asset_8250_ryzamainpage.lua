local RyzaMainPage = class("RyzaMainPage", import(".TemplatePage.PreviewTemplatePage"))

function RyzaMainPage:OnFirstFlush()
	RyzaMainPage.super.OnFirstFlush(self)

	self.mountainBtn = self.btnList:Find("mountain")

	onButton(self, self.mountainBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.RYZA_URBAN_AREA)

		return
	end, SFX_PANEL)

	return
end

return RyzaMainPage
