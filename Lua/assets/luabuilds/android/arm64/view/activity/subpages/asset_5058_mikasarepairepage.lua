local MikasaRepairePage = class("MikasaRepairePage", import("...base.BaseActivityPage"))

function MikasaRepairePage:OnInit()
	self.layer = self._tf:Find("layer")

	return
end

function MikasaRepairePage:OnFirstFlush()
	return
end

function MikasaRepairePage:OnUpdateFlush()
	self:update_task_list_mikasa_museum(self.activity, self.layer, 1)

	return
end

function MikasaRepairePage:update_task_list_mikasa_museum(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = getProxy(TaskProxy)
	local var_4_1 = arg_4_1:getConfig("config_data")
	local var_4_2 = getProxy(ActivityProxy)
	local var_4_3 = arg_4_2:Find("AD")
	local var_4_4 = arg_4_2:Find("item")

	onButton(self, var_4_4:Find("helpBtn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.word_museum_help.tip
		})

		return
	end, SFX_PANEL)

	local var_4_8 = {}

	for iter_4_0 = 1, 4 do
		local var_4_11 = var_4_4:Find("Panel/layout_layer/repair_panel" .. iter_4_0 .. "/Panel")
		local var_4_12 = var_4_11:Find("btn_repair")

		var_4_8[iter_4_0] = nil

		for iter_4_1 = 1, 4 do
			local var_4_13 = var_4_1[(iter_4_0 - 1) * 4 + iter_4_1]

			self:set_mikasa_btn(var_4_1[(iter_4_0 - 1) * 4 + iter_4_1], var_4_11:Find("repair" .. iter_4_1), iter_4_1 == 1 and 0 or var_4_1[(iter_4_0 - 1) * 4 + iter_4_1 - 1], iter_4_1 >= 4)

			var_4_8[iter_4_0] = var_4_8[iter_4_0] or var_4_0:getTaskById(var_4_13) and var_4_13 or nil
		end

		local var_4_14 = var_4_0:getTaskById(var_4_1[(iter_4_0 - 1) * 4 + 1]) or var_4_0:getFinishTaskById(var_4_1[(iter_4_0 - 1) * 4 + 1])

		setActive(var_4_11:Find("line1/unselected"), not var_4_14:isReceive())
		setActive(var_4_11:Find("line1/selected"), var_4_14:isReceive())

		local var_4_15 = var_4_0:getTaskById(var_4_1[(iter_4_0 - 1) * 4 + 2]) or var_4_0:getFinishTaskById(var_4_1[(iter_4_0 - 1) * 4 + 2])

		setActive(var_4_11:Find("line2/unselected"), not var_4_15:isReceive())
		setActive(var_4_11:Find("line2/selected"), var_4_15:isReceive())

		local var_4_16 = var_4_0:getTaskById(var_4_1[(iter_4_0 - 1) * 4 + 3]) or var_4_0:getFinishTaskById(var_4_1[(iter_4_0 - 1) * 4 + 3])

		setActive(var_4_11:Find("to_award/unselected"), not var_4_16:isReceive())
		setActive(var_4_11:Find("to_award/selected"), var_4_16:isReceive())

		local var_4_17 = var_4_0:getTaskById(var_4_1[iter_4_0 * 4]) or var_4_0:getFinishTaskById(var_4_1[iter_4_0 * 4])

		var_4_12:GetComponent(typeof(Image)).enabled = not var_4_17:isFinish()

		setActive(var_4_12:Find("get"), var_4_17:isFinish() and not var_4_17:isReceive())
		setActive(var_4_12:Find("got"), var_4_17:isReceive())
		onButton(self, var_4_12, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_0:getTaskById(var_4_8[iter_4_0]))

			return
		end, SFX_PANEL)
		setActive(var_4_11:Find("gear"), not var_4_17:isFinish())

		if not var_4_17:isFinish() then
			local var_4_18 = var_4_0:getTaskById(var_4_8[iter_4_0])

			setText(var_4_11:Find("gear/test_bg/Text"), var_4_2:getVirtualItemNumber(tonumber(var_4_18:getConfig("target_id"))) .. "/" .. var_4_18:getConfig("target_num"))
		end

		local var_4_19 = var_4_8[iter_4_0]
		local var_4_20 = var_4_8[iter_4_0] and (var_4_0:getTaskById(var_4_19) or var_4_0:getFinishTaskById(var_4_19)) or nil

		setButtonEnabled(var_4_12, var_4_20 and var_4_20:isFinish())
		setActive(var_4_12:Find("mask"), var_4_20 and var_4_20:isFinish())
	end

	local var_4_21 = var_4_4:Find("btn_main")
	local var_4_22 = var_4_0:getTaskById(var_4_1[#var_4_1]) or var_4_0:getFinishTaskById(var_4_1[#var_4_1])

	var_4_21:GetComponent(typeof(Image)).enabled = not var_4_22:isFinish()

	setActive(var_4_21:Find("get"), var_4_22:isFinish() and not var_4_22:isReceive())
	setActive(var_4_21:Find("got"), var_4_22:isReceive())
	onButton(self, var_4_21, function()
		if not var_4_22:isFinish() then
			local var_7_0 = var_4_2:getActivityById(ActivityConst.MIKASA_DAILY_TASK_ACTIVITY)
			local var_7_1 = pg.TimeMgr.GetInstance()

			if _.all(_.flatten({
				var_7_0:getConfig("config_data")[math.clamp(var_7_1:DiffDay(var_7_0.data1, var_7_1:GetServerTime()) + 1, 1, #var_7_0:getConfig("config_data"))]
			}), function(arg_8_0)
				return var_4_0:getFinishTaskById(arg_8_0) ~= nil
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_museum_1"))
			else
				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = "activity"
				})
			end
		else
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_22)
		end

		return
	end, SFX_PANEL)
	setButtonEnabled(var_4_21, not var_4_22:isReceive())
	self:set_mikasa_btn(var_4_1[#var_4_1], var_4_4:Find("repair_main"), 0, true, arg_4_1:getConfig("config_client").story)

	for iter_4_2 = 1, 4 do
		setActive(var_4_4:Find("repair_phase/point" .. iter_4_2), iter_4_2 <= var_4_22:getProgress())

		if iter_4_2 > 1 then
			setActive(var_4_4:Find("repair_phase/line" .. iter_4_2 - 1), iter_4_2 <= var_4_22:getProgress())
		end
	end

	setText(var_4_4:Find("repair_phase/Text"), var_4_22:getProgress() .. "/4")

	return
end

function MikasaRepairePage:set_mikasa_btn(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = getProxy(TaskProxy)
	local var_9_1 = var_9_0:getTaskById(arg_9_1) or var_9_0:getFinishTaskById(arg_9_1)
	local var_9_2 = arg_9_2:Find("award")
	local var_9_3 = arg_9_2:Find("face")

	if arg_9_4 then
		setActive(var_9_2, true)
		setActive(var_9_3, false)

		local var_9_4 = {
			type = pg.task_data_template[arg_9_1].award_display[1][1],
			id = pg.task_data_template[arg_9_1].award_display[1][2],
			count = pg.task_data_template[arg_9_1].award_display[1][3]
		}

		setActive(var_9_2, pg.task_data_template[arg_9_1].award_display[1])
		updateDrop(var_9_2, var_9_4)
		onButton(self, var_9_2, function()
			self:emit(BaseUI.ON_DROP, var_9_4)

			return
		end, SFX_PANEL)
		setActive(var_9_2:Find("mask"), var_9_1:isReceive())
		setActive(var_9_2:Find("black_block"), var_9_1:isReceive())
		setActive(arg_9_2:Find("Text"), false)
	else
		setActive(var_9_2, false)
		setActive(var_9_3, true)
		setActive(var_9_3:Find("bg_select"), arg_9_3 == 0 or var_9_0:getFinishTaskById(arg_9_3))
		setActive(var_9_3:Find("mask"), var_9_0:getFinishTaskById(arg_9_1))
		setActive(var_9_3:Find("black_block"), var_9_0:getFinishTaskById(arg_9_1))
	end

	if var_9_1:getConfig("sub_type") == 90 and arg_9_5 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_5) do
			if iter_9_1[1] == arg_9_1 and iter_9_1[2] == var_9_1:getProgress() then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(iter_9_1[3]) then
					pg.NewStoryMgr.GetInstance():Play(iter_9_1[3])

					break
				end
			end
		end
	end

	return
end

return MikasaRepairePage
