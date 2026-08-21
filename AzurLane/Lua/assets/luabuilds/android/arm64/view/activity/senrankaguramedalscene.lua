local var_0_0 = class("SenrankaguraMedalScene", import("..base.BaseUI"))
local var_0_1
local var_0_2
local var_0_3 = 4
local var_0_4 = "shan_luan_task_help"
local var_0_5 = "shan_luan_task_help"

function var_0_0.getUIName(arg_1_0)
	return "SenrankaguraMedalUI"
end

function var_0_0.GetTaskCountAble()
	local var_2_0

	if not getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_TASK_ID) then
		do return false end

		var_2_0 = 0
	end

	for iter_2_0, iter_2_1 in ipairs(pg.activity_template[ActivityConst.SENRANKAGURA_TASK_ID].config_client.player_task) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			table.insert({}, iter_2_3)
		end
	end

	local function var_2_2(arg_3_0)
		if not arg_3_0 then
			return true
		end

		local var_3_0 = getProxy(TaskProxy):getTaskById(arg_3_0)

		if not var_3_0 and not getProxy(TaskProxy):getFinishTaskById(arg_3_0) then
			return false
		end

		local var_3_1 = pg.task_data_template[arg_3_0].activity_client_config.before

		if var_3_0 and var_3_0:getTaskStatus() <= 0 then
			return false
		end

		return var_2_2(var_3_1)
	end

	for iter_2_4 = 1, #{} do
		local var_2_3 = getProxy(TaskProxy):getTaskById(({})[iter_2_4])

		if var_2_3 then
			if var_2_3:getTaskStatus() == 1 then
				if not pg.task_data_template[({})[iter_2_4]].activity_client_config.before then
					var_2_0 = var_2_0 + 1
				elseif (function(arg_3_0)
					if not arg_3_0 then
						return true
					end

					local var_3_0 = getProxy(TaskProxy):getTaskById(arg_3_0)

					if not var_3_0 and not getProxy(TaskProxy):getFinishTaskById(arg_3_0) then
						return false
					end

					local var_3_1 = pg.task_data_template[arg_3_0].activity_client_config.before

					if var_3_0 and var_3_0:getTaskStatus() <= 0 then
						return false
					end

					return var_2_2(var_3_1)
				end)(pg.task_data_template[({})[iter_2_4]].activity_client_config.before) then
					var_2_0 = var_2_0 + 1
				end
			end
		end
	end

	return var_2_0 > 0, var_2_0
end

