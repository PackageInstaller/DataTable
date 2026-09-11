local var_0_0 = singletonClass("ChessBoardManager")

function var_0_0:Ctor()
	self.heroEntity_ = ChessBoardHeroEntity.New()
	self.taskManager_ = ChessBoardTaskManager.New()
	self.eventQueueManager_ = ChessBoardEventQueue.New()
	self.NPCManager_ = ChessBoardNPCManager.GetInstance()

	self.NPCManager_:Init()

	self.curCanMovePosListCache_ = {}
	self.isSelectPosing_ = false
	self.isSelectNpc_ = false
	self.isSelectMapPos_ = false
	self.selectPropID = nil
	self.curMapTurn_ = 0
	self.eventCallBack_ = nil
	self.timerIndex = 1
	self.delayTimerList = {}
	self.isMovingCamera_ = false
	self.isCanUseProp_ = false
	self.tmpPropList = {}
	self.isArenaChance_ = false
	self.isArenaChanceFinishSend_ = false
end

function var_0_0:SetUp(arg_2_1)
	self.tmpPropList = {}

	self:LoadMap(arg_2_1.mapId)
	self.heroEntity_:SetServerData(arg_2_1.heroInfos)
	self.NPCManager_:SetServerData(arg_2_1.NPCInfoList)
	self.taskManager_:SetServerData(arg_2_1.taskList)

	self.curMapTurn_ = arg_2_1.turn
	self.curMapTurnEventCfg_ = ChessBoardLevelCfg[arg_2_1.mapId].level_event
end

function var_0_0:LoadMap(arg_3_1)
	self.map_ = ChessBoardTools.LoadMap(arg_3_1)

	if not self.map_ then
		-- block empty
	end

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self.map_.mapInfo) do
		var_3_0[ChessBoardTools.TwoDToOneD(iter_3_1.x, iter_3_1.z)] = iter_3_1
	end

	ChessBoardData:SetJsonMap(var_3_0, self.map_.extendInfo, self.map_.extendThingInfo)
	ChessBoardData:SetMapWidthAndHeight(self.map_.width, self.map_.height)
end

function var_0_0:CreateSupportModule()
	if self.blockerManager_ == nil then
		self.blockerManager_ = ChessBoardBlockManager.New(manager.ui.canvas)
	end

	if self.diceManager_ == nil then
		self.diceManager_ = ChessBoardDiceManager.New()
	end
end

function var_0_0:DisposeSupportModule()
	if self.blockerManager_ then
		self.blockerManager_:Dispose()

		self.blockerManager_ = nil
	end

	if self.diceManager_ then
		self.diceManager_:Dispose()

		self.diceManager_ = nil
	end

	self.isFastModule_ = false
end

function var_0_0:AddBuff(arg_6_1, arg_6_2)
	local var_6_0 = self:FindEntity(arg_6_1)

	if var_6_0 then
		var_6_0:AddBuff(arg_6_2)
	end
end

function var_0_0:RemoveBuff(arg_7_1, arg_7_2)
	local var_7_0 = self:FindEntity(arg_7_1)

	if var_7_0 then
		var_7_0:RemoveBuff(arg_7_2)
	end
end

function var_0_0:FindEntity(arg_8_1)
	if self.heroEntity_:GetEntityId() == arg_8_1 then
		return self.heroEntity_
	else
		return self.NPCManager_:FindEntity(arg_8_1)
	end
end

function var_0_0:ExecuteTiming(arg_9_1, arg_9_2)
	if arg_9_1 == ChessBoardConst.TIMING.FIRST_ENTER_MAP then
		self:ExecuteEvent(arg_9_1, {}, nil, 0, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.BUFF_STEP then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.buffEffectID
		}, nil, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.BUFF_DELETE or arg_9_1 == ChessBoardConst.TIMING.BUFF_ADD or arg_9_1 == ChessBoardConst.TIMING.BUFF_TURN then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.buffID
		}, nil, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.TASK_FINISH then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.taskID
		}, nil, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.MAP_EVENT then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.mapTurnNum
		}, nil, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.CHANCE_FINISH then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.chanceID
		}, arg_9_2.gridData, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.NPC_TURN_START or arg_9_1 == ChessBoardConst.TIMING.NPC_TURN_END then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.playerA
		}, nil, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.ENTER_FLOOR or arg_9_1 == ChessBoardConst.TIMING.EXIT_FLOOR or arg_9_1 == ChessBoardConst.TIMING.START_MOVE_FLOOR or arg_9_1 == ChessBoardConst.TIMING.END_MOVE_FLOOR or arg_9_1 == ChessBoardConst.TIMING.ENTER_THING or arg_9_1 == ChessBoardConst.TIMING.EXIT_THING or arg_9_1 == ChessBoardConst.TIMING.START_MOVE_THING or arg_9_1 == ChessBoardConst.TIMING.END_MOVE_THING then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.gridData.x,
			arg_9_2.gridData.z
		}, arg_9_2.gridData, arg_9_2.playerA, -1)
	elseif arg_9_1 == ChessBoardConst.TIMING.NPC_CROSS_HERO or arg_9_1 == ChessBoardConst.TIMING.NPC_STAY_NPC or arg_9_1 == ChessBoardConst.TIMING.NPC_STAY_HERO then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.playerA
		}, arg_9_2.gridData, arg_9_2.playerA, arg_9_2.playerB)
	elseif arg_9_1 == ChessBoardConst.TIMING.HERO_CROSS_NPC or arg_9_1 == ChessBoardConst.TIMING.HERO_STAY_NPC then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.playerB
		}, arg_9_2.gridData, arg_9_2.playerA, arg_9_2.playerB)
	elseif arg_9_1 == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO or arg_9_1 == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO or arg_9_1 == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC or arg_9_1 == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC then
		self:ExecuteEvent(arg_9_1, {
			arg_9_2.buffEffectID
		}, arg_9_2.gridData, arg_9_2.playerA, arg_9_2.playerB)
	end
end

