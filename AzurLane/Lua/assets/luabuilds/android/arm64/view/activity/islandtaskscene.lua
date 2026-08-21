local var_0_0 = class("IslandTaskScene", import("..base.BaseUI"))

var_0_0.OPEN_SUBMIT = "open submit"
var_0_0.ryza_task_tag_explore = "ryza_task_tag_explore"
var_0_0.ryza_task_tag_battle = "ryza_task_tag_battle"
var_0_0.ryza_task_tag_dalegate = "ryza_task_tag_dalegate"
var_0_0.ryza_task_tag_develop = "ryza_task_tag_develop"
var_0_0.ryza_task_tag_adventure = "ryza_task_tag_adventure"
var_0_0.ryza_task_tag_build = "ryza_task_tag_build"
var_0_0.ryza_task_tag_create = "ryza_task_tag_create"
var_0_0.ryza_task_tag_daily = "ryza_task_tag_daily"
var_0_0.add_tages = {
	var_0_0.ryza_task_tag_explore,
	var_0_0.ryza_task_tag_battle,
	var_0_0.ryza_task_tag_dalegate,
	var_0_0.ryza_task_tag_develop,
	var_0_0.ryza_task_tag_adventure,
	var_0_0.ryza_task_tag_build,
	var_0_0.ryza_task_tag_create,
	var_0_0.ryza_task_tag_daily
}
var_0_0.ryza_task_detail_content = "ryza_task_detail_content"
var_0_0.ryza_task_detail_award = "ryza_task_detail_award"
var_0_0.ryza_task_confirm = "ryza_task_confirm"
var_0_0.ryza_task_cancel = "ryza_task_cancel"
var_0_0.sub_item_warning = "sub_item_warning"
var_0_0.island_build_desc = "island_build_desc"
var_0_0.island_history_desc = "island_history_desc"
var_0_0.island_build_level = "island_build_level"
var_0_0.icon_atlas = "ui/islandtaskicon_atlas"
var_0_0.ui_atlas = "ui/islandtaskui_atlas"
var_0_0.task_level_num = 5
var_0_0.task_add_num = 4

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.getUIName(arg_1_0)
	return "IslandTaskUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.activityId = ActivityConst.ISLAND_TASK_ID

	local var_2_0 = findTF(arg_2_0._tf, "ad")

	arg_2_0.btnBack = findTF(var_2_0, "btnBack")
	arg_2_0.btnBuild = findTF(var_2_0, "leftBtns/btnBuild")
	arg_2_0.btnTask = findTF(var_2_0, "leftBtns/btnTask")
	arg_2_0.btnHistory = findTF(var_2_0, "leftBtns/btnHistory")
	arg_2_0.taskPage = IslandTaskPage.New(findTF(var_2_0, "pages/taskPage"), arg_2_0.contextData, findTF(var_2_0, "tpl"), arg_2_0)
	arg_2_0.buildPage = IslandBuildPage.New(findTF(var_2_0, "pages/buildPage"), arg_2_0)
	arg_2_0.historyPage = IslandHistoryPage.New(findTF(var_2_0, "pages/historyPage"), arg_2_0)

	arg_2_0.taskPage:setActive(false)
	arg_2_0.buildPage:setActive(false)
	arg_2_0.historyPage:setActive(false)

	arg_2_0.submitPanel = findTF(findTF(arg_2_0._tf, "pop"), "submitPanel")

	setActive(arg_2_0.submitPanel, false)

	arg_2_0.submitDisplayContent = findTF(arg_2_0.submitPanel, "itemDisplay/viewport/content")
	arg_2_0.submitConfirm = findTF(arg_2_0.submitPanel, "btnComfirm")
	arg_2_0.submitCancel = findTF(arg_2_0.submitPanel, "btnCancel")
	arg_2_0.subimtItem = findTF(arg_2_0.submitPanel, "itemDisplay/viewport/content/item")
	arg_2_0.submitItemDesc = findTF(arg_2_0.submitPanel, "itemDesc")
	arg_2_0.btnCancel = findTF(arg_2_0.submitPanel, "btnCancel")

	setText(findTF(arg_2_0.submitPanel, "btnComfirm/text"), i18n(var_0_0.ryza_task_confirm))
	setText(findTF(arg_2_0.submitPanel, "btnCancel/text"), i18n(var_0_0.ryza_task_cancel))
	setText(findTF(arg_2_0.submitPanel, "bg/text"), i18n(var_0_0.sub_item_warning))
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.btnBack, function()
		arg_3_0:closeView()

		return
	end, SOUND_BACK)
	onToggle(arg_3_0, arg_3_0.btnBuild, function(arg_5_0)
		arg_3_0:clearTagBtn()
		setActive(findTF(arg_3_0.btnBuild, "bg"), not arg_5_0)
		setActive(findTF(arg_3_0.btnBuild, "bg_selected"), arg_5_0)

		if arg_5_0 then
			arg_3_0:showPage(var_0_3)
		end

		return
	end, SFX_CONFIRM)
	onToggle(arg_3_0, arg_3_0.btnTask, function(arg_6_0)
		arg_3_0:clearTagBtn()
		setActive(findTF(arg_3_0.btnTask, "bg"), not arg_6_0)
		setActive(findTF(arg_3_0.btnTask, "bg_selected"), arg_6_0)

		if arg_6_0 then
			arg_3_0:showPage(var_0_1)
		end

		return
	end, SFX_CONFIRM)
	onToggle(arg_3_0, arg_3_0.btnHistory, function(arg_7_0)
		arg_3_0:clearTagBtn()
		setActive(findTF(arg_3_0.btnHistory, "bg"), not arg_7_0)
		setActive(findTF(arg_3_0.btnHistory, "bg_selected"), arg_7_0)

		if arg_7_0 then
			arg_3_0:showPage(var_0_2)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, arg_3_0.submitConfirm, function()
		arg_3_0:emit(IslandTaskMediator.SUBMIT_TASK, {
			activityId = arg_3_0.activityId,
			id = arg_3_0.selectTask.id
		})
		setActive(arg_3_0.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_3_0, arg_3_0.submitCancel, function()
		setActive(arg_3_0.submitPanel, false)

		return
	end, SOUND_BACK)
	arg_3_0:bind(IslandTaskScene.OPEN_SUBMIT, function(arg_10_0, arg_10_1, arg_10_2)
		arg_3_0:openSubmitPanel(arg_10_1)

		return
	end)
	triggerToggle(arg_3_0.btnTask, true)

	return
end

function var_0_0.clearTagBtn(arg_11_0)
	setActive(findTF(arg_11_0.btnBuild, "bg"), true)
	setActive(findTF(arg_11_0.btnBuild, "bg_selected"), false)
	setActive(findTF(arg_11_0.btnTask, "bg"), true)
	setActive(findTF(arg_11_0.btnTask, "bg_selected"), false)
	setActive(findTF(arg_11_0.btnHistory, "bg"), true)
	setActive(findTF(arg_11_0.btnHistory, "bg_selected"), false)

	return
end

function var_0_0.showPage(arg_12_0, arg_12_1)
	arg_12_0.taskPage:setActive(arg_12_1 == var_0_1)
	arg_12_0.buildPage:setActive(arg_12_1 == var_0_3)
	arg_12_0.historyPage:setActive(arg_12_1 == var_0_2)

	return
end

function var_0_0.openSubmitPanel(arg_13_0, arg_13_1)
	setActive(arg_13_0.submitPanel, true)

	local var_13_0 = tonumber(arg_13_1:getConfig("target_id_2"))

	updateDrop(arg_13_0.subimtItem, {
		type = DROP_TYPE_RYZA_DROP,
		id = tonumber(var_13_0),
		count = arg_13_1:getConfig("target_num")
	})
	setText(arg_13_0.submitItemDesc, pg.activity_ryza_item[var_13_0].name)

	return
end

function var_0_0.updateTask(arg_14_0, arg_14_1)
	arg_14_0.taskPage:updateTask(arg_14_1)

	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0.taskPage:dispose()
	arg_15_0.historyPage:dispose()
	arg_15_0.buildPage:dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf)

	return
end

return var_0_0
