local var_0_0 = class("ChessBoardNPCEntity", ChessBoardPlayerEntity)

function var_0_0.Ctor(arg_1_0)
	arg_1_0.super.Ctor(arg_1_0)

	arg_1_0.movePos_ = {}
	arg_1_0.readyToMove_ = false
	arg_1_0.curMovePosIndex_ = 1
end

function var_0_0.GetNPCType(arg_2_0)
	return arg_2_0.playerType_
end

function var_0_0.SetMovePosList(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.movePos_ = arg_3_1
	arg_3_0.readyToMove_ = true
	arg_3_0.curMovePosIndex_ = 1

	arg_3_0:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", arg_3_2)
end

function var_0_0.GetMoveStep(arg_4_0)
	return arg_4_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")
end

function var_0_0.OnMoveStart(arg_5_0)
	ChessBoardLuaBridge.SetNPCToCameraTarget(arg_5_0.id_)
	manager.ChessBoardManager:PlayEntityAction(arg_5_0.id_, ChessBoardConst.ACTIONTYPE.DICE)

	local var_5_0 = ChessBoardNPCPoolCfg[arg_5_0.playerType_]

	if var_5_0.npc_start_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_5_0.npc_start_event].npc_params) then
		manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_TURN_START, {
			playerB = -1,
			playerA = arg_5_0.id_
		})
	end
end

function var_0_0.MoveToNextPos(arg_6_0)
	local var_6_0 = arg_6_0.movePos_[arg_6_0.curMovePosIndex_]

	if var_6_0 == nil then
		error("当前NPC没有移动步数了仍要去移动！NPCID：" .. arg_6_0.id_)

		return
	end

	local function var_6_1()
		ChessBoardLuaBridge.SetNPCToCameraTarget(arg_6_0.id_)
		arg_6_0:CheckPosIsNeedHeadAni(var_6_0)
		ChessBoardLuaBridge.NPCMoveTo(arg_6_0.id_, var_6_0.x, var_6_0.z, function()
			arg_6_0:MoveToPos(var_6_0.x, var_6_0.z)
		end)
	end

	if arg_6_0:GetNextPosNPCAcitonType(var_6_0) == ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO then
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.NPC_BANNER, {
			callback = var_6_1
		})
	else
		var_6_1()
	end
end

