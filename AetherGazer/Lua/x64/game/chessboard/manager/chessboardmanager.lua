local var_0_0 = singletonClass("ChessBoardManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.heroEntity_ = ChessBoardHeroEntity.New()
	arg_1_0.taskManager_ = ChessBoardTaskManager.New()
	arg_1_0.eventQueueManager_ = ChessBoardEventQueue.New()
	arg_1_0.NPCManager_ = ChessBoardNPCManager.GetInstance()

	arg_1_0.NPCManager_:Init()

	arg_1_0.curCanMovePosListCache_ = {}
	arg_1_0.isSelectPosing_ = false
	arg_1_0.isSelectNpc_ = false
	arg_1_0.isSelectMapPos_ = false
	arg_1_0.selectPropID = nil
	arg_1_0.curMapTurn_ = 0
	arg_1_0.eventCallBack_ = nil
	arg_1_0.timerIndex = 1
	arg_1_0.delayTimerList = {}
	arg_1_0.isMovingCamera_ = false
	arg_1_0.isCanUseProp_ = false
	arg_1_0.tmpPropList = {}
	arg_1_0.isArenaChance_ = false
	arg_1_0.isArenaChanceFinishSend_ = false
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.tmpPropList = {}

	arg_2_0:LoadMap(arg_2_1.mapId)
	arg_2_0.heroEntity_:SetServerData(arg_2_1.heroInfos)
	arg_2_0.NPCManager_:SetServerData(arg_2_1.NPCInfoList)
	arg_2_0.taskManager_:SetServerData(arg_2_1.taskList)

	arg_2_0.curMapTurn_ = arg_2_1.turn
	arg_2_0.curMapTurnEventCfg_ = ChessBoardLevelCfg[arg_2_1.mapId].level_event
end

function var_0_0.LoadMap(arg_3_0, arg_3_1)
	arg_3_0.map_ = ChessBoardTools.LoadMap(arg_3_1)

	if not arg_3_0.map_ then
		-- block empty
	end

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.map_.mapInfo) do
		local var_3_1 = iter_3_1.x
		local var_3_2 = iter_3_1.z

		var_3_0[ChessBoardTools.TwoDToOneD(var_3_1, var_3_2)] = iter_3_1
	end

	ChessBoardData:SetJsonMap(var_3_0, arg_3_0.map_.extendInfo, arg_3_0.map_.extendThingInfo)
	ChessBoardData:SetMapWidthAndHeight(arg_3_0.map_.width, arg_3_0.map_.height)
end

function var_0_0.CreateSupportModule(arg_4_0)
	if arg_4_0.blockerManager_ == nil then
		arg_4_0.blockerManager_ = ChessBoardBlockManager.New(manager.ui.canvas)
	end

	if arg_4_0.diceManager_ == nil then
		arg_4_0.diceManager_ = ChessBoardDiceManager.New()
	end
end

function var_0_0.DisposeSupportModule(arg_5_0)
	if arg_5_0.blockerManager_ then
		arg_5_0.blockerManager_:Dispose()

		arg_5_0.blockerManager_ = nil
	end

	if arg_5_0.diceManager_ then
		arg_5_0.diceManager_:Dispose()

		arg_5_0.diceManager_ = nil
	end

	arg_5_0.isFastModule_ = false
end

function var_0_0.AddBuff(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:FindEntity(arg_6_1)

	if var_6_0 then
		var_6_0:AddBuff(arg_6_2)
	end
end

function var_0_0.RemoveBuff(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:FindEntity(arg_7_1)

	if var_7_0 then
		var_7_0:RemoveBuff(arg_7_2)
	end
end

function var_0_0.FindEntity(arg_8_0, arg_8_1)
	if arg_8_0.heroEntity_:GetEntityId() == arg_8_1 then
		return arg_8_0.heroEntity_
	else
		return arg_8_0.NPCManager_:FindEntity(arg_8_1)
	end
end

function var_0_0.ExecuteTiming(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.gridData
	local var_9_1 = arg_9_2.playerA
	local var_9_2 = arg_9_2.playerB
	local var_9_3 = arg_9_2.isTelePort
	local var_9_4 = arg_9_2.buffID
	local var_9_5 = arg_9_2.buffEffectID
	local var_9_6 = arg_9_2.taskID
	local var_9_7 = arg_9_2.mapTurnNum
	local var_9_8 = arg_9_2.chanceID

	if arg_9_1 == ChessBoardConst.TIMING.FIRST_ENTER_MAP then
		arg_9_0:ExecuteEvent(arg_9_1, {}, nil, 0, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.BUFF_STEP then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_5
		}, nil, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.BUFF_DELETE or arg_9_1 == ChessBoardConst.TIMING.BUFF_ADD or arg_9_1 == ChessBoardConst.TIMING.BUFF_TURN then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_4
		}, nil, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.TASK_FINISH then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_6
		}, nil, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.MAP_EVENT then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_7
		}, nil, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.CHANCE_FINISH then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_8
		}, var_9_0, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.NPC_TURN_START or arg_9_1 == ChessBoardConst.TIMING.NPC_TURN_END then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_1
		}, nil, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.ENTER_FLOOR or arg_9_1 == ChessBoardConst.TIMING.EXIT_FLOOR or arg_9_1 == ChessBoardConst.TIMING.START_MOVE_FLOOR or arg_9_1 == ChessBoardConst.TIMING.END_MOVE_FLOOR or arg_9_1 == ChessBoardConst.TIMING.ENTER_THING or arg_9_1 == ChessBoardConst.TIMING.EXIT_THING or arg_9_1 == ChessBoardConst.TIMING.START_MOVE_THING or arg_9_1 == ChessBoardConst.TIMING.END_MOVE_THING then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_0.x,
			var_9_0.z
		}, var_9_0, var_9_1, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.NPC_CROSS_HERO or arg_9_1 == ChessBoardConst.TIMING.NPC_STAY_NPC or arg_9_1 == ChessBoardConst.TIMING.NPC_STAY_HERO then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_1
		}, var_9_0, var_9_1, var_9_2)
	elseif arg_9_1 == ChessBoardConst.TIMING.HERO_CROSS_NPC or arg_9_1 == ChessBoardConst.TIMING.HERO_STAY_NPC then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_2
		}, var_9_0, var_9_1, var_9_2)
	elseif arg_9_1 == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO or arg_9_1 == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO or arg_9_1 == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC or arg_9_1 == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC then
		arg_9_0:ExecuteEvent(arg_9_1, {
			var_9_5
		}, var_9_0, var_9_1, var_9_2)
	end
end

