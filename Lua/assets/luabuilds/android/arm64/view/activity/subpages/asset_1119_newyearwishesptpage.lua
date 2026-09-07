local NewYearWishesPtPage = class("NewYearWishesPtPage", import(".TemplatePage.PtTemplatePage"))

function NewYearWishesPtPage:OnInit()
	NewYearWishesPtPage.super.OnInit(self)

	self.awardGotTag = self.bg:Find("award_got")

	return
end

function NewYearWishesPtPage:OnFirstFlush()
	NewYearWishesPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	return
end

function NewYearWishesPtPage:OnUpdateFlush()
	NewYearWishesPtPage.super.OnUpdateFlush(self)
	setActive(self.awardGotTag, not self.ptData:CanGetNextAward())

	return
end

return NewYearWishesPtPage
