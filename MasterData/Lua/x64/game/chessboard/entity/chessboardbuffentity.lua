local ChessBoardBuffEntity = class("ChessBoardBuffEntity")
local var_0_1 = {
	ADD_BUFF = 1,
	DESTORY_BUFF = 2,
	TURN_BUFF = 3
}
local var_0_2 = {
	[ChessBoardConst.BUFF_EFFECT_TIMING.NPC_STAY] = ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO,
	[ChessBoardConst.BUFF_EFFECT_TIMING.NPC_PASS] = ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO,
	[ChessBoardConst.BUFF_EFFECT_TIMING.PLAYER_STAY] = ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC,
	[ChessBoardConst.BUFF_EFFECT_TIMING.PLAYER_PASS] = ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC,
	[ChessBoardConst.BUFF_EFFECT_TIMING.STEP_UPDATE] = ChessBoardConst.TIMING.BUFF_STEP
}

function ChessBoardBuffEntity:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.buffPoolID_ = arg_1_1
	self.playerEntityID_ = arg_1_2
	self.duration_ = arg_1_3
	self.effectList_ = {}

	for iter_1_0, iter_1_1 in pairs(ChessBoardConst.BUFF_EFFECT_TIMING) do
		self.effectList_[iter_1_1] = {}
	end

	for iter_1_2, iter_1_3 in pairs(ChessBoardBuffPoolCfg[self.buffPoolID_].buff_efffect or {}) do
		table.insert(self.effectList_[ChessBoardBuffEffectCfg[iter_1_3].trigger_time], {
			triggerNum = 0,
			effectID = iter_1_3
		})
	end

	for iter_1_4, iter_1_5 in pairs(arg_1_4) do
		for iter_1_6, iter_1_7 in pairs(self.effectList_[ChessBoardBuffEffectCfg[iter_1_5.effectID].trigger_time]) do
			if iter_1_7.effectID == iter_1_5.effectID then
				iter_1_7.triggerNum = iter_1_5.triggerNum
			end
		end
	end
end

function ChessBoardBuffEntity:GetBuffPoolID()
	return self.buffPoolID_
end

function ChessBoardBuffEntity:OnBuffStart()
	self:TriggerEvent(var_0_1.ADD_BUFF)
end

function ChessBoardBuffEntity:UpdateTurn()
	self.duration_ = self.duration_ + 1
end

function ChessBoardBuffEntity:OnBuffUpdateTurn()
	if ChessBoardBuffPoolCfg[self.buffPoolID_].updateround > 0 and self.duration_ % ChessBoardBuffPoolCfg[self.buffPoolID_].updateround == 0 then
		self:TriggerEvent(var_0_1.TURN_BUFF)
	end

	if ChessBoardBuffPoolCfg[self.buffPoolID_].remainround > 0 and self.duration_ >= ChessBoardBuffPoolCfg[self.buffPoolID_].remainround then
		manager.ChessBoardManager:RemoveBuff(self.playerEntityID_, self.buffPoolID_)
	end
end

function ChessBoardBuffEntity:OnBuffDestroy()
	self:TriggerEvent(var_0_1.DESTORY_BUFF)
end

