local var_0_0 = class("KurskSPPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		local var_2_1
		local var_2_2 = arg_1_0.activity:getConfig("config_client").linkActID

		if var_2_2 then
			var_2_1 = getProxy(ActivityProxy):getActivityById(var_2_2)
		end

		if not var_2_2 then
			arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.BOSSRUSH_MAIN)
		elseif var_2_1 and not var_2_1:isEnd() then
			arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.BOSSRUSH_MAIN)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.bg:Find("build_btn"), function()
		local var_3_1
		local var_3_2 = arg_1_0.activity:getConfig("config_client").linkActID

		if var_3_2 then
			var_3_1 = getProxy(ActivityProxy):getActivityById(var_3_2)
		end

		if not var_3_2 then
			arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				page = BuildShipScene.PAGE_BUILD,
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		elseif var_3_1 and not var_3_1:isEnd() then
			arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
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

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)
	setActive(arg_4_0.battleBtn, true)

	return
end

return var_0_0
