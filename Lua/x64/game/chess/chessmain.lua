local var_0_0 = singletonClass("ChessMain")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.eventData_ = {}
	arg_1_0.finalChess_ = {}
	arg_1_0.IsExecuting_ = false
	arg_1_0.ExecutingChess_ = nil
	arg_1_0.chessEntities_ = {}
	arg_1_0.cachePath_ = {}
	arg_1_0.battleStart_ = false
	arg_1_0.battleResult_ = false
	arg_1_0.mutiTimes_ = nil
	arg_1_0.selectGrid_ = nil
	arg_1_0.map_ = nil
	arg_1_0.bulletDirection_ = nil
	arg_1_0.bulletEvent_ = 0
	arg_1_0.eventQueueManager_ = ChessEventQueue.New()
	arg_1_0.current = ChessCurrentModel.New(arg_1_0.blockerManager_)
	arg_1_0.forceBattle = ChessForceBattleModel.New()
	arg_1_0.mutiBattle = ChessMutiBattleModel.New()
	arg_1_0.characterPos_ = nil
	arg_1_0.curStoneGirdData_ = nil
	arg_1_0.movedStoneGridData_ = nil
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.blockerManager_ = ChessBlockerManager.New(manager.ui.canvas)
	arg_2_0.globalEventManager_ = ChessGlobalEventManager.New(arg_2_0)

	arg_2_0:LoadMap(arg_2_1)
	arg_2_0.current:SetUp(arg_2_0.blockerManager_)
	arg_2_0.forceBattle:SetUp(arg_2_0.map_.width)
	arg_2_0.mutiBattle:SetUp(arg_2_0.map_.width)

	local var_2_0 = WarChessData:GetButterFlyPos()

	if var_2_0 then
		ChessLuaBridge.InitGuider(WarChessTools.GetGuiderAssetPath(arg_2_1), var_2_0[1], var_2_0[2])
	end

	if not table.indexof(WarchessLevelCfg[arg_2_1].extra_gameplay, 2) then
		local var_2_1 = WarChessData:GetCurrentIndex()

		arg_2_0.characterPos_ = {
			var_2_1.x,
			var_2_1.z
		}
	end
end

function var_0_0.IsExecuting(arg_3_0)
	return arg_3_0.IsExecuting_
end

function var_0_0.ExecutingChess(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_2.typeID
	local var_4_1 = arg_4_2.status

	if arg_4_1 == ChessConst.TIMING_WALK and not ChessTools.IsWalkEvent(var_4_0, var_4_1) then
		arg_4_3 = ChessTools.ParseEventPollCfg({
			{
				10000
			}
		})

		arg_4_0.eventQueueManager_:InsertNewEventQueue(arg_4_3, arg_4_1, arg_4_2)
	elseif arg_4_1 == ChessConst.TIMING_CURRENT and not ChessTools.IsWalkEvent(var_4_0, var_4_1) then
		arg_4_3 = ChessTools.ParseEventPollCfg({
			{
				10000
			}
		})

		arg_4_0.eventQueueManager_:InsertNewEventQueue(arg_4_3, arg_4_1, arg_4_2)
	else
		arg_4_0:CreateEventQueue(arg_4_2, arg_4_3, arg_4_1)
	end

	if arg_4_0.eventQueueManager_:CurEventTiming() then
		return
	end

	if arg_4_0.eventQueueManager_:PromoteToNextEvent() then
		arg_4_0:DoNextEvent()
	else
		arg_4_0:EventsEnd()
	end
end

function var_0_0.LoadMap(arg_5_0, arg_5_1)
	arg_5_0.ChapterID = arg_5_1

	if arg_5_0.map_ then
		return
	end

	WarChessData:SetStartTime(manager.time:GetServerTime())

	arg_5_0.map_ = ChessTools.LoadMap(arg_5_1)

	if not arg_5_0.map_ then
		-- block empty
	end

	local var_5_0 = {}

	WarChessData:SetExtendMap(arg_5_0.map_.extendInfo)
	WarChessData:SetJsonMap(var_5_0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.map_.mapInfo) do
		local var_5_1 = iter_5_1.x
		local var_5_2 = iter_5_1.z

		var_5_0[ChessTools.TwoDToOneD(var_5_1, var_5_2)] = iter_5_1
	end

	local var_5_3 = WarChessData:GetCurrentWarChessMapData().mapChangeInfo

	for iter_5_2, iter_5_3 in pairs(var_5_3) do
		local var_5_4 = iter_5_3.pos.x
		local var_5_5 = iter_5_3.pos.z
		local var_5_6 = var_5_0[ChessTools.TwoDToOneD(var_5_4, var_5_5)]

		arg_5_0:CreateChess(var_5_6, iter_5_3.status)
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_0.map_.mapInfo) do
		arg_5_0:CreateChess(iter_5_5, iter_5_5.status)
	end
