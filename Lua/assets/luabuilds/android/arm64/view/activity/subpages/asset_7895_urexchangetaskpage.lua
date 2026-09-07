local UrExchangeTaskPage = class("UrExchangeTaskPage", import("...base.BaseActivityPage"))

function UrExchangeTaskPage:OnInit()
	self.uilist = UIItemList.New(self._tf:Find("AD/task_list/content"), self._tf:Find("AD/task_list/content/tpl"))
	self.getBtn = self._tf:Find("AD/get_btn")
	self.gotBtn = self._tf:Find("AD/got_btn")
	self.unfinishBtn = self._tf:Find("AD/unfinish_btn")

	return
end

function UrExchangeTaskPage:OnDataSetting()
	if not self:GetTaskById(self.activity:getConfig("config_data")[1][1]) then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return true
	else
		return false
	end

	return
end

function UrExchangeTaskPage:OnUpdateFlush()
	local var_3_0 = _.map(self.activity:getConfig("config_data")[1], function(arg_4_0)
		return self:GetTaskById(arg_4_0)
	end)
	local var_3_1 = table.remove(var_3_0, #var_3_0)

	local function var_3_2(arg_5_0)
		if arg_5_0:isFinish() and not arg_5_0:isReceive() then
			return 0
		elseif arg_5_0:isReceive() then
			return 2
		else
			return 1
		end

		return
	end

	table.sort(var_3_0, function(arg_6_0, arg_6_1)
		return var_3_2(arg_6_0) < var_3_2(arg_6_1)
	end)
	self.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_7_2, var_3_0[arg_7_1 + 1])
		end

		return
	end)
	self.uilist:align(#var_3_0)

	local var_3_3 = var_3_1:isReceive()
	local var_3_4 = var_3_1:isFinish() and not var_3_3 and _.all(var_3_0, function(arg_8_0)
		return arg_8_0:isFinish() and arg_8_0:isReceive()
	end)

	onButton(self, self.getBtn, function()
		if var_3_4 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_1)
		end

		return
	end, SFX_PANEL)
	setActive(self.getBtn, var_3_4)
	setActive(self.unfinishBtn, not var_3_4 and not var_3_3)
	setActive(self.gotBtn, var_3_3)

	return
end

function UrExchangeTaskPage:GetTaskById(arg_10_1)
	local var_10_0 = getProxy(TaskProxy):getTaskById(arg_10_1)

	var_10_0 = var_10_0 or getProxy(TaskProxy):getFinishTaskById(arg_10_1)

	return var_10_0
end

function UrExchangeTaskPage:UpdateTask(arg_11_1, arg_11_2)
	assert(arg_11_2)
	setText(arg_11_1:Find("Text"), arg_11_2:getConfig("desc"))

	local var_11_0 = arg_11_2:getConfig("award_display")[1]

	assert(var_11_0, arg_11_2.id)
	assert(var_11_0)

	local var_11_1 = {
		type = var_11_0[1],
		id = var_11_0[2],
		count = var_11_0[3]
	}
	local var_11_2 = arg_11_1:Find("item")

	updateDrop(var_11_2, var_11_1)
	onButton(self, var_11_2, function()
		self:emit(BaseUI.ON_DROP, var_11_1)

		return
	end, SFX_PANEL)

	local var_11_3 = arg_11_2:isFinish()
	local var_11_4 = arg_11_2:isReceive()

	setActive(arg_11_1:Find("mark"), var_11_3 and not var_11_4)

	if var_11_3 and not var_11_4 then
		onButton(self, arg_11_1, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, arg_11_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_11_1)
	end

	setActive(arg_11_1:Find("progress_finish"), var_11_3 and var_11_4)

	local var_11_5 = arg_11_2:getProgress()
	local var_11_6 = arg_11_2:getConfig("target_num")

	setSlider(arg_11_1:Find("progress"), 0, 1, var_11_5 / var_11_6)
	setText(arg_11_1:Find("progress/Text"), var_11_3 and "" or var_11_5 .. "/" .. var_11_6)

	return
end

return UrExchangeTaskPage
