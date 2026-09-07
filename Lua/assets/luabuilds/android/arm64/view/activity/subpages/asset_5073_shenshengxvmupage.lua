local ShenshengxvmuPage = class("ShenshengxvmuPage", import(".TemplatePage.PtTemplatePage"))

function ShenshengxvmuPage:OnFirstFlush()
	ShenshengxvmuPage.super.OnFirstFlush(self)
	setActive(self.displayBtn, false)
	setActive(self.awardTF, false)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	return
end

function ShenshengxvmuPage:OnUpdateFlush()
	ShenshengxvmuPage.super.OnUpdateFlush(self)
	setActive(self.battleBtn, isActive(self.battleBtn) and pg.TimeMgr.GetInstance():inTime((self.activity:getConfig("config_client"))))
	setActive(self.bg:Find("got"), not self.ptData:CanGetNextAward())

	local var_3_0, var_3_1, var_3_2 = self.ptData:GetResProgress()

	setText(self.step, var_3_2 >= 1 and setColorStr(var_3_0, COLOR_GREEN) or var_3_0)
	setText(self.progress, "/" .. var_3_1)

	return
end

return ShenshengxvmuPage
