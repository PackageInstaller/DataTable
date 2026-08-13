class = var_0_10000

local var_0_0 = var_0_10000("IslandSyncMgr")

var_0_0.ISLAND_SYNC_DATA_UPDATE = "IslandSyncMgr.ISLAND_SYNC_DATA_UPDATE"
var_0_0.ISLAND_SYNC_OBJ_UPDATE = "IslandSyncMgr.ISLAND_SYNC_OBJ_UPDATE"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controlResultDic = {}
	arg_1_0.visitorDic = {}
	arg_1_0.unitDic = {}
	arg_1_0.controller = arg_1_1
	arg_1_0.island = arg_1_1.island

	local var_1_0 = arg_1_1

	arg_1_0.view = arg_1_1.GetCore(var_1_0).view
	getProxy = var_2
	PlayerProxy = var_1_0

	local var_1_1 = var_2(var_1_0)

	arg_1_0.playerId = var_2.getPlayerId(var_1_1)
	DelayedDataProcessor = var_2

	local var_1_2 = var_2.New

	IslandConst = var_1_1

	local var_1_3 = var_1_1.SYNC_TIME_DELAY

	IslandConst = var_1_10004
	arg_1_0.syncDataDelayedProcessor = var_1_2(var_1_3, var_1_10004.SYNC_TIME_INTERVAL * 1000, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.UpdateVisitorSyncData(var_2_0, arg_2_0)

		return
	end)
	DelayedDataProcessor = var_2

	local var_1_4 = var_2.New

	IslandConst = var_1_3

	local var_1_5 = var_1_3.SYNC_TIME_DELAY

	IslandConst = var_4
	arg_1_0.syncObjDelayedProcessor = var_1_4(var_1_5, var_4.SYNC_TIME_INTERVAL * 1000, function(arg_3_0)
		local var_3_0 = arg_1_0

		var_1.UpdateSyncObj(var_3_0, arg_3_0)

		return
	end)
	Timer = var_2

	local var_1_6 = var_2.New

	local function var_1_7()
		local var_4_0 = arg_1_0

		var_0.UpdateLocalPlayer(var_4_0)

		return
	end

	IslandConst = var_4
	arg_1_0.collectClientStateTimer = var_1_6(var_1_7, var_4.SYNC_TIME_INTERVAL, -1)

	return
end

function var_0_0.Op(arg_5_0, arg_5_1, ...)
	local var_5_0 = arg_5_0.controller

	var_2.Receive(var_5_0, arg_5_1, ...)

	return
end

