class = var_0_10000

local var_0_0 = "OtherworldTerminalLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.PAGE_PERSONAL = 1
var_0_1.PAGE_ADVENTURE = 2
var_0_1.PAGE_GUARDIAN = 3

local var_0_2 = var_0_1.PAGE_PERSONAL

function var_0_1.getUIName(arg_1_0)
	return "OtherworldTerminalUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_0, "window")

	local var_4_1 = arg_4_0.windowTF

	arg_4_0.togglesTF = var_1.Find(var_4_1, "toggles")

	local var_4_2 = arg_4_0.togglesTF

	arg_4_0.adventureTipTF = var_1.Find(var_4_2, "2/tip")
	setText = var_1

	local var_4_3 = arg_4_0.togglesTF
	local var_4_4 = var_3.Find(var_4_3, var_0_1.PAGE_PERSONAL .. "/Text")

	i18n = var_4

	var_1(var_4_4, var_4("terminal_personal_title"))

	setText = var_1

	local var_4_5 = arg_4_0.togglesTF
	local var_4_6 = var_3.Find(var_4_5, var_0_1.PAGE_ADVENTURE .. "/Text")

	i18n = var_4

	var_1(var_4_6, var_4("terminal_adventure_title"))

	setText = var_1

	local var_4_7 = arg_4_0.togglesTF
	local var_4_8 = var_3.Find(var_4_7, var_0_1.PAGE_GUARDIAN .. "/Text")

	i18n = var_4

	var_1(var_4_8, var_4("terminal_guardian_title"))

	local var_4_9 = arg_4_0.windowTF
	local var_4_10 = var_1.Find(var_4_9, "pages")

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_4_11 = var_1_10002(var_4)
	local var_4_12 = var_2.getActivityById

	ActivityConst = var_4_7

	if var_4_12(var_4_11, var_4_7.OTHER_WORLD_TERMINAL_EVENT_ID) and not var_2:isEnd() then
		TerminalPersonalPage = var_4_9
		arg_4_0.personalPage = var_4_9.New(var_4_10, arg_4_0, {
			upgrade = arg_4_0.contextData.upgrade
		})
	else
		arg_4_0.personalPage = nil
	end

	TerminalAdventurePage = var_4_9
	arg_4_0.adventurePage = var_4_9.New(var_4_10, arg_4_0)
	TerminalGuardianPage = var_3
	arg_4_0.guardianPage = var_3.New(var_4_10, arg_4_0)
	arg_4_0.pages = {
		[var_0_1.PAGE_PERSONAL] = arg_4_0.personalPage,
		[var_0_1.PAGE_ADVENTURE] = arg_4_0.adventurePage,
		[var_0_1.PAGE_GUARDIAN] = arg_4_0.guardianPage
	}

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.windowTF
	local var_5_2 = var_4.Find(var_5_1, "close_btn")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "mask")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.onBackPressed(var_7_0)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.windowTF
	local var_5_10 = var_4.Find(var_5_9, "help_btn")

	local function var_5_11()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip.otherworld_terminal_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_CANCEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	eachChild = var_1_10001

	var_1_10001(arg_5_0.togglesTF, function(arg_9_0)
		onToggle = var_2_10001

		var_2_10001(arg_5_0, arg_9_0, function(arg_10_0)
			if arg_10_0 then
				tonumber = var_3_10001

				local var_10_0 = var_3_10001(arg_9_0.name)

				if arg_5_0.curPageIdx and arg_5_0.curPageIdx == var_10_0 then
					return
				end

				if var_10_0 == var_0_1.PAGE_PERSONAL and not arg_5_0.personalPage then
					pg = var_2

					local var_10_1 = var_2.TipsMgr.GetInstance()
					local var_10_2 = var_2.ShowTips

					i18n = var_3_10005

					var_10_2(var_10_1, var_3_10005("common_activity_end"))

					return
				end

				arg_5_0.curPageIdx = var_10_0

				local var_10_3 = arg_5_0

				var_2.SwitchPage(var_10_3)
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.didEnter(arg_11_0)
	local var_11_0

	if not arg_11_0.contextData.page then
		var_11_0 = var_0_2
	end

	if var_11_0 == var_0_1.PAGE_PERSONAL and not arg_11_0.personalPage then
		var_11_0 = var_0_1.PAGE_ADVENTURE
	end

	triggerToggle = var_2

	local var_11_1 = arg_11_0.togglesTF
	local var_11_2 = var_4.Find

	tostring = var_1_10007

	var_2(var_11_2(var_11_1, var_1_10007(var_11_0)), true)
	arg_11_0:UpdateAdventureTip()

	return
end

function var_0_1.SwitchPage(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.pages) do
		if iter_12_0 == arg_12_0.curPageIdx then
			iter_12_1:ExecuteAction("Show")

			arg_12_0.curPage = iter_12_1
		else
			iter_12_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_1.UpdateAdventurePtAct(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.pages[var_0_1.PAGE_ADVENTURE]

	var_2.ExecuteAction(var_13_0, "UpdatePt", arg_13_1)

	return
end

function var_0_1.UpdateAdventureTip(arg_14_0)
	TerminalAdventurePage = var_1_10001

	local var_14_0 = var_1_10001.IsTip()

	setActive = var_1_10002

	var_1_10002(arg_14_0.adventureTipTF, var_14_0)

	return
end

function var_0_1.UpdateAdventureTaskAct(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.pages[var_0_1.PAGE_ADVENTURE]

	var_2.ExecuteAction(var_15_0, "UpdateTask", arg_15_1)

	return
end

function var_0_1.UpdateGuardianAct(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.pages[var_0_1.PAGE_GUARDIAN]

	var_2.ExecuteAction(var_16_0, "UpdateView", arg_16_1)

	return
end

function var_0_1.willExit(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.pages) do
		iter_17_1:Destroy()

		iter_17_1 = nil
	end

	if arg_17_0.contextData.onExit then
		arg_17_0.contextData.onExit()

		arg_17_0.contextData.onExit = nil
	end

	return
end

return var_0_1
