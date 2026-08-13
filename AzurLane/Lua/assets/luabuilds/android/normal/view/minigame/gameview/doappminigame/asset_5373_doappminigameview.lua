class = var_0_10000

local var_0_0 = "DOAPPMiniGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.MiniGameTemplateView"))

var_0_1.canSelectStage = false

function var_0_1.getUIName(arg_1_0)
	return "DOAPPMiniGameUI"
end

function var_0_1.getGameController(arg_2_0)
	DOAPPMiniGameController = var_1_10001

	return var_1_10001
end

function var_0_1.initPageUI(arg_3_0)
	var_0_1.super.initPageUI(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rtTitlePage
	local var_3_2 = var_3.Find(var_3_1, "main/btn_help")

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_4_2.type = var_2_10003
		pg = var_2_10003
		var_4_2.helps = var_2_10003.gametip.doa_minigame_help.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_0, var_3_2, var_3_3, var_5)

	local var_3_4 = arg_3_0:GetMGData()
	local var_3_5 = var_1.GetSimpleValue(var_3_4, "story")

	onButton = var_3_4

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.rtTitlePage
	local var_3_8 = var_4.Find(var_3_7, "main/btn_start")

	local function var_3_9()
		local var_5_0 = {}

		checkExist = var_2_10001

		if var_2_10001(var_3_5, {
			arg_3_0.stageIndex
		}, {
			1
		}) then
			table = var_2

			var_2.insert(var_5_0, function(arg_6_0)
				pg = var_3_10001

				local var_6_0 = var_3_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_6_0, var_0, arg_6_0)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_5_0, function()
			local var_7_0 = arg_3_0

			var_0.openUI(var_7_0, "select")

			return
		end)

		return
	end

	SFX_PANEL = var_6

	var_3_4(var_3_6, var_3_8, var_3_9, var_6)

	local var_3_10 = arg_3_0.rtTitlePage
	local var_3_11 = var_2.Find(var_3_10, "select")

	onButton = var_3_10

	local var_3_12 = arg_3_0
	local var_3_13 = var_3_11:Find("btn_back")

	local function var_3_14()
		local var_8_0 = arg_3_0

		var_0.openUI(var_8_0, "main")

		return
	end

	SFX_CANCEL = var_7

	var_3_10(var_3_12, var_3_13, var_3_14, var_7)

	onButton = var_3_10

	local var_3_15 = arg_3_0
	local var_3_16 = var_3_11:Find("btn/confirm")

	local function var_3_17()
		if not arg_3_0.character then
			pg = var_0

			local var_9_0 = var_0.TipsMgr.GetInstance()

			var_0.ShowTips(var_9_0, "without selected character")

			return
		end

		local var_9_1 = arg_3_0.gameController

		var_0.ResetGame(var_9_1)

		local var_9_2 = arg_3_0.gameController

		var_0.ReadyGame(var_9_2, {
			name = arg_3_0.character
		})

		local var_9_3 = arg_3_0

		var_0.openUI(var_9_3, "countdown")

		return
	end

	SFX_CONFIRM = var_7

	var_3_10(var_3_15, var_3_16, var_3_17, var_7)

	eachChild = var_3_10

	var_3_10(var_3_11:Find("content"), function(arg_10_0)
		setText = var_2_10001

		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.Find(var_10_0, "name/Text")

		i18n = var_10_0

		var_2_10001(var_10_1, var_10_0("doa_minigame_" .. arg_10_0.name))

		onToggle = var_2_10001

		local var_10_2 = arg_3_0
		local var_10_3 = arg_10_0

		local function var_10_4(arg_11_0)
			if arg_11_0 then
				local var_11_0 = arg_3_0

				var_11_0.character = arg_10_0.name
				setAnchoredPosition = var_11_0

				local var_11_1 = arg_10_0

				var_11_0(var_2.Find(var_11_1, arg_10_0.name), {
					x = 70
				})

				quickPlayAnimator = var_11_0

				local var_11_2 = arg_10_0

				var_11_0(var_2.Find(var_11_2, arg_10_0.name .. "/Image"), "Win")
			else
				local var_11_3

				if arg_3_0.character == arg_10_0.name then
					var_11_3 = arg_3_0
					var_11_3.character = nil
				end

				setAnchoredPosition = var_11_3

				local var_11_4 = arg_10_0

				var_11_3(var_2.Find(var_11_4, arg_10_0.name), {
					x = 110
				})

				quickPlayAnimator = var_11_3

				local var_11_5 = arg_10_0

				var_11_3(var_2.Find(var_11_5, arg_10_0.name .. "/Image"), "Idle")
			end

			return
		end

		SFX_PANEL = var_5

		var_2_10001(var_10_2, var_10_3, var_10_4, var_5)

		return
	end)

	return
