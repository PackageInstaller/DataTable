local var_0_0 = class("GameRoomDOAPPView", import("view.miniGame.MiniGameTemplateView"))

var_0_0.canSelectStage = false

function var_0_0.getUIName(arg_1_0)
	return "GameRoomDOAPPUI"
end

function var_0_0.getGameController(arg_2_0)
	return DOAPPMiniGameController
end

function var_0_0.initPageUI(arg_3_0)
	var_0_0.super.initPageUI(arg_3_0)
	onButton(arg_3_0, arg_3_0.rtTitlePage:Find("main/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.doa_minigame_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = arg_3_0:GetMGData():GetSimpleValue("story")

	onButton(arg_3_0, arg_3_0.rtTitlePage:Find("main/btn_start"), function()
		if checkExist(var_3_0, {
			arg_3_0.stageIndex
		}, {
			1
		}) then
			table.insert({}, function(arg_6_0)
				pg.NewStoryMgr.GetInstance():Play(var_0, arg_6_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_3_0:openUI("select")
			arg_3_0:openCoinLayer(false)

			return
		end)

		return
	end, SFX_PANEL)

	local var_3_1 = arg_3_0.rtTitlePage:Find("select")

	onButton(arg_3_0, var_3_1:Find("btn_back"), function()
		arg_3_0:openUI("main")
		arg_3_0:openCoinLayer(true)
		arg_3_0:openCoinLayer(true)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, var_3_1:Find("btn/confirm"), function()
		if not arg_3_0.character then
			pg.TipsMgr.GetInstance():ShowTips("without selected character")

			return
		end

		arg_3_0.gameController:ResetGame()
		arg_3_0.gameController:ReadyGame({
			name = arg_3_0.character
		})
		arg_3_0:openUI("countdown")

		return
	end, SFX_CONFIRM)
	eachChild(var_3_1:Find("content"), function(arg_10_0)
		setText(arg_10_0:Find("name/Text"), i18n("doa_minigame_" .. arg_10_0.name))
		onToggle(arg_3_0, arg_10_0, function(arg_11_0)
			if arg_11_0 then
				arg_3_0.character = arg_10_0.name

				setAnchoredPosition(arg_10_0:Find(arg_10_0.name), {
					x = 70
				})
				quickPlayAnimator(arg_10_0:Find(arg_10_0.name .. "/Image"), "Win")
			else
				if arg_3_0.character == arg_10_0.name then
					arg_3_0.character = nil
				end

				setAnchoredPosition(arg_10_0:Find(arg_10_0.name), {
					x = 110
				})
				quickPlayAnimator(arg_10_0:Find(arg_10_0.name .. "/Image"), "Idle")
			end

			return
		end, SFX_PANEL)

		return
	end)

	return
end

local function var_0_1(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	eachChild(arg_12_0:Find("mask"), function(arg_13_0)
		setActive(arg_13_0, arg_13_0.name == arg_12_1)

		return
	end)
	setText(arg_12_0:Find("name/Text"), i18n("doa_minigame_" .. arg_12_1))
	eachChild(arg_12_0:Find("name/Text"), function(arg_14_0)
		setActive(arg_14_0, arg_14_0.name == arg_12_1)

		return
	end)
	setActive(arg_12_0:Find("result/lose"), arg_12_3 < 0)
	setActive(arg_12_0:Find("result/win"), arg_12_3 > 0)
	eachChild(arg_12_0:Find("point"), function(arg_15_0)
		setActive(arg_15_0, tonumber(arg_15_0.name) <= arg_12_2)

		return
	end)

	return
end

function var_0_0.initOpenUISwich(arg_16_0)
	var_0_0.super.initOpenUISwich(arg_16_0)

	function arg_16_0.openSwitchDic.result()
		var_0_1(arg_16_0.rtTitlePage:Find("result/window/self"), arg_16_0.gameController:GetResultInfo(false))
		var_0_1(arg_16_0.rtTitlePage:Find("result/window/other"), arg_16_0.gameController:GetResultInfo(true))

		local var_17_0 = arg_16_0:GetMGHubData()

		arg_16_0:SendSuccess(0)

		return
	end

	function arg_16_0.openSwitchDic.select()
		triggerToggle(arg_16_0.rtTitlePage:Find("select/content/Marie"), true)

		return
	end

	return
end

function var_0_0.initBackPressSwitch(arg_19_0)
	var_0_0.super.initBackPressSwitch(arg_19_0)

	function arg_19_0.backPressSwitchDic.select()
		arg_19_0:openUI("main")
		arg_19_0:openCoinLayer(true)

		return
	end

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0.gameController:willExit()

	return
end

function var_0_0.getShowSide(arg_22_0)
	return false
end

return var_0_0