function var_0_0.init(arg_4_0)
	arg_4_0.activityId = ActivityConst.SENRANKAGURA_TASK_ID
	arg_4_0.taskActivity = getProxy(ActivityProxy):getActivityById(arg_4_0.activityId)
	arg_4_0.taskIds = pg.activity_template[arg_4_0.activityId].config_client.player_task
	arg_4_0.taskCount = 0
	arg_4_0.allTasksIds = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.taskIds) do
		arg_4_0.taskCount = arg_4_0.taskCount + #iter_4_1

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			table.insert(arg_4_0.allTasksIds, iter_4_3)
		end
	end

	arg_4_0.openTaskFlag = arg_4_0.contextData.task
	arg_4_0.buffs = pg.activity_template[arg_4_0.activityId].config_client.buff
	arg_4_0.ptId = pg.activity_template[arg_4_0.activityId].config_client.pt_id
	arg_4_0.ptName = pg.player_resource[arg_4_0.ptId].name
	arg_4_0.ptMaxNum = #arg_4_0.allTasksIds
	var_0_1 = #arg_4_0.taskIds
	var_0_2 = #arg_4_0.buffs
	arg_4_0.taskListDatas = {}

	for iter_4_4 = 1, #arg_4_0.taskIds do
		for iter_4_5, iter_4_6 in ipairs(arg_4_0.taskIds[iter_4_4]) do
			arg_4_0:initTaskListIds(iter_4_6, {})
		end

		arg_4_0:sortListDatas({})
		table.insert(arg_4_0.taskListDatas, {})
	end

	local var_4_0 = findTF(arg_4_0._tf, "ad")

	arg_4_0.btnDetail = findTF(var_4_0, "btnDetail")
	arg_4_0.btnBack = findTF(var_4_0, "frame/btnBack")
	arg_4_0.btnHelp = findTF(var_4_0, "frame/btnHelp")
	arg_4_0.btnHome = findTF(var_4_0, "frame/btnHome")
	arg_4_0.hxTf = findTF(var_4_0, "hx")

	setActive(arg_4_0.hxTf, PLATFORM_CODE == PLATFORM_CH)
	onButton(arg_4_0, arg_4_0.btnDetail, function()
		if arg_4_0:getMedalGetAble() then
			pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = ActivityConst.SENRANKAGURA_MEDAL_ID
			})
		elseif arg_4_0.taskActivity then
			arg_4_0:openDetailPane()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))
		end

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.btnBack, function()
		arg_4_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0.btnHome, function()
		arg_4_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_4].tip
		})

		return
	end, SFX_CONFIRM)

	arg_4_0.btnPlayers = {}

	for iter_4_7 = 1, var_0_1 do
		local var_4_2 = findTF(var_4_0, "player/" .. iter_4_7)

		GetComponent(findTF(var_4_2, "img"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		if arg_4_0.taskActivity then
			onButton(arg_4_0, var_4_2, function()
				arg_4_0:openTaskPanel(iter_4_7)

				return
			end, SFX_CONFIRM)
		end

		setActive(findTF(var_4_2, "redTip"), false)
		table.insert(arg_4_0.btnPlayers, var_4_2)
	end

	local var_4_3 = findTF(arg_4_0._tf, "pop")

	arg_4_0.detailPanel = findTF(var_4_3, "detailPanel")

	setActive(arg_4_0.detailPanel, false)
	arg_4_0:initDetailPanel()

	arg_4_0.taskPanel = findTF(var_4_3, "taskPanel")

	setActive(arg_4_0.taskPanel, false)
	arg_4_0:initTaskPanel()

	arg_4_0.submitPanel = findTF(var_4_3, "submitPanel")

	setActive(arg_4_0.submitPanel, false)
	arg_4_0:initSubmitPanel()

	return
end

function var_0_0.didEnter(arg_10_0)
	arg_10_0:updateUI()

	if arg_10_0.taskActivity and arg_10_0.openTaskFlag then
		arg_10_0.openTaskFlag = false

		arg_10_0:openTaskPanel()
	end

	return
end

function var_0_0.updateUI(arg_11_0)
	local var_11_0 = arg_11_0:getMedalGetAble()

	setActive(findTF(arg_11_0.btnDetail, "detail"), not var_11_0 and arg_11_0.taskActivity)
	setActive(findTF(arg_11_0.btnDetail, "get"), var_11_0)

	local var_11_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)
	local var_11_2 = var_11_1:GetPicturePuzzleIds()

	for iter_11_0 = 1, #arg_11_0.btnPlayers do
		setActive(findTF(arg_11_0.btnPlayers[iter_11_0], "medal/icon"), table.contains(var_11_1.data2_list, var_11_2[iter_11_0]))
		setActive(findTF(arg_11_0.btnPlayers[iter_11_0], "img/got"), table.contains(var_11_1.data2_list, var_11_2[iter_11_0]))
	end

	local var_11_3 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)

	for iter_11_1 = 1, #var_11_3.data1_list do
		local var_11_4

		if not false and not table.contains(var_11_3.data2_list, var_11_3.data1_list[iter_11_1]) then
			var_11_4 = true

			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = var_11_3.data1_list[iter_11_1],
				actId = var_11_3.id
			})
		end
	end

	if arg_11_0.taskActivity then
		local var_11_5 = arg_11_0:getGetAbleTask()
		local var_11_6 = {}

		for iter_11_2 = 1, #arg_11_0.taskIds do
			for iter_11_3, iter_11_4 in ipairs(arg_11_0.taskIds[iter_11_2]) do
				if table.contains(var_11_5, iter_11_4) then
					var_11_6[iter_11_2] = not var_11_6[iter_11_2] and 1 or var_11_6[iter_11_2] + 1
				end
			end
		end

		for iter_11_5 = 1, #arg_11_0.btnPlayers do
			setActive(findTF(arg_11_0.btnPlayers[iter_11_5], "redTip"), var_11_6[iter_11_5] ~= nil)
		end

		arg_11_0:updateDetailPanel()
		arg_11_0:updateTask()
	end

	return
