local ChessBoardHeroEntity = class("ChessBoardHeroEntity", ChessBoardPlayerEntity)

function ChessBoardHeroEntity:Ctor()
	self.super.Ctor(self)

	self.propList_ = {}
	self.curUsedProp_ = 0
	self.curChanceInfo_ = {
		isUnLock = 0,
		chanceID = 0,
		chancePropList = {},
		chanceChooseList = {}
	}
end

function ChessBoardHeroEntity:SetServerData(arg_2_1)
	self.super.SetServerData(self, arg_2_1)

	self.propList_ = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.itemList) do
		table.insert(self.propList_, iter_2_1)
	end

	self.curUsedProp_ = arg_2_1.curUsedItem

	if arg_2_1.chanceInfo.chanceID > 0 then
		self.curChanceInfo_.chanceID = arg_2_1.chanceInfo.chanceID
		self.curChanceInfo_.isUnLock = arg_2_1.chanceInfo.isUnLock
		self.curChanceInfo_.chancePropList = {}

		for iter_2_2, iter_2_3 in pairs(arg_2_1.chanceInfo.chancePropList) do
			table.insert(self.curChanceInfo_.chancePropList, iter_2_3)
		end

		self.curChanceInfo_.chanceChooseList = {}

		for iter_2_4, iter_2_5 in pairs(arg_2_1.chanceInfo.chanceChooseList) do
			table.insert(self.curChanceInfo_.chanceChooseList, iter_2_5)
		end
	end
end

