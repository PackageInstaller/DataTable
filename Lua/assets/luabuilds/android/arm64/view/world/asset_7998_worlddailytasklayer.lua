local WorldDailyTaskLayer = class("WorldDailyTaskLayer", import("view.base.BaseUI"))

WorldDailyTaskLayer.Listeners = {
	onUpdateTasks = "OnUpdateTasks"
}
WorldDailyTaskLayer.optionsPath = {
	"blur_panel/adapt/top/title/option"
}

function WorldDailyTaskLayer:getUIName()
	return "WorldDailyTaskUI"
end

function WorldDailyTaskLayer:init()
	for iter_2_0, iter_2_1 in pairs(WorldDailyTaskLayer.Listeners) do
		self[iter_2_0] = function(...)
			WorldDailyTaskLayer[iter_2_1](self, ...)

			return
		end
	end

	self.rtBg = self._tf:Find("bg")
	self.rtBlurPanel = self._tf:Find("blur_panel")
	self.rtTasks = self.rtBlurPanel:Find("adapt/tasks")

	setText(self.rtTasks:Find("frame/empty/Text"), i18n("world_daily_task_none"))
	setText(self.rtTasks:Find("frame/empty/Text_en"), i18n("world_daily_task_none_2"))

	self.rtTop = self.rtBlurPanel:Find("adapt/top")
	self.btnBack = self.rtTop:Find("title/back_button")
	self.btnAllAccept = self.rtTop:Find("title/btn_accept_all")
	self.rtTopTitle = self.rtTop:Find("title")
	self.rtImageTitle = self.rtTopTitle:Find("print/title")
	self.rtImageTitleTask = self.rtTopTitle:Find("print/title_task")
	self.rtImageTitleShop = self.rtTopTitle:Find("print/title_shop")
	self.rtTaskWindow = self._tf:Find("task_window")
	self.wsTasks = {}

	local var_2_0 = self.rtTasks:Find("frame/viewport/content")

	self.taskItemList = UIItemList.New(var_2_0, (var_2_0:GetChild(0)))

	self.taskItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.wsTasks[arg_4_1]

			if not self.wsTasks[arg_4_1] then
				var_4_0 = WSPortTask.New(arg_4_2)

				onButton(self, var_4_0.btnInactive, function()
					local var_5_0, var_5_1 = WorldTask.canTrigger(var_4_0.task.id)

					if var_5_0 then
						self:emit(WorldDailyTaskMediator.OnAccepetTask, {
							var_4_0.task.id
						})
					else
						pg.TipsMgr.GetInstance():ShowTips(var_5_1)
					end

					return
				end, SFX_PANEL)
				onButton(self, var_4_0.btnOnGoing, function()
					self:showTaskWindow(var_4_0.task)

					return
				end, SFX_PANEL)
				onButton(self, var_4_0.btnFinished, function()
					self:emit(WorldDailyTaskMediator.OnSubmitTask, var_4_0.task)

					return
				end, SFX_PANEL)

				function var_4_0.onDrop(arg_8_0)
					self:emit(WorldDailyTaskLayer.ON_DROP, arg_8_0)

					return
				end

				self.wsTasks[arg_4_1] = var_4_0
			end

			var_4_0:Setup(self.taskVOs[arg_4_1])
		end

		return
	end)

	return
end

function WorldDailyTaskLayer:didEnter()
	self:BlurPanel(self._tf)
	self:BlurPanel(self.rtBlurPanel)
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnAllAccept, function()
		self:emit(WorldDailyTaskMediator.OnAccepetTask, underscore.map(self.taskVOs, function(arg_12_0)
			return arg_12_0.id
		end))

		return
	end, SFX_CONFIRM)
	self:OnUpdateTasks()

	return
end

function WorldDailyTaskLayer:onBackPressed()
	triggerButton(self.btnBack)

	return
end

function WorldDailyTaskLayer:willExit()
	self:UnOverlayPanel(self.rtBlurPanel, self._tf)
	self:UnOverlayPanel(self._tf)
	self:DisposeTasks()
	self.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateDailyTaskIds, self.onUpdateTasks)

	self.taskProxy = nil

	return
