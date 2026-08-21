local var_0_0 = class("TerminalAdventurePage", import("view.base.BaseSubView"))

var_0_0.BIND_PT_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_PT_ID
var_0_0.BIND_TASK_ACT_ID = ActivityConst.OTHER_WORLD_TERMINAL_TASK_ID

function var_0_0.getUIName(arg_1_0)
	return "TerminalAdventurePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0._tf.name = tostring(OtherworldTerminalLayer.PAGE_ADVENTURE)
	arg_2_0.levelTF = arg_2_0._tf:Find("frame/level")

	setText(arg_2_0.levelTF:Find("title/content/Text"), i18n("adventure_award_title"))
	setText(arg_2_0.levelTF:Find("progress/title"), i18n("adventure_progress_title"))
	setText(arg_2_0.levelTF:Find("lv"), i18n("adventure_lv_title"))

	arg_2_0.ptIconTF = arg_2_0.levelTF:Find("progress/Image")
	arg_2_0.ptValueTF = arg_2_0.levelTF:Find("progress/value")
	arg_2_0.ptLvTF = arg_2_0.levelTF:Find("lv/Text")
	arg_2_0.awardView = arg_2_0.levelTF:Find("awards/view")
	arg_2_0.awardUIList = UIItemList.New(arg_2_0.awardView:Find("content"), arg_2_0.awardView:Find("content/tpl"))
	arg_2_0.recordTF = arg_2_0._tf:Find("frame/record")

	setText(arg_2_0.recordTF:Find("title/content/Text"), i18n("adventure_record_title"))
	setText(arg_2_0.recordTF:Find("grade"), i18n("adventure_record_grade_title"))

	arg_2_0.recordGradeTF = arg_2_0.recordTF:Find("grade/Text")
	arg_2_0.taskUIList = UIItemList.New(arg_2_0.recordTF:Find("form"), arg_2_0.recordTF:Find("form/tpl"))

	setText(arg_2_0._tf:Find("frame/tip"), i18n("adventure_award_end_tip"))

	arg_2_0.getBtn = arg_2_0._tf:Find("frame/get_all_btn")

	setText(arg_2_0.getBtn:Find("Text"), i18n("adventure_get_all"))

	arg_2_0.getGreyBtn = arg_2_0._tf:Find("frame/get_all_btn_grey")

	setText(arg_2_0.getGreyBtn:Find("Text"), i18n("adventure_get_all"))

	return
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityById(var_0_0.BIND_PT_ACT_ID)

	assert(var_3_0, "not exist bind pt act, id" .. var_0_0.BIND_PT_ACT_ID)

	arg_3_0.ptData = ActivityPtData.New(var_3_0)
	arg_3_0.taskActivity = getProxy(ActivityProxy):getActivityById(var_0_0.BIND_TASK_ACT_ID)

	assert(arg_3_0.taskActivity, "not exist bind task act, id" .. var_0_0.BIND_TASK_ACT_ID)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(OtherworldTerminalMediator.ON_GET_PT_ALL_AWARD, {
			actId = var_0_0.BIND_PT_ACT_ID,
			arg1 = arg_3_0.ptData:GetCurrTarget()
		})

		return
	end, SFX_PANEL)
	arg_3_0:InitPtUI()
	arg_3_0:UpdatePtView()
	arg_3_0:InitTaskUI()
	arg_3_0:UpdateTaskView()

	return
end

