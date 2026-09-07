local IslandPoppingQueue = class("IslandPoppingQueue")

IslandPoppingQueue.PERFORMANCE = 1
IslandPoppingQueue.DISPLAY_AWARD = 2
IslandPoppingQueue.MSGBOX = 3
IslandPoppingQueue.STORY = 4
IslandPoppingQueue.TASK_ACCEPT_PAGE = 5

function IslandPoppingQueue:CreateTask(arg_1_1)
	local var_1_0 = {
		type = self,
		args = arg_1_1 or {}
	}

	var_1_0.callback = var_1_0.args.callback

	return var_1_0
end

function IslandPoppingQueue:Ctor(arg_2_1)
	self.islandScene = arg_2_1
	self.schedule = {}
	self.ignoringStoryList = {}
	self.playerList = {}

	return
end

function IslandPoppingQueue:GetSceneView()
	return self.islandScene
end

function IslandPoppingQueue:Enqueue(arg_4_1, arg_4_2)
	local var_4_0 = IslandPoppingQueue.CreateTask(arg_4_1, arg_4_2)

	if not self:IsValid(var_4_0) then
		return
	end

	table.insert(self.schedule, var_4_0)

	if #self.schedule == 1 then
		self:ProcessNextOne()
	end

	return
end

function IslandPoppingQueue:IsValid(arg_5_1)
	if arg_5_1.type == IslandPoppingQueue.STORY and table.contains(self.ignoringStoryList, arg_5_1.args.name) then
		self:ExecuteStory(arg_5_1.callback, arg_5_1.args.name, arg_5_1.args.refreshNpc)

		return false
	end

	return true
end

function IslandPoppingQueue:ProcessNextOne()
	local var_6_0 = self.schedule[1]

	local function var_6_1()
		if var_6_0.callback then
			var_6_0.callback()
		end

		if not self.schedule then
			return
		end

		self.ignoringStoryList = {}

		table.remove(self.schedule, 1)

		if #self.schedule > 0 then
			onNextTick(function()
				self:ProcessNextOne()

				return
			end)
		end

		return
	end

	if self.schedule[1].type == IslandPoppingQueue.PERFORMANCE then
		self:ExecutePerformer(var_6_1, self.schedule[1].args.name)
	elseif self.schedule[1].type == IslandPoppingQueue.DISPLAY_AWARD then
		self:ExecuteAwardDisplay(var_6_1, self.schedule[1].args.dropData, self.schedule[1].args.displayType)
	elseif self.schedule[1].type == IslandPoppingQueue.MSGBOX then
		self:ExecuteMsgbox(var_6_1, self.schedule[1].args)
	elseif self.schedule[1].type == IslandPoppingQueue.STORY then
		self:ExecuteStory(var_6_1, self.schedule[1].args.name, self.schedule[1].args.refreshNpc)
	elseif self.schedule[1].type == IslandPoppingQueue.TASK_ACCEPT_PAGE then
		self:ExecuteTaskAcceptWin(var_6_1, self.schedule[1].args.taskId)
	else
		error("Unknown popping type: " .. tostring(self.schedule[1].type))
	end

	return
end

function IslandPoppingQueue:ExecuteStory(arg_9_1, arg_9_2, arg_9_3)
	self:GetSceneView():TryDisVisible()
	self:GetSceneView():GetSubView(IslandStoryMgr):ExecuteAction("Play", arg_9_2, arg_9_3, function()
		self:GetSceneView():TryVisible()
		arg_9_1()

		return
	end)

	return
end

function IslandPoppingQueue:ExecuteMsgbox(arg_11_1, arg_11_2)
	self:GetSceneView():GetSubView(IslandMsgBox):ExecuteAction("Show", arg_11_2, arg_11_1)

	return
end

