local var_0_0 = class("GameRoomOreView", import("view.miniGame.MiniGameTemplateView"))

function var_0_0.getUIName(arg_1_0)
	return "GameRoomOreUI"
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

	return
end

function var_0_0.initOpenUISwich(arg_7_0)
	arg_7_0.openSwitchDic = {
		main = function()
			arg_7_0:updateMainUI()

			return
		end,
		pause = function()
			arg_7_0.gameController:PauseGame()

			return
		end,
		exit = function()
			arg_7_0.gameController:PauseGame()

			return
		end,
		result = function()
			local var_11_0 = arg_7_0:GetMGData():GetRuntimeData("elements")

			var_11_0 = var_11_0 or {}

			local var_11_1 = arg_7_0.gameController.point
			local var_11_2 = getProxy(GameRoomProxy):getRoomScore(arg_7_0:getGameRoomData().id)
			local var_11_3 = arg_7_0.rtTitlePage:Find("result")

			setActive(var_11_3:Find("window/now/new"), var_11_2 < arg_7_0.gameController.point)

			if var_11_2 <= var_11_1 then
				var_11_2 = var_11_1
				var_11_0[1] = var_11_1
			end

			arg_7_0:StoreDataToServer({
				var_11_2
			})
			setText(var_11_3:Find("window/high/Text"), var_11_2)
			setText(var_11_3:Find("window/now/Text"), var_11_1)

			local var_11_4 = arg_7_0:GetMGHubData()

			arg_7_0:SendSuccess(var_11_1)

			return
		end
	}

	return
end

function var_0_0.openUI(arg_12_0, arg_12_1)
	if not arg_12_0.openSwitchDic then
		arg_12_0:initOpenUISwich()
	end

	if arg_12_0.status then
		setActive(arg_12_0.rtTitlePage:Find(arg_12_0.status), false)
	end

	if arg_12_1 == "main" then
		arg_12_0:openCoinLayer(true)
	else
		arg_12_0:openCoinLayer(false)
	end

	if arg_12_1 then
		setActive(arg_12_0.rtTitlePage:Find(arg_12_1), true)
	end

	arg_12_0.status = arg_12_1

	switch(arg_12_1, arg_12_0.openSwitchDic)

	return
end

function var_0_0.updateMainUI(arg_13_0)
	var_0_0.super.updateMainUI(arg_13_0)

	return
end

function var_0_0.willExit(arg_14_0)
	arg_14_0.gameController:willExit()

	return
end

return var_0_0
