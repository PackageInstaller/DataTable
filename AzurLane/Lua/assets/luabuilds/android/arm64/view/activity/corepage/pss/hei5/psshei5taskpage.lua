local var_0_0 = class("PSSHei5TaskPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PSSHei5TaskPage"
end

function var_0_0.UpdateActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.activity:GetHei5Info()) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	arg_2_0.taskGroupList = {}

	local var_2_0 = pg.TimeMgr.GetInstance():GetServerDay(arg_2_0.activity:getStartTime())

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.activity:getConfig("config_data")) do
		arg_2_0.taskGroupList[pg.black_friday_battlepass_task_group[iter_2_3].group_mask] = {
			task_group = pg.black_friday_battlepass_task_group[iter_2_3].task_group,
			isLock = var_2_0 < pg.black_friday_battlepass_task_group[iter_2_3].group_mask
		}
	end

	updateCrusingHei5ActivityTask(arg_2_0.activity)

	arg_2_0.finishAll = arg_2_0.phase == #arg_2_0.awardList

	return
end

function var_0_0.initTplVar(arg_3_0)
	arg_3_0.btnGoText = "task_go"
	arg_3_0.btnGetText = "task_get"
	arg_3_0.taskDayText = "blackfriday_cruise_task_day"
	arg_3_0.pticonAtlas = "ui/PSSHei5UI_atlas"
	arg_3_0.pticonName = "battlepass_blackfriday"

	return
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0:initTplVar()
	arg_4_0:UpdateActivity()

	local var_4_0 = arg_4_0._tf:Find("frame")

	arg_4_0.togglesTF = var_4_0:Find("week_list")
	arg_4_0.toggleCount = arg_4_0.togglesTF:Find("count")

	local var_4_1 = var_4_0:Find("view/content")
	local var_4_2 = var_4_1:Find("tpl")

	setText(var_4_2:Find("info/go/Text"), i18n(arg_4_0.btnGoText))
	setText(var_4_2:Find("info/get/Text"), i18n(arg_4_0.btnGetText))
	setText(var_4_2:Find("info/got/Text"), i18n("task_got"))

	arg_4_0.taskGroupItemList = UIItemList.New(var_4_1, var_4_2)

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0.taskGroupItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			arg_5_0:UpdateTaskGroup(arg_6_2, arg_5_0.tempTaskGroup[arg_6_1])
		end

		return
	end)

	return
end

