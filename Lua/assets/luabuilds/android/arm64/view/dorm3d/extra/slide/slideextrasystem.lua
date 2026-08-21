local var_0_0 = class("SlideExtraSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

var_0_0.SHOW_INTERACTION = "SlideExtraSystem.SHOW_INTERACTION"
var_0_0.HIDE_INTERACTION = "SlideExtraSystem.HIDE_INTERACTION"
var_0_0.SHOW_PERFORMANCE = "SlideExtraSystem.SHOW_PERFORMANCE"
var_0_0.HIDE_PERFORMANCE = "SlideExtraSystem.HIDE_PERFORMANCE"

function var_0_0.OnInit(arg_1_0)
	arg_1_0:RegisterNodeCanvas()
	arg_1_0:InitScene()
	arg_1_0:InitData()
	arg_1_0:InitSlide()
	arg_1_0:Emit(Dorm3dRoomMediator.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE)

	arg_1_0.pickTimer = Timer.New(function()
		arg_1_0:OnPick()

		return
	end, SlideConst.TIMER_INTERVAL, -1)

	arg_1_0.pickTimer:Start()
	arg_1_0:OnPick()

	return
end

function var_0_0.OnUpdate(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.ladyDic) do
		iter_3_1:OnUpdate()
	end

	return
end

function var_0_0.OnDispose(arg_4_0)
	if arg_4_0.pickTimer then
		arg_4_0.pickTimer:Stop()

		arg_4_0.pickTimer = nil
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.ladyDic) do
		arg_4_0:RemoveLadySlide(iter_4_0)
	end

	arg_4_0:Func("ChangePlayerPosition")

	if arg_4_0.slideTreeOwner then
		arg_4_0.slideTreeOwner.enabled = false
	end

	if arg_4_0.performanceTreeOwner then
		arg_4_0.performanceTreeOwner.enabled = false
	end

	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.ShowInteraction")
	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.HideInteraction")
	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.ShowPerformance")
	pg.NodeCanvasMgr.GetInstance():UnregisterFunc("Slide.HidePerformance")
	arg_4_0:Emit(Dorm3dRoomMediator.REMOVE_EXTRA_SYSTEM, FurnitureSlideExtraMediator)

	return
end

function var_0_0.OnHandleNotification(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == ApartmentProxy.UPDATE_SLIDE_INVITE_LIST then
		arg_5_0:UpdateSlideInviteList(arg_5_2.addIds, arg_5_2.removeIds)
	elseif arg_5_1 == Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE then
		arg_5_0:InitSlide()
	end

	return
end

function var_0_0.GetInterests()
	return {
		ApartmentProxy.UPDATE_SLIDE_INVITE_LIST,
		Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE
	}
end

function var_0_0.IsOpen(arg_7_0)
	return arg_7_0:GetConfigID() == SlideConst.ROOM_ID and arg_7_0:IsFurnitureSetIn(SlideConst.FURNITURE_ID)
end

function var_0_0.RegisterNodeCanvas(arg_8_0)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.ShowInteraction", function()
		pg.m02:sendNotification(var_0_0.SHOW_INTERACTION)

		return
	end)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.HideInteraction", function()
		pg.m02:sendNotification(var_0_0.HIDE_INTERACTION)

		return
	end)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.ShowPerformance", function()
		pg.m02:sendNotification(var_0_0.SHOW_PERFORMANCE)

		return
	end)
	pg.NodeCanvasMgr.GetInstance():RegisterFunc("Slide.HidePerformance", function()
		pg.m02:sendNotification(var_0_0.HIDE_PERFORMANCE)

		return
	end)

	return
end

function var_0_0.InitScene(arg_13_0)
	arg_13_0.sceneSlideConfigs = GameObject.Find("SlideConfigs").transform
	arg_13_0.movePointsRoot = arg_13_0.sceneSlideConfigs:Find("MovePoints")
	arg_13_0.defaultPointsRoot = arg_13_0.sceneSlideConfigs:Find("DefaultPoints")

	return
end

