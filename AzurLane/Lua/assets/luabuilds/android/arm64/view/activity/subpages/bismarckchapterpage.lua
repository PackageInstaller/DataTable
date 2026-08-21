local var_0_0 = class("BismarckChapterPage", import("...base.BaseActivityPage"))

var_0_0.tabPos = {
	[1] = 10,
	[2] = 182.3
}
var_0_0.IconShowFunc = {
	[DROP_TYPE_SHIP] = function(arg_1_0, arg_1_1)
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. pg.ship_skin_template[pg.ship_data_statistics[arg_1_1].skin_id].painting, "", arg_1_0)

		return
	end,
	[DROP_TYPE_FURNITURE] = function(arg_2_0, arg_2_1)
		GetImageSpriteFromAtlasAsync("furnitureicon/" .. pg.furniture_data_template[arg_2_1].icon, "", arg_2_0)

		return
	end
}
var_0_0.TransformType = {
	[TASK_SUB_TYPE_COLLECT_SHIP] = DROP_TYPE_SHIP,
	[TASK_SUB_TYPE_COLLECT_FURNITURE] = DROP_TYPE_FURNITURE
}

function var_0_0.OnInit(arg_3_0)
	arg_3_0.bg = arg_3_0._tf:Find("AD")
	arg_3_0.items = {}
	arg_3_0.items[1] = arg_3_0._tf:Find("AD/Item1")
	arg_3_0.items[2] = arg_3_0._tf:Find("AD/Item2")
	arg_3_0.awardTF = arg_3_0._tf:Find("AD/award")
	arg_3_0.battleBtn = arg_3_0._tf:Find("AD/battle_btn")
	arg_3_0.shopBtn = arg_3_0._tf:Find("AD/exchange_btn")
	arg_3_0.buildBtn = arg_3_0._tf:Find("AD/build_btn")
	arg_3_0.tab = arg_3_0._tf:Find("tab")
	arg_3_0.bar = arg_3_0._tf:Find("bar")
	arg_3_0.scrollList = arg_3_0.tab:Find("Scroll View")
	arg_3_0.content = arg_3_0.scrollList:Find("Content")
	arg_3_0.listTmpl = arg_3_0.tab:Find("listitem")
	arg_3_0.taskList = UIItemList.New(arg_3_0.content, arg_3_0.listTmpl)
	arg_3_0.finalTasks = {}
	arg_3_0.subtasks = {}
	arg_3_0.tabType = 0

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	arg_4_0.finalTasks = Clone(arg_4_0.activity:getConfig("config_client"))

	_.each(arg_4_0.finalTasks, function(arg_5_0)
		if pg.task_data_template[arg_5_0] and pg.task_data_template[arg_5_0].target_id then
			table.insert(arg_4_0.subtasks, Clone(var_5_0))
		end

		return
	end)
	setText(arg_4_0.bg:Find("desc"), i18n("bismarck_chapter_desc"))
	arg_4_0:SubimtCompletedMission()
	arg_4_0:InitInteractable()

	return
end

function var_0_0.InitInteractable(arg_6_0)
	local var_6_0 = getProxy(TaskProxy)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.finalTasks) do
		onButton(arg_6_0, arg_6_0.items[iter_6_0], function()
			local var_7_0 = var_6_0:getTaskVO(iter_6_1)

			if var_7_0:getTaskStatus() == 1 then
				arg_6_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_7_0)

				return
			end

			if arg_6_0.tabType == iter_6_0 then
				return
			end

			arg_6_0.tabType = iter_6_0

			arg_6_0:UpdateTab()

			return
		end, SFX_PANEL)
	end

	onButton(arg_6_0, arg_6_0.battleBtn, function()
		arg_6_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.shopBtn, function()
		if configClinet.shopLinkActID then
			local var_9_0 = getProxy(ActivityProxy):getActivitiesById(configClinet.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_10_0)
				return not arg_10_0:isEnd()
			end)

			if not var_9_0 or var_9_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			arg_6_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = var_9_0.id
			})

			return
		end
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.buildBtn, function()
		arg_6_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.bg, function()
		if arg_6_0.tabType > 0 then
			arg_6_0.tabType = 0

			arg_6_0:UpdateTab()
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_13_0)
	arg_13_0:UpdateView()
	arg_13_0:UpdateTab()

	return
end

