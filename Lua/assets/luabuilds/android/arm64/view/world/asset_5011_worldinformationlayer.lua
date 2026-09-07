local WorldInformationLayer = class("WorldInformationLayer", import("..base.BaseUI"))

function WorldInformationLayer:getUIName()
	return "WorldInformationUI"
end

WorldInformationLayer.Listeners = {
	onUpdateDailyTask = "OnUpdateDailyTask",
	onUpdateTask = "OnUpdateTask"
}

function WorldInformationLayer:init()
	for iter_2_0, iter_2_1 in pairs(WorldInformationLayer.Listeners) do
		self[iter_2_0] = function(...)
			WorldInformationLayer[iter_2_1](self, ...)

			return
		end
	end

	self.rtLeftPanel = self._tf:Find("adapt/left_panel")

	setText(self.rtLeftPanel:Find("title/Text"), i18n("world_map_title_tips"))
	setText(self.rtLeftPanel:Find("title/Text_en"), i18n("world_map_title_tips_en"))

	self.wsWorldInfo = WSWorldInfo.New()
	self.wsWorldInfo.transform = self.rtLeftPanel:Find("world_info")

	self.wsWorldInfo:Setup()
	setText(self.wsWorldInfo.transform:Find("power/bg/Word"), i18n("world_total_power"))
	setText(self.wsWorldInfo.transform:Find("explore/mileage/Text"), i18n("world_mileage"))
	setText(self.wsWorldInfo.transform:Find("explore/pressing/Text"), i18n("world_pressing"))

	self.rtRightPanel = self._tf:Find("adapt/right_panel")
	self.rtNothingTip = self.rtRightPanel:Find("nothing_tip")
	self.btnClose = self.rtRightPanel:Find("title/close_btn")
	self.toggleAll = self.rtRightPanel:Find("title/task_all")
	self.toggleMain = self.rtRightPanel:Find("title/task_main")
	self.rtContainer = self.rtRightPanel:Find("main/viewport/content")
	self.taskItemList = UIItemList.New(self.rtContainer, self.rtContainer:Find("task_tpl"))

	self.taskItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateTaskTpl(arg_4_2, self.filterTaskList[arg_4_1 + 1])
		end

		return
	end)

	self.btnDailyTask = self.rtLeftPanel:Find("world_info/task_btn")

	return
end

function WorldInformationLayer:didEnter()
	onButton(self, self.btnClose, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		triggerButton(self.btnClose)

		return
	end, SFX_CANCEL)
	onToggle(self, self.toggleAll, function(arg_8_0)
		if arg_8_0 then
			self.filterType = nil

			self:UpdateFilterTaskList()
		end

		setTextColor(self.toggleAll, (arg_8_0 or nil) and (Color.white or Color.New(0.48627450980392156, 0.5215686274509804, 0.6431372549019608)))

		return
	end, SFX_PANEL)
	onToggle(self, self.toggleMain, function(arg_9_0)
		if arg_9_0 then
			self.filterType = 0

			self:UpdateFilterTaskList()
		end

		setTextColor(self.toggleMain, (arg_9_0 or nil) and (Color.white or Color.New(0.48627450980392156, 0.5215686274509804, 0.6431372549019608)))

		return
	end, SFX_PANEL)
	onButton(self, self.btnDailyTask, function()
		if nowWorld():IsSystemOpen(WorldConst.SystemDailyTask) then
			self:emit(WorldInformationMediator.OnOpenDailyTaskPanel)
		else
			pg.TipsMgr.GetInstance(i18n("world_daily_task_lock"))
		end

		return
	end, SFX_PANEL)
	self:OnUpdateDailyTask()
	triggerToggle(self.toggleAll, true)
	self:BlurPanel(self._tf)

	return
end

function WorldInformationLayer:willExit()
	self:UnOverlayPanel(self._tf)
	self.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, self.onUpdateTask)
	self.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateDailyTaskIds, self.onUpdateDailyTask)
	self.wsWorldInfo:Dispose()

	return
end

function WorldInformationLayer:setWorldTaskProxy(arg_12_1)
	self.taskProxy = arg_12_1

	self.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, self.onUpdateTask)
	self.taskProxy:AddListener(WorldTaskProxy.EventUpdateDailyTaskIds, self.onUpdateDailyTask)

	self.taskList = self.taskProxy:getDoingTaskVOs()

	return
end

