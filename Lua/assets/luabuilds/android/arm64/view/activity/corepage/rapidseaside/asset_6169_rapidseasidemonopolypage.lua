local RapidSeasideMonopolyPage = class("RapidSeasideMonopolyPage", import("view.activity.CorePage.CoreActivityPage"))

function RapidSeasideMonopolyPage:OnInit()
	self.startBtn = self._tf:Find("AD/start")
	self.leftCountTxt = self.startBtn:Find("Text"):GetComponent(typeof(Text))
	self.turnTxt = self._tf:Find("AD/loop_cnt/turn"):GetComponent(typeof(Text))
	self.turnCntTxt = self._tf:Find("AD/loop_cnt/turn_cnt"):GetComponent(typeof(Text))
	self.progressTxt = self._tf:Find("AD/loop_cnt/progress"):GetComponent(typeof(Text))
	self.progressCntTxt = self._tf:Find("AD/loop_cnt/progress_cnt"):GetComponent(typeof(Text))
	self.turnAwards = {
		self._tf:Find("AD/turn_awards/award_1"),
		self._tf:Find("AD/turn_awards/award_2"),
		self._tf:Find("AD/turn_awards/award_3")
	}
	self.turnGetBtn = self._tf:Find("AD/turn_awards/get_btn")
	self.turnGotBtn = self._tf:Find("AD/turn_awards/got_btn")
	self.progressImage = self._tf:Find("AD/turn_awards/progress/bar")
	self.title = self._tf:Find("AD/RapidSeasideTitle Variant/Main/title")
	self._paintingParticles = self._tf:Find("AD/RapidSeasideTitle Variant/Main/title/title_2/Particle System")
	self._paintingParticleSystem = self._paintingParticles:GetComponent(typeof(ParticleSystem))
	self.btnManual = self._tf:Find("TopPage/top/manual")
	self.Txtmanual = self.btnManual:Find("Text")
	self.redMalPoint = self.btnManual:Find("tip")

	for iter_1_0, iter_1_1 in ipairs(self.turnAwards) do
		setActive(iter_1_1:Find("can_get_mask"), false)
	end

	onButton(self, self.startBtn, function()
		if not self.activity or self.activity:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		setActive(self.title, false)
		self._paintingParticleSystem:Stop(true)
		self:emit(ActivityMediator.GO_MONOPOLY2026, self.activity.id, function()
			setActive(self.title, true)
			self._paintingParticleSystem:Play()
			self:OnUpdateFlush()

			return
		end)

		return
	end, SFX_PANEL)

	self.taskGoBtn = self._tf:Find("AD/loop_progress/go_btn")
	self.taskGetBtn = self._tf:Find("AD/loop_progress/get_btn")
	self.taskGotBtn = self._tf:Find("AD/loop_progress/got_btn")
	self.taskDesc = self._tf:Find("AD/loop_progress/Text"):GetComponent(typeof(Text))
	self.taskAward = self._tf:Find("AD/loop_progress/award")
	self.taskProgress = self._tf:Find("AD/loop_progress/taskProgress")

	return
end

function RapidSeasideMonopolyPage:OnDataSetting()
	return
end

function RapidSeasideMonopolyPage:OnFirstFlush()
	for iter_5_0, iter_5_1 in ipairs(self.turnAwards) do
		setText(iter_5_1:Find("bg_lock/Text"), i18n("RapidSeasideMonopolyPage_award_loop" .. iter_5_0))
		setText(iter_5_1:Find("bg_unlock/Text"), i18n("RapidSeasideMonopolyPage_award_loop" .. iter_5_0))
	end

	onButton(self, self.btnManual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = RapidSeasideMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	setText(self.Txtmanual, i18n("anniversary_nine_main_page"))
	self:UpdateRed()

	return
end

function RapidSeasideMonopolyPage:OnUpdateFlush()
	self:UpdateTurnAwards()
	self:UpdateTask()
	self:UpdateRed()

	return
end

function RapidSeasideMonopolyPage:UpdateTurnAwards()
	local var_8_0 = self.activity
	local var_8_1

	if pg.gameset.MONOPOLY_AWARD_LIST then
		var_8_1 = pg.gameset.MONOPOLY_AWARD_LIST.description or {
			3,
			6,
			9
		}
	end

	local var_8_2 = var_8_1[3]
	local var_8_3 = (self.activity.data1_list[3] or 1) - 1
	local var_8_4 = self.activity.data1_list[6] or 0

	self.turnTxt.text = i18n("RapidSeasideMonopolyPage_turn_cnt_tip")
	self.turnCntTxt.text = var_8_3 .. "/" .. var_8_2

	local var_8_5 = (math.max(self.activity.data2, 1) - 1) / #(self.activity:getDataConfig("map") or {})

	if var_8_5 == 0 and var_8_3 > 0 then
		var_8_5 = 1
	end

	self.progressTxt.text = i18n("RapidSeasideMonopolyPage_progress_tip")
	self.progressCntTxt.text = string.format("%.1f", var_8_5 * 100) .. "%"

	local var_8_6 = self.activity:getDataConfig("sum_lap_reward_show")
	local var_8_7 = false
	local var_8_8 = 0

	for iter_8_0, iter_8_1 in ipairs(self.turnAwards) do
		local var_8_9 = Drop.New({
			type = var_8_6[iter_8_0][1],
			id = var_8_6[iter_8_0][2],
			count = var_8_6[iter_8_0][3]
		})
		local var_8_10 = var_8_1[iter_8_0]
		local var_8_11 = var_8_1[iter_8_0] <= var_8_3 and var_8_4 < var_8_10

		updateDrop(iter_8_1:Find("mask"), var_8_9)
		onButton(self, iter_8_1, function()
			self:emit(BaseUI.ON_DROP, var_8_9)

			return
		end, SFX_PANEL)
		setActive(iter_8_1:Find("got"), var_8_10 <= var_8_4)
		setActive(iter_8_1:Find("bg_lock"), var_8_10 <= var_8_3)
		setActive(iter_8_1:Find("bg_unlock"), var_8_3 < var_8_10)

		if var_8_8 == 0 and var_8_11 then
			var_8_8 = var_8_10
		end

		setActive(iter_8_1:Find("can_get_mask"), var_8_11)

		var_8_7 = var_8_7 or var_8_11
	end

	setActive(self.turnGotBtn, not var_8_7)
	setActive(self.turnGetBtn, var_8_7)

	self.leftCountTxt.text = i18n("MonopolyCar2024Game_total_num_tip", math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + (self.activity.data1_list[1] or 0) - (self.activity.data1_list[2] or 0))

	onButton(self, self.turnGetBtn, function()
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = var_8_0.id,
			arg1 = var_8_8,
			cmd = ActivityConst.MONOPOLY_OP_ROUND_AWD
		})

		return
	end, SFX_PANEL)

	return
