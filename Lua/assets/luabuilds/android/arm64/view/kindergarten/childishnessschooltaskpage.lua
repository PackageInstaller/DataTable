local var_0_0 = class("ChildishnessSchoolTaskPage", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChildishnessSchoolTaskPage"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.scrollPanel = arg_2_0._tf:Find("window/panel")
	arg_2_0.UIlist = UIItemList.New(arg_2_0._tf:Find("window/panel/list"), arg_2_0._tf:Find("window/panel/list/Tasktpl"))
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.getBtn = arg_2_0._tf:Find("window/btn_get")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.bg, function()
		arg_3_0.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	arg_3_0:Show()

	arg_3_0.anim = arg_3_0._tf:GetComponent(typeof(Animation))
	arg_3_0.animEvent = arg_3_0.anim:GetComponent(typeof(DftAniEvent))

	arg_3_0.animEvent:SetEndEvent(function()
		arg_3_0:closeView()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.Show(arg_7_0)
	arg_7_0:UpdateTaskData()

	arg_7_0.canGetTaskVOs = {}
	arg_7_0.canGetTaskIds = {}

	arg_7_0:sort(arg_7_0.taskVOs)
	arg_7_0:UpdateList(arg_7_0.taskVOs)
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.sort(arg_8_0, arg_8_1)
	arg_8_0.canGetAward = false

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if iter_8_1:getTaskStatus() == 1 then
			table.insert({}, iter_8_1)
			table.insert(arg_8_0.canGetTaskVOs, iter_8_1)
			table.insert(arg_8_0.canGetTaskIds, iter_8_1.id)

			arg_8_0.canGetAward = true
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_1) do
		if iter_8_3:getTaskStatus() == 0 then
			table.insert({}, iter_8_3)
		end
	end

	for iter_8_4, iter_8_5 in pairs(arg_8_1) do
		if iter_8_5:getTaskStatus() == 2 then
			table.insert({}, iter_8_5)
		end
	end

	arg_8_0.taskVOs = {}

	return
end

function var_0_0.UpdateList(arg_9_0, arg_9_1)
	arg_9_0.UIlist:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText(arg_10_2:Find("frame/desc"), arg_9_1[arg_10_1 + 1]:getConfig("desc"))

			local var_10_1 = arg_9_1[arg_10_1 + 1]:getConfig("target_num")
			local var_10_2 = math.min(arg_9_1[arg_10_1 + 1]:getProgress(), var_10_1)

			setText(arg_10_2:Find("frame/progress"), var_10_2 .. "/" .. var_10_1)

			arg_10_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_10_2 / var_10_1

			local var_10_3 = arg_10_2:Find("frame/awards")

			arg_9_0:updateAwards(arg_9_1[arg_10_1 + 1]:getConfig("award_display"), var_10_3, (var_10_3:GetChild(0)))

			local var_10_4 = arg_10_2:Find("frame/go_btn")
			local var_10_5 = arg_10_2:Find("frame/get_btn")
			local var_10_6 = arg_10_2:Find("frame/got_btn")

			if arg_9_1[arg_10_1 + 1]:getTaskStatus() == 0 then
				setActive(var_10_4, true)
				setActive(var_10_5, false)
				setActive(var_10_6, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 1 then
				setActive(var_10_4, false)
				setActive(var_10_5, true)
				setActive(var_10_6, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 2 then
				setActive(var_10_4, false)
				setActive(var_10_5, false)
				setActive(var_10_6, true)
			end

			onButton(arg_9_0, var_10_4, function()
				arg_9_0:emit(ChildishnessSchoolTaskMediator.ON_TASK_GO, var_10_0)

				return
			end, SFX_PANEL)
			onButton(arg_9_0, var_10_5, function()
				arg_9_0:emit(ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT, var_10_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_9_0.UIlist:align(#arg_9_1)

	if arg_9_0.canGetAward then
		setActive(arg_9_0.getBtn, true)
		onButton(arg_9_0, arg_9_0.getBtn, function()
			local var_13_0 = {}

			for iter_13_0, iter_13_1 in pairs(arg_9_0.canGetTaskVOs) do
				for iter_13_2, iter_13_3 in ipairs((iter_13_1:getConfig("award_display"))) do
					local var_13_2 = false

					for iter_13_4, iter_13_5 in pairs(var_13_0) do
						if iter_13_5[1] == iter_13_3[1] and iter_13_5[2] == iter_13_3[2] then
							var_13_2 = true
							iter_13_5[3] = iter_13_5[3] + iter_13_3[3]

							break
						end
					end

					if not var_13_2 then
						table.insert(var_13_0, iter_13_3)
					end
				end
			end

			local var_13_3 = getProxy(PlayerProxy):getRawData()
			local var_13_4 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_13_5, var_13_6 = Task.StaticJudgeOverflow(var_13_3.gold, var_13_3.oil, var_13_4, true, true, var_13_0)

			if var_13_5 then
				table.insert({}, function(arg_14_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_13_6,
						onYes = arg_14_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_9_0:emit(ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT_ONESTEP, ActivityConst.ALVIT_TASK_ACT_ID, arg_9_0.canGetTaskIds)

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(arg_9_0.getBtn, false)
		removeOnButton(arg_9_0.getBtn)
	end

	return
end

function var_0_0.updateAwards(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = _.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo(arg_16_3, arg_16_2)
	end

	for iter_16_1 = 1, arg_16_2.childCount do
		local var_16_1 = arg_16_2:GetChild(iter_16_1 - 1)
		local var_16_2 = iter_16_1 <= #var_16_0

		setActive(var_16_1, iter_16_1 <= #var_16_0)

		if var_16_2 then
			local var_16_3 = {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}

			updateDrop(var_16_1:Find("mask"), {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			})

			if ({
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}).type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(var_16_1:Find("specialFrame"), true)
			else
				setActive(var_16_1:Find("specialFrame"), false)
			end

			onButton(arg_16_0, var_16_1, function()
				arg_16_0:emit(BaseUI.ON_DROP, var_16_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.UpdateTaskData(arg_18_0)
	arg_18_0.taskVOs = {}

	for iter_18_0, iter_18_1 in pairs((getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID):getConfig("config_data"))) do
		local var_18_0 = getProxy(TaskProxy)

		table.insert(arg_18_0.taskVOs, var_18_0:getTaskVO(iter_18_1))
	end

	return
end

function var_0_0.willExit(arg_19_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0._tf)

	return
end

return var_0_0
