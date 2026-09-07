local PockySkinPage = class("PockySkinPage", import("view.base.BaseActivityPage"))

function PockySkinPage.GetCurrentDay()
	return pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").yday
end

function PockySkinPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.leftStage = self.bg:Find("left")
	self.rightStage = self.bg:Find("right")
	self.taskDesc = self.leftStage:Find("task")
	self.signDesc = self.leftStage:Find("signin")
	self.spine = nil
	self.spineLRQ = GetSpineRequestPackage.New("beierfasite_4", function(arg_3_0)
		SetParent(arg_3_0, self.leftStage:Find("ship"))

		self.spine = arg_3_0
		self.spine.transform.localScale = Vector3.one

		self:SetAction("stand")

		self.spineLRQ = nil

		return
	end):Start()
	self.startDay = PlayerPrefs.GetInt("PockySkinSignDay" .. (getProxy(PlayerProxy):getRawData().id or "-1"), 0)
	self.usmLRQ = nil

	return
end

function PockySkinPage:OnDataSetting()
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = self.activity:getConfig("config_client").linkids
	local var_4_2 = false

	self.ActSignIn = self.activity
	self.taskProxy = getProxy(TaskProxy)

	if self.ActSignIn then
		self.nday = 0
		self.taskGroup = self.ActSignIn:getConfig("config_data")
		var_4_2 = var_4_2 or updateActivityTaskStatus(self.ActSignIn)
	end

	self.ActPT = var_4_0:getActivityById(var_4_1[1])

	if self.ActPT then
		if self.ptData then
			self.ptData:Update(self.ActPT)
		else
			self.ptData = ActivityPtData.New(self.ActPT)
		end
	end

	self.ActTaskList = var_4_0:getActivityById(var_4_1[2])

	if self.ActTaskList then
		self.nday2 = 0
		self.taskGroup2 = self.ActTaskList:getConfig("config_data")
		var_4_2 = var_4_2 or updateActivityTaskStatus(self.ActTaskList)
	end

	self.ActFinal = var_4_0:getActivityById(var_4_1[3])

	if self.ActFinal then
		self.nday3 = 0
		self.taskGroup3 = self.ActFinal:getConfig("config_data")
		var_4_2 = var_4_2 or updateActivityTaskStatus(self.ActFinal)
	end

	return var_4_2
end

function PockySkinPage:OnFirstFlush()
	onButton(self, self.rightStage:Find("display_btn"), function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = self.ptData.type,
			dropList = self.ptData.dropList,
			targets = self.ptData.targets,
			level = self.ptData.level,
			count = self.ptData.count,
			resId = self.ptData.resId
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rightStage:Find("battle_btn"), function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.rightStage:Find("get_btn"), function()
		local var_8_0, var_8_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_8_1
		})

		return
	end, SFX_PANEL)
	onButton(self, self.bg:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.pocky_help.tip
		})

		return
	end, SFX_PANEL)

	return
end

function PockySkinPage:SetAction(arg_10_1)
	if not self.spine then
		return
	end

	local var_10_0 = self.spine:GetComponent("SpineAnimUI")

	if var_10_0 then
		var_10_0:SetAction(arg_10_1, 0)
	end

	return
end

function PockySkinPage:OnUpdateFlush()
	self:UpdateTaskList()
	self:UpdatePTList()

	local var_11_0 = "ui"
	local var_11_1 = self.startDay < self.GetCurrentDay() and "juu_factory_rest" or "juu_factory"

	if self.usmLRQ and self.usmLRQ.name ~= var_11_1 then
		self.usmLRQ:Stop()

		self.usmLRQ = nil
	end

	if self.usmName ~= var_11_1 then
		self.usmLRQ = LoadPrefabRequestPackage.New(var_11_0 .. "/" .. var_11_1, var_11_1, function(arg_12_0)
			if not IsNil(self.usm) then
				Destroy(self.usm)
			end

			self.usm = arg_12_0

			setParent(arg_12_0, self.bg:Find("usm"))

			return
		end):Start()
		self.usmName = var_11_1
	end

	return
end

