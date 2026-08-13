class = var_0_10000

local var_0_0 = "TrainingCampScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TrainingCampUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()

	local var_2_0 = arg_2_0

	arg_2_0.addListener(var_2_0)

	TechnologyConst = var_1

	if var_1.isNormalActOn() then
		arg_2_0:initNormalPanel()
	end

	TechnologyConst = var_2_0

	if var_2_0.isTecActOn() then
		arg_2_0:initTecPanel()
	end

	arg_2_0:closeMsgBox()

	return
end

function var_0_1.findUI(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.adaptPanel = var_1.Find(var_3_0, "blur_panel/adapt")

	local var_3_1 = arg_3_0._tf

	arg_3_0.panelContainer = var_1.Find(var_3_1, "PanelContainer")

	local var_3_2 = arg_3_0.panelContainer

	arg_3_0.normalPanel = var_1.Find(var_3_2, "NormalPanel")

	local var_3_3 = arg_3_0.panelContainer

	arg_3_0.tecPanel = var_1.Find(var_3_3, "TecPanel")

	local var_3_4 = arg_3_0._tf

	arg_3_0.switchToNormalBtn = var_1.Find(var_3_4, "SwitchToNormal")

	local var_3_5 = arg_3_0._tf

	arg_3_0.switchToTecBtn = var_1.Find(var_3_5, "SwitchToTec")
	GetOrAddComponent = var_1

	local var_3_6 = arg_3_0.switchToNormalBtn

	arg_3_0.switchToNormalLight = var_1(var_2.Find(var_3_6, "Light"), "Animator")
	GetOrAddComponent = var_1

	local var_3_7 = arg_3_0.switchToTecBtn

	arg_3_0.switchToTecLight = var_1(var_2.Find(var_3_7, "Light"), "Animator")

	local var_3_8 = arg_3_0._tf

	arg_3_0.awardMsg = var_1.Find(var_3_8, "ChooseAwardPanel")

	local var_3_9 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_9, "HelpBtn")

	local var_3_10 = arg_3_0._tf

	arg_3_0.titleTf = var_1.Find(var_3_10, "blur_panel/adapt/top/title")
	GetComponent = var_1
	findTF = var_3_10

	local var_3_11 = var_3_10(arg_3_0.titleTf, "img")

	typeof = var_3
	Image = var_4

	local var_3_12 = var_1(var_3_11, var_3(var_4))

	var_1.SetNativeSize(var_3_12)

	return
end

function var_0_1.initData(arg_4_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_4_0.taskProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	ActivityProxy = var_1_10002
	arg_4_0.activityProxy = var_1(var_1_10002)

	local var_4_0 = arg_4_0.activityProxy
	local var_4_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_4_0.normalTaskactivity = var_4_1(var_4_0, var_1_10003.ACTIVITY_TYPE_GUIDE_TASKS)

	local var_4_2 = arg_4_0.activityProxy
	local var_4_3 = var_1.getActivityByType

	ActivityConst = var_3
	arg_4_0.tecTaskActivity = var_4_3(var_4_2, var_3.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)
	arg_4_0.phaseId = nil
	arg_4_0.cachePageID = nil
	arg_4_0.activity = nil

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.adaptPanel
	local var_5_2 = var_3.Find(var_5_1, "top/back_button")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.switchToNormalBtn

	local function var_5_6()
		if not arg_5_0.isOnSwitchAni then
			TechnologyConst = var_0

			if var_0.isNormalActOn() then
				local var_7_0 = arg_5_0

				var_1.switchPanel(var_7_0, arg_5_0.normalTaskactivity, true)

				setActive = var_1

				var_1(arg_5_0.switchToNormalBtn, false)

				setActive = var_1

				var_1(arg_5_0.switchToTecBtn, true)

				local var_7_1 = arg_5_0

				var_1.resetSwitchBtnsLight(var_7_1)
			end
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_4, var_5_5, var_5_6, var_5)

	onButton = var_1_10001

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.switchToTecBtn

	local function var_5_9()
		if not arg_5_0.isOnSwitchAni then
			TechnologyConst = var_0

			if var_0.isTecActOn() then
				local var_8_0 = arg_5_0

				var_1.switchPanel(var_8_0, arg_5_0.tecTaskActivity, true)

				setActive = var_1

				var_1(arg_5_0.switchToNormalBtn, true)

				setActive = var_1

				var_1(arg_5_0.switchToTecBtn, false)

				local var_8_1 = arg_5_0

				var_1.resetSwitchBtnsLight(var_8_1)
			end
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_7, var_5_8, var_5_9, var_5)

	onButton = var_1_10001

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.helpBtn

	local function var_5_12()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		i18n = var_2_10003
		var_9_2.helps = var_2_10003("newplayer_help_tip")

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_10, var_5_11, var_5_12, var_5)

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:updateSwitchBtns()
	arg_10_0:updateSwitchBtnsTag()
	arg_10_0:autoSelectPanel()

	return
end

function var_0_1.willExit(arg_11_0)
	LeanTween = var_1_10001

	local var_11_0 = var_1_10001.cancel

	go = var_1_10002

	var_11_0(var_1_10002(arg_11_0.normalPanel))

	LeanTween = var_11_0

	local var_11_1 = var_11_0.cancel

	go = var_2

	var_11_1(var_2(arg_11_0.tecPanel))

	return
end

