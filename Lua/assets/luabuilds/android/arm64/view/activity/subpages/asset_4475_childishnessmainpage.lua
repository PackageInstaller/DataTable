local ChildishnessMainPage = class("ChildishnessMainPage", import(".TemplatePage.PreviewTemplatePage"))

function ChildishnessMainPage:OnFirstFlush()
	self.super.OnFirstFlush(self)
	onButton(self, self.btnList:Find("fight"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.KINDERGARTEN)

		return
	end)
	onButton(self, self.btnList:Find("shop"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

return ChildishnessMainPage
