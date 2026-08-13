class = var_0_10000

local var_0_0 = "IslandPerformancePerformer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseEventLogic"))

var_0_1.START_PERFORMANCE = "IslandPerformancePerformer:START_PERFORMANCE"
var_0_1.END_PERFORMANCE = "IslandPerformancePerformer:END_PERFORMANCE"
var_0_1.TYPE_FINDPATH = 1
var_0_1.TYPE_TRANSFER = 2
var_0_1.TYPE_STORY = 3
var_0_1.TYPE_HIDE_UNIT = 4
var_0_1.TYPE_UPDATE_STORY = 5
var_0_1.TYPE_LOCK_NPC_REFRESH = 6

function var_0_1.GetStoryNameList(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.NewStoryMgr.GetInstance()

	if not var_1.GetScript(var_1_0, arg_1_0) then
		return {}
	end

	local function var_1_1(arg_2_0, arg_2_1)
		pg = var_2_10002

		local var_2_0 = var_2_10002.NewStoryMgr.GetInstance()

		if var_2.StoryName2StoryId(var_2_0, arg_2_1) then
			table = var_2_0

			var_2_0.insert(arg_2_0, var_2)
		end

		return
	end

	local var_1_2 = {}

	ipairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(var_1) do
		if iter_1_1.type == var_0_1.TYPE_STORY then
			if iter_1_1.name then
				var_1_1(var_1_2, iter_1_1.name)
			end
		elseif iter_1_1.type == var_0_1.TYPE_UPDATE_STORY then
			if iter_1_1.index then
				var_1_1(var_1_2, iter_1_1.index)
			end
		elseif iter_1_1.type == var_0_1.TYPE_FINDPATH and iter_1_1.index then
			var_1_1(var_1_2, iter_1_1.index)
		end
	end

	var_1_1(var_1_2, arg_1_0)

	return var_1_2
end

function var_0_1.Ctor(arg_3_0, arg_3_1)
	var_0_1.super.Ctor(arg_3_0, arg_3_1)

	if not arg_3_0.handle then
		UpdateBeat = var_2
		arg_3_0.handle = var_2:CreateListener(arg_3_0.Update, arg_3_0)
	end

	UpdateBeat = var_2

	var_2:AddListener(arg_3_0.handle)

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	IslandBaseScene = var_4

	var_3_1(var_3_0, var_4.ON_SCENE_LOADED, function()
		local var_4_0 = arg_3_0

		var_0.OnSceneLoaded(var_4_0)

		return
	end)

	return
end

function var_0_1.GetPlayer(arg_5_0, arg_5_1)
	if arg_5_1 == var_0_1.TYPE_FINDPATH then
		IslandFindingPathPlayer = var_2

		return var_2.New(arg_5_0)
	elseif arg_5_1 == var_0_1.TYPE_TRANSFER then
		IslandTransferPlayer = var_2

		return var_2.New(arg_5_0)
	elseif arg_5_1 == var_0_1.TYPE_STORY then
		IslandPerformanceStoryPlayer = var_2

		return var_2.New(arg_5_0)
	elseif arg_5_1 == var_0_1.TYPE_HIDE_UNIT then
		IslandPerformanceActiveUnitPlayer = var_2

		return var_2.New(arg_5_0)
	elseif arg_5_1 == var_0_1.TYPE_UPDATE_STORY then
		IslandUpdateStoryPlayer = var_2

		return var_2.New(arg_5_0)
	elseif arg_5_1 == var_0_1.TYPE_LOCK_NPC_REFRESH then
		IslandLockNpcRefreshPlayer = var_2

		return var_2.New(arg_5_0)
	end

	return
end

function var_0_1.Play(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0

	arg_6_0.OnStart(var_6_0, arg_6_1)

	local var_6_1 = {}

	_ = var_6_0

	local var_6_2 = var_6_0.detect(arg_6_2, function(arg_7_0)
		return arg_7_0.type == var_0_1.TYPE_LOCK_NPC_REFRESH
	end)
	local var_6_3 = false

	ipairs = var_7

	for iter_6_0, iter_6_1 in var_7(arg_6_2) do
		table = var_1_10012

		var_1_10012.insert(var_6_1, function(arg_8_0)
			local var_8_0 = arg_6_0
			local var_8_1 = var_1.GetPlayer(var_8_0, iter_6_1.type)

			isa = var_8_0

			local var_8_2 = var_8_1

			IslandFindingPathPlayer = var_2_10004

			if var_8_0(var_8_2, var_2_10004) and var_6_2 then
				var_8_1:SetEndCallback(function()
					local var_9_0 = arg_6_0

					var_0.ClearLockNpc(var_9_0, var_6_2.unitIdList, false)

					return
				end)

				var_6_3 = true
			end

			var_8_1:Play(iter_6_1, arg_8_0)

			arg_6_0.player = var_8_1

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_6_1, function()
		if not var_6_3 and var_6_2 then
			local var_10_0 = arg_6_0

			var_1.ClearLockNpc(var_10_0, var_6_2.unitIdList, true)
		end

		local var_10_1 = arg_6_0

		var_1.OnEnd(var_10_1, var_0)

		arg_6_0.player = nil

		if arg_6_3 then
			arg_6_3()
		end

		return
	end)

	return
end

function var_0_1.ClearLockNpc(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_1) do
		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.emit

		IslandBaseScene = var_1_10010
		var_1_10010 = var_1_10010.LINK_CORE_EVENT
		IslandProxy = var_1_10011
		var_1_10011 = var_1_10011.RELEASE_NPC_REFRESH

		local var_11_2 = iter_11_1

		IslandConst = var_1_10013

		var_11_1(var_11_0, var_1_10010, var_1_10011, var_11_2, var_1_10013.UNIT_LIST_OBJ)
	end

	return
end

function var_0_1.OnStart(arg_12_0, arg_12_1)
	arg_12_0.runing = true
	pg = var_2

	local var_12_0 = var_2.m02
	local var_12_1 = var_2.sendNotification

	GAME = var_1_10004

	var_12_1(var_12_0, var_1_10004.STORY_UPDATE, {
		storyId = arg_12_1
	})

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.emit

	IslandBaseScene = var_4

	local var_12_4 = var_4.LINK_CORE_EVENT

	IslandProxy = var_5

	var_12_3(var_12_2, var_12_4, var_5.PERFORMANCE_START)

	return
end

function var_0_1.OnEnd(arg_13_0, arg_13_1)
	arg_13_0.runing = false

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	IslandBaseScene = var_1_10004

	local var_13_2 = var_1_10004.LINK_CORE_EVENT

	IslandProxy = var_1_10005

	var_13_1(var_13_0, var_13_2, var_1_10005.PERFORMANCE_END, arg_13_1)

	return
end

function var_0_1.OnSceneLoaded(arg_14_0)
	if not arg_14_0.player then
		return
	end

	isa = var_1

	local var_14_0 = arg_14_0.player

	IslandTransferPlayer = var_1_10003

	if var_1(var_14_0, var_1_10003) then
		local var_14_1 = arg_14_0.player

		var_1.EndAction(var_14_1)
	end

	return
end

function var_0_1.Update(arg_15_0)
	if arg_15_0.player then
		local var_15_0 = arg_15_0.player

		var_1.Update(var_15_0)
	end

	return
end

function var_0_1.IsRunning(arg_16_0)
	return arg_16_0.runing
end

function var_0_1.Dispose(arg_17_0)
	arg_17_0:disposeEvent()
	arg_17_0:cleanManagedTween()

	arg_17_0.player = nil

	if arg_17_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_17_0.handle)
	end

	arg_17_0.handle = nil

	return
end

return var_0_1
