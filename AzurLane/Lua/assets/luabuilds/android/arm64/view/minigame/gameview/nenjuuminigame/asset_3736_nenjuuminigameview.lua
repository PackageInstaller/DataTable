class = var_0_10000

local var_0_0 = "NenjuuMiniGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "NenjuuMiniGameUI"
end

function var_0_1.openUI(arg_2_0, arg_2_1)
	if arg_2_0.status then
		setActive = var_2

		local var_2_0 = arg_2_0.rtTitlePage

		var_2(var_4.Find(var_2_0, arg_2_0.status), false)
	end

	if arg_2_1 then
		setActive = var_2

		local var_2_1 = arg_2_0.rtTitlePage

		var_2(var_4.Find(var_2_1, arg_2_1), true)
	end

	arg_2_0.status = arg_2_1
	switch = var_2

	var_2(arg_2_1, {
		main = function()
			local var_3_0 = arg_2_0

			var_0.updateMainUI(var_3_0)

			return
		end,
		pause = function()
			local var_4_0 = arg_2_0.gameController

			var_0.PauseGame(var_4_0)

			return
		end,
		exit = function()
			local var_5_0 = arg_2_0.gameController

			var_0.PauseGame(var_5_0)

			return
		end,
		result = function()
			NenjuuGameConfig = var_2_10000

			local var_6_0 = var_2_10000.ParsingElements
			local var_6_1 = arg_2_0
			local var_6_2 = var_2.GetMGData(var_6_1)
			local var_6_3

			if not var_2.GetRuntimeData(var_6_2, "elements") then
				var_6_3 = {}
			end

			local var_6_4 = var_6_0(var_6_3)
			local var_6_5 = arg_2_0.gameController.point
			local var_6_6 = var_6_4.high
			local var_6_7 = arg_2_0.rtTitlePage
			local var_6_8 = var_3.Find(var_6_7, "result")

			setActive = var_6_2

			var_6_2(var_6_8:Find("window/now/new"), var_6_6 < var_6_5)

			if var_6_6 <= var_6_5 then
				var_6_6 = var_6_5
				var_6_4.high = var_6_5
			end

			var_6_4.count = var_6_4.count + var_6_5

			local var_6_9 = arg_2_0

			var_4.SaveDataChange(var_6_9, var_6_4)

			setText = var_4

			var_4(var_6_8:Find("window/high/Text"), var_6_6)

			setText = var_4

			var_4(var_6_8:Find("window/now/Text"), var_6_5)

			local var_6_10 = arg_2_0
			local var_6_11 = var_4.GetMGHubData(var_6_10)

			if arg_2_0.stageIndex == var_6_11.usedtime + 1 and var_6_11.count > 0 then
				local var_6_12 = arg_2_0

				var_5.SendSuccess(var_6_12, 0)
			end

			return
		end
	})

	return
end

function var_0_1.updateMainUI(arg_7_0)
	local var_7_0 = arg_7_0:GetMGHubData()
	local var_7_1 = var_1.getConfig(var_7_0, "reward_need")
	local var_7_2 = var_1.usedtime + var_1.count

	math = var_5

	local var_7_3 = var_5.min(var_1.usedtime + 1, var_7_2)
	local var_7_4 = arg_7_0.itemList.container.childCount

	for iter_7_0 = 1, var_7_4 do
		local var_7_5 = {}

		if iter_7_0 <= var_3 then
			var_7_5.finish = true
		elseif iter_7_0 <= var_7_2 then
			-- block empty
		else
			var_7_5.lock = true
		end

		local var_7_6 = var_6:GetChild(iter_7_0 - 1)

		setActive = var_1_10014

		var_1_10014(var_7_6:Find("finish"), var_7_5.finish)

		setActive = var_1_10014

		var_1_10014(var_7_6:Find("lock"), var_7_5.lock)

		setToggleEnabled = var_1_10014

		var_1_10014(var_7_6, iter_7_0 <= var_7_3)

		triggerToggle = var_1_10014

		var_1_10014(var_7_6, iter_7_0 == var_7_3)
	end

	arg_7_0:checkGet()

	return
end

function var_0_1.checkGet(arg_8_0)
	if arg_8_0:GetMGHubData().ultimate == 0 then
		local var_8_0 = var_1.usedtime
		local var_8_1 = var_1

		if var_8_0 < var_1.getConfig(var_8_1, "reward_need") then
			return
		end

		pg = var_8_0

		local var_8_2 = var_8_0.m02
		local var_8_3 = var_2.sendNotification

		GAME = var_8_1

		local var_8_4 = var_8_1.SEND_MINI_GAME_OP
		local var_8_5 = {
			hubid = var_1.id
		}

		MiniGameOPCommand = var_7
		var_8_5.cmd = var_7.CMD_ULTIMATE
		var_8_5.args1 = {}

		var_8_3(var_8_2, var_8_4, var_8_5)
	end

	return
end

