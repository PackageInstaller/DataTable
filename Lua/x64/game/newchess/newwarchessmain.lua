local var_0_0 = singletonClass("NewWarChessMain")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.IsExecuting_ = false
	arg_1_0.ExecutingChess_ = nil
	arg_1_0.isSelectEventInteracting_ = false
	arg_1_0.selectEventInteracChess_ = nil
	arg_1_0.curChanceID_ = 0
	arg_1_0.curChanceItemID_ = 0
	arg_1_0.curDiceNumList_ = {}
	arg_1_0.curAffixList_ = {}
	arg_1_0.characterPos_ = nil
	arg_1_0.eventQueueManager_ = NewChessEventQueue.New()
	arg_1_0.buffManager_ = NewChessBuffManager.New()
	arg_1_0.taskManager_ = NewChessTaskManager.New()
	arg_1_0.globalManager_ = NewWarChessGlobalManager.New()
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0:LoadMap(arg_2_1)

	local var_2_0 = NewWarChessData:GetCurrentIndex()

	arg_2_0.characterPos_ = {
		var_2_0.x,
		var_2_0.z
	}

	local var_2_1 = NewWarChessData:GetCurrentWarChessMapData()

	arg_2_0.taskManager_:SetServerData(var_2_1.taskList)
	arg_2_0.buffManager_:SetServerData(var_2_1.buffList)
	arg_2_0.globalManager_:SetServerData(var_2_1.globalEventList)
end

function var_0_0.CreateSupportModule(arg_3_0)
	if arg_3_0.blockerManager_ == nil then
		arg_3_0.blockerManager_ = NewWarChessBlockerManager.New(manager.ui.canvas)
	end

	if arg_3_0.tipsManager_ == nil then
		arg_3_0.tipsManager_ = NewChessTipsManager.New()
	end
end

function var_0_0.DisposeSupportModule(arg_4_0)
	if arg_4_0.blockerManager_ then
		arg_4_0.blockerManager_:Dispose()

		arg_4_0.blockerManager_ = nil
	end

	if arg_4_0.tipsManager_ then
		arg_4_0.tipsManager_:Dispose()

		arg_4_0.tipsManager_ = nil
	end
end

function var_0_0.LoadMap(arg_5_0, arg_5_1)
	arg_5_0.ChapterID = arg_5_1
	arg_5_0.map_ = NewChessTools.LoadMap(arg_5_1)

	if not arg_5_0.map_ then
		-- block empty
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.map_.mapInfo) do
		local var_5_1 = iter_5_1.x
		local var_5_2 = iter_5_1.z

		var_5_0[NewChessTools.TwoDToOneD(var_5_1, var_5_2)] = iter_5_1
	end

	NewWarChessData:SetExtendMap(arg_5_0.map_.extendInfo)
	NewWarChessData:SetExtendObjectMap(arg_5_0.map_.extendThingInfo)
	NewWarChessData:SetJsonMap(var_5_0)
end

function var_0_0.ShowPathEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:ClearAllSelectEffect()
	NewChessLuaBridge.ShowGridSelectEffect()
	manager.audio:PlayEffect("ui_system", "button", "")
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.READY, arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.ClearGridSelectEffect(arg_7_0, arg_7_1, arg_7_2)
	NewChessLuaBridge.ClearGridSelectEffect(arg_7_1, arg_7_2)
end

function var_0_0.ClearAllSelectEffect(arg_8_0)
	NewChessLuaBridge.ClearAllSelectEffect()
end

function var_0_0.StartMoveToCaChePath(arg_9_0)
	arg_9_0.blockerManager_:ShowMoveBlocker()
	NewChessLuaBridge.MoveToCachePos()
	manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, false)
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.MOVING)
end

function var_0_0.ClearEndPoint(arg_10_0)
	arg_10_0:ClearAllSelectEffect()

	arg_10_0.IsExecuting_ = false
	arg_10_0.ExecutingChess_ = nil

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
end