function WorldInformationLayer:UpdateFilterTaskList()
	self.filterTaskList = _.filter(self.taskList, function(arg_14_0)
		return not self.filterType or arg_14_0.config.type == self.filterType
	end)

	table.sort(self.filterTaskList, CompareFuncs(WorldTask.sortDic))
	self.taskItemList:align(#self.filterTaskList)
	setActive(self.rtNothingTip, #self.filterTaskList == 0)

	return
end

function WorldInformationLayer:UpdateTaskTpl(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:Find("base_panel")

	GetImageSpriteFromAtlasAsync("ui/worldtaskfloatui_atlas", pg.WorldToastMgr.Type2PictrueName[arg_15_2.config.type], var_15_0:Find("type"), true)
	setText(var_15_0:Find("extend_show/title/Text"), arg_15_2.config.name)
	setText(var_15_0:Find("base_show/title/Text"), arg_15_2.config.name)
	setText(var_15_0:Find("base_show/desc"), arg_15_2.config.description)

	local var_15_1 = var_15_0:Find("base_show/IconTpl")
	local var_15_2 = var_15_0:Find("base_show/award")

	removeAllChildren(var_15_2)

	for iter_15_0 = 1, math.min(#arg_15_2.config.show, 2) do
		local var_15_3 = cloneTplTo(var_15_1, var_15_2)
		local var_15_4 = {
			type = arg_15_2.config.show[iter_15_0][1],
			id = arg_15_2.config.show[iter_15_0][2],
			count = arg_15_2.config.show[iter_15_0][3]
		}

		updateDrop(var_15_3, var_15_4)
		onButton(self, var_15_3, function()
			self:emit(WorldInformationLayer.ON_DROP, var_15_4)

			return
		end, SFX_PANEL)
		setActive(var_15_3, true)
	end

	setActive(var_15_1, false)
	setSlider(var_15_0:Find("base_show/title/progress"), 0, arg_15_2:getMaxProgress(), arg_15_2:getProgress())

	local var_15_5 = var_15_0:Find("btn_go")

	onButton(self, var_15_5, function()
		self:emit(WorldInformationMediator.OnTaskGoto, arg_15_2.id)
		self:closeView()

		return
	end, SFX_PANEL)
	setButtonEnabled(var_15_5, tobool(arg_15_2:GetFollowingAreaId() or arg_15_2:GetFollowingEntrance()))

	local var_15_6 = var_15_0:Find("btn_get")

	onButton(self, var_15_6, function()
		self:emit(WorldInformationMediator.OnSubmitTask, arg_15_2)

		return
	end, SFX_CONFIRM)

	local var_15_7 = arg_15_2:getState()

	setActive(var_15_5, var_15_7 == WorldTask.STATE_ONGOING)
	setActive(var_15_6, var_15_7 == WorldTask.STATE_FINISHED)

	local var_15_8 = arg_15_1:Find("extend_panel")

	if #arg_15_2.config.rare_task_icon > 0 then
		GetImageSpriteFromAtlasAsync("shipyardicon/" .. arg_15_2.config.rare_task_icon, "", var_15_8:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/worldinformationui_atlas", "nobody", var_15_8:Find("card"), true)
	end

	setText(var_15_8:Find("content/desc"), arg_15_2.config.rare_task_text)
	setText(var_15_8:Find("content/slider_progress/Text"), arg_15_2:getProgress() .. "/" .. arg_15_2:getMaxProgress())
	setSlider(var_15_8:Find("content/slider"), 0, arg_15_2:getMaxProgress(), arg_15_2:getProgress())

	local var_15_9 = var_15_8:Find("content/item_tpl")
	local var_15_10 = var_15_8:Find("content/award_bg/panel/content")
	local var_15_11 = arg_15_2.config.show

	removeAllChildren(var_15_10)

	for iter_15_1, iter_15_2 in ipairs(var_15_11) do
		local var_15_12 = cloneTplTo(var_15_9, var_15_10)
		local var_15_13 = {
			type = iter_15_2[1],
			id = iter_15_2[2],
			count = iter_15_2[3]
		}

		updateDrop(var_15_12, var_15_13)
		onButton(self, var_15_12, function()
			self:emit(WorldInformationLayer.ON_DROP, var_15_13)

			return
		end, SFX_PANEL)
		setActive(var_15_12, true)
	end

	setActive(var_15_9, false)
	setActive(var_15_8:Find("content/award_bg/arror"), #var_15_11 > 3)

	return
end

function WorldInformationLayer:OnUpdateTask()
	self.taskList = self.taskProxy:getDoingTaskVOs()

	self:UpdateFilterTaskList()

	return
end

function WorldInformationLayer:OnUpdateDailyTask()
	setActive(self.btnDailyTask:Find("tip"), self.taskProxy:canAcceptDailyTask())
	setActive(self.btnDailyTask:Find("locked"), not nowWorld():IsSystemOpen(WorldConst.SystemDailyTask))

	return
end

return WorldInformationLayer
