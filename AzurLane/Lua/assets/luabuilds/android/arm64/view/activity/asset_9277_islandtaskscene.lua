class = var_0_10000

local var_0_0 = "IslandTaskScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.OPEN_SUBMIT = "open submit"
var_0_1.ryza_task_tag_explore = "ryza_task_tag_explore"
var_0_1.ryza_task_tag_battle = "ryza_task_tag_battle"
var_0_1.ryza_task_tag_dalegate = "ryza_task_tag_dalegate"
var_0_1.ryza_task_tag_develop = "ryza_task_tag_develop"
var_0_1.ryza_task_tag_adventure = "ryza_task_tag_adventure"
var_0_1.ryza_task_tag_build = "ryza_task_tag_build"
var_0_1.ryza_task_tag_create = "ryza_task_tag_create"
var_0_1.ryza_task_tag_daily = "ryza_task_tag_daily"
var_0_1.add_tages = {
	var_0_1.ryza_task_tag_explore,
	var_0_1.ryza_task_tag_battle,
	var_0_1.ryza_task_tag_dalegate,
	var_0_1.ryza_task_tag_develop,
	var_0_1.ryza_task_tag_adventure,
	var_0_1.ryza_task_tag_build,
	var_0_1.ryza_task_tag_create,
	var_0_1.ryza_task_tag_daily
}
var_0_1.ryza_task_detail_content = "ryza_task_detail_content"
var_0_1.ryza_task_detail_award = "ryza_task_detail_award"
var_0_1.ryza_task_confirm = "ryza_task_confirm"
var_0_1.ryza_task_cancel = "ryza_task_cancel"
var_0_1.sub_item_warning = "sub_item_warning"
var_0_1.island_build_desc = "island_build_desc"
var_0_1.island_history_desc = "island_history_desc"
var_0_1.island_build_level = "island_build_level"
var_0_1.icon_atlas = "ui/islandtaskicon_atlas"
var_0_1.ui_atlas = "ui/islandtaskui_atlas"
var_0_1.task_level_num = 5
var_0_1.task_add_num = 4

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.getUIName(arg_1_0)
	return "IslandTaskUI"
end