function var_0_0.ExecuteChessTiming(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2.gridData
	local var_11_1 = arg_11_2.cost
	local var_11_2 = arg_11_2.isTelePort
	local var_11_3 = arg_11_2.dir
	local var_11_4 = arg_11_2.screenPos

	if arg_11_1 == NewChessConst.TIMING_START then
		NewWarChessData:SetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN", 1)

		local var_11_5 = NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].eventpool_id
		local var_11_6 = NewWarChessData:GetServerEvent(arg_11_1, {})

		arg_11_0:ExecutChess(arg_11_1, nil, var_11_6)
	elseif arg_11_1 == NewChessConst.TIMING_WALK_OUT then
		if var_11_0.exitParamList and var_11_0.exitParamList.Length > 0 then
			local var_11_7 = NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})

			arg_11_0:ExecutChess(arg_11_1, var_11_0, var_11_7)
		end
	elseif arg_11_1 == NewChessConst.TIMING_WALK_INTO then
		if var_11_0.enterParamList and var_11_0.enterParamList.Length > 0 then
			local var_11_8 = NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})

			arg_11_0:ExecutChess(arg_11_1, var_11_0, var_11_8)
		end

		if not var_11_2 then
			local var_11_9 = -NewWarChessHexCfg[var_11_0.typeID].penalty * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT_COST_TIMES") / 1000)
			local var_11_10 = math.floor(var_11_9)

			NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_11_10)
			arg_11_0:UpdateBuff()
		end

		if arg_11_0.eventQueueManager_:IsEmpty() then
			arg_11_0.globalManager_:CheckSettlementGlobalEventList()
		end
	elseif arg_11_1 == NewChessConst.TIMING_INTERACT then
		var_11_0 = arg_11_0.ExecutingChess_

		if var_11_0.clickParamList and var_11_0.clickParamList.Length > 0 then
			if NewWarChessEventPoolCfg[var_11_0.clickParamList[0]] == nil then
				error("clickParamList触发的eventPoolID不存在！", var_11_0.clickParamList[0])

				return
			end

			NewWarChessAction.ClickGrid(var_11_0.x, var_11_0.z, false, function()
				local var_12_0 = var_11_0.clickParamList[0]

				if NewWarChessEventPoolCfg[var_12_0].type == NewChessConst.EVENTPOOL_TYPE.NEWWARCHESS_EVENT then
					local var_12_1 = NewWarChessData:GetServerEvent(arg_11_1, {
						var_11_0.x,
						var_11_0.z
					})

					arg_11_0:ExecutChess(arg_11_1, var_11_0, var_12_1)
					arg_11_0:StartExecuteEvent()
				else
					manager.NewChessManager:SetChanceInteract(true, var_11_0)
					JumpTools.OpenPageByJump("/newWarChessChanceView", {
						chanceID = NewWarChessData:GetServerChanceID()
					})
					arg_11_0:ClearInteractChess()
				end
			end)
		end
	elseif arg_11_1 == NewChessConst.TIMING_WALK_OUT_OBJECT then
		if var_11_0.objectExitParamList and var_11_0.objectExitParamList.Length > 0 then
			local var_11_11 = NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})

			arg_11_0:ExecutChess(arg_11_1, var_11_0, var_11_11)
		end
	elseif arg_11_1 == NewChessConst.TIMING_WALK_INTO_OBJECT then
		if var_11_0.objectEnterParamList and var_11_0.objectEnterParamList.Length > 0 then
			local var_11_12 = NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})

			arg_11_0:ExecutChess(arg_11_1, var_11_0, var_11_12)
		end
	elseif arg_11_1 == NewChessConst.TIMING_INTERACT_OBJECT then
		var_11_0 = arg_11_0.ExecutingChess_

		if var_11_0.objectClickParamList and var_11_0.objectClickParamList.Length > 0 then
			if NewWarChessEventPoolCfg[var_11_0.objectClickParamList[0]] == nil then
				error("objectClickParamList触发的eventPoolID不存在！", var_11_0.objectClickParamList[0])

				return
			end

			NewWarChessAction.ClickGrid(var_11_0.x, var_11_0.z, false, function()
				local var_13_0 = var_11_0.objectClickParamList[0]

				if NewWarChessEventPoolCfg[var_13_0].type == NewChessConst.EVENTPOOL_TYPE.NEWWARCHESS_EVENT then
					local var_13_1 = NewWarChessData:GetServerEvent(arg_11_1, {
						var_11_0.x,
						var_11_0.z
					})

					arg_11_0:ExecutChess(arg_11_1, var_11_0, var_13_1)
					arg_11_0:StartExecuteEvent()
				else
					manager.NewChessManager:SetChanceInteract(true, var_11_0)
					JumpTools.OpenPageByJump("/newWarChessChanceView", {
						chanceID = NewWarChessData:GetServerChanceID()
					})
				end
			end)
		end
	elseif arg_11_1 == NewChessConst.TIMING_FARCLICK_OBJECT and var_11_0.objectFarClickParamList and var_11_0.objectFarClickParamList.Length > 0 then
		local var_11_13 = NewWarChessData:GetServerEvent(arg_11_1, {
			var_11_0.x,
			var_11_0.z
		})

		arg_11_0:ExecutChess(arg_11_1, var_11_0, var_11_13)
	end
