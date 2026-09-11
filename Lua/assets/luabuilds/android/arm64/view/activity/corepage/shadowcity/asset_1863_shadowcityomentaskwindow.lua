local ShadowCityOmenTaskWindow = class("ShadowCityOmenTaskWindow", import("view.activity.CorePage.OutPost.OutPostOmenTaskWindow"))

function ShadowCityOmenTaskWindow:getUIName()
	return "ShadowCityOmenTaskWindow"
end

function ShadowCityOmenTaskWindow:UpdateListItem(arg_2_1, arg_2_2)
	local var_2_0 = findTF(arg_2_2, "default")
	local var_2_1 = findTF(var_2_0, "tasks")
	local var_2_2 = findTF(arg_2_2, "lock")
	local var_2_3 = findTF(var_2_2, "desc")
	local var_2_4 = findTF(var_2_2, "lockItem_1/desc")
	local var_2_5 = findTF(var_2_2, "lockItem_2/desc")
	local var_2_6 = arg_2_1 + 1

	setText(findTF(var_2_0, "day"), "DAY " .. arg_2_1 + 1)

	for iter_2_0 = 0, var_2_1.childCount - 1 do
		self:UpdateTaskItem(arg_2_1 + 1, iter_2_0, (var_2_1:GetChild(iter_2_0)))
	end

	local var_2_7 = self:isTaskLock(arg_2_1 + 1)
	local var_2_8 = var_2_7 ~= 0

	setActive(var_2_2, var_2_7 ~= 0)

	GetOrAddComponent(var_2_0, typeof(CanvasGroup)).alpha = var_2_8 and 0.5 or 1

	switch(var_2_7, {
		function()
			local var_3_0, var_3_1 = self:getDate(self.month, self.day + var_2_6 - self.nday)

			setText(var_2_3, i18n("OutPostOmenPage_task_tip1", var_3_0, var_3_1))
			setText(var_2_4, i18n("OutPostOmenPage_task_tip1", var_3_0, var_3_1))
			setText(var_2_5, i18n("OutPostOmenPage_task_tip1", var_3_0, var_3_1))

			return
		end,
		function()
			setText(var_2_3, i18n("OutPostOmenPage_task_tip2"))
			setText(var_2_4, i18n("OutPostOmenPage_task_tip2"))
			setText(var_2_5, i18n("OutPostOmenPage_task_tip2"))

			return
		end
	})

	return
end

function ShadowCityOmenTaskWindow:UpdateTaskItem(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_3:Find("item")
	local var_5_1 = self.taskProxy:getTaskById(self.taskGroup[arg_5_1][arg_5_2 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[arg_5_1][arg_5_2 + 1])
	local var_5_2 = pg.task_data_template[self.taskGroup[arg_5_1][arg_5_2 + 1]]
	local var_5_3 = Drop.Create(pg.task_data_template[self.taskGroup[arg_5_1][arg_5_2 + 1]].award_display[1])

	updateDrop(var_5_0, var_5_3)
	onButton(self, var_5_0, function()
		self:emit(BaseUI.ON_DROP, var_5_3)

		return
	end, SFX_PANEL)

	local var_5_4 = var_5_1 and var_5_1:getProgress() or 0
	local var_5_5 = var_5_2.target_num

	setText(arg_5_3:Find("description"), var_5_2.desc)
	setSlider(arg_5_3:Find("progress"), 0, var_5_5, var_5_4)

	local var_5_6, var_5_7 = ShadowCityOmenTaskWindow:GetProgressColor()

	var_5_4 = var_5_6 and setColorStr(var_5_4, var_5_6) or var_5_4
	var_5_5 = var_5_7 and setColorStr(var_5_5, var_5_7) or var_5_5

	setText(arg_5_3:Find("progressText"), var_5_4 .. "/" .. var_5_5)
	setActive(arg_5_3:Find("got_btn"), (var_5_1 and var_5_1:getTaskStatus() or 0) == 2)

	return
end

function ShadowCityOmenTaskWindow:GetProgressColor()
	return "#25A1FF", "#393A3C"
end

return ShadowCityOmenTaskWindow
