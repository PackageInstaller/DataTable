class = var_0_10000

local var_0_0 = "WorldInformationLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorldInformationUI"
end

var_0_1.Listeners = {
	onUpdateDailyTask = "OnUpdateDailyTask",
	onUpdateTask = "OnUpdateTask"
}

function var_0_1.init(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(var_0_1.Listeners) do
		arg_2_0[iter_2_0] = function(...)
			var_0_1[iter_2_1](arg_2_0, ...)

			return
		end
	end

	local var_2_0 = arg_2_0._tf

	arg_2_0.rtLeftPanel = var_1.Find(var_2_0, "adapt/left_panel")
	setText = var_1

	local var_2_1 = arg_2_0.rtLeftPanel
	local var_2_2 = var_2.Find(var_2_1, "title/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("world_map_title_tips"))

	setText = var_1

	local var_2_3 = arg_2_0.rtLeftPanel
	local var_2_4 = var_2.Find(var_2_3, "title/Text_en")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("world_map_title_tips_en"))

	WSWorldInfo = var_1
	arg_2_0.wsWorldInfo = var_1.New()

	local var_2_5 = arg_2_0.wsWorldInfo
	local var_2_6 = arg_2_0.rtLeftPanel

	var_2_5.transform = var_2.Find(var_2_6, "world_info")

	local var_2_7 = arg_2_0.wsWorldInfo

	var_1.Setup(var_2_7)

	setText = var_1

	local var_2_8 = arg_2_0.wsWorldInfo.transform
	local var_2_9 = var_2.Find(var_2_8, "power/bg/Word")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("world_total_power"))

	setText = var_1

	local var_2_10 = arg_2_0.wsWorldInfo.transform
	local var_2_11 = var_2.Find(var_2_10, "explore/mileage/Text")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("world_mileage"))

	setText = var_1

	local var_2_12 = arg_2_0.wsWorldInfo.transform
	local var_2_13 = var_2.Find(var_2_12, "explore/pressing/Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("world_pressing"))

	local var_2_14 = arg_2_0._tf

	arg_2_0.rtRightPanel = var_1.Find(var_2_14, "adapt/right_panel")

	local var_2_15 = arg_2_0.rtRightPanel

	arg_2_0.rtNothingTip = var_1.Find(var_2_15, "nothing_tip")

	local var_2_16 = arg_2_0.rtRightPanel

	arg_2_0.btnClose = var_1.Find(var_2_16, "title/close_btn")

	local var_2_17 = arg_2_0.rtRightPanel

	arg_2_0.toggleAll = var_1.Find(var_2_17, "title/task_all")

	local var_2_18 = arg_2_0.rtRightPanel

	arg_2_0.toggleMain = var_1.Find(var_2_18, "title/task_main")

	local var_2_19 = arg_2_0.rtRightPanel

	arg_2_0.rtContainer = var_1.Find(var_2_19, "main/viewport/content")
	UIItemList = var_1

	local var_2_20 = var_1.New
	local var_2_21 = arg_2_0.rtContainer
	local var_2_22 = arg_2_0.rtContainer

	arg_2_0.taskItemList = var_2_20(var_2_21, var_3.Find(var_2_22, "task_tpl"))

	local var_2_23 = arg_2_0.taskItemList

	var_1.make(var_2_23, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0

			var_3.UpdateTaskTpl(var_4_0, arg_4_2, arg_2_0.filterTaskList[arg_4_1 + 1])
		end

		return
	end)

	local var_2_24 = arg_2_0.rtLeftPanel

	arg_2_0.btnDailyTask = var_1.Find(var_2_24, "world_info/task_btn")

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.btnClose

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_3.Find(var_5_4, "bg")

	local function var_5_6()
		triggerButton = var_2_10000

		var_2_10000(arg_5_0.btnClose)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_5_3, var_5_5, var_5_6, var_5)

	onToggle = var_1_10001

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.toggleAll

	local function var_5_9(arg_8_0)
		if arg_8_0 then
			var_2_10001 = arg_5_0
			var_2_10001.filterType = nil

			local var_8_0 = arg_5_0

			var_2_10001.UpdateFilterTaskList(var_8_0)
		end

		setTextColor = var_2_10001

		local var_8_1 = arg_5_0.toggleAll

		if arg_8_0 then
			Color = var_2_10003

			if not var_2_10003.white then
				Color = var_2_10003
				var_2_10003 = var_2_10003.New(0.48627450980392156, 0.5215686274509804, 0.6431372549019608)
			end

			var_2_10001(var_8_1, var_2_10003)

			return
		end
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_7, var_5_8, var_5_9, var_5)

	onToggle = var_1_10001

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.toggleMain

	local function var_5_12(arg_9_0)
		if arg_9_0 then
			var_2_10001 = arg_5_0
			var_2_10001.filterType = 0

			local var_9_0 = arg_5_0

			var_2_10001.UpdateFilterTaskList(var_9_0)
		end

		setTextColor = var_2_10001

		local var_9_1 = arg_5_0.toggleMain

		if arg_9_0 then
			Color = var_2_10003

			if not var_2_10003.white then
				Color = var_2_10003
				var_2_10003 = var_2_10003.New(0.48627450980392156, 0.5215686274509804, 0.6431372549019608)
			end

			var_2_10001(var_9_1, var_2_10003)

			return
		end
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_10, var_5_11, var_5_12, var_5)

	onButton = var_1_10001

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.btnDailyTask

	local function var_5_15()
		nowWorld = var_2_10000

		local var_10_0 = var_2_10000()
		local var_10_1 = var_0.IsSystemOpen

		WorldConst = var_2_10002

		local var_10_2

		if var_10_1(var_10_0, var_2_10002.SystemDailyTask) then
			var_10_0 = arg_5_0
			var_10_2 = var_10_2.emit
			WorldInformationMediator = var_2

			var_10_2(var_10_0, var_2.OnOpenDailyTaskPanel)
		else
			pg = var_10_2

			local var_10_3 = var_10_2.TipsMgr.GetInstance

			i18n = var_10_0

			var_10_3(var_10_0("world_daily_task_lock"))
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_13, var_5_14, var_5_15, var_5)
	arg_5_0:OnUpdateDailyTask()

	triggerToggle = var_1

	var_1(arg_5_0.toggleAll, true)
	arg_5_0:BlurPanel(arg_5_0._tf)

	return
