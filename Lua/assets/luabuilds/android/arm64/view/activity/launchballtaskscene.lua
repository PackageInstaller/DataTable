local var_0_0 = class("LaunchBallTaskScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LaunchBallTaskUI"
end

function var_0_0.getBGM(arg_2_0)
	return "cw-story"
end

function var_0_0.init(arg_3_0)
	arg_3_0.taskDatas = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA_TASK):getConfig("config_client")
	arg_3_0.iconTpl = findTF(arg_3_0._tf, "ad/players/Viewport/Content/iconTpl")

	setActive(arg_3_0.iconTpl, false)

	arg_3_0.iconContent = findTF(arg_3_0._tf, "ad/players/Viewport/Content")
	arg_3_0.icons = {}

	for iter_3_0 = 1, #arg_3_0.taskDatas do
		local var_3_0 = tf(instantiate(arg_3_0.iconTpl))
		local var_3_2 = arg_3_0.taskDatas[iter_3_0].player
		local var_3_3 = LaunchBallActivityMgr.GetPlayerZhuanshuIndex(arg_3_0.taskDatas[iter_3_0].player)
		local var_3_4 = var_3_3 and LaunchBallActivityMgr.CheckZhuanShuAble(ActivityConst.MINIGAME_ZUMA, var_3_3) or true

		setActive(findTF(var_3_0, "lock"), not var_3_4)
		GetSpriteFromAtlasAsync("ui/launchballtaskui_atlas", "playerIcon" .. arg_3_0.taskDatas[iter_3_0].player, function(arg_4_0)
			if arg_4_0 then
				setImageSprite(findTF(var_3_0, "img"), arg_4_0, true)
			end

			return
		end)
		setParent(var_3_0, arg_3_0.iconContent)
		setActive(var_3_0, true)
		onButton(arg_3_0, var_3_0, function()
			if var_3_4 then
				arg_3_0:selectPlayer(var_3_2)
			else
				local var_5_0

				if var_3_2 == 2 then
					var_5_0 = i18n("launchball_lock_Shinano")
				elseif var_3_2 == 3 then
					var_5_0 = i18n("launchball_lock_Yura")
				elseif var_3_2 == 4 then
					var_5_0 = i18n("launchball_lock_Shimakaze")
				end

				pg.TipsMgr.GetInstance():ShowTips(var_5_0)
			end

			return
		end)
		table.insert(arg_3_0.icons, {
			tf = var_3_0,
			player = var_3_2
		})
	end

	arg_3_0.taskTpl = findTF(arg_3_0._tf, "ad/tasks/Viewport/Content/taskTpl")
	arg_3_0.taskContent = findTF(arg_3_0._tf, "ad/tasks/Viewport/Content")

	setActive(arg_3_0.taskTpl, false)

	arg_3_0.tasks = {}

	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/getAll"), function()
		if #arg_3_0.submitTasks > 1 then
			arg_3_0:emit(LaunchBallTaskMediator.SUBMIT_ALL, arg_3_0.submitTasks)
		end

		return
	end)

	arg_3_0.helpWindow = findTF(arg_3_0._tf, "helpWindow")

	setActive(arg_3_0.helpWindow, false)
	onButton(arg_3_0, findTF(arg_3_0.helpWindow, "ad"), function()
		setActive(arg_3_0.helpWindow, false)

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0.helpWindow, "ad/btnOk"), function()
		setActive(arg_3_0.helpWindow, false)

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/back"), function()
		arg_3_0:closeView()

		return
	end)
	arg_3_0:selectPlayer(1)

	return
end

