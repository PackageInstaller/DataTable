local StarLightMedalAlbumView = class("StarLightMedalAlbumView", import("view.base.BaseUI"))

StarLightMedalAlbumView.ICON_SCALE = 1.35
StarLightMedalAlbumView.MEDAL_COUNT = 8

function StarLightMedalAlbumView:SetMedalGroupData(arg_1_1)
	self.medalGroupList = arg_1_1
	self.currentMedalGroup = self.medalGroupList[self.GROUP_ID] or ActivityMedalGroup.New(self.GROUP_ID)

	if self.currentMedalGroup:GetMedalGroupState() == ActivityMedalGroup.STATE_ACTIVE then
		self.medalTaskView:SetMedalGroup(self.currentMedalGroup)
	end

	self.medalDetailView:SetMedalGroup(self.currentMedalGroup)

	local var_1_0 = self.currentMedalGroup:GetMedalIds()

	for iter_1_0 = 1, self.MEDAL_COUNT do
		LoadImageSpriteAsync("activitymedal/" .. var_1_0[iter_1_0] .. "_l", self.slots[iter_1_0].slot, true)
		LoadImageSpriteAsync("activitymedal/" .. var_1_0[iter_1_0], self.slots[iter_1_0].active, true)
	end

	return
end

function StarLightMedalAlbumView:ShowPageBtn(arg_2_1)
	setActive(self.prevBtn, false)
	setActive(self.nextBtn, false)

	return
end

function StarLightMedalAlbumView:UpdateMedalList()
	return
end

function StarLightMedalAlbumView:init()
	self:FindUI()

	self.loader = AutoLoader.New()

	return
end

function StarLightMedalAlbumView:FindUI()
	local var_5_0 = self._tf:Find("Top")

	self.bg = self._tf:Find("mask")
	self.backBtn = var_5_0:Find("BackBtn")
	self.helpBtn = var_5_0:Find("InfoBtn")
	self.taskBtn = self._tf:Find("Desk/taskBtn")
	self.prevBtn = self._tf:Find("Desk/prevBtn")
	self.nextBtn = self._tf:Find("Desk/nextBtn")
	self.slots = {}

	for iter_5_0 = 1, self.MEDAL_COUNT do
		self.slots[iter_5_0] = {
			slot = self._tf:Find("Desk/Slot" .. iter_5_0),
			active = self._tf:Find("Desk/Slot" .. iter_5_0 .. "/active"),
			tips = self._tf:Find("Desk/Slot" .. iter_5_0 .. "/reddot"),
			click = self._tf:Find("Desk/Slot" .. iter_5_0 .. "/Click")
		}
	end

	self.medalLock = self._tf:Find("Desk/medal")
	self.trophyLock = self._tf:Find("Desk/trophy")
	self.medalDetailView = MedalDetailPanel.New(self._tf:Find("DetailView"), self)

	self.medalDetailView:SetIconScale(self.ICON_SCALE)

	self.medalTaskView = MedalTaskPanel.New(self._tf:Find("TaskView"), self)

	return
end

function StarLightMedalAlbumView:didEnter()
	StarLightMedalAlbumView.super.didEnter(self)
	self:AddListener()
	self:UpdateView()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function StarLightMedalAlbumView:AddListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	for iter_7_0 = 1, self.MEDAL_COUNT do
		onButton(self, self.slots[iter_7_0].click, function()
			self:showMedalView(iter_7_0)

			return
		end)
	end

	onButton(self, self.taskBtn, function()
		self:showTaskView()

		return
	end)
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[self.HELP_TIPS].tip
		})

		return
	end)
	onButton(self, self.medalLock, function()
		local var_13_0 = self.currentMedalGroup:getConfig("item_show")[2]

		self:emit(BaseUI.ON_DROP, {
			type = var_13_0[1],
			id = var_13_0[2],
			count = var_13_0[3]
		})

		return
	end, SFX_PANEL)

	if self.trophyLock then
		onButton(self, self.trophyLock, function()
			local var_14_0 = self.currentMedalGroup:getConfig("item_show")[1]

			self:emit(BaseUI.ON_DROP, {
				type = var_14_0[1],
				id = var_14_0[2],
				count = var_14_0[3]
			})

			return
		end, SFX_PANEL)
	end

	return
end

function StarLightMedalAlbumView:showMedalView(arg_15_1)
	self.medalDetailView:SetCurrentIndex(arg_15_1)
	self.medalDetailView:UpdateMedal()
	self.medalDetailView:SetActive(true)

	return
end

function StarLightMedalAlbumView:showTaskView()
	self.medalTaskView:ShowMedalTask()
	self.medalTaskView:SetActive(true)

	return
end

function StarLightMedalAlbumView:UpdateView()
	local var_17_0 = self.currentMedalGroup:GetMedalIds()
	local var_17_1 = self.currentMedalGroup:GetMedalList()

	for iter_17_0 = 1, self.MEDAL_COUNT do
		if var_17_1[var_17_0[iter_17_0]].timeStamp then
			setActive(self.slots[iter_17_0].active, true)
		else
			setActive(self.slots[iter_17_0].active, false)
		end
	end

	if self.trophyLock then
		self.trophyLock:GetComponent(typeof(Image)).enabled = not self:OwnTrophy()
	end

	self.medalLock:GetComponent(typeof(Image)).enabled = not self:OwnMedal()

	setActive(self.taskBtn, self.currentMedalGroup:GetMedalGroupState() == ActivityMedalGroup.STATE_ACTIVE)

	return
end

function StarLightMedalAlbumView:OwnTrophy()
	local var_18_0 = self.currentMedalGroup:getConfig("task_show")
	local var_18_1 = -1

	if var_18_0 and type(var_18_0) == "table" then
		var_18_1 = var_18_0[1]
	end

	if var_18_1 <= 0 then
		return false
	end

	return Task.OwnSpAward(pg.task_data_template[var_18_1].award_display[1])
end

function StarLightMedalAlbumView:OwnMedal()
	local var_19_0 = self.currentMedalGroup:getConfig("task_show")
	local var_19_1 = -1

	if var_19_0 and type(var_19_0) == "table" then
		var_19_1 = var_19_0[2]
	end

	if var_19_1 <= 0 then
		return false
	end

	return Task.OwnSpAward(pg.task_data_template[var_19_1].award_display[#pg.task_data_template[var_19_1].award_display])
end

function StarLightMedalAlbumView:FlushTaskPanel()
	self.medalTaskView:SetMedalGroup(self.currentMedalGroup)
	self.medalTaskView:ShowMedalTask()

	return
end

function StarLightMedalAlbumView:willExit()
	self.medalDetailView:SetActive(false)
	self.medalTaskView:SetActive(false)
	self.medalDetailView:Dispose()
	self.medalTaskView:Dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.loader:Clear()

	return
end

return StarLightMedalAlbumView