function ChessBoardHeroEntity:MoveToPos(arg_3_1, arg_3_2)
	ChessBoardLuaBridge.SetStepEffectActive(0, 0, false)

	local var_3_0 = ChessBoardLuaBridge.GetGridData(self.pos_.x, self.pos_.z)
	local var_3_1 = ChessBoardLuaBridge.GetGridData(arg_3_1, arg_3_2)

	if ChessBoardHexCfg[var_3_1.typeID].updatable == 1 then
		local var_3_2 = 0

		for iter_3_0, iter_3_1 in pairs(ChessBoardTools.dirToPos) do
			if iter_3_1[1] == arg_3_1 - self.pos_.x and iter_3_1[2] == arg_3_2 - self.pos_.z then
				var_3_2 = iter_3_0

				break
			end
		end

		self.pos_.x = arg_3_1
		self.pos_.z = arg_3_2
		self.direction_ = var_3_2

		ChessBoardData:FixHeroPosAndDir({
			x = arg_3_1,
			z = arg_3_2
		}, self.direction_)
		self:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.MOVING)
		manager.ChessBoardManager:HeroTryToMove()
	else
		if self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE then
			if var_3_0.thingStartMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.thingStartMoveParam].player_params) then
				if ChessBoardEventPoolCfg[var_3_0.thingStartMoveParam].type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_THING, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_0
					})
				elseif ChessBoardEventPoolCfg[var_3_0.thingStartMoveParam].type == 2 then
					-- block empty
				end
			end

			if var_3_0.startMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.startMoveParam].player_params) then
				if ChessBoardEventPoolCfg[var_3_0.startMoveParam].type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.START_MOVE_FLOOR, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_0
					})
				elseif ChessBoardEventPoolCfg[var_3_0.startMoveParam].type == 2 then
					-- block empty
				end
			end
		end

		if var_3_0.thingExitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.thingExitParam].player_params) then
			if ChessBoardEventPoolCfg[var_3_0.thingExitParam].type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_THING, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_0
				})
			elseif ChessBoardEventPoolCfg[var_3_0.thingExitParam].type == 2 then
				-- block empty
			end
		end

		if var_3_0.exitParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_0.exitParam].player_params) then
			if ChessBoardEventPoolCfg[var_3_0.exitParam].type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.EXIT_FLOOR, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_0
				})
			elseif ChessBoardEventPoolCfg[var_3_0.exitParam].type == 2 then
				-- block empty
			end
		end

		local var_3_3 = 0

		for iter_3_2, iter_3_3 in pairs(ChessBoardTools.dirToPos) do
			if iter_3_3[1] == arg_3_1 - self.pos_.x and iter_3_3[2] == arg_3_2 - self.pos_.z then
				var_3_3 = iter_3_2

				break
			end
		end

		self.pos_.x = arg_3_1
		self.pos_.z = arg_3_2
		self.direction_ = var_3_3

		ChessBoardLuaBridge.SetStepEffectActive(arg_3_1, arg_3_2, true)
		ChessBoardData:FixHeroPosAndDir({
			x = arg_3_1,
			z = arg_3_2
		}, self.direction_)
		self:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.MOVING)
		self:SubAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", -1)

		local var_3_4 = self:CheckPosNPC(var_3_1)

		if var_3_1.thingEnterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.thingEnterParam].player_params) then
			if ChessBoardEventPoolCfg[var_3_1.thingEnterParam].type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_THING, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_1
				})
				manager.ChessBoardManager:StartExecuteEvent(function()
					if var_3_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.enterParam].player_params) then
						if ChessBoardEventPoolCfg[var_3_1.enterParam].type == 1 then
							manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
								playerA = 0,
								playerB = -1,
								gridData = var_3_1
							})
						elseif ChessBoardEventPoolCfg[var_3_1.enterParam].type == 2 then
							-- block empty
						end
					end

					if self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
						self:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.END_MOVE)

						if var_3_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].player_params) then
							if ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].type == 1 then
								manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
									playerA = 0,
									playerB = -1,
									gridData = var_3_1
								})
							elseif ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].type == 2 then
								-- block empty
							end
						end

						if var_3_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.endMoveParam].player_params) then
							if ChessBoardEventPoolCfg[var_3_1.endMoveParam].type == 1 then
								manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
									playerA = 0,
									playerB = -1,
									gridData = var_3_1
								})
							elseif ChessBoardEventPoolCfg[var_3_1.endMoveParam].type == 2 then
								-- block empty
							end
						end
					end

					self:UpdateBuffStep()

					local function var_4_0()
						manager.ChessBoardManager:StartExecuteEvent(function()
							if self.curChanceInfo_.chanceID > 0 then
								manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)

								if self.curChanceInfo_.isUnLock == 1 then
									ChessBoardTools.OpenChanceView(self.curChanceInfo_.chanceID)
								else
									JumpTools.OpenPageByJump("/chessBoardChanceView", {
										viewType = ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE
									})
								end
							elseif self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
								ChessBoardAction.HeroMoveEnd(function()
									manager.ChessBoardManager:OnHeroTurnEnd()
								end)
							else
								manager.ChessBoardManager:HeroTryToMove()
							end
						end)
					end

					if var_3_4 then
						manager.ChessBoardManager:AddDelayTimer(var_3_4, var_4_0)
					else
						var_4_0()
					end
				end)

				if self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
				end

				return
			elseif ChessBoardEventPoolCfg[var_3_1.thingEnterParam].type == 2 then
				-- block empty
			end
		end

		if var_3_1.enterParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.enterParam].player_params) then
			if ChessBoardEventPoolCfg[var_3_1.enterParam].type == 1 then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.ENTER_FLOOR, {
					playerA = 0,
					playerB = -1,
					gridData = var_3_1
				})
			elseif ChessBoardEventPoolCfg[var_3_1.enterParam].type == 2 then
				-- block empty
			end
		end

		if self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
			self:SetAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.END_MOVE)

			if var_3_1.thingEndMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].player_params) then
				if ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_THING, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_1
					})
				elseif ChessBoardEventPoolCfg[var_3_1.thingEndMoveParam].type == 2 then
					-- block empty
				end
			end

			if var_3_1.endMoveParam > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_3_1.endMoveParam].player_params) then
				if ChessBoardEventPoolCfg[var_3_1.endMoveParam].type == 1 then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.END_MOVE_FLOOR, {
						playerA = 0,
						playerB = -1,
						gridData = var_3_1
					})
				elseif ChessBoardEventPoolCfg[var_3_1.endMoveParam].type == 2 then
					-- block empty
				end
			end
		end

		self:UpdateBuffStep()

		local function var_3_5()
			manager.ChessBoardManager:StartExecuteEvent(function()
				if self.curChanceInfo_.chanceID > 0 then
					manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)

					if self.curChanceInfo_.isUnLock == 1 then
						ChessBoardTools.OpenChanceView(self.curChanceInfo_.chanceID)
					else
						JumpTools.OpenPageByJump("/chessBoardChanceView", {
							viewType = ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE
						})
					end
				elseif self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
					ChessBoardAction.HeroMoveEnd(function()
						manager.ChessBoardManager:OnHeroTurnEnd()
					end)
				else
					manager.ChessBoardManager:HeroTryToMove()
				end
			end)
		end

		if var_3_4 then
			manager.ChessBoardManager:AddDelayTimer(var_3_4, var_3_5)
		else
			var_3_5()
		end
	end

	if self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.STAND)
	end
