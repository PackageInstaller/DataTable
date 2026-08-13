class = var_0_10000

local var_0_0 = "MiniGameTemplateView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.BaseMiniGameView"))

var_0_1.canSelectStage = true

function var_0_1.getUIName(arg_1_0)
	return nil
end

function var_0_1.getGameController(arg_2_0)
	return nil
end

function var_0_1.getShowSide(arg_3_0)
	return true
end

function var_0_1.updateMainUI(arg_4_0)
	if arg_4_0:getShowSide() then
		local var_4_0 = arg_4_0:GetMGHubData()
		local var_4_1 = var_1.getConfig(var_4_0, "reward_need")
		local var_4_2 = var_1.usedtime + var_1.count

		math = var_1_10005

		local var_4_3 = var_1_10005.min(var_1.usedtime + 1, var_4_2)
		local var_4_4 = arg_4_0.itemList.container.childCount

		for iter_4_0 = 1, var_4_4 do
			var_1_10012 = {}

			if iter_4_0 <= var_3 then
				var_1_10012.finish = true
			elseif iter_4_0 <= var_4_2 then
				-- block empty
			else
				var_1_10012.lock = true
			end

			local var_4_5 = var_6

			var_1_10013 = var_6.GetChild(var_4_5, iter_4_0 - 1)
			setActive = var_4_5

			var_4_5(var_1_10013:Find("finish"), var_1_10012.finish)

			setActive = var_4_5

			var_4_5(var_1_10013:Find("lock"), var_1_10012.lock)

			setToggleEnabled = var_4_5

			local var_4_6 = var_1_10013
			local var_4_7

			if arg_4_0.canSelectStage then
				var_4_7 = iter_4_0 <= var_4_3
			end

			var_4_5(var_4_6, var_4_7)

			triggerToggle = var_4_5

			var_4_5(var_1_10013, iter_4_0 == var_4_3)
		end

		local var_4_8 = var_6:GetChild(0).anchoredPosition.y - var_6:GetChild(var_4_3 - 1).anchoredPosition.y
		local var_4_9 = var_6.rect.height
		local var_4_10 = var_6
		local var_4_11 = var_6.GetComponent

		typeof = var_1_10012
		ScrollRect = var_1_10013

		local var_4_12 = var_4_11(var_4_10, var_1_10012(var_1_10013)).viewport.rect.height

		math = var_4_10

		local var_4_13 = var_4_10.clamp(var_4_8, 0, var_4_9 - var_4_12) / (var_4_9 - var_4_12)

		scrollTo = var_12

		var_12(var_6, nil, 1 - var_4_13)
	end

	arg_4_0:checkGet()

	return
end

function var_0_1.checkGet(arg_5_0)
	if arg_5_0:GetMGHubData().ultimate == 0 then
		local var_5_0 = var_1.usedtime
		local var_5_1 = var_1

		if var_5_0 < var_1.getConfig(var_5_1, "reward_need") then
			return
		end

		pg = var_5_0

		local var_5_2 = var_5_0.m02
		local var_5_3 = var_2.sendNotification

		GAME = var_5_1

		local var_5_4 = var_5_1.SEND_MINI_GAME_OP
		local var_5_5 = {
			hubid = var_1.id
		}

		MiniGameOPCommand = var_6
		var_5_5.cmd = var_6.CMD_ULTIMATE
		var_5_5.args1 = {}

		var_5_3(var_5_2, var_5_4, var_5_5)
	end

	return
end

