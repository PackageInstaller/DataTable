local MonopolyCar2024Page = class("MonopolyCar2024Page", import("view.base.BaseActivityPage"))

function MonopolyCar2024Page:OnInit()
	self.startBtn = self._tf:Find("AD/start")
	self.leftCountTxt = self.startBtn:Find("Text"):GetComponent(typeof(Text))
	self.turnCntTxt = self._tf:Find("AD/turn"):GetComponent(typeof(Text))
	self.progressTxt = self._tf:Find("AD/progress"):GetComponent(typeof(Text))
	self.turnAwards = {
		self._tf:Find("AD/turn_awards/award_1"),
		self._tf:Find("AD/turn_awards/award_2"),
		self._tf:Find("AD/turn_awards/award_3")
	}
	self.turnGoBtn = self._tf:Find("AD/turn_awards/battle_btn")
	self.turnGetBtn = self._tf:Find("AD/turn_awards/get_btn")
	self.progressImage = self._tf:Find("AD/turn_awards/progress/bar")

	onButton(self, self.startBtn, function()
		if not self.activity or self.activity:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		for iter_2_0, iter_2_1 in ipairs(self.turnAwards) do
			setActive(iter_2_1:Find("mark/get"), false)
		end

		self:emit(ActivityMediator.GO_MONOPOLY2024, self.activity.id, function()
			for iter_3_0, iter_3_1 in ipairs(self.turnAwards) do
				setActive(iter_3_1:Find("mark/get"), true)
			end

			return
		end)

		return
	end, SFX_PANEL)

	self.taskGoBtn = self._tf:Find("AD/battle_btn")
	self.taskGetBtn = self._tf:Find("AD/get_btn")
	self.taskGotBtn = self._tf:Find("AD/got_btn")
	self.taskDesc = self._tf:Find("AD/Text"):GetComponent(typeof(Text))
	self.taskAward = self._tf:Find("AD/award")
	self.taskProgress = self._tf:Find("AD/taskProgress")

	return
end

function MonopolyCar2024Page:OnDataSetting()
	return
end

function MonopolyCar2024Page:OnFirstFlush()
	return
end

function MonopolyCar2024Page:OnUpdateFlush()
	self:UpdateTurnAwards()
	self:UpdateTask()

	return
end

function MonopolyCar2024Page:UpdateTurnAwards()
	local var_7_0 = self.activity
	local var_7_1 = (self.activity.data1_list[3] or 1) - 1
	local var_7_2 = self.activity.data1_list[6] or 0

	self.turnCntTxt.text = var_7_1 .. "/" .. 3

	local var_7_3 = (math.max(self.activity.data2, 1) - 1) / #(self.activity:getDataConfig("map") or {})

	if var_7_3 == 0 and var_7_1 > 0 then
		var_7_3 = 1
	end

	self.progressTxt.text = string.format("%.1f", var_7_3 * 100) .. "%"

	local var_7_4 = var_7_2 + 1
	local var_7_5 = self.activity:getDataConfig("sum_lap_reward_show")

	for iter_7_0, iter_7_1 in ipairs(self.turnAwards) do
		local var_7_6 = Drop.New({
			type = var_7_5[iter_7_0][1],
			id = var_7_5[iter_7_0][2],
			count = var_7_5[iter_7_0][3]
		})

		updateDrop(iter_7_1:Find("mask"), var_7_6)
		onButton(self, iter_7_1, function()
			self:emit(BaseUI.ON_DROP, var_7_6)

			return
		end, SFX_PANEL)
		setActive(iter_7_1:Find("mark"), iter_7_0 == var_7_4)
		setActive(iter_7_1:Find("got"), iter_7_0 <= var_7_2)
	end

	local var_7_7 = 3 < var_7_4
	local var_7_8 = var_7_4 <= var_7_1

	setActive(self.turnGoBtn, not (var_7_4 <= var_7_1) and not var_7_7)
	setActive(self.turnGetBtn, var_7_8 and not var_7_7)

	local var_7_9 = {
		0.183,
		0.587,
		1
	}

	if var_7_1 <= 0 then
		setFillAmount(self.progressImage, 0)
	else
		setFillAmount(self.progressImage, (not var_7_9[var_7_1] or nil) and 1)
	end

	self.leftCountTxt.text = i18n("MonopolyCar2024Game_total_num_tip", math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + (self.activity.data1_list[1] or 0) - (self.activity.data1_list[2] or 0))

	onButton(self, self.turnGetBtn, function()
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = var_7_0.id,
			arg1 = var_7_4,
			cmd = ActivityConst.MONOPOLY_OP_ROUND_AWD
		})

		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2024Page:UpdateTask()
	local var_10_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.MONOPOLY_TASK_ACT_ID.act_id)

	if not var_10_0 or var_10_0:isEnd() then
		return
	end

	local var_10_1 = var_10_0:getConfig("config_data")[1]
	local var_10_2 = getProxy(TaskProxy)
	local var_10_3 = var_10_2:getTaskById(var_10_1) or var_10_2:getFinishTaskById(var_10_1) or Task.New({
		id = var_10_1
	})
	local var_10_4 = var_10_2:getTaskById(var_10_1)
	local var_10_5 = var_10_3:getConfig("award_display")[1]
	local var_10_6 = Drop.New({
		type = var_10_5[1],
		id = var_10_5[2],
		count = var_10_5[3]
	})

	updateDrop(self.taskAward:Find("mask"), var_10_6)
	onButton(self, self.taskAward, function()
		self:emit(BaseUI.ON_DROP, var_10_6)

		return
	end, SFX_PANEL)

	local var_10_7 = var_10_3:getConfig("target_num")

	if var_10_4 ~= nil then
		local var_10_8 = math.min(var_10_3:getProgress(), var_10_7)

		setSlider(self.taskProgress, 0, var_10_7, var_10_8)

		local var_10_9 = var_10_3:getConfig("desc")

		for iter_10_0, iter_10_1 in ipairs({
			var_10_8
		}) do
			var_10_9 = string.gsub(var_10_9, "$" .. iter_10_0, iter_10_1)
		end

		self.taskDesc.text = var_10_9

		local var_10_10 = var_10_3:isFinish()
		local var_10_11 = var_10_3:isReceive()

		setActive(self.taskGoBtn, not var_10_10 and not var_10_11)
		setActive(self.taskGetBtn, var_10_10 and not var_10_11)
		setActive(self.taskGotBtn, var_10_11)
	else
		local var_10_12 = var_10_7

		setSlider(self.taskProgress, 0, var_10_7, var_10_7)

		local var_10_13 = var_10_3:getConfig("desc")

		for iter_10_2, iter_10_3 in ipairs({
			var_10_12
		}) do
			var_10_13 = string.gsub(var_10_13, "$" .. iter_10_2, iter_10_3)
		end

		self.taskDesc.text = var_10_13

		setActive(self.taskGoBtn, false)
		setActive(self.taskGetBtn, false)
		setActive(self.taskGotBtn, true)
	end

	onButton(self, self.taskGetBtn, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_3, function(arg_13_0)
			if arg_13_0 then
				self:OnUpdateFlush()
			end

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2024Page:OnHideFlush()
	return
end

function MonopolyCar2024Page:OnDestroy()
	return
end

return MonopolyCar2024Page