function var_0_0.Init(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:InitPlayer()
	arg_6_0:InitAgora(arg_6_2 or {})
	arg_6_0:InitWorldObject(arg_6_1)
	arg_6_0:InitSyncObj()

	local var_6_0 = arg_6_0.collectClientStateTimer

	var_3.Start(var_6_0)

	return
end

function var_0_0.Update(arg_7_0)
	local var_7_0 = arg_7_0.syncDataDelayedProcessor

	var_1.Update(var_7_0)

	local var_7_1 = arg_7_0.syncObjDelayedProcessor

	var_1.Update(var_7_1)

	return
end

function var_0_0.IsPlayerInTimeline(arg_8_0)
	local var_8_1

	if arg_8_0.player then
		local var_8_0 = arg_8_0.player

		var_8_1 = var_1.InTimeline(var_8_0)
	end

	return var_8_1
end

function var_0_0.InitPlayer(arg_9_0)
	SyncLocalPlayer = var_1_10001
	arg_9_0.player = var_1_10001.New(arg_9_0.playerId, arg_9_0.view.player)

	return
end

function var_0_0.OnVisitorEnter(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.visitorDic

	SyncUnitVisitor = var_1_10004
	var_10_0[arg_10_1] = var_1_10004.New()

	return
end

function var_0_0.OnVisitorExit(arg_11_0, arg_11_1)
	if arg_11_0.visitorDic[arg_11_1] then
		if var_2:GetLastInteract() then
			local var_11_0 = arg_11_0:GetUnit(var_3.type, var_3.id)

			var_4.RemoveOwner(var_11_0, arg_11_1)

			local var_11_1 = var_3.type

			IslandConst = var_11_0

			local var_11_2

			if var_11_1 == var_11_0.SYNC_TYPE_AGORA then
				var_11_2 = arg_11_0

				arg_11_0.Op(var_11_2, "AgoraVirtualInterActionEndSync", var_3.id, arg_11_1)
			else
				local var_11_3 = var_3.type

				IslandConst = var_11_2

				if var_11_3 == var_11_2.SYNC_TYPE_UNIT_STATIC then
					arg_11_0:Op("WorldObjectInterActionEndSync", var_3.id, arg_11_1)
				end
			end
		end

		local var_11_4 = arg_11_0.syncDataDelayedProcessor

		var_4.RemoveDataById(var_11_4, arg_11_1)
		var_2:Dispose()

		arg_11_0.visitorDic[arg_11_1] = nil
	end

	return
end

function var_0_0.UpdateLocalPlayer(arg_12_0)
	table = var_1_10001

	if var_1_10001.getCount(arg_12_0.visitorDic) <= 1 then
		return
	end

	local var_12_0 = {}
	local var_12_1 = arg_12_0.player

	if var_2.IsLoaded(var_12_1) then
		local var_12_2 = arg_12_0.player

		if not var_2.InTimeline(var_12_2) then
			local var_12_3 = arg_12_0.player
			local var_12_4 = var_2.CreateSyncData(var_12_3)

			table = var_12_3

			var_12_3.insert(var_12_0, var_12_4)
		end
	end

	if #var_12_0 > 0 then
		pg = var_2

		local var_12_5 = var_2.m02
		local var_12_6 = var_2.sendNotification

		GAME = var_1_10004

		var_12_6(var_12_5, var_1_10004.ISLAND_SYNC_DATA, {
			data = var_12_0,
			islandId = arg_12_0.island.id
		})
	end

	return
end

function var_0_0.HandleSyncData(arg_13_0, arg_13_1)
	_ = var_1_10002

	var_1_10002.each(arg_13_1, function(arg_14_0)
		local var_14_0 = arg_14_0.id
		local var_14_1 = arg_13_0.syncDataDelayedProcessor

		var_2.Add(var_14_1, var_14_0, arg_14_0)

		return
	end)

	return
end

function var_0_0.UpdateVisitorSyncData(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.id

	if not arg_15_0.visitorDic[var_15_0] then
		Debugger = var_1_10004

		local var_15_1 = var_1_10004.LogWarning

		string = var_1_10005

		var_15_1(var_1_10005.format("访客不存在 id=%d", var_15_0))

		return
	end

	arg_15_0:Op("SetVisitorSyncData", var_15_0, arg_15_1)

	return
end

function var_0_0.SyncVisitorExist(arg_16_0, arg_16_1)
	return arg_16_0.visitorDic[arg_16_1] ~= nil
end

function var_0_0.InitAgora(arg_17_0, arg_17_1)
	local var_17_0 = {}

	pairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_1) do
		SyncUnitInteract = var_1_10008
		var_1_10008 = var_1_10008.New

		local var_17_1 = iter_17_0

		IslandConst = var_1_10010
		var_17_0[iter_17_0] = var_1_10008(var_17_1, var_1_10010.SYNC_TYPE_AGORA)
	end

	local var_17_2 = arg_17_0.unitDic

	IslandConst = var_4
	var_17_2[var_4.SYNC_TYPE_AGORA] = var_17_0

	return
end

function var_0_0.CancelAgoraInteract(arg_18_0)
	local var_18_0 = arg_18_0.unitDic

	IslandConst = var_1_10002

	if not var_18_0[var_1_10002.SYNC_TYPE_AGORA] then
		return
	end

	pairs = var_2

	for iter_18_0, iter_18_1 in var_2(var_1) do
		if iter_18_1:OwnerCount() > 0 then
			pairs = var_7

			for iter_18_2, iter_18_3 in var_7(iter_18_1.owners) do
				arg_18_0:Op("AgoraVirtualInterActionEndSync", iter_18_0, iter_18_3)

				if iter_18_3 == arg_18_0.playerId then
					local var_18_1 = arg_18_0.player

					var_12.SetInTimeline(var_18_1, false)
				end
			end
		end
	end

	return
end

function var_0_0.ResumeAgoraInteract(arg_19_0)
	local var_19_0 = arg_19_0.unitDic

	IslandConst = var_1_10002

	if not var_19_0[var_1_10002.SYNC_TYPE_AGORA] then
		return
	end

	pairs = var_2

	for iter_19_0, iter_19_1 in var_2(var_1) do
		if iter_19_1:OwnerCount() > 0 then
			pairs = var_7

			for iter_19_2, iter_19_3 in var_7(iter_19_1.owners) do
				arg_19_0:Op("AgoraVirtualInterActionSync", iter_19_0, iter_19_3, iter_19_1.status, iter_19_2)
			end
		end
	end

	return
end

function var_0_0.ClearAgoraInteractData(arg_20_0)
	local var_20_0 = arg_20_0.unitDic

	IslandConst = var_1_10002
	var_20_0[var_1_10002.SYNC_TYPE_AGORA] = {}

	return
end

function var_0_0.InitWorldObject(arg_21_0, arg_21_1)
	local var_21_0 = {}

	ipairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(arg_21_1) do
		local var_21_1 = iter_21_1.type

		IslandConst = var_1_10009

		if var_21_1 == var_1_10009.UNIT_TYPE_ITEM_INTERACT then
			local var_21_2 = iter_21_1.id

			SyncUnitInteract = var_1_10009
			var_1_10009 = var_1_10009.New

			local var_21_3 = iter_21_1.id

			IslandConst = var_1_10011
			var_21_0[var_21_2] = var_1_10009(var_21_3, var_1_10011.SYNC_TYPE_UNIT_STATIC)
		end
	end

	local var_21_4 = arg_21_0.unitDic

	IslandConst = var_4
	var_21_4[var_4.SYNC_TYPE_UNIT_STATIC] = var_21_0

	return
end

function var_0_0.InitSyncObj(arg_22_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_22_0 = var_1_10001(var_1_10002)
	local var_22_1 = var_1.GetSyncObjInitData(var_22_0)

	ipairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(var_22_1) do
		if arg_22_0:GetUnit(iter_22_1.type, iter_22_1.id) then
			var_7:InitOwner(iter_22_1.slots)

			if var_7:OwnerCount() > 0 then
				pairs = var_8

				for iter_22_2, iter_22_3 in var_8(var_7.owners) do
					if iter_22_3 ~= arg_22_0.playerId and arg_22_0.visitorDic[iter_22_3] then
						local var_22_2 = arg_22_0.visitorDic[iter_22_3]

						var_13.RecordLastInteract(var_22_2, iter_22_1.id, iter_22_1.type)

						local var_22_3 = iter_22_1.type

						IslandConst = var_22_2

						local var_22_4

						if var_22_3 == var_22_2.SYNC_TYPE_UNIT_STATIC then
							var_22_4 = arg_22_0

							arg_22_0.Op(var_22_4, "WorldObjectInterActionSync", iter_22_1.id, iter_22_3, iter_22_1.status, iter_22_2)
						else
							local var_22_5 = iter_22_1.type

							IslandConst = var_22_4

							if var_22_5 == var_22_4.SYNC_TYPE_AGORA then
								arg_22_0:Op("AgoraVirtualInterActionSync", iter_22_1.id, iter_22_3, iter_22_1.status, iter_22_2)
							end
						end
					end
				end
			else
				local var_22_6 = iter_22_1.status

				if 0 < var_22_6 then
					local var_22_7 = iter_22_1.type

					IslandConst = var_9

					local var_22_8

					if var_22_7 == var_9.SYNC_TYPE_UNIT_STATIC then
						var_22_8 = arg_22_0

						arg_22_0.Op(var_22_8, "WorldObjectInitStatus", iter_22_1.id, iter_22_1.status)
					else
						local var_22_9 = iter_22_1.type

						IslandConst = var_22_8

						if var_22_9 == var_22_8.SYNC_TYPE_AGORA then
							arg_22_0:Op("AgoraVirtualInitStatus", iter_22_1.id, iter_22_1.status)
						end
					end
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
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_1) do
		local var_24_0 = arg_24_0.syncObjDelayedProcessor

		var_7.Add(var_24_0, iter_24_1.id, iter_24_1)
	end

	return
end

function var_0_0.UpdateSyncObj(arg_25_0, arg_25_1)
	arg_25_0:OnVisitorInteract(arg_25_1, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_25_0

		if not var_2.GetUnit(var_26_0, arg_25_1.type, arg_25_1.id) then
			return
		end

		var_2:SetStatus(arg_25_1.status)

		local var_26_1 = arg_25_0

		if not var_3.SyncVisitorExist(var_26_1, arg_26_0) then
			return
		end

		local var_26_2 = arg_25_1.type

		IslandConst = var_26_1

		local var_26_3

		if var_26_2 == var_26_1.SYNC_TYPE_AGORA then
			var_26_3 = arg_25_0

			var_3.Op(var_26_3, "AgoraVirtualInterActionSync", arg_25_1.id, arg_26_0, arg_25_1.status, arg_26_1)
		else
			local var_26_4 = arg_25_1.type

			IslandConst = var_26_3

			if var_26_4 == var_26_3.SYNC_TYPE_UNIT_STATIC then
				local var_26_5 = arg_25_0

				var_3.Op(var_26_5, "WorldObjectInterActionSync", arg_25_1.id, arg_26_0, arg_25_1.status, arg_26_1)
			end
		end

		return
	end, function(arg_27_0)
		local var_27_0 = arg_25_1.type

		IslandConst = var_2_10002

		local var_27_1

		if var_27_0 == var_2_10002.SYNC_TYPE_AGORA then
			var_27_1 = arg_25_0

			var_1.Op(var_27_1, "AgoraVirtualInterActionEndSync", arg_25_1.id, arg_27_0)
		else
			local var_27_2 = arg_25_1.type

			IslandConst = var_27_1

			if var_27_2 == var_27_1.SYNC_TYPE_UNIT_STATIC then
				local var_27_3 = arg_25_0

				var_1.Op(var_27_3, "WorldObjectInterActionEndSync", arg_25_1.id, arg_27_0)
			end
		end

		return
	end)

	return
end

function var_0_0.OnVisitorInteract(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if not arg_28_0:GetUnit(arg_28_1.type, arg_28_1.id) then
		return
	end

	local var_28_0, var_28_1, var_28_2 = var_4:UpdateOwner(arg_28_1.slots)

	if var_28_1 == arg_28_0.playerId then
		return
	end

	if not arg_28_0.visitorDic[var_28_1] then
		warning = var_1_10009

		var_1_10009("访客不存在 id=", var_28_1)

		return
	end

	if var_28_0 then
		var_8:RecordLastInteract(arg_28_1.id, arg_28_1.type)
		arg_28_2(var_28_1, var_28_2)
	else
		var_8:ClearLastInteract()
		arg_28_3(var_28_1)
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
			local var_30_0 = arg_29_0.player

			var_1.SetInTimeline(var_30_0, true)

			local var_30_1 = var_29_0

			var_1.SetStatus(var_30_1, arg_29_4)
		end

		arg_29_5(arg_30_0)

		return
	end)

	return
end

function var_0_0.EndControlUnit(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = arg_31_0:GetUnit(arg_31_1, arg_31_2)

	arg_31_0:ControlUnit(arg_31_2, arg_31_3, 0, var_31_0:GetStatus(), arg_31_1, function(arg_32_0)
		if arg_32_0 then
			local var_32_0 = arg_31_0.player

			var_1.SetInTimeline(var_32_0, false)
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

	local var_33_0 = arg_33_0.controlResultDic

	var_33_0[arg_33_1] = arg_33_6
	pg = var_33_0

	local var_33_1 = var_33_0.m02
	local var_33_2 = var_7.sendNotification

	GAME = var_1_10009

	var_33_2(var_33_1, var_1_10009.ISLAND_SYNC_CONTROL, {
		islandId = arg_33_0.island.id,
		objId = arg_33_1,
		slotId = arg_33_2,
		op = arg_33_3,
		status = arg_33_4,
		type = arg_33_5,
		onResult = function(arg_34_0)
			local var_34_0 = arg_34_0 == 0

			existCall = var_2_10002

			var_2_10002(arg_33_0.controlResultDic[arg_33_1], var_34_0)

			arg_33_0.controlResultDic[arg_33_1] = nil

			return
		end
	})

	return
end

function var_0_0.Dispose(arg_35_0)
	local var_35_0 = arg_35_0.collectClientStateTimer

	var_1.Stop(var_35_0)

	return
end

return var_0_0
