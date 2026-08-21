local var_0_0 = class("AnniversaryScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AnniversaryUI"
end

function var_0_0.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activityVO = arg_2_1
	arg_2_0.configData = arg_2_0.activityVO:getConfig("config_data") or {}
	arg_2_0.date = arg_2_0.activityVO.data3
	arg_2_0.currTaskId = arg_2_0.activityVO.data2

	return
end

function var_0_0.setTaskList(arg_3_0, arg_3_1)
	arg_3_0.taskVOs = arg_3_1

	return
end

function var_0_0.getTaskById(arg_4_0, arg_4_1)
	local var_4_0 = -1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.configData) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if arg_4_1 == iter_4_3 then
				var_4_0 = iter_4_0
			end
		end
	end

	if var_4_0 ~= -1 then
		if var_4_0 < arg_4_0.date then
			local var_4_1 = Task.New({
				submit_time = 2,
				id = arg_4_1
			})

			var_4_1.progress = var_4_1:getConfig("target_num")

			return var_4_1
		else
			return arg_4_0.taskVOs[arg_4_1]
		end
	end

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.backBtn = arg_5_0._tf:Find("bg/top/back")
	arg_5_0.mainPanel = arg_5_0._tf:Find("bg/main")
	arg_5_0.scrollRect = arg_5_0.mainPanel:Find("scroll_rect")
	arg_5_0.taskGorupContainer = arg_5_0.mainPanel:Find("scroll_rect/content")
	arg_5_0.taskGorupTpl = arg_5_0:getTpl("taskGroup", arg_5_0.taskGorupContainer)
	arg_5_0.offset = Vector2(arg_5_0.taskGorupTpl.rect.width / 2 + 30, arg_5_0.taskGorupTpl.rect.height / 2 + 30)
	arg_5_0.taskGroupDesc = arg_5_0.taskGorupContainer:Find("taskGroup_desc")
	arg_5_0.bottomPanel = arg_5_0._tf:Find("bg/bottom")
	arg_5_0.bottomTaskGroups = arg_5_0.bottomPanel:Find("taskGroups")
	arg_5_0.bottomBTpl = arg_5_0:getTpl("bottom_task_tpl", arg_5_0.bottomTaskGroups)
	arg_5_0.startPosition = arg_5_0.taskGorupContainer.localPosition
	arg_5_0.titles = {}

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.backBtn, function()
		arg_6_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	arg_6_0:initScrollRect()

	return
end

local var_0_1 = 2

function var_0_0.getRow(arg_8_0, arg_8_1)
	return math.floor(arg_8_1 / var_0_1) * 2 + arg_8_1 % var_0_1
end

function var_0_0.initScrollRect(arg_9_0)
	arg_9_0.taskGroupTFs = {}

	for iter_9_0 = 0, arg_9_0:getRow(#arg_9_0.configData) - 1 do
		for iter_9_1 = 0, var_0_1 - 1 do
			local var_9_0 = arg_9_0.offset.x * iter_9_1
			local var_9_1 = arg_9_0.offset.y * iter_9_0 * -1

			if iter_9_0 % 2 == 0 == (iter_9_1 % 2 == 0) then
				local var_9_2 = cloneTplTo(arg_9_0.taskGorupTpl, arg_9_0.taskGorupContainer)

				var_9_2.localPosition = Vector2(var_9_0, var_9_1)

				table.insert(arg_9_0.taskGroupTFs, var_9_2)
			end
		end
	end

	arg_9_0:updateTaskGroups()

	arg_9_0.dateIndex = math.max(arg_9_0.date, 1)

	arg_9_0:addVerticalDrag(arg_9_0.scrollRect, function()
		if arg_9_0.dateIndex + 1 > #var_0 then
			return
		end

		arg_9_0:moveToTaskGroup(arg_9_0.dateIndex + 1)

		return
	end, function()
		if arg_9_0.dateIndex - 1 < 1 then
			return
		end

		arg_9_0:moveToTaskGroup(arg_9_0.dateIndex - 1)

		return
	end)
	arg_9_0:moveToTaskGroup(arg_9_0.dateIndex, true)
	arg_9_0:initBottomPanel()

	return
end

function var_0_0.initBottomPanel(arg_12_0)
	arg_12_0.bottomTaskGroupTFs = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.configData) do
		arg_12_0.bottomTaskGroupTFs[iter_12_0] = cloneTplTo(arg_12_0.bottomBTpl, arg_12_0.bottomTaskGroups)

		arg_12_0:updateBottomTaskGroup(iter_12_0)
	end

	return
end

