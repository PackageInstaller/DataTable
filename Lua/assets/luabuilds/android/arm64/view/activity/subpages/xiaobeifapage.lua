local var_0_0 = class("XiaobeiFaPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.layer = arg_1_0._tf:Find("layer")
	arg_1_0.btn = arg_1_0.layer:Find("btn")
	arg_1_0.bonusList = arg_1_0.layer:Find("bonus_list")
	arg_1_0.progress = arg_1_0.layer:Find("progress")
	arg_1_0.progressTxt = arg_1_0.layer:Find("progressText")
	arg_1_0.phaseTxt = arg_1_0.layer:Find("phase/Text")
	arg_1_0.award = arg_1_0.layer:Find("award")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	onButton(arg_2_0, arg_2_0.bonusList, function()
		arg_2_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtTaskAwardWindow, {
			tasklist = var_2_0:getConfig("config_data"),
			ptId = var_2_0:getConfig("config_client").pt_id,
			totalPt = getProxy(ActivityProxy):getActivityById(var_2_0:getConfig("config_client").rank_act_id).data1
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	arg_4_0:flush_task_list_pt_xiaobeifa()

	return
end

function var_0_0.flush_task_list_pt_xiaobeifa(arg_5_0)
	arg_5_0:flush_task_list_pt()

	local var_5_0 = arg_5_0.activity
	local var_5_1, var_5_2, var_5_3 = arg_5_0:getDoingTask(arg_5_0.activity)

	if var_5_0:getConfig("config_client").main_task then
		arg_5_0:setImportantProgress(var_5_0, arg_5_0._tf:Find("progress_important"), var_5_3 and var_5_1 or var_5_1 - 1, var_5_0:getConfig("config_client").main_task, var_5_0:getConfig("config_data"))
	end

	return
end

function var_0_0.getDoingTask(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = getProxy(TaskProxy)
	local var_6_1 = _.flatten(arg_6_1:getConfig("config_data"))
	local var_6_2
	local var_6_3

	if arg_6_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TASKS then
		for iter_6_0 = #var_6_1, 1, -1 do
			local var_6_4 = var_6_0:getFinishTaskById(var_6_1[iter_6_0])

			if var_6_4 then
				if not var_6_3 then
					var_6_2 = var_6_1[iter_6_0]
					var_6_3 = var_6_4
				end

				break
			end

			var_6_2 = var_6_1[iter_6_0]
			var_6_3 = var_6_0:getTaskById(var_6_1[iter_6_0])
		end
	else
		var_6_2, var_6_3 = getActivityTask(arg_6_1)
	end

	if not arg_6_2 then
		assert(var_6_3, "without taskVO " .. var_6_2 .. " from server")
	end

	return table.indexof(var_6_1, var_6_2), var_6_2, var_6_3
end

function var_0_0.flush_task_list_pt(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:getDoingTask(arg_7_0.activity)
	local var_7_3 = getProxy(ActivityProxy):getActivityById(arg_7_0.activity:getConfig("config_client").rank_act_id).data1

	setText(arg_7_0.phaseTxt, var_7_0 .. "/" .. #_.flatten(arg_7_0.activity:getConfig("config_data")))

	if var_7_2 then
		local var_7_4 = var_7_2:getConfig("target_num")
		local var_7_6 = math.min(var_7_3, var_7_4)

		if var_7_3 < var_7_4 then
			local var_7_7 = COLOR_RED or COLOR_GREEN
			local var_7_8 = var_7_5(var_7_6, var_7_7)

			setText(arg_7_0.progressTxt, var_7_8 .. "/" .. var_7_4)
			setSlider(arg_7_0.progress, 0, var_7_4, math.min(var_7_3, var_7_4))

			local var_7_9 = var_7_2:getConfig("award_display")[1]

			updateDrop(arg_7_0.award, {
				type = var_7_9[1],
				id = var_7_9[2],
				count = var_7_9[3]
			})
			onButton(arg_7_0, arg_7_0.award, function()
				arg_7_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			arg_7_0.btn:GetComponent(typeof(Image)).enabled = not var_7_2:isFinish()

			local var_7_10 = var_7_2:isFinish() and not var_7_2:isReceive()

			setActive(arg_7_0.btn:Find("get"), var_7_10)
			setActive(arg_7_0.btn:Find("achieved"), var_7_2:isReceive())
			onButton(arg_7_0, arg_7_0.btn, function()
				if not var_7_2:isFinish() then
					arg_7_0:emit(ActivityMediator.ON_TASK_GO, var_7_2)
				else
					if not arg_7_0:TaskSubmitCheck(var_7_2) then
						return
					end

					arg_7_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_7_2)
				end

				return
			end, SFX_PANEL)
			setButtonEnabled(arg_7_0.btn, not var_7_2:isReceive())

			return
		end
	end
end

function var_0_0.TaskSubmitCheck(arg_10_0, arg_10_1)
	if var_0_0.checkList[arg_10_1.id] then
		for iter_10_0, iter_10_1 in ipairs((getProxy(BayProxy):getShips())) do
			if iter_10_1:getGroupId() == var_0_0.checkList[arg_10_1.id] and iter_10_1:isActivityNpc() then
				return true
			end
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("task_submitTask_error_client"))

		return false
	end

	return true
end

function var_0_0.setImportantProgress(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = arg_11_2:Find("award_display")
	local var_11_1 = arg_11_2:Find("important_task_tpl")
	local var_11_2 = getProxy(TaskProxy)

	setSlider(arg_11_2, 0, pg.task_data_template[arg_11_5[#arg_11_5]].target_num, getProxy(ActivityProxy):getActivityById(arg_11_1:getConfig("config_client").rank_act_id).data1)

	local var_11_4 = var_11_0:GetComponent(typeof(RectTransform)).rect.width

	removeAllChildren(var_11_0)
	setActive(var_11_1, false)

	for iter_11_0, iter_11_1 in ipairs(arg_11_4) do
		for iter_11_2, iter_11_3 in ipairs(arg_11_5) do
			if iter_11_1 == iter_11_3 then
				local var_11_6 = Instantiate(var_11_1)

				SetParent(var_11_6, var_11_0)
				setActive(var_11_6, true)
				setAnchoredPosition(var_11_6, {
					x = pg.task_data_template[arg_11_5[iter_11_2]].target_num / pg.task_data_template[arg_11_5[#arg_11_5]].target_num * var_11_4
				})

				local var_11_7 = var_11_6:Find("award")

				updateDrop(var_11_7, {
					type = pg.task_data_template[iter_11_1].award_display[1][1],
					id = pg.task_data_template[iter_11_1].award_display[1][2],
					count = pg.task_data_template[iter_11_1].award_display[1][3]
				})
				onButton(arg_11_0, var_11_7, function()
					arg_11_0:emit(BaseUI.ON_DROP, var_0)

					return
				end, SFX_PANEL)
				setText(var_11_6:Find("Text"), pg.task_data_template[iter_11_1].target_num)
				setActive(var_11_7:Find("mask"), iter_11_2 <= arg_11_3)

				break
			end
		end
	end

	return
end

function var_0_0.OnDestroy(arg_13_0)
	return
end

return var_0_0
