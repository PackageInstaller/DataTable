class = var_0_10000

local var_0_0 = "IslandMechaTaskDescPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandMechaTaskDescPage"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "list/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "list/content/tpl"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "close")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.startTime = arg_6_1
	arg_6_0.nday = arg_6_2
	arg_6_0.taskGroup = arg_6_3

	arg_6_0:UpdateList()
	var_0_1.super.Show(arg_6_0)

	pg = var_4

	local var_6_0 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)

	pg = var_1

	local var_7_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf, arg_7_0._parentTf)

	return
end

function var_0_1.UpdateList(arg_8_0)
	local var_8_0 = arg_8_0.uiItemList

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0

		if not arg_8_0.taskGroup[arg_9_1 + 1] then
			var_9_0 = {}
		end

		ipairs = var_4

		for iter_9_0, iter_9_1 in var_4(var_9_0) do
			local var_9_1 = arg_8_0

			var_9.UpdateTask(var_9_1, arg_9_1 + 1, iter_9_1, arg_9_2:Find("tpl_" .. iter_9_0))
		end

		local var_9_2 = arg_9_1 + 1

		setText = var_5

		local var_9_3 = arg_9_2:Find("day")
		local var_9_4

		if not (var_9_2 < 10) or not ("0" .. var_9_2) then
			var_9_4 = var_9_2
		end

		var_5(var_9_3, var_9_4)

		return
	end)

	local var_8_1 = arg_8_0.uiItemList

	var_1.align(var_8_1, #arg_8_0.taskGroup)

	return
end

function var_0_1.GetDayDesc(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.startTime + arg_10_1 * 0

	pg = var_3

	local var_10_1 = var_3.TimeMgr.GetInstance()
	local var_10_2 = var_3.STimeDescS(var_10_1, var_10_0, "%Y/%m/%d/%H/%M/%S")

	string = var_1_10004

	return var_1_10004.split(var_10_2, "/")[2], var_4[3]
end

function var_0_1.UpdateTask(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_3 then
		return
	end

	IslandTask = var_1_10004

	local var_11_0 = var_1_10004.New({
		id = arg_11_2,
		process_list = {}
	})

	setText = var_1_10005

	var_1_10005(arg_11_3:Find("Text"), var_11_0:getConfig("task_desc"))

	IslandTaskActhelper = var_1_10005

	local var_11_1, var_11_2, var_11_3 = var_1_10005.GetIslandTaskState(arg_11_2)

	setText = var_8

	var_8(arg_11_3:Find("progress_1/Text"), var_11_1 .. "/" .. var_11_2)

	setFillAmount = var_8

	var_8(arg_11_3:Find("progress_1/bar"), var_11_1 / var_11_2)

	setActive = var_8

	var_8(arg_11_3:Find("lock"), arg_11_1 > arg_11_0.nday)

	local var_11_4 = var_11_0
	local var_11_5 = var_11_0.GetAwards(var_11_4)[1]
	local var_11_6 = arg_11_3:Find("InventoryTpl_1")

	updateCustomDrop = var_11_4

	var_11_4(var_11_6, var_11_5)

	onButton = var_11_4

	local var_11_7 = arg_11_0
	local var_11_8 = var_11_6

	local function var_11_9()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		IslandMediator = var_2_10003

		local var_12_2 = var_2_10003.SHOW_MSG_BOX
		local var_12_3 = {}

		i18n = var_2_10005
		var_12_3.title = var_2_10005("island_word_desc")
		IslandMsgBox = var_5
		var_12_3.type = var_5.TYPE_COMMON_DROP_DESCRIBE
		var_12_3.dropData = var_11_5

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end

	SFX_PANEL = var_1_10015

	var_11_4(var_11_7, var_11_8, var_11_9, var_1_10015)

	local var_11_10 = arg_11_0
	local var_11_11, var_11_12 = arg_11_0.GetDayDesc(var_11_10, arg_11_1 - 1)

	setText = var_11_10

	local var_11_13 = arg_11_3:Find("lock/Text")

	i18n = var_1_10015

	var_11_10(var_11_13, var_1_10015("island_mecha_task_lock_tip", var_11_11, var_11_12))

	setActive = var_11_10

	local var_11_14 = arg_11_3.parent

	var_11_10(var_14.Find(var_11_14, "finish"), var_11_3 == 2)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	if arg_13_0:isShowing() then
		arg_13_0:Hide()
	end

	return
end

return var_0_1
