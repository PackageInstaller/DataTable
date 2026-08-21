local var_0_0 = class("RyzaAtelierCompositeRePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	onButton(arg_1_0, arg_1_0._tf:Find("adapt/helpBtn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("ryza_composite_help_tip")
		})

		return
	end)
	onButton(arg_1_0, arg_1_0._tf:Find("adapt/storeBtn"), function()
		({}).activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)
		;({
			mediator = AtelierStoreBaseMediator,
			viewComponent = AtelierStoreBaseScene
		}).data = {}

		addSubLayer(Context.New({
			mediator = AtelierStoreBaseMediator,
			viewComponent = AtelierStoreBaseScene
		}), (getProxy(ContextProxy):getCurrentContext():getContextByMediator(CoreActivityMainMediator)))

		return
	end)
	onButton(arg_1_0, arg_1_0._tf:Find("adapt/atelierBtn"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 1
		})

		return
	end)

	return
end

return var_0_0
