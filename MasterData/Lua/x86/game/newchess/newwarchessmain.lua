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

function var_0_0:SetUp(arg_2_1)
	self:LoadMap(arg_2_1)

	local var_2_0 = NewWarChessData:GetCurrentIndex()

	self.characterPos_ = {
		var_2_0.x,
		var_2_0.z
	}

	local var_2_1 = NewWarChessData:GetCurrentWarChessMapData()

	self.taskManager_:SetServerData(var_2_1.taskList)
	self.buffManager_:SetServerData(var_2_1.buffList)
	self.globalManager_:SetServerData(var_2_1.globalEventList)
end

function var_0_0:CreateSupportModule()
	if self.blockerManager_ == nil then
		self.blockerManager_ = NewWarChessBlockerManager.New(manager.ui.canvas)
	end

	if self.tipsManager_ == nil then
		self.tipsManager_ = NewChessTipsManager.New()
	end
end

function var_0_0:DisposeSupportModule()
	if self.blockerManager_ then
		self.blockerManager_:Dispose()

		self.blockerManager_ = nil
	end

	if self.tipsManager_ then
		self.tipsManager_:Dispose()

		self.tipsManager_ = nil
	end
end

function var_0_0:LoadMap(arg_5_1)
	self.ChapterID = arg_5_1
	self.map_ = NewChessTools.LoadMap(arg_5_1)

	if not self.map_ then
		-- block empty
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.map_.mapInfo) do
		var_5_0[NewChessTools.TwoDToOneD(iter_5_1.x, iter_5_1.z)] = iter_5_1
	end

	NewWarChessData:SetExtendMap(self.map_.extendInfo)
	NewWarChessData:SetExtendObjectMap(self.map_.extendThingInfo)
	NewWarChessData:SetJsonMap(var_5_0)
end

function var_0_0:ShowPathEffect(arg_6_1, arg_6_2, arg_6_3)
	self:ClearAllSelectEffect()
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

function var_0_0:StartMoveToCaChePath()
	self.blockerManager_:ShowMoveBlocker()
	NewChessLuaBridge.MoveToCachePos()
	manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, false)
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.MOVING)
end

function var_0_0:ClearEndPoint()
	self:ClearAllSelectEffect()

	self.IsExecuting_ = false
	self.ExecutingChess_ = nil

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
end

function var_0_0:ExecuteChessTiming(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2.gridData

	if arg_11_1 == NewChessConst.TIMING_START then
		NewWarChessData:SetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN", 1)

		local var_11_4 = NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].eventpool_id

		self:ExecutChess(arg_11_1, nil, (NewWarChessData:GetServerEvent(arg_11_1, {})))
	elseif arg_11_1 == NewChessConst.TIMING_WALK_OUT then
		if var_11_0.exitParamList and var_11_0.exitParamList.Length > 0 then
			self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})))
		end
	elseif arg_11_1 == NewChessConst.TIMING_WALK_INTO then
		if var_11_0.enterParamList and var_11_0.enterParamList.Length > 0 then
			self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})))
		end

		if not arg_11_2.isTelePort then
			NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", (math.floor(-NewWarChessHexCfg[var_11_0.typeID].penalty * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT_COST_TIMES") / 1000))))
			self:UpdateBuff()
		end

		if self.eventQueueManager_:IsEmpty() then
			self.globalManager_:CheckSettlementGlobalEventList()
		end
	elseif arg_11_1 == NewChessConst.TIMING_INTERACT then
		var_11_0 = self.ExecutingChess_

		if self.ExecutingChess_.clickParamList and var_11_0.clickParamList.Length > 0 then
			if NewWarChessEventPoolCfg[var_11_0.clickParamList[0]] == nil then
				error("clickParamList触发的eventPoolID不存在！", var_11_0.clickParamList[0])

				return
			end

			NewWarChessAction.ClickGrid(var_11_0.x, var_11_0.z, false, function()
				if NewWarChessEventPoolCfg[var_11_0.clickParamList[0]].type == NewChessConst.EVENTPOOL_TYPE.NEWWARCHESS_EVENT then
					self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
						var_11_0.x,
						var_11_0.z
					})))
					self:StartExecuteEvent()
				else
					manager.NewChessManager:SetChanceInteract(true, var_11_0)
					JumpTools.OpenPageByJump("/newWarChessChanceView", {
						chanceID = NewWarChessData:GetServerChanceID()
					})
					self:ClearInteractChess()
				end
			end)
		end
	elseif arg_11_1 == NewChessConst.TIMING_WALK_OUT_OBJECT then
		if var_11_0.objectExitParamList and var_11_0.objectExitParamList.Length > 0 then
			self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})))
		end
	elseif arg_11_1 == NewChessConst.TIMING_WALK_INTO_OBJECT then
		if var_11_0.objectEnterParamList and var_11_0.objectEnterParamList.Length > 0 then
			self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
				var_11_0.x,
				var_11_0.z
			})))
		end
	elseif arg_11_1 == NewChessConst.TIMING_INTERACT_OBJECT then
		var_11_0 = self.ExecutingChess_

		if self.ExecutingChess_.objectClickParamList and var_11_0.objectClickParamList.Length > 0 then
			if NewWarChessEventPoolCfg[var_11_0.objectClickParamList[0]] == nil then
				error("objectClickParamList触发的eventPoolID不存在！", var_11_0.objectClickParamList[0])

				return
			end

			NewWarChessAction.ClickGrid(var_11_0.x, var_11_0.z, false, function()
				if NewWarChessEventPoolCfg[var_11_0.objectClickParamList[0]].type == NewChessConst.EVENTPOOL_TYPE.NEWWARCHESS_EVENT then
					self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
						var_11_0.x,
						var_11_0.z
					})))
					self:StartExecuteEvent()
				else
					manager.NewChessManager:SetChanceInteract(true, var_11_0)
					JumpTools.OpenPageByJump("/newWarChessChanceView", {
						chanceID = NewWarChessData:GetServerChanceID()
					})
				end
			end)
		end
	elseif arg_11_1 == NewChessConst.TIMING_FARCLICK_OBJECT and var_11_0.objectFarClickParamList and var_11_0.objectFarClickParamList.Length > 0 then
		self:ExecutChess(arg_11_1, var_11_0, (NewWarChessData:GetServerEvent(arg_11_1, {
			var_11_0.x,
			var_11_0.z
		})))
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