end

function RapidSeasideMonopolyPage:UpdateTask()
	local var_11_0 = getProxy(TaskProxy)
	local var_11_1 = var_11_0:getTaskById(pg.activity_template[pg.activity_template[self.activity.id].config_data[1]].config_data[1]) or var_11_0:getFinishTaskById(pg.activity_template[pg.activity_template[self.activity.id].config_data[1]].config_data[1]) or Task.New({
		id = pg.activity_template[pg.activity_template[self.activity.id].config_data[1]].config_data[1]
	})
	local var_11_2 = var_11_0:getTaskById(pg.activity_template[pg.activity_template[self.activity.id].config_data[1]].config_data[1])
	local var_11_3 = var_11_1:getConfig("award_display")[1]
	local var_11_4 = Drop.New({
		type = var_11_3[1],
		id = var_11_3[2],
		count = var_11_3[3]
	})

	updateDrop(self.taskAward:Find("mask"), var_11_4)
	onButton(self, self.taskAward, function()
		self:emit(BaseUI.ON_DROP, var_11_4)

		return
	end, SFX_PANEL)

	local var_11_5 = var_11_1:getConfig("target_num")

	if var_11_2 ~= nil then
		local var_11_6 = math.min(var_11_1:getProgress(), var_11_5)

		setSlider(self.taskProgress, 0, var_11_5, var_11_6)

		local var_11_7 = var_11_1:getConfig("desc")

		for iter_11_0, iter_11_1 in ipairs({
			var_11_6
		}) do
			var_11_7 = string.gsub(var_11_7, "$" .. iter_11_0, iter_11_1)
		end

		self.taskDesc.text = var_11_7

		local var_11_8 = var_11_1:isFinish()
		local var_11_9 = var_11_1:isReceive()

		setActive(self.taskGoBtn, not var_11_8 and not var_11_9)
		setActive(self.taskGetBtn, var_11_8 and not var_11_9)
		setActive(self.taskGotBtn, var_11_9)
	else
		local var_11_10 = var_11_5

		setSlider(self.taskProgress, 0, var_11_5, var_11_5)

		local var_11_11 = var_11_1:getConfig("desc")

		for iter_11_2, iter_11_3 in ipairs({
			var_11_10
		}) do
			var_11_11 = string.gsub(var_11_11, "$" .. iter_11_2, iter_11_3)
		end

		self.taskDesc.text = var_11_11

		setActive(self.taskGoBtn, false)
		setActive(self.taskGetBtn, false)
		setActive(self.taskGotBtn, true)
	end

	onButton(self, self.taskGetBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_11_1, function(arg_14_0)
			if arg_14_0 then
				self:OnUpdateFlush()
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.taskGoBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function RapidSeasideMonopolyPage:UpdateRed()
	if pg.activity_template[self.activity.id].config_client.is_showMedal then
		setActive(self.redMalPoint, ActivityMedalGroup.showTip(pg.activity_template[self.activity.id].config_client.medal_group_id))
	end

	return
end

function RapidSeasideMonopolyPage:OnHideFlush()
	return
end

function RapidSeasideMonopolyPage:OnDestroy()
	return
end

return RapidSeasideMonopolyPage
