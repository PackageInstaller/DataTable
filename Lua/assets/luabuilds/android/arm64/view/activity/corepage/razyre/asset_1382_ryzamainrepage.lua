local RyzaMainRePage = class("RyzaMainRePage", import("view.activity.CorePage.CorePreviewTemplatePage"))

function RyzaMainRePage:OnFirstFlush()
	RyzaMainRePage.super.OnFirstFlush(self)

	self.gameBtn = self.btnList:Find("activity")
	self.fightBtn = self.btnList:Find("fight")
	self.shopBtn = self.btnList:Find("shop")

	onButton(self, self.gameBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 43)

		return
	end, SFX_PANEL)
	onButton(self, self.fightBtn, function()
		self:emit(ActivityMediator.SKIP_ACTIVITY_MAP, 50042)

		return
	end, SFX_PANEL)
	onButton(self, self.shopBtn, function()
		self:emit(ActivityMediator.GO_SHOPS_LAYER, {
			actId = 50052,
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end, SFX_PANEL)

	return
end

return RyzaMainRePage
