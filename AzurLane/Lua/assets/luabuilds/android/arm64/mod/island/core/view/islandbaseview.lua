local var_0_0 = class("IslandBaseView")

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
	local var_3_0 = pg.UIMgr.GetInstance().UIMain:Find("UIIsland")

	arg_3_0.poolMgr = arg_3_0.core:GetPoolMgr()
	arg_3_0.layer1Container = var_3_0:Find("layer1")
	arg_3_0.layer1ContainerCg = GetOrAddComponent(arg_3_0.layer1Container, typeof(CanvasGroup))
	arg_3_0.topContainer = var_3_0:Find("layer1/top")
	arg_3_0.opContainer = var_3_0:Find("layer1/op")
	arg_3_0.interactionContainer = var_3_0:Find("layer1/interaction")
	arg_3_0.hudContainer = var_3_0:Find("layer1/hud")
	arg_3_0.pageContianer = var_3_0:Find("layer1/page")
	arg_3_0.layer2UIContianer = var_3_0:Find("layer2/ui")
	arg_3_0.layer2OpContianer = var_3_0:Find("layer2/op")
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
	setActive(arg_7_0.opContainer, arg_7_1)
	setActive(arg_7_0.pageContianer, arg_7_1)

	return
end

function var_0_0.RegisterUnitList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or arg_8_0.registerIndex + 1

	if not arg_8_1 then
		arg_8_0.registerIndex = var_8_0
	end

	assert(arg_8_0.unitRegister[var_8_0] == nil, "UnitList already exist")

	arg_8_0.unitRegister[var_8_0] = {}

	return arg_8_0.unitRegister[var_8_0]
end

function var_0_0.GetUnitListRegitser(arg_9_0)
	return arg_9_0.unitRegister
end

function var_0_0.GetUnitListByKey(arg_10_0, arg_10_1)
	assert(arg_10_1 and arg_10_0.unitRegister[arg_10_1], "key should be exist>>>." .. arg_10_1)

	return arg_10_0.unitRegister[arg_10_1] or {}
end

function var_0_0.AddUnit(arg_11_0, arg_11_1)
	assert(isa(arg_11_1, IslandSceneUnit), "unit should be IslandSceneUnit")
	table.insert(arg_11_0:GetUnitListByKey(arg_11_1:GetUnitType()), arg_11_1)

	return
end

function var_0_0.RemoveUnit(arg_12_0, arg_12_1)
	assert(isa(arg_12_1, IslandSceneUnit), "unit should be IslandSceneUnit")
	table.removebyvalue(arg_12_0:GetUnitListByKey(arg_12_1:GetUnitType()), arg_12_1)

	return
end

function var_0_0.GetPoolMgr(arg_13_0)
	return arg_13_0.poolMgr
end

function var_0_0.CreateRoot(arg_14_0)
	return GameObject.New("Root")
end

function var_0_0.OnCoreStateChanged(arg_15_0, arg_15_1)
	if arg_15_1 == IslandCore.STATE_INIT_FINISH then
		arg_15_0:PlayBGM()
	end

	return
end

function var_0_0.PlayBGM(arg_16_0)
	pg.BgmMgr.GetInstance():Push("IslandScene", arg_16_0.bgm)

	return
end

function var_0_0.NotifiyCore(arg_17_0, arg_17_1, ...)
	arg_17_0:Op("NotifiyCore", arg_17_1, unpack({
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
	arg_20_0:GetCore():GetController():Receive(arg_20_1, ...)

	return
end

function var_0_0.IsSelfIsland(arg_21_0)
	return arg_21_0:GetCore():GetController():IsSelfIsland()
end

function var_0_0.GetIsland(arg_22_0)
	return arg_22_0:GetCore():GetController():GetIsland()
end

function var_0_0.GetSelfIsland(arg_23_0)
	return getProxy(IslandProxy):GetIsland()
end

function var_0_0.GetController(arg_24_0)
	return arg_24_0.core:GetController()
end

function var_0_0.ShowMsgbox(arg_25_0, arg_25_1)
	arg_25_0:NotifiyIsland(ISLAND_EX_EVT.SHOW_MSG, arg_25_1)

	return
end

function var_0_0.GetCore(arg_26_0)
	return arg_26_0.core
end

function var_0_0.InMap(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetCore()

	return var_27_0:GetMapId() == arg_27_1
end

function var_0_0.GetMapId(arg_28_0)
	return arg_28_0:GetCore():GetMapId()
end

function var_0_0.AddListener(arg_29_0, arg_29_1, arg_29_2)
	assert(arg_29_0.callbacks[arg_29_2] == nil, "This method has been monitored. Please use another one" .. arg_29_1)

	arg_29_0.callbacks[arg_29_2] = function(arg_30_0, ...)
		arg_29_2(arg_29_0, ...)

		return
	end

	arg_29_0.core:AddListener(arg_29_1, function(arg_30_0, ...)
		arg_29_2(arg_29_0, ...)

		return
	end)

	return
end

function var_0_0.RemoveListener(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.callbacks[arg_31_2] then
		arg_31_0.core:RemoveListener(arg_31_1, arg_31_0.callbacks[arg_31_2])

		arg_31_0.callbacks[arg_31_0.callbacks[arg_31_2]] = nil
	end

	return
end

function var_0_0.Dispose(arg_32_0)
	pg.BgmMgr.GetInstance():StopPlay()
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
