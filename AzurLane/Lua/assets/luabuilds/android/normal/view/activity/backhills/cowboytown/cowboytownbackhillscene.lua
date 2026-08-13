class = var_0_10000

local var_0_0 = "CowboyTownBackHillScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "CowboyTownBackHillUI"
end

function var_0_1.didEnter(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	var_1_10001(var_2_0, var_3.Find(var_2_1, "top/btn_back"), function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0._tf

	var_1_10001(var_2_2, var_3.Find(var_2_3, "top/btn_home"), function()
		local var_4_0 = arg_2_0

		var_0.emit(var_4_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "top/info/btn_help")

	local function var_2_7()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip["0815_main_help"].tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_4, var_2_6, var_2_7, var_5)

	onButton = var_1_10001

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._tf

	var_1_10001(var_2_8, var_3.Find(var_2_9, "btn/btn_game"), function()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		CowboyTownMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.MINI_GAME)

		return
	end)

	onButton = var_1_10001

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0._tf

	var_1_10001(var_2_10, var_3.Find(var_2_11, "btn/btn_skin"), function()
		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		CowboyTownMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.SKIN)

		return
	end)

	onButton = var_1_10001

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0._tf

	var_1_10001(var_2_12, var_3.Find(var_2_13, "btn/btn_expansion"), function()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		CowboyTownMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.EXPANSION)

		return
	end)

	onButton = var_1_10001

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0._tf

	var_1_10001(var_2_14, var_3.Find(var_2_15, "btn/btn_task"), function()
		local var_9_0 = arg_2_0
		local var_9_1 = var_0.emit

		CowboyTownMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.TASK)

		return
	end)

	onButton = var_1_10001

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0._tf

	var_1_10001(var_2_16, var_3.Find(var_2_17, "btn/btn_story"), function()
		local var_10_0 = arg_2_0
		local var_10_1 = var_0.emit

		CowboyTownMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.STORY)

		return
	end)
	arg_2_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_11_0)
	setActive = var_1_10001

	local var_11_0 = arg_11_0._tf

	var_1_10001(var_2.Find(var_11_0, "btn/btn_game/tip"), var_0_1.MiniGameTip())

	setActive = var_1_10001

	local var_11_1 = arg_11_0._tf

	var_1_10001(var_2.Find(var_11_1, "btn/btn_expansion/tip"), var_0_1.ExpansionTips())
	arg_11_0:UpdateTaskTips()
	arg_11_0:UpdateStoryView()

	return
end

function var_0_1.IsShowMainTip(arg_12_0)
	local var_12_0

	if not var_0_1.MiniGameTip() and not var_0_1.ExpansionTips() then
		SixYearUsTaskMediator = var_12_0

		if not var_12_0.GetTaskRedTip() then
			var_12_0 = var_0_1.StoryTips()
		end
	end

	return var_12_0
end

function var_0_1.UpdateStoryView(arg_13_0)
	setActive = var_1_10001

	local var_13_0 = arg_13_0._tf

	var_1_10001(var_2.Find(var_13_0, "btn/btn_story/tip"), var_0_1.StoryTips())

	return
end

function var_0_1.UpdateActivity(arg_14_0, arg_14_1)
	return
end

function var_0_1.MiniGameTip()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10001

	local var_15_0 = var_1_10000(var_1_10001)
	local var_15_1 = var_0.GetHubByGameId

	CowboyTownMediator = var_1_10002

	return var_15_1(var_15_0, var_1_10002.MINI_GAME_ID).count > 0
end

function var_0_1.ExpansionTips()
	TownScene = var_1_10000

	return var_1_10000.ShowEntranceTip()
end

function var_0_1.UpdateTaskTips(arg_17_0)
	setActive = var_1_10001

	local var_17_0 = arg_17_0._tf
	local var_17_1 = var_2.Find(var_17_0, "btn/btn_task/tip")

	SixYearUsTaskMediator = var_17_0

	var_1_10001(var_17_1, var_17_0.GetTaskRedTip())

	return
end

function var_0_1.StoryTips()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_18_0 = var_1_10000(var_1_10001)

	if var_0.getActivityById(var_18_0, 5535).data1 > 0 then
		return true
	end

	return false
end

return var_0_1
