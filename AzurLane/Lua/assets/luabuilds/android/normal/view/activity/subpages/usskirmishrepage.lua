class = var_0_10000

local var_0_0 = "USSkirmishRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0:initUI()
	arg_1_0:initData()
	arg_1_0:addListener()

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.taskVOList) do
		local var_3_0 = iter_3_1.state
		local var_3_1 = arg_3_0.progress
		local var_3_2 = var_7.GetChild(var_3_1, iter_3_0 - 1)
		local var_3_3 = var_7.Find(var_3_2, "Empty")
		local var_3_4 = var_7
		local var_3_5 = var_7.Find(var_3_4, "Full")

		SkirmishVO = var_3_4

		if var_3_0 < var_3_4.StateClear then
			setActive = var_10

			var_10(var_3_3, true)

			setActive = var_10

			var_10(var_3_5, false)
		else
			setActive = var_10

			var_10(var_3_3, false)

			setActive = var_10

			var_10(var_3_5, true)
		end
	end

	return
end

function var_0_1.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bg = var_1.Find(var_4_0, "AD")

	local var_4_1 = arg_4_0._tf

	arg_4_0.progress = var_1.Find(var_4_1, "Progress")

	local var_4_2 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_2, "HelpBtn")

	local var_4_3 = arg_4_0._tf

	arg_4_0.battleBtn = var_1.Find(var_4_3, "BattleBtn")

	return
end

function var_0_1.initData(arg_5_0)
	Clone = var_1_10001
	pg = var_1_10002

	local var_5_0 = var_1_10002.activity_template

	ActivityConst = var_1_10003
	arg_5_0.taskGroup = var_1_10001(var_5_0[var_1_10003.ACTIVITY_ID_US_SKIRMISH_RE].config_data)
	arg_5_0.taskCount = #arg_5_0.taskGroup
	getProxy = var_1
	SkirmishProxy = var_2
	arg_5_0.skirmishProxy = var_1(var_2)

	local var_5_1 = arg_5_0.skirmishProxy

	var_1.UpdateSkirmishProgress(var_5_1)

	Clone = var_1
	arg_5_0.taskVOList = var_1(arg_5_0.skirmishProxy.data)

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.helpBtn

	local function var_6_2()
		pg = var_2_10000

		if var_2_10000.gametip.help_tempesteve then
			pg = var_0

			local var_7_0 = var_0.MsgboxMgr.GetInstance()
			local var_7_1 = var_0.ShowMsgBox
			local var_7_2 = {}

			MSGBOX_TYPE_HELP = var_2_10003
			var_7_2.type = var_2_10003
			pg = var_2_10003
			var_7_2.helps = var_2_10003.gametip.help_tempesteve.tip

			var_7_1(var_7_0, var_7_2)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.battleBtn

	local function var_6_5()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_8_3 = var_2_10003.LEVEL
		local var_8_4 = {}

		SkirmishProxy = var_2_10005
		var_8_4.mapIdx = var_2_10005.SkirmishMap

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	return
end

return var_0_1
