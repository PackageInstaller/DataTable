local var_0_0 = class("ChessBoardBuffEntity")
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

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.buffPoolID_ = arg_1_1
	arg_1_0.playerEntityID_ = arg_1_2
	arg_1_0.duration_ = arg_1_3

	local var_1_0 = ChessBoardBuffPoolCfg[arg_1_0.buffPoolID_]

	arg_1_0.effectList_ = {}

	for iter_1_0, iter_1_1 in pairs(ChessBoardConst.BUFF_EFFECT_TIMING) do
		arg_1_0.effectList_[iter_1_1] = {}
	end

	for iter_1_2, iter_1_3 in pairs(var_1_0.buff_efffect or {}) do
		local var_1_1 = ChessBoardBuffEffectCfg[iter_1_3]

		table.insert(arg_1_0.effectList_[var_1_1.trigger_time], {
			triggerNum = 0,
			effectID = iter_1_3
		})
	end

	for iter_1_4, iter_1_5 in pairs(arg_1_4) do
		local var_1_2 = ChessBoardBuffEffectCfg[iter_1_5.effectID]

		for iter_1_6, iter_1_7 in pairs(arg_1_0.effectList_[var_1_2.trigger_time]) do
			if iter_1_7.effectID == iter_1_5.effectID then
				iter_1_7.triggerNum = iter_1_5.triggerNum
			end
		end
	end
end

function var_0_0.GetBuffPoolID(arg_2_0)
	return arg_2_0.buffPoolID_
end

function var_0_0.OnBuffStart(arg_3_0)
	arg_3_0:TriggerEvent(var_0_1.ADD_BUFF)
end

function var_0_0.UpdateTurn(arg_4_0)
	arg_4_0.duration_ = arg_4_0.duration_ + 1
end

function var_0_0.OnBuffUpdateTurn(arg_5_0)
	local var_5_0 = ChessBoardBuffPoolCfg[arg_5_0.buffPoolID_]

	if var_5_0.updateround > 0 and arg_5_0.duration_ % var_5_0.updateround == 0 then
		arg_5_0:TriggerEvent(var_0_1.TURN_BUFF)
	end

	if var_5_0.remainround > 0 and arg_5_0.duration_ >= var_5_0.remainround then
		manager.ChessBoardManager:RemoveBuff(arg_5_0.playerEntityID_, arg_5_0.buffPoolID_)
	end
end

function var_0_0.OnBuffDestroy(arg_6_0)
	arg_6_0:TriggerEvent(var_0_1.DESTORY_BUFF)
end

