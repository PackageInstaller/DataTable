local JPSkirmishHeadFramePage = class("JPSkirmishHeadFramePage", import("...base.BaseActivityPage"))

function JPSkirmishHeadFramePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.goBtn = self.bg:Find("GoBtn")
	self.getBtn = self.bg:Find("GetBtn")
	self.gotBtn = self.bg:Find("GotBtn")
	self.gotTag = self.bg:Find("GotTag")
	self.progressBar = self.bg:Find("Progress")
	self.progressText = self.bg:Find("ProgressText")

	setActive(self.goBtn, false)
	setActive(self.getBtn, false)
	setActive(self.gotBtn, false)
	setActive(self.gotTag, false)

	return
end

function JPSkirmishHeadFramePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function JPSkirmishHeadFramePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_5_0, var_5_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)

	return
end

function JPSkirmishHeadFramePage:OnUpdateFlush()
	local var_6_0 = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").linkExpActID)

	if not var_6_0 or var_6_0:isEnd() then
		local var_6_1 = self.ptData:CanGetAward()
		local var_6_2 = self.ptData:CanGetNextAward()

		setActive(self.goBtn, self.ptData:CanGetMorePt() and not var_6_1 and var_6_2)
		setActive(self.getBtn, var_6_1)
		setActive(self.gotBtn, not var_6_2)
		setActive(self.gotTag, not var_6_2)
	end

	local var_6_3, var_6_4, var_6_5 = self.ptData:GetResProgress()

	setText(self.progressText, setColorStr(var_6_3, "#487CFFFF") .. "/" .. var_6_4)
	setSlider(self.progressBar, 0, 1, var_6_5)
	setActive(self.progressText, true)

	return
end

function JPSkirmishHeadFramePage:OnDestroy()
	return
end

return JPSkirmishHeadFramePage
