local TaiyuanAlterItemPage = class("TaiyuanAlterItemPage", import(".TemplatePage.SkinTemplatePage"))

function TaiyuanAlterItemPage:UpdateTask(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2:Find("item")
	local var_1_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_1_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_1_1 + 1])

	assert(var_1_1, "without this task by id: " .. self.taskGroup[self.nday][arg_1_1 + 1])

	local var_1_2 = Drop.Create(var_1_1:getConfig("award_display")[1])

	updateDrop(var_1_0, var_1_2)
	onButton(self, var_1_0, function()
		self:emit(BaseUI.ON_DROP, var_1_2)

		return
	end, SFX_PANEL)

	local var_1_3 = var_1_1:getProgress()
	local var_1_4 = var_1_1:getConfig("target_num")

	setText(arg_1_2:Find("description"), var_1_1:getConfig("desc"))

	local var_1_5, var_1_6 = self:GetProgressColor()

	setText(arg_1_2:Find("progressText"), "<color=#E95545>" .. (var_1_5 and setColorStr(var_1_3, var_1_5) or var_1_3) .. "</color><color=#6D8189>" .. (var_1_6 and setColorStr("/" .. var_1_4, var_1_6) or "/" .. var_1_4) .. "</color>")
	setSlider(arg_1_2:Find("progress"), 0, var_1_4, var_1_3)

	local var_1_8 = arg_1_2:Find("go_btn")
	local var_1_9 = arg_1_2:Find("get_btn")
	local var_1_10 = arg_1_2:Find("got_btn")
	local var_1_11 = var_1_1:getTaskStatus()

	setActive(var_1_8, var_1_11 == 0)
	setActive(var_1_9, var_1_11 == 1)
	setActive(var_1_10, var_1_11 == 2)
	onButton(self, var_1_8, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_1_1)

		return
	end, SFX_PANEL)
	onButton(self, var_1_9, function()
		self:emit(ActivityMediator.ON_TASK_SUBMIT, var_1_1)

		return
	end, SFX_PANEL)

	return
end

return TaiyuanAlterItemPage