function var_0_0:ExecuteEvent(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = ChessBoardData:GetServerEvent(arg_10_1, arg_10_2, arg_10_4, arg_10_5)

	if var_10_0 ~= nil then
		self.eventQueueManager_:InsertNewEventQueue(arg_10_1, arg_10_3, var_10_0)
	end
end

function var_0_0:StartExecuteEvent(arg_11_1)
	if arg_11_1 ~= nil then
		if self.eventCallBack_ ~= nil then
			error("事件回调出错，当前事件回调不未空！同时存在两个回调，联系李润青")
		else
			self.eventCallBack_ = arg_11_1
		end
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

function var_0_0:DoNextEvent()
	if self.eventQueueManager_:IsEventEnd() then
		self:EventsEnd()

		return
	end

	local var_12_0, var_12_1 = self.eventQueueManager_:GetCurFunc()

	self.eventQueueManager_:PromoteCurEventProgress()

	return var_12_0(unpack(var_12_1))
end

function var_0_0:EventsEnd()
	if self.eventQueueManager_:PromoteToNextEvent() then
		self:DoNextEvent()
	else
		self.eventQueueManager_:Clear()
		self.taskManager_:CheckTask()

		if self.eventCallBack_ ~= nil then
			self.eventCallBack_ = nil

			self.eventCallBack_()
		end
	end
end

function var_0_0:GetExecutingChess()
	return self.eventQueueManager_:GetExecutingChess()
end

function var_0_0:SetHeroAttribute(arg_15_1, arg_15_2)
	return self.heroEntity_:SetAttribute(arg_15_1, arg_15_2)
end

function var_0_0:SubHeroAttribute(arg_16_1, arg_16_2)
	return self.heroEntity_:SubAttribute(arg_16_1, arg_16_2)
end

function var_0_0:GetHeroAttribute(arg_17_1)
	return self.heroEntity_:GetAttribute(arg_17_1)
end

function var_0_0:GetCurChanceInfo()
	return self.heroEntity_:GetCurChanceInfo()
end

function var_0_0:AddHeroProp(arg_19_1)
	ChessBoardData:FixHeroPropAddProp(arg_19_1)
	self.heroEntity_:AddHeroProp(arg_19_1)
	manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
end

function var_0_0:RemoveHeroProp(arg_20_1)
	ChessBoardData:FixHeroPropDelProp(arg_20_1)
	self.heroEntity_:DelHeroProp(arg_20_1)
	manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
end

function var_0_0:GetHeroProp()
	return self.heroEntity_:GetHeroProp()
end

function var_0_0:ContainProp(arg_22_1)
	return table.indexof(self:GetHeroProp(), arg_22_1)
end

function var_0_0:AddTmpHeroProp(arg_23_1, arg_23_2)
	if arg_23_2 then
		self:RemoveHeroProp(arg_23_2)
	end

	self:AddHeroProp(arg_23_1)
	table.insert(self.tmpPropList, {
		prop_id = arg_23_1,
		replace_prop_id = arg_23_2 or 0
	})
end

function var_0_0:SendTmpPropToServer(arg_24_1, arg_24_2)
	if self.tmpPropList and #self.tmpPropList > 0 then
		self:SendTmpPropList(arg_24_1, arg_24_2)
	else
		self:ReconnectionTmpListProp(arg_24_1, arg_24_2)
	end
end

function var_0_0:SendTmpPropList(arg_25_1, arg_25_2)
	arg_25_1 = arg_25_1 or 1

	local var_25_0 = self.tmpPropList[arg_25_1]

	if self.tmpPropList[arg_25_1] then
		ChessBoardAction.GetSelectProp(var_25_0.prop_id, var_25_0.replace_prop_id or 0, function()
			self:SendTmpPropList(arg_25_1 + 1, arg_25_2)
		end)
	else
		self.tmpPropList = {}

		if arg_25_2 then
			arg_25_2()
		end
	end
end

function var_0_0:ReconnectionTmpListProp(arg_27_1, arg_27_2)
	arg_27_1 = arg_27_1 or 1

	local var_27_0 = ChessBoardData:GetCurrentChessBoardMapData().heroInfos.tmp_item[arg_27_1]

	if var_27_0 then
		self:TmpPropGet(var_27_0, arg_27_1, arg_27_2)
	else
		ChessBoardData:FixClearTmpProp()

		if arg_27_2 then
			arg_27_2()
		end
	end
end

function var_0_0:TmpPropGet(arg_28_1, arg_28_2, arg_28_3)
	if #manager.ChessBoardManager:GetHeroProp() >= 6 then
		JumpTools.OpenPageByJump("/ChessBoardPropView", {
			propID = arg_28_1,
			viewType = ChessBoardConst.VIEW_TYPE.CHANGE_PROP,
			changePropCallback = function(arg_29_0)
				self:TmpPropAction(arg_28_2, arg_28_3, arg_28_1, arg_29_0)
			end,
			giveUpPropCallback = function()
				ChessBoardAction.GiveUpProp(arg_28_1)
				gameContext:Go("/chessBoardHomeView")
				self:ReconnectionTmpListProp(arg_28_2 + 1, arg_28_3)
			end
		})
	else
		self:TmpPropAction(arg_28_2, arg_28_3, arg_28_1)
	end
end

function var_0_0:TmpPropAction(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	gameContext:Go("/chessBoardHomeView")

	if arg_31_4 then
		self:RemoveHeroProp(arg_31_4)
	end

	self:AddHeroProp(arg_31_3)
	ChessBoardAction.GetSelectProp(arg_31_3, arg_31_4)
	manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GET_PROP, {
		isGet = true,
		propID = arg_31_3,
		callback = function()
			self:ReconnectionTmpListProp(arg_31_1 + 1, arg_31_2)
		end
	})
end

function var_0_0:SetChanceServerData(arg_33_1)
	ChessBoardData:FixHeroChanceData(arg_33_1)
	self.heroEntity_:SetChanceServerData(arg_33_1)
end

function var_0_0:GetCurHeroPosGridData()
	local var_34_0, var_34_1 = self.heroEntity_:GetPosAndDir()

	return ChessBoardLuaBridge.GetGridData(var_34_0.x, var_34_0.z)
end

function var_0_0:TelePortHeroToPosition(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	ChessBoardLuaBridge.SetHeroPosAndDir(arg_35_1, arg_35_2, arg_35_3)
	self.heroEntity_:TelePortHeroToPosition(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	self:PlayPortHeroEffect(arg_35_1, arg_35_2)
	ChessBoardLuaBridge.LookAtPlayer()
end

function var_0_0:PlayPortHeroEffect(arg_36_1, arg_36_2)
	manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_portal", "")
	ChessBoardLuaBridge.ShowTranferEffect(arg_36_1, arg_36_2)
	self:AddDelayTimer(2, function()
		ChessBoardLuaBridge.ClearTranferEffect()
	end)
end

function var_0_0:SetNPCAttribute(arg_38_1, arg_38_2, arg_38_3)
	return self.NPCManager_:SetNPCAttribute(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0:SubNPCAttribute(arg_39_1, arg_39_2, arg_39_3)
	return self.NPCManager_:SubNPCAttribute(arg_39_1, arg_39_2, arg_39_3)
end

function var_0_0:GetNPCAttribute(arg_40_1, arg_40_2)
	return self.NPCManager_:GetNPCAttribute(arg_40_1, arg_40_2)
end

function var_0_0:AddNPC(arg_41_1)
	ChessBoardLuaBridge.AddNPC(arg_41_1.id, arg_41_1.pos.x, arg_41_1.pos.z, arg_41_1.dir, ChessBoardNPCPoolCfg[arg_41_1.typeID].prefab, arg_41_1.actionType or -1)
	ChessBoardData:FixNPCDataAddNPC(arg_41_1)
	self.NPCManager_:AddNPC(arg_41_1)
end

function var_0_0:DeleteNPC(arg_42_1)
	ChessBoardLuaBridge.DeleteNPC(arg_42_1)
	ChessBoardData:FixNPCDataDeleteNPC(arg_42_1)
	self.NPCManager_:DeleteNPC(arg_42_1)
end

function var_0_0:TelePortNPCToPosition(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	ChessBoardLuaBridge.SetNPCPosAndDir(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	self.NPCManager_:TelePortNPCToPosition(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	self:PlayPortHeroEffect(arg_43_2, arg_43_3)
end

ChessBoardCheckStoryIterator = class("ChessBoardCheckStoryIterator")

function ChessBoardCheckStoryIterator.Ctor(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.curIndex = 0
	arg_44_0.curStoryList = arg_44_1
	arg_44_0.callBack = arg_44_2

	manager.ChessBoardManager.blockerManager_:ShowBlocker()
end

function ChessBoardCheckStoryIterator:MoveNext()
	self.curIndex = self.curIndex + 1

	if self.curIndex <= #self.curStoryList then
		local var_45_0 = self.curStoryList[self.curIndex]

		manager.net:SendWithLoadingNew(12002, {
			story_id = self.curStoryList[self.curIndex]
		}, 12003, function(arg_46_0, arg_46_1)
			PlayerData:StoryModify(var_45_0)
			IllustratedAction.ModifyPlot(var_45_0)
			self:MoveNext()
		end)
	else
		self:Dispose()
	end
end

function ChessBoardCheckStoryIterator:Dispose()
	manager.ChessBoardManager.blockerManager_:HideBlocker()

	self.curIndex = 0
	self.curStoryList = 0

	self.callBack()
end

function var_0_0:UnlockChance(arg_48_1)
	local var_48_0 = self.heroEntity_:GetCurChanceInfo()

	var_48_0.isUnLock = 1

	self:SetChanceServerData(var_48_0)
end

function var_0_0:FinishChance(arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = self.heroEntity_:GetCurChanceInfo()

	if arg_49_2 == 0 then
		local var_49_1 = ChessBoardChanceCfg[arg_49_1]

		if ChessBoardChanceCfg[arg_49_1].play_success_story > 0 then
			manager.story:StartChessStoryWithBackground(ChessBoardChanceCfg[arg_49_1].play_success_story, function(arg_50_0)
				if var_49_1.type == ChessBoardConst.CHANCE_TYPE.ARENA then
					local var_50_0 = {}

					if var_49_1.params[2] ~= 0 then
						table.insert(var_50_0, var_49_1.params[2])
					end

					for iter_50_0, iter_50_1 in pairs(var_49_1.params[3]) do
						table.insert(var_50_0, iter_50_1)
					end

					ChessBoardCheckStoryIterator.New(var_50_0, function()
						if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
							self:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
								playerA = 0,
								playerB = -1,
								gridData = self:GetCurHeroPosGridData(),
								chanceID = arg_49_1
							})
						end

						self:StartExecuteEvent(function()
							if var_49_0.chanceID == arg_49_1 then
								self:SetChanceServerData({
									isUnLock = 0,
									chanceID = 0,
									chancePropList = {},
									chanceChooseList = {}
								})
							end

							self:FixBGM()

							if self:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
								JumpTools.OpenPageByJump("/chessBoardOverView")
							elseif self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
								manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
								ChessBoardAction.HeroMoveEnd(function()
									self:OnHeroTurnEnd()
								end)
							else
								manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
							end
						end)
					end):MoveNext()
				else
					if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
						self:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
							playerA = 0,
							playerB = -1,
							gridData = self:GetCurHeroPosGridData(),
							chanceID = arg_49_1
						})
					end

					self:StartExecuteEvent(function()
						if var_49_0.chanceID == arg_49_1 then
							self:SetChanceServerData({
								isUnLock = 0,
								chanceID = 0,
								chancePropList = {},
								chanceChooseList = {}
							})
						end

						self:FixBGM()

						if self:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
							JumpTools.OpenPageByJump("/chessBoardOverView")
						elseif self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
							manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
							ChessBoardAction.HeroMoveEnd(function()
								self:OnHeroTurnEnd()
							end)
						else
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
						end
					end)
				end
			end)
		elseif ChessBoardChanceCfg[arg_49_1].type == ChessBoardConst.CHANCE_TYPE.ARENA then
			local var_49_2 = {}

			if ChessBoardChanceCfg[arg_49_1].params[2] ~= 0 then
				table.insert(var_49_2, ChessBoardChanceCfg[arg_49_1].params[2])
			end

			for iter_49_0, iter_49_1 in pairs(ChessBoardChanceCfg[arg_49_1].params[3]) do
				table.insert(var_49_2, iter_49_1)
			end

			ChessBoardCheckStoryIterator.New(var_49_2, function()
				if var_49_1.chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_49_1.chance_event].player_params) then
					self:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
						playerA = 0,
						playerB = -1,
						gridData = self:GetCurHeroPosGridData(),
						chanceID = arg_49_1
					})
				end

				self:StartExecuteEvent(function()
					if var_49_0.chanceID == arg_49_1 then
						self:SetChanceServerData({
							isUnLock = 0,
							chanceID = 0,
							chancePropList = {},
							chanceChooseList = {}
						})
					end

					self:FixBGM()

					if self:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
						JumpTools.OpenPageByJump("/chessBoardOverView")
					elseif self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
						manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
						ChessBoardAction.HeroMoveEnd(function()
							self:OnHeroTurnEnd()
						end)
					else
						manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
					end
				end)
			end):MoveNext()
		else
			if ChessBoardChanceCfg[arg_49_1].chance_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[ChessBoardChanceCfg[arg_49_1].chance_event].player_params) then
				self:ExecuteTiming(ChessBoardConst.TIMING.CHANCE_FINISH, {
					playerA = 0,
					playerB = -1,
					gridData = self:GetCurHeroPosGridData(),
					chanceID = arg_49_1
				})
			end

			self:StartExecuteEvent(function()
				if var_49_0.chanceID == arg_49_1 then
					self:SetChanceServerData({
						isUnLock = 0,
						chanceID = 0,
						chancePropList = {},
						chanceChooseList = {}
					})
				end

				self:FixBGM()

				if self:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_FINISH") > 0 then
					JumpTools.OpenPageByJump("/chessBoardOverView")
				elseif self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
					ChessBoardAction.HeroMoveEnd(function()
						self:OnHeroTurnEnd()
					end)
				else
					manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
				end

				self:FixBGM()
			end)
		end
	else
		local var_49_4 = ChessBoardChanceCfg[arg_49_1]

		if ChessBoardChanceCfg[arg_49_1].type == ChessBoardConst.CHANCE_TYPE.ARENA then
			if arg_49_3 > 0 then
				if var_49_4.params[2] ~= 0 then
					manager.story:StartChessStoryWithBackground(var_49_4.params[2], function(arg_61_0)
						if var_49_0.chanceID == arg_49_1 then
							self:SetChanceServerData({
								isUnLock = 0,
								chanceID = 0,
								chancePropList = {},
								chanceChooseList = {}
							})
						end

						self:FixBGM()

						if self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
							manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
							ChessBoardAction.HeroMoveEnd(function()
								self:OnHeroTurnEnd()
							end)
						else
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
						end
					end)
				end
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, false)
				self:FixBGM()

				if var_49_0.chanceID == arg_49_1 then
					self:SetChanceServerData({
						isUnLock = 0,
						chanceID = 0,
						chancePropList = {},
						chanceChooseList = {}
					})
				end

				if self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
					ChessBoardAction.HeroMoveEnd(function()
						self:OnHeroTurnEnd()
					end)
				else
					manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
				end
			end
		else
			if var_49_0.chanceID == arg_49_1 then
				self:SetChanceServerData({
					isUnLock = 0,
					chanceID = 0,
					chancePropList = {},
					chanceChooseList = {}
				})
			end

			self:FixBGM()

			if self.heroEntity_:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
				manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
				ChessBoardAction.HeroMoveEnd(function()
					self:OnHeroTurnEnd()
				end)
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE, false)
			end
		end
	end
