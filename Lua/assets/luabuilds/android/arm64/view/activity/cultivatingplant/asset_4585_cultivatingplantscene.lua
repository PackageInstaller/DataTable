local CultivatingPlantScene = class("CultivatingPlantScene", import("view.base.BaseUI"))

function CultivatingPlantScene:getUIName()
	return "CultivatingPlantPartUI"
end

function CultivatingPlantScene:init()
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SFX_CANCLE)
	onButton(self, self.uiCultivatingBtn, function()
		self:emit(CultivatingPlantMediator.GO_SCENE)

		return
	end, SFX_PANEL)
	onButton(self, self.uiIslandBtn, function()
		local var_5_0 = getProxy(TaskProxy):getTaskVO(self.taskList[self.index])

		if var_5_0 == nil or not var_5_0:isFinish() then
			return
		end

		if not var_5_0:isReceive() then
			self:emit(CultivatingPlantMediator.ON_TASK_SUBMIT, var_5_0)
		else
			self:OpenLiveArea()
		end

		return
	end, SFX_PANEL)

	for iter_2_0 = 1, self.uiList.childCount do
		onButton(self, self.uiList:GetChild(iter_2_0 - 1), function()
			self:SelectPage(iter_2_0)

			return
		end, SFX_PANEL)
	end

	setText(self.uiTaskTitle, i18n("cultivating_plant_task_title"))
	setText(self.uiIslandText, i18n("cultivating_plant_island_task"))

	return
end

function CultivatingPlantScene:didEnter()
	self:BlurPanel(self._tf)

	self.taskList = CultivatingPlantTools.GetTaskIDList()

	self:SelectPage((self.contextData.id or nil) and (self.contextData.id + 1 or 1))

	return
end

function CultivatingPlantScene:willExit()
	self:UnOverlayPanel(self._tf)

	if self.liveAreaPage then
		self.liveAreaPage:Destroy()

		self.liveAreaPage = nil
	end

	return
end

function CultivatingPlantScene:SelectPage(arg_9_1)
	if self.index == arg_9_1 then
		return
	end

	local var_9_0 = 216
	local var_9_1 = 1238

	self.index = arg_9_1

	for iter_9_0 = 1, self.uiList.childCount do
		local var_9_2 = self.uiList:GetChild(iter_9_0 - 1)

		var_9_2:GetComponent(typeof(LayoutElement)).preferredWidth = iter_9_0 == arg_9_1 and var_9_1 or var_9_0

		setActive(var_9_2:Find("Image"), iter_9_0 ~= arg_9_1)
		setActive(var_9_2:Find("main"), iter_9_0 == arg_9_1)

		local var_9_3 = getProxy(TaskProxy):getTaskVO(self.taskList[iter_9_0])
		local var_9_4 = var_9_3 and var_9_3:isFinish() or false

		setActive(var_9_2:Find("Image/got"), var_9_4)
		setActive(var_9_2:Find("main/got"), var_9_4)
	end

	self:RefreshTask()
	setText(self.uiCultivatingText, i18n(string.format("cultivating_plant_part_" .. self.index)))

	return
end

function CultivatingPlantScene:RefreshTask()
	local var_10_0 = pg.task_data_template[self.taskList[self.index]]
	local var_10_1 = getProxy(TaskProxy):getTaskVO(self.taskList[self.index])
	local var_10_2 = Drop.Create(pg.task_data_template[self.taskList[self.index]].award_display[1])

	updateDrop(self.uiRewardItem, var_10_2)
	onButton(self, self.uiRewardItem, function()
		self:emit(BaseUI.ON_DROP, var_10_2)

		return
	end, SFX_PANEL)

	local var_10_3 = var_10_1 and var_10_1:isReceive() or false
	local var_10_4 = var_10_1 and var_10_1:isFinish() or false

	setActive(self.uiRewardGot, var_10_3)
	setActive(self.uiRed, var_10_4 and not var_10_3)
	setGray(self.uiIslandBtn, not var_10_4)
	setText(self.uiTaskDesc, var_10_0.desc)

	local var_10_5 = var_10_1 and var_10_1:getProgress() or 0

	setText(self.uiTaskCnt, string.format("<color=#268BC5>%s</color>/%s", var_10_5, var_10_0.target_num))

	self.uiSlider.fillAmount = var_10_5 / var_10_0.target_num

	setActive(self.uiTask, false)
	setActive(self.uiTask, true)

	return
end

function CultivatingPlantScene:OpenLiveArea()
	if self.liveAreaPage == nil then
		self.liveAreaPage = MainLiveAreaPage.New(self._parentTf, self.event)
	end

	self.liveAreaPage:ExecuteAction("Show", true, function()
		return
	end)

	return
end

function CultivatingPlantScene:RefreshSubmitTaskDone()
	setActive(self.uiRewardGot, true)
	setActive(self.uiRed, false)
	self:OpenLiveArea()

	return
end

function CultivatingPlantScene:onBackPressed()
	if self.liveAreaPage and self.liveAreaPage:GetLoaded() and self.liveAreaPage:isShowing() then
		self.liveAreaPage:Hide()

		return true
	end

	return false
end

return CultivatingPlantScene