function var_0_0:IsExecuting()
	return self.IsExecuting_
end

function var_0_0:EventsEnd()
	if self.eventQueueManager_:CurEventTiming() == NewChessConst.TIMING_INTERACT then
		self.IsExecuting_ = false
		self.ExecutingChess_ = nil
	end

	self.taskManager_:CheckTask()

	if self.eventQueueManager_:PromoteToNextEvent() then
		self:DoNextEvent()
	else
		self.eventQueueManager_:Clear()
		self.globalManager_:CheckSettlementGlobalEventList()
		self.globalManager_:CheckStartGlobalEventList()
	end
end

function var_0_0:ExecutChess(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 ~= nil then
		self:CreateEventQueue(arg_18_2, arg_18_3, arg_18_1)
	end
end

function var_0_0:StartExecuteEvent()
	if self.eventQueueManager_:CurEventTiming() then
		return
	end

	if self.eventQueueManager_:PromoteToNextEvent() then
		self:DoNextEvent()
	else
		self:EventsEnd()
	end
end

function var_0_0:CreateEventQueue(arg_20_1, arg_20_2, arg_20_3)
	self.eventQueueManager_:InsertNewEventQueue(arg_20_2, arg_20_3, arg_20_1)
end

function var_0_0:DoNextEvent()
	if self.eventQueueManager_:IsEventEnd() then
		self:EventsEnd()

		return
	end

	local var_21_0, var_21_1 = self.eventQueueManager_:GetCurFunc()

	self.eventQueueManager_:PromoteCurEventProgress()

	return var_21_0(unpack(var_21_1))
end

function var_0_0:GetExecutingChess()
	return self.eventQueueManager_:GetExecutingChess()
end

function var_0_0:SetPosition(arg_23_1, arg_23_2)
	if self.characterPos_ and self.characterPos_[1] == arg_23_1 and self.characterPos_[2] == arg_23_2 then
		return false
	end

	NewWarChessData:SetCurrentIndex(arg_23_1, arg_23_2)

	self.characterPos_ = {
		arg_23_1,
		arg_23_2
	}

	return true
end

function var_0_0:GetPosition()
	return self.characterPos_
end

function var_0_0.SetChanceInteract(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.isSelectEventInteracting_ = arg_25_1
	arg_25_0.selectEventInteracChess_ = arg_25_2
end

function var_0_0:GetChanceInteracChess()
	return self.selectEventInteracChess_
end

function var_0_0:JumpBoard(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	self:ShowBlock()
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

function var_0_0:GetCurBattleAffix()
	return self.curAffixList_
end

function var_0_0.BattleSuccess(arg_30_0)
	arg_30_0.battleResult_ = true
end

function var_0_0:IsBattleBack()
	return self.battleStart_
end

function var_0_0:BattleFinish()
	if self.battleStart_ then
		local var_32_0 = {}

		for iter_32_0 = 1, #self.curDiceNumList_ do
			table.insert(var_32_0, self.curDiceNumList_[iter_32_0])
		end

		NewWarChessData:RemoveDice(var_32_0)

		if self.battleResult_ then
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = self.curChanceID_,
				chanceItemID = self.curChanceItemID_
			})
		else
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = NewWarChessData:GetServerChanceID()
			})
		end
	end

	if not self.battleStart_ then
		return
	end

	self:ClearBattleData()