end

function var_0_0.getMedalGetAble(arg_12_0)
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)

	if #var_12_0.data2_list == #var_12_0:GetPicturePuzzleIds() and var_12_0.data1 ~= 1 then
		return true
	end

	return false
end

function var_0_0.openDetailPane(arg_13_0)
	setActive(arg_13_0.detailPanel, true)

	return
end

function var_0_0.initDetailPanel(arg_14_0)
	arg_14_0.detailSlider = findTF(arg_14_0.detailPanel, "ad/progressSlider")
	arg_14_0.detailClose = findTF(arg_14_0.detailPanel, "ad/btnClose")

	onButton(arg_14_0, findTF(arg_14_0.detailPanel, "ad/black"), function()
		setActive(arg_14_0.detailPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_14_0, arg_14_0.detailClose, function()
		setActive(arg_14_0.detailPanel, false)

		return
	end)

	arg_14_0.detailProgressTipContent = findTF(arg_14_0.detailPanel, "ad/progressDetail")
	arg_14_0.detailProgressTipTpl = findTF(arg_14_0.detailPanel, "ad/progressDetail/tipTpl")

	setActive(arg_14_0.detailProgressTipTpl, false)

	local var_14_0 = findTF(arg_14_0.detailPanel, "ad/progressDetail").sizeDelta.x

	arg_14_0.medalTfs = {}

	for iter_14_0 = 1, var_0_1 do
		table.insert(arg_14_0.medalTfs, findTF(arg_14_0.detailPanel, "ad/medals/" .. iter_14_0))
	end

	for iter_14_1 = 1, var_0_2 do
		local var_14_1 = tf(instantiate(arg_14_0.detailProgressTipTpl))

		setImageSprite(findTF(var_14_1, "num"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "buff_" .. iter_14_1), true)
		setImageSprite(findTF(var_14_1, "count"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "buff_count_" .. iter_14_1), true)

		var_14_1.anchoredPosition = Vector3(arg_14_0.buffs[iter_14_1].pt[1] / arg_14_0.ptMaxNum * var_14_0, 0, 0)

		SetParent(var_14_1, arg_14_0.detailProgressTipContent)
		SetActive(var_14_1, true)
	end

	arg_14_0.detailBuffTfs = {}

	for iter_14_2 = 1, var_0_3 do
		table.insert(arg_14_0.detailBuffTfs, (findTF(arg_14_0.detailPanel, "ad/buff/" .. iter_14_2)))
	end

	arg_14_0.detailProgressDesc = findTF(arg_14_0.detailPanel, "ad/progressDesc")
	arg_14_0.detailLevelDesc = findTF(arg_14_0.detailPanel, "ad/levelDesc")

	return
end

function var_0_0.updateDetailPanel(arg_17_0)
	local var_17_0 = arg_17_0:getPtNum()
	local var_17_1 = arg_17_0:getBuildLv(var_17_0)
	local var_17_2

	if var_17_1 ~= 0 then
		var_17_2 = arg_17_0.buffs[var_17_1].benefit
	end

	for iter_17_0 = 1, var_0_3 do
		local var_17_3 = var_17_2 and pg.benefit_buff_template[var_17_2[iter_17_0]].desc or i18n("shan_luan_task_buff_default")

		setText(findTF(arg_17_0.detailBuffTfs[iter_17_0], "desc"), var_17_3)
	end

	setSlider(arg_17_0.detailSlider, 0, arg_17_0.ptMaxNum, var_17_0)

	local var_17_4 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID)
	local var_17_6 = var_17_4:GetPicturePuzzleIds()

	for iter_17_1 = 1, #arg_17_0.medalTfs do
		setActive(findTF(arg_17_0.medalTfs[iter_17_1], "icon"), table.contains(var_17_4.data2_list, var_17_6[iter_17_1]))
	end

	setText(findTF(arg_17_0.detailProgressDesc, "desc"), i18n("shan_luan_task_progress_tip", arg_17_0:getTaskCompleteCount() .. "/" .. arg_17_0.taskCount))
	setText(findTF(arg_17_0.detailLevelDesc, "desc"), i18n("shan_luan_task_level_tip", "Lv." .. var_17_1))

	return
