local ChessBoardNPCEntity = class("ChessBoardNPCEntity", ChessBoardPlayerEntity)

function ChessBoardNPCEntity:Ctor()
	self.super.Ctor(self)

	self.movePos_ = {}
	self.readyToMove_ = false
	self.curMovePosIndex_ = 1
end

function ChessBoardNPCEntity:GetNPCType()
	return self.playerType_
end

function ChessBoardNPCEntity:SetMovePosList(arg_3_1, arg_3_2)
	self.movePos_ = arg_3_1
	self.readyToMove_ = true
	self.curMovePosIndex_ = 1

	self:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", arg_3_2)
end

function ChessBoardNPCEntity:GetMoveStep()
	return self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")
end

function ChessBoardNPCEntity:OnMoveStart()
	ChessBoardLuaBridge.SetNPCToCameraTarget(self.id_)
	manager.ChessBoardManager:PlayEntityAction(self.id_, ChessBoardConst.ACTIONTYPE.DICE)

	if ChessBoardNPCPoolCfg[self.playerType_].npc_start_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[ChessBoardNPCPoolCfg[self.playerType_].npc_start_event].npc_params) then
		manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_TURN_START, {
			playerB = -1,
			playerA = self.id_
		})
	end
end

function ChessBoardNPCEntity:MoveToNextPos()
	local var_6_0 = self.movePos_[self.curMovePosIndex_]

	if self.movePos_[self.curMovePosIndex_] == nil then
		error("当前NPC没有移动步数了仍要去移动！NPCID：" .. self.id_)

		return
	end

	local function var_6_1()
		ChessBoardLuaBridge.SetNPCToCameraTarget(self.id_)
		self:CheckPosIsNeedHeadAni(var_6_0)
		ChessBoardLuaBridge.NPCMoveTo(self.id_, var_6_0.x, var_6_0.z, function()
			self:MoveToPos(var_6_0.x, var_6_0.z)
		end)
	end

	if self:GetNextPosNPCAcitonType(self.movePos_[self.curMovePosIndex_]) == ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.NPC_BANNER, {
			callback = var_6_1
		})
	else
		var_6_1()
	end
end

