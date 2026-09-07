local IslandBaseView = class("IslandBaseView")

function IslandBaseView:Ctor(arg_1_1, arg_1_2)
	self.core = arg_1_1
	self.callbacks = {}
	self.unitRegister = {}
	self.registerIndex = 0
	self.opCount = arg_1_2 or 1

	return
end

function IslandBaseView:GetCacheOpCount()
	return self.opCount
end

function IslandBaseView:SetUp()
	local var_3_0 = pg.UIMgr.GetInstance().UIMain:Find("UIIsland")

	self.poolMgr = self.core:GetPoolMgr()
	self.layer1Container = var_3_0:Find("layer1")
	self.layer1ContainerCg = GetOrAddComponent(self.layer1Container, typeof(CanvasGroup))
	self.topContainer = var_3_0:Find("layer1/top")
	self.opContainer = var_3_0:Find("layer1/op")
	self.interactionContainer = var_3_0:Find("layer1/interaction")
	self.hudContainer = var_3_0:Find("layer1/hud")
	self.pageContianer = var_3_0:Find("layer1/page")
	self.layer2UIContianer = var_3_0:Find("layer2/ui")
	self.layer2OpContianer = var_3_0:Find("layer2/op")
	self.root = self:CreateRoot()

	self:Init()
	self:AddListeners()

	return
end

function IslandBaseView:Enter()
	self:DoEnter()

	return
end

function IslandBaseView:UnBlockLayer1Event(arg_5_1)
	self.layer1ContainerCg.blocksRaycasts = arg_5_1

	return
end

function IslandBaseView:SetBgm(arg_6_1)
	self.bgm = arg_6_1

	return
end

function IslandBaseView:ShowOrHideContainer(arg_7_1)
	setActive(self.opContainer, arg_7_1)
	setActive(self.pageContianer, arg_7_1)

	return
end

function IslandBaseView:RegisterUnitList(arg_8_1)
	local var_8_0 = arg_8_1 or self.registerIndex + 1

	if not arg_8_1 then
		self.registerIndex = var_8_0
	end

	assert(self.unitRegister[var_8_0] == nil, "UnitList already exist")

	self.unitRegister[var_8_0] = {}

	return self.unitRegister[var_8_0]
end

function IslandBaseView:GetUnitListRegitser()
	return self.unitRegister
end

function IslandBaseView:GetUnitListByKey(arg_10_1)
	assert(arg_10_1 and self.unitRegister[arg_10_1], "key should be exist>>>." .. arg_10_1)

	return self.unitRegister[arg_10_1] or {}
end

function IslandBaseView:AddUnit(arg_11_1)
	assert(isa(arg_11_1, IslandSceneUnit), "unit should be IslandSceneUnit")
	table.insert(self:GetUnitListByKey(arg_11_1:GetUnitType()), arg_11_1)

	return
end

function IslandBaseView:RemoveUnit(arg_12_1)
	assert(isa(arg_12_1, IslandSceneUnit), "unit should be IslandSceneUnit")
	table.removebyvalue(self:GetUnitListByKey(arg_12_1:GetUnitType()), arg_12_1)

	return
end

function IslandBaseView:GetPoolMgr()
	return self.poolMgr
end

function IslandBaseView:CreateRoot()
	return GameObject.New("Root")
end

function IslandBaseView:OnCoreStateChanged(arg_15_1)
	if arg_15_1 == IslandCore.STATE_INIT_FINISH then
		self:PlayBGM()
	end

	return
end

function IslandBaseView:PlayBGM()
	pg.BgmMgr.GetInstance():Push("IslandScene", self.bgm)

	return
end

function IslandBaseView:NotifiyCore(arg_17_1, ...)
	self:Op("NotifiyCore", arg_17_1, unpack({
		...
	}))

	return
end

function IslandBaseView:NotifiyIsland(...)
	self:Op("NotifiyIsland", ...)

	return
end

function IslandBaseView:NotifiyMeditor(arg_19_1, ...)
	self:Op("NotifiyMeditor", arg_19_1, ...)

	return
end

function IslandBaseView:Op(arg_20_1, ...)
	self:GetCore():GetController():Receive(arg_20_1, ...)

	return
end

function IslandBaseView:IsSelfIsland()
	return self:GetCore():GetController():IsSelfIsland()
end

function IslandBaseView:GetIsland()
	return self:GetCore():GetController():GetIsland()
end

function IslandBaseView:GetSelfIsland()
	return getProxy(IslandProxy):GetIsland()
end

function IslandBaseView:GetController()
	return self.core:GetController()
end

function IslandBaseView:ShowMsgbox(arg_25_1)
	self:NotifiyIsland(ISLAND_EX_EVT.SHOW_MSG, arg_25_1)

	return
end

function IslandBaseView:GetCore()
	return self.core
end

function IslandBaseView:InMap(arg_27_1)
	return self:GetCore():GetMapId() == arg_27_1
end

function IslandBaseView:GetMapId()
	return self:GetCore():GetMapId()
end

function IslandBaseView:AddListener(arg_29_1, arg_29_2)
	local function var_29_0(arg_30_0, ...)
		arg_29_2(self, ...)

		return
	end

	assert(self.callbacks[arg_29_2] == nil, "This method has been monitored. Please use another one" .. arg_29_1)

	self.callbacks[arg_29_2] = var_29_0

	self.core:AddListener(arg_29_1, var_29_0)

	return
end

function IslandBaseView:RemoveListener(arg_31_1, arg_31_2)
	if self.callbacks[arg_31_2] then
		self.core:RemoveListener(arg_31_1, self.callbacks[arg_31_2])

		self.callbacks[self.callbacks[arg_31_2]] = nil
	end

	return
end

function IslandBaseView:Dispose()
	pg.BgmMgr.GetInstance():StopPlay()
	self:RemoveListeners()
	self:OnDispose()

	self.callbacks = nil
	self.unitRegister = nil
	self.registerIndex = 0

	return
end

function IslandBaseView:Init()
	return
end

function IslandBaseView:DoEnter()
	return
end

function IslandBaseView:Update()
	return
end

function IslandBaseView:LateUpdate()
	return
end

function IslandBaseView:AddListeners()
	return
end

function IslandBaseView:RemoveListeners()
	return
end

function IslandBaseView:OnDispose()
	return
end

return IslandBaseView
