class = var_0_10000

local var_0_0 = "BismarckChapterPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

var_0_1.tabPos = {
	[1] = 10,
	[2] = 182.3
}

local var_0_2 = {}

DROP_TYPE_SHIP = var_0_0
var_0_2[var_0_0] = function(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ship_data_statistics[arg_1_1].skin_id

	pg = var_1_10003

	local var_1_1 = var_1_10003.ship_skin_template[var_1_0].painting

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("SquareIcon/" .. var_1_1, "", arg_1_0)

	return
end
DROP_TYPE_FURNITURE = var_0_0
var_0_2[var_0_0] = function(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.furniture_data_template[arg_2_1]

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("furnitureicon/" .. var_2_0.icon, "", arg_2_0)

	return
end
var_0_1.IconShowFunc = var_0_2

local var_0_3 = {}

TASK_SUB_TYPE_COLLECT_SHIP = var_0_0
DROP_TYPE_SHIP = var_3
var_0_3[var_0_0] = var_3
TASK_SUB_TYPE_COLLECT_FURNITURE = var_0_0
DROP_TYPE_FURNITURE = var_3
var_0_3[var_0_0] = var_3
var_0_1.TransformType = var_0_3

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.bg = var_1.Find(var_3_0, "AD")
	arg_3_0.items = {}

	local var_3_1 = arg_3_0.items
	local var_3_2 = arg_3_0._tf

	var_3_1[1] = var_2.Find(var_3_2, "AD/Item1")

	local var_3_3 = arg_3_0.items
	local var_3_4 = arg_3_0._tf

	var_3_3[2] = var_2.Find(var_3_4, "AD/Item2")

	local var_3_5 = arg_3_0._tf

	arg_3_0.awardTF = var_1.Find(var_3_5, "AD/award")

	local var_3_6 = arg_3_0._tf

	arg_3_0.battleBtn = var_1.Find(var_3_6, "AD/battle_btn")

	local var_3_7 = arg_3_0._tf

	arg_3_0.shopBtn = var_1.Find(var_3_7, "AD/exchange_btn")

	local var_3_8 = arg_3_0._tf

	arg_3_0.buildBtn = var_1.Find(var_3_8, "AD/build_btn")

	local var_3_9 = arg_3_0._tf

	arg_3_0.tab = var_1.Find(var_3_9, "tab")

	local var_3_10 = arg_3_0._tf

	arg_3_0.bar = var_1.Find(var_3_10, "bar")

	local var_3_11 = arg_3_0.tab

	arg_3_0.scrollList = var_1.Find(var_3_11, "Scroll View")

	local var_3_12 = arg_3_0.scrollList

	arg_3_0.content = var_1.Find(var_3_12, "Content")

	local var_3_13 = arg_3_0.tab

	arg_3_0.listTmpl = var_1.Find(var_3_13, "listitem")
	UIItemList = var_1
	arg_3_0.taskList = var_1.New(arg_3_0.content, arg_3_0.listTmpl)
	arg_3_0.finalTasks = {}
	arg_3_0.subtasks = {}
	arg_3_0.tabType = 0

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	Clone = var_1_10001

	local var_4_0 = arg_4_0.activity

	arg_4_0.finalTasks = var_1_10001(var_3.getConfig(var_4_0, "config_client"))

	local var_4_1 = arg_4_0.finalTasks

	_ = var_1_10002

	var_1_10002.each(var_4_1, function(arg_5_0)
		pg = var_2_10001

		if var_2_10001.task_data_template[arg_5_0] and var_1.target_id then
			table = var_2_10003

			local var_5_0 = var_2_10003.insert
			local var_5_1 = arg_4_0.subtasks

			Clone = var_2_10006

			var_5_0(var_5_1, var_2_10006(var_2))
		end

		return
	end)

	setText = var_2

	local var_4_2 = arg_4_0.bg
	local var_4_3 = var_4.Find(var_4_2, "desc")

	i18n = var_5

	var_2(var_4_3, var_5("bismarck_chapter_desc"))
	arg_4_0:SubimtCompletedMission()
	arg_4_0:InitInteractable()

	return
end

function var_0_1.InitInteractable(arg_6_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.finalTasks) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.task_data_template[iter_6_1]

		local var_6_1 = arg_6_0.items[iter_6_0]

		onButton = var_1_10009

		local var_6_2 = arg_6_0
		local var_6_3 = var_6_1

		local function var_6_4()
			local var_7_0 = var_6_0
			local var_7_1 = var_0.getTaskVO(var_7_0, iter_6_1)

			if var_0.getTaskStatus(var_7_1) == 1 then
				local var_7_2 = arg_6_0
				local var_7_3 = var_1.emit

				ActivityMediator = var_2_10004

				var_7_3(var_7_2, var_2_10004.ON_TASK_SUBMIT, var_0)

				return
			end

			if arg_6_0.tabType == iter_6_0 then
				return
			end

			arg_6_0.tabType = iter_6_0

			local var_7_4 = arg_6_0

			var_1.UpdateTab(var_7_4)

			return
		end

		SFX_PANEL = var_1_10014

		var_1_10009(var_6_2, var_6_3, var_6_4, var_1_10014)
	end

	onButton = var_2

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.battleBtn

	local function var_6_7()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_6_5, var_6_6, var_6_7, var_1_10007)

	onButton = var_2

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.shopBtn

	local function var_6_10()
		configClinet = var_2_10000

		if var_2_10000.shopLinkActID then
			getProxy = var_9_0
			ActivityProxy = var_2_10002
			var_2_10002 = var_9_0(var_2_10002)

			local var_9_0 = var_9_0.getActivitiesById

			configClinet = var_2_10003

			if not var_9_0(var_2_10002, var_2_10003.shopLinkActID) then
				underscore = var_9_0
				var_9_0 = var_9_0.detect
				getProxy = var_2_10002
				ActivityProxy = var_2_10004
				var_2_10004 = var_2_10002(var_2_10004)

				local var_9_1 = var_2.getActivitiesByType

				ActivityConst = var_2_10005
				var_9_0 = var_9_0(var_9_1(var_2_10004, var_2_10005.ACTIVITY_TYPE_SHOP), function(arg_10_0)
					return not arg_10_0:isEnd()
				end)
			end

			if not var_9_0 or var_9_0:isEnd() then
				pg = var_2_10001

				local var_9_2 = var_2_10001.TipsMgr.GetInstance()
				local var_9_3 = var_1.ShowTips

				i18n = var_2_10004

				var_9_3(var_9_2, var_2_10004("common_activity_end"))

				return
			end

			local var_9_4 = arg_6_0
			local var_9_5 = var_1.emit

			ActivityMediator = var_2_10004

			local var_9_6 = var_2_10004.GO_SHOPS_LAYER
			local var_9_7 = {}

			NewShopsScene = var_2_10006
			var_9_7.warp = var_2_10006.TYPE_ACTIVITY
			var_9_7.actId = var_9_0.id

			var_9_5(var_9_4, var_9_6, var_9_7)

			return
		end
	end

	SFX_PANEL = var_1_10007

	var_2(var_6_8, var_6_9, var_6_10, var_1_10007)

	onButton = var_2

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.buildBtn

	local function var_6_13()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_11_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_11_3 = var_2_10004.GETBOAT
		local var_11_4 = {}

		BuildShipScene = var_2_10006
		var_11_4.projectName = var_2_10006.PROJECTS.ACTIVITY

		var_11_1(var_11_0, var_11_2, var_11_3, var_11_4)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_6_11, var_6_12, var_6_13, var_1_10007)

	onButton = var_2

	var_2(arg_6_0, arg_6_0.bg, function()
		if arg_6_0.tabType > 0 then
			arg_6_0.tabType = 0

			local var_12_0 = arg_6_0

			var_0.UpdateTab(var_12_0)
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_13_0)
	arg_13_0:UpdateView()
	arg_13_0:UpdateTab()

	return