function var_0_0.UpdateView(arg_14_0)
	local var_14_0 = getProxy(TaskProxy)

	for iter_14_0 = 1, #arg_14_0.finalTasks do
		local var_14_1 = arg_14_0.items[iter_14_0]

		setActive(arg_14_0.items[iter_14_0], true)
		arg_14_0:UpdateIcon(var_14_1:Find("icon"), pg.task_data_template[arg_14_0.finalTasks[iter_14_0]].award_display[1][1], pg.task_data_template[arg_14_0.finalTasks[iter_14_0]].award_display[1][2])

		local var_14_2 = var_14_0:getTaskVO(arg_14_0.finalTasks[iter_14_0]):getTaskStatus()

		setActive(var_14_1:Find("active"), var_14_2 == 0)
		setActive(var_14_1:Find("finished"), var_14_2 == 1)
		setActive(var_14_1:Find("achieved"), var_14_2 == 2)
		setButtonEnabled(var_14_1, var_14_2 < 2)

		arg_14_0.tabType = arg_14_0.tabType == iter_14_0 and var_14_2 == 2 and 0 or arg_14_0.tabType
	end

	for iter_14_1 = #arg_14_0.finalTasks + 1, #arg_14_0.items do
		setActive(arg_14_0.items[iter_14_1], false)

		arg_14_0.tabType = arg_14_0.tabType == iter_14_1 and 0 or arg_14_0.tabType
	end

	return
end

function var_0_0.UpdateTab(arg_15_0)
	if arg_15_0.tabType == 0 then
		setActive(arg_15_0.tab, false)

		return
	end

	local var_15_0 = arg_15_0.subtasks[arg_15_0.tabType]

	arg_15_0.taskList:align(#arg_15_0.subtasks[arg_15_0.tabType])

	local var_15_1 = getProxy(TaskProxy)
	local var_15_2 = 0

	for iter_15_0 = 1, #arg_15_0.subtasks[arg_15_0.tabType] do
		local var_15_3 = arg_15_0.content:GetChild(iter_15_0 - 1)

		setText(var_15_3:Find("title/Text"), string.format("Task-%02d", iter_15_0))

		local var_15_4 = var_15_0[iter_15_0]
		local var_15_5 = pg.task_data_template[var_15_0[iter_15_0]]
		local var_15_6 = tonumber(pg.task_data_template[var_15_0[iter_15_0]].target_id)
		local var_15_7 = var_0_0.TransformType[pg.task_data_template[var_15_0[iter_15_0]].sub_type]

		setActive(var_15_3:Find("tip2"), var_0_0.TransformType[pg.task_data_template[var_15_0[iter_15_0]].sub_type] == DROP_TYPE_FURNITURE)
		setActive(var_15_3:Find("tip"), var_15_7 == DROP_TYPE_SHIP)

		local var_15_9 = var_15_1:getTaskById(var_15_4) or var_15_1:getFinishTaskById(var_15_4)

		setActive(var_15_3:Find("completed"), defaultValue(var_15_9 and var_15_9:isFinish(), false))
		setText(var_15_3:Find("text"), var_15_5.desc)
		arg_15_0:UpdateIcon(var_15_3:Find("icon"), var_15_7, var_15_6)

		var_15_2 = var_15_2 + (var_15_9 and var_15_9:isFinish() and 1 or 0)
	end

	setText(arg_15_0.tab:Find("slider/progress"), string.format("[%d/%d]", var_15_2, #arg_15_0.subtasks[arg_15_0.tabType]))

	arg_15_0.scrollList:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 1
	arg_15_0.tab.transform.anchoredPosition.x = var_0_0.tabPos[arg_15_0.tabType]

	setAnchoredPosition(arg_15_0.tab, arg_15_0.tab.transform.anchoredPosition)

	arg_15_0.bar.sizeDelta.x = arg_15_0._tf.sizeDelta.x - arg_15_0.bar.anchoredPosition.x - arg_15_0.tab.transform.anchoredPosition.x - arg_15_0.tab.sizeDelta.x
	arg_15_0.bar.sizeDelta = arg_15_0.bar.sizeDelta

	setActive(arg_15_0.tab, true)

	return
end

function var_0_0.UpdateIcon(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if var_0_0.IconShowFunc[arg_16_2] then
		var_0_0.IconShowFunc[arg_16_2](arg_16_1, arg_16_3)
	end

	return
end

function var_0_0.OnDestroy(arg_17_0)
	return
end

function var_0_0.SubimtCompletedMission(arg_18_0)
	local var_18_0 = getProxy(TaskProxy)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.subtasks) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			local var_18_1 = var_18_0:getTaskById(iter_18_3)

			if var_18_1 and var_18_1:isFinish() then
				arg_18_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_18_1)
			end
		end
	end

	return
end

return var_0_0
