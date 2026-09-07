local IslandTaskScene = class("IslandTaskScene", import("..base.BaseUI"))

IslandTaskScene.OPEN_SUBMIT = "open submit"
IslandTaskScene.ryza_task_tag_explore = "ryza_task_tag_explore"
IslandTaskScene.ryza_task_tag_battle = "ryza_task_tag_battle"
IslandTaskScene.ryza_task_tag_dalegate = "ryza_task_tag_dalegate"
IslandTaskScene.ryza_task_tag_develop = "ryza_task_tag_develop"
IslandTaskScene.ryza_task_tag_adventure = "ryza_task_tag_adventure"
IslandTaskScene.ryza_task_tag_build = "ryza_task_tag_build"
IslandTaskScene.ryza_task_tag_create = "ryza_task_tag_create"
IslandTaskScene.ryza_task_tag_daily = "ryza_task_tag_daily"
IslandTaskScene.add_tages = {
	IslandTaskScene.ryza_task_tag_explore,
	IslandTaskScene.ryza_task_tag_battle,
	IslandTaskScene.ryza_task_tag_dalegate,
	IslandTaskScene.ryza_task_tag_develop,
	IslandTaskScene.ryza_task_tag_adventure,
	IslandTaskScene.ryza_task_tag_build,
	IslandTaskScene.ryza_task_tag_create,
	IslandTaskScene.ryza_task_tag_daily
}
IslandTaskScene.ryza_task_detail_content = "ryza_task_detail_content"
IslandTaskScene.ryza_task_detail_award = "ryza_task_detail_award"
IslandTaskScene.ryza_task_confirm = "ryza_task_confirm"
IslandTaskScene.ryza_task_cancel = "ryza_task_cancel"
IslandTaskScene.sub_item_warning = "sub_item_warning"
IslandTaskScene.island_build_desc = "island_build_desc"
IslandTaskScene.island_history_desc = "island_history_desc"
IslandTaskScene.island_build_level = "island_build_level"
IslandTaskScene.icon_atlas = "ui/islandtaskicon_atlas"
IslandTaskScene.ui_atlas = "ui/islandtaskui_atlas"
IslandTaskScene.task_level_num = 5
IslandTaskScene.task_add_num = 4

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function IslandTaskScene:getUIName()
	return "IslandTaskUI"
end

function IslandTaskScene:init()
	self.activityId = ActivityConst.ISLAND_TASK_ID

	local var_2_0 = findTF(self._tf, "ad")

	self.btnBack = findTF(var_2_0, "btnBack")
	self.btnBuild = findTF(var_2_0, "leftBtns/btnBuild")
	self.btnTask = findTF(var_2_0, "leftBtns/btnTask")
	self.btnHistory = findTF(var_2_0, "leftBtns/btnHistory")
	self.taskPage = IslandTaskPage.New(findTF(var_2_0, "pages/taskPage"), self.contextData, findTF(var_2_0, "tpl"), self)
	self.buildPage = IslandBuildPage.New(findTF(var_2_0, "pages/buildPage"), self)
	self.historyPage = IslandHistoryPage.New(findTF(var_2_0, "pages/historyPage"), self)

	self.taskPage:setActive(false)
	self.buildPage:setActive(false)
	self.historyPage:setActive(false)

	self.submitPanel = findTF(findTF(self._tf, "pop"), "submitPanel")

	setActive(self.submitPanel, false)

	self.submitDisplayContent = findTF(self.submitPanel, "itemDisplay/viewport/content")
	self.submitConfirm = findTF(self.submitPanel, "btnComfirm")
	self.submitCancel = findTF(self.submitPanel, "btnCancel")
	self.subimtItem = findTF(self.submitPanel, "itemDisplay/viewport/content/item")
	self.submitItemDesc = findTF(self.submitPanel, "itemDesc")
	self.btnCancel = findTF(self.submitPanel, "btnCancel")

	setText(findTF(self.submitPanel, "btnComfirm/text"), i18n(IslandTaskScene.ryza_task_confirm))
	setText(findTF(self.submitPanel, "btnCancel/text"), i18n(IslandTaskScene.ryza_task_cancel))
	setText(findTF(self.submitPanel, "bg/text"), i18n(IslandTaskScene.sub_item_warning))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandTaskScene:didEnter()
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onToggle(self, self.btnBuild, function(arg_5_0)
		self:clearTagBtn()
		setActive(findTF(self.btnBuild, "bg"), not arg_5_0)
		setActive(findTF(self.btnBuild, "bg_selected"), arg_5_0)

		if arg_5_0 then
			self:showPage(var_0_3)
		end

		return
	end, SFX_CONFIRM)
	onToggle(self, self.btnTask, function(arg_6_0)
		self:clearTagBtn()
		setActive(findTF(self.btnTask, "bg"), not arg_6_0)
		setActive(findTF(self.btnTask, "bg_selected"), arg_6_0)

		if arg_6_0 then
			self:showPage(var_0_1)
		end

		return
	end, SFX_CONFIRM)
	onToggle(self, self.btnHistory, function(arg_7_0)
		self:clearTagBtn()
		setActive(findTF(self.btnHistory, "bg"), not arg_7_0)
		setActive(findTF(self.btnHistory, "bg_selected"), arg_7_0)

		if arg_7_0 then
			self:showPage(var_0_2)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.submitConfirm, function()
		self:emit(IslandTaskMediator.SUBMIT_TASK, {
			activityId = self.activityId,
			id = self.selectTask.id
		})
		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(self, self.submitCancel, function()
		setActive(self.submitPanel, false)

		return
	end, SOUND_BACK)
	self:bind(IslandTaskScene.OPEN_SUBMIT, function(arg_10_0, arg_10_1, arg_10_2)
		self:openSubmitPanel(arg_10_1)

		return
	end)
	triggerToggle(self.btnTask, true)

	return
end

function IslandTaskScene:clearTagBtn()
	setActive(findTF(self.btnBuild, "bg"), true)
	setActive(findTF(self.btnBuild, "bg_selected"), false)
	setActive(findTF(self.btnTask, "bg"), true)
	setActive(findTF(self.btnTask, "bg_selected"), false)
	setActive(findTF(self.btnHistory, "bg"), true)
	setActive(findTF(self.btnHistory, "bg_selected"), false)

	return
end

function IslandTaskScene:showPage(arg_12_1)
	self.taskPage:setActive(arg_12_1 == var_0_1)
	self.buildPage:setActive(arg_12_1 == var_0_3)
	self.historyPage:setActive(arg_12_1 == var_0_2)

	return
end

function IslandTaskScene:openSubmitPanel(arg_13_1)
	setActive(self.submitPanel, true)

	local var_13_0 = tonumber(arg_13_1:getConfig("target_id_2"))

	updateDrop(self.subimtItem, {
		type = DROP_TYPE_RYZA_DROP,
		id = tonumber(var_13_0),
		count = arg_13_1:getConfig("target_num")
	})
	setText(self.submitItemDesc, pg.activity_ryza_item[var_13_0].name)

	return
end

function IslandTaskScene:updateTask(arg_14_1)
	self.taskPage:updateTask(arg_14_1)

	return
end

function IslandTaskScene:willExit()
	self.taskPage:dispose()
	self.historyPage:dispose()
	self.buildPage:dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return IslandTaskScene