function var_0_0.ExecuteEvent(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = ChessBoardData:GetServerEvent(arg_10_1, arg_10_2, arg_10_4, arg_10_5)

	if var_10_0 ~= nil then
		arg_10_0.eventQueueManager_:InsertNewEventQueue(arg_10_1, arg_10_3, var_10_0)
	end
end

function var_0_0.StartExecuteEvent(arg_11_0, arg_11_1)
	if arg_11_1 ~= nil then
		if arg_11_0.eventCallBack_ ~= nil then
			error("事件回调出错，当前事件回调不未空！同时存在两个回调，联系李润青")
		else
			arg_11_0.eventCallBack_ = arg_11_1
		end
	end

	if arg_11_0.eventQueueManager_:CurEventTiming() then
		return
	end

	if arg_11_0.eventQueueManager_:PromoteToNextEvent() then
		arg_11_0:DoNextEvent()
	else
		arg_11_0:EventsEnd()
	end
end

function var_0_0.DoNextEvent(arg_12_0)
	if arg_12_0.eventQueueManager_:IsEventEnd() then
		arg_12_0:EventsEnd()

		return
	end

	local var_12_0, var_12_1 = arg_12_0.eventQueueManager_:GetCurFunc()

	arg_12_0.eventQueueManager_:PromoteCurEventProgress()

	return var_12_0(unpack(var_12_1))
end

function var_0_0.EventsEnd(arg_13_0)
	if arg_13_0.eventQueueManager_:PromoteToNextEvent() then
		arg_13_0:DoNextEvent()
	else
		arg_13_0.eventQueueManager_:Clear()
		arg_13_0.taskManager_:CheckTask()

		if arg_13_0.eventCallBack_ ~= nil then
			local var_13_0 = arg_13_0.eventCallBack_

			arg_13_0.eventCallBack_ = nil

			var_13_0()
		end
	end
end

function var_0_0.GetExecutingChess(arg_14_0)
	return arg_14_0.eventQueueManager_:GetExecutingChess()
end

function var_0_0.SetHeroAttribute(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_0.heroEntity_:SetAttribute(arg_15_1, arg_15_2)
end

function var_0_0.SubHeroAttribute(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0.heroEntity_:SubAttribute(arg_16_1, arg_16_2)
end

function var_0_0.GetHeroAttribute(arg_17_0, arg_17_1)
	return arg_17_0.heroEntity_:GetAttribute(arg_17_1)
end

function var_0_0.GetCurChanceInfo(arg_18_0)
	return arg_18_0.heroEntity_:GetCurChanceInfo()
end

function var_0_0.AddHeroProp(arg_19_0, arg_19_1)
	ChessBoardData:FixHeroPropAddProp(arg_19_1)
	arg_19_0.heroEntity_:AddHeroProp(arg_19_1)
	manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
end

function var_0_0.RemoveHeroProp(arg_20_0, arg_20_1)
	ChessBoardData:FixHeroPropDelProp(arg_20_1)
	arg_20_0.heroEntity_:DelHeroProp(arg_20_1)
	manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
end

function var_0_0.GetHeroProp(arg_21_0)
	return arg_21_0.heroEntity_:GetHeroProp()
end

function var_0_0.ContainProp(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetHeroProp()

	return table.indexof(var_22_0, arg_22_1)
end

function var_0_0.AddTmpHeroProp(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 then
		arg_23_0:RemoveHeroProp(arg_23_2)
	end

	arg_23_0:AddHeroProp(arg_23_1)
	table.insert(arg_23_0.tmpPropList, {
		prop_id = arg_23_1,
		replace_prop_id = arg_23_2 or 0
	})
end

function var_0_0.SendTmpPropToServer(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.tmpPropList and #arg_24_0.tmpPropList > 0 then
		arg_24_0:SendTmpPropList(arg_24_1, arg_24_2)
	else
		arg_24_0:ReconnectionTmpListProp(arg_24_1, arg_24_2)
	end
end

function var_0_0.SendTmpPropList(arg_25_0, arg_25_1, arg_25_2)
	arg_25_1 = arg_25_1 or 1

	local var_25_0 = arg_25_0.tmpPropList[arg_25_1]

	if var_25_0 then
		ChessBoardAction.GetSelectProp(var_25_0.prop_id, var_25_0.replace_prop_id or 0, function()
			arg_25_0:SendTmpPropList(arg_25_1 + 1, arg_25_2)
		end)
	else
		arg_25_0.tmpPropList = {}

		if arg_25_2 then
			arg_25_2()
		end
	end
end

function var_0_0.ReconnectionTmpListProp(arg_27_0, arg_27_1, arg_27_2)
	arg_27_1 = arg_27_1 or 1

	local var_27_0 = ChessBoardData:GetCurrentChessBoardMapData().heroInfos.tmp_item[arg_27_1]

	if var_27_0 then
		arg_27_0:TmpPropGet(var_27_0, arg_27_1, arg_27_2)
	else
		ChessBoardData:FixClearTmpProp()

		if arg_27_2 then
			arg_27_2()
		end
	end
end

function var_0_0.TmpPropGet(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if #manager.ChessBoardManager:GetHeroProp() >= 6 then
		JumpTools.OpenPageByJump("/ChessBoardPropView", {
			propID = arg_28_1,
			viewType = ChessBoardConst.VIEW_TYPE.CHANGE_PROP,
			changePropCallback = function(arg_29_0)
				arg_28_0:TmpPropAction(arg_28_2, arg_28_3, arg_28_1, arg_29_0)
			end,
			giveUpPropCallback = function()
				ChessBoardAction.GiveUpProp(arg_28_1)
				gameContext:Go("/chessBoardHomeView")
				arg_28_0:ReconnectionTmpListProp(arg_28_2 + 1, arg_28_3)
			end
		})
	else
		arg_28_0:TmpPropAction(arg_28_2, arg_28_3, arg_28_1)
	end
end

function var_0_0.TmpPropAction(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	gameContext:Go("/chessBoardHomeView")

	if arg_31_4 then
		arg_31_0:RemoveHeroProp(arg_31_4)
	end

	arg_31_0:AddHeroProp(arg_31_3)
	ChessBoardAction.GetSelectProp(arg_31_3, arg_31_4)
	manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GET_PROP, {
		isGet = true,
		propID = arg_31_3,
		callback = function()
			arg_31_0:ReconnectionTmpListProp(arg_31_1 + 1, arg_31_2)
		end
	})
end

function var_0_0.SetChanceServerData(arg_33_0, arg_33_1)
	ChessBoardData:FixHeroChanceData(arg_33_1)
	arg_33_0.heroEntity_:SetChanceServerData(arg_33_1)
end

function var_0_0.GetCurHeroPosGridData(arg_34_0)
	local var_34_0, var_34_1 = arg_34_0.heroEntity_:GetPosAndDir()

	return ChessBoardLuaBridge.GetGridData(var_34_0.x, var_34_0.z)
end

function var_0_0.TelePortHeroToPosition(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	ChessBoardLuaBridge.SetHeroPosAndDir(arg_35_1, arg_35_2, arg_35_3)
	arg_35_0.heroEntity_:TelePortHeroToPosition(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	arg_35_0:PlayPortHeroEffect(arg_35_1, arg_35_2)
	ChessBoardLuaBridge.LookAtPlayer()
end

function var_0_0.PlayPortHeroEffect(arg_36_0, arg_36_1, arg_36_2)
	manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_portal", "")
	ChessBoardLuaBridge.ShowTranferEffect(arg_36_1, arg_36_2)
	arg_36_0:AddDelayTimer(2, function()
		ChessBoardLuaBridge.ClearTranferEffect()
	end)
end

function var_0_0.SetNPCAttribute(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	return arg_38_0.NPCManager_:SetNPCAttribute(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0.SubNPCAttribute(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	return arg_39_0.NPCManager_:SubNPCAttribute(arg_39_1, arg_39_2, arg_39_3)
end

function var_0_0.GetNPCAttribute(arg_40_0, arg_40_1, arg_40_2)
	return arg_40_0.NPCManager_:GetNPCAttribute(arg_40_1, arg_40_2)
end

function var_0_0.AddNPC(arg_41_0, arg_41_1)
	local var_41_0 = ChessBoardNPCPoolCfg[arg_41_1.typeID]

	ChessBoardLuaBridge.AddNPC(arg_41_1.id, arg_41_1.pos.x, arg_41_1.pos.z, arg_41_1.dir, var_41_0.prefab, arg_41_1.actionType or -1)
	ChessBoardData:FixNPCDataAddNPC(arg_41_1)
	arg_41_0.NPCManager_:AddNPC(arg_41_1)
end

function var_0_0.DeleteNPC(arg_42_0, arg_42_1)
	ChessBoardLuaBridge.DeleteNPC(arg_42_1)
	ChessBoardData:FixNPCDataDeleteNPC(arg_42_1)
	arg_42_0.NPCManager_:DeleteNPC(arg_42_1)
end

function var_0_0.TelePortNPCToPosition(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	ChessBoardLuaBridge.SetNPCPosAndDir(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	arg_43_0.NPCManager_:TelePortNPCToPosition(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	arg_43_0:PlayPortHeroEffect(arg_43_2, arg_43_3)
end

ChessBoardCheckStoryIterator = class("ChessBoardCheckStoryIterator")

function ChessBoardCheckStoryIterator.Ctor(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.curIndex = 0
	arg_44_0.curStoryList = arg_44_1
	arg_44_0.callBack = arg_44_2

	manager.ChessBoardManager.blockerManager_:ShowBlocker()
end

function ChessBoardCheckStoryIterator.MoveNext(arg_45_0)
	arg_45_0.curIndex = arg_45_0.curIndex + 1

	if arg_45_0.curIndex <= #arg_45_0.curStoryList then
		local var_45_0 = arg_45_0.curStoryList[arg_45_0.curIndex]

		manager.net:SendWithLoadingNew(12002, {
			story_id = var_45_0
		}, 12003, function(arg_46_0, arg_46_1)
			PlayerData:StoryModify(var_45_0)
			IllustratedAction.ModifyPlot(var_45_0)
			arg_45_0:MoveNext()
		end)
	else
		arg_45_0:Dispose()
	end
end

function ChessBoardCheckStoryIterator.Dispose(arg_47_0)
	manager.ChessBoardManager.blockerManager_:HideBlocker()

	arg_47_0.curIndex = 0
	arg_47_0.curStoryList = 0

	arg_47_0.callBack()
end

function var_0_0.UnlockChance(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.heroEntity_:GetCurChanceInfo()

	var_48_0.isUnLock = 1

	arg_48_0:SetChanceServerData(var_48_0)
end

function var_0_0.FinishChance(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = arg_49_0.heroEntity_:GetCurChanceInfo()

	if arg_49_2 == 0 then
		local var_49_1 = ChessBoardChanceCfg[arg_49_1]

		if var_49_1.play_success_story > 0 then
			manager.story:StartChessStoryWithBackground(var_49_1.play_success_story, function(arg_50_0)
				if var_49_1.type == ChessBoardConst.CHANCE_TYPE.ARENA then
					local var_50_0 = {}
					local var_50_1 = 0

					if var_49_1.params[2] ~= 0 then
						table.insert(var_50_0, var_49_1.params[2])
					end

					for iter_50_0, iter_50_1 in pairs(var_49_1.params[3]) do
						table.insert(var_50_0, iter_50_1)
					end

					ChessBoardCheckStoryIterator.New(var_50_0, function()
						if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
							local var_51_0 = arg_49_0:GetCurHeroPosGridData()

							arg_49_0:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
								playerA = 0,
								playerB = -1,
								gridData = var_51_0,
								chanceID = arg_49_1
							})
						end

						arg_49_0:StartExecuteEvent(function()
							if var_49_0.chanceID == arg_49_1 then
								arg_49_0:SetChanceServerData({
									isUnLock = 0,
									chanceID = 0,
									chancePropList = {},
									chanceChooseList = {}
								})
							end

							arg_49_0:FixBGM()

							if arg_49_0:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
								JumpTools.OpenPageByJump("/chessBoardOverView")
							elseif arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
								manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
								ChessBoardAction.HeroMoveEnd(function()
									arg_49_0:OnHeroTurnEnd()
								end)
							else
								manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
							end
						end)
					end):MoveNext()
				else
					if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
						local var_50_2 = arg_49_0:GetCurHeroPosGridData()

						arg_49_0:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
							playerA = 0,
							playerB = -1,
							gridData = var_50_2,
							chanceID = arg_49_1
						})
					end

					arg_49_0:StartExecuteEvent(function()
						if var_49_0.chanceID == arg_49_1 then
							arg_49_0:SetChanceServerData({
								isUnLock = 0,
								chanceID = 0,
								chancePropList = {},
								chanceChooseList = {}
							})
						end

						arg_49_0:FixBGM()

						if arg_49_0:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
							JumpTools.OpenPageByJump("/chessBoardOverView")
						elseif arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
							manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
							ChessBoardAction.HeroMoveEnd(function()
								arg_49_0:OnHeroTurnEnd()
							end)
						else
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
						end
					end)
				end
			end)
		elseif var_49_1.type == ChessBoardConst.CHANCE_TYPE.ARENA then
			local var_49_2 = {}
			local var_49_3 = 0

			if var_49_1.params[2] ~= 0 then
				table.insert(var_49_2, var_49_1.params[2])
			end

			for iter_49_0, iter_49_1 in pairs(var_49_1.params[3]) do
				table.insert(var_49_2, iter_49_1)
			end

			ChessBoardCheckStoryIterator.New(var_49_2, function()
				if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
					local var_56_0 = arg_49_0:GetCurHeroPosGridData()

					arg_49_0:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
						playerA = 0,
						playerB = -1,
						gridData = var_56_0,
						chanceID = arg_49_1
					})
				end

				arg_49_0:StartExecuteEvent(function()
					if var_49_0.chanceID == arg_49_1 then
						arg_49_0:SetChanceServerData({
							isUnLock = 0,
							chanceID = 0,
							chancePropList = {},
							chanceChooseList = {}
						})
					end

					arg_49_0:FixBGM()

					if arg_49_0:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
						JumpTools.OpenPageByJump("/chessBoardOverView")
					elseif arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
						manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
						ChessBoardAction.HeroMoveEnd(function()
							arg_49_0:OnHeroTurnEnd()
						end)
					else
						manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
					end
				end)
			end):MoveNext()
		else
			if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
				local var_49_4 = arg_49_0:GetCurHeroPosGridData()

				arg_49_0:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
					playerA = 0,
					playerB = -1,
					gridData = var_49_4,
					chanceID = arg_49_1
				})
			end

			arg_49_0:StartExecuteEvent(function()
				if var_49_0.chanceID == arg_49_1 then
					arg_49_0:SetChanceServerData({
						isUnLock = 0,
						chanceID = 0,
						chancePropList = {},
						chanceChooseList = {}
					})
				end

				arg_49_0:FixBGM()

				if arg_49_0:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
					JumpTools.OpenPageByJump("/chessBoardOverView")
				elseif arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
					ChessBoardAction.HeroMoveEnd(function()
						arg_49_0:OnHeroTurnEnd()
					end)
				else
					manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
				end

				arg_49_0:FixBGM()
			end)
		end
	else
		local var_49_5 = ChessBoardChanceCfg[arg_49_1]

		if var_49_5.type == ChessBoardConst.CHANCE_TYPE.ARENA then
			if arg_49_3 > 0 then
				if var_49_5.params[2] ~= 0 then
					manager.story:StartChessStoryWithBackground(var_49_5.params[2], function(arg_61_0)
						if var_49_0.chanceID == arg_49_1 then
							arg_49_0:SetChanceServerData({
								isUnLock = 0,
								chanceID = 0,
								chancePropList = {},
								chanceChooseList = {}
							})
						end

						arg_49_0:FixBGM()

						if arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
							manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
							ChessBoardAction.HeroMoveEnd(function()
								arg_49_0:OnHeroTurnEnd()
							end)
						else
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
						end
					end)
				end
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, false)
				arg_49_0:FixBGM()

				if var_49_0.chanceID == arg_49_1 then
					arg_49_0:SetChanceServerData({
						isUnLock = 0,
						chanceID = 0,
						chancePropList = {},
						chanceChooseList = {}
					})
				end

				if arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
					ChessBoardAction.HeroMoveEnd(function()
						arg_49_0:OnHeroTurnEnd()
					end)
				else
					manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
				end
			end
		else
			if var_49_0.chanceID == arg_49_1 then
				arg_49_0:SetChanceServerData({
					isUnLock = 0,
					chanceID = 0,
					chancePropList = {},
					chanceChooseList = {}
				})
			end

			arg_49_0:FixBGM()

			if arg_49_0.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
				manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
				ChessBoardAction.HeroMoveEnd(function()
					arg_49_0:OnHeroTurnEnd()
				end)
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
			end
		end
	end
end

function var_0_0.EffectShow(arg_65_0, arg_65_1)
	if arg_65_1 == ChessBoardConst.EFFECT_TYPE.NORMAL_ARROW then
		local var_65_0, var_65_1 = arg_65_0.heroEntity_:GetPosAndDir()
		local var_65_2 = ChessBoardLuaBridge.FindNextMovePos(var_65_0.x, var_65_0.z, var_65_1)

		ChessBoardLuaBridge.ShowArrowEffect(var_65_0.x, var_65_0.z, var_65_1)
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.MULT_ARROW then
		local var_65_3, var_65_4 = arg_65_0.heroEntity_:GetPosAndDir()

		ChessBoardLuaBridge.ShowMultArrowEffect(var_65_3.x, var_65_3.z, var_65_4)
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.SIGN_NPC then
		arg_65_0.isSelectNpc_ = true

		ChessBoardLuaBridge.SetSelectingNPCMovePos(true)

		local var_65_5 = arg_65_0.NPCManager_:GetAllNpcPos()

		for iter_65_0, iter_65_1 in pairs(var_65_5) do
			ChessBoardLuaBridge.ShowChoiceEffect(iter_65_1.x, iter_65_1.z)
		end
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.SIGN_THING then
		arg_65_0.isSelectMapPos_ = true

		ChessBoardLuaBridge.SetSelectingMapPos(true)
		ChessBoardLuaBridge.ShowAllThingChoiceEffect()
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.SIGN_NO_THING_GRID then
		arg_65_0.isSelectMapPos_ = true

		ChessBoardLuaBridge.SetSelectingMapPos(true)

		local var_65_6, var_65_7 = arg_65_0.heroEntity_:GetPosAndDir()

		ChessBoardLuaBridge.ShowAllNoThingGridChoiceEffect(var_65_6.x, var_65_6.z)
	end
end

function var_0_0.UseSelectNpcProp(arg_66_0, arg_66_1)
	if arg_66_1 then
		arg_66_0.selectPropID = arg_66_1

		arg_66_0:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_NPC)

		local var_66_0 = ChessBoardPropCfg[arg_66_1]

		if var_66_0.type == ChessBoardConst.PROPTYPE.GUN then
			ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_KILL")
		elseif var_66_0.type == ChessBoardConst.PROPTYPE.SWAP then
			ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_SWAP")
		end
	end
end

function var_0_0.UseSelectPlayerProp(arg_67_0, arg_67_1)
	if arg_67_1 then
		arg_67_0.selectPropID = arg_67_1

		arg_67_0:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_NPC)

		local var_67_0, var_67_1 = arg_67_0.heroEntity_:GetPosAndDir()

		ChessBoardLuaBridge.ShowChoiceEffect(var_67_0.x, var_67_0.z)

		if ChessBoardPropCfg[arg_67_1].type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
			ShowTips("CHESSBOARD_SELECT_ADD_BUFF")
		end
	end
end

function var_0_0.CheckCanUseDefuseCard(arg_68_0)
	if ChessBoardLuaBridge.CheckHaveThingCanDestory() then
		return true
	end

	local var_68_0, var_68_1 = arg_68_0.heroEntity_:GetBuffData()

	if var_68_0 ~= nil then
		return true
	end

	return false
end

function var_0_0.UseSelectThingProp(arg_69_0, arg_69_1)
	if arg_69_1 then
		arg_69_0.selectPropID = arg_69_1

		arg_69_0:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_THING)

		if ChessBoardPropCfg[arg_69_1].type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			ShowTips("CHESSBOARD_SELECT_REMOVE")

			local var_69_0, var_69_1 = arg_69_0.heroEntity_:GetPosAndDir()

			ChessBoardLuaBridge.ShowChoiceEffect(var_69_0.x, var_69_0.z)
		end
	end
end

function var_0_0.UseSelectNoThingGridProp(arg_70_0, arg_70_1)
	if arg_70_1 then
		arg_70_0.selectPropID = arg_70_1

		arg_70_0:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_NO_THING_GRID)

		if ChessBoardPropCfg[arg_70_1].type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			ShowTips("CHESSBOARD_SELECT_ADD")
		end
	end
end

function var_0_0.PlayEntityAction(arg_71_0, arg_71_1, arg_71_2)
	ChessBoardLuaBridge.PlayEntityAction(arg_71_1, arg_71_2)
end

function var_0_0.HeroRollDice(arg_72_0)
	if arg_72_0.isArenaChance_ then
		arg_72_0.blockerManager_:ShowBlocker()
		ChessBoardAction.RollChanceDice(function(arg_73_0, arg_73_1)
			arg_72_0.blockerManager_:HideBlocker()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.DICE)
			manager.notify:CallUpdateFunc(CHESSBOARD_PLAY_DICE_ANI, arg_73_0, arg_73_1)
		end)
	elseif arg_72_0:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START then
		arg_72_0.blockerManager_:ShowBlocker()
		ChessBoardAction.HeroRollDice(function(arg_74_0)
			arg_72_0.blockerManager_:HideBlocker()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.DICE)
			ChessBoardLuaBridge.ClearMoveEffect()
			manager.notify:CallUpdateFunc(CHESSBOARD_PLAY_DICE_ANI, arg_74_0)

			arg_72_0.isCanUseProp_ = false
		end)
	end
end

function var_0_0.HeroTryToMove(arg_75_0)
	manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)

	local var_75_0, var_75_1 = arg_75_0.heroEntity_:GetPosAndDir()
	local var_75_2 = ChessBoardLuaBridge.FindNextMovePos(var_75_0.x, var_75_0.z, var_75_1)

	if var_75_2.Count > 1 then
		ShowTips("CHESSBOARD_SELECT_ROAD")
		arg_75_0:EffectShow(ChessBoardConst.EFFECT_TYPE.MULT_ARROW)

		arg_75_0.curCanMovePosListCache_ = {}
		arg_75_0.isSelectPosing_ = true

		ChessBoardLuaBridge.SetSelectingMovePos(true)

		for iter_75_0 = 0, var_75_2.Count - 1 do
			local var_75_3 = {
				x = var_75_2[iter_75_0].x,
				z = var_75_2[iter_75_0].z
			}

			table.insert(arg_75_0.curCanMovePosListCache_, var_75_3)
		end

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
	elseif var_75_2.Count == 1 then
		local var_75_4 = {
			x = var_75_2[0].x,
			z = var_75_2[0].z
		}

		arg_75_0:SendHeroWantMove(var_75_4, function()
			manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, false)
		end)
	elseif var_75_2.Count <= 0 then
		error("当前格子找不到下一个可移动的格子！！")
	end
end

function var_0_0.SendHeroWantMove(arg_77_0, arg_77_1, arg_77_2)
	local function var_77_0()
		ChessBoardAction.HeroWantToMoveByPos(arg_77_1, function()
			if manager.ChessBoardManager then
				arg_77_0.blockerManager_:ShowBlocker()
				arg_77_0.heroEntity_:CheckMoveBegin(arg_77_1)
			end

			if arg_77_2 then
				arg_77_2()
			end

			ChessBoardLuaBridge.MoveHeroToPos(arg_77_1.x, arg_77_1.z, function()
				if manager.ChessBoardManager then
					arg_77_0.blockerManager_:HideBlocker()
					arg_77_0.heroEntity_:MoveToPos(arg_77_1.x, arg_77_1.z)
				end
			end)
		end)
	end

	if arg_77_0.heroEntity_:GetNextPosPlayerAcitonType(arg_77_1) == ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.MY_BANNER, {
			callback = var_77_0
		})
	else
		var_77_0()
	end