function var_0_0.Flush(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0:UpdateActivity(arg_7_1)
	end

	local var_7_0 = getProxy(TaskProxy)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.taskGroupList) do
		local var_7_1 = iter_7_0 == 0 and arg_7_0._tf:Find("frame/" .. iter_7_0) or arg_7_0.toggleCount:Find(iter_7_0)

		if iter_7_0 > 0 then
			setText(var_7_1:Find("off/Text"), i18n(arg_7_0.taskDayText, iter_7_0))
			setText(var_7_1:Find("on/Text"), i18n(arg_7_0.taskDayText, iter_7_0))
		end

		setActive(var_7_1:Find("tip"), not iter_7_1.isLock and PlayerPrefs.GetInt(string.format("cursing_%d_task_week_%d", arg_7_0.activity.id, iter_7_0), 0) == 0)
		onToggle(arg_7_0, var_7_1, function(arg_8_0)
			if arg_8_0 then
				setActive(var_7_1:Find("tip"), false)
				PlayerPrefs.SetInt(string.format("cursing_%d_task_week_%d", arg_7_0.activity.id, iter_7_0), 1)

				arg_7_0.weekToggle = iter_7_0
				arg_7_0.contextData.weekToggle = iter_7_0
				arg_7_0.tempTaskGroup = underscore.map(iter_7_1.task_group, function(arg_9_0)
					return underscore.map(arg_9_0, function(arg_10_0)
						assert(var_7_0:getTaskVO(arg_10_0), "without this task:" .. arg_10_0)

						return var_7_0:getTaskVO(arg_10_0)
					end)
				end)

				table.sort(arg_7_0.tempTaskGroup, CompareFuncs({
					function(arg_11_0)
						return underscore.all(arg_11_0, function(arg_12_0)
							return arg_12_0:isReceive()
						end) and 1 or 0
					end,
					function(arg_13_0)
						return arg_13_0[1].id
					end
				}))
				arg_7_0.taskGroupItemList:align(#arg_7_0.tempTaskGroup)
			end

			return
		end, SFX_PANEL)

		if var_7_1:Find("mask") then
			setActive(var_7_1:Find("mask"), iter_7_1.isLock)
		end
	end

	local var_7_2 = underscore.keys(arg_7_0.taskGroupList)

	table.sort(var_7_2, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	if arg_7_0.contextData.weekToggle and not arg_7_0.taskGroupList[arg_7_0.contextData.weekToggle].isLock then
		arg_7_0.weekToggle = arg_7_0.contextData.weekToggle
		arg_7_0.contextData.weekToggle = nil
	else
		arg_7_0.weekToggle = table.remove(var_7_2, 1)

		for iter_7_2, iter_7_3 in ipairs(var_7_2) do
			if arg_7_0.taskGroupList[iter_7_3].isLock then
				break
			elseif underscore.any(underscore.flatten(arg_7_0.taskGroupList[iter_7_3].task_group), function(arg_15_0)
				local var_15_0 = var_7_0:getTaskVO(arg_15_0)

				return var_15_0 and not var_15_0:isReceive()
			end) then
				arg_7_0.weekToggle = iter_7_3

				break
			end
		end
	end

	if arg_7_0.weekToggle == 0 then
		triggerToggle(arg_7_0._tf:Find("frame/0"), true)
	else
		triggerToggle(arg_7_0.toggleCount:Find(arg_7_0.weekToggle), true)
	end

	for iter_7_4, iter_7_5 in ipairs(arg_7_0.taskGroupList) do
		local var_7_3 = arg_7_0.toggleCount:Find(iter_7_4)

		SetCompomentEnabled(var_7_3, typeof(Toggle), not iter_7_5.isLock)

		if not iter_7_5.isLock then
			setGray(var_7_3, underscore.all(underscore.flatten(iter_7_5.task_group), function(arg_16_0)
				local var_16_0 = var_7_0:getTaskVO(arg_16_0)

				return var_16_0 and var_16_0:isReceive()
			end))
		end
	end

	arg_7_0:Show()

	return
end

function var_0_0.UpdateTaskGroup(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:Find("info")

	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		if not iter_17_1:isReceive() then
			table.insert({}, iter_17_1)
		end
	end

	local var_17_1 = #{} > 0 and table.remove({}, 1) or arg_17_2[#arg_17_2]

	arg_17_0:UpdateTaskDisplay(var_17_0, var_17_1)

	return
end

function var_0_0.UpdateTaskDisplay(arg_18_0, arg_18_1, arg_18_2)
	setText(arg_18_1:Find("desc"), string.format("%s(%d/%d)", arg_18_2:getConfig("desc"), arg_18_2:getProgress(), (arg_18_2:getConfig("target_num"))))

	local var_18_0 = Drop.Create(arg_18_2:getConfig("award_display")[1])
	local var_18_1 = arg_18_0.finishAll and 2 or arg_18_2:getTaskStatus()

	setActive(arg_18_1:Find("go"), var_18_1 == 0)
	setActive(arg_18_1:Find("get"), var_18_1 == 1)
	setActive(arg_18_1:Find("got"), var_18_1 == 2)
	setText(arg_18_1:Find("go/Text"), i18n("island_word_go"))
	setText(arg_18_1:Find("get/Text"), i18n("handbook_research_final_task_btn_claim"))
	setText(arg_18_1:Find("got/Text"), i18n("handbook_research_final_task_btn_finished"))

	local var_18_2 = Drop.Create(arg_18_2:getConfig("award_display")[1])

	setText(arg_18_1:Find("icon/num"), "X" .. arg_18_2:getConfig("award_display")[1][3])

	if arg_18_0.pticonAtlas and arg_18_0.pticonName then
		setImageSprite(arg_18_1:Find("icon"), LoadSprite("ui/PSSHei5UI_atlas", "battlepass_blackfriday"), false)
	end

	onButton(arg_18_0, arg_18_1:Find("icon"), function()
		arg_18_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_18_2
		})

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_1:Find("go"), function()
		arg_18_0:emit(PSSHei5Mediator.ON_TASK_GO, arg_18_2)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_1:Find("get"), function()
		arg_18_0:emit(PSSHei5Mediator.ON_TASK_SUBMIT, arg_18_2)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnDestroy(arg_22_0)
	return
end

return var_0_0
