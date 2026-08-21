local var_0_0 = class("IslandCore", import("..IslandDispatcher"))

var_0_0.STATE_LOAD = 1
var_0_0.STATE_INIT = 2
var_0_0.STATE_INIT_FINISH = 3
var_0_0.STATE_DISPOSE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.poolMgr = arg_1_1

	local var_1_0, var_1_1 = arg_1_0:GetViewAndController(arg_1_2, arg_1_3)

	arg_1_0.view = var_1_0
	arg_1_0.controller = var_1_1
	arg_1_0.sceneLoader = arg_1_0:GetSceneLoader()

	arg_1_0:UpdateState(var_0_0.STATE_LOAD)

	local var_1_2, var_1_3, var_1_4 = IslandDataConvertor.Island2SceneName(arg_1_2)

	arg_1_0.view:SetBgm(var_1_4)
	arg_1_0.sceneLoader:Load(var_1_2, var_1_3, {
		function(arg_2_0)
			arg_1_0:SetUp(arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_1_0:Init(arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_1_0:UpdateState(var_0_0.STATE_INIT_FINISH)
			arg_5_0()

			return
		end
	})

	arg_1_0.enterTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.GetSceneLoader(arg_6_0)
	return IslandSceneLoader.New()
end

function var_0_0.GetPoolMgr(arg_7_0)
	return arg_7_0.poolMgr
end

function var_0_0.UpdateState(arg_8_0, arg_8_1)
	arg_8_0.state = arg_8_1

	arg_8_0.view:OnCoreStateChanged(arg_8_1)
	arg_8_0.controller:OnCoreStateChanged(arg_8_1)
	pg.m02:sendNotification(GAME.ISLAND_CORE_STATE_CHANGED, arg_8_1)

	return
end

function var_0_0.SetUp(arg_9_0, arg_9_1)
	arg_9_0:UpdateState(var_0_0.STATE_INIT)
	arg_9_0.view:SetUp()
	arg_9_0.controller:SetUp()

	arg_9_0.handle = arg_9_0.handle or UpdateBeat:CreateListener(arg_9_0.Update, arg_9_0)

	UpdateBeat:AddListener(arg_9_0.handle)

	if not arg_9_0.lateUpdateluHandle then
		arg_9_0.lateUpdateluHandle = LateUpdateBeat:CreateListener(arg_9_0.LateUpdate, arg_9_0)

		LateUpdateBeat:AddListener(arg_9_0.lateUpdateluHandle)
	end

	arg_9_0.callback = arg_9_1

	arg_9_0:OnInit()

	return
end

function var_0_0.Init(arg_10_0, arg_10_1)
	arg_10_0.view:Enter()

	arg_10_0.initCallback = arg_10_1

	return
end

function var_0_0.GetMapId(arg_11_0)
	return arg_11_0:GetController():GetMapID()
end

function var_0_0.IsInit(arg_12_0)
	return arg_12_0.state == var_0_0.STATE_INIT or arg_12_0.state == var_0_0.STATE_INIT_FINISH
end

function var_0_0.Update(arg_13_0)
	if not arg_13_0:IsInit() then
		return
	end

	arg_13_0.controller:Update()
	arg_13_0.view:Update()

	if arg_13_0.callback and arg_13_0.view:IsLoaded() then
		arg_13_0.callback()

		arg_13_0.callback = nil
	end

	if arg_13_0.initCallback and arg_13_0.view:IsInit() then
		arg_13_0.initCallback()

		arg_13_0.initCallback = nil
	end

	return
end

function var_0_0.LateUpdate(arg_14_0)
	if not arg_14_0:IsInit() then
		return
	end

	arg_14_0.controller:LateUpdate()
	arg_14_0.view:LateUpdate()

	return
end

function var_0_0.GetView(arg_15_0)
	return arg_15_0.view
end

function var_0_0.GetController(arg_16_0)
	return arg_16_0.controller
end

function var_0_0.Link(arg_17_0, arg_17_1, ...)
	arg_17_0:GetController():NotifiyCore(arg_17_1, ...)

	return
end

function var_0_0.Dispose(arg_18_0, arg_18_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildMapExit(arg_18_0.controller.mapId, pg.TimeMgr.GetInstance():GetServerTime() - arg_18_0.enterTime))
	arg_18_0:UpdateState(var_0_0.STATE_DISPOSE)

	if arg_18_0.handle then
		UpdateBeat:RemoveListener(arg_18_0.handle)
	end

	if arg_18_0.lateUpdateluHandle then
		LateUpdateBeat:RemoveListener(arg_18_0.lateUpdateluHandle)
	end

	if IslandCameraMgr.instance and IslandCameraMgr.instance.gameObject then
		setActive(IslandCameraMgr.instance.gameObject, false)
	end

	if arg_18_0.view then
		arg_18_0.view:Dispose()

		arg_18_0.view = nil
	end

	if arg_18_0.controller then
		arg_18_0.controller:Dispose()

		arg_18_0.controller = nil
	end

	if arg_18_0.sceneLoader then
		arg_18_0.sceneLoader:Dispose(arg_18_1)

		arg_18_0.sceneLoader = nil
	end

	return
end

function var_0_0.OnInit(arg_19_0)
	return
end

function var_0_0.GetViewAndController(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1
	local var_20_2 = arg_20_1:GetMapId()

	if var_20_2 == IslandConst.AGORA_MAP_ID then
		var_20_1 = AgoraController.New(arg_20_0, arg_20_1)
		var_20_0 = AgoraView.New(arg_20_0, var_20_1:GetAgora(), arg_20_2)
	elseif var_20_2 == IslandConst.CheaterTavernMapId then
		var_20_1 = CheaterTavernController.New(arg_20_0, arg_20_1)
		var_20_0 = IslandCheaterTavernGameView.New(arg_20_0, arg_20_2)
	elseif pg.island_map[var_20_2].minigame_id > 0 then
		var_20_0 = IslandSeekGameView.New(arg_20_0, arg_20_2)
		var_20_1 = IslandController.New(arg_20_0, arg_20_1)
	else
		var_20_1 = IslandController.New(arg_20_0, arg_20_1)
		var_20_0 = IslandView.New(arg_20_0, arg_20_2)
	end

	return var_20_0, var_20_1
end

return var_0_0
