local var_0_0 = class("IslandPerformancePerformer", import("view.base.BaseEventLogic"))

var_0_0.START_PERFORMANCE = "IslandPerformancePerformer:START_PERFORMANCE"
var_0_0.END_PERFORMANCE = "IslandPerformancePerformer:END_PERFORMANCE"
var_0_0.TYPE_FINDPATH = 1
var_0_0.TYPE_TRANSFER = 2
var_0_0.TYPE_STORY = 3
var_0_0.TYPE_HIDE_UNIT = 4
var_0_0.TYPE_UPDATE_STORY = 5
var_0_0.TYPE_LOCK_NPC_REFRESH = 6

function var_0_0.GetStoryNameList(arg_1_0)
	local var_1_0 = pg.NewStoryMgr.GetInstance():GetScript(arg_1_0)

	if not var_1_0 then
		return {}
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.type == var_0_0.TYPE_STORY then
			if iter_1_1.name then
				var_1_1({}, iter_1_1.name)
			end
		elseif iter_1_1.type == var_0_0.TYPE_UPDATE_STORY then
			if iter_1_1.index then
				var_1_1({}, iter_1_1.index)
			end
		elseif iter_1_1.type == var_0_0.TYPE_FINDPATH and iter_1_1.index then
			var_1_1({}, iter_1_1.index)
		end
	end

	var_1_1({}, arg_1_0)

	return {}
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	var_0_0.super.Ctor(arg_3_0, arg_3_1)

	arg_3_0.handle = arg_3_0.handle or UpdateBeat:CreateListener(arg_3_0.Update, arg_3_0)

	UpdateBeat:AddListener(arg_3_0.handle)
	arg_3_0:bind(IslandBaseScene.ON_SCENE_LOADED, function()
		arg_3_0:OnSceneLoaded()

		return
	end)

	return
end

function var_0_0.GetPlayer(arg_5_0, arg_5_1)
	if arg_5_1 == var_0_0.TYPE_FINDPATH then
		return IslandFindingPathPlayer.New(arg_5_0)
	elseif arg_5_1 == var_0_0.TYPE_TRANSFER then
		return IslandTransferPlayer.New(arg_5_0)
	elseif arg_5_1 == var_0_0.TYPE_STORY then
		return IslandPerformanceStoryPlayer.New(arg_5_0)
	elseif arg_5_1 == var_0_0.TYPE_HIDE_UNIT then
		return IslandPerformanceActiveUnitPlayer.New(arg_5_0)
	elseif arg_5_1 == var_0_0.TYPE_UPDATE_STORY then
		return IslandUpdateStoryPlayer.New(arg_5_0)
	elseif arg_5_1 == var_0_0.TYPE_LOCK_NPC_REFRESH then
		return IslandLockNpcRefreshPlayer.New(arg_5_0)
	end

	return
end

function var_0_0.Play(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:OnStart(arg_6_1)

	local var_6_0 = _.detect(arg_6_2, function(arg_7_0)
		return arg_7_0.type == var_0_0.TYPE_LOCK_NPC_REFRESH
	end)
	local var_6_1 = false

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		table.insert({}, function(arg_8_0)
			local var_8_0 = arg_6_0:GetPlayer(iter_6_1.type)

			if isa(var_8_0, IslandFindingPathPlayer) and var_6_0 then
				var_8_0:SetEndCallback(function()
					arg_6_0:ClearLockNpc(var_6_0.unitIdList, false)

					return
				end)

				var_6_1 = true
			end

			var_8_0:Play(iter_6_1, arg_8_0)

			arg_6_0.player = var_8_0

			return
		end)
	end

	seriesAsync({}, function()
		local var_10_0 = not var_6_1 and var_6_0

		if not var_6_1 and var_6_0 then
			arg_6_0:ClearLockNpc(var_6_0.unitIdList, true)
		end

		arg_6_0:OnEnd(var_10_0)

		arg_6_0.player = nil

		if arg_6_3 then
			arg_6_3()
		end

		return
	end)

	return
end

function var_0_0.ClearLockNpc(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		arg_11_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.RELEASE_NPC_REFRESH, iter_11_1, IslandConst.UNIT_LIST_OBJ)
	end

	return
end

function var_0_0.OnStart(arg_12_0, arg_12_1)
	arg_12_0.runing = true

	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_12_1
	})
	arg_12_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.PERFORMANCE_START)

	return
end

function var_0_0.OnEnd(arg_13_0, arg_13_1)
	arg_13_0.runing = false

	arg_13_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.PERFORMANCE_END, arg_13_1)

	return
end

function var_0_0.OnSceneLoaded(arg_14_0)
	if not arg_14_0.player then
		return
	end

	if isa(arg_14_0.player, IslandTransferPlayer) then
		arg_14_0.player:EndAction()
	end

	return
end

function var_0_0.Update(arg_15_0)
	if arg_15_0.player then
		arg_15_0.player:Update()
	end

	return
end

function var_0_0.IsRunning(arg_16_0)
	return arg_16_0.runing
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:disposeEvent()
	arg_17_0:cleanManagedTween()

	arg_17_0.player = nil

	if arg_17_0.handle then
		UpdateBeat:RemoveListener(arg_17_0.handle)
	end

	arg_17_0.handle = nil

	return
end

return var_0_0
