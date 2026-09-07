local ShinanoframePage = class("ShinanoframePage", import("...base.BaseActivityPage"))

function ShinanoframePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.goBtn = self.bg:Find("GoBtn")
	self.getBtn = self.bg:Find("GetBtn")
	self.gotBtn = self.bg:Find("GotBtn")
	self.switchBtn = self.bg:Find("SwitchBtn")
	self.phaseTF_1 = self.bg:Find("Phase1")
	self.phaseTF_2 = self.bg:Find("Phase2")
	self.gotTag = self.bg:Find("Phase2/GotTag")
	self.frameTF = self.bg:Find("Phase2/Icon")
	self.progressBar = self.bg:Find("Phase2/Progress")
	self.progressText = self.bg:Find("Phase2/ProgressText")

	setActive(self.goBtn, false)
	setActive(self.getBtn, false)
	setActive(self.gotBtn, false)
	setActive(self.gotTag, false)
	setActive(self.progressBar, false)
	setActive(self.progressText, false)
	setActive(self.phaseTF_2, false)

	return
end

function ShinanoframePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function ShinanoframePage:OnFirstFlush()
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
	onButton(self, self.switchBtn, function()
		setActive(self.phaseTF_1, not isActive(self.phaseTF_1))
		setActive(self.phaseTF_2, not isActive(self.phaseTF_2))

		return
	end, SFX_PANEL)
	setParent(LoadAndInstantiateSync("IconFrame", (tostring(self.ptData.dropList[1][2]))), self.frameTF, false)

	return
end

function ShinanoframePage:OnUpdateFlush()
	local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SHINANO_EXP_ACT_ID)

	if not var_7_0 or var_7_0:isEnd() then
		setActive(self.phaseTF_1, false)
		setActive(self.phaseTF_2, true)

		local var_7_1, var_7_2, var_7_3 = self.ptData:GetResProgress()

		setText(self.progressText, var_7_1 .. "/" .. var_7_2)
		setSlider(self.progressBar, 0, 1, var_7_3)
		setActive(self.progressBar, true)
		setActive(self.progressText, true)

		local var_7_4 = self.ptData:CanGetAward()
		local var_7_5 = self.ptData:CanGetNextAward()

		setActive(self.goBtn, self.ptData:CanGetMorePt() and not var_7_4 and var_7_5)
		setActive(self.getBtn, var_7_4)
		setActive(self.gotBtn, not var_7_5)
		setActive(self.gotTag, not var_7_5)
	else
		setActive(self.phaseTF_1, true)
		setActive(self.phaseTF_2, false)

		local var_7_6, var_7_7, var_7_8 = self.ptData:GetResProgress()

		setText(self.progressText, var_7_6 .. "/" .. var_7_7)
		setSlider(self.progressBar, 0, 1, var_7_8)
		setActive(self.progressBar, true)
		setActive(self.progressText, true)
	end

	return
end

function ShinanoframePage:OnDestroy()
	return
end

return ShinanoframePage
