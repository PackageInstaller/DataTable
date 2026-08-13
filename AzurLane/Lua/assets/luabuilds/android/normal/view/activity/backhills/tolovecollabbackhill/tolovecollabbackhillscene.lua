class = var_0_10000

local var_0_0 = "ToLoveCollabBackHillScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "ToLoveCollabBackHillUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_1, "map")

	local var_2_2 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_2, "upper")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "upper/task")

	local function var_3_3()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ToLoveCollabBackHillMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.TASK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "upper/jinianzhang")

	local function var_3_7()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ToLoveCollabBackHillMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.TROPHY)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_3.Find(var_3_9, "upper/help")

	local function var_3_11()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ToLoveCollabBackHillMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.PUZZLE)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_3.Find(var_3_13, "top/return_btn")

	local function var_3_15()
		local var_7_0 = arg_3_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_12, var_3_14, var_3_15, var_5)

	onButton = var_1_10001

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_3.Find(var_3_17, "top/return_main_btn")

	local function var_3_19()
		local var_8_0 = arg_3_0

		var_0.emit(var_8_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_16, var_3_18, var_3_19, var_5)

	onButton = var_1_10001

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0._tf
	local var_3_22 = var_3.Find(var_3_21, "top/help_btn")

	local function var_3_23()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.tolove_main_help.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_20, var_3_22, var_3_23, var_5)

	onButton = var_1_10001

	local var_3_24 = arg_3_0
	local var_3_25 = arg_3_0._tf
	local var_3_26 = var_3.Find(var_3_25, "upper/xiaoyouxi")

	local function var_3_27()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		ToLoveCollabBackHillMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.MINI_GAME)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_24, var_3_26, var_3_27, var_5)

	onButton = var_1_10001

	local var_3_28 = arg_3_0
	local var_3_29 = arg_3_0._tf
	local var_3_30 = var_3.Find(var_3_29, "upper/tebiezuozhan")

	local function var_3_31()
		getProxy = var_2_10000
		ChapterProxy = var_2_10001

		local var_11_0 = var_2_10000(var_2_10001)
		local var_11_1, var_11_2 = var_0.getLastMapForActivity(var_11_0)

		if var_11_1 then
			local var_11_3 = var_0:getMapById(var_11_1)

			if not var_2_10003.isUnlock(var_11_3) then
				pg = var_2_10003

				local var_11_4 = var_2_10003.TipsMgr.GetInstance()
				local var_11_5 = var_3.ShowTips

				i18n = var_2_10005

				var_11_5(var_11_4, var_2_10005("common_activity_end"))
			else
				local var_11_6 = arg_3_0
				local var_11_7 = var_3.emit

				BackHillMediatorTemplate = var_2_10005

				local var_11_8 = var_2_10005.GO_SCENE

				SCENE = var_2_10006

				var_11_7(var_11_6, var_11_8, var_2_10006.LEVEL, {
					chapterId = var_11_2,
					mapIdx = var_11_1
				})
			end

			return
		end
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_28, var_3_30, var_3_31, var_5)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_12_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)

	setActive = var_1_10002

	local var_12_1 = arg_12_0._tf
	local var_12_2 = var_3.Find(var_12_1, "upper/task/tips")

	ToLoveCollabTaskMediator = var_12_1

	var_1_10002(var_12_2, var_12_1.GetTaskRedTip())

	getProxy = var_1_10002
	ActivityProxy = var_12_2

	local var_12_3 = var_1_10002(var_12_2)
	local var_12_4 = var_2.getActivityByType

	ActivityConst = var_4

	local var_12_5 = var_12_4(var_12_3, var_4.ACTIVITY_TYPE_PUZZLA)
	local var_12_6 = false

	ipairs = var_4

	for iter_12_0, iter_12_1 in var_4(var_12_5.data1_list) do
		table = var_1_10009

		if not var_1_10009.contains(var_12_5.data2_list, iter_12_1) then
			var_12_6 = true

			break
		end
	end

	if #var_12_5:GetPicturePuzzleIds() == #var_12_5.data2_list and var_12_5.data1 ~= 1 then
		var_12_6 = true
	end

	setActive = var_4

	local var_12_7 = arg_12_0._tf

	var_4(var_5.Find(var_12_7, "upper/jinianzhang/tips"), var_12_6)

	setActive = var_4

	local var_12_8 = arg_12_0._tf
	local var_12_9 = var_5.Find(var_12_8, "upper/help/tips")

	PuzzleConnectMediator = var_12_8

	var_4(var_12_9, var_12_8.GetRedTip())

	setActive = var_4

	local var_12_10 = arg_12_0._tf
	local var_12_11 = var_5.Find(var_12_10, "upper/xiaoyouxi/tips")

	ToLoveGameVo = var_12_10

	var_4(var_12_11, var_12_10.ShouldShowTip())

	return
end

function var_0_1.willExit(arg_13_0)
	return
end

function var_0_1.IsShowMainTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_14_0 = var_1_10000(var_1_10001)

	local function var_14_1()
		ToLoveCollabTaskMediator = var_2_10000

		return var_2_10000.GetTaskRedTip()
	end

	local function var_14_2()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_16_0 = var_2_10000(var_2_10001)
		local var_16_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_16_2 = var_16_1(var_16_0, var_2_10002.ACTIVITY_TYPE_PUZZLA)
		local var_16_3 = false

		ipairs = var_2

		for iter_16_0, iter_16_1 in var_2(var_16_2.data1_list) do
			table = var_2_10007

			if not var_2_10007.contains(var_16_2.data2_list, iter_16_1) then
				var_16_3 = true

				break
			end
		end

		if #var_16_2:GetPicturePuzzleIds() == #var_16_2.data2_list and var_16_2.data1 ~= 1 then
			var_16_3 = true
		end

		return var_16_3
	end

	local function var_14_3()
		PuzzleConnectMediator = var_2_10000

		return var_2_10000.GetRedTip()
	end

	local function var_14_4()
		ToLoveGameVo = var_2_10000

		return var_2_10000.ShouldShowTip()
	end

	local var_14_5

	if not var_14_1() and not var_14_2() and not var_14_3() then
		var_14_5 = var_14_4()
	end

	return var_14_5
end

return var_0_1
