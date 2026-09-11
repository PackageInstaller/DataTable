local var_0_0 = singletonClass("ChessMain")

function var_0_0:Ctor()
	self.eventData_ = {}
	self.finalChess_ = {}
	self.IsExecuting_ = false
	self.ExecutingChess_ = nil
	self.chessEntities_ = {}
	self.cachePath_ = {}
	self.battleStart_ = false
	self.battleResult_ = false
	self.mutiTimes_ = nil
	self.selectGrid_ = nil
	self.map_ = nil
	self.bulletDirection_ = nil
	self.bulletEvent_ = 0
	self.eventQueueManager_ = ChessEventQueue.New()
	self.current = ChessCurrentModel.New(self.blockerManager_)
	self.forceBattle = ChessForceBattleModel.New()
	self.mutiBattle = ChessMutiBattleModel.New()
	self.characterPos_ = nil
	self.curStoneGirdData_ = nil
	self.movedStoneGridData_ = nil
end

function var_0_0:SetUp(arg_2_1)
	self.blockerManager_ = ChessBlockerManager.New(manager.ui.canvas)
	self.globalEventManager_ = ChessGlobalEventManager.New(self)

	self:LoadMap(arg_2_1)
	self.current:SetUp(self.blockerManager_)
	self.forceBattle:SetUp(self.map_.width)
	self.mutiBattle:SetUp(self.map_.width)

	local var_2_0 = WarChessData:GetButterFlyPos()

	if var_2_0 then
		ChessLuaBridge.InitGuider(WarChessTools.GetGuiderAssetPath(arg_2_1), var_2_0[1], var_2_0[2])
	end

	if not table.indexof(WarchessLevelCfg[arg_2_1].extra_gameplay, 2) then
		local var_2_1 = WarChessData:GetCurrentIndex()

		self.characterPos_ = {
			var_2_1.x,
			var_2_1.z
		}
	end
end

function var_0_0:IsExecuting()
	return self.IsExecuting_
end

