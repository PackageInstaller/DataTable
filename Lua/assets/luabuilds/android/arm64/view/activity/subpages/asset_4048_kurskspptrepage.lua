local KurskSPPtRePage = class("KurskSPPtRePage", import(".TemplatePage.PtTemplatePage"))

function KurskSPPtRePage:OnFirstFlush()
	KurskSPPtRePage.super.OnFirstFlush(self)
	onButton(self, self.battleBtn, function()
		local var_2_1
		local var_2_2 = self.activity:getConfig("config_client").linkActID

		if var_2_2 then
			var_2_1 = getProxy(ActivityProxy):getActivityById(var_2_2)
		end

		if not var_2_2 then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.BOSSRUSH_MAIN)
		elseif var_2_1 and not var_2_1:isEnd() then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.BOSSRUSH_MAIN)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.bg:Find("build_btn"), function()
		local var_3_1
		local var_3_2 = self.activity:getConfig("config_client").linkActID

		if var_3_2 then
			var_3_1 = getProxy(ActivityProxy):getActivityById(var_3_2)
		end

		if not var_3_2 then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				page = BuildShipScene.PAGE_BUILD,
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		elseif var_3_1 and not var_3_1:isEnd() then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				page = BuildShipScene.PAGE_BUILD,
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
		end

		return
	end, SFX_PANEL)

	return
end

function KurskSPPtRePage:OnUpdateFlush()
	KurskSPPtRePage.super.OnUpdateFlush(self)
	setActive(self.battleBtn, true)

	return
end

return KurskSPPtRePage
