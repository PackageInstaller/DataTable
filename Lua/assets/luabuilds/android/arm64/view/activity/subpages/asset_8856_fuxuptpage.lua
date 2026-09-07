local FuxuPtPage = class("FuxuPtPage", import(".TemplatePage.PtTemplatePage"))

function FuxuPtPage:OnFirstFlush()
	FuxuPtPage.super.OnFirstFlush(self)
	onButton(self, self.bg:Find("build_btn"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = BuildShipScene.PROJECTS.HEAVY
		})

		return
	end, SFX_PANEL)

	return
end

function FuxuPtPage:OnUpdateFlush()
	FuxuPtPage.super.OnUpdateFlush(self)

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetLevelProgress()
	local var_3_3, var_3_4, var_3_5 = self.ptData:GetResProgress()

	setText(self.step, var_3_0)
	setText(self.progress, (var_3_5 >= 1 and setColorStr(var_3_3, "#df9e38") or var_3_3) .. "/" .. var_3_4)

	local var_3_6
	local var_3_7

	if self.activity:getConfig("config_client") ~= "" then
		var_3_6 = self.activity:getConfig("config_client").linkActID

		if var_3_6 then
			var_3_7 = getProxy(ActivityProxy):getActivityById(var_3_6)
		end
	end

	if var_3_6 and not var_3_7 or var_3_7 and var_3_7:isEnd() then
		setActive(self.battleBtn, false)
		setActive(self.bg:Find("build_btn"), false)
	end

	return
end

return FuxuPtPage
