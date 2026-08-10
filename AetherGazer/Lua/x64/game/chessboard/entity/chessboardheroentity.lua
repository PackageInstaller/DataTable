local var_0_0 = class("ChessBoardHeroEntity", ChessBoardPlayerEntity)

function var_0_0.Ctor(arg_1_0)
	arg_1_0.super.Ctor(arg_1_0)

	arg_1_0.propList_ = {}
	arg_1_0.curUsedProp_ = 0
	arg_1_0.curChanceInfo_ = {
		isUnLock = 0,
		chanceID = 0,
		chancePropList = {},
		chanceChooseList = {}
	}
end

function var_0_0.SetServerData(arg_2_0, arg_2_1)
	arg_2_0.super.SetServerData(arg_2_0, arg_2_1)

	arg_2_0.propList_ = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.itemList) do
		table.insert(arg_2_0.propList_, iter_2_1)
	end

	arg_2_0.curUsedProp_ = arg_2_1.curUsedItem

	if arg_2_1.chanceInfo.chanceID > 0 then
		arg_2_0.curChanceInfo_.chanceID = arg_2_1.chanceInfo.chanceID
		arg_2_0.curChanceInfo_.isUnLock = arg_2_1.chanceInfo.isUnLock
		arg_2_0.curChanceInfo_.chancePropList = {}

		for iter_2_2, iter_2_3 in pairs(arg_2_1.chanceInfo.chancePropList) do
			table.insert(arg_2_0.curChanceInfo_.chancePropList, iter_2_3)
		end

		arg_2_0.curChanceInfo_.chanceChooseList = {}

		for iter_2_4, iter_2_5 in pairs(arg_2_1.chanceInfo.chanceChooseList) do
			table.insert(arg_2_0.curChanceInfo_.chanceChooseList, iter_2_5)
		end
	end
end

