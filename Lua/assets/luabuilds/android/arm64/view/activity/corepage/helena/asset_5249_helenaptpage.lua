local HelenaPTPage = class("HelenaPTPage", import("view.activity.CorePage.CoreActivityPage"))

function HelenaPTPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.task_bg = self.bg:Find("task_bg")
	self.slider = self.task_bg:Find("slider")
	self.step = self.task_bg:Find("step")
	self.progres = self.task_bg:Find("progres")
	self.displayBtn = self.task_bg:Find("display_btn")
	self.awardTF = self.task_bg:Find("award")
	self.battleBtn = self.task_bg:Find("battle_btn")
	self.getBtn = self.task_bg:Find("get_btn")
	self.gotBtn = self.task_bg:Find("got_btn")
	self.skinBtn = self.bg:Find("skinbtn")
	self.scenario = HelenaScenarioPage.New(self._tf, self.event)

	self.scenario:SetCoreStoryPage(self)
	self.scenario:RegisterView(self.coreActivityUI)

	self.loader = AutoLoader.New()
	self.mapGroup = {}
	self.currentBG = nil

	setText(self.task_bg:Find("Text"), i18n("Outpost_20250904_Progress"))
	setText(self.task_bg:Find("display_btn/Text"), i18n("other_world_temple_award"))

	return
end

function HelenaPTPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function HelenaPTPage:OnShowFlush()
	HelenaPTPage.super.OnShowFlush(self)

	if self.contextData.activeScenario then
		triggerButton(self.skinBtn)
	end

	return
end

function HelenaPTPage:OnFirstFlush()
	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			blur = true,
			type = self.ptData.type,
			dropList = self.ptData.dropList,
			targets = self.ptData.targets,
			level = self.ptData.level,
			count = self.ptData.count,
			resId = self.ptData.resId,
			unlockStamps = self.ptData:GetDayUnlockStamps()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:GetAllAward()

		return
	end, SFX_PANEL)
	self:OnAddUI()
	self:OnUpdateFlush()

	return
end

function HelenaPTPage:OnAddUI()
	onButton(self, self.skinBtn, function()
		self.scenario:Load()
		self.scenario:SetActivity(self.activity)
		self.scenario:UpdateStoryTask()
		self.scenario:ActionInvoke("UpdateView")
		self:ShowScenarioLayer(true)

		return
	end, SFX_PANEL)
	setActive(self.skinBtn:Find("red"), self.scenario:IsShowRed(self.activity))

	return
end

function HelenaPTPage:SwitchBG(arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or #arg_10_1 <= 0 then
		existCall(arg_10_2)

		return
	elseif arg_10_3 then
		-- block empty
	elseif table.equal(self.currentBG, arg_10_1) then
		return
	end

	self.currentBG = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(self.mapGroup) do
		self.loader:ClearRequest(iter_10_1)
	end

	table.clear(self.mapGroup)
	table.insert(self.mapGroup, (self.loader:GetSpriteDirect("bg/" .. arg_10_1[1].BG, "", function(arg_11_0)
		setImageSprite(self.bg, arg_11_0)
		SetActive(self.bg, true)

		return
	end)))

	return
end

function HelenaPTPage:ShowScenarioLayer(arg_12_1)
	if arg_12_1 then
		self.coreActivityUI:ActiveScenarioLayer(true)
		self.scenario:ActionInvoke("Show")
	else
		self.scenario:Hide()
		setActive(self.skinBtn:Find("red"), self.scenario:IsShowRed(self.activity))
		self.coreActivityUI:ActiveScenarioLayer(false)
	end

	return
end

function HelenaPTPage:IsShowingPopWindow()
	return self.scenario:isShowing()
end

function HelenaPTPage:ClosePopWindow()
	self.scenario:Hide()
	self:ShowScenarioLayer(false)

	return
end

function HelenaPTPage:GetAllAward()
	local var_15_0 = {}
	local var_15_1 = self.ptData:GetAward()
	local var_15_2 = getProxy(PlayerProxy):getRawData()
	local var_15_3, var_15_4 = Task.StaticJudgeOverflow(var_15_2.gold, var_15_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
		{
			var_15_1.type,
			var_15_1.id,
			var_15_1.count
		}
	})

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
		local var_17_0, var_17_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_17_1
		})

		return
	end)

	return
end

function HelenaPTPage:OnUpdateFlush()
	local var_18_0, var_18_1, var_18_2 = self.ptData:GetLevelProgress()

	if self.step then
		setText(self.step, var_18_0 .. "/" .. var_18_1)
	end

	local var_18_3 = self.activity:getConfig("config_client").story

	if checkExist(var_18_3, {
		var_18_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_18_3[var_18_0][1])
	end

	local var_18_4, var_18_5, var_18_6 = self.ptData:GetResProgress()

	if var_18_5 < var_18_4 then
		var_18_4 = var_18_5
	end

	setText(self.progres, setColorStr(var_18_4, "#3f93d4") .. setColorStr("/" .. var_18_5, "#747c88"))
	setSlider(self.slider, 0, 1, var_18_6)

	local var_18_7 = self.ptData:CanGetAward()
	local var_18_8 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_18_7 and var_18_8)
	setActive(self.getBtn, var_18_7)
	setActive(self.gotBtn, not var_18_8)

	local var_18_9 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_18_9)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_18_9)

		return
	end, SFX_PANEL)

	return
end

function HelenaPTPage:OnDestroy()
	if self.scenario:isShowing() then
		self.scenario:Hide()
	end

	self.scenario:Destroy()

	return
end

function HelenaPTPage:GetWorldPtData(arg_21_1)
	if arg_21_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

return HelenaPTPage
