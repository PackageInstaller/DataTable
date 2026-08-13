class = var_0_10000

local var_0_0 = "IslandCore"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandDispatcher"))

var_0_1.STATE_LOAD = 1
var_0_1.STATE_INIT = 2
var_0_1.STATE_INIT_FINISH = 3
var_0_1.STATE_DISPOSE = 4

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.poolMgr = arg_1_1

	local var_1_0, var_1_1 = arg_1_0:GetViewAndController(arg_1_2, arg_1_3)

	arg_1_0.view = var_1_0
	arg_1_0.controller = var_1_1
	arg_1_0.sceneLoader = arg_1_0:GetSceneLoader()

	arg_1_0:UpdateState(var_0_1.STATE_LOAD)

	IslandDataConvertor = var_6

	local var_1_2, var_1_3, var_1_4 = var_6.Island2SceneName(arg_1_2)
	local var_1_5 = arg_1_0.view

	var_9.SetBgm(var_1_5, var_1_4)

	local var_1_6 = arg_1_0.sceneLoader

	var_9.Load(var_1_6, var_1_2, var_1_3, {
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.SetUp(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick = var_2_10001

			var_2_10001(arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_1_0

			var_1.Init(var_4_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_1_0

			var_1.UpdateState(var_5_0, var_0_1.STATE_INIT_FINISH)
			arg_5_0()

			return
		end
	})

	pg = var_9

	local var_1_7 = var_9.TimeMgr.GetInstance()

	arg_1_0.enterTime = var_9.GetServerTime(var_1_7)

	return
end

function var_0_1.GetSceneLoader(arg_6_0)
	IslandSceneLoader = var_1_10001

	return var_1_10001.New()
end

function var_0_1.GetPoolMgr(arg_7_0)
	return arg_7_0.poolMgr
end

function var_0_1.UpdateState(arg_8_0, arg_8_1)
	arg_8_0.state = arg_8_1

	local var_8_0 = arg_8_0.view

	var_2.OnCoreStateChanged(var_8_0, arg_8_1)

	local var_8_1 = arg_8_0.controller

	var_2.OnCoreStateChanged(var_8_1, arg_8_1)

	pg = var_2

	local var_8_2 = var_2.m02
	local var_8_3 = var_2.sendNotification

	GAME = var_4

	var_8_3(var_8_2, var_4.ISLAND_CORE_STATE_CHANGED, arg_8_1)

	return
end

function var_0_1.SetUp(arg_9_0, arg_9_1)
	arg_9_0:UpdateState(var_0_1.STATE_INIT)

	local var_9_0 = arg_9_0.view

	var_2.SetUp(var_9_0)

	local var_9_1 = arg_9_0.controller

	var_2.SetUp(var_9_1)

	if not arg_9_0.handle then
		UpdateBeat = var_2
		arg_9_0.handle = var_2:CreateListener(arg_9_0.Update, arg_9_0)
	end

	UpdateBeat = var_2

	var_2:AddListener(arg_9_0.handle)

	if not arg_9_0.lateUpdateluHandle then
		LateUpdateBeat = var_2
		arg_9_0.lateUpdateluHandle = var_2:CreateListener(arg_9_0.LateUpdate, arg_9_0)
		LateUpdateBeat = var_2

		var_2:AddListener(arg_9_0.lateUpdateluHandle)
	end

	arg_9_0.callback = arg_9_1

	arg_9_0:OnInit()

	return
end

function var_0_1.Init(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.view

	var_2.Enter(var_10_0)

	arg_10_0.initCallback = arg_10_1

	return
end

function var_0_1.GetMapId(arg_11_0)
	local var_11_0 = arg_11_0:GetController()

	return var_1.GetMapID(var_11_0)
end

function var_0_1.IsInit(arg_12_0)
	return arg_12_0.state == var_0_1.STATE_INIT or arg_12_0.state == var_0_1.STATE_INIT_FINISH
end

function var_0_1.Update(arg_13_0)
	if not arg_13_0:IsInit() then
		return
	end

	local var_13_0 = arg_13_0.controller

	var_1.Update(var_13_0)

	local var_13_1 = arg_13_0.view

	var_1.Update(var_13_1)

	if arg_13_0.callback then
		local var_13_2 = arg_13_0.view

		if var_1.IsLoaded(var_13_2) then
			arg_13_0.callback()

			arg_13_0.callback = nil
		end
	end

	if arg_13_0.initCallback then
		local var_13_3 = arg_13_0.view

		if var_1.IsInit(var_13_3) then
			arg_13_0.initCallback()

			arg_13_0.initCallback = nil
		end
	end

	return
end

function var_0_1.LateUpdate(arg_14_0)
	if not arg_14_0:IsInit() then
		return
	end

	local var_14_0 = arg_14_0.controller

	var_1.LateUpdate(var_14_0)

	local var_14_1 = arg_14_0.view

	var_1.LateUpdate(var_14_1)

	return
end

function var_0_1.GetView(arg_15_0)
	return arg_15_0.view
end

function var_0_1.GetController(arg_16_0)
	return arg_16_0.controller
end

function var_0_1.Link(arg_17_0, arg_17_1, ...)
	local var_17_0 = arg_17_0:GetController()

	var_2.NotifiyCore(var_17_0, arg_17_1, ...)

	return
end

function var_0_1.Dispose(arg_18_0, arg_18_1)
	pg = var_1_10002

	local var_18_0 = var_1_10002.TimeMgr.GetInstance()
	local var_18_1 = var_2.GetServerTime(var_18_0) - arg_18_0.enterTime

	pg = var_3

	local var_18_2 = var_3.GameTrackerMgr.GetInstance()
	local var_18_3 = var_3.Record

	GameTrackerBuilder = var_1_10005

	var_18_3(var_18_2, var_1_10005.BuildMapExit(arg_18_0.controller.mapId, var_18_1))

	local var_18_4 = arg_18_0

	arg_18_0.UpdateState(var_18_4, var_0_1.STATE_DISPOSE)

	if arg_18_0.handle then
		UpdateBeat = var_3
		var_18_4 = var_3

		var_3.RemoveListener(var_18_4, arg_18_0.handle)
	end

	if arg_18_0.lateUpdateluHandle then
		LateUpdateBeat = var_3
		var_18_4 = var_3

		var_3.RemoveListener(var_18_4, arg_18_0.lateUpdateluHandle)
	end

	IslandCameraMgr = var_3

	if var_3.instance then
		IslandCameraMgr = var_3

		if var_3.instance.gameObject then
			setActive = var_3
			IslandCameraMgr = var_18_4

			var_3(var_18_4.instance.gameObject, false)
		end
	end

	if arg_18_0.view then
		local var_18_5 = arg_18_0.view

		var_3.Dispose(var_18_5)

		arg_18_0.view = nil
	end

	if arg_18_0.controller then
		local var_18_6 = arg_18_0.controller

		var_3.Dispose(var_18_6)

		arg_18_0.controller = nil
	end

	if arg_18_0.sceneLoader then
		local var_18_7 = arg_18_0.sceneLoader

		var_3.Dispose(var_18_7, arg_18_1)

		arg_18_0.sceneLoader = nil
	end

	return
end

function var_0_1.OnInit(arg_19_0)
	return
end

function var_0_1.GetViewAndController(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1
	local var_20_2 = arg_20_1
	local var_20_3 = arg_20_1.GetMapId(var_20_2)

	pg = var_20_2

	local var_20_4 = var_20_2.island_map[var_20_3]

	IslandConst = var_1_10007

	local var_20_6

	if var_20_3 == var_1_10007.AGORA_MAP_ID then
		AgoraController = var_20_6

		local var_20_5 = var_20_6.New(arg_20_0, arg_20_1)

		var_20_6 = var_20_1.GetAgora(var_20_5)
		AgoraView = var_20_5
		var_20_0 = var_20_5.New(arg_20_0, var_20_6, arg_20_2)
	else
		IslandConst = var_20_6

		if var_20_3 == var_20_6.CheaterTavernMapId then
			CheaterTavernController = var_7
			var_20_1 = var_7.New(arg_20_0, arg_20_1)
			IslandCheaterTavernGameView = var_7
			var_20_0 = var_7.New(arg_20_0, arg_20_2)
		elseif var_20_4.minigame_id > 0 then
			IslandSeekGameView = var_7
			var_20_0 = var_7.New(arg_20_0, arg_20_2)
			IslandController = var_7
			var_20_1 = var_7.New(arg_20_0, arg_20_1)
		else
			IslandController = var_7
			var_20_1 = var_7.New(arg_20_0, arg_20_1)
			IslandView = var_7
			var_20_0 = var_7.New(arg_20_0, arg_20_2)
		end
	end

	return var_20_0, var_20_1
end

return var_0_1