function var_0_0.OnBuffEffectTrigger(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in pairs(arg_7_0.effectList_[arg_7_1]) do
		local var_7_1 = ChessBoardBuffEffectCfg[iter_7_1.effectID]
		local var_7_2 = ChessBoardEventPoolCfg[var_7_1.event]
		local var_7_3

		if arg_7_0.playerEntityID_ == 0 then
			var_7_3 = manager.ChessBoardManager:GetCurHeroPosGridData()
		else
			local var_7_4, var_7_5 = manager.ChessBoardManager.NPCManager_:GetNPCPosAndDir(arg_7_0.playerEntityID_)

			var_7_3 = ChessBoardLuaBridge.GetGridData(var_7_4.x, var_7_4.z)
		end

		if var_7_1.trigger_count == -1 then
			local var_7_6 = var_0_2[arg_7_1]

			if var_7_6 == ChessBoardConst.TIMING.BUFF_STEP then
				if arg_7_0.playerEntityID_ == 0 then
					if not table.isEmpty(var_7_2.player_params) then
						var_7_0 = true

						manager.ChessBoardManager:ExecuteTiming(var_7_6, {
							playerB = -1,
							gridData = var_7_3,
							buffEffectID = iter_7_1.effectID,
							playerA = arg_7_0.playerEntityID_
						})
					end
				elseif not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_7_6, {
						playerB = -1,
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = arg_7_0.playerEntityID_
					})
				end
			elseif var_7_6 == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO or var_7_6 == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO then
				if not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_7_6, {
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = arg_7_2,
						playerB = arg_7_0.playerEntityID_
					})
				end
			elseif (var_7_6 == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC or var_7_6 == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC) and not table.isEmpty(var_7_2.player_params) then
				var_7_0 = true

				manager.ChessBoardManager:ExecuteTiming(var_7_6, {
					gridData = var_7_3,
					buffEffectID = iter_7_1.effectID,
					playerA = arg_7_0.playerEntityID_,
					playerB = arg_7_2
				})
			end
		elseif iter_7_1.triggerNum < var_7_1.trigger_count then
			local var_7_7 = var_0_2[arg_7_1]

			if var_7_7 == ChessBoardConst.TIMING.BUFF_STEP then
				if arg_7_0.playerEntityID_ == 0 then
					if not table.isEmpty(var_7_2.player_params) then
						var_7_0 = true

						manager.ChessBoardManager:ExecuteTiming(var_7_7, {
							playerB = -1,
							gridData = var_7_3,
							buffEffectID = iter_7_1.effectID,
							playerA = arg_7_0.playerEntityID_
						})
					end
				elseif not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_7_7, {
						playerB = -1,
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = arg_7_0.playerEntityID_
					})
				end
			elseif var_7_7 == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO or var_7_7 == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO then
				if not table.isEmpty(var_7_2.npc_params) then
					var_7_0 = true

					manager.ChessBoardManager:ExecuteTiming(var_7_7, {
						gridData = var_7_3,
						buffEffectID = iter_7_1.effectID,
						playerA = arg_7_2,
						playerB = arg_7_0.playerEntityID_
					})
				end
			elseif (var_7_7 == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC or var_7_7 == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC) and not table.isEmpty(var_7_2.player_params) then
				var_7_0 = true

				manager.ChessBoardManager:ExecuteTiming(var_7_7, {
					gridData = var_7_3,
					buffEffectID = iter_7_1.effectID,
					playerA = arg_7_0.playerEntityID_,
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

function var_0_0.TriggerEvent(arg_8_0, arg_8_1)
	local var_8_0 = ChessBoardBuffPoolCfg[arg_8_0.buffPoolID_]
	local var_8_1 = 0
	local var_8_2 = 0

	if arg_8_1 == var_0_1.ADD_BUFF then
		var_8_1 = var_8_0.add_event
		var_8_2 = ChessBoardConst.TIMING.BUFF_ADD
	elseif arg_8_1 == var_0_1.DESTORY_BUFF then
		var_8_1 = var_8_0.destory_event
		var_8_2 = ChessBoardConst.TIMING.BUFF_DELETE
	elseif arg_8_1 == var_0_1.TURN_BUFF then
		var_8_1 = var_8_0.turn_event
		var_8_2 = ChessBoardConst.TIMING.BUFF_TURN
	end

	if var_8_1 ~= 0 then
		if arg_8_0.playerEntityID_ > 0 then
			if table.isEmpty(ChessBoardEventPoolCfg[var_8_1].npc_params) then
				return
			end
		elseif table.isEmpty(ChessBoardEventPoolCfg[var_8_1].player_params) then
			return
		end

		local var_8_3 = {
			playerB = -1,
			buffID = arg_8_0.buffPoolID_,
			playerA = arg_8_0.playerEntityID_
		}

		manager.ChessBoardManager:ExecuteTiming(var_8_2, var_8_3)
		manager.ChessBoardManager:StartExecuteEvent()
	end
end

function var_0_0.IsDebuff(arg_9_0)
	if ChessBoardBuffPoolCfg[arg_9_0.buffPoolID_].buff_type == ChessBoardConst.BUFF_TYPE.DEBUFF then
		return true
	else
		return false
	end
end

function var_0_0.GetRemainRound(arg_10_0)
	local var_10_0 = ChessBoardBuffPoolCfg[arg_10_0.buffPoolID_]

	if var_10_0.remainround > 0 then
		return var_10_0.remainround - arg_10_0.duration_
	else
		return -1
	end
end

function var_0_0.Dispose(arg_11_0)
	return
end

return var_0_0