end

function var_0_1.willExit(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0._tf)

	local var_11_0 = arg_11_0.taskProxy
	local var_11_1 = var_1.RemoveListener

	WorldTaskProxy = var_3

	var_11_1(var_11_0, var_3.EventUpdateTask, arg_11_0.onUpdateTask)

	local var_11_2 = arg_11_0.taskProxy
	local var_11_3 = var_1.RemoveListener

	WorldTaskProxy = var_3

	var_11_3(var_11_2, var_3.EventUpdateDailyTaskIds, arg_11_0.onUpdateDailyTask)

	local var_11_4 = arg_11_0.wsWorldInfo

	var_1.Dispose(var_11_4)

	return
end

function var_0_1.setWorldTaskProxy(arg_12_0, arg_12_1)
	arg_12_0.taskProxy = arg_12_1

	local var_12_0 = arg_12_0.taskProxy
	local var_12_1 = var_2.AddListener

	WorldTaskProxy = var_1_10004

	var_12_1(var_12_0, var_1_10004.EventUpdateTask, arg_12_0.onUpdateTask)

	local var_12_2 = arg_12_0.taskProxy
	local var_12_3 = var_2.AddListener

	WorldTaskProxy = var_4

	var_12_3(var_12_2, var_4.EventUpdateDailyTaskIds, arg_12_0.onUpdateDailyTask)

	local var_12_4 = arg_12_0.taskProxy

	arg_12_0.taskList = var_2.getDoingTaskVOs(var_12_4)

	return
end