end

function var_0_0:EffectShow(arg_65_1)
	if arg_65_1 == ChessBoardConst.EFFECT_TYPE.NORMAL_ARROW then
		local var_65_0, var_65_1 = self.heroEntity_:GetPosAndDir()
		local var_65_2 = ChessBoardLuaBridge.FindNextMovePos(var_65_0.x, var_65_0.z, var_65_1)

		ChessBoardLuaBridge.ShowArrowEffect(var_65_0.x, var_65_0.z, var_65_1)
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.MULT_ARROW then
		local var_65_3, var_65_4 = self.heroEntity_:GetPosAndDir()

		ChessBoardLuaBridge.ShowMultArrowEffect(var_65_3.x, var_65_3.z, var_65_4)
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.SIGN_NPC then
		self.isSelectNpc_ = true

		ChessBoardLuaBridge.SetSelectingNPCMovePos(true)

		for iter_65_0, iter_65_1 in pairs((self.NPCManager_:GetAllNpcPos())) do
			ChessBoardLuaBridge.ShowChoiceEffect(iter_65_1.x, iter_65_1.z)
		end
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.SIGN_THING then
		self.isSelectMapPos_ = true

		ChessBoardLuaBridge.SetSelectingMapPos(true)
		ChessBoardLuaBridge.ShowAllThingChoiceEffect()
	elseif arg_65_1 == ChessBoardConst.EFFECT_TYPE.SIGN_NO_THING_GRID then
		self.isSelectMapPos_ = true

		ChessBoardLuaBridge.SetSelectingMapPos(true)

		local var_65_5, var_65_6 = self.heroEntity_:GetPosAndDir()

		ChessBoardLuaBridge.ShowAllNoThingGridChoiceEffect(var_65_5.x, var_65_5.z)
	end