function ChessBoardBuffEntity:OnBuffEffectTrigger(arg_7_1, arg_7_2)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in pairs(self.effectList_[arg_7_1]) do
		local var_7_1 = ChessBoardBuffEffectCfg[iter_7_1.effectID]
		local var_7_2 = ChessBoardEventPoolCfg[ChessBoardBuffEffectCfg[iter_7_1.effectID].event]
		local var_7_3

		if self.playerEntityID_ == 0 then
			var_7_3 = manager.ChessBoardManager:GetCurHeroPosGridData()
		else
			local var_7_4, var_7_5 = manager.ChessBoardManager.NPCManager_:GetNPCPosAndDir(self.playerEntityID_)

			var_7_3 = ChessBoardLuaBridge.GetGridData(var_7_4.x, var_7_4.z)
		end

		if var_7_1.trigger_count == -1 then
			if var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_STEP then
				if self.playerEntityID_ == 0 then
					if not table.isEmpty(var_7_2.player_params) then
						var_7_0 = true

						manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
							playerB = -1,
							gridData = var_7_3,
							buffEffectID = iter_7_1.effectID,
							playerA = self.playerEntityID_
						})
					end
				elseif not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
						playerB = -1,
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = self.playerEntityID_
					})
				end
			elseif var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO or var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO then
				if not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = arg_7_2,
						playerB = self.playerEntityID_
					})
				end
			elseif (var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC or var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC) and not table.isEmpty(var_7_2.player_params) then
				var_7_0 = true

				manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
					gridData = var_7_3,
					buffEffectID = iter_7_1.effectID,
					playerA = self.playerEntityID_,
					playerB = arg_7_2
				})
			end
		elseif iter_7_1.triggerNum < var_7_1.trigger_count then
			if var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_STEP then
				if self.playerEntityID_ == 0 then
					if not table.isEmpty(var_7_2.player_params) then
						var_7_0 = true

						manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
							playerB = -1,
							gridData = var_7_3,
							buffEffectID = iter_7_1.effectID,
							playerA = self.playerEntityID_
						})
					end
				elseif not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
						playerB = -1,
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = self.playerEntityID_
					})
				end
			elseif var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO or var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO then
				if not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = arg_7_2,
						playerB = self.playerEntityID_
					})
				end
			elseif (var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC or var_0_2[arg_7_1] == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC) and not table.isEmpty(var_7_2.player_params) then
				var_7_0 = true

				manager.ChessBoardManager:ExecuteTiming(var_0_2[arg_7_1], {
					gridData = var_7_3,
					buffEffectID = iter_7_1.effectID,
					playerA = self.playerEntityID_,
					playerB = arg_7_2
				})
			end
		end

		iter_7_1.triggerNum = iter_7_1.triggerNum + 1
	end

	if var_7_0 then
		manager.ChessBoardManager:StartExecuteEvent()
	end
end

function ChessBoardBuffEntity:TriggerEvent(arg_8_1)
	local var_8_0 = 0
	local var_8_1 = 0

	if arg_8_1 == var_0_1.ADD_BUFF then
		var_8_0 = ChessBoardBuffPoolCfg[self.buffPoolID_].add_event
		var_8_1 = ChessBoardConst.TIMING.BUFF_ADD
	elseif arg_8_1 == var_0_1.DESTORY_BUFF then
		var_8_0 = ChessBoardBuffPoolCfg[self.buffPoolID_].destory_event
		var_8_1 = ChessBoardConst.TIMING.BUFF_DELETE
	elseif arg_8_1 == var_0_1.TURN_BUFF then
		var_8_0 = ChessBoardBuffPoolCfg[self.buffPoolID_].turn_event
		var_8_1 = ChessBoardConst.TIMING.BUFF_TURN
	end

	if var_8_0 ~= 0 then
		if self.playerEntityID_ > 0 then
			if table.isEmpty(ChessBoardEventPoolCfg[var_8_0].npc_params) then
				return
			end
		elseif table.isEmpty(ChessBoardEventPoolCfg[var_8_0].player_params) then
			return
		end

		manager.ChessBoardManager:ExecuteTiming(var_8_1, {
			playerB = -1,
			buffID = self.buffPoolID_,
			playerA = self.playerEntityID_
		})
		manager.ChessBoardManager:StartExecuteEvent()
	end
end

function ChessBoardBuffEntity:IsDebuff()
	if ChessBoardBuffPoolCfg[self.buffPoolID_].buff_type == ChessBoardConst.BUFF_TYPE.DEBUFF then
		return true
	else
		return false
	end
end

function ChessBoardBuffEntity:GetRemainRound()
	if ChessBoardBuffPoolCfg[self.buffPoolID_].remainround > 0 then
		return ChessBoardBuffPoolCfg[self.buffPoolID_].remainround - self.duration_
	else
		return -1
	end
end

function ChessBoardBuffEntity:Dispose()
	return
end

return ChessBoardBuffEntity
