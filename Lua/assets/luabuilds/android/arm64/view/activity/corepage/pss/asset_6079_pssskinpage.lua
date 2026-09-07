local PSSSkinPage = class("PSSSkinPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function PSSSkinPage:OnInit()
	PSSSkinPage.super.OnInit(self)

	return
end

function PSSSkinPage:UpdateTask(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:Find("item")
	local var_2_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_2_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_2_1 + 1])

	assert(var_2_1, "without this task by id: " .. self.taskGroup[self.nday][arg_2_1 + 1])

	local var_2_2 = Drop.Create(var_2_1:getConfig("award_display")[1])

	updateDrop(var_2_0, var_2_2)
	onButton(self, var_2_0, function()
		self:emit(BaseUI.ON_DROP, var_2_2)

		return
	end, SFX_PANEL)

	local var_2_3 = var_2_1:getProgress()
	local var_2_4 = var_2_1:getConfig("target_num")

	setText(arg_2_2:Find("description"), var_2_1:getConfig("desc"))
	setText(arg_2_2:Find("progressText"), var_2_3)
	setText(arg_2_2:Find("progressText_1"), "/" .. var_2_4)
	setSlider(arg_2_2:Find("progress"), 0, var_2_4, var_2_3)

	local var_2_5 = arg_2_2:Find("go_btn")
	local var_2_6 = arg_2_2:Find("get_btn")
	local var_2_7 = arg_2_2:Find("got_btn")

	setText(arg_2_2:Find("go_btn/Text"), i18n("island_word_go"))
	setText(arg_2_2:Find("get_btn/Text"), i18n("handbook_research_final_task_btn_claim"))
	setText(arg_2_2:Find("got_btn/Text"), i18n("handbook_research_final_task_btn_finished"))

	local var_2_8 = var_2_1:getTaskStatus()

	setActive(var_2_5, var_2_8 == 0)
	setActive(var_2_6, var_2_8 == 1)
	setActive(var_2_7, var_2_8 == 2)
	onButton(self, var_2_5, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_2_1)

		return
	end, SFX_PANEL)
	onButton(self, var_2_6, function()
		local var_5_0 = {}
		local var_5_1 = var_2_1:getConfig("award_display")
		local var_5_2 = getProxy(PlayerProxy):getRawData()
		local var_5_3, var_5_4 = Task.StaticJudgeOverflow(var_5_2.gold, var_5_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_5_1)

		if var_5_3 then
			table.insert(var_5_0, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_5_4,
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync(var_5_0, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_2_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

return PSSSkinPage
