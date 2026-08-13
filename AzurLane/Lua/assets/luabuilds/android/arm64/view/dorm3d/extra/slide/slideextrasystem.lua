class = var_0_10000

local var_0_0 = "SlideExtraSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Extra.BaseExtraSystem"))

var_0_1.SHOW_INTERACTION = "SlideExtraSystem.SHOW_INTERACTION"
var_0_1.HIDE_INTERACTION = "SlideExtraSystem.HIDE_INTERACTION"
var_0_1.SHOW_PERFORMANCE = "SlideExtraSystem.SHOW_PERFORMANCE"
var_0_1.HIDE_PERFORMANCE = "SlideExtraSystem.HIDE_PERFORMANCE"

function var_0_1.OnInit(arg_1_0)
	arg_1_0:RegisterNodeCanvas()
	arg_1_0:InitScene()
	arg_1_0:InitData()
	arg_1_0:InitSlide()

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.Emit

	Dorm3dRoomMediator = var_1_10004

	var_1_1(var_1_0, var_1_10004.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE)

	Timer = var_1_1

	local var_1_2 = var_1_1.New

	local function var_1_3()
		local var_2_0 = arg_1_0

		var_0.OnPick(var_2_0)

		return
	end

	SlideConst = var_4
	arg_1_0.pickTimer = var_1_2(var_1_3, var_4.TIMER_INTERVAL, -1)

	local var_1_4 = arg_1_0.pickTimer

	var_1.Start(var_1_4)
	arg_1_0:OnPick()

	return
end

function var_0_1.OnUpdate(arg_3_0, arg_3_1)
	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.ladyDic) do
		iter_3_1:OnUpdate()
	end

	return
end

function var_0_1.OnDispose(arg_4_0)
	if arg_4_0.pickTimer then
		local var_4_0 = arg_4_0.pickTimer

		var_1.Stop(var_4_0)

		arg_4_0.pickTimer = nil
	end

	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.ladyDic) do
		arg_4_0:RemoveLadySlide(iter_4_0)
	end

	arg_4_0:Func("ChangePlayerPosition")

	if arg_4_0.slideTreeOwner then
		arg_4_0.slideTreeOwner.enabled = false
	end

	local var_4_1

	if arg_4_0.performanceTreeOwner then
		var_4_1 = arg_4_0.performanceTreeOwner
		var_4_1.enabled = false
	end

	pg = var_4_1

	local var_4_2 = var_4_1.NodeCanvasMgr.GetInstance()

	var_1.UnregisterFunc(var_4_2, "Slide.ShowInteraction")

	pg = var_1

	local var_4_3 = var_1.NodeCanvasMgr.GetInstance()

	var_1.UnregisterFunc(var_4_3, "Slide.HideInteraction")

	pg = var_1

	local var_4_4 = var_1.NodeCanvasMgr.GetInstance()

	var_1.UnregisterFunc(var_4_4, "Slide.ShowPerformance")

	pg = var_1

	local var_4_5 = var_1.NodeCanvasMgr.GetInstance()

	var_1.UnregisterFunc(var_4_5, "Slide.HidePerformance")

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.Emit

	Dorm3dRoomMediator = var_4

	local var_4_8 = var_4.REMOVE_EXTRA_SYSTEM

	FurnitureSlideExtraMediator = iter_4_1

	var_4_7(var_4_6, var_4_8, iter_4_1)

	return
end

function var_0_1.OnHandleNotification(arg_5_0, arg_5_1, arg_5_2)
	ApartmentProxy = var_1_10003

	if arg_5_1 == var_1_10003.UPDATE_SLIDE_INVITE_LIST then
		arg_5_0:UpdateSlideInviteList(arg_5_2.addIds, arg_5_2.removeIds)
	else
		Dorm3dRoomMediator = var_3

		if arg_5_1 == var_3.REFRESH_FURNITURE_AND_SLOTS_DONE then
			arg_5_0:InitSlide()
		end
	end

	return
end

function var_0_1.GetInterests()
	local var_6_0 = {}

	ApartmentProxy = var_1_10001
	var_6_0[1] = var_1_10001.UPDATE_SLIDE_INVITE_LIST
	Dorm3dRoomMediator = var_1
	var_6_0[2] = var_1.REFRESH_FURNITURE_AND_SLOTS_DONE

	return var_6_0
end

function var_0_1.IsOpen(arg_7_0)
	local var_7_0 = arg_7_0:GetConfigID()

	SlideConst = var_1_10002

	local var_7_3

	if var_7_0 == var_1_10002.ROOM_ID then
		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.IsFurnitureSetIn

		SlideConst = var_1_10004
		var_7_3 = var_7_2(var_7_1, var_1_10004.FURNITURE_ID)
	else
		var_7_3 = false
	end

	if false then
		var_7_3 = true
	end

	return var_7_3
end

