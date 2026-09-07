local LeMarsReSkinPage = class("LeMarsReSkinPage", import(".TemplatePage.SkinTemplatePage"))

function LeMarsReSkinPage:OnInit()
	LeMarsReSkinPage.super.OnInit(self)

	self.displayBtn = self.bg:Find("display_btn")

	return
end

function LeMarsReSkinPage:OnFirstFlush()
	LeMarsReSkinPage.super.OnFirstFlush(self)
	onButton(self, self.displayBtn, function()
		local var_3_0 = {}
		local var_3_1 = {}
		local var_3_2 = self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])
		local var_3_3 = var_3_2:getProgress()
		local var_3_4 = self.nday

		for iter_3_0, iter_3_1 in ipairs(self.activity:getConfig("config_data")) do
			for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
				if pg.task_data_template[iter_3_3] and pg.task_data_template[iter_3_3].award_display and pg.task_data_template[iter_3_3].award_display[1] then
					table.insert(var_3_0, pg.task_data_template[iter_3_3].award_display[1])
					table.insert(var_3_1, pg.task_data_template[iter_3_3].target_num)
				end
			end
		end

		if var_3_2:getTaskStatus() ~= 2 then
			var_3_4 = var_3_4 - 1
		end

		self:emit(ActivityMediator.ON_AWARD_WINDOW, var_3_0, var_3_4, {
			i18n("LeMarsReSkinPage_reward_target"),
			i18n("LeMarsReSkinPage_reward_title")
		}, {
			targetList = var_3_1,
			nowGet = var_3_3
		})

		return
	end, SFX_PANEL)

	return
end

function LeMarsReSkinPage:UpdateTask(arg_4_1, arg_4_2)
	local var_4_1 = arg_4_2:Find("award")
	local var_4_2 = self.taskProxy:getTaskById(self.taskGroup[self.nday][1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][1])

	assert(var_4_2, "without this task by id: " .. self.taskGroup[self.nday][1])

	local var_4_3 = Drop.Create(var_4_2:getConfig("award_display")[1])

	updateDrop(var_4_1, var_4_3)
	onButton(self, var_4_1, function()
		self:emit(BaseUI.ON_DROP, var_4_3)

		return
	end, SFX_PANEL)

	local var_4_4 = var_4_2:getProgress()
	local var_4_5 = var_4_2:getConfig("target_num")

	setScrollText(arg_4_2:Find("mask/description"), var_4_2:getConfig("desc"))

	local var_4_6, var_4_7 = self:GetProgressColor()

	setText(arg_4_2:Find("progress"), (var_4_6 and setColorStr(var_4_4, var_4_6) or var_4_4) .. (var_4_7 and setColorStr("/" .. var_4_5, var_4_7) or "/" .. var_4_5))
	setSlider(arg_4_2:Find("slider"), 0, var_4_5, var_4_4)

	local var_4_9 = arg_4_2:Find("go_btn")
	local var_4_10 = arg_4_2:Find("get_btn")
	local var_4_11 = arg_4_2:Find("got_btn")
	local var_4_12 = var_4_2:getTaskStatus()

	setActive(var_4_9, var_4_12 == 0)
	setActive(var_4_10, var_4_12 == 1)
	setActive(var_4_11, var_4_12 == 2)
	onButton(self, var_4_9, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_4_2)

		return
	end, SFX_PANEL)
	onButton(self, var_4_10, function()
		local var_7_0 = {}
		local var_7_1 = var_4_2:getConfig("award_display")
		local var_7_2 = getProxy(PlayerProxy):getRawData()
		local var_7_3, var_7_4 = Task.StaticJudgeOverflow(var_7_2.gold, var_7_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_7_1)

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
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_2)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function LeMarsReSkinPage:GetProgressColor()
	return "#1EA2ACFF", "#3DCCD7"
end

return LeMarsReSkinPage
