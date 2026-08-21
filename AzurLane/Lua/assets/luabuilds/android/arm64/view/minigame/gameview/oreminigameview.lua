local var_0_0 = class("OreMiniGameView", import("view.miniGame.MiniGameTemplateView"))

function var_0_0.getUIName(arg_1_0)
	return "OreMiniGameUI"
end

function var_0_0.getGameController(arg_2_0)
	return OreMiniGameController
end

function var_0_0.getShowSide(arg_3_0)
	return false
end

function var_0_0.initPageUI(arg_4_0)
	var_0_0.super.initPageUI(arg_4_0)
	onButton(arg_4_0, arg_4_0.rtTitlePage:Find("main/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ore_minigame_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.rtTitlePage:Find("result/window/btn_finish"), function()
		arg_4_0:openUI("main")
		arg_4_0.gameController:ResetGame()

		return
	end, SFX_CONFIRM)

	local var_4_0 = arg_4_0.rtTitlePage:Find("main/res_bar")

	LoadImageSpriteAsync(Item.getConfigData(pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_client.item_id).icon, var_4_0:Find("icon"), true)
	setText(var_4_0:Find("num"), arg_4_0:GetMGHubData().count)
	onButton(arg_4_0, var_4_0, function()
		arg_4_0:emit(BaseMiniGameMediator.OPEN_SUB_LAYER, {
			mediator = IslandGameLimitMediator,
			viewComponent = IslandGameLimitLayer
		})

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.updateMainUI(arg_8_0)
	var_0_0.super.updateMainUI(arg_8_0)
	setText(arg_8_0.rtTitlePage:Find("main/res_bar"):Find("num"), arg_8_0:GetMGHubData().count)

	return
end

function var_0_0.willExit(arg_9_0)
	arg_9_0.gameController:willExit()

	return
end

return var_0_0