end

function WorldDailyTaskLayer:SetTaskProxy(arg_15_1)
	self.taskProxy = arg_15_1

	self.taskProxy:AddListener(WorldTaskProxy.EventUpdateDailyTaskIds, self.onUpdateTasks)

	return
end

function WorldDailyTaskLayer:OnUpdateTasks()
	self.taskVOs = underscore.map(self.taskProxy:getDailyTaskIds(), function(arg_17_0)
		return WorldTask.New({
			id = arg_17_0
		})
	end)

	table.sort(self.taskVOs, CompareFuncs(WorldTask.sortDic))
	self.taskItemList:align(#self.taskVOs)
	setActive(self.rtTasks:Find("frame/empty"), #self.taskVOs == 0)
	setActive(self.btnAllAccept, self.taskProxy:canAcceptDailyTask())

	return
end

function WorldDailyTaskLayer:DisposeTasks()
	_.each(self.wsTasks, function(arg_19_0)
		arg_19_0:Dispose()

		return
	end)

	self.wsTasks = nil

	return
end

function WorldDailyTaskLayer:showTaskWindow(arg_20_1)
	local var_20_0 = self.rtTaskWindow:Find("main_window/left_panel")

	setActive(var_20_0:Find("bg"), arg_20_1:IsSpecialType())

	if #arg_20_1.config.rare_task_icon > 0 then
		GetImageSpriteFromAtlasAsync("shipyardicon/" .. arg_20_1.config.rare_task_icon, "", var_20_0:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/worldportui_atlas", "nobody", var_20_0:Find("card"), true)
	end

	local var_20_1 = self.rtTaskWindow:Find("main_window/right_panel")

	setText(var_20_1:Find("title/Text"), arg_20_1.config.name)
	setText(var_20_1:Find("content/desc"), arg_20_1.config.rare_task_text)
	setText(var_20_1:Find("content/slider_progress/Text"), arg_20_1:getProgress() .. "/" .. arg_20_1:getMaxProgress())
	setSlider(var_20_1:Find("content/slider"), 0, arg_20_1:getMaxProgress(), arg_20_1:getProgress())

	local var_20_2 = var_20_1:Find("content/item_tpl")
	local var_20_3 = var_20_1:Find("content/award_bg/panel/content")
	local var_20_4 = arg_20_1.config.show

	removeAllChildren(var_20_3)

	for iter_20_0, iter_20_1 in ipairs(var_20_4) do
		local var_20_5 = cloneTplTo(var_20_2, var_20_3)
		local var_20_6 = {
			type = iter_20_1[1],
			id = iter_20_1[2],
			count = iter_20_1[3]
		}

		updateDrop(var_20_5, var_20_6)
		onButton(self, var_20_5, function()
			self:emit(WorldDailyTaskLayer.ON_DROP, var_20_6)

			return
		end, SFX_PANEL)
		setActive(var_20_5, true)
	end

	setActive(var_20_2, false)
	setActive(var_20_1:Find("content/award_bg/arror"), #var_20_4 > 3)
	onButton(self, var_20_1:Find("btn_close"), function()
		self:hideTaskWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtTaskWindow:Find("bg"), function()
		self:hideTaskWindow()

		return
	end, SFX_CANCEL)
	onButton(self, var_20_1:Find("btn_go"), function()
		self:hideTaskWindow()
		self:emit(WorldDailyTaskMediator.OnTaskGoto, arg_20_1.id)

		return
	end, SFX_PANEL)
	setButtonEnabled(var_20_1:Find("btn_go"), arg_20_1:GetFollowingAreaId() or arg_20_1:GetFollowingEntrance())
	setActive(self.rtTaskWindow, true)
	pg.UIMgr.GetInstance():BlurPanel(self.rtTaskWindow)

	return
end

function WorldDailyTaskLayer:hideTaskWindow()
	setActive(self.rtTaskWindow, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtTaskWindow, self._tf)

	return
end

return WorldDailyTaskLayer