end

function var_0_0:UseSelectNpcProp(arg_66_1)
	if arg_66_1 then
		self.selectPropID = arg_66_1

		self:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_NPC)

		if ChessBoardPropCfg[arg_66_1].type == ChessBoardConst.PROPTYPE.GUN then
			ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_KILL")
		elseif ChessBoardPropCfg[arg_66_1].type == ChessBoardConst.PROPTYPE.SWAP then
			ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_SWAP")
		end
	end
end

function var_0_0:UseSelectPlayerProp(arg_67_1)
	if arg_67_1 then
		self.selectPropID = arg_67_1

		self:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_NPC)

		local var_67_0, var_67_1 = self.heroEntity_:GetPosAndDir()

		ChessBoardLuaBridge.ShowChoiceEffect(var_67_0.x, var_67_0.z)

		if ChessBoardPropCfg[arg_67_1].type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
			ShowTips("CHESSBOARD_SELECT_ADD_BUFF")
		end
	end
end

function var_0_0:CheckCanUseDefuseCard()
	if ChessBoardLuaBridge.CheckHaveThingCanDestory() then
		return true
	end

	local var_68_0, var_68_1 = self.heroEntity_:GetBuffData()

	if var_68_0 ~= nil then
		return true
	end

	return false
end

function var_0_0:UseSelectThingProp(arg_69_1)
	if arg_69_1 then
		self.selectPropID = arg_69_1

		self:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_THING)

		if ChessBoardPropCfg[arg_69_1].type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			ShowTips("CHESSBOARD_SELECT_REMOVE")

			local var_69_0, var_69_1 = self.heroEntity_:GetPosAndDir()

			ChessBoardLuaBridge.ShowChoiceEffect(var_69_0.x, var_69_0.z)
		end
	end
end

function var_0_0:UseSelectNoThingGridProp(arg_70_1)
	if arg_70_1 then
		self.selectPropID = arg_70_1

		self:EffectShow(ChessBoardConst.EFFECT_TYPE.SIGN_NO_THING_GRID)

		if ChessBoardPropCfg[arg_70_1].type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			ShowTips("CHESSBOARD_SELECT_ADD")
		end
	end
end

function var_0_0.PlayEntityAction(arg_71_0, arg_71_1, arg_71_2)
	ChessBoardLuaBridge.PlayEntityAction(arg_71_1, arg_71_2)
end

function var_0_0:HeroRollDice()
	if self.isArenaChance_ then
		self.blockerManager_:ShowBlocker()
		ChessBoardAction.RollChanceDice(function(arg_73_0, arg_73_1)
			self.blockerManager_:HideBlocker()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.DICE)
			manager.notify:CallUpdateFunc(CHESSBOARD_PLAY_DICE_ANI, arg_73_0, arg_73_1)
		end)
	elseif self:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START then
		self.blockerManager_:ShowBlocker()
		ChessBoardAction.HeroRollDice(function(arg_74_0)
			self.blockerManager_:HideBlocker()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.DICE)
			ChessBoardLuaBridge.ClearMoveEffect()
			manager.notify:CallUpdateFunc(CHESSBOARD_PLAY_DICE_ANI, arg_74_0)

			self.isCanUseProp_ = false
		end)
	end
end

function var_0_0:HeroTryToMove()
	manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)

	local var_75_0, var_75_1 = self.heroEntity_:GetPosAndDir()
	local var_75_2 = ChessBoardLuaBridge.FindNextMovePos(var_75_0.x, var_75_0.z, var_75_1)

	if var_75_2.Count > 1 then
		ShowTips("CHESSBOARD_SELECT_ROAD")
		self:EffectShow(ChessBoardConst.EFFECT_TYPE.MULT_ARROW)

		self.curCanMovePosListCache_ = {}
		self.isSelectPosing_ = true

		ChessBoardLuaBridge.SetSelectingMovePos(true)

		for iter_75_0 = 0, var_75_2.Count - 1 do
			table.insert(self.curCanMovePosListCache_, {
				x = var_75_2[iter_75_0].x,
				z = var_75_2[iter_75_0].z
			})
		end

		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
	elseif var_75_2.Count == 1 then
		self:SendHeroWantMove({
			x = var_75_2[0].x,
			z = var_75_2[0].z
		}, function()
			manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, false)
		end)
	elseif var_75_2.Count <= 0 then
		error("当前格子找不到下一个可移动的格子！！")
	end
end