function var_0_0.updateBottomTaskGroup(arg_13_0, arg_13_1)
	arg_13_0.bottomTaskGroupTFs[arg_13_1]:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/anniversaryui_atlas", "part" .. arg_13_1)
	arg_13_0.bottomTaskGroupTFs[arg_13_1]:Find("Image"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/anniversaryui_atlas", "h_part" .. arg_13_1)

	triggerToggle(arg_13_0.bottomTaskGroupTFs[arg_13_1], (_.all(arg_13_0.configData[arg_13_1], function(arg_14_0)
		local var_14_0 = arg_13_0:getTaskById(arg_14_0)

		return var_14_0 and var_14_0:isReceive()
	end)))

	return
end

function var_0_0.updateTaskGroups(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.configData) do
		if arg_15_0.taskGroupTFs[iter_15_0] then
			arg_15_0:updateTaskGroup(arg_15_0.taskGroupTFs[iter_15_0], iter_15_0, iter_15_1)
		end
	end

	return
end

function var_0_0.updateTaskGroup(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1:Find("mask_lock")
	local var_16_1 = arg_16_1:Find("mask_prev_unfinish")

	arg_16_1:Find("icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/anniversaryui_atlas", "lihui" .. arg_16_2)

	local var_16_2 = arg_16_2 > arg_16_0.date
	local var_16_3 = false
	local var_16_4 = false

	if arg_16_2 > arg_16_0.date then
		local var_16_5 = arg_16_0.activityVO.data1 + (arg_16_2 - 1) * 0

		var_16_4 = arg_16_0.activityVO.data1 + (arg_16_2 - 1) * 0 <= pg.TimeMgr.GetInstance():GetServerTime()

		local var_16_6 = pg.TimeMgr.GetInstance()

		setText(var_16_0:Find("Text"), (var_16_6:STimeDescC(var_16_5, "%m/%d")))
	else
		var_16_3 = _.all(arg_16_3, function(arg_17_0)
			local var_17_0 = arg_16_0:getTaskById(arg_17_0)

			return var_17_0 and var_17_0:isReceive()
		end)
	end

	setActive(var_16_0, var_16_2 and not var_16_4)
	setActive(var_16_1, var_16_2 and var_16_4)
	setActive(arg_16_1:Find("completed"), var_16_3)

	return
end

function var_0_0.updateTaskGroupDesc(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.configData[arg_18_1]
	local var_18_1 = arg_18_0.taskGroupDesc:Find("main/desc")
	local var_18_2 = var_18_1:Find("Image"):GetComponent(typeof(Image))

	var_18_2.sprite = arg_18_0.titles[arg_18_1] and arg_18_0.titles[arg_18_1] or GetSpriteFromAtlas("ui/anniversaryui_atlas", "title" .. arg_18_1)

	local var_18_4 = arg_18_0.taskGroupDesc:Find("main/task_list")

	setText(var_18_1, i18n("anniversary_task_title_" .. arg_18_1))

	local function var_18_5(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0:getTaskById(arg_19_1) or Task.New({
			id = arg_19_1
		})

		setText(arg_19_0:Find("name"), var_19_0:getConfig("name"))
		setText(arg_19_0:Find("desc"), var_19_0:getConfig("desc"))
		onButton(arg_18_0, arg_19_0:Find("confirm_btn"), function()
			if var_19_0:isReceive() then
				-- block empty
			elseif not var_19_0:isFinish() then
				arg_18_0:emit(AnniversaryMediator.TO_TASK, var_19_0)
			elseif var_19_0:isFinish() then
				arg_18_0:emit(AnniversaryMediator.ON_SUBMIT_TASK, arg_19_1)
			end

			return
		end, SFX_PANEL)
		setActive(arg_19_0:Find("confirm_btn/go"), not var_19_0:isFinish())
		setActive(arg_19_0:Find("confirm_btn/finished"), var_19_0:isReceive())

		local var_19_1 = var_19_0:isFinish() and not var_19_0:isReceive()

		setActive(arg_19_0:Find("confirm_btn/get"), var_19_1)

		local var_19_2 = arg_19_0:Find("icon")
		local var_19_3 = var_19_0:getConfig("award_display")[1]

		updateDrop(var_19_2, {
			type = var_19_3[1],
			id = var_19_3[2],
			count = var_19_3[3]
		})
		onButton(arg_18_0, var_19_2, function()
			local var_21_0

			if var_19_3[1] == DROP_TYPE_RESOURCE then
				var_21_0 = id2ItemId(var_19_3[2])
			elseif var_19_3[1] == DROP_TYPE_ITEM then
				var_21_0 = var_19_3[2]
			end

			if var_21_0 then
				arg_18_0:emit(var_0_0.ON_ITEM, var_21_0)
			end

			return
		end, SFX_PANEL)

		arg_19_0:Find("slider"):GetComponent(typeof(Slider)).value = var_19_0:getProgress() / var_19_0:getConfig("target_num")

		setText(arg_19_0:Find("slider/Text"), var_19_0:getProgress() .. "/" .. var_19_0:getConfig("target_num"))

		return
	end

	arg_18_0.ulist = UIItemList.New(var_18_4, (var_18_4:Find("task_tpl")))

	arg_18_0.ulist:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			var_18_5(arg_22_2, var_18_0[arg_22_1 + 1])
		end

		return
	end)
	arg_18_0.ulist:align(#var_18_0)

	return
end

function var_0_0.moveToTaskGroup(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3 then
		LeanTween.cancel(go(arg_23_0.taskGroupDesc))
		LeanTween.cancel(go(arg_23_0.taskGorupContainer))
	elseif LeanTween.isTweening(go(arg_23_0.taskGroupDesc)) or LeanTween.isTweening(go(arg_23_0.taskGorupContainer)) then
		return
	end

	local function var_23_0()
		arg_23_0.dateIndex = arg_23_1

		return
	end

	if arg_23_1 > arg_23_0.date then
		LeanTween.moveLocal(go(arg_23_0.taskGorupContainer), Vector3(arg_23_0.taskGorupContainer.localPosition.x, arg_23_0.startPosition.y + (arg_23_0:getRow(arg_23_1) - 1) * arg_23_0.offset.y, 0), 0.2):setOnComplete(System.Action(var_23_0))

		arg_23_0.taskGroupDesc.localScale = Vector3(0, 1, 1)
		arg_23_0.overStep = true

		if arg_23_0.dateIndex then
			triggerToggle(arg_23_0.taskGroupTFs[arg_23_0.dateIndex], false)
		end
	else
		if arg_23_2 or arg_23_0.overStep then
			arg_23_0.taskGroupDesc.localScale = Vector3(0, 1, 1)

			arg_23_0:openAnim(arg_23_1, var_23_0)
			arg_23_0:updateTaskGroupDesc(arg_23_1)
		elseif arg_23_0.dateIndex then
			arg_23_0:closeAnim(arg_23_0.dateIndex, function()
				arg_23_0:openAnim(arg_23_1, var_23_0)

				arg_23_0.dateIndex = arg_23_1

				arg_23_0:updateTaskGroupDesc(arg_23_0.dateIndex)

				return
			end)
		end

		arg_23_0.overStep = nil
	end

	return
end

function var_0_0.openAnim(arg_26_0, arg_26_1, arg_26_2)
	assert(arg_26_1, "index can not be nil" .. arg_26_1)

	local var_26_0 = arg_26_0.taskGroupTFs[arg_26_1]
	local var_26_1 = arg_26_0.startPosition.y + (arg_26_0:getRow(arg_26_1) - 1) * arg_26_0.offset.y
	local var_26_2 = arg_26_0.taskGorupContainer.localPosition.x

	table.insert({}, function(arg_27_0)
		LeanTween.moveLocal(go(arg_26_0.taskGorupContainer), Vector3(var_26_2, var_26_1, 0), 0.2):setOnComplete(System.Action(arg_27_0))

		return
	end)
	table.insert({}, function(arg_28_0)
		triggerToggle(var_26_0, true)
		LeanTween.rotate(go(var_26_0), Vector3(var_26_0.eulerAngles.x, 0, var_26_0.eulerAngles.z), 0.2):setFrom(Vector3(var_26_0.eulerAngles.x, -180, var_26_0.eulerAngles.z)):setOnComplete(System.Action(arg_28_0))

		return
	end)
	table.insert({}, function(arg_29_0)
		LeanTween.scale(arg_26_0.taskGroupDesc, Vector3(1, 1, 1), 0.2):setFrom(Vector3(0, 1, 1)):setOnComplete(System.Action(arg_29_0))

		arg_26_0.taskGroupDesc.position = var_26_0.position

		arg_26_0.taskGroupDesc:SetAsLastSibling()
		var_26_0:SetAsLastSibling()

		return
	end)
	seriesAsync({}, arg_26_2)

	return
end

function var_0_0.closeAnim(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.taskGroupTFs[arg_30_1]

	table.insert({}, function(arg_31_0)
		LeanTween.scale(arg_30_0.taskGroupDesc, Vector3(0, 1, 1), 0.2):setFrom(Vector3(1, 1, 1)):setOnComplete(System.Action(arg_31_0))

		return
	end)
	table.insert({}, function(arg_32_0)
		LeanTween.rotate(go(var_30_0), Vector3(var_30_0.eulerAngles.x, 0, var_30_0.eulerAngles.z), 0.2):setFrom(Vector3(var_30_0.eulerAngles.x, -180, var_30_0.eulerAngles.z)):setOnComplete(System.Action(arg_32_0))

		return
	end)
	table.insert({}, function(arg_33_0)
		triggerToggle(var_30_0, false)
		arg_33_0()

		return
	end)
	seriesAsync({}, arg_30_2)

	return
end

function var_0_0.addVerticalDrag(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = GetOrAddComponent(arg_34_1, "EventTriggerListener")
	local var_34_1
	local var_34_2 = 0
	local var_34_3 = 50

	var_34_0:AddBeginDragFunc(function()
		var_34_2 = 0
		var_34_1 = nil

		return
	end)
	var_34_0:AddDragFunc(function(arg_36_0, arg_36_1)
		var_34_1 = var_34_1 or arg_36_1.position
		var_34_2 = arg_36_1.position.y - var_34_1.y

		return
	end)
	var_34_0:AddDragEndFunc(function(arg_37_0, arg_37_1)
		if var_34_2 < -var_34_3 then
			if arg_34_3 then
				arg_34_3()
			end
		elseif var_34_2 > var_34_3 and arg_34_2 then
			arg_34_2()
		end

		return
	end)

	return
end

function var_0_0.willExit(arg_38_0)
	return
end

return var_0_0
