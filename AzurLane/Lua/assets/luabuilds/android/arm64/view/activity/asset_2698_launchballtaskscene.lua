class = var_0_10000

local var_0_0 = "LaunchBallTaskScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LaunchBallTaskUI"
end

function var_0_1.getBGM(arg_2_0)
	return "cw-story"
end

function var_0_1.init(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_3_2 = var_3_1(var_3_0, var_1_10004.MINIGAME_ZUMA_TASK)

	arg_3_0.taskDatas = var_1.getConfig(var_3_2, "config_client")
	findTF = var_2
	arg_3_0.iconTpl = var_2(arg_3_0._tf, "ad/players/Viewport/Content/iconTpl")
	setActive = var_2

	var_2(arg_3_0.iconTpl, false)

	findTF = var_2
	arg_3_0.iconContent = var_2(arg_3_0._tf, "ad/players/Viewport/Content")
	arg_3_0.icons = {}

	for iter_3_0 = 1, #arg_3_0.taskDatas do
		tf = var_1_10006
		instantiate = var_1_10008
		var_1_10006 = var_1_10006(var_1_10008(arg_3_0.iconTpl))

		local var_3_3 = iter_3_0

		var_1_10008 = arg_3_0.taskDatas[iter_3_0].player
		LaunchBallActivityMgr = var_1_10009
		var_1_10009 = var_1_10009.GetPlayerZhuanshuIndex(var_1_10008)

		local var_3_4
		local var_3_5

		if var_1_10009 then
			LaunchBallActivityMgr = var_3_5
			var_3_5 = var_3_5.CheckZhuanShuAble
			ActivityConst = var_1_10013
			var_3_4 = var_3_5(var_1_10013.MINIGAME_ZUMA, var_1_10009)
		else
			var_3_4 = true
		end

		setActive = var_3_5
		findTF = var_1_10013

		var_3_5(var_1_10013(var_1_10006, "lock"), not var_3_4)

		GetSpriteFromAtlasAsync = var_3_5

		var_3_5("ui/launchballtaskui_atlas", "playerIcon" .. arg_3_0.taskDatas[iter_3_0].player, function(arg_4_0)
			if arg_4_0 then
				setImageSprite = var_2_10001
				findTF = var_2_10003

				var_2_10001(var_2_10003(var_1_10006, "img"), arg_4_0, true)
			end

			return
		end)

		setParent = var_3_5

		var_3_5(var_1_10006, arg_3_0.iconContent)

		setActive = var_3_5

		var_3_5(var_1_10006, true)

		onButton = var_3_5

		var_3_5(arg_3_0, var_1_10006, function()
			if var_3_4 then
				local var_5_0 = arg_3_0

				var_0.selectPlayer(var_5_0, var_1_10008)
			else
				local var_5_1

				if var_1_10008 == 2 then
					i18n = var_1
					var_5_1 = var_1("launchball_lock_Shinano")
				elseif var_1_10008 == 3 then
					i18n = var_1
					var_5_1 = var_1("launchball_lock_Yura")
				elseif var_1_10008 == 4 then
					i18n = var_1
					var_5_1 = var_1("launchball_lock_Shimakaze")
				end

				pg = var_1

				local var_5_2 = var_1.TipsMgr.GetInstance()

				var_1.ShowTips(var_5_2, var_5_1)
			end

			return
		end)

		table = var_3_5

		var_3_5.insert(arg_3_0.icons, {
			tf = var_1_10006,
			player = var_1_10008
		})
	end

	findTF = var_2
	arg_3_0.taskTpl = var_2(arg_3_0._tf, "ad/tasks/Viewport/Content/taskTpl")
	findTF = var_2
	arg_3_0.taskContent = var_2(arg_3_0._tf, "ad/tasks/Viewport/Content")
	setActive = var_2

	var_2(arg_3_0.taskTpl, false)

	arg_3_0.tasks = {}
	onButton = var_2

	local var_3_6 = arg_3_0

	findTF = var_5

	var_2(var_3_6, var_5(arg_3_0._tf, "ad/getAll"), function()
		if #arg_3_0.submitTasks > 1 then
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			LaunchBallTaskMediator = var_2_10003

			var_6_1(var_6_0, var_2_10003.SUBMIT_ALL, arg_3_0.submitTasks)
		end

		return
	end)

	findTF = var_2
	arg_3_0.helpWindow = var_2(arg_3_0._tf, "helpWindow")
	setActive = var_2

	var_2(arg_3_0.helpWindow, false)

	onButton = var_2

	local var_3_7 = arg_3_0

	findTF = var_5

	var_2(var_3_7, var_5(arg_3_0.helpWindow, "ad"), function()
		setActive = var_2_10000

		var_2_10000(arg_3_0.helpWindow, false)

		return
	end)

	onButton = var_2

	local var_3_8 = arg_3_0

	findTF = var_5

	var_2(var_3_8, var_5(arg_3_0.helpWindow, "ad/btnOk"), function()
		setActive = var_2_10000

		var_2_10000(arg_3_0.helpWindow, false)

		return
	end)

	onButton = var_2

	local var_3_9 = arg_3_0

	findTF = var_5

	var_2(var_3_9, var_5(arg_3_0._tf, "ad/back"), function()
		local var_9_0 = arg_3_0

		var_0.closeView(var_9_0)

		return
	end)
	arg_3_0:selectPlayer(1)

	return
end

function var_0_1.selectPlayer(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0.icons do
		local var_10_0 = arg_10_0.icons[iter_10_0].tf

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(var_10_0, "selected"), arg_10_0.icons[iter_10_0].player == arg_10_1)
	end

	local var_10_1 = arg_10_0:getTaskByPlayer(arg_10_1)

	arg_10_0:updateTaskList(var_10_1)

	arg_10_0.selectPlayerId = arg_10_1

	return
end

function var_0_1.updateTaskList(arg_11_0, arg_11_1)
	arg_11_0.submitTasks = {}

	for iter_11_0 = 1, #arg_11_0.tasks do
		setActive = var_1_10006

		var_1_10006(arg_11_0.tasks[iter_11_0].tf, false)
	end

	local var_11_0 = {}

	for iter_11_1 = 1, #arg_11_1 do
		local var_11_1 = arg_11_1[iter_11_1][2]
		local var_11_2 = arg_11_1[iter_11_1][1]

		getProxy = var_1_10009
		TaskProxy = var_1_10011
		var_1_10011 = var_1_10009(var_1_10011)
		var_1_10009 = var_1_10009.getTaskById(var_1_10011, var_11_1)
		getProxy = var_1_10010
		TaskProxy = var_12

		local var_11_3 = var_1_10010(var_12)

		var_1_10010 = var_1_10010.getFinishTaskById(var_11_3, var_11_1)

		if var_1_10009 then
			table = var_1_10011

			var_1_10011.insert(var_11_0, {
				data = var_1_10009,
				type = var_11_2
			})
		elseif var_1_10010 then
			table = var_1_10011

			var_1_10011.insert(var_11_0, {
				data = var_1_10010,
				type = var_11_2
			})
		end
	end

	table = var_3

	var_3.sort(var_11_0, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0.data
		local var_12_1 = arg_12_1.data

		if var_12_0:getTaskStatus() == 1 and var_12_1:getTaskStatus() ~= 1 then
			return true
		elseif var_12_0:getTaskStatus() ~= 1 and var_12_1:getTaskStatus() == 1 then
			return false
		elseif var_12_0:getTaskStatus() == 2 and var_12_1:getTaskStatus() ~= 2 then
			return false
		elseif var_12_0:getTaskStatus() ~= 2 and var_12_1:getTaskStatus() == 2 then
			return true
		else
			return var_12_0.id < var_12_1.id
		end

		return
	end)

	for iter_11_2 = 1, #var_11_0 do
		local var_11_4

		if #arg_11_0.tasks < iter_11_2 then
			tf = var_8
			instantiate = var_1_10010
			var_11_4 = var_8(var_1_10010(arg_11_0.taskTpl))
			setParent = var_8

			var_8(var_11_4, arg_11_0.taskContent)

			setActive = var_8

			var_8(var_11_4, true)

			table = var_8

			var_8.insert(arg_11_0.tasks, {
				tf = var_11_4
			})
		else
			var_11_4 = arg_11_0.tasks[iter_11_2].tf
		end

		local var_11_5 = var_11_0[iter_11_2].data
		local var_11_6 = var_11_0[iter_11_2].type

		var_1_10010 = var_11_5.id

		local var_11_7
		local var_11_8
		local var_11_9
		local var_11_10
		local var_11_11 = var_11_5:getProgress()
		local var_11_12 = var_11_5:getTargetNumber()
		local var_11_13 = var_11_5:getConfig("desc")
		local var_11_14 = var_11_5
		local var_11_15 = var_11_5.getConfig(var_11_14, "award_display")[1]

		setSlider = var_15
		findTF = var_11_14

		var_15(var_11_14(var_11_4, "Slider"), 0, 1, var_11_11 / var_11_12)

		local var_11_16 = {
			type = var_11_15[1],
			id = var_11_15[2],
			count = var_11_15[3]
		}

		updateDrop = var_16
		findTF = var_18

		var_16(var_18(var_11_4, "icon"), var_11_16)

		setActive = var_16
		findTF = var_18

		var_16(var_18(var_11_4, "icon"), true)

		setText = var_16
		findTF = var_18

		var_16(var_18(var_11_4, "desc"), var_11_13)

		setText = var_16
		findTF = var_18

		var_16(var_18(var_11_4, "progress"), var_11_11 .. "/" .. var_11_12)

		local var_11_17

		LaunchBallTaskMgr = var_17

		if var_11_6 == var_17.type_series_split then
			i18n = var_17
			var_11_17 = var_17("launchball_spilt_series")
		else
			LaunchBallTaskMgr = var_17

			if var_11_6 == var_17.type_close_split then
				i18n = var_17
				var_11_17 = var_17("launchball_spilt_mix")
			else
				LaunchBallTaskMgr = var_17

				if var_11_6 == var_17.type_over_split then
					i18n = var_17
					var_11_17 = var_17("launchball_spilt_over")
				else
					LaunchBallTaskMgr = var_17

					if var_11_6 == var_17.type_many_split then
						i18n = var_17
						var_11_17 = var_17("launchball_spilt_many")
					end
				end
			end
		end

		if var_11_17 then
			setActive = var_17
			findTF = var_19

			var_17(var_19(var_11_4, "tip"), true)
		else
			setActive = var_17
			findTF = var_19

			var_17(var_19(var_11_4, "tip"), false)
		end

		onButton = var_17

		local var_11_18 = arg_11_0

		findTF = var_20

		var_17(var_11_18, var_20(var_11_4, "tip"), function()
			setText = var_2_10000
			findTF = var_2_10002

			var_2_10000(var_2_10002(arg_11_0.helpWindow, "ad/desc"), var_11_17)

			setActive = var_2_10000

			var_2_10000(arg_11_0.helpWindow, true)

			return
		end)

		setActive = var_17
		findTF = var_11_18

		var_17(var_11_18(var_11_4, "go"), var_11_5:getTaskStatus() == 0)

		setActive = var_17
		findTF = var_19

		var_17(var_19(var_11_4, "got"), var_11_5:getTaskStatus() == 2)

		setActive = var_17
		findTF = var_19

		var_17(var_19(var_11_4, "get"), var_11_5:getTaskStatus() == 1)

		onButton = var_17

		local var_11_19 = arg_11_0

		findTF = var_20

		var_17(var_11_19, var_20(var_11_4, "go"), function()
			pg = var_2_10000

			local var_14_0 = var_2_10000.m02
			local var_14_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_14_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_14_1(var_14_0, var_14_2, var_2_10004.SIXTH_ANNIVERSARY_JP_DARK)

			return
		end)

		onButton = var_17

		local var_11_20 = arg_11_0

		findTF = var_20

		var_17(var_11_20, var_20(var_11_4, "get"), function()
			pg = var_2_10000

			local var_15_0 = var_2_10000.m02
			local var_15_1 = var_0.sendNotification

			GAME = var_2_10003

			var_15_1(var_15_0, var_2_10003.SUBMIT_TASK, var_1_10010)

			return
		end)

		setActive = var_17

		var_17(var_11_4, true)

		if var_11_5:getTaskStatus() == 1 then
			table = var_17

			var_17.insert(arg_11_0.submitTasks, var_11_5)
		end
	end

	setActive = var_3
	findTF = var_5

	var_3(var_5(arg_11_0._tf, "ad/getAll"), #arg_11_0.submitTasks > 1)

	return
end

function var_0_1.updateTasks(arg_16_0)
	arg_16_0:selectPlayer(arg_16_0.selectPlayerId)

	return
end

function var_0_1.getTaskByPlayer(arg_17_0, arg_17_1)
	for iter_17_0 = 1, #arg_17_0.taskDatas do
		if arg_17_0.taskDatas[iter_17_0].player == arg_17_1 then
			return arg_17_0.taskDatas[iter_17_0].task
		end
	end

	return
end

function var_0_1.willExit(arg_18_0)
	return
end

return var_0_1