function var_0_0:SendHeroWantMove(arg_77_1, arg_77_2)
	local function var_77_0()
		ChessBoardAction.HeroWantToMoveByPos(arg_77_1, function()
			if manager.ChessBoardManager then
				self.blockerManager_:ShowBlocker()
				self.heroEntity_:CheckMoveBegin(arg_77_1)
			end

			if arg_77_2 then
				arg_77_2()
			end

			ChessBoardLuaBridge.MoveHeroToPos(arg_77_1.x, arg_77_1.z, function()
				if manager.ChessBoardManager then
					self.blockerManager_:HideBlocker()
					self.heroEntity_:MoveToPos(arg_77_1.x, arg_77_1.z)
				end
			end)
		end)
	end

	if self.heroEntity_:GetNextPosPlayerAcitonType(arg_77_1) == ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.MY_BANNER, {
			callback = var_77_0
		})
	else
		var_77_0()
	end
end

function var_0_0:CheckOverlap(arg_81_1)
	local var_81_0, var_81_1 = self.heroEntity_:GetPosAndDir()
	local var_81_2 = self.NPCManager_:FindTargetPosNPCEntity(var_81_0, self.heroEntity_:GetEntityId())

	if var_81_2 then
		ChessBoardLuaBridge.PlayEntityOverlap(var_81_2:GetEntityId(), arg_81_1)
	end
end

function var_0_0:SelectMovePos(arg_82_1, arg_82_2)
	if self.isSelectPosing_ then
		local var_82_0

		for iter_82_0, iter_82_1 in pairs(self.curCanMovePosListCache_) do
			if iter_82_1.x == arg_82_1 and iter_82_1.z == arg_82_2 then
				var_82_0 = {
					x = arg_82_1,
					z = arg_82_2
				}

				break
			end
		end

		if var_82_0 then
			self:CheckOverlap(false)

			self.isSelectPosing_ = false

			ChessBoardLuaBridge.SetSelectingMovePos(false)

			self.curCanMovePosListCache_ = {}

			manager.notify:CallUpdateFunc(CHESSBOARD_STEP_UPDATE)
			self:SendHeroWantMove(var_82_0, function()
				ChessBoardLuaBridge.ClearMoveEffect()
			end)
		end
	else
		error("当前不需要选择格子！")
	end
end