end

function var_0_0.CachePath(arg_6_0, arg_6_1)
	arg_6_0.cachePath_ = arg_6_1
end

function var_0_0.InsertGlobalEventList(arg_7_0, arg_7_1)
	arg_7_0.globalEventManager_:InsertGlobalEventList(arg_7_1)
end

function var_0_0.ClearGlobalEventByType(arg_8_0, arg_8_1)
	arg_8_0.globalEventManager_:ClearGlobalEventByType(arg_8_1)
end

function var_0_0.GetExecutingChess(arg_9_0)
	return arg_9_0.eventQueueManager_:GetExecutingChess()
end

function var_0_0.CreateEventQueue(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1.paramList[0]

	if not WarchessEventPoolCfg[var_10_0] then
		-- block empty
	end

	arg_10_0.eventQueueManager_:InsertNewEventQueue(arg_10_2, arg_10_3, arg_10_1)
end

function var_0_0.InsertEventQueue(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == "GLOBAL" then
		arg_11_0.eventQueueManager_:InsertNewEventQueue(arg_11_1, "GLOBAL")
	else
		arg_11_0.eventQueueManager_:InsertCurEventQueue(arg_11_1)
	end
end

function var_0_0.DoNextEvent(arg_12_0)
	local var_12_0 = arg_12_0.eventQueueManager_:LastEventID()

	if var_12_0 then
		WarChessData:ExecuteEventOneTime(var_12_0)
	end

	if arg_12_0.eventQueueManager_:IsEventEnd() then
		arg_12_0:EventsEnd()

		return
	end

	local var_12_1, var_12_2 = arg_12_0.eventQueueManager_:GetCurFunc()

	arg_12_0.eventQueueManager_:PromoteCurEventProgress()

	return var_12_1(unpack(var_12_2))
end

function var_0_0.EventsEnd(arg_13_0)
	local var_13_0 = arg_13_0.eventQueueManager_:CurEventTiming()

	if var_13_0 == ChessConst.TIMING_INTERACT then
		arg_13_0.IsExecuting_ = false
		arg_13_0.ExecutingChess_ = nil
	end

	if var_13_0 ~= nil then
		arg_13_0.globalEventManager_:ExecuteGlobalEvent(var_13_0)
	end

	if arg_13_0.eventQueueManager_:PromoteToNextEvent() then
		arg_13_0:DoNextEvent()
	else
		arg_13_0.eventQueueManager_:Clear()

		if WarChessData:GetStoneIsMoving() then
			ChessLuaBridge.StoneContinueMove()
		end
	end
end

function var_0_0.CreateChess(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ChessTools.ParseParameter(arg_14_1, true)
	local var_14_1 = ChessTools.TwoDToOneD(arg_14_1.x, arg_14_1.z)

	if arg_14_0.chessEntities_[var_14_1] then
		return
	end

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if ChessTools.IsSavingEvent(iter_14_1.eventID) then
			arg_14_0.chessEntities_[var_14_1] = {
				x = arg_14_1.x,
				z = arg_14_1.z
			}

			return
		end
	end
end

function var_0_0.ExecutingCreatedChess(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.chessEntities_) do
		local var_15_0 = ChessLuaBridge.GetGridData(iter_15_1.x, iter_15_1.z)
		local var_15_1 = ChessTools.ParseParameter(var_15_0)

		for iter_15_2, iter_15_3 in pairs(var_15_1) do
			local var_15_2 = ChessEventConfig[iter_15_3.eventID][arg_15_1]

			if var_15_2 then
				var_15_2(iter_15_0, iter_15_1, unpack(iter_15_3.params))
			end
		end
	end
end

function var_0_0.SetPosition(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.characterPos_ and arg_16_0.characterPos_[1] == arg_16_1 and arg_16_0.characterPos_[2] == arg_16_2 then
		return false
	end

	WarChessData:SetCurrentIndex(arg_16_1, arg_16_2)

	arg_16_0.characterPos_ = {
		arg_16_1,
		arg_16_2
	}

	return true
end

function var_0_0.SetInteractChess(arg_17_0, arg_17_1)
	arg_17_0.IsExecuting_ = true
	arg_17_0.ExecutingChess_ = arg_17_1
end

function var_0_0.ExecuteMove(arg_18_0)
	WarChessAction.RoleMoveByPath(arg_18_0.cachePath_, function(arg_19_0)
		if not isSuccess(arg_19_0) then
			ShowTips(arg_19_0)
			ChessLuaBridge.ClearCachePath()
		else
			manager.notify:CallUpdateFunc(CAMERA_MOVE, false)
			ChessLuaBridge.MoveToCachePos()
			arg_18_0.blockerManager_:ShowBlocker()
		end
	end)
end

function var_0_0.OnMoveEnd(arg_20_0)
	arg_20_0.blockerManager_:HideBlocker()
	arg_20_0:SetGridSelectOutline(nil, nil, false)
end

function var_0_0.StopMove(arg_21_0)
	manager.audio:StopEffect()

	arg_21_0.stopMove_ = true
end

function var_0_0.IsStopMove(arg_22_0)
	if arg_22_0.stopMove_ then
		arg_22_0.stopMove_ = false

		return true
	end

	return false
end

function var_0_0.ExecuteChessTiming(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2.gridData
	local var_23_1 = false
	local var_23_2 = arg_23_2.isError

	if arg_23_1 == ChessConst.TIMING_START then
		arg_23_0.globalEventManager_:ExecuteGlobalEvent(ChessConst.TIMING_START)

		if arg_23_0.eventQueueManager_:PromoteToNextEvent() then
			arg_23_0:DoNextEvent()
		else
			arg_23_0.eventQueueManager_:Clear()
		end
	elseif arg_23_1 == ChessConst.TIMING_CLICK then
		arg_23_0.stopMove_ = false

		if ChessTools.IsInteract(var_23_0.typeID, var_23_0.status) and (var_23_0.paramList.Length ~= 0 or true) then
			local var_23_3 = ChessTools.IsShowMessage(var_23_0.paramList[0], var_23_0.status)

			if var_23_3 == "" then
				if var_23_2 then
					ChessTools.CantReach(var_23_0.x, var_23_0.z)
				else
					ChessEventConfig[2][1](var_23_0)
				end
			elseif var_23_3[1] == 1 then
				ChessEventConfig[3][1](var_23_0, var_23_3[2], var_23_2)
			elseif var_23_3[1] == 2 then
				ChessEventConfig[4][1](var_23_0, var_23_3[2], var_23_2)
			end
		elseif var_23_2 then
			ChessTools.CantReach(var_23_0.x, var_23_0.z)
		else
			ChessEventConfig[1][1]()
		end
	elseif arg_23_1 == ChessConst.TIMING_WALK then
		local var_23_4 = ChessTools.ParseParameter(var_23_0)

		arg_23_0:ExecutingChess(arg_23_1, var_23_0, var_23_4)

		local var_23_5 = arg_23_0:IsStopMove()

		if var_23_5 then
			arg_23_0.IsExecuting_ = false
			arg_23_0.ExecutingChess_ = nil
		end

		var_23_1 = var_23_5
	elseif arg_23_1 == ChessConst.TIMING_INTERACT then
		var_23_0 = arg_23_0.ExecutingChess_

		local var_23_6 = ChessTools.ParseParameter(var_23_0)

		WarChessAction.TouchGrid({
			x = var_23_0.x,
			z = var_23_0.z
		}, nil, 1, function()
			arg_23_0:ExecutingChess(arg_23_1, var_23_0, var_23_6)
		end)
	elseif arg_23_1 == ChessConst.TIMING_HIT then
		local var_23_7 = ChessTools.ParseParameter(var_23_0, false, true)

		arg_23_0:ExecutingChess(arg_23_1, var_23_0, var_23_7)
	elseif arg_23_1 == ChessConst.TIMING_CURRENT then
		local var_23_8 = ChessTools.ParseParameter(var_23_0, false, true)

		if table.length(var_23_8) == 0 and var_23_0.typeID ~= 10101 then
			Debug.LogError(string.format("洋流状态中... 这个格子没参数:(%d,%d)", var_23_0.x, var_23_0.z))
		end

		arg_23_0:ExecutingChess(arg_23_1, var_23_0, var_23_8)

		var_23_1 = arg_23_0:IsStopMove()
	elseif arg_23_1 == ChessConst.TIMING_CURRENT_HIT then
		local var_23_9 = ChessTools.ParseParameter(var_23_0, false, true)

		WarChessAction.TouchGrid({
			x = var_23_0.x,
			z = var_23_0.z
		}, nil, 2, function()
			arg_23_0:ExecutingChess(arg_23_1, var_23_0, var_23_9)
		end)
	elseif arg_23_1 == ChessConst.TIMING_STONE_MOVE then
		local var_23_10 = ChessTools.ParseParameter(var_23_0, false, true)

		arg_23_0:ExecutingChess(arg_23_1, var_23_0, var_23_10)
	end

	arg_23_0.LastState_ = arg_23_1

	return var_23_1
end

function var_0_0.Dispose(arg_26_0)
	manager.windowBar:ClearWhereTag()

	arg_26_0.eventData_ = {}
	arg_26_0.finalChess_ = {}
	arg_26_0.IsExecuting_ = false
	arg_26_0.ExecutingChess_ = nil
	arg_26_0.chessEntities_ = {}
	arg_26_0.map_ = nil
	arg_26_0.battleStart_ = false
	arg_26_0.battleResult_ = false
	arg_26_0.mutiTimes_ = nil

	arg_26_0.blockerManager_:Dispose()
	arg_26_0.globalEventManager_:Dispose()
	arg_26_0.eventQueueManager_:Clear()
	arg_26_0.current:Dispose()
	arg_26_0.forceBattle:Dispose()
	arg_26_0.mutiBattle:Dispose()

	arg_26_0.selectGrid_ = nil
	arg_26_0.bulletDirection_ = nil
	arg_26_0.bulletEvent_ = 0
	arg_26_0.characterPos_ = nil

	if arg_26_0.bulletTimer_ then
		arg_26_0.bulletTimer_:Stop()

		arg_26_0.bulletTimer_ = nil
	end
end

function var_0_0.BattleStart(arg_27_0, arg_27_1)
	arg_27_0.battleStart_ = true
	arg_27_0.battleResult_ = nil
	arg_27_0.mutiTimes_ = arg_27_1

	arg_27_0:SetBattleIndex()

	local var_27_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_27_0 then
		arg_27_0.originShadowRotationImmediately = var_27_0.shadowRotationImmediately
		var_27_0.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)

	if not manager.ChessManager.current:IsDetector() then
		WarChessData:SetCharacterDirection(ChessLuaBridge.GetPlayerDirection())
	end
end

function var_0_0.SetBattleIndex(arg_28_0)
	local var_28_0 = arg_28_0:GetExecutingChess()
	local var_28_1 = var_28_0.x
	local var_28_2 = var_28_0.z * arg_28_0.map_.width + var_28_1 + 1

	WarChessData:SetBattleIndex(var_28_2)
end

function var_0_0.BattleSuccess(arg_29_0)
	arg_29_0.battleResult_ = true

	if arg_29_0.mutiTimes_ then
		arg_29_0.mutiTimes_ = arg_29_0.mutiTimes_ - 1
	end
end

function var_0_0.BattleFinish(arg_30_0)
	if arg_30_0.battleStart_ then
		if arg_30_0.mutiTimes_ then
			if arg_30_0.battleResult_ and arg_30_0.mutiTimes_ == 0 then
				arg_30_0:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
				arg_30_0:DoNextEvent()
			else
				arg_30_0:EventsEnd()
			end
		elseif arg_30_0.battleResult_ then
			arg_30_0:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
			arg_30_0:DoNextEvent()
		else
			arg_30_0:EventsEnd()
		end
	end

	if not arg_30_0.battleStart_ then
		return
	end

	arg_30_0.battleStart_ = false
	arg_30_0.battleResult_ = nil
	arg_30_0.mutiTimes_ = nil

	local var_30_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_30_0 then
		var_30_0.shadowRotationImmediately = arg_30_0.originShadowRotationImmediately
	end

	ChessLuaBridge.SetCameraControlEnable(true)
end

function var_0_0.LookAtPlayerWithCurPos(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = WarChessData:GetCurrentIndex()

	if math.abs(var_31_0.x - arg_31_1) + math.abs(var_31_0.z - arg_31_2) > 2 then
		ChessLuaBridge.LookAtPlayer(function()
			if arg_31_3 then
				arg_31_3()
			end
		end)
	elseif arg_31_3 then
		arg_31_3()
	end
end

function var_0_0.ChangeGridStatus(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	arg_33_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_33_1, arg_33_2, function()
		ChessLuaBridge.ChangeGridStatus(arg_33_1, arg_33_2, arg_33_3, function()
			arg_33_0:LookAtPlayerWithCurPos(arg_33_1, arg_33_2, function()
				arg_33_0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridStatusLua(arg_33_1, arg_33_2, arg_33_3)

				if arg_33_4 then
					arg_33_4()
				end
			end)
		end)
	end, true)
end

function var_0_0.PlayGridAnimation(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_37_1, arg_37_2, function()
		ChessLuaBridge.PlayGridAnimation(arg_37_1, arg_37_2, arg_37_3, function()
			arg_37_0:LookAtPlayerWithCurPos(arg_37_1, arg_37_2, function()
				arg_37_0.blockerManager_:HideBlocker()
				arg_37_4()
			end)
		end)
	end, true)
end

function var_0_0.ChangeGridDirection(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	arg_41_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_41_1, arg_41_2, function()
		ChessLuaBridge.RotateGrid(arg_41_1, arg_41_2, arg_41_3 * 60, arg_41_4, function()
			arg_41_0:LookAtPlayerWithCurPos(arg_41_1, arg_41_2, function()
				arg_41_0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridDirection(arg_41_1, arg_41_2, arg_41_3)

				if arg_41_5 then
					arg_41_5()
				end
			end)
		end)
	end, true)
end

function var_0_0.ChangeGridByList(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = {}
	local var_45_1 = {}

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		table.insert(var_45_0, iter_45_1.x)
		table.insert(var_45_1, iter_45_1.z)
	end

	local var_45_2 = #arg_45_1

	local function var_45_3()
		var_45_2 = var_45_2 - 1

		if var_45_2 <= 0 then
			ChessLuaBridge.LookAtPlayer(function()
				arg_45_0.blockerManager_:HideBlocker()

				if arg_45_2 then
					arg_45_2()
				end
			end)
		end
	end

	arg_45_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtTarget(var_45_0, var_45_1, function()
		for iter_48_0 = 1, #arg_45_1 do
			local var_48_0 = arg_45_1[iter_48_0].style
			local var_48_1 = arg_45_1[iter_48_0]

			if var_48_0 == 1 then
				ChessLuaBridge.ChangeGridStatus(var_48_1.x, var_48_1.z, var_48_1.param, var_45_3)
			elseif var_48_0 == 2 then
				ChessLuaBridge.ChangeGridByIndex(var_48_1.x, var_48_1.z, var_48_1.param, var_45_3)
			elseif var_48_0 == 3 then
				local var_48_2 = ChessLuaBridge.GetGridData(var_48_1.x, var_48_1.z)

				if var_48_2.typeID == 20110 or var_48_2.typeID == 20111 then
					manager.audio:PlayEffect("se_story_activity_2_1_4", "se_story_activity_2_1_4_warchess_pipe_move", "")
				end

				ChessLuaBridge.RotateGrid(var_48_1.x, var_48_1.z, var_48_1.param[1] * 60, var_48_1.param[2], var_45_3)
			end
		end
	end, true)
end

function var_0_0.ChangeGridByIndex(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	arg_49_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_49_1, arg_49_2, function()
		ChessLuaBridge.ChangeGridByIndex(arg_49_1, arg_49_2, arg_49_3, function()
			arg_49_0:LookAtPlayerWithCurPos(arg_49_1, arg_49_2, function()
				arg_49_0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridLua(arg_49_1, arg_49_2, arg_49_3)

				if arg_49_4 then
					arg_49_4()
				end
			end)
		end)
	end, true)
end

function var_0_0.ChangeGridByIndexWithOutLook(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	arg_53_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.ChangeGridByIndex(arg_53_1, arg_53_2, arg_53_3, function()
		arg_53_0.blockerManager_:HideBlocker()
		WarChessData:ChangeGridLua(arg_53_1, arg_53_2, arg_53_3)

		if arg_53_4 then
			arg_53_4()
		end
	end)
end

function var_0_0.ChangeGridByGridData(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	arg_55_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_55_1, arg_55_2, function()
		ChessLuaBridge.ChangeGrid(arg_55_1, arg_55_2, arg_55_3, function()
			arg_55_0:LookAtPlayerWithCurPos(arg_55_1, arg_55_2, function()
				arg_55_0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridLua(arg_55_1, arg_55_2, 0)

				if arg_55_4 then
					arg_55_4()
				end
			end)
		end)
	end, true)
end

function var_0_0.MoveToTarget(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	arg_59_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_59_1, arg_59_2, function()
		arg_59_0.blockerManager_:HideBlocker()

		if arg_59_3 then
			arg_59_3()
		end
	end)
end

function var_0_0.LookAtPlayer(arg_61_0, arg_61_1)
	arg_61_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function()
		arg_61_0.blockerManager_:HideBlocker()

		if arg_61_1 then
			arg_61_1()
		end
	end)
end

function var_0_0.LookForSeconds(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	arg_63_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_63_1, arg_63_2, function()
		TimeTools.StartAfterSeconds(arg_63_3, function()
			ChessLuaBridge.LookAtPlayer(function()
				arg_63_0.blockerManager_:HideBlocker()

				if arg_63_4 then
					arg_63_4()
				end
			end)
		end, {})
	end)
end

function var_0_0.SetGridSelectOutline(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	if arg_67_3 then
		if arg_67_0.selectGrid_ then
			ChessLuaBridge.SetGridSelectOutline(arg_67_0.selectGrid_.x, arg_67_0.selectGrid_.z, false)
		end

		ChessLuaBridge.SetGridSelectOutline(arg_67_1, arg_67_2, true)

		arg_67_0.selectGrid_ = {
			x = arg_67_1,
			z = arg_67_2
		}
	elseif arg_67_0.selectGrid_ then
		ChessLuaBridge.SetGridSelectOutline(arg_67_0.selectGrid_.x, arg_67_0.selectGrid_.z, false)

		arg_67_0.selectGrid_ = nil
	end
end

function var_0_0.ShowBlocker(arg_68_0)
	arg_68_0.blockerManager_:ShowBlocker()
end

function var_0_0.HideBlocker(arg_69_0)
	arg_69_0.blockerManager_:HideBlocker()
end

local var_0_1 = 0

function var_0_0.bulletBarrierFunction(arg_70_0)
	var_0_1 = var_0_1 + 1

	if var_0_1 == 2 then
		arg_70_0.blockerManager_:HideBlocker()

		var_0_1 = 0
	elseif var_0_1 > 2 then
		-- block empty
	end
end

function var_0_0.FireBullet(arg_71_0)
	manager.notify:CallUpdateFunc(CAMERA_MOVE, false)
	arg_71_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function()
		WarChessAction.FireByPlayer(function()
			ChessLuaBridge.FireByPlayer()

			arg_71_0.bulletEvent_ = arg_71_0.bulletEvent_ + 1
			arg_71_0.bulletTimer_ = TimeTools.StartAfterSeconds(1.67, function()
				arg_71_0:bulletBarrierFunction()
			end, {})
		end)
	end)
end

function var_0_0.BulletContinue(arg_75_0)
	arg_75_0.bulletEvent_ = arg_75_0.bulletEvent_ + 1
end

function var_0_0.OnBulletEnd(arg_76_0)
	arg_76_0.bulletEvent_ = arg_76_0.bulletEvent_ == 0 and 0 or arg_76_0.bulletEvent_ - 1

	if not arg_76_0.bulletEvent_ or arg_76_0.bulletEvent_ == 0 then
		arg_76_0:bulletBarrierFunction()
	end
end

function var_0_0.SetBulletDirection(arg_77_0, arg_77_1)
	arg_77_0.bulletDirection_ = arg_77_1
end

function var_0_0.GetBulletDirection(arg_78_0)
	return arg_78_0.bulletDirection_
end

function var_0_0.SetCountDown(arg_79_0, arg_79_1)
	if arg_79_1 then
		ChessLuaBridge.SetCountText(arg_79_1)
	else
		ChessLuaBridge.SetCountText(0, false)
	end
end

function var_0_0.StoneStartToMove(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function()
		ChessLuaBridge.StoneMove(arg_80_1, arg_80_2)
	end)
end

return var_0_0