end

function ChessBoardHeroEntity:CheckPosNPC(arg_11_1)
	local var_11_0, var_11_1 = self:GetPosAndDir()
	local var_11_2 = manager.ChessBoardManager.NPCManager_:FindTargetPosNPCEntity(var_11_0, self:GetEntityId())

	if var_11_2 then
		local var_11_3 = var_11_2:GetEntityId()
		local var_11_4 = {
			gridData = arg_11_1,
			playerA = self:GetEntityId(),
			playerB = var_11_3
		}
		local var_11_5 = ChessBoardNPCPoolCfg[var_11_2:GetNPCType()]

		if self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM") <= 0 then
			self.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.PLAYER_STAY, var_11_3)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(var_11_3) then
				if var_11_5.player_stay_npc_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_11_5.player_stay_npc_event].player_params) then
					manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.HERO_STAY_NPC, var_11_4)
				end

				return 1.5
			end
		else
			self.buffManager_:OnBuffEffectTrigger(ChessBoardConst.BUFF_EFFECT_TIMING.PLAYER_PASS, var_11_3)

			if manager.ChessBoardManager.NPCManager_:CheckNPCIsActive(var_11_3) and var_11_5.player_cross_npc_event > 0 and not table.isEmpty(ChessBoardEventPoolCfg[var_11_5.player_cross_npc_event].player_params) then
				manager.ChessBoardManager:ExecuteTiming(ChessBoardConst.TIMING.HERO_CROSS_NPC, var_11_4)
			end
		end
	end
end

function ChessBoardHeroEntity:CheckMoveBegin(arg_12_1)
	local var_12_0, var_12_1 = self:GetNextPosPlayerAcitonType(arg_12_1)

	if var_12_0 == ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC then
		ChessBoardLuaBridge.ChangeCameraToCloseCamera()
		manager.ChessBoardManager:AddDelayTimer(0.1, function()
			manager.ChessBoardManager:PlayEntityAction(var_12_1:GetEntityId(), ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC)
		end)
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.HERO_STAY_NPC)
	elseif var_12_0 == ChessBoardConst.ACTIONTYPE.CROSS then
		ChessBoardLuaBridge.PlayEntityOverlap(self:GetEntityId(), true)
	end
end

function ChessBoardHeroEntity:GetNextPosPlayerAcitonType(arg_14_1)
	local var_14_0 = manager.ChessBoardManager.NPCManager_:FindTargetPosNPCEntity(arg_14_1, self:GetEntityId())
	local var_14_1 = self:GetAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")
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

function ChessBoardHeroEntity:TelePortHeroToPosition(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self.pos_.x = arg_15_1
	self.pos_.z = arg_15_2
	self.direction_ = arg_15_3

	ChessBoardData:FixHeroPosAndDir({
		x = arg_15_1,
		z = arg_15_2
	}, self.direction_)

	if arg_15_4 then
		arg_15_4()
	end
end

function ChessBoardHeroEntity:GetCurChanceInfo()
	return self.curChanceInfo_
end

function ChessBoardHeroEntity:AddHeroProp(arg_17_1)
	table.insert(self.propList_, arg_17_1)
end

function ChessBoardHeroEntity:DelHeroProp(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self.propList_) do
		if iter_18_1 == arg_18_1 then
			table.remove(self.propList_, iter_18_0)

			break
		end
	end
end

function ChessBoardHeroEntity:GetHeroProp()
	return self.propList_
end

function ChessBoardHeroEntity:SetChanceServerData(arg_20_1)
	self.curChanceInfo_ = {
		chanceID = arg_20_1.chanceID,
		isUnLock = arg_20_1.isUnLock,
		chancePropList = deepClone(arg_20_1.chancePropList),
		chanceChooseList = deepClone(arg_20_1.chanceChooseList)
	}
end

function ChessBoardHeroEntity:SetCurUsedPropID(arg_21_1)
	self.curUsedProp_ = arg_21_1
end

function ChessBoardHeroEntity:GetCurUsedPropID()
	return self.curUsedProp_
end

function ChessBoardHeroEntity:ClearCurUsedPropID()
	self.curUsedProp_ = 0
end

function ChessBoardHeroEntity:Dispose()
	self.super.Dispose(self)

	self.propList_ = {}
	self.curUsedProp_ = 0
	self.curChanceInfo_ = {
		isUnLock = 0,
		chanceID = 0,
		chancePropList = {},
		chanceChooseList = {}
	}
end

return ChessBoardHeroEntity