end

function var_0_0:ClearBattleData()
	self.battleStart_ = false
	self.battleResult_ = nil
	self.curChanceID_ = 0
	self.curChanceItemID_ = 0
	self.curDiceNumList_ = {}
	self.curAffixList_ = {}

	local var_33_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_33_0 then
		var_33_0.shadowRotationImmediately = self.originShadowRotationImmediately
	end

	NewChessLuaBridge.SetCameraControlEnable(true)
end

function var_0_0:ChangeGridByExtentID(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	self:ShowBlock()
	NewChessLuaBridge.ChangeGridByIndex(arg_34_1, arg_34_2, arg_34_3, arg_34_4, function()
		self:CloseBlock()

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

function var_0_0:ChangeObjectByExtentID(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	self:ShowBlock()
	NewChessLuaBridge.ChangeObjectByIndex(arg_36_1, arg_36_2, arg_36_3, function()
		self:CloseBlock()
		NewWarChessData:ChangeObjectLua(arg_36_1, arg_36_2, arg_36_3)

		if arg_36_4 then
			arg_36_4()
		end
	end)
end

function var_0_0:DeleteObject(arg_38_1, arg_38_2, arg_38_3)
	self:ShowBlock()
	NewChessLuaBridge.DeleteObject(arg_38_1, arg_38_2, function()
		self:CloseBlock()
		NewWarChessData:DeleteObjectLua(arg_38_1, arg_38_2)

		if arg_38_3 then
			arg_38_3()
		end
	end)
end

function var_0_0:ChangeGridDirection(arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	self:ShowBlock()
	NewChessLuaBridge.RotateGrid(arg_40_1, arg_40_2, arg_40_3 * 60, arg_40_4, function()
		self:CloseBlock()
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

function var_0_0:MoveToTarget(arg_44_1, arg_44_2, arg_44_3)
	self:ShowBlock()
	self:ClearAllSelectEffect()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
	NewChessLuaBridge.MoveTargetSmooth(arg_44_1, arg_44_2, function()
		manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, true)
		self:CloseBlock()

		if arg_44_3 then
			arg_44_3()
		end
	end, true)
end

function var_0_0:PlayGridAnimation(arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	self.blockerManager_:ShowBlocker()
	NewChessLuaBridge.PlayGridAnimation(arg_46_1, arg_46_2, arg_46_3, arg_46_4, function()
		self.blockerManager_:HideBlocker()
		arg_46_5()
	end)
end

function var_0_0:OnMoveEnd()
	self.blockerManager_:HideMoveBlocker()
	self:ClearAllSelectEffect()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
end

function var_0_0:ShowBlock()
	self.blockerManager_:ShowBlocker()
end

function var_0_0:CloseBlock()
	self.blockerManager_:HideBlocker()
end

function var_0_0:CreateTips(arg_51_1)
	self.tipsManager_:CreateTips(arg_51_1)
end

function var_0_0:AddBuff(arg_52_1)
	self.buffManager_:AddBuff(arg_52_1)
end

function var_0_0:UpdateBuff()
	self.buffManager_:UpdateBuff()
end

function var_0_0:RemoveBuff(arg_54_1)
	self.buffManager_:RemoveBuff(arg_54_1)
end

function var_0_0:Dispose()
	manager.windowBar:ClearWhereTag()

	self.characterPos_ = nil
	self.map_ = nil
	self.IsExecuting_ = false
	self.ExecutingChess_ = nil
	self.isSelectEventInteracting_ = false
	self.selectEventInteracChess_ = nil
	self.curChanceID_ = 0
	self.curChanceItemID_ = 0
	self.curDiceNumList_ = {}
	self.curAffixList_ = {}

	self.eventQueueManager_:Clear()
	self.buffManager_:Dispose()
	self.taskManager_:Dispose()
	self.globalManager_:Dispose()
	self:DisposeSupportModule()
end

return var_0_0