function var_0_1.initPageUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.rtTitlePage = var_1.Find(var_6_0, "TitlePage")

	local var_6_1 = arg_6_0.rtTitlePage
	local var_6_2 = var_1.Find(var_6_1, "main")

	onButton = var_6_1

	local var_6_3 = arg_6_0
	local var_6_4 = var_6_2:Find("btn_back")

	local function var_6_5()
		local var_7_0 = arg_6_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_6

	var_6_1(var_6_3, var_6_4, var_6_5, var_6)

	onButton = var_6_1

	local var_6_6 = arg_6_0
	local var_6_7 = var_6_2:Find("btn_help")

	local function var_6_8()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		pg = var_2_10003
		var_8_2.helps = var_2_10003.gametip["2023spring_minigame_help"].tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_6

	var_6_1(var_6_6, var_6_7, var_6_8, var_6)

	local var_6_9 = arg_6_0:GetMGData()
	local var_6_10 = var_2.GetSimpleValue(var_6_9, "story")

	onButton = var_6_9

	local var_6_11 = arg_6_0
	local var_6_12 = var_6_2:Find("btn_start")

	local function var_6_13()
		local var_9_0 = {}

		checkExist = var_2_10001

		if var_2_10001(var_6_10, {
			arg_6_0.stageIndex
		}, {
			1
		}) then
			table = var_2

			var_2.insert(var_9_0, function(arg_10_0)
				pg = var_3_10001

				local var_10_0 = var_3_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_10_0, var_0, arg_10_0)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_9_0, function()
			local var_11_0 = arg_6_0

			var_0.openUI(var_11_0, "countdown")

			return
		end)

		return
	end

	SFX_PANEL = var_7

	var_6_9(var_6_11, var_6_12, var_6_13, var_7)

	arg_6_0.stageIndex = 0

	if arg_6_0:getShowSide() then
		pg = var_3

		local var_6_14 = var_3.mini_game[arg_6_0:GetMGData().id].simple_config_data.drop
		local var_6_15 = var_6_2
		local var_6_16 = var_6_2.Find(var_6_15, "side_panel/award/content")

		UIItemList = var_6_15
		arg_6_0.itemList = var_6_15.New(var_6_16, var_6_16:GetChild(0))

		local var_6_17 = arg_6_0.itemList

		var_5.make(var_6_17, function(arg_12_0, arg_12_1, arg_12_2)
			arg_12_1 = arg_12_1 + 1
			UIItemList = var_2_10003

			if arg_12_0 == var_2_10003.EventUpdate then
				local var_12_0 = arg_12_2:Find("IconTpl")
				local var_12_1 = {}

				unpack = var_5

				local var_12_2, var_12_3, var_12_4 = var_5(var_6_14[arg_12_1])

				var_12_1.count = var_12_4
				var_12_1.id = var_12_3
				var_12_1.type = var_12_2
				updateDrop = var_12_2

				var_12_2(var_12_0, var_12_1)

				onButton = var_12_2

				local var_12_5 = arg_6_0
				local var_12_6 = var_12_0

				local function var_12_7()
					local var_13_0 = arg_6_0

					var_0.emit(var_13_0, var_0_1.ON_DROP, var_12_1)

					return
				end

				SFX_PANEL = var_2_10009

				var_12_2(var_12_5, var_12_6, var_12_7, var_2_10009)

				onToggle = var_12_2

				var_12_2(arg_6_0, arg_12_2, function(arg_14_0)
					if arg_14_0 then
						arg_6_0.stageIndex = arg_12_1
					end

					return
				end)
			end

			return
		end)

		local var_6_18 = arg_6_0.itemList

		var_5.align(var_6_18, #var_6_14)
	end

	local var_6_19 = arg_6_0.rtTitlePage
	local var_6_20 = var_3.Find(var_6_19, "countdown")
	local var_6_21 = var_3.Find(var_6_20, "bg/Image")
	local var_6_22 = var_4.GetComponent

	typeof = var_6
	DftAniEvent = var_7

	local var_6_23 = var_6_22(var_6_21, var_6(var_7))

	var_4.SetEndEvent(var_6_23, function()
		local var_15_0 = arg_6_0

		var_0.openUI(var_15_0)

		local var_15_1 = arg_6_0.gameController

		var_0.StartGame(var_15_1)

		return
	end)

	local var_6_24 = arg_6_0.rtTitlePage
	local var_6_25 = var_4.Find(var_6_24, "pause")

	onButton = var_6_24

	local var_6_26 = arg_6_0
	local var_6_27 = var_6_25:Find("window/btn_confirm")

	local function var_6_28()
		local var_16_0 = arg_6_0

		var_0.openUI(var_16_0)

		local var_16_1 = arg_6_0.gameController

		var_0.ResumeGame(var_16_1)

		return
	end

	SFX_CONFIRM = var_9

	var_6_24(var_6_26, var_6_27, var_6_28, var_9)

	local var_6_29 = arg_6_0.rtTitlePage
	local var_6_30 = var_5.Find(var_6_29, "exit")

	onButton = var_6_29

	local var_6_31 = arg_6_0
	local var_6_32 = var_6_30:Find("window/btn_cancel")

	local function var_6_33()
		local var_17_0 = arg_6_0

		var_0.openUI(var_17_0)

		local var_17_1 = arg_6_0.gameController

		var_0.ResumeGame(var_17_1)

		return
	end

	SFX_CANCEL = var_10

	var_6_29(var_6_31, var_6_32, var_6_33, var_10)

	onButton = var_6_29

	local var_6_34 = arg_6_0
	local var_6_35 = var_6_30:Find("window/btn_confirm")

	local function var_6_36()
		local var_18_0 = arg_6_0

		var_0.openUI(var_18_0)

		local var_18_1 = arg_6_0.gameController

		var_0.EndGame(var_18_1)

		return
	end

	SFX_CONFIRM = var_10

	var_6_29(var_6_34, var_6_35, var_6_36, var_10)

	local var_6_37 = arg_6_0.rtTitlePage
	local var_6_38 = var_6.Find(var_6_37, "result")

	onButton = var_6_37

	local var_6_39 = arg_6_0
	local var_6_40 = var_6_38:Find("window/btn_finish")

	local function var_6_41()
		local var_19_0 = arg_6_0

		var_0.openUI(var_19_0, "main")

		return
	end

	SFX_CONFIRM = var_11

	var_6_37(var_6_39, var_6_40, var_6_41, var_11)

	return
end

function var_0_1.initControllerUI(arg_20_0)
	local var_20_0 = arg_20_0._tf
	local var_20_1 = var_1.Find(var_20_0, "Controller/top")

	onButton = var_20_0

	local var_20_2 = arg_20_0
	local var_20_3 = var_20_1:Find("btn_back")

	local function var_20_4()
		local var_21_0 = arg_20_0

		var_0.openUI(var_21_0, "exit")

		return
	end

	SFX_PANEL = var_6

	var_20_0(var_20_2, var_20_3, var_20_4, var_6)

	onButton = var_20_0

	var_20_0(arg_20_0, var_20_1:Find("btn_pause"), function()
		local var_22_0 = arg_20_0

		var_0.openUI(var_22_0, "pause")

		return
	end)

	return
end

function var_0_1.SaveDataChange(arg_23_0, arg_23_1)
	arg_23_0:StoreDataToServer(arg_23_1)

	return
end

function var_0_1.didEnter(arg_24_0)
	arg_24_0:initPageUI()
	arg_24_0:initControllerUI()

	arg_24_0.gameController = arg_24_0:getGameController().New(arg_24_0, arg_24_0._tf)

	arg_24_0:openUI("main")

	return
end

function var_0_1.initOpenUISwich(arg_25_0)
	arg_25_0.openSwitchDic = {
		main = function()
			local var_26_0 = arg_25_0

			var_0.updateMainUI(var_26_0)

			return
		end,
		pause = function()
			local var_27_0 = arg_25_0.gameController

			var_0.PauseGame(var_27_0)

			return
		end,
		exit = function()
			local var_28_0 = arg_25_0.gameController

			var_0.PauseGame(var_28_0)

			return
		end,
		result = function()
			local var_29_0 = arg_25_0
			local var_29_1 = var_0.GetMGData(var_29_0)
			local var_29_2

			if not var_0.GetRuntimeData(var_29_1, "elements") then
				var_29_2 = {}
			end

			local var_29_3 = arg_25_0.gameController.point
			local var_29_4

			if not var_29_2[1] then
				var_29_4 = 0
			end

			local var_29_5 = arg_25_0.rtTitlePage
			local var_29_6 = var_3.Find(var_29_5, "result")

			setActive = var_29_5

			var_29_5(var_29_6:Find("window/now/new"), var_29_4 < var_29_3)

			if var_29_4 <= var_29_3 then
				var_29_4 = var_29_3
				var_29_2[1] = var_29_3
			end

			local var_29_7 = arg_25_0

			var_4.SaveDataChange(var_29_7, var_29_2)

			setText = var_4

			var_4(var_29_6:Find("window/high/Text"), var_29_4)

			setText = var_4

			var_4(var_29_6:Find("window/now/Text"), var_29_3)

			local var_29_8 = arg_25_0
			local var_29_9 = var_4.GetMGHubData(var_29_8)
			local var_29_10 = arg_25_0

			if (not var_5.getShowSide(var_29_10) or arg_25_0.stageIndex == var_29_9.usedtime + 1) and var_29_9.count > 0 then
				local var_29_11 = arg_25_0

				var_5.SendSuccess(var_29_11, 0)
			end

			return
		end
	}

	return
end

function var_0_1.openUI(arg_30_0, arg_30_1)
	if not arg_30_0.openSwitchDic then
		arg_30_0:initOpenUISwich()
	end

	if arg_30_0.status then
		setActive = var_2

		local var_30_0 = arg_30_0.rtTitlePage

		var_2(var_3.Find(var_30_0, arg_30_0.status), false)
	end

	if arg_30_1 then
		setActive = var_2

		local var_30_1 = arg_30_0.rtTitlePage

		var_2(var_3.Find(var_30_1, arg_30_1), true)
	end

	arg_30_0.status = arg_30_1
	switch = var_2

	var_2(arg_30_1, arg_30_0.openSwitchDic)

	return
end

function var_0_1.initBackPressSwitch(arg_31_0)
	arg_31_0.backPressSwitchDic = {
		main = function()
			var_0_1.super.onBackPressed(arg_31_0)

			return
		end,
		countdown = function()
			return
		end,
		pause = function()
			local var_34_0 = arg_31_0

			var_0.openUI(var_34_0)

			local var_34_1 = arg_31_0.gameController

			var_0.ResumeGame(var_34_1)

			return
		end,
		exit = function()
			local var_35_0 = arg_31_0

			var_0.openUI(var_35_0)

			local var_35_1 = arg_31_0.gameController

			var_0.ResumeGame(var_35_1)

			return
		end,
		result = function()
			return
		end
	}

	return
end

function var_0_1.onBackPressed(arg_37_0)
	if not arg_37_0.backPressSwitchDic then
		arg_37_0:initBackPressSwitch()
	end

	switch = var_1

	var_1(arg_37_0.status, arg_37_0.backPressSwitchDic, function()
		assert = var_2_10000

		var_2_10000(arg_37_0.gameController.isStart)

		local var_38_0 = arg_37_0

		var_0.openUI(var_38_0, "pause")

		return
	end)

	return
end

function var_0_1.willExit(arg_39_0)
	return
end

return var_0_1