function var_0_0.InitSlide(arg_14_0)
	warning("SystemInitSlide")

	if not arg_14_0:Get("doneFirstSlotFresh") or arg_14_0.slideInited then
		return
	end

	arg_14_0.slideInited = true
	arg_14_0.slideGo = arg_14_0:GetSceneItem("FurnitureSlots/140101/Slide(Clone)")

	assert(arg_14_0.slideGo, "Furniture Slide not found in scene")
	warning("InitSlide Done")

	arg_14_0.slideTreeOwner = GetOrAddComponent(arg_14_0.slideGo, typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	arg_14_0.slideTreeOwner.graph.blackboard:AddVariable("_player", go(arg_14_0:Get("player")))

	arg_14_0.slideTreeOwner.enabled = true
	arg_14_0.performanceTreeOwner = GetOrAddComponent(arg_14_0.slideGo:Find("performance_interact_point"), typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	arg_14_0.performanceTreeOwner.graph.blackboard:AddVariable("_player", go(arg_14_0:Get("player")))

	arg_14_0.performanceTreeOwner.enabled = true

	return
end

function var_0_0.InitData(arg_15_0)
	arg_15_0.commandConfigDic = {}
	arg_15_0.defaultPoints = {}

	_.each(pg.dorm3d_minigame_slide.all, function(arg_16_0)
		arg_15_0.commandConfigDic[arg_16_0] = {}

		_.each(pg.dorm3d_minigame_slide[arg_16_0].slide_command, function(arg_17_0)
			table.insert(arg_15_0.commandConfigDic[arg_16_0], SlideCommand.New(arg_17_0, arg_15_0.movePointsRoot))

			return
		end)

		arg_15_0.defaultPoints[arg_16_0] = arg_15_0.defaultPointsRoot:Find(pg.dorm3d_minigame_slide[arg_16_0].slide_zone)

		return
	end)

	arg_15_0.inviteList = getProxy(ApartmentProxy):GetSlideInviteList()
	arg_15_0.randomList = Clone(arg_15_0.inviteList)
	arg_15_0.ladyDic = {}

	_.each(arg_15_0.inviteList, function(arg_18_0)
		arg_15_0:AddLadySlide(arg_18_0)

		return
	end)

	return
end

function var_0_0.AddLadySlide(arg_19_0, arg_19_1)
	arg_19_0.ladyDic[arg_19_1] = LadySlide.New(arg_19_1, arg_19_0:Get("ladyDict")[arg_19_1], arg_19_0.commandConfigDic[arg_19_1], arg_19_0.defaultPoints[arg_19_1], function(arg_20_0)
		arg_19_0:PlayVFX(arg_20_0)

		return
	end)

	arg_19_0.ladyDic[arg_19_1]:Reset()

	return
end

function var_0_0.RemoveLadySlide(arg_21_0, arg_21_1)
	if arg_21_0.ladyDic[arg_21_1] then
		arg_21_0:Func("ChangeCharacterPosition", arg_21_0.ladyDic[arg_21_1].ladyEnv)
		arg_21_0.ladyDic[arg_21_1].ladyEnv:PlaySingleAction(SlideConst.IDLE_ANIM)
		arg_21_0.ladyDic[arg_21_1]:Dispose()

		arg_21_0.ladyDic[arg_21_1] = nil
	end

	return
end

function var_0_0.OnPick(arg_22_0)
	if #arg_22_0.inviteList == 0 then
		return
	end

	arg_22_0.currentGroupId = arg_22_0:RandomPick()

	if arg_22_0.ladyDic[arg_22_0.currentGroupId].ladyEnv:GetBlackboardValue("inWatchMode") then
		if #arg_22_0.inviteList > 1 then
			arg_22_0:OnPick()
		end

		return
	end

	arg_22_0.ladyDic[arg_22_0.currentGroupId]:StartMove()

	return
end

function var_0_0.RandomPick(arg_23_0)
	if not arg_23_0.randomList or #arg_23_0.randomList == 0 then
		arg_23_0.randomList = Clone(arg_23_0.inviteList)
	end

	local var_23_0 = math.random(1, #arg_23_0.randomList)

	table.remove(arg_23_0.randomList, var_23_0)

	return arg_23_0.randomList[var_23_0]
end

function var_0_0.TestMove(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.ladyDic) do
		iter_24_1:EndMove()
		iter_24_1:StartMove()

		arg_24_0.currentGroupId = iter_24_1.id

		return
	end

	return
end

function var_0_0.UpdateSlideInviteList(arg_25_0, arg_25_1, arg_25_2)
	if table.contains(arg_25_2, arg_25_0.currentGroupId) then
		arg_25_0.ladyDic[arg_25_0.currentGroupId]:EndMove()
	end

	_.each(arg_25_2, function(arg_26_0)
		arg_25_0:RemoveLadySlide(arg_26_0)
		table.removebyvalue(arg_25_0.inviteList, arg_26_0)
		table.removebyvalue(arg_25_0.randomList, arg_26_0)

		return
	end)
	_.each(arg_25_1, function(arg_27_0)
		if not table.contains(arg_25_0.inviteList, arg_27_0) then
			table.insert(arg_25_0.inviteList, arg_27_0)
			arg_25_0:AddLadySlide(arg_27_0)
		end

		if not table.contains(arg_25_0.randomList, arg_27_0) then
			table.insert(arg_25_0.randomList, arg_27_0)
		end

		return
	end)

	return
end

function var_0_0.PlayVFX(arg_28_0, arg_28_1)
	setActive(arg_28_0.sceneSlideConfigs:Find("vfx/" .. arg_28_1), false)
	onNextTick(function()
		setActive(var_0, true)

		return
	end)

	return
end

return var_0_0
