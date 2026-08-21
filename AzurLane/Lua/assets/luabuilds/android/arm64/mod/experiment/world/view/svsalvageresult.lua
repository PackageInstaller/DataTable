local var_0_0 = class("SVSalvageResult", import("view.base.BaseSubView"))

var_0_0.HideView = "SVSalvageResult.HideView"

function var_0_0.getUIName(arg_1_0)
	return "SVSalvageResult"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.rtPanel = arg_3_0._tf:Find("window/display_panel")

	setText(arg_3_0.rtPanel:Find("info/Text"), i18n("world_catsearch_help_1"))
	setText(arg_3_0.rtPanel:Find("info/items_btn/Text"), i18n("world_catsearch_help_2"))
	onButton(arg_3_0, arg_3_0.rtPanel:Find("info/items_btn"), function()
		arg_3_0:emit(BaseUI.ON_DROP_LIST, {
			item2Row = true,
			itemList = _.map(pg.gameset.world_catsearchdrop_show.description, function(arg_5_0)
				return {
					type = arg_5_0[1],
					id = arg_5_0[2],
					count = arg_5_0[3]
				}
			end),
			content = i18n("world_catsearch_help_6")
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	arg_3_0.btnBack = arg_3_0._tf:Find("window/top/btnBack")

	onButton(arg_3_0, arg_3_0.btnBack, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	arg_3_0.btnCanel = arg_3_0._tf:Find("window/button_container/custom_button_2")

	onButton(arg_3_0, arg_3_0.btnCanel, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	arg_3_0.btnHelp = arg_3_0.rtPanel:Find("info/help")

	onButton(arg_3_0, arg_3_0.btnHelp, function()
		arg_3_0:Hide()
		arg_3_0:emit(WorldScene.SceneOp, "OpOpenLayer", Context.New({
			mediator = WorldHelpMediator,
			viewComponent = WorldHelpLayer,
			data = {
				titleId = 3,
				pageId = 10
			}
		}))

		return
	end, SFX_PANEL)

	arg_3_0.btnConfirm = arg_3_0._tf:Find("window/button_container/custom_button_1")

	onButton(arg_3_0, arg_3_0.btnConfirm, function()
		arg_3_0:Hide()
		arg_3_0:emit(WorldScene.SceneOp, "OpReqCatSalvage", arg_3_0.fleetId)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

function var_0_0.Show(arg_12_0)
	setActive(arg_12_0._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_12_0._tf)

	return
end

function var_0_0.Hide(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0._parentTf)
	setActive(arg_13_0._tf, false)

	return
end

function var_0_0.Setup(arg_14_0, arg_14_1)
	arg_14_0.fleetId = arg_14_1

	return
end

return var_0_0
