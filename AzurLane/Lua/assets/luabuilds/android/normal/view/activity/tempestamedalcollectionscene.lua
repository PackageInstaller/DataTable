class = var_0_10000

local var_0_0 = "TempestaMedalCollectionScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TempestaMedalCollectionUI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_1.onBackPressed(arg_3_0)
	isActive = var_1_10001

	if var_1_10001(arg_3_0.rtHelpPanel) then
		setActive = var_1

		var_1(arg_3_0.rtHelpPanel)

		pg = var_1

		local var_3_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_3_0, arg_3_0.rtHelpPanel, arg_3_0._tf)

		return
	end

	arg_3_0:closeView()

	return
end

function var_0_1.init(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "top/btn_back")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	local var_4_4 = arg_4_0._tf

	arg_4_0.rtMainPanel = var_1.Find(var_4_4, "main")
	onButton = var_1

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.rtMainPanel
	local var_4_7 = var_3.Find(var_4_6, "btn_help")

	local function var_4_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_6_0, arg_4_0.rtHelpPanel)

		setActive = var_0

		var_0(arg_4_0.rtHelpPanel, true)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_5, var_4_7, var_4_8, var_5)

	local var_4_9 = arg_4_0._tf

	arg_4_0.rtHelpPanel = var_1.Find(var_4_9, "help_panel")
	setText = var_1

	local var_4_10 = arg_4_0.rtHelpPanel
	local var_4_11 = var_2.Find(var_4_10, "window/Text")

	i18n = var_4_10

	var_1(var_4_11, var_4_10("pirate_wanted_help"))

	onButton = var_1

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.rtHelpPanel
	local var_4_14 = var_3.Find(var_4_13, "bg")

	local function var_4_15()
		local var_7_0 = arg_4_0

		var_0.onBackPressed(var_7_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_4_12, var_4_14, var_4_15, var_5)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:updateTaskLayers()

	return
end

function var_0_1.updateTaskLayers(arg_9_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)

	underscore = var_1_10002

	local var_9_1 = var_1_10002.map
	local var_9_2 = arg_9_0.activity
	local var_9_3 = var_9_1(var_3.getConfig(var_9_2, "config_data"), function(arg_10_0)
		local var_10_0 = var_9_0

		if not var_1.getTaskVO(var_10_0, arg_10_0) then
			Task = var_10_0

			local var_10_1 = var_10_0.New({
				submit_time = 1,
				id = arg_10_0
			})

			var_1.updateProgress(var_10_1, var_1:getConfig("target_num"))
		end

		return var_1
	end)

	ipairs = var_3

	for iter_9_0, iter_9_1 in var_3(var_9_3) do
		local var_9_4 = arg_9_0.rtMainPanel
		local var_9_5 = var_8.Find(var_9_4, "tasks")
		local var_9_6 = var_8.GetChild(var_9_5, iter_9_0 - 1)

		if iter_9_0 == #var_9_3 then
			setActive = var_9

			var_9(var_9_6:Find("got"), iter_9_1:isReceive())

			Drop = var_9

			local var_9_7 = var_9.Create(iter_9_1:getConfig("award_display")[1])

			onButton = var_10

			local var_9_8 = arg_9_0
			local var_9_9 = var_9_6

			local function var_9_10()
				local var_11_0 = arg_9_0
				local var_11_1 = var_0.emit

				BaseUI = var_2_10002

				var_11_1(var_11_0, var_2_10002.ON_DROP, var_9_7)

				return
			end

			SFX_PANEL = var_1_10014

			var_10(var_9_8, var_9_9, var_9_10, var_1_10014)
		else
			local var_9_11 = {}

			unpack = var_10

			local var_9_12, var_9_13, var_9_14 = var_10(iter_9_1:getConfig("award_display")[1])

			var_9_11.count = var_9_14
			var_9_11.id = var_9_13
			var_9_11.type = var_9_12
			updateDrop = var_9_12

			var_9_12(var_9_6:Find("IconTpl"), var_9_11)

			onButton = var_9_12

			local var_9_15 = arg_9_0
			local var_9_16 = var_9_6:Find("IconTpl")

			local function var_9_17()
				local var_12_0 = arg_9_0
				local var_12_1 = var_0.emit

				BaseUI = var_2_10002

				var_12_1(var_12_0, var_2_10002.ON_DROP, var_9_11)

				return
			end

			SFX_PANEL = var_1_10014

			var_9_12(var_9_15, var_9_16, var_9_17, var_1_10014)

			setText = var_9_12

			var_9_12(var_9_6:Find("Text"), iter_9_1:getConfig("desc"))

			local var_9_18 = iter_9_1
			local var_9_19 = iter_9_1.getTaskStatus(var_9_18)

			setActive = var_9_18

			var_9_18(var_9_6:Find("btn_go"), var_9_19 == 0)

			setActive = var_9_18

			var_9_18(var_9_6:Find("btn_get"), var_9_19 == 1)

			setActive = var_9_18

			var_9_18(var_9_6:Find("btn_got"), var_9_19 == 2)

			onButton = var_9_18

			local var_9_20 = arg_9_0

			var_1_10014 = var_9_6

			local var_9_21 = var_9_6.Find(var_1_10014, "btn_go")

			function var_1_10014()
				local var_13_0 = arg_9_0
				local var_13_1 = var_0.emit

				TempestaMedalCollectionMediator = var_2_10002

				var_13_1(var_13_0, var_2_10002.ON_TASK_GO, iter_9_1)

				return
			end

			SFX_PANEL = var_15

			var_9_18(var_9_20, var_9_21, var_1_10014, var_15)

			onButton = var_9_18

			local var_9_22 = arg_9_0

			var_1_10014 = var_9_6

			local var_9_23 = var_9_6.Find(var_1_10014, "btn_get")

			function var_1_10014()
				local var_14_0 = arg_9_0
				local var_14_1 = var_0.emit

				TempestaMedalCollectionMediator = var_2_10002

				var_14_1(var_14_0, var_2_10002.ON_TASK_SUBMIT, iter_9_1)

				return
			end

			SFX_PANEL = var_15

			var_9_18(var_9_22, var_9_23, var_1_10014, var_15)
		end
	end

	local var_9_24 = #var_9_3 - 1

	underscore = var_4

	local var_9_25 = var_4.reduce(var_9_3, 0, function(arg_15_0, arg_15_1)
		return arg_15_0 + (arg_15_1:isReceive() and 1 or 0)
	end)

	setText = var_5

	local var_9_26 = arg_9_0.rtMainPanel
	local var_9_27 = var_6.Find(var_9_26, "progress/Text")

	math = var_9_26

	var_5(var_9_27, var_9_26.min(var_9_25, var_9_24) .. "/" .. var_9_24)

	if var_9_24 <= var_9_25 then
		local var_9_28 = var_9_3[#var_9_3]

		if not var_5.isReceive(var_9_28) then
			local var_9_29 = arg_9_0
			local var_9_30 = arg_9_0.emit

			TempestaMedalCollectionMediator = var_7

			var_9_30(var_9_29, var_7.ON_TASK_SUBMIT, var_9_3[#var_9_3])
		end
	end

	return
end

function var_0_1.willExit(arg_16_0)
	isActive = var_1_10001

	if var_1_10001(arg_16_0.rtHelpPanel) then
		arg_16_0:onBackPressed()
	end

	return
end

return var_0_1