function var_0_0.InitPtUI(arg_5_0)
	LoadImageSpriteAsync(Drop.New(arg_5_0.ptData:GetRes()):getIcon(), arg_5_0.ptIconTF, false)
	arg_5_0.awardUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = arg_6_1 + 1

			updateDrop(arg_6_2:Find("IconTpl"), Drop.New({
				type = arg_5_0.ptData.dropList[arg_6_1 + 1][1],
				id = arg_5_0.ptData.dropList[arg_6_1 + 1][2],
				count = arg_5_0.ptData.dropList[arg_6_1 + 1][3]
			}), {
				hideName = true
			})
			onButton(arg_5_0.binder, arg_6_2:Find("IconTpl"), function()
				arg_5_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)

			local var_6_2 = arg_5_0.ptData:GetLevel()

			setActive(arg_6_2:Find("IconTpl/got"), var_6_0 <= var_6_2)
			setText(arg_6_2:Find("lv"), "Lv:" .. var_6_0)
			setActive(arg_6_2:Find("lv0"), var_6_0 == 1)

			local var_6_3 = arg_6_2:Find("progress")

			setActive(var_6_3:Find("left"), var_6_0 ~= 1)
			setActive(var_6_3:Find("right"), var_6_0 == #arg_5_0.ptData.targets)

			local var_6_4

			if var_6_0 <= var_6_2 then
				setSlider(var_6_3, 0, 1, 1)

				goto label_6_0

				var_6_4 = arg_5_0.ptData.count - (var_6_0 == 1 and 0 or arg_5_0.ptData.targets[var_6_0 - 1])
			end

			setSlider(var_6_3, 0, 1, var_6_4 / (arg_5_0.ptData.targets[var_6_0] - (var_6_0 == 1 and 0 or arg_5_0.ptData.targets[var_6_0 - 1])))

			::label_6_0::
		end

		return
	end)

	return
end

function var_0_0.UpdatePt(arg_8_0, arg_8_1)
	arg_8_0.ptData = ActivityPtData.New(arg_8_1)

	arg_8_0:UpdatePtView()

	return
end

function var_0_0.UpdatePtView(arg_9_0)
	local var_9_0 = arg_9_0.ptData:CanGetAward()

	setActive(arg_9_0.getBtn, var_9_0)
	setActive(arg_9_0.getGreyBtn, not var_9_0)

	local var_9_1 = arg_9_0.ptData:GetLevel()
	local var_9_2, var_9_3 = arg_9_0.ptData:GetResProgress()

	setText(arg_9_0.ptValueTF, math.max(var_9_3 - var_9_2, 0))
	setText(arg_9_0.ptLvTF, var_9_1)
	arg_9_0.awardUIList:align(#arg_9_0.ptData.targets)
	scrollTo(arg_9_0.awardView, var_9_1 / #arg_9_0.ptData.targets, 0)

	return
end

function var_0_0.InitTaskUI(arg_10_0)
	arg_10_0.taskIds = arg_10_0.taskActivity:getConfig("config_data")

	arg_10_0.taskUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = getProxy(TaskProxy):getTaskById(arg_10_0.taskIds[arg_11_1 + 1])

			setText(arg_11_2:Find("name"), var_11_0:getConfig("desc"))
			setText(arg_11_2:Find("value"), var_11_0:getProgress())
		end

		return
	end)

	return
end

function var_0_0.UpdateTask(arg_12_0, arg_12_1)
	arg_12_0.taskActivity = arg_12_1

	arg_12_0:UpdateTaskView()

	return
end

function var_0_0.UpdateTaskView(arg_13_0)
	arg_13_0.taskUIList:align(#arg_13_0.taskIds)
	setText(arg_13_0.recordGradeTF, arg_13_0:GetAdventureGrade())

	return
end

function var_0_0.GetAdventureGrade(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs((arg_14_0.taskActivity:getConfig("config_client"))) do
		if #iter_14_1[2] > 0 then
			for iter_14_2, iter_14_3 in ipairs(iter_14_1[2]) do
				local var_14_0 = getProxy(TaskProxy):getTaskById(iter_14_3[1])

				if var_14_0 and iter_14_3[2] <= var_14_0:getProgress() then
					return iter_14_1[1]
				end
			end
		else
			return iter_14_1[1]
		end
	end

	return ""
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

function var_0_0.IsTip()
	local var_16_0 = getProxy(ActivityProxy):getActivityById(var_0_0.BIND_PT_ACT_ID)

	if not var_16_0 or var_16_0:isEnd() then
		return false
	end

	return ActivityPtData.New(var_16_0):CanGetAward()
end

return var_0_0
