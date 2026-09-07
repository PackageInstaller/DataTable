local IslandSyncMgr = class("IslandSyncMgr")

IslandSyncMgr.ISLAND_SYNC_DATA_UPDATE = "IslandSyncMgr.ISLAND_SYNC_DATA_UPDATE"
IslandSyncMgr.ISLAND_SYNC_OBJ_UPDATE = "IslandSyncMgr.ISLAND_SYNC_OBJ_UPDATE"

function IslandSyncMgr:Ctor(arg_1_1)
	self.controlResultDic = {}
	self.visitorDic = {}
	self.unitDic = {}
	self.controller = arg_1_1
	self.island = arg_1_1.island
	self.view = arg_1_1:GetCore().view
	self.playerId = getProxy(PlayerProxy):getPlayerId()
	self.syncDataDelayedProcessor = DelayedDataProcessor.New(IslandConst.SYNC_TIME_DELAY, IslandConst.SYNC_TIME_INTERVAL * 1000, function(arg_2_0)
		self:UpdateVisitorSyncData(arg_2_0)

		return
	end)
	self.syncObjDelayedProcessor = DelayedDataProcessor.New(IslandConst.SYNC_TIME_DELAY, IslandConst.SYNC_TIME_INTERVAL * 1000, function(arg_3_0)
		self:UpdateSyncObj(arg_3_0)

		return
	end)
	self.collectClientStateTimer = Timer.New(function()
		self:UpdateLocalPlayer()

		return
	end, IslandConst.SYNC_TIME_INTERVAL, -1)

	return
end

function IslandSyncMgr:Op(arg_5_1, ...)
	self.controller:Receive(arg_5_1, ...)

	return
end

function IslandSyncMgr:Init(arg_6_1, arg_6_2)
	self:InitPlayer()
	self:InitAgora(arg_6_2 or {})
	self:InitWorldObject(arg_6_1)
	self:InitSyncObj()
	self.collectClientStateTimer:Start()

	return
end

function IslandSyncMgr:Update()
	self.syncDataDelayedProcessor:Update()
	self.syncObjDelayedProcessor:Update()

	return
end

function IslandSyncMgr:IsPlayerInTimeline()
	return self.player and self.player:InTimeline()
end

function IslandSyncMgr:InitPlayer()
	self.player = SyncLocalPlayer.New(self.playerId, self.view.player)

	return
end

function IslandSyncMgr:OnVisitorEnter(arg_10_1, arg_10_2)
	self.visitorDic[arg_10_1] = SyncUnitVisitor.New()

	return
end

function IslandSyncMgr:OnVisitorExit(arg_11_1)
	if self.visitorDic[arg_11_1] then
		local var_11_0 = self.visitorDic[arg_11_1]:GetLastInteract()

		if var_11_0 then
			self:GetUnit(var_11_0.type, var_11_0.id):RemoveOwner(arg_11_1)

			if var_11_0.type == IslandConst.SYNC_TYPE_AGORA then
				self:Op("AgoraVirtualInterActionEndSync", var_11_0.id, arg_11_1)
			elseif var_11_0.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
				self:Op("WorldObjectInterActionEndSync", var_11_0.id, arg_11_1)
			end
		end

		self.syncDataDelayedProcessor:RemoveDataById(arg_11_1)
		self.visitorDic[arg_11_1]:Dispose()

		self.visitorDic[arg_11_1] = nil
	end

	return
end

function IslandSyncMgr:UpdateLocalPlayer()
	if table.getCount(self.visitorDic) <= 1 then
		return
	end

	local var_12_0 = {}

	if self.player:IsLoaded() and not self.player:InTimeline() then
		table.insert(var_12_0, (self.player:CreateSyncData()))
	end

	if #var_12_0 > 0 then
		pg.m02:sendNotification(GAME.ISLAND_SYNC_DATA, {
			data = var_12_0,
			islandId = self.island.id
		})
	end

	return
end

function IslandSyncMgr:HandleSyncData(arg_13_1)
	_.each(arg_13_1, function(arg_14_0)
		self.syncDataDelayedProcessor:Add(arg_14_0.id, arg_14_0)

		return
	end)

	return
