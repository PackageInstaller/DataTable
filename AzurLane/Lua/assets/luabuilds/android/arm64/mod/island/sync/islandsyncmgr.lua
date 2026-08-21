local var_0_0 = class("IslandSyncMgr")

var_0_0.ISLAND_SYNC_DATA_UPDATE = "IslandSyncMgr.ISLAND_SYNC_DATA_UPDATE"
var_0_0.ISLAND_SYNC_OBJ_UPDATE = "IslandSyncMgr.ISLAND_SYNC_OBJ_UPDATE"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controlResultDic = {}
	arg_1_0.visitorDic = {}
	arg_1_0.unitDic = {}
	arg_1_0.controller = arg_1_1
	arg_1_0.island = arg_1_1.island
	arg_1_0.view = arg_1_1:GetCore().view
	arg_1_0.playerId = getProxy(PlayerProxy):getPlayerId()
	arg_1_0.syncDataDelayedProcessor = DelayedDataProcessor.New(IslandConst.SYNC_TIME_DELAY, IslandConst.SYNC_TIME_INTERVAL * 1000, function(arg_2_0)
		arg_1_0:UpdateVisitorSyncData(arg_2_0)

		return
	end)
	arg_1_0.syncObjDelayedProcessor = DelayedDataProcessor.New(IslandConst.SYNC_TIME_DELAY, IslandConst.SYNC_TIME_INTERVAL * 1000, function(arg_3_0)
		arg_1_0:UpdateSyncObj(arg_3_0)

		return
	end)
	arg_1_0.collectClientStateTimer = Timer.New(function()
		arg_1_0:UpdateLocalPlayer()

		return
	end, IslandConst.SYNC_TIME_INTERVAL, -1)

	return
end

function var_0_0.Op(arg_5_0, arg_5_1, ...)
	arg_5_0.controller:Receive(arg_5_1, ...)

	return
end

