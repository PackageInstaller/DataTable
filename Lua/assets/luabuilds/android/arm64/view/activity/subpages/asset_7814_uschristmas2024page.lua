local USChristmas2024Page = class("USChristmas2024Page", import("view.base.BaseActivityPage"))

function USChristmas2024Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.awardNum = self.bg:Find("awardNum")
	self.linkBtn = self.bg:Find("linkBtn")

	setActive(self.item, false)

	return
end

function USChristmas2024Page:OnDataSetting()
	self.nday = 0
	self.activityTaskProxy = getProxy(ActivityTaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")

	return
end

function USChristmas2024Page:OnFirstFlush()
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function USChristmas2024Page:UpdateTask(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:Find("item")
	local var_5_1 = self.taskGroup[self.nday][arg_5_1 + 1]
	local var_5_2
	local var_5_3 = false

	for iter_5_0, iter_5_1 in ipairs((self.activityTaskProxy:getTaskById(self.activity.id))) do
		if iter_5_1.id == self.taskGroup[self.nday][arg_5_1 + 1] then
			var_5_2 = iter_5_1

			break
		end
	end

	if not var_5_2 then
		for iter_5_2, iter_5_3 in ipairs((self.activityTaskProxy:getFinishTaskById(self.activity.id))) do
			if iter_5_3.id == self.taskGroup[self.nday][arg_5_1 + 1] then
				var_5_2 = iter_5_3
				var_5_3 = true

				break
			end
		end
	end

	assert(var_5_2, "without this task by id: " .. self.taskGroup[self.nday][arg_5_1 + 1])

	local var_5_4 = Drop.Create(var_5_2:getConfig("award_display")[1])

	updateDrop(var_5_0, var_5_4)
	onButton(self, var_5_0, function()
		self:emit(BaseUI.ON_DROP, var_5_4)

		return
	end, SFX_PANEL)

	local var_5_5 = var_5_2:getProgress()
	local var_5_6 = var_5_2:getConfig("target_num")

	setText(arg_5_2:Find("description"), var_5_2:getConfig("desc"))

	local var_5_7, var_5_8 = self:GetProgressColor()

	setText(arg_5_2:Find("progressText"), (var_5_7 and setColorStr(var_5_5, var_5_7) or var_5_5) .. (var_5_8 and setColorStr("/" .. var_5_6, var_5_8) or "/" .. var_5_6))
	setSlider(arg_5_2:Find("progress"), 0, var_5_6, var_5_5)

	local var_5_10 = arg_5_2:Find("go_btn")
	local var_5_11 = arg_5_2:Find("get_btn")
	local var_5_12 = arg_5_2:Find("got_btn")
	local var_5_13 = var_5_2:getTaskStatus()

	setActive(var_5_10, not var_5_3 and var_5_13 == 0)
	setActive(var_5_11, not var_5_3 and var_5_13 == 1)
	setActive(var_5_12, var_5_3)
	onButton(self, var_5_10, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_5_2)

		return
	end, SFX_PANEL)
	onButton(self, var_5_11, function()
		local var_8_0 = {}
		local var_8_1 = var_5_2:getConfig("award_display")
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
			self:emit(ActivityMediator.ON_ACTIVITY_TASK_SUBMIT, {
				activityId = self.activity.id,
				id = var_5_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function USChristmas2024Page:OnUpdateFlush()
	self.nday = self.activity:GetCurrentDay()

	local var_11_1 = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").link_act_id)

	setText(self.awardNum, (var_11_1 or nil) and var_11_1.data1)
	onButton(self, self.linkBtn, function()
		Application.OpenURL(self.activity:getConfig("config_client").url)

		return
	end, SFX_PANEL)
	self.uilist:align(#self.taskGroup[self.nday])

	return
end

function USChristmas2024Page:OnDestroy()
	eachChild(self.items, function(arg_14_0)
		Destroy(arg_14_0)

		return
	end)

	return
end

function USChristmas2024Page:GetProgressColor()
	return nil
end

return USChristmas2024Page