function var_0_0.selectPlayer(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0.icons do
		setActive(findTF(arg_10_0.icons[iter_10_0].tf, "selected"), arg_10_0.icons[iter_10_0].player == arg_10_1)
	end

	arg_10_0:updateTaskList((arg_10_0:getTaskByPlayer(arg_10_1)))

	arg_10_0.selectPlayerId = arg_10_1

	return
end

function var_0_0.updateTaskList(arg_11_0, arg_11_1)
	arg_11_0.submitTasks = {}

	for iter_11_0 = 1, #arg_11_0.tasks do
		setActive(arg_11_0.tasks[iter_11_0].tf, false)
	end

	local var_11_0 = {}

	for iter_11_1 = 1, #arg_11_1 do
		local var_11_1 = getProxy(TaskProxy):getTaskById(arg_11_1[iter_11_1][2])
		local var_11_2 = getProxy(TaskProxy):getFinishTaskById(arg_11_1[iter_11_1][2])

		if var_11_1 then
			table.insert(var_11_0, {
				data = var_11_1,
				type = arg_11_1[iter_11_1][1]
			})
		elseif var_11_2 then
			table.insert(var_11_0, {
				data = var_11_2,
				type = arg_11_1[iter_11_1][1]
			})
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1.data

		if arg_12_0.data:getTaskStatus() == 1 and var_12_0:getTaskStatus() ~= 1 then
			return true
		elseif arg_12_0.data:getTaskStatus() ~= 1 and var_12_0:getTaskStatus() == 1 then
			return false
		elseif arg_12_0.data:getTaskStatus() == 2 and var_12_0:getTaskStatus() ~= 2 then
			return false
		elseif arg_12_0.data:getTaskStatus() ~= 2 and var_12_0:getTaskStatus() == 2 then
			return true
		else
			return arg_12_0.data.id < var_12_0.id
		end

		return
	end)

	for iter_11_2 = 1, #var_11_0 do
		local var_11_3

		if iter_11_2 > #arg_11_0.tasks then
			var_11_3 = tf(instantiate(arg_11_0.taskTpl))

			setParent(var_11_3, arg_11_0.taskContent)
			setActive(var_11_3, true)
			table.insert(arg_11_0.tasks, {
				tf = var_11_3
			})
		else
			var_11_3 = arg_11_0.tasks[iter_11_2].tf
		end

		local var_11_4 = var_11_0[iter_11_2].data
		local var_11_5 = var_11_0[iter_11_2].data.id
		local var_11_6 = var_11_0[iter_11_2].data:getProgress()
		local var_11_8 = var_11_0[iter_11_2].data:getTargetNumber()
		local var_11_9 = var_11_0[iter_11_2].data:getConfig("desc")
		local var_11_10 = var_11_0[iter_11_2].data:getConfig("award_display")[1]

		setSlider(findTF(var_11_3, "Slider"), 0, 1, nil / nil)
		updateDrop(findTF(var_11_3, "icon"), {
			type = (nil)[1],
			id = (nil)[2],
			count = (nil)[3]
		})
		setActive(findTF(var_11_3, "icon"), true)
		setText(findTF(var_11_3, "desc"), nil)
		setText(findTF(var_11_3, "progress"), var_11_6 .. "/" .. nil)

		local var_11_11

		if var_11_0[iter_11_2].type == LaunchBallTaskMgr.type_series_split then
			var_11_11 = i18n("launchball_spilt_series")
		elseif var_11_0[iter_11_2].type == LaunchBallTaskMgr.type_close_split then
			var_11_11 = i18n("launchball_spilt_mix")
		elseif var_11_0[iter_11_2].type == LaunchBallTaskMgr.type_over_split then
			var_11_11 = i18n("launchball_spilt_over")
		elseif var_11_0[iter_11_2].type == LaunchBallTaskMgr.type_many_split then
			var_11_11 = i18n("launchball_spilt_many")
		end

		if var_11_11 then
			setActive(findTF(var_11_3, "tip"), true)
		else
			setActive(findTF(var_11_3, "tip"), false)
		end

		onButton(arg_11_0, findTF(var_11_3, "tip"), function()
			setText(findTF(arg_11_0.helpWindow, "ad/desc"), var_11_11)
			setActive(arg_11_0.helpWindow, true)

			return
		end)
		setActive(findTF(var_11_3, "go"), var_11_4:getTaskStatus() == 0)
		setActive(findTF(var_11_3, "got"), var_11_4:getTaskStatus() == 2)
		setActive(findTF(var_11_3, "get"), var_11_4:getTaskStatus() == 1)
		onButton(arg_11_0, findTF(var_11_3, "go"), function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_DARK)

			return
		end)
		onButton(arg_11_0, findTF(var_11_3, "get"), function()
			pg.m02:sendNotification(GAME.SUBMIT_TASK, var_11_5)

			return
		end)
		setActive(var_11_3, true)

		if var_11_4:getTaskStatus() == 1 then
			table.insert(arg_11_0.submitTasks, var_11_4)
		end
	end

	setActive(findTF(arg_11_0._tf, "ad/getAll"), #arg_11_0.submitTasks > 1)

	return
end

function var_0_0.updateTasks(arg_16_0)
	arg_16_0:selectPlayer(arg_16_0.selectPlayerId)

	return
end

function var_0_0.getTaskByPlayer(arg_17_0, arg_17_1)
	for iter_17_0 = 1, #arg_17_0.taskDatas do
		if arg_17_0.taskDatas[iter_17_0].player == arg_17_1 then
			return arg_17_0.taskDatas[iter_17_0].task
		end
	end

	return
end

function var_0_0.willExit(arg_18_0)
	return
end

return var_0_0
