local CastlePtPage = class("CastlePtPage", import(".TemplatePage.PtTemplatePage"))

CastlePtPage.MAIN_ID = ActivityConst.CASTLE_ACT_ID

function CastlePtPage:OnFirstFlush()
	CastlePtPage.super.OnFirstFlush(self)
	onButton(self, self.bg:Find("main_btn"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CASTLE_MAIN)

		return
	end, SFX_PANEL)

	return
end

function CastlePtPage:OnUpdateFlush()
	CastlePtPage.super.OnUpdateFlush(self)

	self.mainAct = getProxy(ActivityProxy):getActivityById(CastlePtPage.MAIN_ID)

	local var_3_0 = self.mainAct.data2

	if table.contains({
		4565,
		4568,
		4571,
		4574,
		4577,
		4580,
		4583,
		4586
	}, self.mainAct.data1) then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(self.mainAct.data1)) then
			var_3_0 = var_3_0 - 1
		end
	end

	setText(self.bg:Find("main_btn/Text"), i18n("roll_times_left", var_3_0))
	setText(self.bg:Find("description"), i18n("activity_kill"))

	return
end

return CastlePtPage