function var_0_0.MoveToPos(arg_9_0, arg_9_1, arg_9_2)
	ChessBoardLuaBridge.SetStepEffectActive(0, 0, false)

	local var_9_0 = ChessBoardLuaBridge.GetGridData(arg_9_0.pos_.x, arg_9_0.pos_.z)
	local var_9_1 = ChessBoardLuaBridge.GetGridData(arg_9_1, arg_9_2)

	if ChessBoardHexCfg[var_9_1.typeID].updatable == 1 then
		local var_9_2 = 0
		local var_9_3 = arg_9_1 - arg_9_0.pos_.x
		local var_9_4 = arg_9_2 - arg_9_0.pos_.z

		for iter_9_0, iter_9_1 in pairs(ChessBoardTools.dirToPos) do
			if iter_9_1[1] == var_9_3 and iter_9_1[2] == var_9_4 then
				var_9_2 = iter_9_0

				break
			end
		end

		arg_9_0.pos_.x = arg_9_1
		arg_9_0.pos_.z = arg_9_2
		arg_9_0.direction_ = var_9_2

		ChessBoardData:FixNPCPosAndDir(arg_9_0.id_, {
			x = arg_9_1,
			z = arg_9_2
		}, arg_9_0.direction_)

		arg_9_0.curMovePosIndex_ = arg_9_0.curMovePosIndex_ + 1

		manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
	else
		if arg_9_0.curMovePosIndex_ == 1 then
			if var_9_0.thingStartMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.thingStartMoveParam].npc_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_THING, {
					playerB = -1,
					gridData = var_9_0,
					playerA = arg_9_0.id_
				})
			end

			if var_9_0.startMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.startMoveParam].npc_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_FLOOR, {
					playerB = -1,
					gridData = var_9_0,
					playerA = arg_9_0.id_
				})
			end
		end

		if var_9_0.thingExitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.thingExitParam].npc_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_THING, {
				playerB = -1,
				gridData = var_9_0,
				playerA = arg_9_0.id_
			})
		end

		if var_9_0.exitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_0.exitParam].npc_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_FLOOR, {
				playerB = -1,
				gridData = var_9_0,
				playerA = arg_9_0.id_
			})
		end

		local var_9_5 = 0
		local var_9_6 = arg_9_1 - arg_9_0.pos_.x
		local var_9_7 = arg_9_2 - arg_9_0.pos_.z

		for iter_9_2, iter_9_3 in pairs(ChessBoardTools.dirToPos) do
			if iter_9_3[1] == var_9_6 and iter_9_3[2] == var_9_7 then
				var_9_5 = iter_9_2

				break
			end
		end

		arg_9_0.pos_.x = arg_9_1
		arg_9_0.pos_.z = arg_9_2
		arg_9_0.direction_ = var_9_5

		ChessBoardLuaBridge.SetStepEffectActive(arg_9_1, arg_9_2, true)
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_duck_move", "")
		ChessBoardData:FixNPCPosAndDir(arg_9_0.id_, {
			x = arg_9_1,
			z = arg_9_2
		}, arg_9_0.direction_)

		arg_9_0.curMovePosIndex_ = arg_9_0.curMovePosIndex_ + 1

		arg_9_0:SubAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", -1)

		local var_9_8, var_9_9, var_9_10 = arg_9_0:CheckPosHero(var_9_1)

		if var_9_8 then
			manager.ChessBoardManager:StartExecuteEvent(function()
				if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_9_0.id_) then
					if var_9_1.thingEnterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEnterParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_THING, {
							playerB = -1,
							gridData = var_9_1,
							playerA = arg_9_0.id_
						})
						manager.ChessBoardManager:StartExecuteEvent(function()
							if var_9_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.enterParam].npc_params) then
								manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
									playerB = -1,
									gridData = var_9_1,
									playerA = arg_9_0.id_
								})
							end

							if arg_9_0:GetIsMoveEnd() then
								manager.ChessBoardManager:PlayEntityAction(arg_9_0.id_, ChessBoardConst.ACTIONTYPE.STAND)

								if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
									manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
										playerB = -1,
										gridData = var_9_1,
										playerA = arg_9_0.id_
									})
								elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
									manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
										playerB = -1,
										gridData = var_9_1,
										playerA = arg_9_0.id_
									})
								end
							end

							arg_9_0:UpdateBuffStep()

							if var_9_9 then
								manager.ChessBoardManager:AddDelayTimer(var_9_9, function()
									manager.ChessBoardManager:StartExecuteEvent(function()
										if var_9_10 then
											manager.ChessBoardManager:AddDelayTimer(var_9_10, function()
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
							playerA = arg_9_0.id_
						})
					end

					if arg_9_0:GetIsMoveEnd() then
						if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
								playerB = -1,
								gridData = var_9_1,
								playerA = arg_9_0.id_
							})
						elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
								playerB = -1,
								gridData = var_9_1,
								playerA = arg_9_0.id_
							})
						end
					end

					arg_9_0:UpdateBuffStep()
				else
					manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
				end

				if var_9_9 then
					manager.ChessBoardManager:AddDelayTimer(var_9_9, function()
						manager.ChessBoardManager:StartExecuteEvent(function()
							if var_9_10 then
								manager.ChessBoardManager:AddDelayTimer(var_9_10, function()
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
		elseif manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_9_0.id_) then
			if var_9_1.thingEnterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEnterParam].npc_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_THING, {
					playerB = -1,
					gridData = var_9_1,
					playerA = arg_9_0.id_
				})
				manager.ChessBoardManager:StartExecuteEvent(function()
					if var_9_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.enterParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
							playerB = -1,
							gridData = var_9_1,
							playerA = arg_9_0.id_
						})
					end

					if arg_9_0:GetIsMoveEnd() then
						if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
								playerB = -1,
								gridData = var_9_1,
								playerA = arg_9_0.id_
							})
						elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
								playerB = -1,
								gridData = var_9_1,
								playerA = arg_9_0.id_
							})
						end
					end

					arg_9_0:UpdateBuffStep()

					if var_9_9 then
						manager.ChessBoardManager:AddDelayTimer(var_9_9, function()
							manager.ChessBoardManager:StartExecuteEvent(function()
								if var_9_10 then
									manager.ChessBoardManager:AddDelayTimer(var_9_10, function()
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
						playerA = arg_9_0.id_
					})
				end

				if arg_9_0:GetIsMoveEnd() then
					if var_9_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.thingEndMoveParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
							playerB = -1,
							gridData = var_9_1,
							playerA = arg_9_0.id_
						})
					elseif var_9_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_9_1.endMoveParam].npc_params) then
						manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
							playerB = -1,
							gridData = var_9_1,
							playerA = arg_9_0.id_
						})
					end
				end

				arg_9_0:UpdateBuffStep()

				if var_9_9 then
					manager.ChessBoardManager:AddDelayTimer(var_9_9, function()
						manager.ChessBoardManager:StartExecuteEvent(function()
							if var_9_10 then
								manager.ChessBoardManager:AddDelayTimer(var_9_10, function()
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

			if var_9_9 then
				manager.ChessBoardManager:AddDelayTimer(var_9_9, function()
					manager.ChessBoardManager:StartExecuteEvent(function()
						if var_9_10 then
							manager.ChessBoardManager:AddDelayTimer(var_9_10, function()
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

function var_0_0.CheckPosHero(arg_33_0, arg_33_1)
	local var_33_0 = false
	local var_33_1, var_33_2 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()
	local var_33_3 = ChessBoardNPCPoolCfg[arg_33_0.playerType_]
	local var_33_4 = false
	local var_33_5
	local var_33_6

	if arg_33_0:CheckIsSamePos(var_33_1) then
		if arg_33_0:GetIsMoveEnd() then
			manager.ChessBoardManager.heroEntity_.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.NPC_STAY, arg_33_0.id_)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_33_0.id_) then
				if var_33_3.npc_stay_player_event and not table.isEmpty(ChessBoardEventPoolCfg[var_33_3.npc_stay_player_event].npc_params) then
					var_33_4 = true

					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_STAY_HERO, {
						playerB = 0,
						gridData = arg_33_1,
						playerA = arg_33_0.id_
					})
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.SAD_BIG)

					var_33_5 = 1
					var_33_6 = 3
				end
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
			end
		else
			manager.ChessBoardManager.heroEntity_.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.NPC_PASS, arg_33_0.id_)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_33_0.id_) then
				if var_33_3.npc_cross_player_event and not table.isEmpty(ChessBoardEventPoolCfg[var_33_3.npc_cross_player_event].npc_params) then
					var_33_4 = true

					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_CROSS_HERO, {
						playerB = 0,
						gridData = arg_33_1,
						playerA = arg_33_0.id_
					})
				end
			else
				manager.notify:CallUpdateFunc(CHESSBOARD_NPC_STEP_UPDATE, 0)
			end
		end
	else
		local var_33_7 = manager.ChessBoardManager.NPCManager_:FindTargetPosNPCEntity(arg_33_0.pos_, arg_33_0.id_)

		if var_33_7 and arg_33_0:GetIsMoveEnd() then
			if var_33_3.npc_stay_npc_event and not table.isEmpty(ChessBoardEventPoolCfg[var_33_3.npc_stay_npc_event].npc_params) then
				var_33_4 = true

				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_STAY_NPC, {
					gridData = arg_33_1,
					playerA = arg_33_0.id_,
					playerB = var_33_7:GetEntityId()
				})
			end

			var_33_5 = 0
			var_33_6 = 0.7 or var_33_6
		end
	end

	if arg_33_0:GetIsMoveEnd() then
		if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_33_0.id_) then
			manager.ChessBoardManager:PlayEntityAction(arg_33_0.id_, ChessBoardConst.ACTIONTYPE.STAND)
		end

		if arg_33_0:CheckIsNearbyHero() then
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.NERVOUS)

			var_33_5 = 1.5
		end
	end

	return var_33_4, var_33_5, var_33_6