function IslandPoppingQueue:ExecutePerformer(arg_12_1, arg_12_2)
	local var_12_0 = pg.NewStoryMgr.GetInstance():GetScript(arg_12_2)

	if not var_12_0 or #var_12_0 <= 0 then
		arg_12_1()

		return
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.type == IslandPerformancePerformer.TYPE_STORY then
			table.insert(self.ignoringStoryList, iter_12_1.name)
		end
	end

	local var_12_1 = IslandPerformancePerformer.New(self:GetSceneView().event)

	var_12_1:Play(arg_12_2, var_12_0, function()
		var_12_1:Dispose()
		table.removebyvalue(self.playerList, var_12_1)
		arg_12_1()

		return
	end)
	table.insert(self.playerList, var_12_1)

	return
end

function IslandPoppingQueue:ExecuteAwardDisplay(arg_14_1, arg_14_2, arg_14_3)
	seriesAsync({
		function(arg_15_0)
			if not arg_14_2.drops or #arg_14_2.drops <= 0 then
				arg_15_0()

				return
			end

			self:GetSceneView():emit(BaseUI.ON_ACHIEVE, arg_14_2.drops, arg_15_0)

			return
		end,
		function(arg_16_0)
			onNextTick(arg_16_0)

			return
		end,
		function(arg_17_0)
			if not arg_14_2.awards or #arg_14_2.awards <= 0 then
				arg_17_0()

				return
			end

			self:GetSceneView():DisplayAward({
				type = arg_14_3,
				title = i18n("island_get_item_tip"),
				awards = arg_14_2.awards,
				callback = arg_17_0
			})

			return
		end,
		function(arg_18_0)
			onNextTick(arg_18_0)

			return
		end,
		function(arg_19_0)
			if not arg_14_2.exp or arg_14_2.exp <= 0 then
				arg_19_0()

				return
			end

			self:GetSceneView():ShowExpAdd(arg_14_2.exp, arg_19_0)

			return
		end,
		function(arg_20_0)
			onNextTick(arg_20_0)

			return
		end,
		function(arg_21_0)
			self:GetSceneView():DisplaySystemUnlock(arg_14_2.abilitys, arg_21_0)

			return
		end,
		function(arg_22_0)
			onNextTick(arg_22_0)

			return
		end,
		function(arg_23_0)
			pg.m02:sendNotification(GAME.ISLAND_UPGRADE, {
				callback = arg_23_0
			})

			return
		end,
		function(arg_24_0)
			onNextTick(arg_24_0)

			return
		end,
		function(arg_25_0)
			if not arg_14_2.overflowAwards or #arg_14_2.overflowAwards == 0 then
				arg_25_0()

				return
			end

			self:GetSceneView():DisplayAward({
				titleColor = "#ab4734",
				title = i18n("island_add_temp_bag"),
				awards = arg_14_2.overflowAwards,
				callback = arg_25_0
			})

			return
		end,
		function(arg_26_0)
			if not arg_14_2.overflowAwards or #arg_14_2.overflowAwards == 0 then
				arg_26_0()

				return
			end

			self:GetSceneView():OpenPage(IslandInventoryPage)
			arg_26_0()

			return
		end
	}, arg_14_1)

	return
end

function IslandPoppingQueue:ExecuteTaskAcceptWin(arg_27_1, arg_27_2)
	self:GetSceneView():emitCore(ISLAND_EVT.DISABLE_INPUT)
	self:GetSceneView():GetSubView(Island3dTaskAcceptPage):ExecuteAction("Show", arg_27_2, function()
		self:GetSceneView():emitCore(ISLAND_EVT.ENABLE_INPUT)
		arg_27_1()

		return
	end)

	return
end

function IslandPoppingQueue:AnyPlayerIsRunning()
	return #self.playerList > 0
end

function IslandPoppingQueue:Dispose()
	self.schedule = nil

	for iter_30_0, iter_30_1 in ipairs(self.playerList or {}) do
		iter_30_1:Dispose()
	end

	self.playerList = nil

	return
end

return IslandPoppingQueue
