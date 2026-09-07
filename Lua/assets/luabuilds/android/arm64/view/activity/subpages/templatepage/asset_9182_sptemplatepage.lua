local SpTemplatePage = class("SpTemplatePage", import(".PtTemplatePage"))

function SpTemplatePage:OnInit()
	SpTemplatePage.super.OnInit(self)

	self.buildBtn = self.bg:Find("build_btn")

	return
end

function SpTemplatePage:OnFirstFlush()
	SpTemplatePage.super.OnFirstFlush(self)

	local var_2_0 = self.activity:getConfig("config_client").linkPoolActID

	if not var_2_0 then
		pg.TipsMgr.GetInstance():ShowTips("未配置linkPoolActID！！！")
	else
		local var_2_1 = getProxy(ActivityProxy):getActivityById(var_2_0)

		if var_2_1 and not var_2_1:isEnd() then
			setActive(self.buildBtn, true)

			local var_2_2 = pg.activity_template[var_2_0].config_client.id and pg.activity_template[var_2_0].config_client.id or BuildShipScene.PROJECTS.SPECIAL
			local var_2_3 = {
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY,
				BuildShipScene.PROJECTS.ACTIVITY
			}

			onButton(self, self.buildBtn, function()
				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
					page = BuildShipScene.PAGE_BUILD,
					projectName = var_2_3[var_2_2]
				})

				return
			end, SFX_PANEL)
		else
			setActive(self.buildBtn, false)
		end
	end

	return
end

return SpTemplatePage
