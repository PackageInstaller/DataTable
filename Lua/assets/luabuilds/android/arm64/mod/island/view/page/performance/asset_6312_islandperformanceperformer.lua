local IslandPerformancePerformer = class("IslandPerformancePerformer", import("view.base.BaseEventLogic"))

IslandPerformancePerformer.START_PERFORMANCE = "IslandPerformancePerformer:START_PERFORMANCE"
IslandPerformancePerformer.END_PERFORMANCE = "IslandPerformancePerformer:END_PERFORMANCE"
IslandPerformancePerformer.TYPE_FINDPATH = 1
IslandPerformancePerformer.TYPE_TRANSFER = 2
IslandPerformancePerformer.TYPE_STORY = 3
IslandPerformancePerformer.TYPE_HIDE_UNIT = 4
IslandPerformancePerformer.TYPE_UPDATE_STORY = 5
IslandPerformancePerformer.TYPE_LOCK_NPC_REFRESH = 6

function IslandPerformancePerformer:GetStoryNameList()
	local var_1_0 = pg.NewStoryMgr.GetInstance():GetScript(self)

	if not var_1_0 then
		return {}
	end

	local function var_1_1(arg_2_0, arg_2_1)
		local var_2_0 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_2_1)

		if var_2_0 then
			table.insert(arg_2_0, var_2_0)
		end

		return
	end

	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.type == IslandPerformancePerformer.TYPE_STORY then
			if iter_1_1.name then
				var_1_1(var_1_2, iter_1_1.name)
			end
		elseif iter_1_1.type == IslandPerformancePerformer.TYPE_UPDATE_STORY then
			if iter_1_1.index then
				var_1_1(var_1_2, iter_1_1.index)
			end
		elseif iter_1_1.type == IslandPerformancePerformer.TYPE_FINDPATH and iter_1_1.index then
			var_1_1(var_1_2, iter_1_1.index)
		end
	end

	var_1_1(var_1_2, self)

	return var_1_2
end

function IslandPerformancePerformer:Ctor(arg_3_1)
	IslandPerformancePerformer.super.Ctor(self, arg_3_1)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)
	self:bind(IslandBaseScene.ON_SCENE_LOADED, function()
		self:OnSceneLoaded()

		return
	end)

	return
end

function IslandPerformancePerformer:GetPlayer(arg_5_1)
	if arg_5_1 == IslandPerformancePerformer.TYPE_FINDPATH then
		return IslandFindingPathPlayer.New(self)
	elseif arg_5_1 == IslandPerformancePerformer.TYPE_TRANSFER then
		return IslandTransferPlayer.New(self)
	elseif arg_5_1 == IslandPerformancePerformer.TYPE_STORY then
		return IslandPerformanceStoryPlayer.New(self)
	elseif arg_5_1 == IslandPerformancePerformer.TYPE_HIDE_UNIT then
		return IslandPerformanceActiveUnitPlayer.New(self)
	elseif arg_5_1 == IslandPerformancePerformer.TYPE_UPDATE_STORY then
		return IslandUpdateStoryPlayer.New(self)
	elseif arg_5_1 == IslandPerformancePerformer.TYPE_LOCK_NPC_REFRESH then
		return IslandLockNpcRefreshPlayer.New(self)
	end

	return
end

function IslandPerformancePerformer:Play(arg_6_1, arg_6_2, arg_6_3)
	self:OnStart(arg_6_1)

	local var_6_0 = {}
	local var_6_1 = _.detect(arg_6_2, function(arg_7_0)
		return arg_7_0.type == IslandPerformancePerformer.TYPE_LOCK_NPC_REFRESH
	end)
	local var_6_2 = false

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		table.insert(var_6_0, function(arg_8_0)
			local var_8_0 = self:GetPlayer(iter_6_1.type)

			if isa(var_8_0, IslandFindingPathPlayer) and var_6_1 then
				var_8_0:SetEndCallback(function()
					self:ClearLockNpc(var_6_1.unitIdList, false)

					return
				end)

				var_6_2 = true
			end

			var_8_0:Play(iter_6_1, arg_8_0)

			self.player = var_8_0

			return
		end)
	end

	seriesAsync(var_6_0, function()
		local var_10_0 = not var_6_2 and var_6_1

		if not var_6_2 and var_6_1 then
			self:ClearLockNpc(var_6_1.unitIdList, true)
		end

		self:OnEnd(var_10_0)

		self.player = nil

		if arg_6_3 then
			arg_6_3()
		end

		return
	end)

	return
end

function IslandPerformancePerformer:ClearLockNpc(arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.RELEASE_NPC_REFRESH, iter_11_1, IslandConst.UNIT_LIST_OBJ)
	end

	return
end

function IslandPerformancePerformer:OnStart(arg_12_1)
	self.runing = true

	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_12_1
	})
	self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.PERFORMANCE_START)

	return
end

function IslandPerformancePerformer:OnEnd(arg_13_1)
	self.runing = false

	self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.PERFORMANCE_END, arg_13_1)

	return
end

function IslandPerformancePerformer:OnSceneLoaded()
	if not self.player then
		return
	end

	if isa(self.player, IslandTransferPlayer) then
		self.player:EndAction()
	end

	return
end

function IslandPerformancePerformer:Update()
	if self.player then
		self.player:Update()
	end

	return
end

function IslandPerformancePerformer:IsRunning()
	return self.runing
end

function IslandPerformancePerformer:Dispose()
	self:disposeEvent()
	self:cleanManagedTween()

	self.player = nil

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self.handle = nil

	return
end

return IslandPerformancePerformer
