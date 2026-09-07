local IslandCore = class("IslandCore", import("..IslandDispatcher"))

IslandCore.STATE_LOAD = 1
IslandCore.STATE_INIT = 2
IslandCore.STATE_INIT_FINISH = 3
IslandCore.STATE_DISPOSE = 4

function IslandCore:Ctor(arg_1_1, arg_1_2, arg_1_3)
	IslandCore.super.Ctor(self)

	self.poolMgr = arg_1_1

	local var_1_0, var_1_1 = self:GetViewAndController(arg_1_2, arg_1_3)

	self.view = var_1_0
	self.controller = var_1_1
	self.sceneLoader = self:GetSceneLoader()

	self:UpdateState(IslandCore.STATE_LOAD)

	local var_1_2, var_1_3, var_1_4 = IslandDataConvertor.Island2SceneName(arg_1_2)

	self.view:SetBgm(var_1_4)
	self.sceneLoader:Load(var_1_2, var_1_3, {
		function(arg_2_0)
			self:SetUp(arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:Init(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:UpdateState(IslandCore.STATE_INIT_FINISH)
			arg_5_0()

			return
		end
	})

	self.enterTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function IslandCore:GetSceneLoader()
	return IslandSceneLoader.New()
end

function IslandCore:GetPoolMgr()
	return self.poolMgr
end

function IslandCore:UpdateState(arg_8_1)
	self.state = arg_8_1

	self.view:OnCoreStateChanged(arg_8_1)
	self.controller:OnCoreStateChanged(arg_8_1)
	pg.m02:sendNotification(GAME.ISLAND_CORE_STATE_CHANGED, arg_8_1)

	return
end

function IslandCore:SetUp(arg_9_1)
	self:UpdateState(IslandCore.STATE_INIT)
	self.view:SetUp()
	self.controller:SetUp()

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	if not self.lateUpdateluHandle then
		self.lateUpdateluHandle = LateUpdateBeat:CreateListener(self.LateUpdate, self)

		LateUpdateBeat:AddListener(self.lateUpdateluHandle)
	end

	self.callback = arg_9_1

	self:OnInit()

	return
end

function IslandCore:Init(arg_10_1)
	self.view:Enter()

	self.initCallback = arg_10_1

	return
end

function IslandCore:GetMapId()
	return self:GetController():GetMapID()
end

function IslandCore:IsInit()
	return self.state == IslandCore.STATE_INIT or self.state == IslandCore.STATE_INIT_FINISH
end

function IslandCore:Update()
	if not self:IsInit() then
		return
	end

	self.controller:Update()
	self.view:Update()

	if self.callback and self.view:IsLoaded() then
		self.callback()

		self.callback = nil
	end

	if self.initCallback and self.view:IsInit() then
		self.initCallback()

		self.initCallback = nil
	end

	return
end

function IslandCore:LateUpdate()
	if not self:IsInit() then
		return
	end

	self.controller:LateUpdate()
	self.view:LateUpdate()

	return
end

function IslandCore:GetView()
	return self.view
end

function IslandCore:GetController()
	return self.controller
end

function IslandCore:Link(arg_17_1, ...)
	self:GetController():NotifiyCore(arg_17_1, ...)

	return
end

function IslandCore:Dispose(arg_18_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildMapExit(self.controller.mapId, pg.TimeMgr.GetInstance():GetServerTime() - self.enterTime))
	self:UpdateState(IslandCore.STATE_DISPOSE)

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self.lateUpdateluHandle then
		LateUpdateBeat:RemoveListener(self.lateUpdateluHandle)
	end

	if IslandCameraMgr.instance and IslandCameraMgr.instance.gameObject then
		setActive(IslandCameraMgr.instance.gameObject, false)
	end

	if self.view then
		self.view:Dispose()

		self.view = nil
	end

	if self.controller then
		self.controller:Dispose()

		self.controller = nil
	end

	if self.sceneLoader then
		self.sceneLoader:Dispose(arg_18_1)

		self.sceneLoader = nil
	end

	return
end

function IslandCore:OnInit()
	return
end

function IslandCore:GetViewAndController(arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1
	local var_20_2 = arg_20_1:GetMapId()

	if var_20_2 == IslandConst.AGORA_MAP_ID then
		var_20_1 = AgoraController.New(self, arg_20_1)
		var_20_0 = AgoraView.New(self, var_20_1:GetAgora(), arg_20_2)
	elseif var_20_2 == IslandConst.CheaterTavernMapId then
		var_20_1 = CheaterTavernController.New(self, arg_20_1)
		var_20_0 = IslandCheaterTavernGameView.New(self, arg_20_2)
	elseif pg.island_map[var_20_2].minigame_id > 0 then
		var_20_0 = IslandSeekGameView.New(self, arg_20_2)
		var_20_1 = IslandController.New(self, arg_20_1)
	else
		var_20_1 = IslandController.New(self, arg_20_1)
		var_20_0 = IslandView.New(self, arg_20_2)
	end

	return var_20_0, var_20_1
end

return IslandCore
