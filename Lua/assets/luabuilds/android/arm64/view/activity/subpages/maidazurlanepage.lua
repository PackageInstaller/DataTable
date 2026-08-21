local var_0_0 = class("MaidAzurlanePage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.bg:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.maid_task_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.bg:Find("ClickIron"), function()
		local var_3_0 = Context.New()

		SCENE.SetSceneInfo(var_3_0, SCENE.NEWYEAR_BACKHILL_2022)
		var_3_0:addChild(Context.New({
			mediator = BuildingUpgradeMediator,
			viewComponent = BuildingCafeUpgradeLayer,
			data = {
				buildingID = 18,
				isLayer = true
			}
		}))
		pg.m02:sendNotification(GAME.LOAD_SCENE, {
			context = var_3_0
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.bg:Find("ClickRoyal"), function()
		local var_4_0 = Context.New()

		SCENE.SetSceneInfo(var_4_0, SCENE.NEWYEAR_BACKHILL_2022)
		var_4_0:addChild(Context.New({
			mediator = BuildingUpgradeMediator,
			viewComponent = BuildingCafeUpgradeLayer,
			data = {
				buildingID = 17,
				isLayer = true
			}
		}))
		pg.m02:sendNotification(GAME.LOAD_SCENE, {
			context = var_4_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)
	setText(arg_5_0.dayTF, setColorStr(tostring(arg_5_0.nday), "#7B3B2C"))

	return
end

return var_0_0
