local RoyalRePtPage = class("RoyalRePtPage", import(".TemplatePage.PtTemplatePage"))

function RoyalRePtPage:OnInit()
	RoyalRePtPage.super.OnInit(self)

	self.progresses = self.bg:Find("progresses")
	self.progress_r = self.progresses:Find("progress_r")
	self.progress_l = self.progresses:Find("progress_l")

	return
end

function RoyalRePtPage:OnUpdateFlush()
	local var_2_0 = self.ptData:getTargetLevel()
	local var_2_1 = self.activity:getConfig("config_client").story

	if checkExist(var_2_1, {
		var_2_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_1[var_2_0][1])
	end

	local var_2_2, var_2_3, var_2_4 = self.ptData:GetLevelProgress()
	local var_2_5, var_2_6, var_2_7 = self.ptData:GetResProgress()

	setText(self.step, var_2_2 .. "/" .. var_2_3)
	setText(self.progress_l, (var_2_7 >= 1 and setColorStr(var_2_5, COLOR_GREEN) or var_2_5) .. "/" .. var_2_6)
	setSlider(self.slider, 0, 1, var_2_7)

	local var_2_8 = self.ptData:CanGetAward()
	local var_2_9 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_2_8 and var_2_9)
	setActive(self.getBtn, var_2_8)
	setActive(self.gotBtn, not var_2_9)

	local var_2_10 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_2_10)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_2_10)

		return
	end, SFX_PANEL)

	return
end

return RoyalRePtPage