end

function var_0_0.getTaskCompleteCount(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs((arg_18_0:getActiveTask())) do
		local var_18_1 = arg_18_0:getTask(iter_18_1)

		if var_18_1:getTaskStatus() == 2 then
			var_18_0 = var_18_0 + 1
		else
			print()
		end
	end

	return var_18_0
end

function var_0_0.getPtNum(arg_19_0)
	local var_19_0 = 0

	var_19_0 = arg_19_0.ptId and (getProxy(PlayerProxy):getData()[arg_19_0.ptName] or 0) or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetBuildingLevelSum()

	if var_19_0 > arg_19_0.ptMaxNum then
		var_19_0 = arg_19_0.ptMaxNum
	end

	return var_19_0
end

function var_0_0.getBuildLv(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0 = #arg_20_0.buffs, 1, -1 do
		var_20_0 = arg_20_1 >= arg_20_0.buffs[iter_20_0].pt[1] and var_20_0 < iter_20_0 and iter_20_0 or var_20_0
	end

	return var_20_0
end

function var_0_0.initTaskListIds(arg_21_0, arg_21_1, arg_21_2)
	local var_21_1 = pg.task_data_template[arg_21_1].activity_client_config.special or false
	local var_21_2 = {
		id = arg_21_1,
		before = pg.task_data_template[arg_21_1].activity_client_config.before,
		special = var_21_1
	}

	for iter_21_0, iter_21_1 in ipairs(arg_21_2) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1) do
			if iter_21_3.id == pg.task_data_template[arg_21_1].activity_client_config.before then
				table.insert(iter_21_1, var_21_2)

				return
			elseif iter_21_3.before == arg_21_1 then
				table.insert(iter_21_1, var_21_2)

				return
			end
		end
	end

	table.insert(arg_21_2, {
		var_21_2
	})

	return
end

function var_0_0.initTaskPanel(arg_22_0)
	onButton(arg_22_0, findTF(arg_22_0.taskPanel, "ad/frame/btnBack"), function()
		setActive(arg_22_0.taskPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_22_0, findTF(arg_22_0.taskPanel, "ad/frame/btnHome"), function()
		arg_22_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, findTF(arg_22_0.taskPanel, "ad/frame/btnHelp"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_5].tip
		})

		return
	end, SFX_CONFIRM)

	arg_22_0.taskTagTfs = {}

	local var_22_0 = findTF(arg_22_0.taskPanel, "ad/tag/content")
	local var_22_1 = findTF(arg_22_0.taskPanel, "ad/tag/content/tagTpl")

	setActive(var_22_1, false)

	for iter_22_0 = 1, var_0_1 do
		local var_22_2 = iter_22_0
		local var_22_3 = tf(instantiate(var_22_1))

		setImageSprite(findTF(var_22_3, "icon"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "player_icon_" .. iter_22_0), true)
		SetParent(var_22_3, var_22_0)
		setActive(var_22_3, true)
		table.insert(arg_22_0.taskTagTfs, var_22_3)
		onButton(arg_22_0, var_22_3, function()
			arg_22_0:taskSelectTag(var_22_2, true)

			return
		end, SFX_CONFIRM)
	end

	arg_22_0.taskButtonTpl = findTF(arg_22_0.taskPanel, "ad/taskButtonTpl")
	arg_22_0.taskList = {}

	local var_22_4 = findTF(arg_22_0.taskPanel, "ad/task/content")

	arg_22_0.taskDragTf = findTF(arg_22_0.taskPanel, "ad/task/drag")

	local var_22_5 = findTF(arg_22_0.taskPanel, "ad/taskTpl")
	local var_22_6 = findTF(arg_22_0.taskPanel, "ad/taskButtonTpl")

	setActive(var_22_5, false)
	setActive(var_22_6, false)

	arg_22_0.taskGroups = {}

	for iter_22_1 = 1, var_0_1 do
		for iter_22_2 = 1, #arg_22_0.taskListDatas[iter_22_1] do
			local var_22_7 = tf(instantiate(var_22_5))

			setParent(var_22_7, var_22_4)
			setActive(var_22_7, true)

			local var_22_8 = {}

			for iter_22_3, iter_22_4 in ipairs(arg_22_0.taskListDatas[iter_22_1][iter_22_2]) do
				local var_22_9 = tf(instantiate(var_22_6))

				var_22_9.anchoredPosition = Vector2(iter_22_4.pos[1] * 325 + iter_22_4.pos[2] * 90, iter_22_4.pos[2] * 190)

				if iter_22_4.special then
					if iter_22_4.pos[2] ~= 0 then
						setImageSprite(findTF(var_22_9, "get"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_get_" .. 4), true)
						setImageSprite(findTF(var_22_9, "got"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_got_" .. 4), true)
					else
						setImageSprite(findTF(var_22_9, "get"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_get_" .. 2), true)
						setImageSprite(findTF(var_22_9, "got"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_got_" .. 2), true)
					end
				elseif not iter_22_4.special and iter_22_4.pos[2] ~= 0 then
					setImageSprite(findTF(var_22_9, "get"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_get_" .. 3), true)
					setImageSprite(findTF(var_22_9, "got"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "task_got_" .. 3), true)
				end

				setActive(var_22_9, true)
				SetParent(var_22_9, var_22_7)
				table.insert(var_22_8, {
					tf = var_22_9,
					data = iter_22_4
				})
				onButton(arg_22_0, var_22_9, function()
					arg_22_0:openSubmitPanel(iter_22_4)

					return
				end, SFX_CONFIRM)
			end

			;({}).listTf = var_22_7
			;({}).taskDic = var_22_8
		end

		table.insert(arg_22_0.taskGroups, {})
	end

	arg_22_0.taskButtonTpl = findTF(arg_22_0.taskPanel, "ad/buttonTpl")
	arg_22_0.taskBtnGetAll = findTF(arg_22_0.taskPanel, "ad/btnGetAll")

	onButton(arg_22_0, arg_22_0.taskBtnGetAll, function()
		local var_28_0 = arg_22_0:getGetAbleTask()

		if var_28_0 and #var_28_0 > 0 then
			arg_22_0:emit(SenrankaguraMedalMediator.SUBMIT_TASK_ALL, var_28_0)
		end

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.updateTask(arg_29_0)
	for iter_29_0 = 1, #arg_29_0.taskGroups do
		for iter_29_1, iter_29_2 in ipairs(arg_29_0.taskGroups[iter_29_0].taskDic) do
			local var_29_0 = arg_29_0:getTask(iter_29_2.data.id)

			setActive(findTF(iter_29_2.tf, "lock"), false)
			setActive(findTF(iter_29_2.tf, "getAble"), false)
			setActive(findTF(iter_29_2.tf, "get"), false)
			setActive(findTF(iter_29_2.tf, "got"), false)

			if var_29_0 then
				if arg_29_0:checkTaskBeforeComplete(var_29_0:getConfig("activity_client_config").before) then
					if var_29_0:getTaskStatus() == 0 then
						setActive(findTF(iter_29_2.tf, "get"), true)
					elseif var_29_0:getTaskStatus() == 1 then
						setActive(findTF(iter_29_2.tf, "get"), true)
						setActive(findTF(iter_29_2.tf, "getAble"), true)
					elseif var_29_0:getTaskStatus() == 2 then
						setActive(findTF(iter_29_2.tf, "got"), true)
					end
				else
					setActive(findTF(iter_29_2.tf, "lock"), true)
					setActive(findTF(iter_29_2.tf, "get"), true)
				end
			else
				setActive(findTF(iter_29_2.tf, "lock"), true)
				setActive(findTF(iter_29_2.tf, "get"), true)
			end
		end
	end

	if #arg_29_0:getGetAbleTask() > 0 then
		setActive(arg_29_0.taskBtnGetAll, true)
	else
		setActive(arg_29_0.taskBtnGetAll, false)
	end

	for iter_29_3 = 1, #arg_29_0.taskGroups do
		for iter_29_4, iter_29_5 in ipairs(arg_29_0.taskGroups[iter_29_3].taskDic) do
			local var_29_2 = iter_29_5.data.pos
			local var_29_3 = iter_29_5.tf

			setActive(findTF(iter_29_5.tf, "line/back"), false)
			setActive(findTF(var_29_3, "line/bottom"), false)
			setActive(findTF(var_29_3, "line/top"), false)
			var_29_3:SetAsFirstSibling()

			if not iter_29_5.data.before then
				setActive(findTF(var_29_3, "line"), false)
			else
				local var_29_4 = arg_29_0:getTaskPos(iter_29_5.data.before)
				local var_29_5 = arg_29_0:getTask(iter_29_5.data.before)
				local var_29_6 = arg_29_0:checkTaskBeforeComplete(iter_29_5.data.before) and Color.New(0.9921568627450981, 0.9647058823529412, 0.8666666666666667) or Color.New(0.48627450980392156, 0.35294117647058826, 0.2901960784313726)

				if var_29_4[1] < var_29_2[1] then
					setActive(findTF(var_29_3, "line/back"), true)
					setImageColor(findTF(var_29_3, "line/back"), var_29_6)
				elseif var_29_4[2] < var_29_2[2] then
					setActive(findTF(var_29_3, "line/bottom"), true)
					setImageColor(findTF(var_29_3, "line/bottom"), var_29_6)
				else
					setActive(findTF(var_29_3, "line/top"), true)
					setImageColor(findTF(var_29_3, "line/top"), var_29_6)
				end

				setActive(findTF(var_29_3, "line"), true)
			end
		end
	end

	return
end

function var_0_0.checkTaskBeforeComplete(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return true
	end

	local var_30_0 = arg_30_0:getTaskGroupData(arg_30_1).before
	local var_30_1 = arg_30_0:getTask(arg_30_1)

	if not var_30_1 then
		return true
	end

	if var_30_1:getTaskStatus() == 0 then
		return false
	end

	if var_30_1:getTaskStatus() >= 1 then
		return arg_30_0:checkTaskBeforeComplete(var_30_0)
	end

	return true
end

function var_0_0.getTaskGroupData(arg_31_0, arg_31_1)
	for iter_31_0 = 1, #arg_31_0.taskGroups do
		for iter_31_1, iter_31_2 in ipairs(arg_31_0.taskGroups[iter_31_0].taskDic) do
			if iter_31_2.data.id == arg_31_1 then
				return iter_31_2.data
			end
		end
	end

	return nil
end

function var_0_0.getTaskPos(arg_32_0, arg_32_1)
	for iter_32_0 = 1, #arg_32_0.taskGroups do
		for iter_32_1, iter_32_2 in ipairs(arg_32_0.taskGroups[iter_32_0].taskDic) do
			if iter_32_2.data.id == arg_32_1 then
				return iter_32_2.data.pos
			end
		end
	end

	return nil
end

function var_0_0.getTask(arg_33_0, arg_33_1)
	local var_33_0 = getProxy(TaskProxy)
	local var_33_1 = var_33_0:getTaskById(arg_33_1)

	if var_33_1 then
		return var_33_1
	end

	local var_33_3 = var_33_0:getFinishTaskById(arg_33_1)

	if var_33_3 then
		return var_33_3
	end

	return nil
end

function var_0_0.getGetAbleTask(arg_34_0)
	local var_34_0 = getProxy(TaskProxy)
	local var_34_1 = arg_34_0:getActiveTask()

	for iter_34_0 = 1, #var_34_1 do
		local var_34_2 = var_34_0:getTaskById(var_34_1[iter_34_0])

		if var_34_2 and var_34_2:getTaskStatus() == 1 then
			table.insert({}, var_34_2.id)
		end
	end

	return {}
end

function var_0_0.getActiveTask(arg_35_0)
	for iter_35_0 = 1, #arg_35_0.taskGroups do
		for iter_35_1, iter_35_2 in ipairs(arg_35_0.taskGroups[iter_35_0].taskDic) do
			if not iter_35_2.data.before then
				table.insert({}, iter_35_2.data.id)
			elseif arg_35_0:checkTaskBeforeComplete(iter_35_2.data.before) then
				table.insert({}, iter_35_2.data.id)
			end
		end
	end

	return {}
end

function var_0_0.taskSelectTag(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = 0

	if arg_36_0.currentSelectIndex then
		var_36_0 = math.abs(arg_36_0.currentSelectIndex - arg_36_1)
	end

	arg_36_0.currentSelectIndex = arg_36_1
	arg_36_0.currentSelectTag = arg_36_0.taskTagTfs[arg_36_1]
	arg_36_0.currentTaskDatas = arg_36_0.taskListDatas[arg_36_1]

	for iter_36_0 = 1, #arg_36_0.taskTagTfs do
		setActive(findTF(arg_36_0.taskTagTfs[iter_36_0], "select"), arg_36_0.currentSelectTag == arg_36_0.taskTagTfs[iter_36_0])
	end

	arg_36_0.taskScrollRect = GetComponent(findTF(arg_36_0.taskPanel, "ad/task"), typeof(ScrollRect))

	local var_36_1 = Vector2(arg_36_0.taskScrollRect.normalizedPosition.x, arg_36_0.taskScrollRect.normalizedPosition.y)

	if arg_36_2 then
		if LeanTween.isTweening(go(arg_36_0._tf)) then
			LeanTween.cancel(go(arg_36_0._tf))
		end

		LeanTween.value(go(arg_36_0._tf), arg_36_0.taskScrollRect.normalizedPosition.y, (var_0_1 - 1 - (arg_36_1 - 1)) / (var_0_1 - 1), 0.3 + var_36_0 * 0.1):setOnUpdate(System.Action_float(function(arg_37_0)
			var_36_1.y = arg_37_0
			arg_36_0.taskScrollRect.normalizedPosition = var_36_1

			arg_36_0.taskScrollRect.onValueChanged:Invoke(var_36_1)

			return
		end))
	else
		scrollTo(arg_36_0.taskScrollRect, 0, (var_0_1 - 1 - (arg_36_1 - 1)) / (var_0_1 - 1))
	end

	return
end

function var_0_0.openTaskPanel(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or 1

	arg_38_0:taskSelectTag(arg_38_1, false)
	setActive(arg_38_0.taskPanel, true)

	return
end

function var_0_0.sortListDatas(arg_39_0, arg_39_1)
	local var_39_0

	for iter_39_0 = 1, #arg_39_1 do
		var_39_0 = {}

		for iter_39_1 = 1, #arg_39_1[iter_39_0] do
			local var_39_2
			local var_39_3 = arg_39_1[iter_39_0][iter_39_1]

			if not arg_39_1[iter_39_0][iter_39_1].before then
				var_39_2 = {
					0,
					0
				}
			elseif var_39_3.before then
				local var_39_4 = (function(arg_41_0, arg_41_1)
					for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
						if iter_41_1.id == arg_41_0 then
							return iter_41_1
						end
					end

					return
				end)(var_39_3.before, arg_39_1[iter_39_0])

				assert(var_39_4, "找不到前置id.." .. var_39_3.before)

				local var_39_5 = var_39_4.pos
				local var_39_6 = {
					var_39_4.pos[1] + 1,
					var_39_4.pos[2]
				}

				for iter_39_2 = 1, 10 do
					if (function(arg_40_0)
						for iter_40_0, iter_40_1 in ipairs(var_39_0) do
							if iter_40_1[1] == arg_40_0[1] and iter_40_1[2] == arg_40_0[2] then
								return false
							end
						end

						return true
					end)(var_39_6) then
						break
					else
						if iter_39_2 == 1 then
							var_39_6[1] = var_39_6[1] - 1
						end

						var_39_6[2] = var_39_6[2] > 0 and var_39_6[2] * -1 or math.abs(var_39_6[2]) + 1

						if var_39_5[2] - var_39_6[2] > 1 then
							var_39_4.pos = {
								var_39_6[1],
								var_39_6[2]
							}
							var_39_6[1] = var_39_6[1] + 1
						end
					end

					assert(iter_39_2 ~= 10, "任务分支超过10个")
				end

				var_39_2 = var_39_6
			end

			var_39_3.pos = var_39_2

			table.insert(var_39_0, var_39_2)
		end
	end

	return
end

function var_0_0.openSubmitPanel(arg_42_0, arg_42_1)
	setActive(arg_42_0.submitPanel, true)
	setImageSprite(findTF(arg_42_0.submitPanel, "icon/img"), GetSpriteFromAtlas("ui/senrankaguramedalui_atlas", "player_icon_" .. arg_42_0.currentSelectIndex), true)

	local var_42_0 = arg_42_0:getTask(arg_42_1.id)
	local var_42_1 = arg_42_0:checkTaskBeforeComplete(arg_42_1.before)

	if var_42_0 then
		arg_42_0.selectTask = var_42_0

		setText(findTF(arg_42_0.submitPanel, "taskDesc"), var_42_0:getConfig("desc"))
		setText(findTF(arg_42_0.submitPanel, "img/taskName"), var_42_0:getConfig("name"))
		setText(findTF(arg_42_0.submitPanel, "progress/taskProgress"), setColorStr(var_42_0:getProgress(), "#C2695B") .. "/" .. setColorStr(var_42_0:getConfig("target_num"), "#9D6B59"))
		arg_42_0:setSubmitAward((var_42_0:getConfig("award_display")))
		setActive(arg_42_0.submitGo, var_42_0:getTaskStatus() == 0 or not var_42_1)
		setActive(arg_42_0.submitGet, var_42_0:getTaskStatus() == 1 and var_42_1)
		setActive(arg_42_0.submitGot, var_42_0:getTaskStatus() == 2)
	end

	return
end

function var_0_0.initSubmitPanel(arg_43_0)
	arg_43_0.submitGet = findTF(arg_43_0.submitPanel, "get")
	arg_43_0.submitGot = findTF(arg_43_0.submitPanel, "got")
	arg_43_0.submitGo = findTF(arg_43_0.submitPanel, "go")
	arg_43_0.submitbtnBack = findTF(arg_43_0.submitPanel, "back")
	arg_43_0.submitDisplayContent = findTF(arg_43_0.submitPanel, "itemDisplay/viewport/content")
	arg_43_0.submitItemTpl = findTF(arg_43_0.submitPanel, "itemDisplay/viewport/content/item")

	setActive(arg_43_0.submitItemTpl, false)

	arg_43_0.submitItemDesc = findTF(arg_43_0.submitPanel, "itemDesc")
	arg_43_0.submitItems = {}

	onButton(arg_43_0, findTF(arg_43_0.submitPanel, "black"), function()
		setActive(arg_43_0.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_43_0, arg_43_0.submitbtnBack, function()
		setActive(arg_43_0.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_43_0, arg_43_0.submitGet, function()
		if arg_43_0.selectTask then
			arg_43_0:emit(SenrankaguraMedalMediator.SUBMIT_TASK, arg_43_0.selectTask.id)
		end

		setActive(arg_43_0.submitPanel, false)

		return
	end, SOUND_BACK)
	onButton(arg_43_0, arg_43_0.submitGo, function()
		setActive(arg_43_0.submitPanel, false)

		if arg_43_0.selectTask then
			arg_43_0:emit(SenrankaguraMedalMediator.TASK_GO, arg_43_0.selectTask)
		end

		return
	end, SOUND_BACK)
	setText(findTF(arg_43_0.submitPanel, "bg/txtDesc"), i18n("ryza_task_detail_content"))
	setText(findTF(arg_43_0.submitPanel, "bg/txtAward"), i18n("ryza_task_detail_award"))

	return
end

function var_0_0.setSubmitAward(arg_48_0, arg_48_1)
	if #arg_48_0.submitItems < #arg_48_1 then
		for iter_48_0 = 1, #arg_48_1 - #arg_48_0.submitItems do
			local var_48_0 = tf(instantiate(arg_48_0.submitItemTpl))

			setParent(var_48_0, arg_48_0.submitDisplayContent)
			table.insert(arg_48_0.submitItems, var_48_0)
		end
	end

	for iter_48_1 = 1, #arg_48_0.submitItems do
		if iter_48_1 <= #arg_48_1 then
			updateDrop(arg_48_0.submitItems[iter_48_1], {
				type = arg_48_1[iter_48_1][1],
				id = arg_48_1[iter_48_1][2],
				count = arg_48_1[iter_48_1][3]
			})
			onButton(arg_48_0, arg_48_0.submitItems[iter_48_1], function()
				arg_48_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_48_0.submitItems[iter_48_1], true)
		else
			setActive(arg_48_0.submitItems[iter_48_1], false)
		end
	end

	return
end

function var_0_0.willExit(arg_50_0)
	if LeanTween.isTweening(go(arg_50_0._tf)) then
		LeanTween.cancel(go(arg_50_0._tf))
	end

	return
end

return var_0_0