function var_0_0.Init(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:InitPlayer()
	arg_6_0:InitAgora(arg_6_2 or {})
	arg_6_0:InitWorldObject(arg_6_1)
	arg_6_0:InitSyncObj()
	arg_6_0.collectClientStateTimer:Start()

	return
end

function var_0_0.Update(arg_7_0)
	arg_7_0.syncDataDelayedProcessor:Update()
	arg_7_0.syncObjDelayedProcessor:Update()

	return
end

function var_0_0.IsPlayerInTimeline(arg_8_0)
	return arg_8_0.player and arg_8_0.player:InTimeline()
end

function var_0_0.InitPlayer(arg_9_0)
	arg_9_0.player = SyncLocalPlayer.New(arg_9_0.playerId, arg_9_0.view.player)

	return
end

function var_0_0.OnVisitorEnter(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.visitorDic[arg_10_1] = SyncUnitVisitor.New()

	return
end

function var_0_0.OnVisitorExit(arg_11_0, arg_11_1)
	if arg_11_0.visitorDic[arg_11_1] then
		local var_11_0 = arg_11_0.visitorDic[arg_11_1]:GetLastInteract()

		if var_11_0 then
			arg_11_0:GetUnit(var_11_0.type, var_11_0.id):RemoveOwner(arg_11_1)

			if var_11_0.type == IslandConst.SYNC_TYPE_AGORA then
				arg_11_0:Op("AgoraVirtualInterActionEndSync", var_11_0.id, arg_11_1)
			elseif var_11_0.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
				arg_11_0:Op("WorldObjectInterActionEndSync", var_11_0.id, arg_11_1)
			end
		end

		arg_11_0.syncDataDelayedProcessor:RemoveDataById(arg_11_1)
		arg_11_0.visitorDic[arg_11_1]:Dispose()

		arg_11_0.visitorDic[arg_11_1] = nil
	end

	return
end

function var_0_0.UpdateLocalPlayer(arg_12_0)
	if table.getCount(arg_12_0.visitorDic) <= 1 then
		return
	end

	local var_12_0 = {}

	if arg_12_0.player:IsLoaded() and not arg_12_0.player:InTimeline() then
		table.insert(var_12_0, (arg_12_0.player:CreateSyncData()))
	end

	if #var_12_0 > 0 then
		pg.m02:sendNotification(GAME.ISLAND_SYNC_DATA, {
			data = var_12_0,
			islandId = arg_12_0.island.id
		})
	end

	return
end

function var_0_0.HandleSyncData(arg_13_0, arg_13_1)
	_.each(arg_13_1, function(arg_14_0)
		arg_13_0.syncDataDelayedProcessor:Add(arg_14_0.id, arg_14_0)

		return
	end)

	return
end

function var_0_0.UpdateVisitorSyncData(arg_15_0, arg_15_1)
	if not arg_15_0.visitorDic[arg_15_1.id] then
		Debugger.LogWarning(string.format("访客不存在 id=%d", arg_15_1.id))

		return
	end

	arg_15_0:Op("SetVisitorSyncData", arg_15_1.id, arg_15_1)

	return
end

function var_0_0.SyncVisitorExist(arg_16_0, arg_16_1)
	return arg_16_0.visitorDic[arg_16_1] ~= nil
end

function var_0_0.InitAgora(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		({})[iter_17_0] = SyncUnitInteract.New(iter_17_0, IslandConst.SYNC_TYPE_AGORA)
	end

	arg_17_0.unitDic[IslandConst.SYNC_TYPE_AGORA] = {}

	return
end

function var_0_0.CancelAgoraInteract(arg_18_0)
	if not arg_18_0.unitDic[IslandConst.SYNC_TYPE_AGORA] then
		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.unitDic[IslandConst.SYNC_TYPE_AGORA]) do
		if iter_18_1:OwnerCount() > 0 then
			for iter_18_2, iter_18_3 in pairs(iter_18_1.owners) do
				arg_18_0:Op("AgoraVirtualInterActionEndSync", iter_18_0, iter_18_3)

				if iter_18_3 == arg_18_0.playerId then
					arg_18_0.player:SetInTimeline(false)
				end
			end
		end
	end

	return
end

function var_0_0.ResumeAgoraInteract(arg_19_0)
	if not arg_19_0.unitDic[IslandConst.SYNC_TYPE_AGORA] then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.unitDic[IslandConst.SYNC_TYPE_AGORA]) do
		if iter_19_1:OwnerCount() > 0 then
			for iter_19_2, iter_19_3 in pairs(iter_19_1.owners) do
				arg_19_0:Op("AgoraVirtualInterActionSync", iter_19_0, iter_19_3, iter_19_1.status, iter_19_2)
			end
		end
	end

	return
end

function var_0_0.ClearAgoraInteractData(arg_20_0)
	arg_20_0.unitDic[IslandConst.SYNC_TYPE_AGORA] = {}

	return
end

function var_0_0.InitWorldObject(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if iter_21_1.type == IslandConst.UNIT_TYPE_ITEM_INTERACT then
			({})[iter_21_1.id] = SyncUnitInteract.New(iter_21_1.id, IslandConst.SYNC_TYPE_UNIT_STATIC)
		end
	end

	arg_21_0.unitDic[IslandConst.SYNC_TYPE_UNIT_STATIC] = {}

	return
end

function var_0_0.InitSyncObj(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs((getProxy(IslandProxy):GetSyncObjInitData())) do
		local var_22_0 = arg_22_0:GetUnit(iter_22_1.type, iter_22_1.id)

		if var_22_0 then
			var_22_0:InitOwner(iter_22_1.slots)

			if var_22_0:OwnerCount() > 0 then
				for iter_22_2, iter_22_3 in pairs(var_22_0.owners) do
					if iter_22_3 ~= arg_22_0.playerId and arg_22_0.visitorDic[iter_22_3] then
						arg_22_0.visitorDic[iter_22_3]:RecordLastInteract(iter_22_1.id, iter_22_1.type)

						if iter_22_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
							arg_22_0:Op("WorldObjectInterActionSync", iter_22_1.id, iter_22_3, iter_22_1.status, iter_22_2)
						elseif iter_22_1.type == IslandConst.SYNC_TYPE_AGORA then
							arg_22_0:Op("AgoraVirtualInterActionSync", iter_22_1.id, iter_22_3, iter_22_1.status, iter_22_2)
						end
					end
				end
			elseif iter_22_1.status > 0 then
				if iter_22_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
					arg_22_0:Op("WorldObjectInitStatus", iter_22_1.id, iter_22_1.status)
				elseif iter_22_1.type == IslandConst.SYNC_TYPE_AGORA then
					arg_22_0:Op("AgoraVirtualInitStatus", iter_22_1.id, iter_22_1.status)
				end
			end
		end
	end

	return
end

function var_0_0.GetUnit(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0.unitDic[arg_23_1] then
		return nil
	end

	return arg_23_0.unitDic[arg_23_1][arg_23_2]
end

function var_0_0.HandleSyncObj(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		arg_24_0.syncObjDelayedProcessor:Add(iter_24_1.id, iter_24_1)
	end

	return
end

function var_0_0.UpdateSyncObj(arg_25_0, arg_25_1)
	arg_25_0:OnVisitorInteract(arg_25_1, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_25_0:GetUnit(arg_25_1.type, arg_25_1.id)

		if not var_26_0 then
			return
		end

		var_26_0:SetStatus(arg_25_1.status)

		if not arg_25_0:SyncVisitorExist(arg_26_0) then
			return
		end

		if arg_25_1.type == IslandConst.SYNC_TYPE_AGORA then
			arg_25_0:Op("AgoraVirtualInterActionSync", arg_25_1.id, arg_26_0, arg_25_1.status, arg_26_1)
		elseif arg_25_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
			arg_25_0:Op("WorldObjectInterActionSync", arg_25_1.id, arg_26_0, arg_25_1.status, arg_26_1)
		end

		return
	end, function(arg_27_0)
		if arg_25_1.type == IslandConst.SYNC_TYPE_AGORA then
			arg_25_0:Op("AgoraVirtualInterActionEndSync", arg_25_1.id, arg_27_0)
		elseif arg_25_1.type == IslandConst.SYNC_TYPE_UNIT_STATIC then
			arg_25_0:Op("WorldObjectInterActionEndSync", arg_25_1.id, arg_27_0)
		end

		return
	end)

	return
end

function var_0_0.OnVisitorInteract(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0:GetUnit(arg_28_1.type, arg_28_1.id)

	if not var_28_0 then
		return
	end

	local var_28_1, var_28_2, var_28_3 = var_28_0:UpdateOwner(arg_28_1.slots)

	if var_28_2 == arg_28_0.playerId then
		return
	end

	if not arg_28_0.visitorDic[var_28_2] then
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

function var_0_0.TryControlUnit(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	if arg_29_0:IsPlayerInTimeline() then
		arg_29_5(false)

		return
	end

	local var_29_0 = arg_29_0:GetUnit(arg_29_1, arg_29_2)

	arg_29_0:ControlUnit(arg_29_2, arg_29_3, 1, arg_29_4, arg_29_1, function(arg_30_0)
		if arg_30_0 then
			arg_29_0.player:SetInTimeline(true)
			var_29_0:SetStatus(arg_29_4)
		end

		arg_29_5(arg_30_0)

		return
	end)

	return
end

function var_0_0.EndControlUnit(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_0:ControlUnit(arg_31_2, arg_31_3, 0, arg_31_0:GetUnit(arg_31_1, arg_31_2):GetStatus(), arg_31_1, function(arg_32_0)
		if arg_32_0 then
			arg_31_0.player:SetInTimeline(false)
		end

		arg_31_4(arg_32_0)

		return
	end)

	return
end

function var_0_0.ControlUnit(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	if arg_33_0.controlResultDic[arg_33_1] then
		arg_33_6(false)

		return
	end

	arg_33_0.controlResultDic[arg_33_1] = arg_33_6

	pg.m02:sendNotification(GAME.ISLAND_SYNC_CONTROL, {
		islandId = arg_33_0.island.id,
		objId = arg_33_1,
		slotId = arg_33_2,
		op = arg_33_3,
		status = arg_33_4,
		type = arg_33_5,
		onResult = function(arg_34_0)
			existCall(arg_33_0.controlResultDic[arg_33_1], arg_34_0 == 0)

			arg_33_0.controlResultDic[arg_33_1] = nil

			return
		end
	})

	return
end

function var_0_0.Dispose(arg_35_0)
	arg_35_0.collectClientStateTimer:Stop()

	return
end

return var_0_0