end

function IslandSyncMgr:UpdateVisitorSyncData(arg_15_1)
	if not self.visitorDic[arg_15_1.id] then
		Debugger.LogWarning(string.format("访客不存在 id=%d", arg_15_1.id))

		return
	end

	self:Op("SetVisitorSyncData", arg_15_1.id, arg_15_1)

	return
end

function IslandSyncMgr:SyncVisitorExist(arg_16_1)
	return self.visitorDic[arg_16_1] ~= nil
end

function IslandSyncMgr:InitAgora(arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		var_17_0[iter_17_0] = SyncUnitInteract.New(iter_17_0, IslandConst.SYNC_TYPE_AGORA)
	end

	self.unitDic[IslandConst.SYNC_TYPE_AGORA] = var_17_0

	return
end

function IslandSyncMgr:CancelAgoraInteract()
	if not self.unitDic[IslandConst.SYNC_TYPE_AGORA] then
		return
	end

	for iter_18_0, iter_18_1 in pairs(self.unitDic[IslandConst.SYNC_TYPE_AGORA]) do
		if iter_18_1:OwnerCount() > 0 then
			for iter_18_2, iter_18_3 in pairs(iter_18_1.owners) do
				self:Op("AgoraVirtualInterActionEndSync", iter_18_0, iter_18_3)

				if iter_18_3 == self.playerId then
					self.player:SetInTimeline(false)
				end
			end
		end
	end

	return
end

function IslandSyncMgr:ResumeAgoraInteract()
	if not self.unitDic[IslandConst.SYNC_TYPE_AGORA] then
		return
	end

	for iter_19_0, iter_19_1 in pairs(self.unitDic[IslandConst.SYNC_TYPE_AGORA]) do
		if iter_19_1:OwnerCount() > 0 then
			for iter_19_2, iter_19_3 in pairs(iter_19_1.owners) do
				self:Op("AgoraVirtualInterActionSync", iter_19_0, iter_19_3, iter_19_1.status, iter_19_2)
			end
		end
	end

	return
end

function IslandSyncMgr:ClearAgoraInteractData()
	self.unitDic[IslandConst.SYNC_TYPE_AGORA] = {}

	return
end

function IslandSyncMgr:InitWorldObject(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if iter_21_1.type == IslandConst.UNIT_TYPE_ITEM_INTERACT then
			var_21_0[iter_21_1.id] = SyncUnitInteract.New(iter_21_1.id, IslandConst.SYNC_TYPE_UNIT_STATIC)
		end
	end

	self.unitDic[IslandConst.SYNC_TYPE_UNIT_STATIC] = var_21_0

	return
end

function IslandSyncMgr:InitSyncObj()
	for iter_22_0, iter_22_1 in ipairs((getProxy(IslandProxy):GetSyncObjInitData())) do
		local var_22_0 = self:GetUnit(iter_22_1.type, iter_22_1.id)

		if var_22_0 then
			var_22_0:InitOwner(iter_22_1.slots)

			if var_22_0:OwnerCount() > 0 then
				for iter_22_2, iter_22_3 in pairs(var_22_0.owners) do
					if iter_22_3 ~= self.playerId and self.visitorDic[iter_22_3] then
						self.visitorDic[iter_22_3]:RecordLastInteract(iter_22_1.id, iter_22_1.type)

						if iter_22_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
							self:Op("WorldObjectInterActionSync", iter_22_1.id, iter_22_3, iter_22_1.status, iter_22_2)
						elseif iter_22_1.type == IslandConst.SYNC_TYPE_AGORA then
							self:Op("AgoraVirtualInterActionSync", iter_22_1.id, iter_22_3, iter_22_1.status, iter_22_2)
						end
					end
				end
			elseif iter_22_1.status > 0 then
				if iter_22_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
					self:Op("WorldObjectInitStatus", iter_22_1.id, iter_22_1.status)
				elseif iter_22_1.type == IslandConst.SYNC_TYPE_AGORA then
					self:Op("AgoraVirtualInitStatus", iter_22_1.id, iter_22_1.status)
				end
			end
		end
	end

	return
end

function IslandSyncMgr:GetUnit(arg_23_1, arg_23_2)
	if not self.unitDic[arg_23_1] then
		return nil
	end

	return self.unitDic[arg_23_1][arg_23_2]
end

function IslandSyncMgr:HandleSyncObj(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		self.syncObjDelayedProcessor:Add(iter_24_1.id, iter_24_1)
	end

	return
end

function IslandSyncMgr:UpdateSyncObj(arg_25_1)
	self:OnVisitorInteract(arg_25_1, function(arg_26_0, arg_26_1)
		local var_26_0 = self:GetUnit(arg_25_1.type, arg_25_1.id)

		if not var_26_0 then
			return
		end

		var_26_0:SetStatus(arg_25_1.status)

		if not self:SyncVisitorExist(arg_26_0) then
			return
		end

		if arg_25_1.type == IslandConst.SYNC_TYPE_AGORA then
			self:Op("AgoraVirtualInterActionSync", arg_25_1.id, arg_26_0, arg_25_1.status, arg_26_1)
		elseif arg_25_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
			self:Op("WorldObjectInterActionSync", arg_25_1.id, arg_26_0, arg_25_1.status, arg_26_1)
		end

		return
	end, function(arg_27_0)
		if arg_25_1.type == IslandConst.SYNC_TYPE_AGORA then
			self:Op("AgoraVirtualInterActionEndSync", arg_25_1.id, arg_27_0)
		elseif arg_25_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
			self:Op("WorldObjectInterActionEndSync", arg_25_1.id, arg_27_0)
		end

		return
	end)

	return
end

function IslandSyncMgr:OnVisitorInteract(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = self:GetUnit(arg_28_1.type, arg_28_1.id)

	if not var_28_0 then
		return
	end

	local var_28_1, var_28_2, var_28_3 = var_28_0:UpdateOwner(arg_28_1.slots)

	if var_28_2 == self.playerId then
		return
	end

	local var_28_4 = self.visitorDic[var_28_2]

	if not self.visitorDic[var_28_2] then
		warning("访客不存在 id=", var_28_2)

		return
	end

	if var_28_1 then
		var_28_4:RecordLastInteract(arg_28_1.id, arg_28_1.type)
		arg_28_2(var_28_2, var_28_3)
	else
		var_28_4:ClearLastInteract()
		arg_28_3(var_28_2)
	end

	return
end

function IslandSyncMgr:TryControlUnit(arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	if self:IsPlayerInTimeline() then
		arg_29_5(false)

		return
	end

	local var_29_0 = self:GetUnit(arg_29_1, arg_29_2)

	self:ControlUnit(arg_29_2, arg_29_3, 1, arg_29_4, arg_29_1, function(arg_30_0)
		if arg_30_0 then
			self.player:SetInTimeline(true)
			var_29_0:SetStatus(arg_29_4)
		end

		arg_29_5(arg_30_0)

		return
	end)

	return
end

function IslandSyncMgr:EndControlUnit(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self:ControlUnit(arg_31_2, arg_31_3, 0, self:GetUnit(arg_31_1, arg_31_2):GetStatus(), arg_31_1, function(arg_32_0)
		if arg_32_0 then
			self.player:SetInTimeline(false)
		end

		arg_31_4(arg_32_0)

		return
	end)

	return
end

function IslandSyncMgr:ControlUnit(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	if self.controlResultDic[arg_33_1] then
		arg_33_6(false)

		return
	end

	self.controlResultDic[arg_33_1] = arg_33_6

	pg.m02:sendNotification(GAME.ISLAND_SYNC_CONTROL, {
		islandId = self.island.id,
		objId = arg_33_1,
		slotId = arg_33_2,
		op = arg_33_3,
		status = arg_33_4,
		type = arg_33_5,
		onResult = function(arg_34_0)
			existCall(self.controlResultDic[arg_33_1], arg_34_0 == 0)

			self.controlResultDic[arg_33_1] = nil

			return
		end
	})

	return
end

function IslandSyncMgr:Dispose()
	self.collectClientStateTimer:Stop()

	return
end

return IslandSyncMgr
