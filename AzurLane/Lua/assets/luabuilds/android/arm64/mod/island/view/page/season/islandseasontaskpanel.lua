local var_0_0 = class("IslandSeasonTaskPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonTaskPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("content")

	arg_2_0.getAllBtn = var_2_0:Find("get_all")

	setText(arg_2_0.getAllBtn:Find("Text"), i18n("island_season_task_collectall"))
	setActive(var_2_0:Find("tpl"), false)

	arg_2_0.scrollCom = var_2_0:Find("view"):GetComponent("LScrollRect")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.getAllBtn, function()
		arg_3_0:emit(IslandMediator.ON_SUBMIT_TASK_ONE_STEP, arg_3_0.canSubmitIds)

		return
	end, SFX_PANEL)

	function arg_3_0.scrollCom.onUpdateItem(arg_5_0, arg_5_1)
		arg_3_0:UpdateTask(arg_5_0, tf(arg_5_1))

		return
	end

	return
end

function var_0_0.UpdateTask(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.name = arg_6_0.taskIds[arg_6_1 + 1]

	setText(arg_6_2:Find("get/Text"), i18n("island_season_task_collect"))
	setText(arg_6_2:Find("got/Text"), i18n("island_season_task_collected"))

	local var_6_0 = arg_6_0.taskVODic[arg_6_0.taskIds[arg_6_1 + 1]]

	setText(arg_6_2:Find("desc"), pg.island_task[arg_6_0.taskIds[arg_6_1 + 1]].task_desc)
	setText(arg_6_2:Find("name"), pg.island_task[arg_6_0.taskIds[arg_6_1 + 1]].name)
	UIItemList.StaticAlign(arg_6_2:Find("awards"), arg_6_2:Find("awards/tpl"), #IslandTask.GetAwardsStatic(arg_6_0.taskIds[arg_6_1 + 1]), function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_7_2, var_0[arg_7_1 + 1], {
				style = "island"
			})
			onButton(arg_6_0, arg_7_2, function()
				arg_6_0.contextData:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_0[arg_7_1 + 1]
				})

				return
			end)
		end

		return
	end)

	local var_6_1 = pg.island_task_target[pg.island_task[arg_6_0.taskIds[arg_6_1 + 1]].target_id[1]].target_num

	if var_6_0 then
		local var_6_2 = var_6_0:GetTargetList()[1]:GetProgress() or var_6_1

		setText(arg_6_2:Find("progress"), var_6_2 .. "/" .. var_6_1)
		setActive(arg_6_2:Find("get_bg"), var_6_0 and var_6_0:IsFinish())

		local var_6_3 = var_6_0 and var_6_0:IsSubmitOnUI() and var_6_0:IsFinish()

		setActive(arg_6_2:Find("get"), var_6_3)
		setActive(arg_6_2:Find("got"), not var_6_0)
		onButton(arg_6_0, arg_6_2:Find("get"), function()
			arg_6_0:emit(IslandMediator.ON_SUBMIT_TASK, var_6_0.id)

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.Show(arg_10_0)
	arg_10_0.super.Show(arg_10_0)
	arg_10_0:Flush()
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_16")

	return
end

function var_0_0.Flush(arg_11_0)
	arg_11_0.taskIds = arg_11_0.contextData.season:GetTaskIds()
	arg_11_0.taskVODic = {}

	local var_11_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.contextData.season:GetTaskIds()) do
		local var_11_1 = var_11_0:GetTask(iter_11_1)

		if var_11_1 then
			arg_11_0.taskVODic[iter_11_1] = var_11_1
		end
	end

	table.sort(arg_11_0.taskIds, CompareFuncs({
		function(arg_12_0)
			return arg_11_0.taskVODic[arg_12_0] and arg_11_0.taskVODic[arg_12_0]:IsFinish() and 0 or 1
		end,
		function(arg_13_0)
			return arg_11_0.taskVODic[arg_13_0] and 0 or 1
		end,
		function(arg_14_0)
			return arg_14_0
		end
	}))
	arg_11_0.scrollCom:SetTotalCount(#arg_11_0.taskIds, -1)

	arg_11_0.canSubmitIds = underscore.select(arg_11_0.taskIds, function(arg_15_0)
		local var_15_0 = arg_11_0.taskVODic[arg_15_0]

		if arg_11_0.taskVODic[arg_15_0] then
			var_15_0 = arg_11_0.taskVODic[arg_15_0]:IsSubmitOnUI()
			var_15_0 = var_15_0 and arg_11_0.taskVODic[arg_15_0]:IsFinish()
		end

		return var_15_0
	end)

	setActive(arg_11_0.getAllBtn, #arg_11_0.canSubmitIds > 0)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	ClearLScrollrect(arg_16_0.scrollCom)

	return
end

return var_0_0
