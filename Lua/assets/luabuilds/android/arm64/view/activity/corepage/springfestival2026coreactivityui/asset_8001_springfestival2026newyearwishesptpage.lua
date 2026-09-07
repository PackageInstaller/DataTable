local SpringFestival2026NewYearWishesPtPage = class("SpringFestival2026NewYearWishesPtPage", import("view.activity.CorePage.CorePtTemplatePage"))

function SpringFestival2026NewYearWishesPtPage:OnInit()
	SpringFestival2026NewYearWishesPtPage.super.OnInit(self)

	self.awardGotTag = self.bg:Find("award_got")

	return
end

function SpringFestival2026NewYearWishesPtPage:OnFirstFlush()
	SpringFestival2026NewYearWishesPtPage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	return
end

function SpringFestival2026NewYearWishesPtPage:OnUpdateFlush()
	SpringFestival2026NewYearWishesPtPage.super.OnUpdateFlush(self)
	setActive(self.awardGotTag, not self.ptData:CanGetNextAward())

	return
end

return SpringFestival2026NewYearWishesPtPage