function var_0_0:ExecutingChess(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == ChessConst.TIMING_WALK and not ChessTools.IsWalkEvent(arg_4_2.typeID, arg_4_2.status) then
		arg_4_3 = ChessTools.ParseEventPollCfg({
			{
				10000
			}
		})

		self.eventQueueManager_:InsertNewEventQueue(arg_4_3, arg_4_1, arg_4_2)
	elseif arg_4_1 == ChessConst.TIMING_CURRENT and not ChessTools.IsWalkEvent(arg_4_2.typeID, arg_4_2.status) then
		arg_4_3 = ChessTools.ParseEventPollCfg({
			{
				10000
			}
		})

		self.eventQueueManager_:InsertNewEventQueue(arg_4_3, arg_4_1, arg_4_2)
	else
		self:CreateEventQueue(arg_4_2, arg_4_3, arg_4_1)
	end

	if self.eventQueueManager_:CurEventTiming() then
		return
	end

	if self.eventQueueManager_:PromoteToNextEvent() then
		self:DoNextEvent()
	else
		self:EventsEnd()
	end
end

function var_0_0:LoadMap(arg_5_1)
	self.ChapterID = arg_5_1

	if self.map_ then
		return
	end

	WarChessData:SetStartTime(manager.time:GetServerTime())

	self.map_ = ChessTools.LoadMap(arg_5_1)

	if not self.map_ then
		-- block empty
	end

	local var_5_0 = {}

	WarChessData:SetExtendMap(self.map_.extendInfo)
	WarChessData:SetJsonMap(var_5_0)

	for iter_5_0, iter_5_1 in pairs(self.map_.mapInfo) do
		var_5_0[ChessTools.TwoDToOneD(iter_5_1.x, iter_5_1.z)] = iter_5_1
	end

	for iter_5_2, iter_5_3 in pairs(WarChessData:GetCurrentWarChessMapData().mapChangeInfo) do
		self:CreateChess(var_5_0[ChessTools.TwoDToOneD(iter_5_3.pos.x, iter_5_3.pos.z)], iter_5_3.status)
	end

	for iter_5_4, iter_5_5 in pairs(self.map_.mapInfo) do
		self:CreateChess(iter_5_5, iter_5_5.status)
	end
end

function var_0_0.CachePath(arg_6_0, arg_6_1)
	arg_6_0.cachePath_ = arg_6_1
end

function var_0_0:InsertGlobalEventList(arg_7_1)
	self.globalEventManager_:InsertGlobalEventList(arg_7_1)
end

function var_0_0:ClearGlobalEventByType(arg_8_1)
	self.globalEventManager_:ClearGlobalEventByType(arg_8_1)
end

function var_0_0:GetExecutingChess()
	return self.eventQueueManager_:GetExecutingChess()
end

function var_0_0:CreateEventQueue(arg_10_1, arg_10_2, arg_10_3)
	if not WarchessEventPoolCfg[arg_10_1.paramList[0]] then
		-- block empty
	end

	self.eventQueueManager_:InsertNewEventQueue(arg_10_2, arg_10_3, arg_10_1)
end

function var_0_0:InsertEventQueue(arg_11_1, arg_11_2)
	if arg_11_2 == "GLOBAL" then
		self.eventQueueManager_:InsertNewEventQueue(arg_11_1, "GLOBAL")
	else
		self.eventQueueManager_:InsertCurEventQueue(arg_11_1)
	end
end

function var_0_0:DoNextEvent()
	local var_12_0 = self.eventQueueManager_:LastEventID()

	if var_12_0 then
		WarChessData:ExecuteEventOneTime(var_12_0)
	end

	if self.eventQueueManager_:IsEventEnd() then
		self:EventsEnd()

		return
	end

	local var_12_1, var_12_2 = self.eventQueueManager_:GetCurFunc()

	self.eventQueueManager_:PromoteCurEventProgress()

	return var_12_1(unpack(var_12_2))
end

function var_0_0:EventsEnd()
	local var_13_0 = self.eventQueueManager_:CurEventTiming()

	if var_13_0 == ChessConst.TIMING_INTERACT then
		self.IsExecuting_ = false
		self.ExecutingChess_ = nil
	end

	if var_13_0 ~= nil then
		self.globalEventManager_:ExecuteGlobalEvent(var_13_0)
	end

	if self.eventQueueManager_:PromoteToNextEvent() then
		self:DoNextEvent()
	else
		self.eventQueueManager_:Clear()

		if WarChessData:GetStoneIsMoving() then
			ChessLuaBridge.StoneContinueMove()
		end
	end
end

function var_0_0:CreateChess(arg_14_1, arg_14_2)
	local var_14_0 = ChessTools.TwoDToOneD(arg_14_1.x, arg_14_1.z)

	if self.chessEntities_[var_14_0] then
		return
	end

	for iter_14_0, iter_14_1 in pairs((ChessTools.ParseParameter(arg_14_1, true))) do
		if ChessTools.IsSavingEvent(iter_14_1.eventID) then
			self.chessEntities_[var_14_0] = {
				x = arg_14_1.x,
				z = arg_14_1.z
			}

			return
		end
	end
end

function var_0_0:ExecutingCreatedChess(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(self.chessEntities_) do
		for iter_15_2, iter_15_3 in pairs((ChessTools.ParseParameter((ChessLuaBridge.GetGridData(iter_15_1.x, iter_15_1.z))))) do
			if ChessEventConfig[iter_15_3.eventID][arg_15_1] then
				ChessEventConfig[iter_15_3.eventID][arg_15_1](iter_15_0, iter_15_1, unpack(iter_15_3.params))
			end
		end
	end
end

function var_0_0:SetPosition(arg_16_1, arg_16_2)
	if self.characterPos_ and self.characterPos_[1] == arg_16_1 and self.characterPos_[2] == arg_16_2 then
		return false
	end

	WarChessData:SetCurrentIndex(arg_16_1, arg_16_2)

	self.characterPos_ = {
		arg_16_1,
		arg_16_2
	}

	return true
end

function var_0_0.SetInteractChess(arg_17_0, arg_17_1)
	arg_17_0.IsExecuting_ = true
	arg_17_0.ExecutingChess_ = arg_17_1
end

function var_0_0:ExecuteMove()
	WarChessAction.RoleMoveByPath(self.cachePath_, function(arg_19_0)
		if not isSuccess(arg_19_0) then
			ShowTips(arg_19_0)
			ChessLuaBridge.ClearCachePath()
		else
			manager.notify:CallUpdateFunc(CAMERA_MOVE, false)
			ChessLuaBridge.MoveToCachePos()
			self.blockerManager_:ShowBlocker()
		end
	end)
end

function var_0_0:OnMoveEnd()
	self.blockerManager_:HideBlocker()
	self:SetGridSelectOutline(nil, nil, false)
end

function var_0_0.StopMove(arg_21_0)
	manager.audio:StopEffect()

	arg_21_0.stopMove_ = true
end

function var_0_0:IsStopMove()
	if self.stopMove_ then
		self.stopMove_ = false

		return true
	end

	return false
end

function var_0_0:ExecuteChessTiming(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2.gridData
	local var_23_1 = false

	if arg_23_1 == ChessConst.TIMING_START then
		self.globalEventManager_:ExecuteGlobalEvent(ChessConst.TIMING_START)

		if self.eventQueueManager_:PromoteToNextEvent() then
			self:DoNextEvent()
		else
			self.eventQueueManager_:Clear()
		end
	elseif arg_23_1 == ChessConst.TIMING_CLICK then
		self.stopMove_ = false

		if ChessTools.IsInteract(var_23_0.typeID, var_23_0.status) and (var_23_0.paramList.Length ~= 0 or true) then
			local var_23_2 = ChessTools.IsShowMessage(var_23_0.paramList[0], var_23_0.status)

			if var_23_2 == "" then
				if arg_23_2.isError then
					ChessTools.CantReach(var_23_0.x, var_23_0.z)
				else
					ChessEventConfig[2][1](var_23_0)
				end
			elseif var_23_2[1] == 1 then
				ChessEventConfig[3][1](var_23_0, var_23_2[2], arg_23_2.isError)
			elseif var_23_2[1] == 2 then
				ChessEventConfig[4][1](var_23_0, var_23_2[2], arg_23_2.isError)
			end
		elseif arg_23_2.isError then
			ChessTools.CantReach(var_23_0.x, var_23_0.z)
		else
			ChessEventConfig[1][1]()
		end
	elseif arg_23_1 == ChessConst.TIMING_WALK then
		self:ExecutingChess(arg_23_1, var_23_0, (ChessTools.ParseParameter(var_23_0)))

		local var_23_3 = self:IsStopMove()

		if var_23_3 then
			self.IsExecuting_ = false
			self.ExecutingChess_ = nil
		end

		var_23_1 = var_23_3
	elseif arg_23_1 == ChessConst.TIMING_INTERACT then
		var_23_0 = self.ExecutingChess_

		local var_23_4 = ChessTools.ParseParameter(self.ExecutingChess_)

		WarChessAction.TouchGrid({
			x = self.ExecutingChess_.x,
			z = self.ExecutingChess_.z
		}, nil, 1, function()
			self:ExecutingChess(arg_23_1, var_23_0, var_23_4)
		end)
	elseif arg_23_1 == ChessConst.TIMING_HIT then
		self:ExecutingChess(arg_23_1, var_23_0, (ChessTools.ParseParameter(var_23_0, false, true)))
	elseif arg_23_1 == ChessConst.TIMING_CURRENT then
		local var_23_5 = ChessTools.ParseParameter(var_23_0, false, true)

		if table.length(var_23_5) == 0 and var_23_0.typeID ~= 10101 then
			Debug.LogError(string.format("洋流状态中... 这个格子没参数:(%d,%d)", var_23_0.x, var_23_0.z))
		end

		self:ExecutingChess(arg_23_1, var_23_0, var_23_5)

		var_23_1 = self:IsStopMove()
	elseif arg_23_1 == ChessConst.TIMING_CURRENT_HIT then
		local var_23_6 = ChessTools.ParseParameter(var_23_0, false, true)

		WarChessAction.TouchGrid({
			x = var_23_0.x,
			z = var_23_0.z
		}, nil, 2, function()
			self:ExecutingChess(arg_23_1, var_23_0, var_23_6)
		end)
	elseif arg_23_1 == ChessConst.TIMING_STONE_MOVE then
		self:ExecutingChess(arg_23_1, var_23_0, (ChessTools.ParseParameter(var_23_0, false, true)))
	end

	self.LastState_ = arg_23_1

	return var_23_1
end

function var_0_0:Dispose()
	manager.windowBar:ClearWhereTag()

	self.eventData_ = {}
	self.finalChess_ = {}
	self.IsExecuting_ = false
	self.ExecutingChess_ = nil
	self.chessEntities_ = {}
	self.map_ = nil
	self.battleStart_ = false
	self.battleResult_ = false
	self.mutiTimes_ = nil

	self.blockerManager_:Dispose()
	self.globalEventManager_:Dispose()
	self.eventQueueManager_:Clear()
	self.current:Dispose()
	self.forceBattle:Dispose()
	self.mutiBattle:Dispose()

	self.selectGrid_ = nil
	self.bulletDirection_ = nil
	self.bulletEvent_ = 0
	self.characterPos_ = nil

	if self.bulletTimer_ then
		self.bulletTimer_:Stop()

		self.bulletTimer_ = nil
	end
end

function var_0_0:BattleStart(arg_27_1)
	self.battleStart_ = true
	self.battleResult_ = nil
	self.mutiTimes_ = arg_27_1

	self:SetBattleIndex()

	local var_27_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_27_0 then
		self.originShadowRotationImmediately = var_27_0.shadowRotationImmediately
		var_27_0.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)

	if not manager.ChessManager.current:IsDetector() then
		WarChessData:SetCharacterDirection(ChessLuaBridge.GetPlayerDirection())
	end
end

function var_0_0:SetBattleIndex()
	local var_28_0 = self:GetExecutingChess()

	WarChessData:SetBattleIndex(var_28_0.z * self.map_.width + var_28_0.x + 1)
end

function var_0_0:BattleSuccess()
	self.battleResult_ = true

	if self.mutiTimes_ then
		self.mutiTimes_ = self.mutiTimes_ - 1
	end
end

function var_0_0:BattleFinish()
	if self.battleStart_ then
		if self.mutiTimes_ then
			if self.battleResult_ and self.mutiTimes_ == 0 then
				self:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
				self:DoNextEvent()
			else
				self:EventsEnd()
			end
		elseif self.battleResult_ then
			self:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
			self:DoNextEvent()
		else
			self:EventsEnd()
		end
	end

	if not self.battleStart_ then
		return
	end

	self.battleStart_ = false
	self.battleResult_ = nil
	self.mutiTimes_ = nil

	local var_30_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_30_0 then
		var_30_0.shadowRotationImmediately = self.originShadowRotationImmediately
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

function var_0_0:ChangeGridStatus(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_33_1, arg_33_2, function()
		ChessLuaBridge.ChangeGridStatus(arg_33_1, arg_33_2, arg_33_3, function()
			self:LookAtPlayerWithCurPos(arg_33_1, arg_33_2, function()
				self.blockerManager_:HideBlocker()
				WarChessData:ChangeGridStatusLua(arg_33_1, arg_33_2, arg_33_3)

				if arg_33_4 then
					arg_33_4()
				end
			end)
		end)
	end, true)
end

function var_0_0:PlayGridAnimation(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_37_1, arg_37_2, function()
		ChessLuaBridge.PlayGridAnimation(arg_37_1, arg_37_2, arg_37_3, function()
			self:LookAtPlayerWithCurPos(arg_37_1, arg_37_2, function()
				self.blockerManager_:HideBlocker()
				arg_37_4()
			end)
		end)
	end, true)
end

function var_0_0:ChangeGridDirection(arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_41_1, arg_41_2, function()
		ChessLuaBridge.RotateGrid(arg_41_1, arg_41_2, arg_41_3 * 60, arg_41_4, function()
			self:LookAtPlayerWithCurPos(arg_41_1, arg_41_2, function()
				self.blockerManager_:HideBlocker()
				WarChessData:ChangeGridDirection(arg_41_1, arg_41_2, arg_41_3)

				if arg_41_5 then
					arg_41_5()
				end
			end)
		end)
	end, true)
end

function var_0_0:ChangeGridByList(arg_45_1, arg_45_2)
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
				self.blockerManager_:HideBlocker()

				if arg_45_2 then
					arg_45_2()
				end
			end)
		end
	end

	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtTarget(var_45_0, var_45_1, function()
		for iter_48_0 = 1, #arg_45_1 do
			local var_48_0 = arg_45_1[iter_48_0]

			if arg_45_1[iter_48_0].style == 1 then
				ChessLuaBridge.ChangeGridStatus(var_48_0.x, var_48_0.z, var_48_0.param, var_45_3)
			elseif arg_45_1[iter_48_0].style == 2 then
				ChessLuaBridge.ChangeGridByIndex(var_48_0.x, var_48_0.z, var_48_0.param, var_45_3)
			elseif arg_45_1[iter_48_0].style == 3 then
				local var_48_1 = ChessLuaBridge.GetGridData(var_48_0.x, var_48_0.z)

				if var_48_1.typeID == 20110 or var_48_1.typeID == 20111 then
					manager.audio:PlayEffect("se_story_activity_2_1_4", "se_story_activity_2_1_4_warchess_pipe_move", "")
				end

				ChessLuaBridge.RotateGrid(var_48_0.x, var_48_0.z, var_48_0.param[1] * 60, var_48_0.param[2], var_45_3)
			end
		end
	end, true)
end

function var_0_0:ChangeGridByIndex(arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_49_1, arg_49_2, function()
		ChessLuaBridge.ChangeGridByIndex(arg_49_1, arg_49_2, arg_49_3, function()
			self:LookAtPlayerWithCurPos(arg_49_1, arg_49_2, function()
				self.blockerManager_:HideBlocker()
				WarChessData:ChangeGridLua(arg_49_1, arg_49_2, arg_49_3)

				if arg_49_4 then
					arg_49_4()
				end
			end)
		end)
	end, true)
end

function var_0_0:ChangeGridByIndexWithOutLook(arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.ChangeGridByIndex(arg_53_1, arg_53_2, arg_53_3, function()
		self.blockerManager_:HideBlocker()
		WarChessData:ChangeGridLua(arg_53_1, arg_53_2, arg_53_3)

		if arg_53_4 then
			arg_53_4()
		end
	end)
end

function var_0_0:ChangeGridByGridData(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_55_1, arg_55_2, function()
		ChessLuaBridge.ChangeGrid(arg_55_1, arg_55_2, arg_55_3, function()
			self:LookAtPlayerWithCurPos(arg_55_1, arg_55_2, function()
				self.blockerManager_:HideBlocker()
				WarChessData:ChangeGridLua(arg_55_1, arg_55_2, 0)

				if arg_55_4 then
					arg_55_4()
				end
			end)
		end)
	end, true)
end

function var_0_0:MoveToTarget(arg_59_1, arg_59_2, arg_59_3)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_59_1, arg_59_2, function()
		self.blockerManager_:HideBlocker()

		if arg_59_3 then
			arg_59_3()
		end
	end)
end

function var_0_0:LookAtPlayer(arg_61_1)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function()
		self.blockerManager_:HideBlocker()

		if arg_61_1 then
			arg_61_1()
		end
	end)