function ChessBoardNPCEntity:MoveToPos(arg_9_1, arg_9_2)
	ChessBoardLuaBridge.SetStepEffectActive(0, 0, false)

	local var_9_0 = ChessBoardLuaBridge.GetGridData(self.pos_.x, self.pos_.z)
	local var_9_1 = ChessBoardLuaBridge.GetGridData(arg_9_1, arg_9_2)

	if ChessBoardHexCfg[var_9_1.typeID].updatable == 1 then
		local var_9_2 = 0

		for iter_9_0, iter_9_1 in pairs(ChessBoardTools.dirToPos) do
			if iter_9_1[1] == arg_9_1 - self.pos_.x and iter_9_1[2] == arg_9_2 - self.pos_.z then
				var_9_2 = iter_9_0

				break
			end
		end

		self.pos_.x = arg_9_1
		self.pos_.z = arg_9_2
		self.direction_ = var_9_2

		ChessBoardData:FixNPCPosAndDir(self.id_, {
			x = arg_9_1,
			z = arg_9_2
		}, self.direction_)

		self.curMovePosIndex_ = self.curMovePosIndex_ + 1

		manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
	else
		if self.curMovePosIndex_ == 1 then
			if var_9_0.thingStartMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.thingStartMoveParam].npc_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_THING, {
					playerB = -1,
					gridData = var_9_0,
					playerA = self.id_
				})
			end

			if var_9_0.startMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.startMoveParam].npc_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_FLOOR, {
					playerB = -1,
					gridData = var_9_0,
					playerA = self.id_
				})
			end
		end

		if var_9_0.thingExitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.thingExitParam].npc_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_THING, {
				playerB = -1,
				gridData = var_9_0,
				playerA = self.id_
			})
		end

		if var_9_0.exitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.exitParam].npc_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_FLOOR, {
				playerB = -1,
				gridData = var_9_0,
				playerA = self.id_
			})
		end

		local var_9_3 = 0

		for iter_9_2, iter_9_3 in pairs(ChessBoardTools.dirToPos) do
			if iter_9_3[1] == arg_9_1 - self.pos_.x and iter_9_3[2] == arg_9_2 - self.pos_.z then
				var_9_3 = iter_9_2

				break
			end
		end

		self.pos_.x = arg_9_1
		self.pos_.z = arg_9_2
		self.direction_ = var_9_3

		ChessBoardLuaBridge.SetStepEffectActive(arg_9_1, arg_9_2, true)
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_duck_move", "")
		ChessBoardData:FixNPCPosAndDir(self.id_, {
			x = arg_9_1,
			z = arg_9_2
		}, self.direction_)

		self.curMovePosIndex_ = self.curMovePosIndex_ + 1

		self:SubAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", -1)

		local var_9_4, var_9_5, var_9_6 = self:CheckPosHero(var_9_1)

		if var_9_4 then
			manager.ChessBoardManager:StartExecuteEvent(function()
				if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
					if var_9_1.thingEnterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEnterParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_THING, {
							playerB = -1,
							gridData = var_9_1,
							playerA = self.id_
						})
						manager.ChessBoardManager:StartExecuteEvent(function()
							if var_9_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.enterParam].npc_params) then
								manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
									playerB = -1,
									gridData = var_9_1,
									playerA = self.id_
								})
							end

							if self:GetIsMoveEnd() then
								manager.ChessBoardManager:PlayEntityAction(self.id_, ChessBoardConst.ACTIONTYPE.STAND)

								if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
									manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
										playerB = -1,
										gridData = var_9_1,
										playerA = self.id_
									})
								elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
									manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
										playerB = -1,
										gridData = var_9_1,
										playerA = self.id_
									})
								end
							end

							self:UpdateBuffStep()

							if var_9_5 then
								manager.ChessBoardManager:AddDelayTimer(var_9_5, function()
									manager.ChessBoardManager:StartExecuteEvent(function()
										if var_9_6 then
											manager.ChessBoardManager:AddDelayTimer(var_9_6, function()
												manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
											end)
										else
											manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
										end
									end)
								end)
							else
								manager.ChessBoardManager:StartExecuteEvent(function()
									manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
								end)
							end
						end)

						return
					end

					if var_9_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.enterParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
							playerB = -1,
							gridData = var_9_1,
							playerA = self.id_
						})
					end

					if self:GetIsMoveEnd() then
						if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
								playerB = -1,
								gridData = var_9_1,
								playerA = self.id_
							})
						elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
								playerB = -1,
								gridData = var_9_1,
								playerA = self.id_
							})
						end
					end

					self:UpdateBuffStep()
				else
					manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
				end

				if var_9_5 then
					manager.ChessBoardManager:AddDelayTimer(var_9_5, function()
						manager.ChessBoardManager:StartExecuteEvent(function()
							if var_9_6 then
								manager.ChessBoardManager:AddDelayTimer(var_9_6, function()
									manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
								end)
							else
								manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
							end
						end)
					end)
				else
					manager.ChessBoardManager:StartExecuteEvent(function()
						manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
					end)
				end
			end)
		elseif manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
			if var_9_1.thingEnterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEnterParam].npc_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_THING, {
					playerB = -1,
					gridData = var_9_1,
					playerA = self.id_
				})
				manager.ChessBoardManager:StartExecuteEvent(function()
					if var_9_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.enterParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
							playerB = -1,
							gridData = var_9_1,
							playerA = self.id_
						})
					end

					if self:GetIsMoveEnd() then
						if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
								playerB = -1,
								gridData = var_9_1,
								playerA = self.id_
							})
						elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
								playerB = -1,
								gridData = var_9_1,
								playerA = self.id_
							})
						end
					end

					self:UpdateBuffStep()

					if var_9_5 then
						manager.ChessBoardManager:AddDelayTimer(var_9_5, function()
							manager.ChessBoardManager:StartExecuteEvent(function()
								if var_9_6 then
									manager.ChessBoardManager:AddDelayTimer(var_9_6, function()
										manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
									end)
								else
									manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
								end
							end)
						end)
					else
						manager.ChessBoardManager:StartExecuteEvent(function()
							manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
						end)
					end
				end)
			else
				if var_9_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.enterParam].npc_params) then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
						playerB = -1,
						gridData = var_9_1,
						playerA = self.id_
					})
				end

				if self:GetIsMoveEnd() then
					if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
							playerB = -1,
							gridData = var_9_1,
							playerA = self.id_
						})
					elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
							playerB = -1,
							gridData = var_9_1,
							playerA = self.id_
						})
					end
				end

				self:UpdateBuffStep()

				if var_9_5 then
					manager.ChessBoardManager:AddDelayTimer(var_9_5, function()
						manager.ChessBoardManager:StartExecuteEvent(function()
							if var_9_6 then
								manager.ChessBoardManager:AddDelayTimer(var_9_6, function()
									manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
								end)
							else
								manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
							end
						end)
					end)
				else
					manager.ChessBoardManager:StartExecuteEvent(function()
						manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
					end)
				end
			end
		else
			manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)

			if var_9_5 then
				manager.ChessBoardManager:AddDelayTimer(var_9_5, function()
					manager.ChessBoardManager:StartExecuteEvent(function()
						if var_9_6 then
							manager.ChessBoardManager:AddDelayTimer(var_9_6, function()
								manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
							end)
						else
							manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
						end
					end)
				end)
			else
				manager.ChessBoardManager:StartExecuteEvent(function()
					manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
				end)
			end
		end
	end
