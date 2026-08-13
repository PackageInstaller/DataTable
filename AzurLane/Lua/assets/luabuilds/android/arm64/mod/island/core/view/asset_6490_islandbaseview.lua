class = var_0_10000

local var_0_0 = var_0_10000("IslandBaseView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.core = arg_1_1
	arg_1_0.callbacks = {}
	arg_1_0.unitRegister = {}
	arg_1_0.registerIndex = 0
	arg_1_0.opCount = arg_1_2 or 1

	return
end

function var_0_0.GetCacheOpCount(arg_2_0)
	return arg_2_0.opCount
end

function var_0_0.SetUp(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance().UIMain
	local var_3_1 = var_1.Find(var_3_0, "UIIsland")
	local var_3_2 = arg_3_0.core

	arg_3_0.poolMgr = var_2.GetPoolMgr(var_3_2)
	arg_3_0.layer1Container = var_3_1:Find("layer1")
	GetOrAddComponent = var_2

	local var_3_3 = arg_3_0.layer1Container

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_3_0.layer1ContainerCg = var_2(var_3_3, var_5(var_1_10007))
	arg_3_0.topContainer = var_3_1:Find("layer1/top")
	arg_3_0.opContainer = var_3_1:Find("layer1/op")
	arg_3_0.interactionContainer = var_3_1:Find("layer1/interaction")
	arg_3_0.hudContainer = var_3_1:Find("layer1/hud")
	arg_3_0.pageContianer = var_3_1:Find("layer1/page")
	arg_3_0.layer2UIContianer = var_3_1:Find("layer2/ui")
	arg_3_0.layer2OpContianer = var_3_1:Find("layer2/op")
	arg_3_0.root = arg_3_0:CreateRoot()

	arg_3_0:Init()
	arg_3_0:AddListeners()

	return
end

function var_0_0.Enter(arg_4_0)
	arg_4_0:DoEnter()

	return
end

function var_0_0.UnBlockLayer1Event(arg_5_0, arg_5_1)
	arg_5_0.layer1ContainerCg.blocksRaycasts = arg_5_1

	return
end

function var_0_0.SetBgm(arg_6_0, arg_6_1)
	arg_6_0.bgm = arg_6_1

	return
end

function var_0_0.ShowOrHideContainer(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0.opContainer, arg_7_1)

	setActive = var_1_10002

	var_1_10002(arg_7_0.pageContianer, arg_7_1)

	return
end

function var_0_0.RegisterUnitList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or arg_8_0.registerIndex + 1

	if not arg_8_1 then
		arg_8_0.registerIndex = var_8_0
	end

	assert = var_1_10003

	var_1_10003(arg_8_0.unitRegister[var_8_0] == nil, "UnitList already exist")

	arg_8_0.unitRegister[var_8_0] = {}

	return arg_8_0.unitRegister[var_8_0]
end

function var_0_0.GetUnitListRegitser(arg_9_0)
	return arg_9_0.unitRegister
end

function var_0_0.GetUnitListByKey(arg_10_0, arg_10_1)
	assert = var_1_10002

	var_1_10002(arg_10_1 and arg_10_0.unitRegister[arg_10_1], "key should be exist>>>." .. arg_10_1)

	local var_10_0

	if not arg_10_0.unitRegister[arg_10_1] then
		var_10_0 = {}
	end

	return var_10_0
end

function var_0_0.AddUnit(arg_11_0, arg_11_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_11_0 = arg_11_1

	IslandSceneUnit = var_1_10007

	var_1_10002(var_1_10004(var_11_0, var_1_10007), "unit should be IslandSceneUnit")

	local var_11_1 = arg_11_0:GetUnitListByKey(arg_11_1:GetUnitType())

	table = var_1_10003

	var_1_10003.insert(var_11_1, arg_11_1)

	return
end

function var_0_0.RemoveUnit(arg_12_0, arg_12_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_12_0 = arg_12_1

	IslandSceneUnit = var_1_10007

	var_1_10002(var_1_10004(var_12_0, var_1_10007), "unit should be IslandSceneUnit")

	local var_12_1 = arg_12_0:GetUnitListByKey(arg_12_1:GetUnitType())

	table = var_1_10003

	var_1_10003.removebyvalue(var_12_1, arg_12_1)

	return
end

function var_0_0.GetPoolMgr(arg_13_0)
	return arg_13_0.poolMgr
end

function var_0_0.CreateRoot(arg_14_0)
	GameObject = var_1_10001

	return var_1_10001.New("Root")
end

function var_0_0.OnCoreStateChanged(arg_15_0, arg_15_1)
	IslandCore = var_1_10002

	if arg_15_1 == var_1_10002.STATE_INIT_FINISH then
		arg_15_0:PlayBGM()
	end

	return
end

function var_0_0.PlayBGM(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.Push(var_16_0, "IslandScene", arg_16_0.bgm)

	return
end

function var_0_0.NotifiyCore(arg_17_0, arg_17_1, ...)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.Op
	local var_17_2 = "NotifiyCore"
	local var_17_3 = arg_17_1

	unpack = var_1_10007

	var_17_1(var_17_0, var_17_2, var_17_3, var_1_10007({
		...
	}))

	return
end

function var_0_0.NotifiyIsland(arg_18_0, ...)
	arg_18_0:Op("NotifiyIsland", ...)

	return
end

function var_0_0.NotifiyMeditor(arg_19_0, arg_19_1, ...)
	arg_19_0:Op("NotifiyMeditor", arg_19_1, ...)

	return
end

function var_0_0.Op(arg_20_0, arg_20_1, ...)
	local var_20_0 = arg_20_0:GetCore()
	local var_20_1 = var_2.GetController(var_20_0)

	var_2.Receive(var_20_1, arg_20_1, ...)

	return
end

function var_0_0.IsSelfIsland(arg_21_0)
	local var_21_0 = arg_21_0:GetCore()
	local var_21_1 = var_1.GetController(var_21_0)

	return var_1.IsSelfIsland(var_21_1)
end

function var_0_0.GetIsland(arg_22_0)
	local var_22_0 = arg_22_0:GetCore()
	local var_22_1 = var_1.GetController(var_22_0)

	return var_1.GetIsland(var_22_1)
end

function var_0_0.GetSelfIsland(arg_23_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)

	return var_1.GetIsland(var_23_0)
end

function var_0_0.GetController(arg_24_0)
	local var_24_0 = arg_24_0.core

	return var_1.GetController(var_24_0)
end

function var_0_0.ShowMsgbox(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10005

	var_25_1(var_25_0, var_1_10005.SHOW_MSG, arg_25_1)

	return
end

function var_0_0.GetCore(arg_26_0)
	return arg_26_0.core
end

function var_0_0.InMap(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetCore()

	return var_2.GetMapId(var_27_0) == arg_27_1
end

function var_0_0.GetMapId(arg_28_0)
	local var_28_0 = arg_28_0:GetCore()

	return var_1.GetMapId(var_28_0)
end

function var_0_0.AddListener(arg_29_0, arg_29_1, arg_29_2)
	local function var_29_0(arg_30_0, ...)
		arg_29_2(arg_29_0, ...)

		return
	end

	assert = var_1_10004

	var_1_10004(arg_29_0.callbacks[arg_29_2] == nil, "This method has been monitored. Please use another one" .. arg_29_1)

	arg_29_0.callbacks[arg_29_2] = var_29_0

	local var_29_1 = arg_29_0.core

	var_4.AddListener(var_29_1, arg_29_1, var_29_0)

	return
end

function var_0_0.RemoveListener(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.callbacks[arg_31_2] then
		local var_31_0 = arg_31_0.core

		var_4.RemoveListener(var_31_0, arg_31_1, var_3)

		arg_31_0.callbacks[var_3] = nil
	end

	return
end

function var_0_0.Dispose(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.StopPlay(var_32_0)
	arg_32_0:RemoveListeners()
	arg_32_0:OnDispose()

	arg_32_0.callbacks = nil
	arg_32_0.unitRegister = nil
	arg_32_0.registerIndex = 0

	return
end

function var_0_0.Init(arg_33_0)
	return
end

function var_0_0.DoEnter(arg_34_0)
	return
end

function var_0_0.Update(arg_35_0)
	return
end

function var_0_0.LateUpdate(arg_36_0)
	return
end

function var_0_0.AddListeners(arg_37_0)
	return
end

function var_0_0.RemoveListeners(arg_38_0)
	return
end

function var_0_0.OnDispose(arg_39_0)
	return
end

return var_0_0