function var_0_0.MoveToPos(arg_3_0, arg_3_1, arg_3_2)
	ChessBoardLuaBridge.SetStepEffectActive(0, 0, false)

	local var_3_0 = ChessBoardLuaBridge.GetGridData(arg_3_0.pos_.x, arg_3_0.pos_.z)
	local var_3_1 = ChessBoardLuaBridge.GetGridData(arg_3_1, arg_3_2)

	if ChessBoardHexCfg[var_3_1.typeID].updatable == 1 then
		local var_3_2 = 0
		local var_3_3 = arg_3_1 - arg_3_0.pos_.x
		local var_3_4 = arg_3_2 - arg_3_0.pos_.z

		for iter_3_0, iter_3_1 in pairs(ChessBoardTools.dirToPos) do
			if iter_3_1[1] == var_3_3 and iter_3_1[2] == var_3_4 then
				var_3_2 = iter_3_0

				break
			end
		end

		arg_3_0.pos_.x = arg_3_1
		arg_3_0.pos_.z = arg_3_2
		arg_3_0.direction_ = var_3_2

		ChessBoardData:FixHeroPosAndDir({
			x = arg_3_1,
			z = arg_3_2
		}, arg_3_0.direction_)
		arg_3_0:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.MOVING)
		manager.ChessBoardManager:HeroTryToMove()
	else
		if arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE then
			if var_3_0.thingStartMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.thingStartMoveParam].player_params) then
				local var_3_5 = ChessBoardEventPoolCfg[var_3_0.thingStartMoveParam]

				if var_3_5.type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_THING, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_0
					})
				elseif var_3_5.type == 2 then
					-- block empty
				end
			end

			if var_3_0.startMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.startMoveParam].player_params) then
				local var_3_6 = ChessBoardEventPoolCfg[var_3_0.startMoveParam]

				if var_3_6.type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_FLOOR, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_0
					})
				elseif var_3_6.type == 2 then
					-- block empty
				end
			end
		end

		if var_3_0.thingExitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.thingExitParam].player_params) then
			local var_3_7 = ChessBoardEventPoolCfg[var_3_0.thingExitParam]

			if var_3_7.type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_THING, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_0
				})
			elseif var_3_7.type == 2 then
				-- block empty
			end
		end

		if var_3_0.exitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.exitParam].player_params) then
			local var_3_8 = ChessBoardEventPoolCfg[var_3_0.exitParam]

			if var_3_8.type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_FLOOR, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_0
				})
			elseif var_3_8.type == 2 then
				-- block empty
			end
		end

		local var_3_9 = 0
		local var_3_10 = arg_3_1 - arg_3_0.pos_.x
		local var_3_11 = arg_3_2 - arg_3_0.pos_.z

		for iter_3_2, iter_3_3 in pairs(ChessBoardTools.dirToPos) do
			if iter_3_3[1] == var_3_10 and iter_3_3[2] == var_3_11 then
				var_3_9 = iter_3_2

				break
			end
		end

		arg_3_0.pos_.x = arg_3_1
		arg_3_0.pos_.z = arg_3_2
		arg_3_0.direction_ = var_3_9

		ChessBoardLuaBridge.SetStepEffectActive(arg_3_1, arg_3_2, true)
		ChessBoardData:FixHeroPosAndDir({
			x = arg_3_1,
			z = arg_3_2
		}, arg_3_0.direction_)
		arg_3_0:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.MOVING)
		arg_3_0:SubAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", -1)

		local var_3_12 = arg_3_0:CheckPosNPC(var_3_1)

		if var_3_1.thingEnterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.thingEnterParam].player_params) then
			local var_3_13 = ChessBoardEventPoolCfg[var_3_1.thingEnterParam]

			if var_3_13.type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_THING, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_1
				})
				manager.ChessBoardManager:StartExecuteEvent(function()
					if var_3_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.enterParam].player_params) then
						local var_4_0 = ChessBoardEventPoolCfg[var_3_1.enterParam]

						if var_4_0.type == 1 then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
								playerA = 0,
								playerB = -1,
								gridData = var_3_1
							})
						elseif var_4_0.type == 2 then
							-- block empty
						end
					end

					if arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
						arg_3_0:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.END_MOVE)

						if var_3_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].player_params) then
							local var_4_1 = ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam]

							if var_4_1.type == 1 then
								manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
									playerA = 0,
									playerB = -1,
									gridData = var_3_1
								})
							elseif var_4_1.type == 2 then
								-- block empty
							end
						end

						if var_3_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.endMoveParam].player_params) then
							local var_4_2 = ChessBoardEventPoolCfg[var_3_1.endMoveParam]

							if var_4_2.type == 1 then
								manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
									playerA = 0,
									playerB = -1,
									gridData = var_3_1
								})
							elseif var_4_2.type == 2 then
								-- block empty
							end
						end
					end

					arg_3_0:UpdateBuffStep()

					local function var_4_3()
						manager.ChessBoardManager:StartExecuteEvent(function()
							if arg_3_0.curChanceInfo_.chanceID > 0 then
								manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)

								if arg_3_0.curChanceInfo_.isUnLock == 1 then
									ChessBoardTools.OpenChanceView(arg_3_0.curChanceInfo_.chanceID)
								else
									JumpTools.OpenPageByJump("/chessBoardChanceView", {
										viewType = ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE
									})
								end
							elseif arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
								ChessBoardAction.HeroMoveEnd(function()
									manager.ChessBoardManager:OnHeroTurnEnd()
								end)
							else
								manager.ChessBoardManager:HeroTryToMove()
							end
						end)
					end

					if var_3_12 then
						manager.ChessBoardManager:AddDelayTimer(var_3_12, var_4_3)
					else
						var_4_3()
					end
				end)

				if arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
				end

				return
			elseif var_3_13.type == 2 then
				-- block empty
			end
		end

		if var_3_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.enterParam].player_params) then
			local var_3_14 = ChessBoardEventPoolCfg[var_3_1.enterParam]

			if var_3_14.type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_1
				})
			elseif var_3_14.type == 2 then
				-- block empty
			end
		end

		if arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
			arg_3_0:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.END_MOVE)

			if var_3_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].player_params) then
				local var_3_15 = ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam]

				if var_3_15.type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_1
					})
				elseif var_3_15.type == 2 then
					-- block empty
				end
			end

			if var_3_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.endMoveParam].player_params) then
				local var_3_16 = ChessBoardEventPoolCfg[var_3_1.endMoveParam]

				if var_3_16.type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_1
					})
				elseif var_3_16.type == 2 then
					-- block empty
				end
			end
		end

		arg_3_0:UpdateBuffStep()

		local function var_3_17()
			manager.ChessBoardManager:StartExecuteEvent(function()
				if arg_3_0.curChanceInfo_.chanceID > 0 then
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)

					if arg_3_0.curChanceInfo_.isUnLock == 1 then
						ChessBoardTools.OpenChanceView(arg_3_0.curChanceInfo_.chanceID)
					else
						JumpTools.OpenPageByJump("/chessBoardChanceView", {
							viewType = ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE
						})
					end
				elseif arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					ChessBoardAction.HeroMoveEnd(function()
						manager.ChessBoardManager:OnHeroTurnEnd()
					end)
				else
					manager.ChessBoardManager:HeroTryToMove()
				end
			end)
		end

		if var_3_12 then
			manager.ChessBoardManager:AddDelayTimer(var_3_12, var_3_17)
		else
			var_3_17()
		end
	end

	if arg_3_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
	end
