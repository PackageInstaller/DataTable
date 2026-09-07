local StarsCityOmenPage = class("StarsCityOmenPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function StarsCityOmenPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.dayTF = self.bg:Find("total_progress/day")
	self.maxDayTF = self.bg:Find("total_progress/max_day")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.btnDetail = self.bg:Find("btn_detail")
	self.txtDetail = self.btnDetail:Find("detail")
	self.ruleTxt = self.bg:Find("rule_get")
	self.btnStory = self.bg:Find("btn_story")
	self.redPoint = self.btnStory:Find("red")
	self.scenario = self:GetOutPostScenarioPage().New(self._tf, self.event)

	self.scenario:SetCoreStoryPage(self)
	self.scenario:RegisterView(self.coreActivityUI)

	self.taskWindow = StarsCityOmenTaskWindow.New(self._tf, self.event)

	setActive(self.item, false)

	self.progressLabel = self.bg:Find("total_progress/label")

	setText(self.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(self.txtDetail, i18n("Outpost_20260514_Detail"))
	setText(self.ruleTxt, i18n("Outpost_20260806_rule"))

	return
end

function StarsCityOmenPage:GetOutPostScenarioPage()
	return OutPostScenarioPage_260806
end

function StarsCityOmenPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(self.activity)
end

function StarsCityOmenPage:OnFirstFlush()
	StarsCityOmenPage.super.OnFirstFlush(self)
	setActive(self.maxTF, #self.taskGroup)
	onButton(self, self.btnDetail, function()
		self.taskWindow:ExecuteAction("Show", self.activity)

		return
	end, SFX_PANEL)
	onButton(self, self.btnStory, function()
		if self.scenario then
			self.scenario:Load()
			self.scenario:SetActivity(self.activity)
			self.scenario:UpdateStoryTask()
			self.scenario:ActionInvoke("UpdateView")
			self:ShowScenarioLayer(true)
			PlayerPrefs.SetInt(Activity.GetPlayerActivyIDKey(self.activity.id), 1)
			PlayerPrefs.Save()
			self:refreshStoryPoint()
		end

		return
	end, SFX_PANEL)

	return
end

function StarsCityOmenPage:OnShowFlush()
	StarsCityOmenPage.super.OnShowFlush(self)

	return
end

function StarsCityOmenPage:ShowScenarioLayer(arg_8_1)
	if arg_8_1 then
		self.coreActivityUI:ActiveScenarioLayer(true)

		if self.scenario then
			self.scenario:ActionInvoke("Show")
		end
	else
		if self.scenario then
			self.scenario:Hide()
		end

		self.coreActivityUI:ActiveScenarioLayer(false)
	end

	return
end

function StarsCityOmenPage:IsShowingPopWindow()
	if self.scenario then
		return self.scenario:isShowing()
	end

	return
end

function StarsCityOmenPage:ClosePopWindow()
	if self.scenario then
		self.scenario:Hide()
		self:ShowScenarioLayer(false)
	end

	return
end

function StarsCityOmenPage:OnUpdateFlush()
	self.nday = self:getTaskIdx(self.activity)

	self:PlayStory()
	self:refreshStoryPoint()

	if self.dayTF then
		setText(self.dayTF, "DAY " .. self.nday)
		setText(self.maxDayTF, "/" .. #self.taskGroup)
	end

	self.uilist:align(#self.taskGroup[self.nday])

	if self.taskWindow:isShowing() then
		self.taskWindow:ExecuteAction("Show", self.activity)
	end

	return
end

function StarsCityOmenPage:UpdateTask(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2:Find("item")
	local var_12_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_12_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_12_1 + 1])

	assert(var_12_1, "without this task by id: " .. self.taskGroup[self.nday][arg_12_1 + 1])

	local var_12_2 = Drop.Create(var_12_1:getConfig("award_display")[1])

	updateDrop(var_12_0, var_12_2)
	onButton(self, var_12_0, function()
		self:emit(BaseUI.ON_DROP, var_12_2)

		return
	end, SFX_PANEL)

	local var_12_3 = var_12_1:getProgress()
	local var_12_4 = var_12_1:getConfig("target_num")

	setScrollText(arg_12_2:Find("mask/description"), var_12_1:getConfig("desc"))

	local var_12_5, var_12_6 = self:GetProgressColor()

	setText(arg_12_2:Find("progressText"), (var_12_5 and setColorStr(var_12_3, var_12_5) or var_12_3) .. (var_12_6 and setColorStr("/" .. var_12_4, var_12_6) or "/" .. var_12_4))
	setSlider(arg_12_2:Find("progress"), 0, var_12_4, var_12_3)

	local var_12_8 = arg_12_2:Find("go_btn")
	local var_12_9 = arg_12_2:Find("get_btn")
	local var_12_10 = arg_12_2:Find("got_btn")

	self:SetBtnLocal(arg_12_2)

	local var_12_11 = var_12_1:getTaskStatus()

	setActive(var_12_8, var_12_11 == 0)
	setActive(var_12_9, var_12_11 == 1)
	setActive(var_12_10, var_12_11 == 2)
	onButton(self, var_12_8, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_12_1)

		return
	end, SFX_PANEL)
	onButton(self, var_12_9, function()
		local var_15_0 = {}
		local var_15_1 = var_12_1:getConfig("award_display")
		local var_15_2 = getProxy(PlayerProxy):getRawData()
		local var_15_3, var_15_4 = Task.StaticJudgeOverflow(var_15_2.gold, var_15_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_15_1)

		if var_15_3 then
			table.insert(var_15_0, function(arg_16_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_15_4,
					onYes = arg_16_0
				})

				return
			end)
		end

		seriesAsync(var_15_0, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_12_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function StarsCityOmenPage:getTaskIdx(arg_18_1)
	local var_18_0 = 1
	local var_18_1 = math.min(arg_18_1:getNDay(), #self.taskGroup)

	for iter_18_0 = 1, var_18_1 do
		if not true then
			break
		end

		var_18_0 = iter_18_0

		if iter_18_0 < var_18_1 then
			for iter_18_1, iter_18_2 in ipairs(self.taskGroup[iter_18_0]) do
				if not self:isTaskFinished(iter_18_2) then
					break
				end
			end
		end
	end

	return math.min(var_18_0, #self.taskGroup)
end

function StarsCityOmenPage:isTaskFinished(arg_19_1)
	self.taskProxy = self.taskProxy or getProxy(TaskProxy)

	local var_19_0 = self.taskProxy:getTaskById(arg_19_1) or self.taskProxy:getFinishTaskById(arg_19_1)

	return var_19_0 and var_19_0:getTaskStatus() == 2
end

function StarsCityOmenPage:refreshStoryPoint()
	setActive(self.redPoint, PlayerPrefs.GetInt(Activity.GetPlayerActivyIDKey(self.activity.id), 0) == 0)

	return
end

function StarsCityOmenPage:GetProgressColor()
	return "#FFFFFF", "#C3C3C3"
end

function StarsCityOmenPage:SetBtnLocal(arg_22_1)
	setText(arg_22_1:Find("get_btn"):Find("Text"), i18n("LiquorFloorTaskUI_get"))
	setText(arg_22_1:Find("go_btn"):Find("Text"), i18n("LiquorFloorTaskUI_go"))
	setText(arg_22_1:Find("got_btn"):Find("Text"), i18n("LiquorFloorTaskUI_got"))

	return
end

function StarsCityOmenPage:OnHideFlush()
	if self.taskWindow:isShowing() then
		self.taskWindow:Hide()
	end

	return
end

function StarsCityOmenPage:OnDestroy()
	if self.taskWindow then
		self.taskWindow:Hide()
		self.taskWindow:Destroy()

		self.taskWindow = nil
	end

	if self.scenario then
		if self.scenario:isShowing() then
			self.scenario:Hide()
		end

		self.scenario:Destroy()
	end

	return
end

return StarsCityOmenPage
