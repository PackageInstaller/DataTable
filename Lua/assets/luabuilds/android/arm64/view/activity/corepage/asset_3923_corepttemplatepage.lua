local CorePtTemplatePage = class("CorePtTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

function CorePtTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.slider = self.bg:Find("slider")
	self.step = self.bg:Find("step")
	self.progress = self.bg:Find("progress")
	self.displayBtn = self.bg:Find("display_btn")
	self.awardTF = self.bg:Find("award")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")

	return
end

function CorePtTemplatePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function CorePtTemplatePage:OnFirstFlush()
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
		local var_5_0
		local var_5_1

		if self.activity:getConfig("config_client") ~= "" then
			var_5_0 = self.activity:getConfig("config_client").linkActID

			if var_5_0 then
				var_5_1 = getProxy(ActivityProxy):getActivityById(var_5_0)
			end
		end

		if not var_5_0 then
			self:emit(ActivityMediator.BATTLE_OPERA)
		elseif var_5_1 and not var_5_1:isEnd() then
			self:emit(ActivityMediator.BATTLE_OPERA)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_6_0 = {}
		local var_6_1 = self.ptData:GetAward()
		local var_6_2 = getProxy(PlayerProxy):getRawData()
		local var_6_3, var_6_4 = Task.StaticJudgeOverflow(var_6_2.gold, var_6_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_6_1.type,
				var_6_1.id,
				var_6_1.count
			}
		})

		if var_6_3 then
			table.insert(var_6_0, function(arg_7_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_6_4,
					onYes = arg_7_0
				})

				return
			end)
		end

		seriesAsync(var_6_0, function()
			local var_8_0, var_8_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_8_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function CorePtTemplatePage:OnUpdateFlush()
	local var_9_0 = self.ptData:getTargetLevel()
	local var_9_1 = self.activity:getConfig("config_client").story

	if checkExist(var_9_1, {
		var_9_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_9_1[var_9_0][1])
	end

	if self.step then
		local var_9_2, var_9_3, var_9_4 = self.ptData:GetLevelProgress()

		setText(self.step, var_9_2 .. "/" .. var_9_3)
	end

	local var_9_5, var_9_6, var_9_7 = self.ptData:GetResProgress()

	setText(self.progress, (var_9_7 >= 1 and setColorStr(var_9_5, COLOR_GREEN) or var_9_5) .. "/" .. var_9_6)
	setSlider(self.slider, 0, 1, var_9_7)

	local var_9_8 = self.ptData:CanGetAward()
	local var_9_9 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_9_8 and var_9_9)
	setActive(self.getBtn, var_9_8)
	setActive(self.gotBtn, not var_9_9)

	local var_9_10 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_9_10)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_9_10)

		return
	end, SFX_PANEL)

	return
end

function CorePtTemplatePage:OnDestroy()
	return
end

function CorePtTemplatePage:GetWorldPtData(arg_12_1)
	if arg_12_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

return CorePtTemplatePage
