local MaidAzurlanePage = class("MaidAzurlanePage", import(".TemplatePage.SkinTemplatePage"))

function MaidAzurlanePage:OnFirstFlush()
	MaidAzurlanePage.super.OnFirstFlush(self)
	onButton(self, self.bg:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.maid_task_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.bg:Find("ClickIron"), function()
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
	onButton(self, self.bg:Find("ClickRoyal"), function()
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

function MaidAzurlanePage:OnUpdateFlush()
	MaidAzurlanePage.super.OnUpdateFlush(self)
	setText(self.dayTF, setColorStr(tostring(self.nday), "#7B3B2C"))

	return
end

return MaidAzurlanePage