end

function var_0_0.CheckIsNearbyHero(arg_34_0)
	local var_34_0, var_34_1 = arg_34_0:GetPosAndDir()
	local var_34_2 = ChessBoardLuaBridge.FindNextMovePos(var_34_0.x, var_34_0.z, var_34_1)
	local var_34_3, var_34_4 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()

	for iter_34_0 = 0, var_34_2.Count - 1 do
		if var_34_2[iter_34_0].x == var_34_3.x and var_34_2[iter_34_0].z == var_34_3.z then
			return true
		end
	end

	return false
end

function var_0_0.CheckPosIsNeedHeadAni(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:GetNextPosNPCAcitonType(arg_35_1)

	if var_35_0 == ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO then
		ChessBoardLuaBridge.ChangeCameraToCloseCamera()
		manager.ChessBoardManager:PlayEntityAction(arg_35_0.id_, ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO)
		manager.ChessBoardManager:AddDelayTimer(0.62, function()
			ChessBoardLuaBridge.LookAtPlayer()
			manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO)
		end)
	elseif var_35_0 == ChessBoardConst.ACTIONTYPE.CROSS then
		manager.ChessBoardManager:PlayEntityAction(arg_35_0.id_, ChessBoardConst.ACTIONTYPE.CROSS)
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.CROSS)
	end