function var_0_1.init(arg_2_0)
	ActivityConst = var_1_10001
	arg_2_0.activityId = var_1_10001.ISLAND_TASK_ID
	findTF = var_1

	local var_2_0 = var_1(arg_2_0._tf, "ad")

	findTF = var_1_10002
	arg_2_0.btnBack = var_1_10002(var_2_0, "btnBack")
	findTF = var_2
	arg_2_0.btnBuild = var_2(var_2_0, "leftBtns/btnBuild")
	findTF = var_2
	arg_2_0.btnTask = var_2(var_2_0, "leftBtns/btnTask")
	findTF = var_2
	arg_2_0.btnHistory = var_2(var_2_0, "leftBtns/btnHistory")
	IslandTaskPage = var_2

	local var_2_1 = var_2.New

	findTF = var_4

	local var_2_2 = var_4(var_2_0, "pages/taskPage")
	local var_2_3 = arg_2_0.contextData

	findTF = var_6
	arg_2_0.taskPage = var_2_1(var_2_2, var_2_3, var_6(var_2_0, "tpl"), arg_2_0)
	IslandBuildPage = var_2

	local var_2_4 = var_2.New

	findTF = var_2_2
	arg_2_0.buildPage = var_2_4(var_2_2(var_2_0, "pages/buildPage"), arg_2_0)
	IslandHistoryPage = var_2

	local var_2_5 = var_2.New

	findTF = var_4
	arg_2_0.historyPage = var_2_5(var_4(var_2_0, "pages/historyPage"), arg_2_0)

	local var_2_6 = arg_2_0.taskPage

	var_2.setActive(var_2_6, false)

	local var_2_7 = arg_2_0.buildPage

	var_2.setActive(var_2_7, false)

	local var_2_8 = arg_2_0.historyPage

	var_2.setActive(var_2_8, false)

	findTF = var_2

	local var_2_9 = var_2(arg_2_0._tf, "pop")

	findTF = var_3
	arg_2_0.submitPanel = var_3(var_2_9, "submitPanel")
	setActive = var_3

	var_3(arg_2_0.submitPanel, false)

	findTF = var_3
	arg_2_0.submitDisplayContent = var_3(arg_2_0.submitPanel, "itemDisplay/viewport/content")
	findTF = var_3
	arg_2_0.submitConfirm = var_3(arg_2_0.submitPanel, "btnComfirm")
	findTF = var_3
	arg_2_0.submitCancel = var_3(arg_2_0.submitPanel, "btnCancel")
	findTF = var_3
	arg_2_0.subimtItem = var_3(arg_2_0.submitPanel, "itemDisplay/viewport/content/item")
	findTF = var_3
	arg_2_0.submitItemDesc = var_3(arg_2_0.submitPanel, "itemDesc")
	findTF = var_3
	arg_2_0.btnCancel = var_3(arg_2_0.submitPanel, "btnCancel")
	setText = var_3
	findTF = var_5

	local var_2_10 = var_5(arg_2_0.submitPanel, "btnComfirm/text")

	i18n = var_6

	var_3(var_2_10, var_6(var_0_1.ryza_task_confirm))

	setText = var_3
	findTF = var_2_10

	local var_2_11 = var_2_10(arg_2_0.submitPanel, "btnCancel/text")

	i18n = var_6

	var_3(var_2_11, var_6(var_0_1.ryza_task_cancel))

	setText = var_3
	findTF = var_2_11

	local var_2_12 = var_2_11(arg_2_0.submitPanel, "bg/text")

	i18n = var_6

	var_3(var_2_12, var_6(var_0_1.sub_item_warning))

	pg = var_3

	local var_2_13 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_2_13, arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.btnBack

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onToggle = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.btnBuild

	local function var_3_5(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.clearTagBtn(var_5_0)

		setActive = var_1
		findTF = var_5_0

		var_1(var_5_0(arg_3_0.btnBuild, "bg"), not arg_5_0)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_3_0.btnBuild, "bg_selected"), arg_5_0)

		if arg_5_0 then
			local var_5_1 = arg_3_0

			var_1.showPage(var_5_1, var_0_4)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.btnTask

	local function var_3_8(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.clearTagBtn(var_6_0)

		setActive = var_1
		findTF = var_6_0

		var_1(var_6_0(arg_3_0.btnTask, "bg"), not arg_6_0)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_3_0.btnTask, "bg_selected"), arg_6_0)

		if arg_6_0 then
			local var_6_1 = arg_3_0

			var_1.showPage(var_6_1, var_0_2)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onToggle = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.btnHistory

	local function var_3_11(arg_7_0)
		local var_7_0 = arg_3_0

		var_1.clearTagBtn(var_7_0)

		setActive = var_1
		findTF = var_7_0

		var_1(var_7_0(arg_3_0.btnHistory, "bg"), not arg_7_0)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_3_0.btnHistory, "bg_selected"), arg_7_0)

		if arg_7_0 then
			local var_7_1 = arg_3_0

			var_1.showPage(var_7_1, var_0_3)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.submitConfirm

	local function var_3_14()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		IslandTaskMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.SUBMIT_TASK, {
			activityId = arg_3_0.activityId,
			id = arg_3_0.selectTask.id
		})

		setActive = var_8_1

		var_8_1(arg_3_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.submitCancel

	local function var_3_17()
		setActive = var_2_10000

		var_2_10000(arg_3_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.bind

	IslandTaskScene = var_3_16

	var_3_19(var_3_18, var_3_16.OPEN_SUBMIT, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_3_0

		var_3.openSubmitPanel(var_10_0, arg_10_1)

		return
	end)

	triggerToggle = var_3_19

	var_3_19(arg_3_0.btnTask, true)

	return
end

function var_0_1.clearTagBtn(arg_11_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_11_0.btnBuild, "bg"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_11_0.btnBuild, "bg_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_11_0.btnTask, "bg"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_11_0.btnTask, "bg_selected"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_11_0.btnHistory, "bg"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_11_0.btnHistory, "bg_selected"), false)

	return
end

function var_0_1.showPage(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.taskPage

	var_2.setActive(var_12_0, arg_12_1 == var_0_2)

	local var_12_1 = arg_12_0.buildPage

	var_2.setActive(var_12_1, arg_12_1 == var_0_4)

	local var_12_2 = arg_12_0.historyPage

	var_2.setActive(var_12_2, arg_12_1 == var_0_3)

	return
end

function var_0_1.openSubmitPanel(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0.submitPanel, true)

	tonumber = var_1_10002

	local var_13_0 = var_1_10002(arg_13_1:getConfig("target_id_2"))

	pg = var_1_10003

	local var_13_1 = var_1_10003.activity_ryza_item[var_13_0].name

	updateDrop = var_4

	local var_13_2 = arg_13_0.subimtItem
	local var_13_3 = {}

	DROP_TYPE_RYZA_DROP = var_1_10008
	var_13_3.type = var_1_10008
	tonumber = var_1_10008
	var_13_3.id = var_1_10008(var_13_0)
	var_13_3.count = arg_13_1:getConfig("target_num")

	var_4(var_13_2, var_13_3)

	setText = var_4

	var_4(arg_13_0.submitItemDesc, var_13_1)

	return
end

function var_0_1.updateTask(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.taskPage

	var_2.updateTask(var_14_0, arg_14_1)

	return
end

function var_0_1.willExit(arg_15_0)
	local var_15_0 = arg_15_0.taskPage

	var_1.dispose(var_15_0)

	local var_15_1 = arg_15_0.historyPage

	var_1.dispose(var_15_1)

	local var_15_2 = arg_15_0.buildPage

	var_1.dispose(var_15_2)

	pg = var_1

	local var_15_3 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_3, arg_15_0._tf)

	return
end

return var_0_1