end

local function var_0_2(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	eachChild = var_1_10004

	var_1_10004(arg_12_0:Find("mask"), function(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_13_0, arg_13_0.name == arg_12_1)

		return
	end)

	setText = var_1_10004

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.Find(var_12_0, "name/Text")

	i18n = var_12_0

	var_1_10004(var_12_1, var_12_0("doa_minigame_" .. arg_12_1))

	eachChild = var_1_10004

	var_1_10004(arg_12_0:Find("name/Text"), function(arg_14_0)
		setActive = var_2_10001

		var_2_10001(arg_14_0, arg_14_0.name == arg_12_1)

		return
	end)

	setActive = var_1_10004

	var_1_10004(arg_12_0:Find("result/lose"), arg_12_3 < 0)

	setActive = var_1_10004

	var_1_10004(arg_12_0:Find("result/win"), arg_12_3 > 0)

	eachChild = var_1_10004

	var_1_10004(arg_12_0:Find("point"), function(arg_15_0)
		setActive = var_2_10001

		local var_15_0 = arg_15_0

		tonumber = var_2_10003

		var_2_10001(var_15_0, var_2_10003(arg_15_0.name) <= arg_12_2)

		return
	end)

	return
end

function var_0_1.initOpenUISwich(arg_16_0)
	var_0_1.super.initOpenUISwich(arg_16_0)

	function arg_16_0.openSwitchDic.result()
		local var_17_0 = var_0_2
		local var_17_1 = arg_16_0.rtTitlePage
		local var_17_2 = var_1.Find(var_17_1, "result/window/self")
		local var_17_3 = arg_16_0.gameController

		var_17_0(var_17_2, var_2.GetResultInfo(var_17_3, false))

		local var_17_4 = var_0_2
		local var_17_5 = arg_16_0.rtTitlePage
		local var_17_6 = var_1.Find(var_17_5, "result/window/other")
		local var_17_7 = arg_16_0.gameController

		var_17_4(var_17_6, var_2.GetResultInfo(var_17_7, true))

		local var_17_8 = arg_16_0
		local var_17_9 = var_0.GetMGHubData(var_17_8)

		if arg_16_0.stageIndex == var_17_9.usedtime + 1 and var_17_9.count > 0 then
			local var_17_10 = arg_16_0

			var_1.SendSuccess(var_17_10, 0)
		end

		return
	end

	function arg_16_0.openSwitchDic.select()
		triggerToggle = var_2_10000

		local var_18_0 = arg_16_0.rtTitlePage

		var_2_10000(var_1.Find(var_18_0, "select/content/Marie"), true)

		return
	end

	return
end

function var_0_1.initBackPressSwitch(arg_19_0)
	var_0_1.super.initBackPressSwitch(arg_19_0)

	function arg_19_0.backPressSwitchDic.select()
		local var_20_0 = arg_19_0

		var_0.openUI(var_20_0, "main")

		return
	end

	return
end

function var_0_1.willExit(arg_21_0)
	local var_21_0 = arg_21_0.gameController

	var_1.willExit(var_21_0)

	return
end

return var_0_1