function PockySkinPage:UpdateTaskList()
	self.nday = self.ActSignIn.data3 or 0
	self.nday2 = self.ActTaskList.data3 or 0
	self.nday3 = self.ActFinal.data3 or 0

	local var_13_0 = self.ActSignIn:getConfig("config_client").story

	if checkExist(var_13_0, {
		self.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_13_0[self.nday][1])
	end

	local var_13_1 = self.leftStage:Find("go_btn")
	local var_13_2 = self.leftStage:Find("get_btn")
	local var_13_3 = self.leftStage:Find("sign_btn")
	local var_13_4 = self.leftStage:Find("got_btn")
	local var_13_5 = self.leftStage:Find("award")
	local var_13_6 = self.leftStage:Find("slider")
	local var_13_7 = getProxy(TaskProxy)
	local var_13_8 = var_13_7:getTaskVO(self.taskGroup[self.nday][1])
	local var_13_9 = var_13_7:getTaskVO(self.taskGroup2[self.nday2][1])
	local var_13_10 = var_13_7:getTaskVO(self.taskGroup3[self.nday3][1])
	local var_13_11 = var_13_8:getTaskStatus()
	local var_13_12 = var_13_9:getTaskStatus()
	local var_13_13 = var_13_10:getTaskStatus()

	if not self.startTaskid then
		self.startTaskid = self.taskGroup[self.nday][1]
		self.startStatus = var_13_11
	end

	local var_13_14 = false

	if self.startTaskid ~= self.taskGroup[self.nday][1] then
		self.startTaskid = self.taskGroup[self.nday][1]
		self.startStatus = var_13_11
		var_13_14 = true
	elseif self.startStatus ~= var_13_11 then
		self.startStatus = var_13_11
		var_13_14 = true
	end

	local var_13_15 = self.GetCurrentDay()

	if var_13_14 and var_13_15 > self.startDay then
		self.startDay = var_13_15

		PlayerPrefs.SetInt("PockySkinSignDay" .. (getProxy(PlayerProxy):getRawData().id or "-1"), self.startDay)
	end

	if var_13_13 == 2 then
		setActive(var_13_5, false)
		setActive(var_13_6, false)
		setActive(self.taskDesc, false)
		setActive(self.signDesc, true)
		setText(self.signDesc:Find("title"), i18n("pocky_jiujiu"))
		setText(self.signDesc:Find("desc"), i18n("pocky_jiujiu_desc"))
		setActive(var_13_1, false)
		setActive(var_13_3, true)
		setActive(var_13_2, false)
		setActive(var_13_4, false)
		onButton(self, var_13_3, function()
			local var_14_0 = self.GetCurrentDay()

			if var_14_0 > self.startDay then
				self.startDay = var_14_0

				PlayerPrefs.SetInt("PockySkinSignDay" .. (getProxy(PlayerProxy):getRawData().id or "-1"), self.startDay)
				self:OnUpdateFlush()
			end

			return
		end, SFX_PANEL)
		removeOnButton(var_13_4)

		return
	end

	local var_13_16
	local var_13_17

	if self.ptData.level >= #self.ptData.targets and self.nday >= #self.taskGroup and var_13_11 == 2 and self.nday2 >= #self.taskGroup2 and var_13_12 == 2 then
		setActive(var_13_3, false)

		var_13_16 = var_13_2
		var_13_17 = var_13_10
	elseif self.nday <= self.nday2 and var_13_11 ~= 2 then
		setActive(var_13_2, false)

		var_13_16 = var_13_3
		var_13_17 = var_13_8
	else
		setActive(var_13_3, false)

		var_13_16 = var_13_2
		var_13_17 = var_13_9
	end

	local var_13_19 = var_13_17:getConfig("award_display")[1]
	local var_13_20 = {
		type = var_13_19[1],
		id = var_13_19[2],
		count = var_13_19[3]
	}

	setActive(var_13_5, true)
	updateDrop(var_13_5, var_13_20)
	onButton(self, var_13_5, function()
		self:emit(BaseUI.ON_DROP, var_13_20)

		return
	end, SFX_PANEL)
	setActive(var_13_6, true)
	setActive(self.taskDesc, true)
	setActive(self.signDesc, false)
	setText(self.taskDesc:Find("title"), var_13_17:getConfig("name"))
	setText(self.taskDesc:Find("desc"), var_13_17:getConfig("desc"))
	setSlider(var_13_6, 0, var_13_17:getConfig("target_num"), (var_13_17:getProgress()))

	local var_13_21 = var_13_17:getTaskStatus()

	setActive(var_13_1, var_13_21 == 0)
	setActive(var_13_16, var_13_21 == 1)
	setActive(var_13_4, var_13_21 == 2)
	onButton(self, var_13_1, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_13_17)

		return
	end, SFX_PANEL)
	onButton(self, var_13_16, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_17)

		return
	end, SFX_PANEL)

	return
end

function PockySkinPage:UpdatePTList()
	if not self.ptData then
		return
	end

	local var_18_0 = self.ptData:getTargetLevel()
	local var_18_1 = self.ActPT:getConfig("config_client").story

	if checkExist(var_18_1, {
		var_18_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_18_1[var_18_0][1])
	end

	local var_18_2, var_18_3 = self.ptData:GetResProgress()
	local var_18_4 = self.ptData:GetTotalResRequire()

	setSlider(self.rightStage:Find("slider"), 0, 1, math.min(var_18_2, var_18_3) / var_18_4)
	setSlider(self.rightStage:Find("slider_total"), 0, 1, self.ptData:GetUnlockedMaxResRequire() / var_18_4)

	local var_18_5 = self.ptData:CanGetAward()
	local var_18_6 = self.ptData:CanGetNextAward()

	setActive(self.rightStage:Find("battle_btn"), self.ptData:CanGetMorePt() and not var_18_5 and var_18_6)
	setActive(self.rightStage:Find("get_btn"), var_18_5)
	setActive(self.rightStage:Find("got_btn"), not var_18_6)

	return
end

function PockySkinPage:OnDestroy()
	if self.spineLRQ then
		self.spineLRQ:Stop()

		self.spineLRQ = nil
	end

	if self.spine then
		self.spine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar("beierfasite_4", self.spine)

		self.spine = nil
	end

	return
end

return PockySkinPage