function var_0_1.updateSwitchBtns(arg_12_0)
	TechnologyConst = var_1_10001

	local var_12_0, var_12_1 = var_1_10001.isNormalActOn()

	TechnologyConst = var_1_10003

	local var_12_2, var_12_3 = var_1_10003.isTecActOn()

	if not var_12_0 or not var_12_2 then
		setActive = var_1_10005

		var_1_10005(arg_12_0.switchToNormalBtn, false)

		setActive = var_1_10005

		var_1_10005(arg_12_0.switchToTecBtn, false)
	elseif var_12_0 and var_12_2 then
		setActive = var_1_10005

		var_1_10005(arg_12_0.switchToNormalBtn, true)

		setActive = var_1_10005

		var_1_10005(arg_12_0.switchToTecBtn, true)
	end

	local var_12_4 = arg_12_0.switchToNormalBtn
	local var_12_5 = var_5.Find(var_12_4, "Tag")
	local var_12_6 = arg_12_0.switchToTecBtn
	local var_12_7 = var_6.Find(var_12_6, "Tag")

	setActive = var_12_6

	var_12_6(var_12_5, var_12_1)

	setActive = var_12_6

	var_12_6(var_12_7, var_12_3)

	return
end

function var_0_1.updateSwitchBtnsTag(arg_13_0)
	TechnologyConst = var_1_10001

	local var_13_0, var_13_1 = var_1_10001.isNormalActOn()

	TechnologyConst = var_1_10003

	local var_13_2, var_13_3 = var_1_10003.isTecActOn()
	local var_13_4 = arg_13_0.switchToNormalBtn
	local var_13_5 = var_5.Find(var_13_4, "Tag")
	local var_13_6 = arg_13_0.switchToTecBtn
	local var_13_7 = var_6.Find(var_13_6, "Tag")

	setActive = var_13_6

	var_13_6(var_13_5, var_13_1)

	setActive = var_13_6

	var_13_6(var_13_7, var_13_3)

	PlayerPrefs = var_13_6

	local var_13_8 = var_13_6.GetInt("TrainCamp_Tec_Catchup_First_Tag", 0)

	arg_13_0.switchToNormalLight.enabled = var_13_8 == 0

	local var_13_9 = arg_13_0.switchToTecLight

	var_13_9.enabled = var_13_8 == 0

	if var_13_8 == 0 then
		PlayerPrefs = var_13_9

		var_13_9.SetInt("TrainCamp_Tec_Catchup_First_Tag", 1)
	end

	return
end

function var_0_1.resetSwitchBtnsLight(arg_14_0)
	arg_14_0.switchToNormalLight.enabled = false
	arg_14_0.switchToTecLight.enabled = false

	return
end

function var_0_1.autoSelectPanel(arg_15_0)
	TechnologyConst = var_1_10001

	local var_15_0, var_15_1 = var_1_10001.isNormalActOn()

	TechnologyConst = var_1_10003

	local var_15_2, var_15_3 = var_1_10003.isTecActOn()

	if var_15_0 and var_15_2 then
		arg_15_0:switchPanel(arg_15_0.normalTaskactivity)

		setActive = var_5

		var_5(arg_15_0.switchToNormalBtn, false)

		setActive = var_5

		var_5(arg_15_0.switchToTecBtn, true)
	elseif var_15_0 then
		arg_15_0:switchPanel(arg_15_0.normalTaskactivity)
	elseif var_15_2 then
		arg_15_0:switchPanel(arg_15_0.tecTaskActivity)
	end

	return
end

function var_0_1.initNormalPanel(arg_16_0)
	local var_16_0 = arg_16_0.normalPanel
	local var_16_1 = var_1.Find(var_16_0, "ToggleList")

	arg_16_0.normalToggles = {
		var_16_1:Find("Phase1"),
		var_16_1:Find("Phase2"),
		var_16_1:Find("Phase3")
	}
	UIItemList = var_2

	local var_16_2 = var_2.New
	local var_16_3 = arg_16_0.normalPanel
	local var_16_4 = var_3.Find(var_16_3, "ScrollRect/Content")
	local var_16_5 = arg_16_0.normalPanel

	arg_16_0.normalTaskUIItemList = var_16_2(var_16_4, var_4.Find(var_16_5, "ScrollRect/TaskTpl"))

	local var_16_6 = arg_16_0.normalPanel

	arg_16_0.normalProgressPanel = var_2.Find(var_16_6, "ProgressPanel")
	pairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_0.normalToggles) do
		onToggle = var_1_10007

		local var_16_7 = arg_16_0
		local var_16_8 = iter_16_1

		local function var_16_9(arg_17_0)
			if arg_17_0 then
				if arg_16_0.phaseId < iter_16_0 then
					pg = var_1

					local var_17_0 = var_1.TipsMgr.GetInstance()
					local var_17_1 = var_1.ShowTips

					i18n = var_2_10003

					var_17_1(var_17_0, var_2_10003("newplayer_notice_7"))

					triggerToggle = var_17_1

					var_17_1(arg_16_0.normalToggles[arg_16_0.cachePageID], true)
				else
					local var_17_2 = arg_16_0

					var_1.updateNormalPanel(var_17_2, iter_16_0)
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10007(var_16_7, var_16_8, var_16_9, var_1_10011)
	end

	return
end

function var_0_1.updateNormalPanel(arg_18_0, arg_18_1)
	arg_18_0.cachePageID = arg_18_1

	local var_18_0 = arg_18_0.normalTaskactivity
	local var_18_1 = var_2.getConfig(var_18_0, "config_data")[3][arg_18_1][1]
	local var_18_2 = var_3[arg_18_1][2]

	arg_18_0:sortTaskIDList(var_18_1)
	arg_18_0:updateTaskUIItemList(arg_18_0.normalTaskUIItemList, var_18_1)
	arg_18_0:updateNormalProgressPanel(arg_18_1, var_18_2, var_18_1)

	return
end