function var_0_1.initPageUI(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.rtTitlePage = var_1.Find(var_9_0, "TitlePage")

	local var_9_1 = arg_9_0.rtTitlePage
	local var_9_2 = var_1.Find(var_9_1, "main")

	onButton = var_1_10002

	local var_9_3 = arg_9_0
	local var_9_4 = var_9_2
	local var_9_5 = var_9_2.Find(var_9_4, "btn_back")

	local function var_9_6()
		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_9_4

	var_1_10002(var_9_3, var_9_5, var_9_6, var_9_4)

	onButton = var_1_10002

	local var_9_7 = arg_9_0
	local var_9_8 = var_9_2
	local var_9_9 = var_9_2.Find(var_9_8, "btn_home")

	local function var_9_10()
		local var_11_0 = arg_9_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10003

		var_11_1(var_11_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CANCEL = var_9_8

	var_1_10002(var_9_7, var_9_9, var_9_10, var_9_8)

	onButton = var_1_10002

	local var_9_11 = arg_9_0
	local var_9_12 = var_9_2
	local var_9_13 = var_9_2.Find(var_9_12, "btn_help")

	local function var_9_14()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_12_2.type = var_2_10004
		pg = var_2_10004
		var_12_2.helps = var_2_10004.gametip["2023spring_minigame_help"].tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_9_12

	var_1_10002(var_9_11, var_9_13, var_9_14, var_9_12)

	onButton = var_1_10002

	local var_9_15 = arg_9_0
	local var_9_16 = var_9_2
	local var_9_17 = var_9_2.Find(var_9_16, "btn_opreation")

	local function var_9_18()
		setActive = var_2_10000

		local var_13_0 = arg_9_0.rtLevel

		var_2_10000(var_2.Find(var_13_0, "Opreation"), true)

		local var_13_1 = arg_9_0

		var_0.UpdateOpreationPage(var_13_1, 1)

		return
	end

	SFX_PANEL = var_9_16

	var_1_10002(var_9_15, var_9_17, var_9_18, var_9_16)

	local var_9_19 = arg_9_0:GetMGData()
	local var_9_20 = var_2.GetSimpleValue(var_9_19, "story")

	onButton = var_9_1

	local var_9_21 = arg_9_0
	local var_9_22 = var_9_2
	local var_9_23 = var_9_2.Find(var_9_22, "btn_start")

	local function var_9_24()
		local var_14_0 = {}

		checkExist = var_2_10001

		if var_2_10001(var_9_20, {
			arg_9_0.stageIndex
		}, {
			1
		}) then
			table = var_2_10002

			var_2_10002.insert(var_14_0, function(arg_15_0)
				pg = var_3_10001

				local var_15_0 = var_3_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_15_0, var_0, arg_15_0)

				return
			end)
		end

		seriesAsync = var_2_10002

		var_2_10002(var_14_0, function()
			local var_16_0 = arg_9_0

			var_0.openReadyPage(var_16_0)

			return
		end)

		return
	end

	SFX_PANEL = var_9_22

	var_9_1(var_9_21, var_9_23, var_9_24, var_9_22)

	arg_9_0.stageIndex = 0
	pg = var_3

	local var_9_25 = var_3.mini_game[arg_9_0:GetMGData().id].simple_config_data.drop
	local var_9_26 = var_9_2:Find("side_panel/award/content")

	UIItemList = var_9_21
	arg_9_0.itemList = var_9_21.New(var_9_26, var_9_26:GetChild(0))

	local var_9_27 = arg_9_0.itemList

	var_5.make(var_9_27, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_17_2
			local var_17_1 = arg_17_2.Find(var_17_0, "IconTpl")
			local var_17_2 = {}

			unpack = var_17_0

			local var_17_3, var_17_4, var_17_5 = var_17_0(var_9_25[arg_17_1])

			var_17_2.count = var_17_5
			var_17_2.id = var_17_4
			var_17_2.type = var_17_3
			updateDrop = var_17_3

			var_17_3(var_17_1, var_17_2)

			onButton = var_17_3

			local var_17_6 = arg_9_0
			local var_17_7 = var_17_1

			local function var_17_8()
				local var_18_0 = arg_9_0

				var_0.emit(var_18_0, var_0_1.ON_DROP, var_17_2)

				return
			end

			SFX_PANEL = var_2_10010

			var_17_3(var_17_6, var_17_7, var_17_8, var_2_10010)

			onToggle = var_17_3

			var_17_3(arg_9_0, arg_17_2, function(arg_19_0)
				if arg_19_0 then
					arg_9_0.stageIndex = arg_17_1
				end

				return
			end)
		end

		return
	end)

	local var_9_28 = arg_9_0.itemList

	var_5.align(var_9_28, #var_9_25)

	local var_9_29 = arg_9_0.rtTitlePage
	local var_9_30 = var_5.Find(var_9_29, "countdown")
	local var_9_31 = var_5.Find(var_9_30, "bg/Image")
	local var_9_32 = var_6.GetComponent

	typeof = var_9
	DftAniEvent = var_11

	local var_9_33 = var_9_32(var_9_31, var_9(var_11))

	var_6.SetEndEvent(var_9_33, function()
		local var_20_0 = arg_9_0

		var_0.openUI(var_20_0)

		local var_20_1 = arg_9_0.gameController

		var_0.StartGame(var_20_1)

		return
	end)

	local var_9_34 = arg_9_0.rtTitlePage
	local var_9_35 = var_6.Find(var_9_34, "pause")

	onButton = var_9_29

	local var_9_36 = arg_9_0
	local var_9_37 = var_9_35
	local var_9_38 = var_9_35.Find(var_9_37, "window/btn_confirm")

	local function var_9_39()
		local var_21_0 = arg_9_0

		var_0.openUI(var_21_0)

		local var_21_1 = arg_9_0.gameController

		var_0.ResumeGame(var_21_1)

		return
	end

	SFX_CONFIRM = var_9_37

	var_9_29(var_9_36, var_9_38, var_9_39, var_9_37)

	local var_9_40 = arg_9_0.rtTitlePage
	local var_9_41 = var_7.Find(var_9_40, "exit")

	onButton = var_9_34

	local var_9_42 = arg_9_0
	local var_9_43 = var_9_41
	local var_9_44 = var_9_41.Find(var_9_43, "window/btn_cancel")

	local function var_9_45()
		local var_22_0 = arg_9_0

		var_0.openUI(var_22_0)

		local var_22_1 = arg_9_0.gameController

		var_0.ResumeGame(var_22_1)

		return
	end

	SFX_CANCEL = var_9_43

	var_9_34(var_9_42, var_9_44, var_9_45, var_9_43)

	onButton = var_9_34

	local var_9_46 = arg_9_0
	local var_9_47 = var_9_41
	local var_9_48 = var_9_41.Find(var_9_47, "window/btn_confirm")

	local function var_9_49()
		local var_23_0 = arg_9_0

		var_0.openUI(var_23_0)

		local var_23_1 = arg_9_0.gameController

		var_0.EndGame(var_23_1)

		return
	end

	SFX_CONFIRM = var_9_47

	var_9_34(var_9_46, var_9_48, var_9_49, var_9_47)

	local var_9_50 = arg_9_0.rtTitlePage
	local var_9_51 = var_8.Find(var_9_50, "result")

	onButton = var_9_40

	local var_9_52 = arg_9_0
	local var_9_53 = var_9_51
	local var_9_54 = var_9_51.Find(var_9_53, "window/btn_finish")

	local function var_9_55()
		local var_24_0 = arg_9_0

		var_0.openUI(var_24_0, "main")

		return
	end

	SFX_CONFIRM = var_9_53

	var_9_40(var_9_52, var_9_54, var_9_55, var_9_53)

	return
end

function var_0_1.initLeveUI(arg_25_0)
	local var_25_0 = arg_25_0._tf

	arg_25_0.rtLevel = var_1.Find(var_25_0, "LevelPage")

	local var_25_1 = arg_25_0.rtLevel
	local var_25_2 = var_1.Find(var_25_1, "Opreation")

	onButton = var_1_10002

	local var_25_3 = arg_25_0
	local var_25_4 = var_25_2
	local var_25_5 = var_25_2.Find(var_25_4, "btn_back")

	local function var_25_6()
		setActive = var_2_10000

		var_2_10000(var_25_2, false)

		return
	end

	SFX_CANCEL = var_25_4

	var_1_10002(var_25_3, var_25_5, var_25_6, var_25_4)

	return
end

local var_0_2 = {
	bomb = {
		"2023spring_minigame_item_firecracker"
	},
	lantern = {
		"2023spring_minigame_item_lantern"
	},
	ice = {
		"2023spring_minigame_skill_icewall",
		"2023spring_minigame_skill_icewall_up"
	},
	flash = {
		"2023spring_minigame_skill_flash",
		"2023spring_minigame_skill_flash_up"
	},
	rush = {
		"2023spring_minigame_skill_sprint",
		"2023spring_minigame_skill_sprint_up"
	},
	blessing = {
		"2023spring_minigame_bless_speed",
		"2023spring_minigame_bless_speed_up"
	},
	decoy = {
		"2023spring_minigame_bless_substitute",
		"2023spring_minigame_bless_substitute_up"
	}
}

function var_0_1.UpdateOpreationPage(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.rtLevel
	local var_27_1 = var_2.Find(var_27_0, "Opreation")

	NenjuuGameConfig = var_1_10003

	local var_27_2 = var_1_10003.ParsingElements
	local var_27_3 = arg_27_0:GetMGData()
	local var_27_4

	if not var_5.GetRuntimeData(var_27_3, "elements") then
		var_27_4 = {}
	end

	local var_27_5 = var_27_2(var_27_4)

	setText = var_27_0

	var_27_0(var_27_1:Find("point/Text"), var_27_5.count)

	local var_27_6 = {
		{
			"bomb",
			"lantern"
		},
		{
			"ice",
			"flash",
			"rush"
		},
		{
			"blessing",
			"decoy"
		}
	}
	local var_27_7
	local var_27_8 = var_27_1:Find("main/view/content")

	UIItemList = var_7

	local var_27_9 = var_7.New(var_27_8, var_27_8:Find("tpl"))

	var_7.make(var_27_9, function(arg_28_0, arg_28_1, arg_28_2)
		arg_28_1 = arg_28_1 + 1
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = var_27_7[arg_28_1]

			setActive = var_2_10004

			var_2_10004(arg_28_2:Find("empty"), not var_28_0)

			setActive = var_2_10004

			var_2_10004(arg_28_2:Find("info"), var_28_0)

			if var_28_0 then
				local var_28_1 = arg_28_2
				local var_28_2 = arg_28_2.Find(var_28_1, "info")

				eachChild = var_2_10005

				var_2_10005(var_28_2:Find("icon"), function(arg_29_0)
					setActive = var_3_10001

					var_3_10001(arg_29_0, arg_29_0.name == var_28_0)

					return
				end)

				string = var_2_10005

				local var_28_3 = var_2_10005.split

				i18n = var_7

				local var_28_4 = var_28_3(var_7(var_0_2[var_28_0][1]), "|")

				setText = var_28_1

				var_28_1(var_28_2:Find("name/Text"), var_28_4[1])

				setText = var_28_1

				var_28_1(var_28_2:Find("desc"), var_28_4[2])

				setActive = var_28_1

				var_28_1(var_28_2:Find("level"), var_0_2[var_28_0][2])

				local var_28_5

				if var_0_2[var_28_0][2] then
					string = var_28_5
					var_28_5 = var_28_5.split
					i18n = var_8
					var_28_5 = var_28_5(var_8(var_0_2[var_28_0][2]), "|")

					for iter_28_0 = 1, 3 do
						local var_28_6 = var_28_2:Find("level/" .. iter_28_0)

						setActive = var_2_10012

						var_2_10012(var_28_6, var_28_5[iter_28_0])

						if var_28_5[iter_28_0] then
							setTextColor = var_2_10012

							local var_28_7 = var_28_6:Find("Text")

							Color = var_15

							var_2_10012(var_28_7, var_15.NewHex(iter_28_0 > var_27_5.level[var_28_0] and "8D90AFFF" or "535885FF"))

							changeToScrollText = var_2_10012

							local var_28_8 = var_28_6:Find("info")

							setColorStr = var_15

							var_2_10012(var_28_8, var_15(var_28_5[iter_28_0], iter_28_0 > var_27_5.level[var_28_0] and "#8D90AFFF" or "#535885FF"))
						end
					end
				end

				eachChild = var_28_5

				var_28_5(var_28_2:Find("status"), function(arg_30_0)
					setActive = var_3_10001

					var_3_10001(arg_30_0, false)

					return
				end)

				onButton = var_28_5

				local var_28_9 = arg_27_0
				local var_28_10 = var_28_2
				local var_28_11 = var_28_2.Find(var_28_10, "status/btn_equip")

				local function var_28_12()
					var_27_5.item = var_28_0

					local var_31_0 = arg_27_0

					var_0.SaveDataChange(var_31_0, var_27_5)

					local var_31_1 = arg_27_0

					var_0.UpdateOpreationPage(var_31_1, arg_27_1)

					return
				end

				SFX_CONFIRM = var_28_10

				var_28_5(var_28_9, var_28_11, var_28_12, var_28_10)

				onButton = var_28_5

				local var_28_13 = arg_27_0
				local var_28_14 = var_28_2
				local var_28_15 = var_28_2.Find(var_28_14, "status/btn_unlock")

				local function var_28_16()
					local var_32_0 = var_27_5
					local var_32_1 = var_27_5.count

					NenjuuGameConfig = var_3_10002
					var_32_0.count = var_32_1 - var_3_10002.SKILL_LEVEL_CONFIG[var_28_0].cost[var_27_5.level[var_28_0] + 1]
					var_27_5.level[var_28_0] = var_27_5.level[var_28_0] + 1

					local var_32_3

					if var_27_5.level[var_28_0] > 1 then
						pg = var_32_3

						local var_32_2 = var_32_3.TipsMgr.GetInstance()

						var_32_3 = var_32_3.ShowTips
						i18n = var_3

						var_32_3(var_32_2, var_3("2023spring_minigame_tip7", var_28_4[1]))
					else
						pg = var_32_3

						local var_32_4 = var_32_3.TipsMgr.GetInstance()
						local var_32_5 = var_0.ShowTips

						i18n = var_3

						var_32_5(var_32_4, var_3("2023spring_minigame_tip6", var_28_4[1]))
					end

					local var_32_6 = arg_27_0

					var_0.SaveDataChange(var_32_6, var_27_5)

					local var_32_7 = arg_27_0

					var_0.UpdateOpreationPage(var_32_7, arg_27_1)

					return
				end

				SFX_CONFIRM = var_28_14

				var_28_5(var_28_13, var_28_15, var_28_16, var_28_14)

				local var_28_17 = var_27_5.level[var_28_0]

				NenjuuGameConfig = var_7

				if var_28_17 < #var_7.SKILL_LEVEL_CONFIG[var_28_0].cost then
					NenjuuGameConfig = var_28_17
					var_28_17 = var_28_17.SKILL_LEVEL_CONFIG[var_28_0].cost[var_27_5.level[var_28_0] + 1]

					if var_27_5.count < var_28_17 then
						setText = var_7

						var_7(var_28_2:Find("status/btn_lock/point"), var_28_17)

						setText = var_7
						var_28_15 = var_28_2:Find("status/btn_lock/Text")
						i18n = var_10

						var_7(var_28_15, var_10("2023spring_minigame_tip3"))

						setActive = var_7

						var_7(var_28_2:Find("status/btn_lock"), true)
					else
						setText = var_7

						var_7(var_28_2:Find("status/btn_unlock/point"), var_28_17)

						setText = var_7
						var_28_15 = var_28_2:Find("status/btn_unlock/Text")
						i18n = var_10

						var_7(var_28_15, var_10("2023spring_minigame_tip3"))

						setActive = var_7

						var_7(var_28_2:Find("status/btn_unlock"), true)
					end
				elseif var_28_0 == "bomb" or var_28_0 == "lantern" then
					setText = var_28_17

					local var_28_18 = var_28_2:Find("status/btn_equip/Text")

					i18n = var_28_15

					var_28_17(var_28_18, var_28_15("2023spring_minigame_tip1"))

					setActive = var_28_17

					var_28_17(var_28_2:Find("status/btn_equip"), var_27_5.item ~= var_28_0)

					setText = var_28_17

					local var_28_19 = var_28_2:Find("status/btn_in/Text")

					i18n = var_9

					var_28_17(var_28_19, var_9("2023spring_minigame_tip2"))

					setActive = var_28_17

					var_28_17(var_28_2:Find("status/btn_in"), var_27_5.item == var_28_0)
				else
					setActive = var_28_17

					var_28_17(var_28_2:Find("status/unlock"), true)
				end
			end
		end

		return
	end)

	ipairs = var_8

	for iter_27_0, iter_27_1 in var_8(var_27_6) do
		onToggle = var_13

		local var_27_10 = arg_27_0
		local var_27_11 = var_27_1
		local var_27_12 = var_27_1.Find(var_27_11, "toggles/" .. iter_27_0)

		local function var_27_13(arg_33_0)
			arg_27_1 = iter_27_0
			var_27_7 = iter_27_1

			local var_33_0 = var_0

			var_1.align(var_33_0, 4)

			setActive = var_1

			local var_33_1 = var_27_1

			var_1(var_3.Find(var_33_1, "main/tip"), iter_27_0 == 1)

			return
		end

		SFX_PANEL = var_27_11

		var_13(var_27_10, var_27_12, var_27_13, var_27_11)
	end

	triggerToggle = var_8

	var_8(var_27_1:Find("toggles/" .. arg_27_1), true)

	return
end

local function var_0_3(arg_34_0, arg_34_1, arg_34_2)
	ipairs = var_1_10003
	NenjuuGameConfig = var_1_10005

	for iter_34_0, iter_34_1 in var_1_10003(var_1_10005.ABILITY_LIST) do
		if arg_34_0[iter_34_1] then
			arg_34_1 = arg_34_1 + arg_34_2[iter_34_1]
		end
	end

	return arg_34_1
end

function var_0_1.openReadyPage(arg_35_0)
	NenjuuGameConfig = var_1_10001

	local var_35_0 = var_1_10001.ParsingElements
	local var_35_1 = arg_35_0:GetMGData()
	local var_35_2

	if not var_3.GetRuntimeData(var_35_1, "elements") then
		var_35_2 = {}
	end

	local var_35_3 = var_35_0(var_35_2)

	NenjuuGameConfig = var_1_10002

	local var_35_4 = var_1_10002.GetStageConfig("Spring23Level_" .. arg_35_0.stageIndex)
	local var_35_5, var_35_6

	if not arg_35_0.abilityCache[arg_35_0.stageIndex] then
		var_35_5 = arg_35_0.abilityCache
		var_35_6 = arg_35_0.stageIndex
		setmetatable = var_5
		var_35_5[var_35_6] = var_5({}, {
			__index = var_35_4.ability_config
		})
	end

	setActive = var_35_5

	local var_35_7 = arg_35_0.rtLevel

	var_35_5(var_5.Find(var_35_7, "Ready"), true)

	onButton = var_35_5

	local var_35_8 = arg_35_0
	local var_35_9 = arg_35_0.rtLevel
	local var_35_10 = var_6.Find(var_35_9, "Ready/bg")

	local function var_35_11()
		setActive = var_2_10000

		local var_36_0 = arg_35_0.rtLevel

		var_2_10000(var_2.Find(var_36_0, "Ready"), false)

		return
	end

	SFX_CANCEL = var_35_9

	var_35_5(var_35_8, var_35_10, var_35_11, var_35_9)

	local var_35_12 = arg_35_0.rtLevel
	local var_35_13 = var_3.Find(var_35_12, "Ready/main")

	eachChild = var_35_6

	var_35_6(var_35_13:Find("title"), function(arg_37_0)
		setActive = var_2_10001

		local var_37_0 = arg_37_0
		local var_37_1 = arg_37_0.name

		tostring = var_2_10005

		var_2_10001(var_37_0, var_37_1 == var_2_10005(arg_35_0.stageIndex))

		return
	end)

	setText = var_35_6

	var_35_6(var_35_13:Find("rate/Image/Text"), var_0_3(arg_35_0.abilityCache[arg_35_0.stageIndex], var_35_4.base_rate, var_35_4.ability_rate))

	setText = var_35_6

	var_35_6(var_35_13:Find("high/Image/Text"), var_35_3["stage_" .. arg_35_0.stageIndex])

	setText = var_35_6

	local var_35_14 = var_35_13:Find("ability_text/Text")

	i18n = var_7

	var_35_6(var_35_14, var_7("2023spring_minigame_tip5"))

	underscore = var_35_6

	local var_35_15 = var_35_6.filter

	NenjuuGameConfig = var_35_14

	local var_35_16 = var_35_15(var_35_14.ABILITY_LIST, function(arg_38_0)
		return arg_35_0.abilityCache[arg_35_0.stageIndex][arg_38_0]
	end)

	UIItemList = var_35_12

	local var_35_17 = var_35_12.New(var_35_13:Find("abilitys"), var_35_13:Find("abilitys/tpl"))

	var_5.make(var_35_17, function(arg_39_0, arg_39_1, arg_39_2)
		arg_39_1 = arg_39_1 + 1
		UIItemList = var_2_10003

		if arg_39_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_39_2:Find("empty"), not var_35_16[arg_39_1])

			setActive = var_3

			var_3(arg_39_2:Find("enable"), var_35_16[arg_39_1])

			if var_35_16[arg_39_1] then
				eachChild = var_3

				var_3(arg_39_2:Find("enable"), function(arg_40_0)
					setActive = var_3_10001

					var_3_10001(arg_40_0, arg_40_0.name == var_35_16[arg_39_1])

					return
				end)
			end
		end

		return
	end)

	local var_35_18 = var_5
	local var_35_19 = var_5.align

	NenjuuGameConfig = var_9

	var_35_19(var_35_18, #var_9.ABILITY_LIST)

	onButton = var_35_19

	local var_35_20 = arg_35_0
	local var_35_21 = var_35_13
	local var_35_22 = var_35_13.Find(var_35_21, "btn_rate")

	local function var_35_23()
		setActive = var_2_10000

		local var_41_0 = arg_35_0.rtLevel

		var_2_10000(var_2.Find(var_41_0, "Ready"), false)

		local var_41_1 = arg_35_0

		var_0.openRatePage(var_41_1)

		return
	end

	SFX_PANEL = var_35_21

	var_35_19(var_35_20, var_35_22, var_35_23, var_35_21)

	onButton = var_35_19

	local var_35_24 = arg_35_0
	local var_35_25 = var_35_13
	local var_35_26 = var_35_13.Find(var_35_25, "btn_continue")

	local function var_35_27()
		setActive = var_2_10000

		local var_42_0 = arg_35_0.rtLevel

		var_2_10000(var_2.Find(var_42_0, "Ready"), false)

		local var_42_1 = arg_35_0.gameController

		var_0.ResetGame(var_42_1)

		local var_42_2 = arg_35_0.gameController
		local var_42_3 = var_0.ReadyGame
		local var_42_4 = {
			index = arg_35_0.stageIndex
		}

		NenjuuGameConfig = var_4

		local var_42_5 = var_4.ParsingElements
		local var_42_6 = arg_35_0
		local var_42_7 = var_6.GetMGData(var_42_6)
		local var_42_8

		if not var_6.GetRuntimeData(var_42_7, "elements") then
			var_42_8 = {}
		end

		var_42_4.FuShun = var_42_5(var_42_8)
		var_42_4.Nenjuu = arg_35_0.abilityCache[arg_35_0.stageIndex]
		var_42_4.rate = var_0_3(arg_35_0.abilityCache[arg_35_0.stageIndex], var_35_4.base_rate, var_35_4.ability_rate)

		var_42_3(var_42_2, var_42_4)

		local var_42_9 = arg_35_0

		var_0.openUI(var_42_9, "countdown")

		return
	end

	SFX_CONFIRM = var_35_25

	var_35_19(var_35_24, var_35_26, var_35_27, var_35_25)

	return
end

function var_0_1.openRatePage(arg_43_0)
	NenjuuGameConfig = var_1_10001

	local var_43_0 = var_1_10001.ParsingElements
	local var_43_1 = arg_43_0:GetMGData()
	local var_43_2

	if not var_3.GetRuntimeData(var_43_1, "elements") then
		var_43_2 = {}
	end

	local var_43_3 = var_43_0(var_43_2)

	NenjuuGameConfig = var_1_10002

	local var_43_4 = var_1_10002.GetStageConfig("Spring23Level_" .. arg_43_0.stageIndex)
	local var_43_5

	if not arg_43_0.abilityCache[arg_43_0.stageIndex] then
		var_43_5 = arg_43_0.abilityCache

		local var_43_6 = arg_43_0.stageIndex

		setmetatable = var_5
		var_43_5[var_43_6] = var_5({}, {
			__index = var_43_4.ability_config
		})
	end

	setActive = var_43_5

	local var_43_7 = arg_43_0.rtLevel

	var_43_5(var_5.Find(var_43_7, "Rate"), true)

	onButton = var_43_5

	local var_43_8 = arg_43_0
	local var_43_9 = arg_43_0.rtLevel
	local var_43_10 = var_6.Find(var_43_9, "Rate/bg")

	local function var_43_11()
		setActive = var_2_10000

		local var_44_0 = arg_43_0.rtLevel

		var_2_10000(var_2.Find(var_44_0, "Rate"), false)

		local var_44_1 = arg_43_0

		var_0.openReadyPage(var_44_1)

		return
	end

	SFX_CANCEL = var_43_9

	var_43_5(var_43_8, var_43_10, var_43_11, var_43_9)

	local var_43_12 = arg_43_0.rtLevel
	local var_43_13 = var_3.Find(var_43_12, "Rate/main/panel")
	local var_43_14 = var_0_3(arg_43_0.abilityCache[arg_43_0.stageIndex], var_43_4.base_rate, var_43_4.ability_rate)

	setText = var_43_12

	var_43_12(var_43_13:Find("info/rate/Text"), var_43_14)

	underscore = var_43_12

	local var_43_15 = var_43_12.filter

	NenjuuGameConfig = var_7

	local var_43_16 = var_43_15(var_7.ABILITY_LIST, function(arg_45_0)
		return arg_43_0.abilityCache[arg_43_0.stageIndex][arg_45_0] ~= nil
	end)
	local var_43_17 = var_43_13:Find("view/content")

	UIItemList = var_7

	local var_43_18 = var_7.New(var_43_17, var_43_17:Find("tpl"))

	var_7.make(var_43_18, function(arg_46_0, arg_46_1, arg_46_2)
		arg_46_1 = arg_46_1 + 1
		UIItemList = var_2_10003

		if arg_46_0 == var_2_10003.EventUpdate then
			local var_46_0 = var_43_16[arg_46_1]

			setActive = var_2_10004

			var_2_10004(arg_46_2:Find("empty"), not var_46_0)

			setActive = var_2_10004

			var_2_10004(arg_46_2:Find("enable"), var_46_0)

			if var_46_0 then
				local var_46_1 = arg_46_2
				local var_46_2 = arg_46_2.Find(var_46_1, "enable")

				eachChild = var_2_10005

				var_2_10005(var_46_2:Find("icon"), function(arg_47_0)
					setActive = var_3_10001

					var_3_10001(arg_47_0, arg_47_0.name == var_46_0)

					return
				end)

				string = var_2_10005

				local var_46_3 = var_2_10005.split

				i18n = var_7

				local var_46_4 = "2023spring_minigame_nenjuu_skill"

				table = var_10

				local var_46_5 = var_10.indexof

				NenjuuGameConfig = var_2_10012

				local var_46_6 = var_46_3(var_7(var_46_4 .. var_46_5(var_2_10012.ABILITY_LIST, var_46_0)), "|")

				setText = var_46_1

				var_46_1(var_46_2:Find("name/Text"), var_46_6[1])

				setText = var_46_1

				var_46_1(var_46_2:Find("desc"), var_46_6[2])

				onToggle = var_46_1

				var_46_1(arg_43_0, var_46_2:Find("toggle"), function(arg_48_0)
					arg_43_0.abilityCache[arg_43_0.stageIndex][var_46_0] = arg_48_0

					local var_48_0 = var_0_3(arg_43_0.abilityCache[arg_43_0.stageIndex], var_43_4.base_rate, var_43_4.ability_rate) - var_43_14

					setText = var_2

					local var_48_1 = var_43_13

					var_2(var_4.Find(var_48_1, "info/delta"), (var_48_0 < 0 and "" or "+") .. var_48_0)

					return
				end)

				triggerToggle = var_46_1

				var_46_1(var_46_2:Find("toggle"), arg_43_0.abilityCache[arg_43_0.stageIndex][var_46_0])
			end
		end

		return
	end)

	local var_43_19 = var_7
	local var_43_20 = var_7.align

	math = var_11

	local var_43_21 = var_11.min
	local var_43_22 = #var_43_16 + 1

	NenjuuGameConfig = var_1_10014

	var_43_20(var_43_19, var_43_21(var_43_22, #var_1_10014.ABILITY_LIST))

	return
end

function var_0_1.initControllerUI(arg_49_0)
	local var_49_0 = arg_49_0._tf
	local var_49_1 = var_1.Find(var_49_0, "Controller/top")

	onButton = var_1_10002

	local var_49_2 = arg_49_0
	local var_49_3 = var_49_1
	local var_49_4 = var_49_1.Find(var_49_3, "btn_back")

	local function var_49_5()
		local var_50_0 = arg_49_0

		var_0.openUI(var_50_0, "exit")

		return
	end

	SFX_PANEL = var_49_3

	var_1_10002(var_49_2, var_49_4, var_49_5, var_49_3)

	onButton = var_1_10002

	var_1_10002(arg_49_0, var_49_1:Find("btn_pause"), function()
		local var_51_0 = arg_49_0

		var_0.openUI(var_51_0, "pause")

		return
	end)

	return
end

function var_0_1.SaveDataChange(arg_52_0, arg_52_1)
	local var_52_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_52_0, arg_52_1.high)

	table = var_3

	var_3.insert(var_52_0, arg_52_1.count)

	table = var_3

	local var_52_1 = var_3.insert
	local var_52_2 = var_52_0

	if arg_52_1.item then
		table = var_6

		local var_52_3 = var_6.indexof

		NenjuuGameConfig = var_1_10008

		local var_52_4

		if not var_52_3(var_1_10008.ITEM_LIST, arg_52_1.item) then
			var_52_4 = 0
		end

		var_52_1(var_52_2, var_52_4)

		for iter_52_0 = 1, 7 do
			table = var_1_10007

			var_1_10007.insert(var_52_0, arg_52_1["stage_" .. iter_52_0])
		end

		ipairs = var_3

		for iter_52_1, iter_52_2 in var_3({
			"bomb",
			"lantern",
			"ice",
			"flash",
			"rush",
			"blessing",
			"decoy"
		}) do
			table = var_1_10008

			var_1_10008.insert(var_52_0, arg_52_1.level[iter_52_2])
		end

		arg_52_0:StoreDataToServer(var_52_0)

		return
	end
end

function var_0_1.didEnter(arg_53_0)
	arg_53_0:initPageUI()
	arg_53_0:initLeveUI()
	arg_53_0:initControllerUI()

	arg_53_0.abilityCache = {}
	NenjuuGameController = var_1
	arg_53_0.gameController = var_1.New(arg_53_0, arg_53_0._tf)

	arg_53_0:openUI("main")

	return
end

function var_0_1.onBackPressed(arg_54_0)
	switch = var_1_10001

	var_1_10001(arg_54_0.status, {
		main = function()
			isActive = var_2_10000

			local var_55_0 = arg_54_0.rtLevel

			if var_2_10000(var_2.Find(var_55_0, "Opreation")) then
				triggerButton = var_0

				local var_55_1 = arg_54_0.rtLevel

				var_0(var_2.Find(var_55_1, "Opreation/btn_back"))

				return
			end

			isActive = var_0

			local var_55_2 = arg_54_0.rtLevel

			if var_0(var_2.Find(var_55_2, "Ready")) then
				triggerButton = var_0

				local var_55_3 = arg_54_0.rtLevel

				var_0(var_2.Find(var_55_3, "Ready/bg"))

				return
			end

			isActive = var_0

			local var_55_4 = arg_54_0.rtLevel

			if var_0(var_2.Find(var_55_4, "Rate")) then
				triggerButton = var_0

				local var_55_5 = arg_54_0.rtLevel

				var_0(var_2.Find(var_55_5, "Rate/bg"))

				return
			end

			var_0_1.super.onBackPressed(arg_54_0)

			return
		end,
		countdown = function()
			return
		end,
		pause = function()
			local var_57_0 = arg_54_0

			var_0.openUI(var_57_0)

			local var_57_1 = arg_54_0.gameController

			var_0.ResumeGame(var_57_1)

			return
		end,
		exit = function()
			local var_58_0 = arg_54_0

			var_0.openUI(var_58_0)

			local var_58_1 = arg_54_0.gameController

			var_0.ResumeGame(var_58_1)

			return
		end,
		result = function()
			return
		end
	}, function()
		assert = var_2_10000

		var_2_10000(arg_54_0.gameController.isStart)

		local var_60_0 = arg_54_0

		var_0.openUI(var_60_0, "pause")

		return
	end)

	return
end

function var_0_1.willExit(arg_61_0)
	return
end

return var_0_1