function var_0_1.RegisterNodeCanvas(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.NodeCanvasMgr.GetInstance()

	var_1.RegisterFunc(var_8_0, "Slide.ShowInteraction", function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02

		var_0.sendNotification(var_9_0, var_0_1.SHOW_INTERACTION)

		return
	end)

	pg = var_1

	local var_8_1 = var_1.NodeCanvasMgr.GetInstance()

	var_1.RegisterFunc(var_8_1, "Slide.HideInteraction", function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.m02

		var_0.sendNotification(var_10_0, var_0_1.HIDE_INTERACTION)

		return
	end)

	pg = var_1

	local var_8_2 = var_1.NodeCanvasMgr.GetInstance()

	var_1.RegisterFunc(var_8_2, "Slide.ShowPerformance", function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.m02

		var_0.sendNotification(var_11_0, var_0_1.SHOW_PERFORMANCE)

		return
	end)

	pg = var_1

	local var_8_3 = var_1.NodeCanvasMgr.GetInstance()

	var_1.RegisterFunc(var_8_3, "Slide.HidePerformance", function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.m02

		var_0.sendNotification(var_12_0, var_0_1.HIDE_PERFORMANCE)

		return
	end)

	return
end

function var_0_1.InitScene(arg_13_0)
	GameObject = var_1_10001
	arg_13_0.sceneSlideConfigs = var_1_10001.Find("SlideConfigs").transform

	local var_13_0 = arg_13_0.sceneSlideConfigs

	arg_13_0.movePointsRoot = var_1.Find(var_13_0, "MovePoints")

	local var_13_1 = arg_13_0.sceneSlideConfigs

	arg_13_0.defaultPointsRoot = var_1.Find(var_13_1, "DefaultPoints")

	return
end

function var_0_1.InitSlide(arg_14_0)
	warning = var_1_10001

	var_1_10001("SystemInitSlide")

	if not arg_14_0:Get("doneFirstSlotFresh") or arg_14_0.slideInited then
		return
	end

	arg_14_0.slideInited = true
	arg_14_0.slideGo = arg_14_0:GetSceneItem("FurnitureSlots/140101/Slide(Clone)")
	assert = var_1

	var_1(arg_14_0.slideGo, "Furniture Slide not found in scene")

	warning = var_1

	var_1("InitSlide Done")

	GetOrAddComponent = var_1

	local var_14_0 = arg_14_0.slideGo

	typeof = var_4
	NodeCanvas = var_1_10006
	arg_14_0.slideTreeOwner = var_1(var_14_0, var_4(var_1_10006.BehaviourTrees.BehaviourTreeOwner))

	local var_14_1 = arg_14_0.slideTreeOwner.graph.blackboard
	local var_14_2 = var_1.AddVariable
	local var_14_3 = "_player"

	go = var_1_10005

	var_14_2(var_14_1, var_14_3, var_1_10005(arg_14_0:Get("player")))

	local var_14_4 = arg_14_0.slideTreeOwner

	var_14_4.enabled = true
	GetOrAddComponent = var_14_4

	local var_14_5 = arg_14_0.slideGo
	local var_14_6 = var_3.Find(var_14_5, "performance_interact_point")

	typeof = var_14_3
	NodeCanvas = var_6
	arg_14_0.performanceTreeOwner = var_14_4(var_14_6, var_14_3(var_6.BehaviourTrees.BehaviourTreeOwner))

	local var_14_7 = arg_14_0.performanceTreeOwner.graph.blackboard
	local var_14_8 = var_1.AddVariable
	local var_14_9 = "_player"

	go = var_14_5

	var_14_8(var_14_7, var_14_9, var_14_5(arg_14_0:Get("player")))

	arg_14_0.performanceTreeOwner.enabled = true

	return
end

function var_0_1.InitData(arg_15_0)
	arg_15_0.commandConfigDic = {}
	arg_15_0.defaultPoints = {}
	_ = var_1

	local var_15_0 = var_1.each

	pg = var_1_10003

	var_15_0(var_1_10003.dorm3d_minigame_slide.all, function(arg_16_0)
		local var_16_0 = arg_15_0.commandConfigDic

		var_16_0[arg_16_0] = {}
		_ = var_16_0

		local var_16_1 = var_16_0.each

		pg = var_2_10003

		var_16_1(var_2_10003.dorm3d_minigame_slide[arg_16_0].slide_command, function(arg_17_0)
			table = var_3_10001

			local var_17_0 = var_3_10001.insert
			local var_17_1 = arg_15_0.commandConfigDic[arg_16_0]

			SlideCommand = var_4

			var_17_0(var_17_1, var_4.New(arg_17_0, arg_15_0.movePointsRoot))

			return
		end)

		local var_16_2 = arg_15_0.defaultPointsRoot
		local var_16_3 = var_1.Find

		pg = var_4

		local var_16_4 = var_16_3(var_16_2, var_4.dorm3d_minigame_slide[arg_16_0].slide_zone)

		arg_15_0.defaultPoints[arg_16_0] = var_16_4

		return
	end)

	getProxy = var_15_0
	ApartmentProxy = var_3

	local var_15_1 = var_15_0(var_3)

	arg_15_0.inviteList = var_1.GetSlideInviteList(var_15_1)
	Clone = var_1
	arg_15_0.randomList = var_1(arg_15_0.inviteList)
	arg_15_0.ladyDic = {}
	_ = var_1

	var_1.each(arg_15_0.inviteList, function(arg_18_0)
		local var_18_0 = arg_15_0

		var_1.AddLadySlide(var_18_0, arg_18_0)

		return
	end)

	return
end

function var_0_1.AddLadySlide(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.Get(var_19_0, "ladyDict")[arg_19_1]
	local var_19_2 = arg_19_0.ladyDic

	LadySlide = var_19_0
	var_19_2[arg_19_1] = var_19_0.New(arg_19_1, var_19_1, arg_19_0.commandConfigDic[arg_19_1], arg_19_0.defaultPoints[arg_19_1], function(arg_20_0)
		local var_20_0 = arg_19_0

		var_1.PlayVFX(var_20_0, arg_20_0)

		return
	end)

	local var_19_3 = arg_19_0.ladyDic[arg_19_1]

	var_3.Reset(var_19_3)

	return
end

function var_0_1.RemoveLadySlide(arg_21_0, arg_21_1)
	if arg_21_0.ladyDic[arg_21_1] then
		arg_21_0:Func("ChangeCharacterPosition", arg_21_0.ladyDic[arg_21_1].ladyEnv)

		local var_21_0 = arg_21_0.ladyDic[arg_21_1].ladyEnv
		local var_21_1 = var_2.PlaySingleAction

		SlideConst = var_5

		var_21_1(var_21_0, var_5.IDLE_ANIM)

		local var_21_2 = arg_21_0.ladyDic[arg_21_1]

		var_2.Dispose(var_21_2)

		arg_21_0.ladyDic[arg_21_1] = nil
	end

	return
end

function var_0_1.OnPick(arg_22_0)
	if #arg_22_0.inviteList == 0 then
		return
	end

	arg_22_0.currentGroupId = arg_22_0:RandomPick()

	local var_22_0 = arg_22_0.ladyDic[arg_22_0.currentGroupId].ladyEnv

	if var_1.GetBlackboardValue(var_22_0, "inWatchMode") then
		if #arg_22_0.inviteList > 1 then
			arg_22_0:OnPick()
		end

		return
	end

	local var_22_1 = arg_22_0.ladyDic[arg_22_0.currentGroupId]

	var_1.StartMove(var_22_1)

	return
end

function var_0_1.RandomPick(arg_23_0)
	if not arg_23_0.randomList or #arg_23_0.randomList == 0 then
		Clone = var_1
		arg_23_0.randomList = var_1(arg_23_0.inviteList)
	end

	math = var_1

	local var_23_0 = var_1.random(1, #arg_23_0.randomList)
	local var_23_1 = arg_23_0.randomList[var_23_0]

	table = var_3

	var_3.remove(arg_23_0.randomList, var_23_0)

	return var_23_1
end

function var_0_1.TestMove(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.ladyDic) do
		iter_24_1:EndMove()
		iter_24_1:StartMove()

		arg_24_0.currentGroupId = iter_24_1.id

		return
	end

	return
end

function var_0_1.UpdateSlideInviteList(arg_25_0, arg_25_1, arg_25_2)
	table = var_1_10003

	if var_1_10003.contains(arg_25_2, arg_25_0.currentGroupId) then
		local var_25_0 = arg_25_0.ladyDic[arg_25_0.currentGroupId]

		var_3.EndMove(var_25_0)
	end

	_ = var_3

	var_3.each(arg_25_2, function(arg_26_0)
		local var_26_0 = arg_25_0

		var_1.RemoveLadySlide(var_26_0, arg_26_0)

		table = var_1

		var_1.removebyvalue(arg_25_0.inviteList, arg_26_0)

		table = var_1

		var_1.removebyvalue(arg_25_0.randomList, arg_26_0)

		return
	end)

	_ = var_3

	var_3.each(arg_25_1, function(arg_27_0)
		table = var_2_10001

		if not var_2_10001.contains(arg_25_0.inviteList, arg_27_0) then
			table = var_1

			var_1.insert(arg_25_0.inviteList, arg_27_0)

			local var_27_0 = arg_25_0

			var_1.AddLadySlide(var_27_0, arg_27_0)
		end

		table = var_1

		if not var_1.contains(arg_25_0.randomList, arg_27_0) then
			table = var_1

			var_1.insert(arg_25_0.randomList, arg_27_0)
		end

		return
	end)

	return
end

function var_0_1.PlayVFX(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.sceneSlideConfigs
	local var_28_1 = var_2.Find(var_28_0, "vfx/" .. arg_28_1)

	setActive = var_1_10003

	var_1_10003(var_28_1, false)

	onNextTick = var_1_10003

	var_1_10003(function()
		setActive = var_2_10000

		var_2_10000(var_28_1, true)

		return
	end)

	return
end

return var_0_1