function var_0_1.UpdateFilterTaskList(arg_13_0)
	_ = var_1_10001
	arg_13_0.filterTaskList = var_1_10001.filter(arg_13_0.taskList, function(arg_14_0)
		return not arg_13_0.filterType or arg_14_0.config.type == arg_13_0.filterType
	end)
	table = var_1

	local var_13_0 = var_1.sort
	local var_13_1 = arg_13_0.filterTaskList

	CompareFuncs = var_3
	WorldTask = var_1_10004

	var_13_0(var_13_1, var_3(var_1_10004.sortDic))

	local var_13_2 = arg_13_0.taskItemList

	var_1.align(var_13_2, #arg_13_0.filterTaskList)

	setActive = var_1

	var_1(arg_13_0.rtNothingTip, #arg_13_0.filterTaskList == 0)

	return
end

function var_0_1.UpdateTaskTpl(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.Find(var_15_0, "base_panel")

	GetImageSpriteFromAtlasAsync = var_15_0

	local var_15_2 = "ui/worldtaskfloatui_atlas"

	pg = var_1_10006

	var_15_0(var_15_2, var_1_10006.WorldToastMgr.Type2PictrueName[arg_15_2.config.type], var_15_1:Find("type"), true)

	setText = var_15_0

	var_15_0(var_15_1:Find("extend_show/title/Text"), arg_15_2.config.name)

	setText = var_15_0

	var_15_0(var_15_1:Find("base_show/title/Text"), arg_15_2.config.name)

	setText = var_15_0

	var_15_0(var_15_1:Find("base_show/desc"), arg_15_2.config.description)

	local var_15_3 = var_15_1:Find("base_show/IconTpl")
	local var_15_4 = var_15_1
	local var_15_5 = var_15_1.Find(var_15_4, "base_show/award")

	removeAllChildren = var_15_4

	var_15_4(var_15_5)

	local var_15_6 = arg_15_2.config.show
	local var_15_7 = 1

	math = var_8

	for iter_15_0 = var_15_7, var_8.min(#var_15_6, 2) do
		local var_15_8 = var_15_6[iter_15_0]

		cloneTplTo = var_1_10012
		var_1_10012 = var_1_10012(var_15_3, var_15_5)
		var_1_10013 = {
			type = var_15_8[1],
			id = var_15_8[2],
			count = var_15_8[3]
		}
		updateDrop = var_14

		var_14(var_1_10012, var_1_10013)

		onButton = var_14

		local var_15_9 = arg_15_0
		local var_15_10 = var_1_10012

		local function var_15_11()
			local var_16_0 = arg_15_0

			var_0.emit(var_16_0, var_0_1.ON_DROP, var_1_10013)

			return
		end

		SFX_PANEL = var_1_10018

		var_14(var_15_9, var_15_10, var_15_11, var_1_10018)

		setActive = var_14

		var_14(var_1_10012, true)
	end

	setActive = var_15_7

	var_15_7(var_15_3, false)

	setSlider = var_15_7

	local var_15_12 = var_15_1:Find("base_show/title/progress")
	local var_15_13 = 0
	local var_15_14 = arg_15_2:getMaxProgress()
	local var_15_15 = arg_15_2

	var_15_7(var_15_12, var_15_13, var_15_14, arg_15_2.getProgress(var_15_15))

	local var_15_16 = var_15_1
	local var_15_17 = var_15_1.Find(var_15_16, "btn_go")

	onButton = var_15_16

	local var_15_18 = arg_15_0
	local var_15_19 = var_15_17

	local function var_15_20()
		local var_17_0 = arg_15_0
		local var_17_1 = var_0.emit

		WorldInformationMediator = var_2_10002

		var_17_1(var_17_0, var_2_10002.OnTaskGoto, arg_15_2.id)

		local var_17_2 = arg_15_0

		var_0.closeView(var_17_2)

		return
	end

	SFX_PANEL = var_15_15

	var_15_16(var_15_18, var_15_19, var_15_20, var_15_15)

	setButtonEnabled = var_15_16

	local var_15_21 = var_15_17

	tobool = var_15_19

	local var_15_22

	if not arg_15_2:GetFollowingAreaId() then
		var_15_22 = arg_15_2:GetFollowingEntrance()
	end

	var_15_16(var_15_21, var_15_19(var_15_22))

	local var_15_23 = var_15_1
	local var_15_24 = var_15_1.Find(var_15_23, "btn_get")

	onButton = var_15_23

	local var_15_25 = arg_15_0
	local var_15_26 = var_15_24

	local function var_15_27()
		local var_18_0 = arg_15_0
		local var_18_1 = var_0.emit

		WorldInformationMediator = var_2_10002

		var_18_1(var_18_0, var_2_10002.OnSubmitTask, arg_15_2)

		return
	end

	SFX_CONFIRM = var_1_10013

	var_15_23(var_15_25, var_15_26, var_15_27, var_1_10013)

	local var_15_28 = arg_15_2
	local var_15_29 = arg_15_2.getState(var_15_28)

	setActive = var_15_28

	local var_15_30 = var_15_17

	WorldTask = var_15_27

	var_15_28(var_15_30, var_15_29 == var_15_27.STATE_ONGOING)

	setActive = var_15_28

	local var_15_31 = var_15_24

	WorldTask = var_12

	var_15_28(var_15_31, var_15_29 == var_12.STATE_FINISHED)

	local var_15_32 = arg_15_1:Find("extend_panel")

	if #arg_15_2.config.rare_task_icon > 0 then
		GetImageSpriteFromAtlasAsync = var_12

		var_12("shipyardicon/" .. var_11, "", var_15_32:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync = var_12

		var_12("ui/worldinformationui_atlas", "nobody", var_15_32:Find("card"), true)
	end

	setText = var_12

	var_12(var_15_32:Find("content/desc"), arg_15_2.config.rare_task_text)

	setText = var_12

	var_12(var_15_32:Find("content/slider_progress/Text"), arg_15_2:getProgress() .. "/" .. arg_15_2:getMaxProgress())

	setSlider = var_12

	var_12(var_15_32:Find("content/slider"), 0, arg_15_2:getMaxProgress(), arg_15_2:getProgress())

	local var_15_33 = var_15_32:Find("content/item_tpl")
	local var_15_34 = var_15_32:Find("content/award_bg/panel/content")
	local var_15_35 = arg_15_2.config.show

	removeAllChildren = var_15

	var_15(var_15_34)

	ipairs = var_15

	for iter_15_1, iter_15_2 in var_15(var_15_35) do
		cloneTplTo = var_1_10020
		var_1_10020 = var_1_10020(var_15_33, var_15_34)

		local var_15_36 = {
			type = iter_15_2[1],
			id = iter_15_2[2],
			count = iter_15_2[3]
		}

		updateDrop = var_22

		var_22(var_1_10020, var_15_36)

		onButton = var_22

		local var_15_37 = arg_15_0
		local var_15_38 = var_1_10020

		local function var_15_39()
			local var_19_0 = arg_15_0

			var_0.emit(var_19_0, var_0_1.ON_DROP, var_15_36)

			return
		end

		SFX_PANEL = var_1_10026

		var_22(var_15_37, var_15_38, var_15_39, var_1_10026)

		setActive = var_22

		var_22(var_1_10020, true)
	end

	setActive = var_15

	var_15(var_15_33, false)

	setActive = var_15

	var_15(var_15_32:Find("content/award_bg/arror"), #var_15_35 > 3)

	return
end

function var_0_1.OnUpdateTask(arg_20_0)
	local var_20_0 = arg_20_0.taskProxy

	arg_20_0.taskList = var_1.getDoingTaskVOs(var_20_0)

	arg_20_0:UpdateFilterTaskList()

	return
end

function var_0_1.OnUpdateDailyTask(arg_21_0)
	setActive = var_1_10001

	local var_21_0 = arg_21_0.btnDailyTask
	local var_21_1 = var_2.Find(var_21_0, "tip")
	local var_21_2 = arg_21_0.taskProxy

	var_1_10001(var_21_1, var_3.canAcceptDailyTask(var_21_2))

	setActive = var_1_10001

	local var_21_3 = arg_21_0.btnDailyTask
	local var_21_4 = var_2.Find(var_21_3, "locked")

	nowWorld = var_21_3

	local var_21_5 = var_21_3()
	local var_21_6 = var_3.IsSystemOpen

	WorldConst = var_1_10005

	var_1_10001(var_21_4, not var_21_6(var_21_5, var_1_10005.SystemDailyTask))

	return
end

return var_0_1