end

function var_0_1.UpdateView(arg_14_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	for iter_14_0 = 1, #arg_14_0.finalTasks do
		var_1_10006 = arg_14_0.finalTasks[iter_14_0]
		pg = var_1_10007
		var_1_10007 = var_1_10007.task_data_template[var_1_10006]

		local var_14_1 = arg_14_0.items[iter_14_0]

		setActive = var_1_10009

		var_1_10009(var_14_1, true)

		var_1_10009 = var_1_10007.award_display[1]

		arg_14_0:UpdateIcon(var_14_1:Find("icon"), var_1_10009[1], var_1_10009[2])

		local var_14_2 = var_14_0
		local var_14_3 = var_14_0.getTaskVO(var_14_2, var_1_10006)
		local var_14_4 = var_10.getTaskStatus(var_14_3)

		setActive = var_14_2

		var_14_2(var_14_1:Find("active"), var_14_4 == 0)

		setActive = var_14_2

		var_14_2(var_14_1:Find("finished"), var_14_4 == 1)

		setActive = var_14_2

		var_14_2(var_14_1:Find("achieved"), var_14_4 == 2)

		setButtonEnabled = var_14_2

		var_14_2(var_14_1, var_14_4 < 2)

		arg_14_0.tabType = arg_14_0.tabType == iter_14_0 and var_14_4 == 2 and 0 or arg_14_0.tabType
	end

	for iter_14_1 = #arg_14_0.finalTasks + 1, #arg_14_0.items do
		setActive = var_1_10006

		var_1_10006(arg_14_0.items[iter_14_1], false)

		var_1_10006 = arg_14_0.tabType == iter_14_1 and 0 or arg_14_0.tabType
		arg_14_0.tabType = var_1_10006
	end

	return
end

function var_0_1.UpdateTab(arg_15_0)
	if arg_15_0.tabType == 0 then
		setActive = var_1

		var_1(arg_15_0.tab, false)

		return
	end

	local var_15_0 = #arg_15_0.subtasks[arg_15_0.tabType]
	local var_15_1 = arg_15_0.taskList

	var_3.align(var_15_1, var_15_0)

	getProxy = var_3
	TaskProxy = var_15_1

	local var_15_2 = var_3(var_15_1)
	local var_15_3 = 0

	for iter_15_0 = 1, var_15_0 do
		local var_15_4 = arg_15_0.content
		local var_15_5 = var_9.GetChild(var_15_4, iter_15_0 - 1)

		setText = var_1_10010

		local var_15_6 = var_15_5:Find("title/Text")

		string = var_1_10013

		var_1_10010(var_15_6, var_1_10013.format("Task-%02d", iter_15_0))

		var_1_10010 = var_1[iter_15_0]
		pg = var_15_4

		local var_15_7 = var_15_4.task_data_template[var_1_10010]

		tonumber = var_15_6

		local var_15_8 = var_15_6(var_15_7.target_id)

		var_1_10013 = var_0_1.TransformType[var_15_7.sub_type]
		setActive = var_14

		local var_15_9 = var_15_5:Find("tip2")

		DROP_TYPE_FURNITURE = var_1_10017
		var_1_10017 = var_1_10013 == var_1_10017

		var_14(var_15_9, var_1_10017)

		setActive = var_14

		local var_15_10 = var_15_5:Find("tip")

		DROP_TYPE_SHIP = var_1_10017
		var_1_10017 = var_1_10013 == var_1_10017

		var_14(var_15_10, var_1_10017)

		local var_15_11 = false

		var_1_10017 = var_15_2

		local var_15_12

		if not var_15_2.getTaskById(var_1_10017, var_1_10010) then
			var_1_10017 = var_15_2
			var_15_12 = var_15_2.getFinishTaskById(var_1_10017, var_1_10010)
		end

		setActive = var_15_10

		local var_15_13 = var_15_5:Find("completed")

		defaultValue = var_19

		var_15_10(var_15_13, var_19(var_15_12 and var_15_12:isFinish(), false))

		setText = var_15_10

		var_15_10(var_15_5:Find("text"), var_15_7.desc)
		arg_15_0:UpdateIcon(var_15_5:Find("icon"), var_1_10013, var_15_8)

		var_15_3 = var_15_3 + (var_15_12 and var_15_12:isFinish() and 1 or 0)
	end

	setText = var_5

	local var_15_14 = arg_15_0.tab
	local var_15_15 = var_7.Find(var_15_14, "slider/progress")

	string = iter_15_0

	var_5(var_15_15, iter_15_0.format("[%d/%d]", var_15_3, var_15_0))

	local var_15_16 = arg_15_0.scrollList
	local var_15_17 = var_5.GetComponent

	typeof = var_8
	ScrollRect = var_10
	var_15_17(var_15_16, var_8(var_10)).verticalNormalizedPosition = 1

	local var_15_18 = arg_15_0.tab.transform.anchoredPosition
	local var_15_19 = arg_15_0.tab.sizeDelta

	var_15_18.x = var_0_1.tabPos[arg_15_0.tabType]
	setAnchoredPosition = var_7

	var_7(arg_15_0.tab, var_15_18)

	local var_15_20

	var_15_20.x, var_15_20 = arg_15_0._tf.sizeDelta.x - arg_15_0.bar.anchoredPosition.x - var_15_18.x - var_15_19.x, arg_15_0.bar.sizeDelta

	local var_15_21 = arg_15_0.bar

	var_15_21.sizeDelta = var_15_20
	setActive = var_15_21

	var_15_21(arg_15_0.tab, true)

	return
end

function var_0_1.UpdateIcon(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if var_0_1.IconShowFunc[arg_16_2] then
		var_0_1.IconShowFunc[arg_16_2](arg_16_1, arg_16_3)
	end

	return
end

function var_0_1.OnDestroy(arg_17_0)
	return
end

function var_0_1.SubimtCompletedMission(arg_18_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)

	pairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.subtasks) do
		pairs = var_1_10007

		for iter_18_2, iter_18_3 in var_1_10007(iter_18_1) do
			if var_18_0:getTaskById(iter_18_3) and var_12:isFinish() then
				local var_18_1 = arg_18_0
				local var_18_2 = arg_18_0.emit

				ActivityMediator = var_1_10016

				var_18_2(var_18_1, var_1_10016.ON_TASK_SUBMIT, var_12)
			end
		end
	end

	return
end

return var_0_1