end

function var_0_0.GetNextPosNPCAcitonType(arg_37_0, arg_37_1)
	local var_37_0 = manager.ChessBoardManager.heroEntity_:CheckIsSamePos(arg_37_1)
	local var_37_1 = ChessBoardConst.ACTIONTYPE.ALL

	if var_37_0 then
		if arg_37_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") == 1 then
			var_37_1 = ChessBoardConst.ACTIONTYPE.NPC_STAY_HERO
		else
			var_37_1 = ChessBoardConst.ACTIONTYPE.CROSS
		end
	end

	return var_37_1
end

function var_0_0.GetNPCIsReadyToMove(arg_38_0)
	return arg_38_0.readyToMove_
end

function var_0_0.GetIsMoveEnd(arg_39_0)
	return arg_39_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0
end

function var_0_0.OnMoveEnd(arg_40_0)
	local var_40_0 = 0.7

	arg_40_0.movePos_ = {}
	arg_40_0.readyToMove_ = false

	arg_40_0:OnBuffUpdateTurn()

	arg_40_0.curMovePosIndex_ = 1
	arg_40_0.movePos_ = 0

	if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_40_0.id_) then
		manager.ChessBoardManager:PlayEntityAction(arg_40_0.id_, ChessBoardConst.ACTIONTYPE.STAND)

		local var_40_1 = ChessBoardNPCPoolCfg[arg_40_0.playerType_]

		if var_40_1.npc_stop_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_40_1.npc_stop_event].npc_params) then
			manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.NPC_TURN_END, {
				playerB = -1,
				playerA = arg_40_0.id_
			})
		end
	end

	if ChessBoardLuaBridge.GetGridData(arg_40_0.pos_.x, arg_40_0.pos_.z).typeID == ChessBoardConst.DUCK_GRID_ID then
		var_40_0 = 2.2

		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.DUCK_CREATE_TIPS, {
			callback = function()
				return
			end
		})
	end

	return var_40_0
end

function var_0_0.TelePortNPCToPosition(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	arg_42_0.pos_.x = arg_42_1
	arg_42_0.pos_.z = arg_42_2
	arg_42_0.direction_ = arg_42_3

	ChessBoardData:FixNPCPosAndDir(arg_42_0.id_, {
		x = arg_42_1,
		z = arg_42_2
	}, arg_42_0.direction_)

	if arg_42_4 then
		arg_42_4()
	end
end

function var_0_0.UpdateBuffStep(arg_43_0)
	if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(arg_43_0.id_) then
		arg_43_0.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.STEP_UPDATE, -1)
	end
end

return var_0_0
