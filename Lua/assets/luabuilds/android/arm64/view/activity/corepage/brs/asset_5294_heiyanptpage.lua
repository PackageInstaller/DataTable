local HeiYanPtPage = class("HeiYanPtPage", import("view.activity.CorePage.CoreActivityPage"))

function HeiYanPtPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.task_bg = self.bg:Find("task_bg")
	self.slider = self.task_bg:Find("slider")
	self.step = self.task_bg:Find("step")
	self.progress = self.task_bg:Find("progress")
	self.progres = self.task_bg:Find("progres")
	self.displayBtn = self.task_bg:Find("display_btn")
	self.awardTF = self.task_bg:Find("award")
	self.battleBtn = self.task_bg:Find("battle_btn")
	self.getBtn = self.task_bg:Find("get_btn")
	self.gotBtn = self.task_bg:Find("got_btn")

	return
end

function HeiYanPtPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function HeiYanPtPage:OnFirstFlush()
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
	self:OnUpdateFlush()

	return
end

function HeiYanPtPage:GetAllAward()
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

	return
end

function HeiYanPtPage:OnUpdateFlush()
	local var_10_0, var_10_1, var_10_2 = self.ptData:GetLevelProgress()

	if self.step then
		setText(self.step, var_10_0 .. "/" .. var_10_1)
	end

	local var_10_3 = self.activity:getConfig("config_client").story

	if checkExist(var_10_3, {
		var_10_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_10_3[var_10_0][1])
	end

	local var_10_4, var_10_5, var_10_6 = self.ptData:GetResProgress()

	setText(self.progress, "/" .. var_10_5)
	setText(self.progres, var_10_6 >= 1 and setColorStr(var_10_4, "#6ef0ff") or var_10_4)
	setSlider(self.slider, 0, 1, var_10_6)

	local var_10_7 = self.ptData:CanGetAward()
	local var_10_8 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_10_7 and var_10_8)
	setActive(self.getBtn, var_10_7)
	setActive(self.gotBtn, not var_10_8)

	local var_10_9 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_10_9)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_10_9)

		return
	end, SFX_PANEL)

	return
end

function HeiYanPtPage:OnDestroy()
	return
end

function HeiYanPtPage:GetWorldPtData(arg_13_1)
	if arg_13_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

return HeiYanPtPage