end

function var_0_0.CheckPosNPC(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")
	local var_11_1, var_11_2 = arg_11_0:GetPosAndDir()
	local var_11_3 = manager.ChessBoardManager.NPCManager_:FindTargetPosNPCEntity(var_11_1, arg_11_0:GetEntityId())

	if var_11_3 then
		local var_11_4 = var_11_3:GetEntityId()
		local var_11_5 = {
			gridData = arg_11_1,
			playerA = arg_11_0:GetEntityId(),
			playerB = var_11_4
		}
		local var_11_6 = ChessBoardNPCPoolCfg[var_11_3:GetNPCType()]

		if var_11_0 <= 0 then
			arg_11_0.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.PLAYER_STAY, var_11_4)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(var_11_4) then
				if var_11_6.player_stay_npc_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_11_6.player_stay_npc_event].player_params) then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.HERO_STAY_NPC, var_11_5)
				end

				return 1.5
			end
		else
			arg_11_0.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.PLAYER_PASS, var_11_4)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(var_11_4) and var_11_6.player_cross_npc_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_11_6.player_cross_npc_event].player_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.HERO_CROSS_NPC, var_11_5)
			end
		end
	end
end

function var_0_0.CheckMoveBegin(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = arg_12_0:GetNextPosPlayerAcitonType(arg_12_1)

	if var_12_0 == ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC then
		ChessBoardLuaBridge.ChangeCameraToCloseCamera()
		manager.ChessBoardManager:AddDelayTimer(0.1, function()
			manager.ChessBoardManager:PlayEntityAction(var_12_1:GetEntityId(), ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC)
		end)
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC)
	elseif var_12_0 == ChessBoardConst.ACTIONTYPE.CROSS then
		ChessBoardLuaBridge.PlayEntityOverlap(arg_12_0:GetEntityId(), true)
	end
end

function var_0_0.GetNextPosPlayerAcitonType(arg_14_0, arg_14_1)
	local var_14_0 = manager.ChessBoardManager.NPCManager_:FindTargetPosNPCEntity(arg_14_1, arg_14_0:GetEntityId())
	local var_14_1 = arg_14_0:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")
	local var_14_2 = ChessBoardConst.ACTIONTYPE.ALL

	if var_14_0 then
		if var_14_1 == 1 then
			var_14_2 = ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC
		elseif var_14_1 > 1 then
			var_14_2 = ChessBoardConst.ACTIONTYPE.CROSS
		end
	end

	return var_14_2, var_14_0
end

function var_0_0.TelePortHeroToPosition(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0.pos_.x = arg_15_1
	arg_15_0.pos_.z = arg_15_2
	arg_15_0.direction_ = arg_15_3

	ChessBoardData:FixHeroPosAndDir({
		x = arg_15_1,
		z = arg_15_2
	}, arg_15_0.direction_)

	if arg_15_4 then
		arg_15_4()
	end
end

function var_0_0.GetCurChanceInfo(arg_16_0)
	return arg_16_0.curChanceInfo_
end

function var_0_0.AddHeroProp(arg_17_0, arg_17_1)
	table.insert(arg_17_0.propList_, arg_17_1)
end

function var_0_0.DelHeroProp(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.propList_) do
		if iter_18_1 == arg_18_1 then
			table.remove(arg_18_0.propList_, iter_18_0)

			break
		end
	end
end

function var_0_0.GetHeroProp(arg_19_0)
	return arg_19_0.propList_
end

function var_0_0.SetChanceServerData(arg_20_0, arg_20_1)
	arg_20_0.curChanceInfo_ = {
		chanceID = arg_20_1.chanceID,
		isUnLock = arg_20_1.isUnLock,
		chancePropList = deepClone(arg_20_1.chancePropList),
		chanceChooseList = deepClone(arg_20_1.chanceChooseList)
	}
end

function var_0_0.SetCurUsedPropID(arg_21_0, arg_21_1)
	arg_21_0.curUsedProp_ = arg_21_1
end

function var_0_0.GetCurUsedPropID(arg_22_0)
	return arg_22_0.curUsedProp_
end

function var_0_0.ClearCurUsedPropID(arg_23_0)
	arg_23_0.curUsedProp_ = 0
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.super.Dispose(arg_24_0)

	arg_24_0.propList_ = {}
	arg_24_0.curUsedProp_ = 0
	arg_24_0.curChanceInfo_ = {
		isUnLock = 0,
		chanceID = 0,
		chancePropList = {},
		chanceChooseList = {}
	}
end

return var_0_0
