local ToLoveCollabMedalView = class("ToLoveCollabMedalView", import("..TemplateMV.MedalCollectionTemplateView"))

function ToLoveCollabMedalView:getUIName()
	return "ToLoveCollabMedalPage"
end

function ToLoveCollabMedalView:init()
	self:FindUI()

	self.loader = AutoLoader.New()

	return
end

function ToLoveCollabMedalView:FindUI()
	self.bg = self._tf:Find("mask")
	self.backBtn = self._tf:Find("Top"):Find("BackBtn")
	self.slots = {}

	for iter_3_0 = 1, 6 do
		self.slots[iter_3_0] = {
			char = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Char"),
			selected = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/Selected"),
			tips = self._tf:Find("Desk/Slot" .. iter_3_0 .. "/reddot")
		}
	end

	self.medalTF = self._tf:Find("Desk/trophy")
	self.syncBtn = self._tf:Find("Desk/syncBtn")
	self.task = self._tf:Find("Desk/task")
	self.taskBGGo = self.task:Find("bg_go")
	self.taskBGGot = self.task:Find("bg_got")
	self.taskBtnGo = self.task:Find("go_btn")
	self.taskBtnGot = self.task:Find("got_btn")
	self.taskBtnGet = self.task:Find("get_btn")
	self.taskDesc = self.task:Find("desc")
	self.taskReward = self.task:Find("award/mask")
	self.taskRewardName = self.task:Find("name")

	return
end

function ToLoveCollabMedalView:didEnter()
	self.taskList, self.dropInfoList = {}, {}

	local var_4_0 = self.activityData:getConfig("config_client").item_task

	for iter_4_0 = 1, 6 do
		self.taskList[iter_4_0] = Task.New({
			id = var_4_0[iter_4_0][2]
		})
		self.dropInfoList[iter_4_0] = {
			type = DROP_TYPE_VITEM,
			id = var_4_0[iter_4_0][1]
		}
	end

	self:AddListener()

	self.contextData.ChipIndex = self.contextData.ChipIndex or 1

	self:UpdateView()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function ToLoveCollabMedalView:AddListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.taskBtnGet, function()
		local var_7_0 = self.allIDList[self.contextData.ChipIndex]

		if not table.contains(self.activeIDList, self.allIDList[self.contextData.ChipIndex]) and table.contains(self.activatableIDList, var_7_0) then
			self:emit(MedalCollectionTemplateMediator.MEMORYBOOK_UNLOCK, {
				id = var_7_0,
				actId = self.activityData.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtnGo, function()
		local var_8_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_TASK_ID)

		if var_8_0 and not var_8_0:isEnd() then
			self:emit(MedalCollectionTemplateMediator.MEMORYBOOK_GO, self.taskList[self.contextData.ChipIndex])
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)

	for iter_5_0 = 1, 6 do
		onButton(self, self._tf:Find("Desk/Slot" .. iter_5_0 .. "/Click"), function()
			self.contextData.ChipIndex = iter_5_0

			self:UpdateView()

			return
		end, SFX_PANEL)
	end

	onButton(self, self.syncBtn, function()
		self:CheckAward()

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function ToLoveCollabMedalView:UpdateAfterSubmit(arg_12_1)
	self:UpdateView()

	return
end

function ToLoveCollabMedalView:UpdateAfterFinalMedal()
	ToLoveCollabMedalView.super.UpdateAfterFinalMedal(self)
	self:UpdateView()

	return
end

function ToLoveCollabMedalView:UpdateView()
	for iter_14_0 = 1, 6 do
		for iter_14_1 = 1, #self.slots do
			local var_14_2 = table.contains(self.activeIDList, self.allIDList[iter_14_1])

			setActive(self.slots[iter_14_1].char, var_14_2)
			setActive(self.slots[iter_14_1].tips, table.contains(self.activatableIDList, self.allIDList[iter_14_1]) and not var_14_2)
		end

		setActive(self.slots[iter_14_0].selected, iter_14_0 == self.contextData.ChipIndex)
	end

	local var_14_3 = #self.activeIDList == #self.allIDList
	local var_14_4 = #self.activeIDList == #self.allIDList and self.activityData.data1 == 1

	setActive(self.medalTF:Find("Lock"), not (#self.activeIDList == #self.allIDList and self.activityData.data1 == 1))
	setActive(self.medalTF:Find("Unlock"), var_14_4)
	setActive(self.syncBtn:Find("notSync"), not var_14_3)
	setActive(self.syncBtn:Find("synced"), var_14_4)

	self.syncBtn:GetComponent(typeof(Image)).enabled = var_14_3 and not var_14_4

	setActive(self.syncBtn:Find("reddot"), var_14_3 and not var_14_4)
	self:UpdateInfo()

	return
end

function ToLoveCollabMedalView:UpdateInfo()
	local var_15_0 = self.allIDList[self.contextData.ChipIndex]
	local var_15_1 = table.contains(self.activeIDList, self.allIDList[self.contextData.ChipIndex])
	local var_15_2 = not var_15_1 and table.contains(self.activatableIDList, var_15_0)

	setActive(self.taskBGGo, not var_15_1)
	setActive(self.taskBGGot, var_15_1)
	setActive(self.taskBtnGot, var_15_1)
	setActive(self.taskBtnGet, var_15_2)
	setActive(self.taskBtnGo, not var_15_2)
	setText(self.taskDesc, self.taskList[self.contextData.ChipIndex]:getConfig("desc"))
	updateDrop(self.taskReward, self.dropInfoList[self.contextData.ChipIndex])
	setText(self.taskRewardName, pg.item_virtual_data_statistics[self.dropInfoList[self.contextData.ChipIndex].id].name)

	return
end

function ToLoveCollabMedalView:willExit()
	self.loader:Clear()

	return
end

return ToLoveCollabMedalView
