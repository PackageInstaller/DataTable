local OutPostOmenPage = class("OutPostOmenPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function OutPostOmenPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.dayTF = self.bg:Find("total_progress/day")
	self.maxDayTF = self.bg:Find("total_progress/max_day")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.btnDetail = self.bg:Find("btn_detail")
	self.txtDetail = self.btnDetail:Find("detail")
	self.btnStory = self.bg:Find("btn_story")
	self.scenario = self:GetOutPostScenarioPage().New(self._tf, self.event)

	self.scenario:SetCoreStoryPage(self)
	self.scenario:RegisterView(self.coreActivityUI)

	self.taskWindow = OutPostOmenTaskWindow.New(self._tf, self.event)

	setActive(self.item, false)

	self.progressLabel = self.bg:Find("total_progress/label")

	setText(self.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(self.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

function OutPostOmenPage:GetOutPostScenarioPage()
	return OutPostScenarioPage
end

function OutPostOmenPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(self.activity)
end

function OutPostOmenPage:OnFirstFlush()
	OutPostOmenPage.super.OnFirstFlush(self)
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
		end

		return
	end, SFX_PANEL)

	return
end

function OutPostOmenPage:OnShowFlush()
	OutPostOmenPage.super.OnShowFlush(self)

	return
end

function OutPostOmenPage:ShowScenarioLayer(arg_8_1)
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

function OutPostOmenPage:IsShowingPopWindow()
	if self.scenario then
		return self.scenario:isShowing()
	end

	return
end

function OutPostOmenPage:ClosePopWindow()
	if self.scenario then
		self.scenario:Hide()
		self:ShowScenarioLayer(false)
	end

	return
end

function OutPostOmenPage:OnUpdateFlush()
	self.nday = self:getTaskIdx(self.activity)

	self:PlayStory()

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

function OutPostOmenPage:getTaskIdx(arg_12_1)
	local var_12_0 = 1
	local var_12_1 = math.min(arg_12_1:getNDay(), #self.taskGroup)

	for iter_12_0 = 1, var_12_1 do
		if not true then
			break
		end

		var_12_0 = iter_12_0

		if iter_12_0 < var_12_1 then
			for iter_12_1, iter_12_2 in ipairs(self.taskGroup[iter_12_0]) do
				if not self:isTaskFinished(iter_12_2) then
					break
				end
			end
		end
	end

	return math.min(var_12_0, #self.taskGroup)
end

function OutPostOmenPage:isTaskFinished(arg_13_1)
	self.taskProxy = self.taskProxy or getProxy(TaskProxy)

	local var_13_0 = self.taskProxy:getTaskById(arg_13_1) or self.taskProxy:getFinishTaskById(arg_13_1)

	return var_13_0 and var_13_0:getTaskStatus() == 2
end

function OutPostOmenPage:OnHideFlush()
	if self.taskWindow:isShowing() then
		self.taskWindow:Hide()
	end

	return
end

function OutPostOmenPage:OnDestroy()
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

return OutPostOmenPage