end

function var_0_0.CheckOverlap(arg_81_0, arg_81_1)
	local var_81_0, var_81_1 = arg_81_0.heroEntity_:GetPosAndDir()
	local var_81_2 = arg_81_0.NPCManager_:FindTargetPosNPCEntity(var_81_0, arg_81_0.heroEntity_:GetEntityId())

	if var_81_2 then
		local var_81_3 = var_81_2:GetEntityId()

		ChessBoardLuaBridge.PlayEntityOverlap(var_81_3, arg_81_1)
	end
end

function var_0_0.SelectMovePos(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_0.isSelectPosing_ then
		local var_82_0

		for iter_82_0, iter_82_1 in pairs(arg_82_0.curCanMovePosListCache_) do
			if iter_82_1.x == arg_82_1 and iter_82_1.z == arg_82_2 then
				var_82_0 = {
					x = arg_82_1,
					z = arg_82_2
				}

				break
			end
		end

		if var_82_0 then
			arg_82_0:CheckOverlap(false)

			arg_82_0.isSelectPosing_ = false

			ChessBoardLuaBridge.SetSelectingMovePos(false)

			arg_82_0.curCanMovePosListCache_ = {}

			manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
			arg_82_0:SendHeroWantMove(var_82_0, function()
				ChessBoardLuaBridge.ClearMoveEffect()
			end)
		end
	else
		error("当前不需要选择格子！")
	end
end

function var_0_0.SelectNpcPos(arg_84_0, arg_84_1, arg_84_2)
	if arg_84_0.isSelectNpc_ then
		local var_84_0 = ChessBoardPropCfg[arg_84_0.selectPropID]
		local var_84_1
		local var_84_2 = arg_84_0.NPCManager_:GetAllNpcPos()

		for iter_84_0, iter_84_1 in pairs(var_84_2) do
			if iter_84_1.x == arg_84_1 and iter_84_1.z == arg_84_2 then
				var_84_1 = {
					x = arg_84_1,
					z = arg_84_2
				}

				break
			end
		end

		local var_84_3, var_84_4 = arg_84_0.heroEntity_:GetPosAndDir()

		if var_84_0.type == ChessBoardConst.PROPTYPE.GUN or var_84_0.type == ChessBoardConst.PROPTYPE.SWAP then
			if var_84_1 then
				local var_84_5

				if var_84_0.type == ChessBoardConst.PROPTYPE.GUN then
					var_84_5 = GetTips("CHESSBOARD_IS_KILL_DUCK")
				elseif var_84_0.type == ChessBoardConst.PROPTYPE.SWAP then
					var_84_5 = GetTips("CHESSBOARD_IS_SWAP_DUCK")
				end

				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = var_84_5,
					OkCallback = function()
						arg_84_0.isSelectNpc_ = false

						ChessBoardLuaBridge.SetSelectingNPCMovePos(false)
						ChessBoardAction.UseProp(arg_84_0.selectPropID, {
							arg_84_1,
							arg_84_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							arg_84_0:PropEffect(arg_84_0.selectPropID, {
								arg_84_1,
								arg_84_2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.USE_PROP, {
								isUseStart = false,
								propID = arg_84_0.selectPropID
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			elseif var_84_0.type == ChessBoardConst.PROPTYPE.GUN then
				ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_KILL")
			elseif var_84_0.type == ChessBoardConst.PROPTYPE.SWAP then
				ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_SWAP")
			end
		elseif var_84_0.type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
			if var_84_1 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_SURE_NPC_ADD_BUFF"),
					OkCallback = function()
						arg_84_0.isSelectNpc_ = false

						ChessBoardLuaBridge.SetSelectingNPCMovePos(false)
						ChessBoardAction.UseProp(arg_84_0.selectPropID, {
							arg_84_1,
							arg_84_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							arg_84_0:PropEffect(arg_84_0.selectPropID, {
								1,
								arg_84_1,
								arg_84_2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			elseif var_84_3.x == arg_84_1 and var_84_3.z == arg_84_2 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_SURE_SELF_ADD_BUFF"),
					OkCallback = function()
						arg_84_0.isSelectNpc_ = false

						ChessBoardLuaBridge.SetSelectingNPCMovePos(false)
						ChessBoardAction.UseProp(arg_84_0.selectPropID, {
							arg_84_1,
							arg_84_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							arg_84_0:PropEffect(arg_84_0.selectPropID, {
								2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			else
				ShowTips("CHESSBOARD_SELECT_ROLE")
			end
		end
	end
end

function var_0_0.SelectMapPos(arg_91_0, arg_91_1, arg_91_2)
	if arg_91_0.isSelectMapPos_ then
		local var_91_0 = ChessBoardPropCfg[arg_91_0.selectPropID]

		if var_91_0.type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			local var_91_1 = arg_91_0.heroEntity_:GetPosAndDir()
			local var_91_2 = ChessBoardLuaBridge.GetGridData(arg_91_1, arg_91_2)

			if var_91_1.x == arg_91_1 and var_91_1.z == arg_91_2 then
				local var_91_3, var_91_4 = arg_91_0.heroEntity_:GetBuffData()

				if var_91_3 == nil then
					ShowTips("CHESSBOARD_HERO_NO_BUFF")
				else
					ChessBoardTools.ChessBoardMessageBox({
						title = GetTips("PROMPT"),
						content = GetTips("CHESSBOARD_CLEAR_BUFF"),
						OkCallback = function()
							arg_91_0.isSelectMapPos_ = false

							ChessBoardLuaBridge.SetSelectingMapPos(false)
							ChessBoardAction.UseProp(arg_91_0.selectPropID, {
								arg_91_1,
								arg_91_2
							}, function()
								ChessBoardLuaBridge.ClearChoiceEffect()
								arg_91_0:PropEffect(arg_91_0.selectPropID, {
									1
								})
								manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
							end)
						end
					})
				end
			elseif var_91_2.thingTypeID > 0 and ChessBoardThingCfg[var_91_2.thingTypeID].destoryable > 0 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_CLEAR_THING"),
					OkCallback = function()
						arg_91_0.isSelectMapPos_ = false

						ChessBoardLuaBridge.SetSelectingMapPos(false)
						ChessBoardAction.UseProp(arg_91_0.selectPropID, {
							arg_91_1,
							arg_91_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							arg_91_0:PropEffect(arg_91_0.selectPropID, {
								2,
								arg_91_1,
								arg_91_2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			else
				ShowTips("CHESSBOARD_SELECT_REMOVE")
			end
		elseif var_91_0.type == ChessBoardConst.PROPTYPE.NEW_MAP_THING then
			local var_91_5 = arg_91_0.heroEntity_:GetPosAndDir()
			local var_91_6 = ChessBoardLuaBridge.GetGridData(arg_91_1, arg_91_2)
			local var_91_7 = arg_91_0.NPCManager_:FindNPCWithPos(arg_91_1, arg_91_2)
			local var_91_8 = ChessBoardHexCfg[var_91_6.typeID]

			if var_91_5.x == arg_91_1 and var_91_5.z == arg_91_2 then
				ShowTips("CHESSBOARD_SELECT_PUT")
			elseif var_91_6.thingTypeID > 0 then
				ShowTips("CHESSBOARD_SELECT_PUT")
			elseif var_91_7 ~= nil then
				ShowTips("CHESSBOARD_SELECT_PUT")
			elseif var_91_6.thingTypeID == 0 and var_91_8.walkable >= 1 and var_91_8.updatable == 0 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_SURE_PUT"),
					OkCallback = function()
						arg_91_0.isSelectMapPos_ = false

						ChessBoardLuaBridge.SetSelectingMapPos(false)
						ChessBoardAction.UseProp(arg_91_0.selectPropID, {
							arg_91_1,
							arg_91_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							arg_91_0:PropEffect(arg_91_0.selectPropID, {
								arg_91_1,
								arg_91_2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			else
				ShowTips("CHESSBOARD_SELECT_PUT")
			end
		end
	end
end

function var_0_0.SelectMapGrid(arg_98_0, arg_98_1, arg_98_2)
	local var_98_0 = ChessBoardHexCfg[arg_98_2]

	if var_98_0 and var_98_0.dec ~= "" then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GRID_BUBBLE, {
			modelPos = arg_98_1,
			thingTypeID = arg_98_2
		})
	end
end

function var_0_0.ChangeGridByExtentID(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5)
	arg_99_0.blockerManager_:ShowBlocker()

	local var_99_0 = ChessBoardData:GetExtendGridJsonData(arg_99_3)

	if ChessBoardHexCfg[var_99_0.typeID].walkable == 0 then
		local var_99_1, var_99_2 = arg_99_0.heroEntity_:GetPosAndDir()

		if var_99_1.x == arg_99_1 and var_99_1.z == arg_99_2 then
			local var_99_3 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapID()]

			ChessBoardLuaBridge.MoveTargetSmooth(arg_99_1, arg_99_2, function()
				ShowTips("CHESSBOARD_CHANGE_MAP_TP")
				arg_99_0:PlayPortHeroEffect(arg_99_1, arg_99_2)
				ChessBoardLuaBridge.SetHeroPosAndDir(var_99_3.init_pos[1], var_99_3.init_pos[2], var_99_3.init_dir)
				arg_99_0.heroEntity_:TelePortHeroToPosition(var_99_3.init_pos[1], var_99_3.init_pos[2], var_99_3.init_dir)
				arg_99_0:AddDelayTimer(1, function()
					ChessBoardLuaBridge.MoveTargetSmooth(arg_99_1, arg_99_2, function()
						ChessBoardLuaBridge.ChangeGridByIndex(arg_99_1, arg_99_2, arg_99_3, arg_99_4, function()
							arg_99_0.blockerManager_:HideBlocker()

							if arg_99_4 then
								ChessBoardData:ChangeGridLuaInheritDir(arg_99_1, arg_99_2, arg_99_3)
							else
								ChessBoardData:ChangeGridLua(arg_99_1, arg_99_2, arg_99_3)
							end

							if arg_99_5 then
								arg_99_5()
							end
						end)
					end)
				end)
			end)
		else
			local var_99_4 = arg_99_0.NPCManager_:FindNPCWithPos(arg_99_1, arg_99_2)

			if var_99_4 ~= nil then
				ChessBoardLuaBridge.ShowNPCDestoryEffectActive(arg_99_1, arg_99_2)
				manager.ChessBoardManager:AddDelayTimer(0.5, function()
					ChessBoardLuaBridge.ClearNPCDestoryEffect()
				end)
				arg_99_0:DeleteNPC(var_99_4)
			end

			ChessBoardLuaBridge.ChangeGridByIndex(arg_99_1, arg_99_2, arg_99_3, arg_99_4, function()
				arg_99_0.blockerManager_:HideBlocker()

				if arg_99_4 then
					ChessBoardData:ChangeGridLuaInheritDir(arg_99_1, arg_99_2, arg_99_3)
				else
					ChessBoardData:ChangeGridLua(arg_99_1, arg_99_2, arg_99_3)
				end

				if arg_99_5 then
					arg_99_5()
				end
			end)
		end
	else
		ChessBoardLuaBridge.ChangeGridByIndex(arg_99_1, arg_99_2, arg_99_3, arg_99_4, function()
			arg_99_0.blockerManager_:HideBlocker()

			if arg_99_4 then
				ChessBoardData:ChangeGridLuaInheritDir(arg_99_1, arg_99_2, arg_99_3)
			else
				ChessBoardData:ChangeGridLua(arg_99_1, arg_99_2, arg_99_3)
			end

			if arg_99_5 then
				arg_99_5()
			end
		end)
	end
end

function var_0_0.ChangeThingByExtentID(arg_107_0, arg_107_1, arg_107_2, arg_107_3, arg_107_4)
	arg_107_0.blockerManager_:ShowBlocker()

	local var_107_0 = ChessBoardData:GetExtendThingJsonData(arg_107_3)

	if ChessBoardThingCfg[var_107_0.thingTypeID].fix_walkable == 1 then
		local var_107_1, var_107_2 = arg_107_0.heroEntity_:GetPosAndDir()

		if var_107_1.x == arg_107_1 and var_107_1.z == arg_107_2 then
			local var_107_3 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapID()]

			ChessBoardLuaBridge.MoveTargetSmooth(arg_107_1, arg_107_2, function()
				ShowTips("CHESSBOARD_CHANGE_MAP_TP")
				arg_107_0:PlayPortHeroEffect(arg_107_1, arg_107_2)
				ChessBoardLuaBridge.SetHeroPosAndDir(var_107_3.init_pos[1], var_107_3.init_pos[2], var_107_3.init_dir)
				arg_107_0.heroEntity_:TelePortHeroToPosition(var_107_3.init_pos[1], var_107_3.init_pos[2], var_107_3.init_dir)
				arg_107_0:AddDelayTimer(1, function()
					ChessBoardLuaBridge.MoveTargetSmooth(arg_107_1, arg_107_2, function()
						ChessBoardLuaBridge.ChangeThingByIndex(arg_107_1, arg_107_2, arg_107_3, function()
							arg_107_0.blockerManager_:HideBlocker()
							ChessBoardData:ChangeThingLua(arg_107_1, arg_107_2, arg_107_3)

							if arg_107_4 then
								arg_107_4()
							end
						end)
					end)
				end)
			end)
		else
			local var_107_4 = arg_107_0.NPCManager_:FindNPCWithPos(arg_107_1, arg_107_2)

			if var_107_4 ~= nil then
				ChessBoardLuaBridge.ShowNPCDestoryEffectActive(arg_107_1, arg_107_2)
				manager.ChessBoardManager:AddDelayTimer(0.5, function()
					ChessBoardLuaBridge.ClearNPCDestoryEffect()
				end)
				arg_107_0:DeleteNPC(var_107_4)
			end

			ChessBoardLuaBridge.ChangeThingByIndex(arg_107_1, arg_107_2, arg_107_3, function()
				arg_107_0.blockerManager_:HideBlocker()
				ChessBoardData:ChangeThingLua(arg_107_1, arg_107_2, arg_107_3)

				if arg_107_4 then
					arg_107_4()
				end
			end)
		end
	else
		ChessBoardLuaBridge.ChangeThingByIndex(arg_107_1, arg_107_2, arg_107_3, function()
			arg_107_0.blockerManager_:HideBlocker()
			ChessBoardData:ChangeThingLua(arg_107_1, arg_107_2, arg_107_3)

			if arg_107_4 then
				arg_107_4()
			end
		end)
	end
end

function var_0_0.DeleteThing(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	arg_115_0.blockerManager_:ShowBlocker()
	ChessBoardLuaBridge.DeleteThing(arg_115_1, arg_115_2, function()
		arg_115_0.blockerManager_:HideBlocker()
		ChessBoardData:DeleteThingLua(arg_115_1, arg_115_2)

		if arg_115_3 then
			arg_115_3()
		end
	end)
end

function var_0_0.PlayGridAnimation(arg_117_0, arg_117_1, arg_117_2, arg_117_3, arg_117_4, arg_117_5)
	arg_117_0.blockerManager_:ShowBlocker()

	if ChessBoardLuaBridge.GetGridData(arg_117_1, arg_117_2).thingTypeID == ChessBoardConst.BOMB_BALLOON and arg_117_0.NPCManager_:GetMovingNPC() == -1 then
		arg_117_0:AddDelayTimer(1, function()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SAD)
		end)
	end

	ChessBoardLuaBridge.PlayGridAnimation(arg_117_1, arg_117_2, arg_117_3, arg_117_4, function()
		arg_117_0.blockerManager_:HideBlocker()
		arg_117_5()
	end)
end

function var_0_0.MoveToTarget(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	arg_120_0.isMovingCamera_ = true

	arg_120_0.blockerManager_:ShowBlocker()
	manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, true)
	ChessBoardLuaBridge.MoveTargetSmooth(arg_120_1, arg_120_2, function()
		manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, true)

		arg_120_0.isMovingCamera_ = false

		arg_120_0.blockerManager_:HideBlocker()

		if arg_120_3 then
			arg_120_3()
		end
	end, true)
end

function var_0_0.GetIsCameraMoving(arg_122_0)
	return arg_122_0.isMovingCamera_
end

function var_0_0.GetIsCanUseProp(arg_123_0)
	return arg_123_0.isCanUseProp_
end

function var_0_0.SetIsCanUseProp(arg_124_0, arg_124_1)
	arg_124_0.isCanUseProp_ = arg_124_1
end

function var_0_0.UpdateMapTurn(arg_125_0)
	arg_125_0.blockerManager_:ShowBlocker()

	arg_125_0.curMapTurn_ = arg_125_0.curMapTurn_ + 1

	manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.NEW_ROUND_OPEN_TIPS, {
		callback = function()
			arg_125_0:MapEventTrigger()
		end
	})
end

function var_0_0.MapEventTrigger(arg_127_0)
	local var_127_0 = false

	for iter_127_0, iter_127_1 in pairs(arg_127_0.curMapTurnEventCfg_) do
		if arg_127_0.curMapTurn_ == iter_127_1[1] then
			local var_127_1 = ChessBoardEventPoolCfg[iter_127_1[2]]

			if var_127_1 and not table.isEmpty(var_127_1.player_params) then
				var_127_0 = true

				if var_127_1.type == 1 then
					arg_127_0:ExecuteTiming(ChessBoardConst.TIMING.MAP_EVENT, {
						playerB = -1,
						playerA = 0,
						mapTurnNum = arg_127_0.curMapTurn_
					})
					arg_127_0:StartExecuteEvent(function()
						arg_127_0:MyTurnBegin()
					end)
				elseif var_127_1.type == 2 then
					-- block empty
				end
			end
		end
	end

	if not var_127_0 then
		arg_127_0:MyTurnBegin()
	end
end

function var_0_0.MyTurnBegin(arg_129_0)
	manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.MY_TURN_TIPS, {
		callback = function()
			arg_129_0.isCanUseProp_ = true

			manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.DICE_SHOW)
			arg_129_0:EffectShow(ChessBoardConst.EFFECT_TYPE.NORMAL_ARROW)
			arg_129_0.blockerManager_:HideBlocker()
		end
	})
end

function var_0_0.OnHeroTurnEnd(arg_131_0)
	arg_131_0.heroEntity_:OnBuffUpdateTurn()
	arg_131_0:SetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START)

	local var_131_0 = arg_131_0.heroEntity_:GetCurUsedPropID()

	if var_131_0 > 0 then
		arg_131_0:FixPropEffect(var_131_0)
	end

	arg_131_0.heroEntity_:ClearCurUsedPropID()
	arg_131_0:AddDelayTimer(0.5, function()
		arg_131_0:OnGridTips()
	end)
end

function var_0_0.OnGridTips(arg_133_0)
	local var_133_0 = arg_133_0.heroEntity_:GetPosAndDir()
	local var_133_1 = ChessBoardLuaBridge.GetGridData(var_133_0.x, var_133_0.z)

	if var_133_1.typeID == ChessBoardConst.DUCK_GRID_ID then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.DUCK_CREATE_TIPS, {
			callback = function()
				manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.NERVOUS)
				arg_133_0:AddDelayTimer(1.5, function()
					arg_133_0.NPCManager_:StartNPCTurn()
				end)
			end
		})
	elseif var_133_1.typeID == ChessBoardConst.SUFFER_GRID_ID then
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SAD)
		arg_133_0:AddDelayTimer(1.5, function()
			arg_133_0.NPCManager_:StartNPCTurn()
		end)
	else
		arg_133_0.NPCManager_:StartNPCTurn()
	end
end

function var_0_0.GetCurMapTurnCount(arg_137_0)
	return arg_137_0.curMapTurn_
end

function var_0_0.PropEffect(arg_138_0, arg_138_1, arg_138_2)
	local var_138_0 = ChessBoardPropCfg[arg_138_1]

	if arg_138_0.isArenaChance_ then
		arg_138_0:GetCurChanceInfo().chanceChooseList[3] = arg_138_1
	else
		arg_138_0.heroEntity_:SetCurUsedPropID(arg_138_1)
	end

	arg_138_0.isCanUseProp_ = false

	if var_138_0.type == ChessBoardConst.PROPTYPE.ADD_BUFF then
		arg_138_0.heroEntity_:AddBuff(var_138_0.params[1])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.GUN then
		local var_138_1 = arg_138_0.NPCManager_:FindNPCWithPos(arg_138_2[1], arg_138_2[2])

		ChessBoardLuaBridge.SetNPCToCameraTarget(var_138_1)
		ChessBoardLuaBridge.ChangeCameraToCloseCamera()
		arg_138_0:PlayEntityAction(var_138_1, ChessBoardConst.ACTIONTYPE.HIT)
		arg_138_0:AddDelayTimer(2, function()
			arg_138_0:DeleteNPC(var_138_1)
			ChessBoardLuaBridge.LookAtPlayer()
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
			manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
		end)
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.SWAP then
		local var_138_2, var_138_3 = arg_138_0.heroEntity_:GetPosAndDir()
		local var_138_4 = arg_138_0.NPCManager_:FindNPCWithPos(arg_138_2[1], arg_138_2[2])
		local var_138_5, var_138_6 = arg_138_0.NPCManager_:GetNPCPosAndDir(var_138_4)
		local var_138_7 = var_138_2.x
		local var_138_8 = var_138_2.z

		arg_138_0:TelePortHeroToPosition(var_138_5.x, var_138_5.z, var_138_6)
		ChessBoardLuaBridge.ClearMoveEffect()
		arg_138_0:EffectShow(ChessBoardConst.EFFECT_TYPE.NORMAL_ARROW)
		arg_138_0:TelePortNPCToPosition(var_138_4, var_138_7, var_138_8, var_138_3)
		manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
		manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.SET_DICE_POINT then
		arg_138_0:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_SELECT", var_138_0.params[1])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.ADD_ATTRIBUTE then
		arg_138_0:SubHeroAttribute(var_138_0.params[1], var_138_0.params[2])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.ADD_ATTRIBUTE_CURTURN then
		arg_138_0:SubHeroAttribute(var_138_0.params[1], var_138_0.params[2])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.NEW_MAP_THING then
		arg_138_0:ChangeThingByExtentID(arg_138_2[1], arg_138_2[2], var_138_0.params[1])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
		if arg_138_2[1] == 1 then
			arg_138_0.heroEntity_.buffManager_:CheckClashBuff()
		elseif arg_138_2[1] == 2 then
			manager.ChessBoardManager:DeleteThing(arg_138_2[2], arg_138_2[3])
		end
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.NPC_STOP_MOVE_CARD then
		ShowTips("CHESSBOARD_DUCK_STOP")
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
		if arg_138_2[1] == 1 then
			local var_138_9 = arg_138_0.NPCManager_:FindNPCWithPos(arg_138_2[2], arg_138_2[3])

			arg_138_0:AddBuff(var_138_9, var_138_0.params[1])
		elseif arg_138_2[1] == 2 then
			arg_138_0.heroEntity_:AddBuff(var_138_0.params[1])
		end
	end

	if arg_138_1 == 10001 or arg_138_1 == 10002 then
		arg_138_0:HeroRollDice()
	end
end

function var_0_0.FixPropEffect(arg_140_0, arg_140_1)
	local var_140_0 = ChessBoardPropCfg[arg_140_1]

	if var_140_0.type == ChessBoardConst.PROPTYPE.SET_DICE_POINT then
		arg_140_0:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_SELECT", 0)
	elseif var_140_0.type == ChessBoardConst.PROPTYPE.ADD_ATTRIBUTE_CURTURN then
		arg_140_0:SubHeroAttribute(var_140_0.params[1], -var_140_0.params[2])
	end
end

function var_0_0.BattleStart(arg_141_0, arg_141_1)
	arg_141_0.battleStart_ = true
	arg_141_0.battleResult_ = nil
	arg_141_0.battlePoint_ = 0
	arg_141_0.curChanceID_ = arg_141_1

	local var_141_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_141_0 then
		arg_141_0.originShadowRotationImmediately = var_141_0.shadowRotationImmediately
		var_141_0.shadowRotationImmediately = true
	end

	ChessBoardLuaBridge.SetCameraControlEnable(false)
end

function var_0_0.IsBattleBack(arg_142_0)
	return arg_142_0.battleStart_
end

function var_0_0.SetSmallGamePoint(arg_143_0, arg_143_1, arg_143_2)
	arg_143_0.battleResult_ = arg_143_1
	arg_143_0.battlePoint_ = arg_143_2
end

function var_0_0.QTEFinish(arg_144_0, arg_144_1)
	local var_144_0 = arg_144_1.params
	local var_144_1 = var_144_0[1]
	local var_144_2 = arg_144_0.curChanceID_
	local var_144_3 = arg_144_0.battleResult_
	local var_144_4 = arg_144_0.battlePoint_

	if var_144_1 == 1 then
		gameContext:Go("/chessBoardHomeView")

		local var_144_5 = var_144_0[2]
		local var_144_6 = 0

		for iter_144_0, iter_144_1 in pairs(var_144_5 or {}) do
			if iter_144_1[1] == var_144_4 then
				var_144_6 = iter_144_1[2]

				break
			end
		end

		manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", var_144_6)
		ChessBoardAction.FinishChance(var_144_2, var_144_3, var_144_4)

		if var_144_4 == ChessBoardQTEGameConst.QTEGameResult.Perfect then
			arg_144_0:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY)
		end
	else
		gameContext:Go("/chessBoardHomeView")

		local var_144_7 = var_144_0[2]
		local var_144_8 = 0

		for iter_144_2, iter_144_3 in pairs(var_144_7 or {}) do
			if iter_144_3[1] == var_144_4 then
				var_144_8 = iter_144_3[2]

				break
			end
		end

		local var_144_9 = manager.ChessBoardManager:GetCurChanceInfo()

		for iter_144_4 = 1, var_144_8 do
			if var_144_9.chancePropList[iter_144_4] then
				ChessBoardData:AddTmpProp(var_144_9.chancePropList[iter_144_4])
			end
		end

		ChessBoardAction.FinishChance(var_144_2, 0, var_144_4)
		arg_144_0:ReconnectionTmpListProp(nil, function()
			manager.ChessBoardManager:FinishChance(var_144_2, 0, var_144_4)

			if var_144_4 == ChessBoardQTEGameConst.QTEGameResult.Perfect then
				arg_144_0:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY)
			end
		end)
	end
end

function var_0_0.BattleFinish(arg_146_0)
	if arg_146_0.battleStart_ then
		local var_146_0 = ChessBoardChanceCfg[arg_146_0.curChanceID_]

		if var_146_0.type == ChessBoardConst.CHANCE_TYPE.QTE then
			gameContext:Go("/chessBoardHomeView")
			arg_146_0:QTEFinish(var_146_0)
		elseif arg_146_0.battleResult_ == 0 then
			ChessBoardAction.FinishChance(arg_146_0.curChanceID_, arg_146_0.battleResult_, arg_146_0.battlePoint_, function()
				gameContext:Go("/chessBoardHomeView")
			end)
		elseif arg_146_0.battleResult_ == 1 then
			ChessBoardTools.OpenChanceView(arg_146_0.curChanceID_)
		end
	end

	if not arg_146_0.battleStart_ then
		return
	end

	arg_146_0:ClearBattleData()
end

function var_0_0.ClearBattleData(arg_148_0)
	arg_148_0.battleStart_ = false
	arg_148_0.battleResult_ = nil
	arg_148_0.curChanceID_ = 0

	local var_148_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_148_0 then
		var_148_0.shadowRotationImmediately = arg_148_0.originShadowRotationImmediately
	end

	ChessBoardLuaBridge.SetCameraControlEnable(true)
end

function var_0_0.StartArenaChance(arg_149_0)
	arg_149_0.isArenaChance_ = true
	arg_149_0.isArenaChanceFinishSend_ = false

	manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, true)
end

function var_0_0.GetIsArenaChance(arg_150_0)
	return arg_150_0.isArenaChance_
end

function var_0_0.CheckArenaChance(arg_151_0)
	local var_151_0 = arg_151_0:GetCurChanceInfo()
	local var_151_1 = ChessBoardChanceCfg[var_151_0.chanceID]

	if var_151_0.chanceChooseList[2] >= var_151_1.params[1] then
		return 1
	elseif var_151_0.chanceChooseList[1] <= 0 then
		return 2
	else
		return 0
	end
end

function var_0_0.FinishArenaChance(arg_152_0, arg_152_1)
	if arg_152_0.isArenaChanceFinishSend_ then
		return
	end

	local var_152_0 = arg_152_0:GetCurChanceInfo()

	if arg_152_1 then
		ShowTips("CHESSBOARD_ARENA_SUCCESS")

		arg_152_0.isArenaChanceFinishSend_ = true

		ChessBoardAction.FinishChance(var_152_0.chanceID, 0, var_152_0.chanceChooseList[2], function()
			arg_152_0.isArenaChance_ = false

			manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, false)
		end)
	else
		ShowTips("CHESSBOARD_ARENA_FAILED")

		arg_152_0.isArenaChanceFinishSend_ = true

		ChessBoardAction.FinishChance(var_152_0.chanceID, 1, var_152_0.chanceChooseList[2], function()
			arg_152_0.isArenaChance_ = false

			arg_152_0:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_ARENA_DICE_NUM", 1)
			manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, false)
		end)
	end
end

function var_0_0.AddDelayTimer(arg_155_0, arg_155_1, arg_155_2)
	arg_155_0.blockerManager_:ShowBlocker()

	if ChessBoardData:GetIsFastModule() == true then
		arg_155_1 = arg_155_1 / 2
	end

	if arg_155_2 == nil then
		return
	end

	if arg_155_1 == 0 then
		arg_155_0.blockerManager_:HideBlocker()
		arg_155_2()

		return
	end

	local var_155_0 = arg_155_0.timerIndex

	arg_155_0.delayTimerList[var_155_0] = Timer.New(function()
		arg_155_0.blockerManager_:HideBlocker()
		arg_155_2()
		arg_155_0:DeleteTimer(var_155_0)
	end, arg_155_1, 1)

	arg_155_0.delayTimerList[var_155_0]:Start()

	arg_155_0.timerIndex = (arg_155_0.timerIndex + 1) % 10
end

function var_0_0.DeleteTimer(arg_157_0, arg_157_1)
	if arg_157_0.delayTimerList[arg_157_1] then
		arg_157_0.delayTimerList[arg_157_1]:Stop()

		arg_157_0.delayTimerList[arg_157_1] = nil
	end
end

function var_0_0.ChangeFastModule(arg_158_0)
	local var_158_0 = ChessBoardData:ChangeFastModule()

	arg_158_0:ApplyFastModule(var_158_0)

	return var_158_0
end

function var_0_0.ApplyFastModule(arg_159_0, arg_159_1)
	ChessBoardLuaBridge.ChangeSpeedModule(arg_159_1)
	arg_159_0.diceManager_:OnChessBoardFastModuleUpdate(arg_159_1)
end

function var_0_0.FixBGM(arg_160_0)
	local var_160_0 = ChessBoardData:GetCurrentChessBoardMapID()

	if ChessBoardLevelCfg[var_160_0].activity == ChessBoardConst.ARENA_ACTIVITYID then
		manager.audio:PlayBGM("bgm_activity_3_3_minigame_warchess_stage", "bgm_activity_3_3_minigame_warchess_stage", "bgm_activity_3_3_minigame_warchess_stage.awb")

		if arg_160_0:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ARENA_ACTIVE") >= 1 then
			manager.audio:PlayEffect("bgm_activity_3_3_minigame_warchess_stage", "bgm_activity_3_3_minigame_warchess_openlight", "")
		end
	else
		manager.audio:PlayBGM("bgm_activity_3_3_minigame_warchess", "bgm_activity_3_3_minigame_warchess", "bgm_activity_3_3_minigame_warchess.awb")
	end
end

function var_0_0.Dispose(arg_161_0)
	for iter_161_0, iter_161_1 in pairs(arg_161_0.delayTimerList) do
		arg_161_0:DeleteTimer(iter_161_0)
	end

	arg_161_0.heroEntity_:Dispose()
	arg_161_0.NPCManager_:Dispose()
	arg_161_0.taskManager_:Dispose()
	arg_161_0.eventQueueManager_:Clear()
	arg_161_0:DisposeSupportModule()
	arg_161_0:ClearBattleData()

	arg_161_0.isArenaChance_ = false
	arg_161_0.curMapTurn_ = 0
	arg_161_0.selectPropID = nil
	arg_161_0.eventCallBack_ = nil
end

return var_0_0
