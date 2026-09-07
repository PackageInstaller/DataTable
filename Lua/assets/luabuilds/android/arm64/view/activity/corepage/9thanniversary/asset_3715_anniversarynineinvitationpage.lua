local AnniversaryNineInvitationPage = class("AnniversaryNineInvitationPage", import("view.activity.CorePage.CoreActivityPage"))

function AnniversaryNineInvitationPage:OnInit()
	self.rtMarks = self._tf:Find("AD/progress/items")
	self.rtFinish = self._tf:Find("AD/award/got")
	self.rtBtns = self._tf:Find("AD/btn_list")
	self.goBtn = self.rtBtns:Find("go")
	self.getBtn = self.rtBtns:Find("get")
	self.gotBtn = self.rtBtns:Find("got")
	self.red = self.rtBtns:Find("red")

	return
end

function AnniversaryNineInvitationPage:OnDataSetting()
	self.curDay = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.lastTaskId = table.remove(self.taskGroup)

	return
end

function AnniversaryNineInvitationPage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		local var_4_0 = self.coreActivityUI:GetActivityIdByPageClass("AnniversaryNineGamePage")

		if var_4_0 then
			self.coreActivityUI:verifyTabs(var_4_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		if self.finalTaskVO and self.finalTaskVO:getTaskStatus() == 1 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, self.finalTaskVO)
		end

		return
	end, SFX_PANEL)

	return
end

function AnniversaryNineInvitationPage:OnUpdateFlush()
	for iter_6_0 = 1, #self.taskGroup do
		local var_6_0 = self.taskProxy:getTaskVO(self.taskGroup[iter_6_0])

		if var_6_0 and var_6_0:getTaskStatus() == 1 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_6_0)

			return
		end
	end

	self:RefreshTaskState()
	self:RefreshProgress()
	self:RefreshButtons()

	return
end

function AnniversaryNineInvitationPage:RefreshTaskState()
	self.finalTaskVO = self.taskProxy:getTaskVO(self.lastTaskId)
	self.finishCount = math.max(self.activity.data3, 1) - (underscore.all(self.taskGroup, function(arg_8_0)
		local var_8_0 = self.taskProxy:getTaskVO(arg_8_0)

		return not var_8_0 or var_8_0:isReceive()
	end) and 0 or 1)

	return
end

function AnniversaryNineInvitationPage:RefreshProgress()
	local var_9_0 = math.min(self.finishCount, self.rtMarks.childCount)

	for iter_9_0 = 1, self.rtMarks.childCount do
		setActive(self.rtMarks:GetChild(iter_9_0 - 1):Find("mark"), iter_9_0 <= var_9_0)
	end

	return
end

function AnniversaryNineInvitationPage:RefreshButtons()
	local var_10_0 = self.finalTaskVO and self.finalTaskVO:getTaskStatus() or 0
	local var_10_1 = var_10_0 == 1
	local var_10_2 = var_10_0 == 2

	setActive(self.goBtn, var_10_0 == 0)

	if var_10_1 then
		onButton(self, self.getBtn, function()
			if self.finalTaskVO and self.finalTaskVO:getTaskStatus() == 1 then
				self:emit(ActivityMediator.ON_TASK_SUBMIT, self.finalTaskVO)
			end

			return
		end, SFX_PANEL)
	end

	setActive(self.getBtn, var_10_1)
	setActive(self.red, var_10_1)
	setActive(self.gotBtn, var_10_2)
	setActive(self.rtFinish, var_10_2)

	return
end

return AnniversaryNineInvitationPage
