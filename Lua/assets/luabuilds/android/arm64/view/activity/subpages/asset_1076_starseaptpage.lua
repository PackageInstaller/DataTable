local StarSeaPtPage = class("StarSeaPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = "#CCB5FF"

function StarSeaPtPage:OnUpdateFlush()
	local var_1_0 = self.ptData:getTargetLevel()
	local var_1_1 = self.activity:getConfig("config_client").story

	if checkExist(var_1_1, {
		var_1_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_1_1[var_1_0][1])
	end

	if self.step then
		local var_1_2, var_1_3, var_1_4 = self.ptData:GetLevelProgress()

		setText(self.step, setColorStr(var_1_2, var_0_1) .. "/" .. var_1_3)
	end

	local var_1_5, var_1_6, var_1_7 = self.ptData:GetResProgress()

	setText(self.progress, (var_1_7 >= 1 and setColorStr(var_1_5, var_0_1) or var_1_5) .. "/" .. var_1_6)
	setSlider(self.slider, 0, 1, var_1_7)

	local var_1_8 = self.ptData:CanGetAward()
	local var_1_9 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_1_8 and var_1_9)
	setActive(self.getBtn, var_1_8)
	setActive(self.gotBtn, not var_1_9)

	local var_1_10 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_1_10)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_1_10)

		return
	end, SFX_PANEL)

	return
end

return StarSeaPtPage