end

function var_0_0.SetInteractChess(arg_14_0, arg_14_1)
	arg_14_0.IsExecuting_ = true
	arg_14_0.ExecutingChess_ = arg_14_1
end

function var_0_0.ClearInteractChess(arg_15_0)
	arg_15_0.IsExecuting_ = false
	arg_15_0.ExecutingChess_ = nil
end

function var_0_0.IsExecuting(arg_16_0)
	return arg_16_0.IsExecuting_
end

function var_0_0.EventsEnd(arg_17_0)
	if arg_17_0.eventQueueManager_:CurEventTiming() == NewChessConst.TIMING_INTERACT then
		arg_17_0.IsExecuting_ = false
		arg_17_0.ExecutingChess_ = nil
	end

	arg_17_0.taskManager_:CheckTask()

	if arg_17_0.eventQueueManager_:PromoteToNextEvent() then
		arg_17_0:DoNextEvent()
	else
		arg_17_0.eventQueueManager_:Clear()
		arg_17_0.globalManager_:CheckSettlementGlobalEventList()
		arg_17_0.globalManager_:CheckStartGlobalEventList()
	end
end

function var_0_0.ExecutChess(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 ~= nil then
		arg_18_0:CreateEventQueue(arg_18_2, arg_18_3, arg_18_1)
	end
end

function var_0_0.StartExecuteEvent(arg_19_0)
	if arg_19_0.eventQueueManager_:CurEventTiming() then
		return
	end

	if arg_19_0.eventQueueManager_:PromoteToNextEvent() then
		arg_19_0:DoNextEvent()
	else
		arg_19_0:EventsEnd()
	end
end

function var_0_0.CreateEventQueue(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0.eventQueueManager_:InsertNewEventQueue(arg_20_2, arg_20_3, arg_20_1)
end

function var_0_0.DoNextEvent(arg_21_0)
	if arg_21_0.eventQueueManager_:IsEventEnd() then
		arg_21_0:EventsEnd()

		return
	end

	local var_21_0, var_21_1 = arg_21_0.eventQueueManager_:GetCurFunc()

	arg_21_0.eventQueueManager_:PromoteCurEventProgress()

	return var_21_0(unpack(var_21_1))
end

function var_0_0.GetExecutingChess(arg_22_0)
	return arg_22_0.eventQueueManager_:GetExecutingChess()
end

function var_0_0.SetPosition(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.characterPos_ and arg_23_0.characterPos_[1] == arg_23_1 and arg_23_0.characterPos_[2] == arg_23_2 then
		return false
	end

	NewWarChessData:SetCurrentIndex(arg_23_1, arg_23_2)

	arg_23_0.characterPos_ = {
		arg_23_1,
		arg_23_2
	}

	return true
end

function var_0_0.GetPosition(arg_24_0)
	return arg_24_0.characterPos_
end

function var_0_0.SetChanceInteract(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.isSelectEventInteracting_ = arg_25_1
	arg_25_0.selectEventInteracChess_ = arg_25_2
end

function var_0_0.GetChanceInteracChess(arg_26_0)
	return arg_26_0.selectEventInteracChess_
end

function var_0_0.JumpBoard(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	arg_27_0:ShowBlock()
	NewChessLuaBridge.JumpBoard(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
end

function var_0_0.BattleStart(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	arg_28_0.battleStart_ = true
	arg_28_0.battleResult_ = nil
	arg_28_0.curChanceID_ = arg_28_1
	arg_28_0.curChanceItemID_ = arg_28_2
	arg_28_0.curDiceNumList_ = arg_28_3
	arg_28_0.curAffixList_ = arg_28_4

	local var_28_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_28_0 then
		arg_28_0.originShadowRotationImmediately = var_28_0.shadowRotationImmediately
		var_28_0.shadowRotationImmediately = true
	end

	NewChessLuaBridge.SetCameraControlEnable(false)
	NewWarChessData:SetCharacterDirection(NewChessLuaBridge.GetPlayerDirection())
end

function var_0_0.GetCurBattleAffix(arg_29_0)
	return arg_29_0.curAffixList_
end

function var_0_0.BattleSuccess(arg_30_0)
	arg_30_0.battleResult_ = true
end

function var_0_0.IsBattleBack(arg_31_0)
	return arg_31_0.battleStart_
end

function var_0_0.BattleFinish(arg_32_0)
	if arg_32_0.battleStart_ then
		local var_32_0 = {}

		for iter_32_0 = 1, #arg_32_0.curDiceNumList_ do
			table.insert(var_32_0, arg_32_0.curDiceNumList_[iter_32_0])
		end

		NewWarChessData:RemoveDice(var_32_0)

		if arg_32_0.battleResult_ then
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = arg_32_0.curChanceID_,
				chanceItemID = arg_32_0.curChanceItemID_
			})
		else
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = NewWarChessData:GetServerChanceID()
			})
		end
	end

	if not arg_32_0.battleStart_ then
		return
	end

	arg_32_0:ClearBattleData()
end

function var_0_0.ClearBattleData(arg_33_0)
	arg_33_0.battleStart_ = false
	arg_33_0.battleResult_ = nil
	arg_33_0.curChanceID_ = 0
	arg_33_0.curChanceItemID_ = 0
	arg_33_0.curDiceNumList_ = {}
	arg_33_0.curAffixList_ = {}

	local var_33_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_33_0 then
		var_33_0.shadowRotationImmediately = arg_33_0.originShadowRotationImmediately
	end

	NewChessLuaBridge.SetCameraControlEnable(true)
end

function var_0_0.ChangeGridByExtentID(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	arg_34_0:ShowBlock()
	NewChessLuaBridge.ChangeGridByIndex(arg_34_1, arg_34_2, arg_34_3, arg_34_4, function()
		arg_34_0:CloseBlock()

		if arg_34_4 then
			NewWarChessData:ChangeGridLuaInheritDir(arg_34_1, arg_34_2, arg_34_3)
		else
			NewWarChessData:ChangeGridLua(arg_34_1, arg_34_2, arg_34_3)
		end

		if arg_34_5 then
			arg_34_5()
		end
	end)
end

function var_0_0.ChangeObjectByExtentID(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	arg_36_0:ShowBlock()
	NewChessLuaBridge.ChangeObjectByIndex(arg_36_1, arg_36_2, arg_36_3, function()
		arg_36_0:CloseBlock()
		NewWarChessData:ChangeObjectLua(arg_36_1, arg_36_2, arg_36_3)

		if arg_36_4 then
			arg_36_4()
		end
	end)
end

function var_0_0.DeleteObject(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0:ShowBlock()
	NewChessLuaBridge.DeleteObject(arg_38_1, arg_38_2, function()
		arg_38_0:CloseBlock()
		NewWarChessData:DeleteObjectLua(arg_38_1, arg_38_2)

		if arg_38_3 then
			arg_38_3()
		end
	end)
end

function var_0_0.ChangeGridDirection(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	arg_40_0:ShowBlock()
	NewChessLuaBridge.RotateGrid(arg_40_1, arg_40_2, arg_40_3 * 60, arg_40_4, function()
		arg_40_0:CloseBlock()
		NewWarChessData:ChangeGridDirection(arg_40_1, arg_40_2, arg_40_3)

		if arg_40_5 then
			arg_40_5()
		end
	end)
end

function var_0_0.LookAtPlayerWithCurPos(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = NewWarChessData:GetCurrentIndex()

	if math.abs(var_42_0.x - arg_42_1) + math.abs(var_42_0.z - arg_42_2) > 2 then
		NewChessLuaBridge.LookAtPlayer(function()
			if arg_42_3 then
				arg_42_3()
			end
		end)
	elseif arg_42_3 then
		arg_42_3()
	end
end

function var_0_0.MoveToTarget(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_0:ShowBlock()
	arg_44_0:ClearAllSelectEffect()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
	NewChessLuaBridge.MoveTargetSmooth(arg_44_1, arg_44_2, function()
		manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, true)
		arg_44_0:CloseBlock()

		if arg_44_3 then
			arg_44_3()
		end
	end, true)
end

function var_0_0.PlayGridAnimation(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	arg_46_0.blockerManager_:ShowBlocker()
	NewChessLuaBridge.PlayGridAnimation(arg_46_1, arg_46_2, arg_46_3, arg_46_4, function()
		arg_46_0.blockerManager_:HideBlocker()
		arg_46_5()
	end)
end

function var_0_0.OnMoveEnd(arg_48_0)
	arg_48_0.blockerManager_:HideMoveBlocker()
	arg_48_0:ClearAllSelectEffect()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
end

function var_0_0.ShowBlock(arg_49_0)
	arg_49_0.blockerManager_:ShowBlocker()
end

function var_0_0.CloseBlock(arg_50_0)
	arg_50_0.blockerManager_:HideBlocker()
end

function var_0_0.CreateTips(arg_51_0, arg_51_1)
	arg_51_0.tipsManager_:CreateTips(arg_51_1)
end

function var_0_0.AddBuff(arg_52_0, arg_52_1)
	arg_52_0.buffManager_:AddBuff(arg_52_1)
end

function var_0_0.UpdateBuff(arg_53_0)
	arg_53_0.buffManager_:UpdateBuff()
end

function var_0_0.RemoveBuff(arg_54_0, arg_54_1)
	arg_54_0.buffManager_:RemoveBuff(arg_54_1)
end

function var_0_0.Dispose(arg_55_0)
	manager.windowBar:ClearWhereTag()

	arg_55_0.characterPos_ = nil
	arg_55_0.map_ = nil
	arg_55_0.IsExecuting_ = false
	arg_55_0.ExecutingChess_ = nil
	arg_55_0.isSelectEventInteracting_ = false
	arg_55_0.selectEventInteracChess_ = nil
	arg_55_0.curChanceID_ = 0
	arg_55_0.curChanceItemID_ = 0
	arg_55_0.curDiceNumList_ = {}
	arg_55_0.curAffixList_ = {}

	arg_55_0.eventQueueManager_:Clear()
	arg_55_0.buffManager_:Dispose()
	arg_55_0.taskManager_:Dispose()
	arg_55_0.globalManager_:Dispose()
	arg_55_0:DisposeSupportModule()
end

return var_0_0