end

function ChessBoardNPCEntity:CheckPosHero(arg_33_1)
	local var_33_1, var_33_2 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()
	local var_33_3 = false
	local var_33_4
	local var_33_5

	if self:CheckIsSamePos(var_33_1) then
		if self:GetIsMoveEnd() then
			manager.ChessBoardManager.heroEntity_.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.NPC_STAY, self.id_)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
				if ChessBoardNPCPoolCfg[self.playerType_].npc_stay_player_event and not table.isEmpty(ChessBoardEventPoolCfg[ChessBoardNPCPoolCfg[self.playerType_].npc_stay_player_event].npc_params) then
					var_33_3 = true

					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_STAY_HERO, {
						playerB = 0,
						gridData = arg_33_1,
						playerA = self.id_
					})
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SAD_BIG)

					var_33_4 = 1
					var_33_5 = 3
				end
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
			end
		else
			manager.ChessBoardManager.heroEntity_.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.NPC_PASS, self.id_)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
				if ChessBoardNPCPoolCfg[self.playerType_].npc_cross_player_event and not table.isEmpty(ChessBoardEventPoolCfg[ChessBoardNPCPoolCfg[self.playerType_].npc_cross_player_event].npc_params) then
					var_33_3 = true

					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_CROSS_HERO, {
						playerB = 0,
						gridData = arg_33_1,
						playerA = self.id_
					})
				end
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
			end
		end
	else
		local var_33_6 = manager.ChessBoardManager.NPCManager_:FindTargetPosNPCEntity(self.pos_, self.id_)

		if var_33_6 and self:GetIsMoveEnd() then
			if ChessBoardNPCPoolCfg[self.playerType_].npc_stay_npc_event and not table.isEmpty(ChessBoardEventPoolCfg[ChessBoardNPCPoolCfg[self.playerType_].npc_stay_npc_event].npc_params) then
				var_33_3 = true

				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_STAY_NPC, {
					gridData = arg_33_1,
					playerA = self.id_,
					playerB = var_33_6:GetEntityId()
				})
			end

			var_33_4 = 0
			var_33_5 = 0.7 or var_33_5
		end
	end

	if self:GetIsMoveEnd() then
		if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
			manager.ChessBoardManager:PlayEntityAction(self.id_, ChessBoardConst.ACTIONTYPE.STAND)
		end

		if self:CheckIsNearbyHero() then
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.NERVOUS)

			var_33_4 = 1.5
		end
	end

	return var_33_3, var_33_4, var_33_5
