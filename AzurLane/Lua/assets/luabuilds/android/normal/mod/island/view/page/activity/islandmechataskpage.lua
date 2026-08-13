class = var_0_10000

local var_0_0 = "IslandMechaTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.item = var_1.Find(var_1_0, "bg/tasks/task")

	local var_1_1 = arg_1_0._tf

	arg_1_0.items = var_1.Find(var_1_1, "bg/tasks")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_1.Find(var_1_2, "bg/time/Text")
	local var_1_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.timeTxt = var_1_4(var_1_3, var_3(var_1_10004))

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_1.Find(var_1_5, "bg/desc")
	local var_1_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.descTxt = var_1_7(var_1_6, var_3(var_1_10004))

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_1.Find(var_1_8, "bg/progress")
	local var_1_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.progressTxt = var_1_10(var_1_9, var_3(var_1_10004))

	local var_1_11 = arg_1_0._tf

	arg_1_0.lookAllBtn = var_1.Find(var_1_11, "bg/look_all")

	local var_1_12 = arg_1_0._tf

	arg_1_0.preViewBtn = var_1.Find(var_1_12, "bg/preview")
	setText = var_1

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_2.Find(var_1_13, "bg/preview/Text")

	i18n = var_1_13

	var_1(var_1_14, var_1_13("island_mecha_task_preview"))

	setText = var_1

	local var_1_15 = arg_1_0._tf
	local var_1_16 = var_2.Find(var_1_15, "bg/look_all/Text")

	i18n = var_1_15

	var_1(var_1_16, var_1_15("island_mecha_task_look_all"))

	IslandMechaTaskDescPage = var_1

	local var_1_17 = var_1.New

	pg = var_1_16
	arg_1_0.descPage = var_1_17(var_1_16.UIMgr.GetInstance().OverlayMain, arg_1_0.event)
	onButton = var_1

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.preViewBtn

	local function var_1_20()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		IslandMediator = var_2_10002

		var_2_1(var_2_0, var_2_10002.OPEN_MACHA_MODEL_PREVIEW)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_18, var_1_19, var_1_20, var_1_10005)

	onButton = var_1

	local var_1_21 = arg_1_0
	local var_1_22 = arg_1_0.lookAllBtn

	local function var_1_23()
		local var_3_0 = arg_1_0.descPage
		local var_3_1 = var_0.ExecuteAction
		local var_3_2 = "Show"
		local var_3_3 = arg_1_0.activity
		local var_3_4 = var_3.getStartTime(var_3_3)
		local var_3_5 = arg_1_0.activity

		var_3_1(var_3_0, var_3_2, var_3_4, var_4.getDayIndex(var_3_5), arg_1_0.taskGroup)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_21, var_1_22, var_1_23, var_1_10005)

	local var_1_24 = arg_1_0.uilist

	var_1.make(var_1_24, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_1_0

			var_3.UpdateTask(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	IslandTaskActhelper = var_1_10001

	var_1_10001.SetNonFirstEnter(arg_5_0.activity.id)

	return
end

function var_0_1.OnDataSetting(arg_6_0)
	arg_6_0.nday = 0

	local var_6_0 = arg_6_0.activity

	arg_6_0.taskGroup = var_1.getIslandConfig(var_6_0, "config_data")

	return
end

function var_0_1.UpdateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 + 1
	local var_7_1 = arg_7_2:Find("item")
	local var_7_2 = arg_7_0.taskGroup[arg_7_0.nday][var_7_0]

	IslandTask = var_6

	local var_7_3 = var_6.New({
		id = var_7_2,
		process_list = {}
	})

	assert = var_7

	var_7(var_7_3, "without this task by id: " .. var_7_2)

	local var_7_4 = var_7_3
	local var_7_5 = var_7_3.GetAwards(var_7_4)[1]

	updateCustomDrop = var_7_4

	var_7_4(var_7_1, var_7_5)

	onButton = var_7_4

	local var_7_6 = arg_7_0
	local var_7_7 = var_7_1

	local function var_7_8()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		IslandMediator = var_2_10002

		local var_8_2 = var_2_10002.SHOW_MSG_BOX
		local var_8_3 = {}

		i18n = var_2_10004
		var_8_3.title = var_2_10004("island_word_desc")
		IslandMsgBox = var_4
		var_8_3.type = var_4.TYPE_COMMON_DROP_DESCRIBE
		var_8_3.dropData = var_7_5

		var_8_1(var_8_0, var_8_2, var_8_3)

		return
	end

	SFX_PANEL = var_1_10012

	var_7_4(var_7_6, var_7_7, var_7_8, var_1_10012)

	local var_7_9 = arg_7_2:Find("go_btn")
	local var_7_10 = arg_7_2:Find("get_btn")
	local var_7_11 = arg_7_2:Find("got_btn")
	local var_7_12 = arg_7_2
	local var_7_13 = arg_7_2.Find(var_7_12, "un_finish")

	IslandTaskActhelper = var_7_12

	local var_7_14, var_7_15, var_7_16 = var_7_12.GetIslandTaskState(var_7_2)

	setText = var_1_10015

	var_1_10015(arg_7_2:Find("description"), var_7_3:getConfig("task_desc"))

	setText = var_1_10015

	var_1_10015(arg_7_2:Find("progressText"), var_7_14 .. "/" .. var_7_15)

	setSlider = var_1_10015

	var_1_10015(arg_7_2:Find("progress"), 0, var_7_15, var_7_14)

	local var_7_17 = var_7_3
	local var_7_18 = var_7_3.GetTargetList(var_7_17)[1]

	pg = var_7_17

	local var_7_19 = var_7_17.island_task_target[var_7_18.id]

	tonumber = var_17

	local var_7_20 = var_17(var_7_19.tips)

	tonumber = var_18

	local var_7_21 = var_18(var_7_19.jump_ui)
	local var_7_22 = var_7_20 or var_7_21

	setActive = var_1_10020

	var_1_10020(var_7_13, var_7_16 == 0 and not var_7_22)

	setActive = var_1_10020

	var_1_10020(var_7_9, var_7_16 == 0 and var_7_22)

	setActive = var_1_10020

	var_1_10020(var_7_10, var_7_16 == 1)

	setActive = var_1_10020

	var_1_10020(var_7_11, var_7_16 == 2)

	onButton = var_1_10020

	local var_7_23 = arg_7_0
	local var_7_24 = var_7_9

	local function var_7_25()
		if not var_7_22 then
			return
		end

		if var_7_21 then
			local var_9_0 = arg_7_0

			var_0._SkipBtn(var_9_0, var_7_21)
		elseif var_7_20 then
			pg = var_0

			local var_9_1 = var_0.island_world_objects[var_7_20].mapId

			IslandMainBtnTipHelper = var_1

			if var_1.IsUnlock("map") then
				local var_9_2 = arg_7_0

				var_1._SkipObj(var_9_2, var_7_20)
			end
		end

		return
	end

	SFX_PANEL = var_1_10024

	var_1_10020(var_7_23, var_7_24, var_7_25, var_1_10024)

	onButton = var_1_10020

	local var_7_26 = arg_7_0
	local var_7_27 = var_7_10

	local function var_7_28()
		pg = var_2_10000

		local var_10_0 = var_2_10000.m02
		local var_10_1 = var_0.sendNotification

		GAME = var_2_10002

		var_10_1(var_10_0, var_2_10002.ISLAND_SUBMIT_TASK, {
			taskId = var_7_2
		})

		return
	end

	SFX_PANEL = var_1_10024

	var_1_10020(var_7_26, var_7_27, var_7_28, var_1_10024)

	return
end

function var_0_1.UpdateAll(arg_11_0)
	if not arg_11_0.activity then
		return
	end

	IslandTaskActhelper = var_1
	arg_11_0.nday = var_1.GetNDay(arg_11_0.activity)

	arg_11_0:UpdateDay()
	arg_11_0:UpdateDesc()
	arg_11_0:UpdateProgress()

	local var_11_0

	if not arg_11_0.taskGroup[arg_11_0.nday] then
		var_11_0 = {}
	end

	local var_11_1 = arg_11_0.uilist

	var_2.align(var_11_1, #var_11_0)

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	arg_12_0:UpdateAll()

	return
end

function var_0_1.OnShowFlush(arg_13_0)
	arg_13_0:UpdateAll()

	return
end

function var_0_1.UpdateDay(arg_14_0)
	local var_14_0 = arg_14_0.activity
	local var_14_1 = var_1.getConfig(var_14_0, "time")[2][1][2]
	local var_14_2 = var_1[2][1][3]
	local var_14_3 = var_1[3][1][2]
	local var_14_4 = var_1[3][1][3]
	local var_14_5 = arg_14_0.timeTxt

	string = var_1_10007

	local var_14_6 = var_1_10007.format
	local var_14_7 = "%d.%d - %d.%d%s"
	local var_14_8 = var_14_1
	local var_14_9 = var_14_2
	local var_14_10 = var_14_3
	local var_14_11 = var_14_4

	i18n = var_1_10013
	var_14_5.text = var_14_6(var_14_7, var_14_8, var_14_9, var_14_10, var_14_11, var_1_10013("island_draw_time_1"))

	return
end

function var_0_1.UpdateDesc(arg_15_0)
	local var_15_0 = arg_15_0.descTxt

	i18n = var_1_10002
	var_15_0.text = var_1_10002("island_mecha_task_description")

	return
end

function var_0_1.UpdateProgress(arg_16_0)
	local var_16_0 = arg_16_0.nday
	local var_16_1 = #arg_16_0.taskGroup
	local var_16_2 = arg_16_0.progressTxt

	i18n = var_1_10004
	var_16_2.text = var_1_10004("island_mecha_task_progress", var_16_0, var_16_1)

	return
end

function var_0_1.Hide(arg_17_0)
	var_0_1.super.Hide(arg_17_0)

	if arg_17_0.descPage then
		local var_17_0 = arg_17_0.descPage

		if var_1.isShowing(var_17_0) then
			local var_17_1 = arg_17_0.descPage

			var_1.Hide(var_17_1)
		end
	end

	return
end

function var_0_1.OnDestroy(arg_18_0)
	if arg_18_0.descPage then
		local var_18_0 = arg_18_0.descPage

		var_1.Destroy(var_18_0)

		arg_18_0.descPage = nil
	end

	eachChild = var_1

	var_1(arg_18_0.items, function(arg_19_0)
		Destroy = var_2_10001

		var_2_10001(arg_19_0)

		return
	end)

	return
end

function var_0_1._SkipBtn(arg_20_0, arg_20_1)
	pg = var_1_10002

	local var_20_0 = var_1_10002.island_main_btns[arg_20_1]

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_20_1 = var_1_10003(var_1_10004)
	local var_20_2 = var_3.GetIsland(var_20_1)
	local var_20_3 = var_3.GetAblityAgency(var_20_2)

	if not var_3.HasAbility(var_20_3, var_20_0.ability_id) then
		pg = var_3

		local var_20_4 = var_3.TipsMgr.GetInstance()
		local var_20_5 = var_3.ShowTips

		i18n = var_5

		var_20_5(var_20_4, var_5("island_taskjump_systemnoopen_tips"))

		return
	end

	if var_20_0.open_page ~= "" then
		local var_20_6 = arg_20_0
		local var_20_7 = arg_20_0.emit

		IslandMediator = var_5

		var_20_7(var_20_6, var_5.OPEN_PAGE, var_20_0.open_page, var_20_0.page_param)
	end

	return
end

function var_0_1._SkipObj(arg_21_0, arg_21_1)
	pg = var_1_10002

	local var_21_0 = var_1_10002.island_world_objects[arg_21_1].mapId

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_21_1 = var_1_10003(var_1_10004)
	local var_21_2 = var_3.GetIsland(var_21_1)
	local var_21_3 = var_3.GetAblityAgency(var_21_2)

	if not var_3.IsUnlockMap(var_21_3, var_21_0) then
		pg = var_3

		local var_21_4 = var_3.TipsMgr.GetInstance()
		local var_21_5 = var_3.ShowTips

		i18n = var_5

		var_21_5(var_21_4, var_5("island_taskjump_placenoopen_tips"))

		return
	end

	local var_21_6 = arg_21_0
	local var_21_7 = arg_21_0.emit

	IslandSeasonPage = var_5

	var_21_7(var_21_6, var_5.CLOSE)

	_IslandCore = var_21_7

	if var_21_7 then
		_IslandCore = var_21_7

		local var_21_8 = var_21_7:GetController()

		if var_21_0 == var_3.GetMapID(var_21_8) then
			return
		end
	end

	local var_21_9 = arg_21_0
	local var_21_10 = arg_21_0.emit

	IslandBaseMediator = var_5

	local var_21_11 = var_5.SWITCH_MAP
	local var_21_12 = var_21_0

	pg = var_1_10007

	var_21_10(var_21_9, var_21_11, var_21_12, var_1_10007.island_map[var_21_0].born_object)

	return
end

return var_0_1
