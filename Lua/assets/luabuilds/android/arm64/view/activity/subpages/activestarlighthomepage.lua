local var_0_0 = class("ActiveStarlightHomepage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.Build = arg_1_0._tf:Find("bg/Build"):GetComponent("Button")
	arg_1_0.Level = arg_1_0._tf:Find("bg/Level"):GetComponent("Button")
	arg_1_0.Shop = arg_1_0._tf:Find("bg/Shop"):GetComponent("Button")
	arg_1_0.Manual = arg_1_0._tf:Find("bg/Manual"):GetComponent("Button")
	arg_1_0.image = arg_1_0._tf:Find("bg/Manual/image")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("time")

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.Build, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_NEWSERVER
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Level, function()
		arg_3_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Shop, function()
		arg_3_0:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Manual, function()
		arg_3_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = StarLightMedalAlbumView
		})))

		return
	end, SFX_PANEL)

	return
end

return var_0_0