function var_0_0:SelectNpcPos(arg_84_1, arg_84_2)
	if self.isSelectNpc_ then
		local var_84_0

		for iter_84_0, iter_84_1 in pairs((self.NPCManager_:GetAllNpcPos())) do
			if iter_84_1.x == arg_84_1 and iter_84_1.z == arg_84_2 then
				var_84_0 = {
					x = arg_84_1,
					z = arg_84_2
				}

				break
			end
		end

		local var_84_1, var_84_2 = self.heroEntity_:GetPosAndDir()

		if ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.GUN or ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SWAP then
			if var_84_0 then
				local var_84_3

				if ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.GUN then
					var_84_3 = GetTips("CHESSBOARD_IS_KILL_DUCK")
				elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SWAP then
					var_84_3 = GetTips("CHESSBOARD_IS_SWAP_DUCK")
				end

				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = var_84_3,
					OkCallback = function()
						self.isSelectNpc_ = false

						ChessBoardLuaBridge.SetSelectingNPCMovePos(false)
						ChessBoardAction.UseProp(self.selectPropID, {
							arg_84_1,
							arg_84_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							self:PropEffect(self.selectPropID, {
								arg_84_1,
								arg_84_2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.USE_PROP, {
								isUseStart = false,
								propID = self.selectPropID
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.GUN then
				ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_KILL")
			elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SWAP then
				ShowTips("CHESSBOARD_CHOOSE_DUCK_TO_SWAP")
			end
		elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
			if var_84_0 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_SURE_NPC_ADD_BUFF"),
					OkCallback = function()
						self.isSelectNpc_ = false

						ChessBoardLuaBridge.SetSelectingNPCMovePos(false)
						ChessBoardAction.UseProp(self.selectPropID, {
							arg_84_1,
							arg_84_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							self:PropEffect(self.selectPropID, {
								1,
								arg_84_1,
								arg_84_2
							})
							manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
						end)
					end
				})
			elseif var_84_1.x == arg_84_1 and var_84_1.z == arg_84_2 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_SURE_SELF_ADD_BUFF"),
					OkCallback = function()
						self.isSelectNpc_ = false

						ChessBoardLuaBridge.SetSelectingNPCMovePos(false)
						ChessBoardAction.UseProp(self.selectPropID, {
							arg_84_1,
							arg_84_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							self:PropEffect(self.selectPropID, {
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

function var_0_0:SelectMapPos(arg_91_1, arg_91_2)
	if self.isSelectMapPos_ then
		if ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
			local var_91_0 = self.heroEntity_:GetPosAndDir()
			local var_91_1 = ChessBoardLuaBridge.GetGridData(arg_91_1, arg_91_2)

			if var_91_0.x == arg_91_1 and var_91_0.z == arg_91_2 then
				local var_91_2, var_91_3 = self.heroEntity_:GetBuffData()

				if var_91_2 == nil then
					ShowTips("CHESSBOARD_HERO_NO_BUFF")
				else
					ChessBoardTools.ChessBoardMessageBox({
						title = GetTips("PROMPT"),
						content = GetTips("CHESSBOARD_CLEAR_BUFF"),
						OkCallback = function()
							self.isSelectMapPos_ = false

							ChessBoardLuaBridge.SetSelectingMapPos(false)
							ChessBoardAction.UseProp(self.selectPropID, {
								arg_91_1,
								arg_91_2
							}, function()
								ChessBoardLuaBridge.ClearChoiceEffect()
								self:PropEffect(self.selectPropID, {
									1
								})
								manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
							end)
						end
					})
				end
			elseif var_91_1.thingTypeID > 0 and ChessBoardThingCfg[var_91_1.thingTypeID].destoryable > 0 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_CLEAR_THING"),
					OkCallback = function()
						self.isSelectMapPos_ = false

						ChessBoardLuaBridge.SetSelectingMapPos(false)
						ChessBoardAction.UseProp(self.selectPropID, {
							arg_91_1,
							arg_91_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							self:PropEffect(self.selectPropID, {
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
		elseif ChessBoardPropCfg[self.selectPropID].type == ChessBoardConst.PROPTYPE.NEW_MAP_THING then
			local var_91_4 = self.heroEntity_:GetPosAndDir()
			local var_91_5 = ChessBoardLuaBridge.GetGridData(arg_91_1, arg_91_2)

			if var_91_4.x == arg_91_1 and var_91_4.z == arg_91_2 then
				ShowTips("CHESSBOARD_SELECT_PUT")
			elseif var_91_5.thingTypeID > 0 then
				ShowTips("CHESSBOARD_SELECT_PUT")
			elseif self.NPCManager_:FindNPCWithPos(arg_91_1, arg_91_2) ~= nil then
				ShowTips("CHESSBOARD_SELECT_PUT")
			elseif var_91_5.thingTypeID == 0 and ChessBoardHexCfg[var_91_5.typeID].walkable >= 1 and ChessBoardHexCfg[var_91_5.typeID].updatable == 0 then
				ChessBoardTools.ChessBoardMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CHESSBOARD_SURE_PUT"),
					OkCallback = function()
						self.isSelectMapPos_ = false

						ChessBoardLuaBridge.SetSelectingMapPos(false)
						ChessBoardAction.UseProp(self.selectPropID, {
							arg_91_1,
							arg_91_2
						}, function()
							ChessBoardLuaBridge.ClearChoiceEffect()
							self:PropEffect(self.selectPropID, {
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
	if ChessBoardHexCfg[arg_98_2] and ChessBoardHexCfg[arg_98_2].dec ~= "" then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GRID_BUBBLE, {
			modelPos = arg_98_1,
			thingTypeID = arg_98_2
		})
	end
end

function var_0_0:ChangeGridByExtentID(arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5)
	self.blockerManager_:ShowBlocker()

	if ChessBoardHexCfg[ChessBoardData:GetExtendGridJsonData(arg_99_3).typeID].walkable == 0 then
		local var_99_0, var_99_1 = self.heroEntity_:GetPosAndDir()

		if var_99_0.x == arg_99_1 and var_99_0.z == arg_99_2 then
			local var_99_2 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapID()]

			ChessBoardLuaBridge.MoveTargetSmooth(arg_99_1, arg_99_2, function()
				ShowTips("CHESSBOARD_CHANGE_MAP_TP")
				self:PlayPortHeroEffect(arg_99_1, arg_99_2)
				ChessBoardLuaBridge.SetHeroPosAndDir(var_99_2.init_pos[1], var_99_2.init_pos[2], var_99_2.init_dir)
				self.heroEntity_:TelePortHeroToPosition(var_99_2.init_pos[1], var_99_2.init_pos[2], var_99_2.init_dir)
				self:AddDelayTimer(1, function()
					ChessBoardLuaBridge.MoveTargetSmooth(arg_99_1, arg_99_2, function()
						ChessBoardLuaBridge.ChangeGridByIndex(arg_99_1, arg_99_2, arg_99_3, arg_99_4, function()
							self.blockerManager_:HideBlocker()

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
			local var_99_3 = self.NPCManager_:FindNPCWithPos(arg_99_1, arg_99_2)

			if var_99_3 ~= nil then
				ChessBoardLuaBridge.ShowNPCDestoryEffectActive(arg_99_1, arg_99_2)
				manager.ChessBoardManager:AddDelayTimer(0.5, function()
					ChessBoardLuaBridge.ClearNPCDestoryEffect()
				end)
				self:DeleteNPC(var_99_3)
			end

			ChessBoardLuaBridge.ChangeGridByIndex(arg_99_1, arg_99_2, arg_99_3, arg_99_4, function()
				self.blockerManager_:HideBlocker()

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
			self.blockerManager_:HideBlocker()

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

function var_0_0:ChangeThingByExtentID(arg_107_1, arg_107_2, arg_107_3, arg_107_4)
	self.blockerManager_:ShowBlocker()

	if ChessBoardThingCfg[ChessBoardData:GetExtendThingJsonData(arg_107_3).thingTypeID].fix_walkable == 1 then
		local var_107_0, var_107_1 = self.heroEntity_:GetPosAndDir()

		if var_107_0.x == arg_107_1 and var_107_0.z == arg_107_2 then
			local var_107_2 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapID()]

			ChessBoardLuaBridge.MoveTargetSmooth(arg_107_1, arg_107_2, function()
				ShowTips("CHESSBOARD_CHANGE_MAP_TP")
				self:PlayPortHeroEffect(arg_107_1, arg_107_2)
				ChessBoardLuaBridge.SetHeroPosAndDir(var_107_2.init_pos[1], var_107_2.init_pos[2], var_107_2.init_dir)
				self.heroEntity_:TelePortHeroToPosition(var_107_2.init_pos[1], var_107_2.init_pos[2], var_107_2.init_dir)
				self:AddDelayTimer(1, function()
					ChessBoardLuaBridge.MoveTargetSmooth(arg_107_1, arg_107_2, function()
						ChessBoardLuaBridge.ChangeThingByIndex(arg_107_1, arg_107_2, arg_107_3, function()
							self.blockerManager_:HideBlocker()
							ChessBoardData:ChangeThingLua(arg_107_1, arg_107_2, arg_107_3)

							if arg_107_4 then
								arg_107_4()
							end
						end)
					end)
				end)
			end)
		else
			local var_107_3 = self.NPCManager_:FindNPCWithPos(arg_107_1, arg_107_2)

			if var_107_3 ~= nil then
				ChessBoardLuaBridge.ShowNPCDestoryEffectActive(arg_107_1, arg_107_2)
				manager.ChessBoardManager:AddDelayTimer(0.5, function()
					ChessBoardLuaBridge.ClearNPCDestoryEffect()
				end)
				self:DeleteNPC(var_107_3)
			end

			ChessBoardLuaBridge.ChangeThingByIndex(arg_107_1, arg_107_2, arg_107_3, function()
				self.blockerManager_:HideBlocker()
				ChessBoardData:ChangeThingLua(arg_107_1, arg_107_2, arg_107_3)

				if arg_107_4 then
					arg_107_4()
				end
			end)
		end
	else
		ChessBoardLuaBridge.ChangeThingByIndex(arg_107_1, arg_107_2, arg_107_3, function()
			self.blockerManager_:HideBlocker()
			ChessBoardData:ChangeThingLua(arg_107_1, arg_107_2, arg_107_3)

			if arg_107_4 then
				arg_107_4()
			end
		end)
	end
end

function var_0_0:DeleteThing(arg_115_1, arg_115_2, arg_115_3)
	self.blockerManager_:ShowBlocker()
	ChessBoardLuaBridge.DeleteThing(arg_115_1, arg_115_2, function()
		self.blockerManager_:HideBlocker()
		ChessBoardData:DeleteThingLua(arg_115_1, arg_115_2)

		if arg_115_3 then
			arg_115_3()
		end
	end)
end

function var_0_0:PlayGridAnimation(arg_117_1, arg_117_2, arg_117_3, arg_117_4, arg_117_5)
	self.blockerManager_:ShowBlocker()

	if ChessBoardLuaBridge.GetGridData(arg_117_1, arg_117_2).thingTypeID == ChessBoardConst.BOMB_BALLOON and self.NPCManager_:GetMovingNPC() == -1 then
		self:AddDelayTimer(1, function()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SAD)
		end)
	end

	ChessBoardLuaBridge.PlayGridAnimation(arg_117_1, arg_117_2, arg_117_3, arg_117_4, function()
		self.blockerManager_:HideBlocker()
		arg_117_5()
	end)
end

function var_0_0:MoveToTarget(arg_120_1, arg_120_2, arg_120_3)
	self.isMovingCamera_ = true

	self.blockerManager_:ShowBlocker()
	manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, true)
	ChessBoardLuaBridge.MoveTargetSmooth(arg_120_1, arg_120_2, function()
		manager.notify:CallUpdateFunc(CHESSBOARD_CAMERA_MOVE, true)

		self.isMovingCamera_ = false

		self.blockerManager_:HideBlocker()

		if arg_120_3 then
			arg_120_3()
		end
	end, true)
end

function var_0_0:GetIsCameraMoving()
	return self.isMovingCamera_
end

function var_0_0:GetIsCanUseProp()
	return self.isCanUseProp_
end

function var_0_0.SetIsCanUseProp(arg_124_0, arg_124_1)
	arg_124_0.isCanUseProp_ = arg_124_1
end

function var_0_0:UpdateMapTurn()
	self.blockerManager_:ShowBlocker()

	self.curMapTurn_ = self.curMapTurn_ + 1

	manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.NEW_ROUND_OPEN_TIPS, {
		callback = function()
			self:MapEventTrigger()
		end
	})
end

function var_0_0:MapEventTrigger()
	local var_127_0 = false

	for iter_127_0, iter_127_1 in pairs(self.curMapTurnEventCfg_) do
		if self.curMapTurn_ == iter_127_1[1] then
			if ChessBoardEventPoolCfg[iter_127_1[2]] and not table.isEmpty(ChessBoardEventPoolCfg[iter_127_1[2]].player_params) then
				var_127_0 = true

				if ChessBoardEventPoolCfg[iter_127_1[2]].type == 1 then
					self:ExecuteTiming(ChessBoardConst.TIMING.MAP_EVENT, {
						playerB = -1,
						playerA = 0,
						mapTurnNum = self.curMapTurn_
					})
					self:StartExecuteEvent(function()
						self:MyTurnBegin()
					end)
				elseif ChessBoardEventPoolCfg[iter_127_1[2]].type == 2 then
					-- block empty
				end
			end
		end
	end

	if not var_127_0 then
		self:MyTurnBegin()
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

function var_0_0:OnHeroTurnEnd()
	self.heroEntity_:OnBuffUpdateTurn()
	self:SetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START)

	local var_131_0 = self.heroEntity_:GetCurUsedPropID()

	if var_131_0 > 0 then
		self:FixPropEffect(var_131_0)
	end

	self.heroEntity_:ClearCurUsedPropID()
	self:AddDelayTimer(0.5, function()
		self:OnGridTips()
	end)
end

function var_0_0:OnGridTips()
	local var_133_0 = self.heroEntity_:GetPosAndDir()
	local var_133_1 = ChessBoardLuaBridge.GetGridData(var_133_0.x, var_133_0.z)

	if var_133_1.typeID == ChessBoardConst.DUCK_GRID_ID then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.DUCK_CREATE_TIPS, {
			callback = function()
				manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.NERVOUS)
				self:AddDelayTimer(1.5, function()
					self.NPCManager_:StartNPCTurn()
				end)
			end
		})
	elseif var_133_1.typeID == ChessBoardConst.SUFFER_GRID_ID then
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SAD)
		self:AddDelayTimer(1.5, function()
			self.NPCManager_:StartNPCTurn()
		end)
	else
		self.NPCManager_:StartNPCTurn()
	end
end

function var_0_0:GetCurMapTurnCount()
	return self.curMapTurn_
end

function var_0_0:PropEffect(arg_138_1, arg_138_2)
	local var_138_0 = ChessBoardPropCfg[arg_138_1]

	if self.isArenaChance_ then
		self:GetCurChanceInfo().chanceChooseList[3] = arg_138_1
	else
		self.heroEntity_:SetCurUsedPropID(arg_138_1)
	end

	self.isCanUseProp_ = false

	if var_138_0.type == ChessBoardConst.PROPTYPE.ADD_BUFF then
		self.heroEntity_:AddBuff(var_138_0.params[1])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.GUN then
		local var_138_1 = self.NPCManager_:FindNPCWithPos(arg_138_2[1], arg_138_2[2])

		ChessBoardLuaBridge.SetNPCToCameraTarget(var_138_1)
		ChessBoardLuaBridge.ChangeCameraToCloseCamera()
		self:PlayEntityAction(var_138_1, ChessBoardConst.ACTIONTYPE.HIT)
		self:AddDelayTimer(2, function()
			self:DeleteNPC(var_138_1)
			ChessBoardLuaBridge.LookAtPlayer()
			manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
			manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
		end)
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.SWAP then
		local var_138_2, var_138_3 = self.heroEntity_:GetPosAndDir()
		local var_138_4 = self.NPCManager_:FindNPCWithPos(arg_138_2[1], arg_138_2[2])
		local var_138_5, var_138_6 = self.NPCManager_:GetNPCPosAndDir(var_138_4)

		self:TelePortHeroToPosition(var_138_5.x, var_138_5.z, var_138_6)
		ChessBoardLuaBridge.ClearMoveEffect()
		self:EffectShow(ChessBoardConst.EFFECT_TYPE.NORMAL_ARROW)
		self:TelePortNPCToPosition(var_138_4, var_138_2.x, var_138_2.z, var_138_3)
		manager.notify:CallUpdateFunc(CHESSBOARD_VIEW_STATE_UPDATE, ChessBoardConst.VIEW_STATE_TYPE.NORMAL)
		manager.notify:CallUpdateFunc(CHESSBOARD_PROP_UPDATE)
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.SET_DICE_POINT then
		self:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_SELECT", var_138_0.params[1])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.ADD_ATTRIBUTE then
		self:SubHeroAttribute(var_138_0.params[1], var_138_0.params[2])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.ADD_ATTRIBUTE_CURTURN then
		self:SubHeroAttribute(var_138_0.params[1], var_138_0.params[2])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.NEW_MAP_THING then
		self:ChangeThingByExtentID(arg_138_2[1], arg_138_2[2], var_138_0.params[1])
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.DEFUSE_CARD then
		if arg_138_2[1] == 1 then
			self.heroEntity_.buffManager_:CheckClashBuff()
		elseif arg_138_2[1] == 2 then
			manager.ChessBoardManager:DeleteThing(arg_138_2[2], arg_138_2[3])
		end
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.NPC_STOP_MOVE_CARD then
		ShowTips("CHESSBOARD_DUCK_STOP")
	elseif var_138_0.type == ChessBoardConst.PROPTYPE.SELECT_ADD_BUFF then
		if arg_138_2[1] == 1 then
			self:AddBuff(self.NPCManager_:FindNPCWithPos(arg_138_2[2], arg_138_2[3]), var_138_0.params[1])
		elseif arg_138_2[1] == 2 then
			self.heroEntity_:AddBuff(var_138_0.params[1])
		end
	end

	if arg_138_1 == 10001 or arg_138_1 == 10002 then
		self:HeroRollDice()
	end
end

function var_0_0:FixPropEffect(arg_140_1)
	if ChessBoardPropCfg[arg_140_1].type == ChessBoardConst.PROPTYPE.SET_DICE_POINT then
		self:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_SELECT", 0)
	elseif ChessBoardPropCfg[arg_140_1].type == ChessBoardConst.PROPTYPE.ADD_ATTRIBUTE_CURTURN then
		self:SubHeroAttribute(ChessBoardPropCfg[arg_140_1].params[1], -ChessBoardPropCfg[arg_140_1].params[2])
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

function var_0_0:IsBattleBack()
	return self.battleStart_
end

function var_0_0.SetSmallGamePoint(arg_143_0, arg_143_1, arg_143_2)
	arg_143_0.battleResult_ = arg_143_1
	arg_143_0.battlePoint_ = arg_143_2
end

function var_0_0:QTEFinish(arg_144_1)
	local var_144_0 = self.curChanceID_
	local var_144_1 = self.battlePoint_

	if arg_144_1.params[1] == 1 then
		gameContext:Go("/chessBoardHomeView")

		local var_144_2 = 0

		for iter_144_0, iter_144_1 in pairs(arg_144_1.params[2] or {}) do
			if iter_144_1[1] == self.battlePoint_ then
				var_144_2 = iter_144_1[2]

				break
			end
		end

		manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", var_144_2)
		ChessBoardAction.FinishChance(self.curChanceID_, self.battleResult_, self.battlePoint_)

		if self.battlePoint_ == ChessBoardQTEGameConst.QTEGameResult.Perfect then
			self:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY)
		end
	else
		gameContext:Go("/chessBoardHomeView")

		local var_144_3 = 0

		for iter_144_2, iter_144_3 in pairs(arg_144_1.params[2] or {}) do
			if iter_144_3[1] == self.battlePoint_ then
				var_144_3 = iter_144_3[2]

				break
			end
		end

		local var_144_4 = manager.ChessBoardManager:GetCurChanceInfo()

		for iter_144_4 = 1, var_144_3 do
			if var_144_4.chancePropList[iter_144_4] then
				ChessBoardData:AddTmpProp(var_144_4.chancePropList[iter_144_4])
			end
		end

		ChessBoardAction.FinishChance(self.curChanceID_, 0, self.battlePoint_)
		self:ReconnectionTmpListProp(nil, function()
			manager.ChessBoardManager:FinishChance(var_144_0, 0, var_144_1)

			if var_144_1 == ChessBoardQTEGameConst.QTEGameResult.Perfect then
				self:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HAPPY)
			end
		end)
	end
end

function var_0_0:BattleFinish()
	if self.battleStart_ then
		if ChessBoardChanceCfg[self.curChanceID_].type == ChessBoardConst.CHANCE_TYPE.QTE then
			gameContext:Go("/chessBoardHomeView")
			self:QTEFinish(ChessBoardChanceCfg[self.curChanceID_])
		elseif self.battleResult_ == 0 then
			ChessBoardAction.FinishChance(self.curChanceID_, self.battleResult_, self.battlePoint_, function()
				gameContext:Go("/chessBoardHomeView")
			end)
		elseif self.battleResult_ == 1 then
			ChessBoardTools.OpenChanceView(self.curChanceID_)
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

	local var_148_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_148_0 then
		var_148_0.shadowRotationImmediately = self.originShadowRotationImmediately
	end

	ChessBoardLuaBridge.SetCameraControlEnable(true)
end

function var_0_0.StartArenaChance(arg_149_0)
	arg_149_0.isArenaChance_ = true
	arg_149_0.isArenaChanceFinishSend_ = false

	manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, true)
end

function var_0_0:GetIsArenaChance()
	return self.isArenaChance_
end

function var_0_0:CheckArenaChance()
	local var_151_0 = self:GetCurChanceInfo()

	if var_151_0.chanceChooseList[2] >= ChessBoardChanceCfg[var_151_0.chanceID].params[1] then
		return 1
	elseif var_151_0.chanceChooseList[1] <= 0 then
		return 2
	else
		return 0
	end
end

function var_0_0:FinishArenaChance(arg_152_1)
	if self.isArenaChanceFinishSend_ then
		return
	end

	local var_152_0 = self:GetCurChanceInfo()

	if arg_152_1 then
		ShowTips("CHESSBOARD_ARENA_SUCCESS")

		self.isArenaChanceFinishSend_ = true

		ChessBoardAction.FinishChance(var_152_0.chanceID, 0, var_152_0.chanceChooseList[2], function()
			self.isArenaChance_ = false

			manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, false)
		end)
	else
		ShowTips("CHESSBOARD_ARENA_FAILED")

		self.isArenaChanceFinishSend_ = true

		ChessBoardAction.FinishChance(var_152_0.chanceID, 1, var_152_0.chanceChooseList[2], function()
			self.isArenaChance_ = false

			self:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_ARENA_DICE_NUM", 1)
			manager.notify:CallUpdateFunc(CHESSBOARD_ARENA_UI_UPDATE, false)
		end)
	end
end

function var_0_0:AddDelayTimer(arg_155_1, arg_155_2)
	self.blockerManager_:ShowBlocker()

	if ChessBoardData:GetIsFastModule() == true then
		arg_155_1 = arg_155_1 / 2
	end

	if arg_155_2 == nil then
		return
	end

	if arg_155_1 == 0 then
		self.blockerManager_:HideBlocker()
		arg_155_2()

		return
	end

	local var_155_0 = self.timerIndex

	self.delayTimerList[self.timerIndex] = Timer.New(function()
		self.blockerManager_:HideBlocker()
		arg_155_2()
		self:DeleteTimer(var_155_0)
	end, arg_155_1, 1)

	self.delayTimerList[var_155_0]:Start()

	self.timerIndex = (self.timerIndex + 1) % 10
end

function var_0_0:DeleteTimer(arg_157_1)
	if self.delayTimerList[arg_157_1] then
		self.delayTimerList[arg_157_1]:Stop()

		self.delayTimerList[arg_157_1] = nil
	end
end

function var_0_0:ChangeFastModule()
	local var_158_0 = ChessBoardData:ChangeFastModule()

	self:ApplyFastModule(var_158_0)

	return var_158_0
end

function var_0_0:ApplyFastModule(arg_159_1)
	ChessBoardLuaBridge.ChangeSpeedModule(arg_159_1)
	self.diceManager_:OnChessBoardFastModuleUpdate(arg_159_1)
end

function var_0_0:FixBGM()
	if ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapID()].activity == ChessBoardConst.ARENA_ACTIVITYID then
		manager.audio:PlayBGM("bgm_activity_3_3_minigame_warchess_stage", "bgm_activity_3_3_minigame_warchess_stage", "bgm_activity_3_3_minigame_warchess_stage.awb")

		if self:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ARENA_ACTIVE") >= 1 then
			manager.audio:PlayEffect("bgm_activity_3_3_minigame_warchess_stage", "bgm_activity_3_3_minigame_warchess_openlight", "")
		end
	else
		manager.audio:PlayBGM("bgm_activity_3_3_minigame_warchess", "bgm_activity_3_3_minigame_warchess", "bgm_activity_3_3_minigame_warchess.awb")
	end
end

function var_0_0:Dispose()
	for iter_161_0, iter_161_1 in pairs(self.delayTimerList) do
		self:DeleteTimer(iter_161_0)
	end

	self.heroEntity_:Dispose()
	self.NPCManager_:Dispose()
	self.taskManager_:Dispose()
	self.eventQueueManager_:Clear()
	self:DisposeSupportModule()
	self:ClearBattleData()

	self.isArenaChance_ = false
	self.curMapTurn_ = 0
	self.selectPropID = nil
	self.eventCallBack_ = nil
end

return var_0_0