end

function ChessBoardNPCEntity:CheckIsNearbyHero()
	local var_34_0, var_34_1 = self:GetPosAndDir()
	local var_34_2 = ChessBoardLuaBridge.FindNextMovePos(var_34_0.x, var_34_0.z, var_34_1)
	local var_34_3, var_34_4 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()

	for iter_34_0 = 0, var_34_2.Count - 1 do
		if var_34_2[iter_34_0].x == var_34_3.x and var_34_2[iter_34_0].z == var_34_3.z then
			return true
		end
	end

	return false
end

function ChessBoardNPCEntity:CheckPosIsNeedHeadAni(arg_35_1)
	local var_35_0 = self:GetNextPosNPCAcitonType(arg_35_1)

	if var_35_0 == ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO then
		ChessBoardLuaBridge.ChangeCameraToCloseCamera()
		manager.ChessBoardManager:PlayEntityAction(self.id_, ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO)
		manager.ChessBoardManager:AddDelayTimer(0.62, function()
			ChessBoardLuaBridge.LookAtPlayer()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO)
		end)
	elseif var_35_0 == ChessBoardConst.ACTIONTYPE.CROSS then
		manager.ChessBoardManager:PlayEntityAction(self.id_, ChessBoardConst.ACTIONTYPE.CROSS)
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.CROSS)
	end
end

function ChessBoardNPCEntity:GetNextPosNPCAcitonType(arg_37_1)
	return (manager.ChessBoardManager.heroEntity_:CheckIsSamePos(arg_37_1) or nil) and (self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") == 1 and ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO or ChessBoardConst.ACTIONTYPE.CROSS)
end

function ChessBoardNPCEntity:GetNPCIsReadyToMove()
	return self.readyToMove_
end

function ChessBoardNPCEntity:GetIsMoveEnd()
	return self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0
end

function ChessBoardNPCEntity:OnMoveEnd()
	local var_40_0 = 0.7

	self.movePos_ = {}
	self.readyToMove_ = false

	self:OnBuffUpdateTurn()

	self.curMovePosIndex_ = 1
	self.movePos_ = 0

	if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
		manager.ChessBoardManager:PlayEntityAction(self.id_, ChessBoardConst.ACTIONTYPE.STAND)

		if ChessBoardNPCPoolCfg[self.playerType_].npc_stop_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[ChessBoardNPCPoolCfg[self.playerType_].npc_stop_event].npc_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_TURN_END, {
				playerB = -1,
				playerA = self.id_
			})
		end
	end

	if ChessBoardLuaBridge.GetGridData(self.pos_.x, self.pos_.z).typeID == ChessBoardConst.DUCK_GRID_ID then
		var_40_0 = 2.2

		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.DUCK_CREATE_TIPS, {
			callback = function()
				return
			end
		})
	end

	return var_40_0
end

function ChessBoardNPCEntity:TelePortNPCToPosition(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	self.pos_.x = arg_42_1
	self.pos_.z = arg_42_2
	self.direction_ = arg_42_3

	ChessBoardData:FixNPCPosAndDir(self.id_, {
		x = arg_42_1,
		z = arg_42_2
	}, self.direction_)

	if arg_42_4 then
		arg_42_4()
	end
end

function ChessBoardNPCEntity:UpdateBuffStep()
	if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(self.id_) then
		self.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.STEP_UPDATE, -1)
	end
end

return ChessBoardNPCEntity
