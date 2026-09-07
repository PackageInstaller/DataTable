local LaunchBallTaskScene = class("LaunchBallTaskScene", import("..base.BaseUI"))

function LaunchBallTaskScene:getUIName()
	return "LaunchBallTaskUI"
end

function LaunchBallTaskScene:getBGM()
	return "cw-story"
end

function LaunchBallTaskScene:init()
	self.taskDatas = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA_TASK):getConfig("config_client")
	self.iconTpl = findTF(self._tf, "ad/players/Viewport/Content/iconTpl")

	setActive(self.iconTpl, false)

	self.iconContent = findTF(self._tf, "ad/players/Viewport/Content")
	self.icons = {}

	for iter_3_0 = 1, #self.taskDatas do
		local var_3_0 = tf(instantiate(self.iconTpl))
		local var_3_2 = self.taskDatas[iter_3_0].player
		local var_3_3 = LaunchBallActivityMgr.GetPlayerZhuanshuIndex(self.taskDatas[iter_3_0].player)
		local var_3_4 = var_3_3 and LaunchBallActivityMgr.CheckZhuanShuAble(ActivityConst.MINIGAME_ZUMA, var_3_3) or true

		setActive(findTF(var_3_0, "lock"), not var_3_4)
		GetSpriteFromAtlasAsync("ui/launchballtaskui_atlas", "playerIcon" .. self.taskDatas[iter_3_0].player, function(arg_4_0)
			if arg_4_0 then
				setImageSprite(findTF(var_3_0, "img"), arg_4_0, true)
			end

			return
		end)
		setParent(var_3_0, self.iconContent)
		setActive(var_3_0, true)
		onButton(self, var_3_0, function()
			if var_3_4 then
				self:selectPlayer(var_3_2)
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
		table.insert(self.icons, {
			tf = var_3_0,
			player = var_3_2
		})
	end

	self.taskTpl = findTF(self._tf, "ad/tasks/Viewport/Content/taskTpl")
	self.taskContent = findTF(self._tf, "ad/tasks/Viewport/Content")

	setActive(self.taskTpl, false)

	self.tasks = {}

	onButton(self, findTF(self._tf, "ad/getAll"), function()
		if #self.submitTasks > 1 then
			self:emit(LaunchBallTaskMediator.SUBMIT_ALL, self.submitTasks)
		end

		return
	end)

	self.helpWindow = findTF(self._tf, "helpWindow")

	setActive(self.helpWindow, false)
	onButton(self, findTF(self.helpWindow, "ad"), function()
		setActive(self.helpWindow, false)

		return
	end)
	onButton(self, findTF(self.helpWindow, "ad/btnOk"), function()
		setActive(self.helpWindow, false)

		return
	end)
	onButton(self, findTF(self._tf, "ad/back"), function()
		self:closeView()

		return
	end)
	self:selectPlayer(1)

	return
end

function LaunchBallTaskScene:selectPlayer(arg_10_1)
	for iter_10_0 = 1, #self.icons do
		setActive(findTF(self.icons[iter_10_0].tf, "selected"), self.icons[iter_10_0].player == arg_10_1)
	end

	self:updateTaskList((self:getTaskByPlayer(arg_10_1)))

	self.selectPlayerId = arg_10_1

	return
end

function LaunchBallTaskScene:updateTaskList(arg_11_1)
	self.submitTasks = {}

	for iter_11_0 = 1, #self.tasks do
		setActive(self.tasks[iter_11_0].tf, false)
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

		if iter_11_2 > #self.tasks then
			var_11_3 = tf(instantiate(self.taskTpl))

			setParent(var_11_3, self.taskContent)
			setActive(var_11_3, true)
			table.insert(self.tasks, {
				tf = var_11_3
			})
		else
			var_11_3 = self.tasks[iter_11_2].tf
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

		onButton(self, findTF(var_11_3, "tip"), function()
			setText(findTF(self.helpWindow, "ad/desc"), var_11_11)
			setActive(self.helpWindow, true)

			return
		end)
		setActive(findTF(var_11_3, "go"), var_11_4:getTaskStatus() == 0)
		setActive(findTF(var_11_3, "got"), var_11_4:getTaskStatus() == 2)
		setActive(findTF(var_11_3, "get"), var_11_4:getTaskStatus() == 1)
		onButton(self, findTF(var_11_3, "go"), function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_DARK)

			return
		end)
		onButton(self, findTF(var_11_3, "get"), function()
			pg.m02:sendNotification(GAME.SUBMIT_TASK, var_11_5)

			return
		end)
		setActive(var_11_3, true)

		if var_11_4:getTaskStatus() == 1 then
			table.insert(self.submitTasks, var_11_4)
		end
	end

	setActive(findTF(self._tf, "ad/getAll"), #self.submitTasks > 1)

	return
end

function LaunchBallTaskScene:updateTasks()
	self:selectPlayer(self.selectPlayerId)

	return
end

function LaunchBallTaskScene:getTaskByPlayer(arg_17_1)
	for iter_17_0 = 1, #self.taskDatas do
		if self.taskDatas[iter_17_0].player == arg_17_1 then
			return self.taskDatas[iter_17_0].task
		end
	end

	return
end

function LaunchBallTaskScene:willExit()
	return
end

return LaunchBallTaskScene
