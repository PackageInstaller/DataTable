local DoaMainRePage = class("DoaMainRePage", import(".TemplatePage.PreviewTemplatePage"))

function DoaMainRePage:OnInit()
	DoaMainRePage.super.OnInit(self)

	self.charactorTf = self.bg:Find("charactor")

	return
end

function DoaMainRePage:OnFirstFlush()
	DoaMainRePage.super.OnFirstFlush(self)
	onButton(self, self.bg:Find("btnMiniGame"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end)

	return
end

function DoaMainRePage:OnUpdateFlush()
	local var_4_0 = math.random(1, 9)

	for iter_4_0 = 1, 9 do
		setActive(findTF(self.charactorTf, "charactor" .. iter_4_0), var_4_0 == iter_4_0)
	end

	return
end

return DoaMainRePage
