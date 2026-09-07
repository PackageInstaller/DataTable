local DALFavorabilityPage = class("DALFavorabilityPage", import("view.activity.CorePage.CoreActivityPage"))

function DALFavorabilityPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.progres = self.bg:Find("progres")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.displayBtn = self.bg:Find("display_btn")
	self.vx_get = self.bg:Find("vx_get")

	return
end

function DALFavorabilityPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function DALFavorabilityPage:OnFirstFlush()
	SetActive(self.vx_get, false)
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

	return
end

function DALFavorabilityPage:GetAllAward()
	local var_7_0 = {}
	local var_7_1 = self.ptData:GetAward()
	local var_7_2 = getProxy(PlayerProxy):getRawData()
	local var_7_3, var_7_4 = Task.StaticJudgeOverflow(var_7_2.gold, var_7_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
		{
			var_7_1.type,
			var_7_1.id,
			var_7_1.count
		}
	})

	if var_7_3 then
		table.insert(var_7_0, function(arg_8_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_7_4,
				onYes = arg_8_0
			})

			return
		end)
	end

	seriesAsync(var_7_0, function()
		local var_9_0, var_9_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_9_1
		})

		return
	end)
	SetActive(self.vx_get, true)

	return
end

function DALFavorabilityPage:OnUpdateFlush()
	updateDrop(self.awardTF:Find("IconTpl"), (self.ptData:GetAward()))

	local var_10_0, var_10_1, var_10_2 = self.ptData:GetResProgress()

	setText(self.progres, setColorStr(var_10_0, "#ffffff") .. setColorStr("/" .. var_10_1, "#DD9D9D"))

	local var_10_3 = self.ptData:CanGetAward()
	local var_10_4 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_10_3 and var_10_4)
	setActive(self.getBtn, var_10_3)
	setActive(self.gotBtn, not var_10_4)

	for iter_10_0 = 1, 10 do
		if iter_10_0 <= self.ptData:GetLevel() then
			SetActive(self.bg:Find("schedule/" .. iter_10_0 .. "/on"), true)
			SetActive(self.bg:Find("schedule/" .. iter_10_0 .. "/not"), false)
		else
			SetActive(self.bg:Find("schedule/" .. iter_10_0 .. "/on"), false)
			SetActive(self.bg:Find("schedule/" .. iter_10_0 .. "/not"), true)
		end
	end

	return
end

function DALFavorabilityPage:GetWorldPtData(arg_11_1)
	if arg_11_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

return DALFavorabilityPage