function var_0_1.updateNormalProgressPanel(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:getTask(arg_19_2)

	if arg_19_1 == arg_19_0.phaseId and arg_19_0:isMissTask(arg_19_3) then
		local var_19_1 = arg_19_0
		local var_19_2 = arg_19_0.emit

		TrainingCampMediator = var_1_10007

		var_19_2(var_19_1, var_1_10007.ON_TRIGGER, {
			cmd = 1,
			activity_id = arg_19_0.activity.id
		})
	end

	if var_19_0 and var_19_0:isClientTrigger() and not var_19_0:isFinish() then
		local var_19_3 = arg_19_0
		local var_19_4 = arg_19_0.emit

		TrainingCampMediator = var_1_10007

		var_19_4(var_19_3, var_1_10007.ON_UPDATE, var_19_0)
	end

	local var_19_5 = arg_19_0.normalProgressPanel
	local var_19_6 = var_5.Find(var_19_5, "Get")
	local var_19_7 = arg_19_0.normalProgressPanel
	local var_19_8 = var_6.Find(var_19_7, "Lock")
	local var_19_9 = arg_19_0.normalProgressPanel
	local var_19_10 = var_7.Find(var_19_9, "Go")
	local var_19_11 = arg_19_0.normalProgressPanel
	local var_19_12 = var_8.Find(var_19_11, "Pass")

	setActive = var_19_11

	local var_19_13 = var_19_6
	local var_19_14

	if var_19_0 and var_19_0:isFinish() then
		var_19_14 = not var_19_0:isReceive()
	end

	var_19_11(var_19_13, var_19_14)

	setActive = var_19_11

	var_19_11(var_19_8, not var_19_0)

	setActive = var_19_11

	var_19_11(var_19_10, var_19_0 and not var_19_0:isFinish())

	setActive = var_19_11

	var_19_11(var_19_12, var_19_0 and var_19_0:isReceive())

	local var_19_15 = arg_19_0.normalProgressPanel
	local var_19_16 = var_9.Find(var_19_15, "Slider/LabelText")
	local var_19_17 = arg_19_0.normalProgressPanel
	local var_19_18 = var_10.Find(var_19_17, "Slider/ProgressText")

	if not var_19_0 then
		Task = var_19_17
		var_19_0 = var_19_17.New({
			id = arg_19_2
		})

		if arg_19_0:isFinishedAll(arg_19_3) then
			local var_19_19 = arg_19_0

			var_19_17 = arg_19_0.emit
			TrainingCampMediator = var_13

			var_19_17(var_19_19, var_13.ON_TRIGGER, {
				cmd = 2,
				activity_id = arg_19_0.activity.id
			})
		end

		setText = var_19_17

		local var_19_20 = var_19_16

		i18n = var_13

		var_19_17(var_19_20, var_13("newplayer_notice_" .. arg_19_1))

		var_19_17 = 0
		_ = var_19_20

		var_19_20.each(arg_19_3, function(arg_20_0)
			local var_20_0 = arg_19_0.taskProxy

			if var_1.getFinishTaskById(var_20_0, arg_20_0) ~= nil then
				var_19_17 = var_19_17 + 1
			end

			return
		end)

		setText = var_12

		var_12(var_19_18, var_19_17 .. "/" .. #arg_19_3)
	else
		setText = var_19_17

		local var_19_21 = var_19_16

		var_1_10014 = var_19_0

		var_19_17(var_19_21, var_19_0.getConfig(var_1_10014, "desc"))

		setText = var_19_17

		local var_19_22 = var_19_18

		math = var_13

		var_19_17(var_19_22, var_13.min(var_19_0.progress, var_19_0:getConfig("target_num")) .. "/" .. var_19_0:getConfig("target_num"))
	end

	local var_19_23 = arg_19_0.normalProgressPanel
	local var_19_24 = var_11.Find(var_19_23, "Slider")
	local var_19_25 = var_11.GetComponent

	typeof = var_13
	Slider = var_1_10014

	local var_19_26 = var_19_25(var_19_24, var_13(var_1_10014))
	local var_19_27 = var_19_0.progress
	local var_19_28 = var_19_0

	var_19_26.value = var_19_27 / var_19_0.getConfig(var_19_28, "target_num")

	local var_19_29 = arg_19_0.normalProgressPanel
	local var_19_30 = var_11.Find(var_19_29, "Icon")
	local var_19_31 = var_11.GetComponent

	typeof = var_13
	Image = var_19_28

	local var_19_32 = var_19_31(var_19_30, var_13(var_19_28))

	GetSpriteFromAtlas = var_19_30
	var_19_32.sprite = var_19_30("ui/trainingcampui_atlas", "panel_phase_award_" .. arg_19_1)
	setText = var_19_32

	local var_19_33 = arg_19_0.normalProgressPanel
	local var_19_34 = var_12.Find(var_19_33, "TipText")

	i18n = var_19_33

	var_19_32(var_19_34, var_19_33("newplayer_notice_" .. 3 + arg_19_1))

	onButton = var_19_32

	local var_19_35 = arg_19_0
	local var_19_36 = var_19_6

	local function var_19_37()
		local var_21_0 = var_19_0

		if var_0.isSelectable(var_21_0) then
			local var_21_1 = arg_19_0

			var_0.openMsgbox(var_21_1, function(arg_22_0)
				local var_22_0 = arg_19_0
				local var_22_1 = var_1.emit

				TrainingCampMediator = var_3_10003

				var_22_1(var_22_0, var_3_10003.ON_SELECTABLE_GET, var_19_0, arg_22_0)

				return
			end)
		else
			local var_21_2 = arg_19_0
			local var_21_3 = var_0.emit

			TrainingCampMediator = var_2_10002

			var_21_3(var_21_2, var_2_10002.ON_GET, var_19_0)
		end

		return
	end

	SFX_PANEL = var_15

	var_19_32(var_19_35, var_19_36, var_19_37, var_15)

	onButton = var_19_32

	local var_19_38 = arg_19_0
	local var_19_39 = var_19_10

	local function var_19_40()
		local var_23_0 = arg_19_0
		local var_23_1 = var_0.emit

		TrainingCampMediator = var_2_10002

		var_23_1(var_23_0, var_2_10002.ON_GO, var_19_0)

		return
	end

	SFX_PANEL = var_15

	var_19_32(var_19_38, var_19_39, var_19_40, var_15)

	return
end

function var_0_1.initTecPanel(arg_24_0)
	local var_24_0 = arg_24_0.tecTaskActivity
	local var_24_1 = var_1.getConfig(var_24_0, "config_data")[3]
	local var_24_2 = arg_24_0.tecTaskActivity

	arg_24_0.allTechPhase = #var_2.getConfig(var_24_2, "config_data")[3] + 1

	local var_24_3 = arg_24_0.tecPanel
	local var_24_4 = var_3.Find(var_24_3, "ToggleList")
	local var_24_5 = var_3.Find(var_24_4, "Phase1")

	UIItemList = var_24_4

	var_24_4.StaticAlign(var_3, var_24_5, arg_24_0.allTechPhase, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			arg_25_2.name = "Phase" .. arg_25_1
			setText = var_3

			local var_25_0 = arg_25_2
			local var_25_1 = arg_25_2.Find(var_25_0, "TextImg")

			i18n = var_25_0

			var_3(var_25_1, var_25_0("tec_catchup_" .. arg_25_1))

			onToggle = var_3

			local var_25_2 = arg_24_0
			local var_25_3 = arg_25_2

			local function var_25_4(arg_26_0)
				setTextColor = var_3_10001

				local var_26_0 = arg_25_2
				local var_26_1 = var_2.Find(var_26_0, "TextImg")

				if arg_26_0 then
					Color = var_26_0

					if not var_26_0.white then
						Color = var_26_0
						var_26_0 = var_26_0.NewHex("525252")
					end

					var_3_10001(var_26_1, var_26_0)

					if arg_26_0 then
						local var_26_2 = arg_24_0

						var_1.updateTecPanel(var_26_2, arg_25_1)
					end

					return
				end
			end

			SFX_PANEL = var_7

			var_3(var_25_2, var_25_3, var_25_4, var_7)

			onButton = var_3

			local var_25_5 = arg_24_0
			local var_25_6 = arg_25_2:Find("Disable")

			local function var_25_7()
				pg = var_3_10000

				local var_27_0 = var_3_10000.TipsMgr.GetInstance()
				local var_27_1 = var_0.ShowTips

				i18n = var_3_10002

				var_27_1(var_27_0, var_3_10002("tec_notice_not_open_tip"))

				return
			end

			SFX_PANEL = var_7

			var_3(var_25_5, var_25_6, var_25_7, var_7)

			onButton = var_3

			local var_25_8 = arg_24_0
			local var_25_9 = arg_25_2:Find("Unlock")

			local function var_25_10()
				pg = var_3_10000

				local var_28_0 = var_3_10000.MsgboxMgr.GetInstance()
				local var_28_1 = var_0.ShowMsgBox
				local var_28_2 = {}

				string = var_3_10003
				var_28_2.content = var_3_10003.format("are you unlock phase %d ?", arg_25_1)

				function var_28_2.onYes()
					if arg_25_1 == 1 then
						warning = var_0

						var_0("cmd 3")

						local var_29_0 = arg_24_0
						local var_29_1 = var_0.emit

						TrainingCampMediator = var_4_10002

						var_29_1(var_29_0, var_4_10002.ON_TRIGGER, {
							cmd = 3,
							activity_id = arg_24_0.tecTaskActivity.id
						})
					else
						local var_29_2 = arg_24_0
						local var_29_3 = var_0.emit

						TrainingCampMediator = var_4_10002

						var_29_3(var_29_2, var_4_10002.ON_TRIGGER, {
							cmd = 1,
							activity_id = arg_24_0.tecTaskActivity.id,
							arg1 = arg_25_1 == 0 and 1 or arg_25_1
						})
					end

					return
				end

				var_28_1(var_28_0, var_28_2)

				return
			end

			SFX_PANEL = var_7

			var_3(var_25_8, var_25_9, var_25_10, var_7)
		end

		return
	end)

	UIItemList = var_5

	local var_24_6 = var_5.New
	local var_24_7 = arg_24_0.tecPanel
	local var_24_8 = var_6.Find(var_24_7, "ScrollRect/Content")
	local var_24_9 = arg_24_0.tecPanel

	arg_24_0.tecTaskUIItemList = var_24_6(var_24_8, var_7.Find(var_24_9, "ScrollRect/TaskTpl"))

	local var_24_10 = arg_24_0.tecPanel

	arg_24_0.tecProgressPanel = var_5.Find(var_24_10, "ProgressPanel")

	return
end

function var_0_1.updateTecPanel(arg_30_0, arg_30_1)
	arg_30_0.cachePageID = arg_30_1

	local var_30_0 = arg_30_0.tecTaskActivity
	local var_30_1 = var_2.getConfig(var_30_0, "config_data")[3]

	math = var_30_0

	local var_30_2 = var_30_1[var_30_0.max(1, arg_30_1)][1]

	math = var_5

	local var_30_3 = var_30_1[var_5.max(1, arg_30_1)][2]

	arg_30_0:sortTaskIDList(var_30_2)
	arg_30_0:updateTaskUIItemList(arg_30_0.tecTaskUIItemList, var_30_2)
	arg_30_0:updateTecProgressPanel(var_30_3, arg_30_1, var_30_2)

	return
end

function var_0_1.updateTecProgressPanel(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0:isFinishedAll(arg_31_3) then
		local var_31_0 = arg_31_0
		local var_31_1 = arg_31_0.emit

		TrainingCampMediator = var_6

		var_31_1(var_31_0, var_6.ON_TRIGGER, {
			cmd = 2,
			activity_id = arg_31_0.activity.id
		})
	end

	local var_31_2

	if arg_31_0.phaseId == arg_31_2 then
		local var_31_3 = arg_31_0.taskProxy

		var_31_2 = var_5.getTaskVO(var_31_3, arg_31_1)
	else
		var_31_2 = arg_31_0:getTask(arg_31_1)
	end

	if var_31_2 and var_31_2:isClientTrigger() and not var_31_2:isFinish() then
		local var_31_4 = arg_31_0
		local var_31_5 = arg_31_0.emit

		TrainingCampMediator = var_1_10007

		var_31_5(var_31_4, var_1_10007.ON_UPDATE, var_31_2)
	end

	local var_31_6 = arg_31_0.tecProgressPanel
	local var_31_7 = var_5.Find(var_31_6, "Get")
	local var_31_8 = arg_31_0.tecProgressPanel
	local var_31_9 = var_6.Find(var_31_8, "Lock")
	local var_31_10 = arg_31_0.tecProgressPanel
	local var_31_11 = var_7.Find(var_31_10, "Go")
	local var_31_12 = arg_31_0.tecProgressPanel
	local var_31_13 = var_8.Find(var_31_12, "Pass")

	setActive = var_31_12

	local var_31_14 = var_31_7
	local var_31_15

	if var_31_2 and var_31_2:isFinish() then
		var_31_15 = not var_31_2:isReceive()
	end

	var_31_12(var_31_14, var_31_15)

	setActive = var_31_12

	var_31_12(var_31_9, not var_31_2)

	setActive = var_31_12

	var_31_12(var_31_11, var_31_2 and not var_31_2:isFinish())

	setActive = var_31_12

	var_31_12(var_31_13, var_31_2 and var_31_2:isReceive())

	local var_31_16 = arg_31_0.tecProgressPanel
	local var_31_17 = var_9.Find(var_31_16, "Slider/LabelText")
	local var_31_18 = arg_31_0.tecProgressPanel
	local var_31_19 = var_10.Find(var_31_18, "Slider/ProgressText")

	if not var_31_2 then
		var_31_18 = 0
		_ = var_12

		var_12.each(arg_31_3, function(arg_32_0)
			local var_32_0 = arg_31_0.taskProxy

			if var_1.getTaskVO(var_32_0, arg_32_0) and var_1:isReceive() then
				var_31_18 = var_31_18 + 1
			end

			return
		end)

		Task = var_12
		var_31_2 = var_12.New({
			id = arg_31_1
		})
		setText = var_12
		var_1_10013 = var_31_17
		i18n = var_14

		local var_31_20 = "tec_notice"

		i18n = var_1_10016

		var_12(var_1_10013, var_14(var_31_20, var_1_10016("tec_catchup_" .. arg_31_2)))
	else
		setText = var_31_18

		var_31_18(var_31_17, var_31_2:getConfig("desc"))
	end

	setText = var_31_18

	local var_31_21 = var_31_19

	math = var_1_10013

	var_31_18(var_31_21, var_1_10013.min(var_31_2.progress, var_31_2:getConfig("target_num")) .. "/" .. var_31_2:getConfig("target_num"))

	setSlider = var_31_18

	local var_31_22 = arg_31_0.tecProgressPanel

	var_31_18(var_12.Find(var_31_22, "Slider"), 0, var_31_2:getConfig("target_num"), var_31_2.progress)

	local var_31_23 = arg_31_0.tecProgressPanel
	local var_31_24 = var_11.Find(var_31_23, "Icon/Item")
	local var_31_25 = var_31_2:getConfig("award_display")[1]
	local var_31_26 = {
		type = var_31_25[1],
		id = var_31_25[2],
		count = var_31_25[3]
	}

	updateDrop = var_14

	var_14(var_31_24, var_31_26)

	onButton = var_14

	local var_31_27 = arg_31_0
	local var_31_28 = var_31_24

	local function var_31_29()
		local var_33_0 = arg_31_0
		local var_33_1 = var_0.emit

		BaseUI = var_2_10002

		var_33_1(var_33_0, var_2_10002.ON_DROP, var_31_26)

		return
	end

	SFX_PANEL = var_1_10018

	var_14(var_31_27, var_31_28, var_31_29, var_1_10018)

	setActive = var_14

	local var_31_30 = arg_31_0.tecProgressPanel

	var_14(var_15.Find(var_31_30, "TipText"), false)

	onButton = var_14

	local var_31_31 = arg_31_0
	local var_31_32 = var_31_7

	local function var_31_33()
		local var_34_0 = var_31_2

		if var_0.isSelectable(var_34_0) then
			local var_34_1 = arg_31_0

			var_0.openMsgbox(var_34_1, function(arg_35_0)
				local var_35_0 = arg_31_0
				local var_35_1 = var_1.emit

				TrainingCampMediator = var_3_10003

				var_35_1(var_35_0, var_3_10003.ON_SELECTABLE_GET, var_31_2, arg_35_0)

				return
			end)
		else
			local var_34_2 = arg_31_0
			local var_34_3 = var_0.emit

			TrainingCampMediator = var_2_10002

			var_34_3(var_34_2, var_2_10002.ON_GET, var_31_2)
		end

		return
	end

	SFX_PANEL = var_1_10018

	var_14(var_31_31, var_31_32, var_31_33, var_1_10018)

	onButton = var_14

	local var_31_34 = arg_31_0
	local var_31_35 = var_31_11

	local function var_31_36()
		local var_36_0 = arg_31_0
		local var_36_1 = var_0.emit

		TrainingCampMediator = var_2_10002

		var_36_1(var_36_0, var_2_10002.ON_GO, var_31_2)

		return
	end

	SFX_PANEL = var_1_10018

	var_14(var_31_34, var_31_35, var_31_36, var_1_10018)

	return
end

function var_0_1.updateToggleDisable(arg_37_0, arg_37_1)
	ipairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_1) do
		setActive = var_1_10007

		var_1_10007(iter_37_1:Find("Disable"), iter_37_0 > arg_37_0.phaseId)
	end

	return
end

function var_0_1.updateTechToggleState(arg_38_0)
	local var_38_1

	if arg_38_0.techFinishTaskId then
		local var_38_0 = arg_38_0.taskProxy

		var_38_1 = var_1.getTaskVO(var_38_0, arg_38_0.techFinishTaskId)
	end

	if arg_38_0.phaseId ~= "ready" then
		TechnologyConst = var_2

		local var_38_2

		if var_2.isTecActOn() and var_38_1 then
			::label_38_0::

			var_1_10003 = var_38_1
			var_38_2 = var_38_1.isReceive(var_1_10003)

			if false then
				var_38_2 = false
			end

			if false then
				var_38_2 = true
			end
		end

		eachChild = var_1_10003

		local var_38_3 = arg_38_0.tecPanel

		var_1_10003(var_4.Find(var_38_3, "ToggleList"), function(arg_39_0, arg_39_1)
			local var_39_0 = not arg_38_0.finishPhaseDic[arg_39_1] and arg_38_0.phaseId ~= arg_39_1

			if var_38_2 then
				if arg_39_1 == 1 then
					local var_39_1

					if not arg_38_0.finishPhaseDic[0] then
						if arg_38_0.phaseId ~= 0 then
							var_39_1 = false

							goto label_39_0
						end

						var_39_1 = true
					end

					::label_39_0::

					setActive = var_2_10004

					var_2_10004(arg_39_0:Find("Unlock"), var_39_0 and var_39_1)

					setActive = var_2_10004

					var_2_10004(arg_39_0:Find("Disable"), var_39_0 and not var_39_1)

					return
				end
			end
		end)

		return
	end
end

function var_0_1.updateTaskUIItemList(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1:make(function(arg_41_0, arg_41_1, arg_41_2)
		UIItemList = var_2_10003

		if arg_41_0 == var_2_10003.EventUpdate then
			arg_41_1 = arg_41_1 + 1

			local var_41_0 = arg_40_0

			var_3.updateTask(var_41_0, arg_40_2[arg_41_1], arg_41_2)
		end

		return
	end)
	arg_40_1:align(#arg_40_2)

	return
end

function var_0_1.updateTask(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_2:Find("Get")
	local var_42_1 = arg_42_2:Find("Got")
	local var_42_2 = arg_42_2:Find("Go")
	local var_42_3 = arg_42_0
	local var_42_4 = arg_42_0.getTask(var_42_3, arg_42_1)

	setActive = var_42_3

	local var_42_5 = var_42_0
	local var_42_6

	if var_42_4 and var_42_4:isFinish() then
		var_42_6 = not var_42_4:isReceive()
	end

	var_42_3(var_42_5, var_42_6)

	setActive = var_42_3

	var_42_3(var_42_1, var_42_4 and var_42_4:isReceive())

	setActive = var_42_3

	var_42_3(var_42_2, not var_42_4 or var_42_4 and not var_42_4:isFinish())

	if var_42_4 and var_42_4:isClientTrigger() and not var_42_4:isFinish() then
		local var_42_7 = arg_42_0

		var_42_3 = arg_42_0.emit
		TrainingCampMediator = var_9

		var_42_3(var_42_7, var_9.ON_UPDATE, var_42_4)
	end

	setText = var_42_3

	var_42_3(arg_42_2:Find("TitleText"), var_42_4:getConfig("desc"))

	local var_42_8 = var_42_4:getConfig("award_display")[1]
	local var_42_9 = arg_42_2:Find("Item")
	local var_42_10 = {
		type = var_42_8[1],
		id = var_42_8[2],
		count = var_42_8[3]
	}

	updateDrop = var_10

	var_10(var_42_9, var_42_10)

	onButton = var_10

	local var_42_11 = arg_42_0
	local var_42_12 = var_42_9

	local function var_42_13()
		local var_43_0 = arg_42_0
		local var_43_1 = var_0.emit

		BaseUI = var_2_10002

		var_43_1(var_43_0, var_2_10002.ON_DROP, var_42_10)

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_42_11, var_42_12, var_42_13, var_1_10014)

	setText = var_10

	local var_42_14 = arg_42_2
	local var_42_15 = arg_42_2.Find(var_42_14, "ProgressText")

	math = var_42_14

	var_10(var_42_15, var_42_14.min(var_42_4.progress, var_42_4:getConfig("target_num")) .. "/" .. var_42_4:getConfig("target_num"))

	onButton = var_10

	local var_42_16 = arg_42_0
	local var_42_17 = var_42_0

	local function var_42_18()
		local var_44_0 = arg_42_0
		local var_44_1 = var_0.emit

		TrainingCampMediator = var_2_10002

		var_44_1(var_44_0, var_2_10002.ON_GET, var_42_4)

		return
	end

	SFX_PANEL = var_14

	var_10(var_42_16, var_42_17, var_42_18, var_14)

	onButton = var_10

	local var_42_19 = arg_42_0
	local var_42_20 = var_42_2

	local function var_42_21()
		local var_45_0 = arg_42_0
		local var_45_1 = var_0.emit

		TrainingCampMediator = var_2_10002

		var_45_1(var_45_0, var_2_10002.ON_GO, var_42_4)

		return
	end

	SFX_PANEL = var_14

	var_10(var_42_19, var_42_20, var_42_21, var_14)

	return
end

function var_0_1.getTask(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.taskProxy

	if not var_2.getTaskVO(var_46_0, arg_46_1) then
		Task = var_46_0

		local var_46_1 = var_46_0.New({
			id = arg_46_1
		})

		var_2.progress = var_2.getConfig(var_46_1, "target_num")
		var_2.submitTime = 1
	end

	return var_2
end

function var_0_1.getTaskState(arg_47_0, arg_47_1)
	if arg_47_1:isReceive() then
		return 0
	elseif arg_47_1:isFinish() then
		return 2
	elseif not arg_47_1:isFinish() then
		return 1
	end

	return -1
end

function var_0_1.sortTaskIDList(arg_48_0, arg_48_1)
	table = var_1_10002

	var_1_10002.sort(arg_48_1, function(arg_49_0, arg_49_1)
		local var_49_0 = arg_48_0.taskProxy
		local var_49_1

		if not var_2.getTaskVO(var_49_0, arg_49_0) then
			Task = var_49_1
			var_49_1 = var_49_1.New({
				id = arg_49_0
			})
		end

		local var_49_2 = arg_48_0.taskProxy
		local var_49_3

		if not var_3.getTaskVO(var_49_2, arg_49_1) then
			Task = var_49_3
			var_49_3 = var_49_3.New({
				id = arg_49_1
			})
		end

		local var_49_4 = arg_48_0
		local var_49_5 = var_4.getTaskState(var_49_4, var_49_1)
		local var_49_6 = arg_48_0

		if var_49_5 == var_5.getTaskState(var_49_6, var_49_3) then
			return var_49_1.id < var_49_3.id
		else
			return var_5 < var_49_5
		end

		return
	end)

	return arg_48_1
end

function var_0_1.isFinishedAll(arg_50_0, arg_50_1)
	_ = var_1_10002

	return var_1_10002.all(arg_50_1, function(arg_51_0)
		local var_51_0 = arg_50_0.taskProxy
		local var_51_1

		if not var_1.getTaskVO(var_51_0, arg_51_0) or not var_1:isReceive() then
			var_51_1 = false
		end

		return var_51_1
	end)
end

function var_0_1.isMissTask(arg_52_0, arg_52_1)
	_ = var_1_10002

	return var_1_10002.any(arg_52_1, function(arg_53_0)
		local var_53_0 = arg_52_0.taskProxy

		return var_1.getTaskVO(var_53_0, arg_53_0) == nil
	end)
end

function var_0_1.setPhrase(arg_54_0)
	if arg_54_0.lockFirst == true then
		arg_54_0.phaseId = 1

		return
	end

	local var_54_0 = 1
	local var_54_1 = arg_54_0.activity
	local var_54_2 = #var_2.getConfig(var_54_1, "config_data")[3]

	local function var_54_3(arg_55_0)
		if arg_55_0 > 1 then
			local var_55_0 = var_0[arg_55_0 - 1][2]
			local var_55_1 = arg_54_0.taskProxy

			return var_2.getFinishTaskById(var_55_1, var_55_0) ~= nil
		end

		return
	end

	for iter_54_0 = var_54_2, 1, -1 do
		local var_54_4 = var_2[iter_54_0][1]

		_ = var_1_10010

		if var_1_10010.all(var_54_4, function(arg_56_0)
			local var_56_0 = arg_54_0.taskProxy

			return var_1.getTaskVO(var_56_0, arg_56_0) ~= nil
		end) or var_54_3(iter_54_0) then
			var_54_0 = iter_54_0

			break
		end
	end

	arg_54_0.phaseId = var_54_0

	return
end

function var_0_1.setTechPhrase(arg_57_0)
	if arg_57_0.activity.data1 == 0 then
		arg_57_0.phaseId = "ready"
	else
		arg_57_0.phaseId = arg_57_0.activity.data1

		if arg_57_0.phaseId == 1 and arg_57_0.activity.data2 < 1 then
			arg_57_0.phaseId = 0
		end
	end

	if arg_57_0.phaseId ~= "ready" then
		local var_57_0 = arg_57_0.activity
		local var_57_1 = var_1.getConfig(var_57_0, "config_data")[3]

		math = var_57_0

		local var_57_2

		if not var_57_1[var_57_0.max(1, arg_57_0.phaseId)][2] then
			var_57_2 = nil
		end

		arg_57_0.techFinishTaskId = var_57_2
		arg_57_0.finishPhaseDic = {}
		ipairs = var_1

		for iter_57_0, iter_57_1 in var_1(arg_57_0.activity.data1_list) do
			arg_57_0.finishPhaseDic[iter_57_1] = true
		end

		arg_57_0.finishPhaseDic[0] = arg_57_0.finishPhaseDic[1]
		arg_57_0.finishPhaseDic[1] = arg_57_0.activity.data2 == 1 and arg_57_0.activity.data1 ~= 1

		arg_57_0:updateTechToggleState()

		return
	end
end

function var_0_1.switchPanel(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.activity = arg_58_1

	local var_58_0 = arg_58_1
	local var_58_1 = arg_58_1.getConfig(var_58_0, "type")

	ActivityConst = var_58_0

	if var_58_1 == var_58_0.ACTIVITY_TYPE_GUIDE_TASKS then
		arg_58_0:setPhrase()

		if arg_58_2 then
			arg_58_0:aniOnSwitch(arg_58_0.normalPanel, arg_58_0.tecPanel)
		else
			setActive = var_3

			var_3(arg_58_0.normalPanel, true)

			setActive = var_3

			var_3(arg_58_0.tecPanel, false)
		end

		arg_58_0:updateToggleDisable(arg_58_0.normalToggles)

		triggerToggle = var_3

		var_3(arg_58_0.normalToggles[arg_58_0.phaseId], true)
	else
		local var_58_2 = arg_58_1
		local var_58_3 = arg_58_1.getConfig(var_58_2, "type")

		ActivityConst = var_58_2

		if var_58_3 == var_58_2.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
			arg_58_0:setTechPhrase()

			local var_58_4 = arg_58_0.phaseId == "ready"
			local var_58_5 = arg_58_0.tecPanel
			local var_58_6 = var_4.Find(var_58_5, "ToggleList")
			local var_58_7 = var_4.GetComponent

			typeof = var_6
			ToggleGroup = var_1_10007

			local var_58_8 = var_58_7(var_58_6, var_6(var_1_10007))

			var_58_8.allowSwitchOff = var_58_4
			setActive = var_58_8

			local var_58_9 = arg_58_0.tecPanel

			var_58_8(var_5.Find(var_58_9, "ScrollRect"), not var_58_4)

			setActive = var_58_8

			local var_58_10 = arg_58_0.tecPanel

			var_58_8(var_5.Find(var_58_10, "ProgressPanel"), not var_58_4)

			if arg_58_2 then
				arg_58_0:aniOnSwitch(arg_58_0.tecPanel, arg_58_0.normalPanel)
			else
				setActive = var_58_8

				var_58_8(arg_58_0.normalPanel, false)

				setActive = var_58_8

				var_58_8(arg_58_0.tecPanel, true)
			end

			if arg_58_0.phaseId == "ready" then
				eachChild = var_4

				local var_58_11 = arg_58_0.tecPanel

				var_4(var_5.Find(var_58_11, "ToggleList"), function(arg_59_0)
					triggerToggle = var_2_10001

					var_2_10001(arg_59_0, false)

					return
				end)
			else
				triggerToggle = var_4

				local var_58_12 = arg_58_0.tecPanel
				local var_58_13 = var_5.Find(var_58_12, "ToggleList")

				var_4(var_5.GetChild(var_58_13, arg_58_0.phaseId), true)
			end
		end
	end

	return
end

function var_0_1.switchPageByMediator(arg_60_0)
	local var_60_0 = arg_60_0.activity
	local var_60_1 = var_1.getConfig(var_60_0, "type")

	ActivityConst = var_60_0

	if var_60_1 == var_60_0.ACTIVITY_TYPE_GUIDE_TASKS then
		arg_60_0:switchPanel(arg_60_0.normalTaskactivity)
	else
		local var_60_2 = arg_60_0.activity
		local var_60_3 = var_1.getConfig(var_60_2, "type")

		ActivityConst = var_60_2

		if var_60_3 == var_60_2.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
			arg_60_0:switchPanel(arg_60_0.tecTaskActivity)
		end
	end

	return
end

function var_0_1.aniOnSwitch(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0.isOnSwitchAni = true

	arg_61_1:SetAsLastSibling()

	setActive = var_3

	var_3(arg_61_1, true)

	GetOrAddComponent = var_3

	local var_61_0 = var_3(arg_61_1, "DftAniEvent")

	var_3.SetEndEvent(var_61_0, function()
		local var_62_0 = arg_61_0

		var_62_0.isOnSwitchAni = false
		setActive = var_62_0

		var_62_0(arg_61_2, false)

		return
	end)

	return
end

function var_0_1.openMsgbox(arg_63_0, arg_63_1)
	setActive = var_1_10002

	var_1_10002(arg_63_0.switchToNormalBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_63_0.switchToTecBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_63_0.awardMsg, true)

	setActive = var_1_10002

	var_1_10002(arg_63_0.normalPanel, false)

	local var_63_0
	local var_63_1 = arg_63_0.awardMsg
	local var_63_2 = var_3.Find(var_63_1, "photos")

	for iter_63_0 = 1, var_63_2.childCount do
		local var_63_3 = var_63_2
		local var_63_4 = var_63_2.GetChild(var_63_3, iter_63_0 - 1)

		onToggle = var_63_3

		local var_63_5 = arg_63_0
		local var_63_6 = var_63_4

		local function var_63_7(arg_64_0)
			if arg_64_0 then
				var_63_0 = iter_63_0
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_63_3(var_63_5, var_63_6, var_63_7, var_1_10013)
	end

	onButton = var_4

	local var_63_8 = arg_63_0
	local var_63_9 = arg_63_0.awardMsg
	local var_63_10 = var_6.Find(var_63_9, "confirm_btn")

	local function var_63_11()
		if var_63_0 then
			if arg_63_1 then
				arg_63_1(var_63_0)
			end

			local var_65_0 = arg_63_0

			var_0.closeMsgBox(var_65_0)
		end

		return
	end

	SFX_PANEL = var_8

	var_4(var_63_8, var_63_10, var_63_11, var_8)

	return
end

function var_0_1.closeMsgBox(arg_66_0)
	setActive = var_1_10001

	var_1_10001(arg_66_0.awardMsg, false)

	setActive = var_1_10001

	var_1_10001(arg_66_0.normalPanel, true)
	arg_66_0:updateSwitchBtns()

	return
end

function var_0_1.tryShowTecFixTip(arg_67_0, arg_67_1)
	if arg_67_0.tecTaskActivity and arg_67_1 == arg_67_0.tecTaskActivity.id then
		local var_67_0 = arg_67_0.activityProxy
		local var_67_1 = var_2.getActivityByType

		ActivityConst = var_1_10004
		arg_67_0.tecTaskActivity = var_67_1(var_67_0, var_1_10004.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)
	end

	return
end

return var_0_1