end

function var_0_0:LookForSeconds(arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(arg_63_1, arg_63_2, function()
		TimeTools.StartAfterSeconds(arg_63_3, function()
			ChessLuaBridge.LookAtPlayer(function()
				self.blockerManager_:HideBlocker()

				if arg_63_4 then
					arg_63_4()
				end
			end)
		end, {})
	end)
end

function var_0_0:SetGridSelectOutline(arg_67_1, arg_67_2, arg_67_3)
	if arg_67_3 then
		if self.selectGrid_ then
			ChessLuaBridge.SetGridSelectOutline(self.selectGrid_.x, self.selectGrid_.z, false)
		end

		ChessLuaBridge.SetGridSelectOutline(arg_67_1, arg_67_2, true)

		self.selectGrid_ = {
			x = arg_67_1,
			z = arg_67_2
		}
	elseif self.selectGrid_ then
		ChessLuaBridge.SetGridSelectOutline(self.selectGrid_.x, self.selectGrid_.z, false)

		self.selectGrid_ = nil
	end
end

function var_0_0:ShowBlocker()
	self.blockerManager_:ShowBlocker()
end

function var_0_0:HideBlocker()
	self.blockerManager_:HideBlocker()
end

local var_0_1 = 0

function var_0_0:bulletBarrierFunction()
	var_0_1 = var_0_1 + 1

	if var_0_1 == 2 then
		self.blockerManager_:HideBlocker()

		var_0_1 = 0
	elseif var_0_1 > 2 then
		-- block empty
	end
end

function var_0_0:FireBullet()
	manager.notify:CallUpdateFunc(CAMERA_MOVE, false)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function()
		WarChessAction.FireByPlayer(function()
			ChessLuaBridge.FireByPlayer()

			self.bulletEvent_ = self.bulletEvent_ + 1
			self.bulletTimer_ = TimeTools.StartAfterSeconds(1.67, function()
				self:bulletBarrierFunction()
			end, {})
		end)
	end)
end

function var_0_0:BulletContinue()
	self.bulletEvent_ = self.bulletEvent_ + 1
end

function var_0_0:OnBulletEnd()
	self.bulletEvent_ = self.bulletEvent_ == 0 and 0 or self.bulletEvent_ - 1

	if not self.bulletEvent_ or self.bulletEvent_ == 0 then
		self:bulletBarrierFunction()
	end
end

function var_0_0.SetBulletDirection(arg_77_0, arg_77_1)
	arg_77_0.bulletDirection_ = arg_77_1
end

function var_0_0:GetBulletDirection()
	return self.bulletDirection_
end

function var_0_0.SetCountDown(arg_79_0, arg_79_1)
	if arg_79_1 then
		ChessLuaBridge.SetCountText(arg_79_1)
	else
		ChessLuaBridge.SetCountText(0, false)
	end
end

function var_0_0:StoneStartToMove(arg_80_1, arg_80_2)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function()
		ChessLuaBridge.StoneMove(arg_80_1, arg_80_2)
	end)
end

return var_0_0
