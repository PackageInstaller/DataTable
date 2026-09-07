local DayDoubleTaskTemplatePage = class("DayDoubleTaskTemplatePage", import("view.base.BaseActivityPage"))

function DayDoubleTaskTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.dayTF = self.bg:Find("total_progress/day")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)

	setActive(self.item, false)

	self.progressLabel = self.bg:Find("total_progress/label")

	setText(self.progressLabel, i18n("Outpost_20250904_Progress"))

	return
end

function DayDoubleTaskTemplatePage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")

	return updateActivityTaskStatus(self.activity)
end

function DayDoubleTaskTemplatePage:OnFirstFlush()
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function DayDoubleTaskTemplatePage:UpdateTask(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:Find("item")
	local var_5_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_5_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_5_1 + 1])

	assert(var_5_1, "without this task by id: " .. self.taskGroup[self.nday][arg_5_1 + 1])

	local var_5_2 = Drop.Create(var_5_1:getConfig("award_display")[1])

	updateDrop(var_5_0, var_5_2)
	onButton(self, var_5_0, function()
		self:emit(BaseUI.ON_DROP, var_5_2)

		return
	end, SFX_PANEL)

	local var_5_3 = var_5_1:getProgress()
	local var_5_4 = var_5_1:getConfig("target_num")

	setText(arg_5_2:Find("description"), var_5_1:getConfig("desc"))

	local var_5_5, var_5_6 = self:GetProgressColor()

	setText(arg_5_2:Find("progressText"), (var_5_5 and setColorStr(var_5_3, var_5_5) or var_5_3) .. (var_5_6 and setColorStr("/" .. var_5_4, var_5_6) or "/" .. var_5_4))
	setSlider(arg_5_2:Find("progress"), 0, var_5_4, var_5_3)

	local var_5_8 = arg_5_2:Find("go_btn")
	local var_5_9 = arg_5_2:Find("get_btn")
	local var_5_10 = arg_5_2:Find("got_btn")
	local var_5_11 = var_5_1:getTaskStatus()

	setActive(var_5_8, var_5_11 == 0)
	setActive(var_5_9, var_5_11 == 1)
	setActive(var_5_10, var_5_11 == 2)
	onButton(self, var_5_8, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_5_1)

		return
	end, SFX_PANEL)
	onButton(self, var_5_9, function()
		local var_8_0 = {}
		local var_8_1 = var_5_1:getConfig("award_display")
		local var_8_2 = getProxy(PlayerProxy):getRawData()
		local var_8_3, var_8_4 = Task.StaticJudgeOverflow(var_8_2.gold, var_8_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_8_1)

		if var_8_3 then
			table.insert(var_8_0, function(arg_9_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_8_4,
					onYes = arg_9_0
				})

				return
			end)
		end

		seriesAsync(var_8_0, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_5_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function DayDoubleTaskTemplatePage:OnUpdateFlush()
	self.nday = self.activity.data3

	self:PlayStory()
	self:UpdateProgress()
	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function UpdateProgress()
	if self.dayTF then
		setText(self.dayTF, self.nday .. "/" .. #self.taskGroup)
	end

	return
end

function DayDoubleTaskTemplatePage:PlayStory()
	local var_13_0 = self.activity:getConfig("config_client").story

	if checkExist(var_13_0, {
		self.nday
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_13_0[self.nday][1])
	end

	return
end

function DayDoubleTaskTemplatePage:OnDestroy()
	eachChild(self.items, function(arg_15_0)
		Destroy(arg_15_0)

		return
	end)

	return
end

function DayDoubleTaskTemplatePage:GetProgressColor()
	return nil
end

return DayDoubleTaskTemplatePage
