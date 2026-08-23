local var_0_0 = table
local var_0_1 = table.insert
local CommandComponent = class("CommandComponent")

function CommandComponent.create()
	return CommandComponent.new()
end

function CommandComponent:ctor()
	self._commands = {}
end

function CommandComponent:addUpdateCommand(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = self._commands

	var_3_0.attack_before = self._commands.attack_before or {}
	var_3_0.attack_before.buff = {}

	if arg_3_1.addBuffs and #arg_3_1.addBuffs > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.addBuffs) do
			local var_3_1 = {
				buff_action = 1,
				buff_id = iter_3_1.buffId,
				buff_serial_id = iter_3_1.serialId,
				knight_serial_id = iter_3_1.victim.serialId,
				add_effects = {}
			}

			if iter_3_1.rebound then
				var_0_1(var_3_1.add_effects, {
					add_type = 1
				})
			end

			var_0_1(var_3_0.attack_before.buff, var_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.buff or {}) do
		var_0_1(var_3_0.attack_before.buff, {
			buff_id = iter_3_3.buff_id,
			buff_serial_id = iter_3_3.buff_serial_id,
			knight_serial_id = iter_3_3.victim.serialId,
			buff_action = iter_3_3.buff_action,
			buff_effect = iter_3_3.buff_effect,
			is_dead = iter_3_3.victim.isDead,
			is_ghost = iter_3_3.victim.isGhost,
			del_ghost = iter_3_3.victim.delGhost
		})
	end

	if arg_3_1.removeList then
		for iter_3_4 = 1, #arg_3_1.removeList do
			var_0_1(var_3_0.attack_before.buff, {
				buff_action = 2,
				buff_serial_id = arg_3_1.removeList[iter_3_4].serialId,
				buff_id = arg_3_1.removeList[iter_3_4].buffCfg.id,
				knight_serial_id = arg_3_1.removeList[iter_3_4].victim.serialId,
				buff_show_state = arg_3_1.removeList[iter_3_4].buff_show_state
			})
		end
	end

	var_3_0.attack_serial_id = arg_3_1.attacker.serialId
	var_3_0.attack_before.effect = {}

	for iter_3_5, iter_3_6 in ipairs(arg_3_1.effect or {}) do
		local var_3_2 = {
			effect_type = iter_3_6.effect_type,
			effect_value = iter_3_6.effect_value,
			add_value = iter_3_6.add_value,
			add_value2 = iter_3_6.add_value2
		}

		if iter_3_6.victim then
			var_3_2.victim_serial_id = iter_3_6.victim.serialId
			var_3_2.is_dead = iter_3_6.victim.isDead
			var_3_2.is_ghost = iter_3_6.victim.isGhost
			var_3_2.del_ghost = iter_3_6.victim.delGhost
		end

		var_0_0.insert(var_3_0.attack_before.effect, var_3_2)
	end

	var_3_0.attack_before.add_effects = {}

	if arg_3_1.chanceStun then
		var_0_1(var_3_0.attack_before.add_effects, {
			add_type = 1
		})
	end

	if arg_3_1.is_dead then
		var_3_0.is_dead = true
	end
end

function CommandComponent:addFightCommand(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_1.attacker
	local var_4_3 = {}

	if not arg_4_2 then
		var_4_3 = self._commands
	end

	var_4_3.attack_serial_id = var_4_0.serialId
	var_4_3.add_serial_id = var_4_0.addSerialId
	var_4_3.attack_type = arg_4_1.attackType
	var_4_3.attack_id = arg_4_1.attackId
	var_4_3.uniteCdList = arg_4_1.uniteCdList

	if #arg_4_1.attackEffectBefore > 0 then
		var_4_3.attack_before = var_4_3.attack_before or {}
		var_4_3.attack_before.effect = var_4_3.attack_before.effect or {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_1.attackEffectBefore) do
			var_0_1(var_4_3.attack_before.effect, iter_4_1)
		end
	end

	var_4_3.attack_infos = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.attackInfos) do
		local var_4_4 = {
			victim_serial_id = iter_4_3.victim.serialId
		}
		local var_4_5 = {
			effect_type = iter_4_3.effect_type,
			effect_value = iter_4_3.effect_value,
			add_value = iter_4_3.add_value,
			add_value2 = iter_4_3.add_value2,
			debugLogData = iter_4_3.debugLogData,
			rebornFail = iter_4_3.rebornFail
		}

		var_4_4.effect = var_4_5
		var_4_5.add_effects = iter_4_3.add_effects or {}

		if iter_4_3.crit then
			var_0_1(var_4_5.add_effects, {
				add_type = 1
			})
		end

		if iter_4_3.miss then
			var_0_1(var_4_5.add_effects, {
				add_type = 2
			})
		end

		if iter_4_3.block then
			var_0_1(var_4_5.add_effects, {
				add_type = 3
			})
		end

		if iter_4_3.buffClear then
			var_0_1(var_4_5.add_effects, {
				add_type = 6
			})
		end

		if iter_4_3.invincible then
			var_0_1(var_4_5.add_effects, {
				add_type = 7
			})
		end

		if iter_4_3.suckAnger then
			var_0_1(var_4_5.add_effects, {
				add_type = 8
			})
		end

		if iter_4_3.seckill then
			var_0_1(var_4_5.add_effects, {
				add_type = 9
			})
		end

		if iter_4_3.hpLink then
			var_0_1(var_4_5.add_effects, {
				add_type = 10
			})
		end

		if iter_4_3.behead then
			var_0_1(var_4_5.add_effects, {
				add_type = 11
			})
		end

		if iter_4_3.detonate then
			var_0_1(var_4_5.add_effects, {
				add_type = 12
			})
		end

		if iter_4_3.absorb then
			local var_4_6 = iter_4_3.absorbValue or 0

			var_0_1(var_4_5.add_effects, {
				add_type = 13,
				add_value = var_4_6
			})
		end

		if iter_4_3.hide then
			var_0_1(var_4_5.add_effects, {
				add_type = 14
			})
		end

		if iter_4_3.immune then
			var_0_1(var_4_5.add_effects, {
				add_type = 15
			})
		end

		if iter_4_3.dragonSoul then
			var_0_1(var_4_5.add_effects, {
				add_type = 16
			})
		end

		if iter_4_3.tiesuo then
			var_0_1(var_4_5.add_effects, {
				add_type = 19
			})
		end

		if iter_4_3.ignoreShield then
			var_0_1(var_4_5.add_effects, {
				add_type = 20
			})
		end

		if iter_4_3.victim.isDead then
			var_4_4.is_dead = true
		end

		if iter_4_3.victim.isGhost then
			var_4_4.is_ghost = true
		end

		if iter_4_3.victim.delGhost then
			var_4_4.del_ghost = true
		end

		var_0_1(var_4_3.attack_infos, var_4_4)
	end

	if #arg_4_1.attackEffectAfter > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.effect = var_4_3.attack_after.effect or {}

		for iter_4_4, iter_4_5 in ipairs(arg_4_1.attackEffectAfter) do
			local var_4_7 = {
				effect_type = iter_4_5.effect_type,
				effect_value = iter_4_5.effect_value,
				add_value = iter_4_5.add_value,
				add_value2 = iter_4_5.add_value2,
				add_effects = iter_4_5.add_effects,
				rebornFail = iter_4_5.rebornFail
			}

			if iter_4_5.ignoreShield then
				var_4_7.add_effects = {
					{
						add_type = 20
					}
				}
			end

			if iter_4_5.suckAnger then
				var_4_7.add_effects = {
					{
						add_type = 8
					}
				}
			end

			if iter_4_5.victim then
				var_4_7.victim_serial_id = iter_4_5.victim.serialId
				var_4_7.is_dead = iter_4_5.victim.isDead

				if iter_4_5.victim.isGhost then
					var_4_7.is_ghost = true
				end

				if iter_4_5.victim.delGhost then
					var_4_7.del_ghost = true
				end
			end

			var_0_1(var_4_3.attack_after.effect, var_4_7)
		end
	end

	if #arg_4_1.addBuffs > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.buff = {}

		for iter_4_6, iter_4_7 in ipairs(arg_4_1.addBuffs) do
			local var_4_8 = {
				buff_action = 1,
				buff_id = iter_4_7.buffId,
				buff_serial_id = iter_4_7.serialId,
				knight_serial_id = iter_4_7.victim.serialId,
				add_effects = {}
			}

			var_4_8.buff_effect_index = iter_4_7.buff_effect_index or 0
			var_4_8.buff_show_state = iter_4_7.buff_show_state

			if iter_4_7.rebound then
				var_0_1(var_4_8.add_effects, {
					add_type = 1
				})
			end

			var_0_1(var_4_3.attack_after.buff, var_4_8)
		end
	end

	if #arg_4_1.delBuffs > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.buff = var_4_3.attack_after.buff or {}

		for iter_4_8, iter_4_9 in ipairs(arg_4_1.delBuffs) do
			var_0_1(var_4_3.attack_after.buff, {
				buff_action = 2,
				buff_id = iter_4_9.buffCfg.id,
				buff_serial_id = iter_4_9.serialId,
				knight_serial_id = iter_4_9.victim.serialId,
				buff_show_state = iter_4_9.buff_show_state
			})
		end
	end

	if #arg_4_1.updateBuffEffects > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.buff = var_4_3.attack_after.buff or {}

		for iter_4_10, iter_4_11 in ipairs(arg_4_1.updateBuffEffects) do
			local var_4_9 = {
				buff_action = 4,
				buff_id = iter_4_11.buffCfg.id,
				buff_serial_id = iter_4_11.serialId,
				knight_serial_id = iter_4_11.victim.serialId
			}

			var_4_9.buff_effect_index = iter_4_11.buff_effect_index or 0

			var_0_1(var_4_3.attack_after.buff, var_4_9)
		end
	end

	if #arg_4_1.buffVisible > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.buff = var_4_3.attack_after.buff or {}

		for iter_4_12, iter_4_13 in ipairs(arg_4_1.buffVisible) do
			var_0_1(var_4_3.attack_after.buff, {
				buff_action = 5,
				buff_id = iter_4_13.buffCfg.id,
				buff_serial_id = iter_4_13.serialId,
				knight_serial_id = iter_4_13.victim.serialId,
				buff_show_state = iter_4_13.buff_show_state
			})
		end
	end

	if #arg_4_1.skillSummons > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.skillSummons = var_4_3.attack_after.skillSummons or {}

		for iter_4_14, iter_4_15 in ipairs(arg_4_1.skillSummons) do
			var_0_1(var_4_3.attack_after.skillSummons, {
				summon_action = 1,
				serial_id = iter_4_15.serialId,
				summon_id = iter_4_15.summonCfg.id,
				owner_serial_id = iter_4_15.owner.serialId
			})
		end
	end

	if #arg_4_1.delSkillSummon > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.skillSummons = var_4_3.attack_after.skillSummons or {}

		for iter_4_16, iter_4_17 in ipairs(arg_4_1.delSkillSummon) do
			var_0_1(var_4_3.attack_after.skillSummons, {
				summon_action = 2,
				serial_id = iter_4_17.serialId,
				summon_id = iter_4_17.summonCfg.id,
				owner_serial_id = iter_4_17.owner.serialId
			})
		end
	end

	if #arg_4_1.addScenes > 0 then
		var_4_3.attack_after = var_4_3.attack_after or {}
		var_4_3.attack_after.add_scenes = var_4_3.attack_after.add_scenes or {}

		for iter_4_18, iter_4_19 in ipairs(arg_4_1.addScenes) do
			var_0_1(var_4_3.attack_after.add_scenes, {
				serial_id = iter_4_19.serialId,
				scene_id = iter_4_19.sceneId,
				attack_serial_id = iter_4_19.attacker.serialId
			})
		end
	end

	if var_4_0.isDead then
		var_4_3.is_dead = true
	end

	var_4_3.knights = arg_4_1.knights
	var_4_3.reborns = arg_4_1.reborns
	var_4_3.spEffects = arg_4_1.spEffects

	if arg_4_2 then
		self._commands.passive_infos = self._commands.passive_infos or {}

		var_0_0.insert(self._commands.passive_infos, #self._commands.passive_infos + 1, var_4_3)
	end
end

function CommandComponent:addRoundCommand(arg_5_1)
	self._commands.round_start = {}
	self._commands.round_start.combo_value = arg_5_1.comboValue
	self._commands.round_start.cd_list = arg_5_1.cdList
	self._commands.round_start.succuba_cd_list = arg_5_1.succubaCdList
	self._commands.round_start.scene_list = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.sceneRemoveList or {}) do
		var_0_0.insert(self._commands.round_start.scene_list, {
			scene_id = iter_5_1.sceneCfg.id,
			scene_serial_id = iter_5_1.serialId,
			knight_serial = iter_5_1.attacker.serialId
		})
	end

	self._commands.round_start.buffs = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_1.removeList or {}) do
		var_0_0.insert(self._commands.round_start.buffs, {
			buff_action = 2,
			buff_serial_id = iter_5_3.serialId,
			buff_id = iter_5_3.buffCfg.id,
			knight_serial_id = iter_5_3.victim.serialId,
			buff_show_state = iter_5_3.buff_show_state
		})
	end
end

function CommandComponent:addUpdateAfterAttackCommand(arg_6_1)
	self._commands.attack_after = self._commands.attack_after or {}
	self._commands.attack_after.buff = self._commands.attack_after.buff or {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.removeList or {}) do
		var_0_1(self._commands.attack_after.buff, {
			buff_action = 2,
			buff_id = iter_6_1.buffCfg.id,
			buff_serial_id = iter_6_1.serialId,
			knight_serial_id = iter_6_1.victim.serialId,
			buff_show_state = iter_6_1.buff_show_state
		})
	end
end

function CommandComponent:addNotReadyCommand(arg_7_1)
	self._commands.attack_after = self._commands.attack_after or {}
	self._commands.attack_after.buff = self._commands.attack_after.buff or {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.removeList or {}) do
		var_0_1(self._commands.attack_after.buff, {
			buff_action = 2,
			buff_id = iter_7_1.buffCfg.id,
			buff_serial_id = iter_7_1.serialId,
			knight_serial_id = iter_7_1.victim.serialId,
			buff_show_state = iter_7_1.buff_show_state
		})
	end
end

function CommandComponent:setGameOver(arg_8_1)
	self._commands.is_game_over = true
	self._commands.winner = arg_8_1
end

function CommandComponent:setWaveOver(arg_9_1)
	self._commands.is_wave_over = true
	self._commands.winner = arg_9_1
end

function CommandComponent:setDebugAddBuff()
	self._commands.is_debug_add_buff = true
end

function CommandComponent:setWaveRecover(arg_11_1)
	self._commands.wave_recover = arg_11_1
end

function CommandComponent:addAssist()
	self._commands.assist = true
end

function CommandComponent:addRestart(arg_13_1)
	self._commands.restart = true
	self._commands.restart_infos = arg_13_1
end

function CommandComponent:addNextWave(arg_14_1)
	self._commands.nextWaveInfos = {}
	self._commands.nextWaveInfos.removeBuffList = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_1.removeBuffList or {}) do
		local var_14_0 = {}

		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			var_0_1(var_14_0, {
				buff_action = 2,
				buff_id = iter_14_3.buffCfg.id,
				buff_serial_id = iter_14_3.serialId,
				knight_serial_id = iter_14_3.victim.serialId,
				buff_show_state = iter_14_3.buff_show_state
			})
		end

		self._commands.nextWaveInfos.removeBuffList[iter_14_0] = var_14_0
	end

	self._commands.nextWaveInfos.removeMarkList = {}

	for iter_14_4, iter_14_5 in pairs(arg_14_1.removeMarkList or {}) do
		local var_14_1 = {}

		for iter_14_6, iter_14_7 in ipairs(iter_14_5) do
			var_0_1(var_14_1, {
				markType = iter_14_7.mType,
				level = iter_14_7.level,
				knight_serial_id = iter_14_7.victim.serialId
			})
		end

		self._commands.nextWaveInfos.removeMarkList[iter_14_4] = var_14_1
	end
end

function CommandComponent:pack()
	return self._commands
end

return CommandComponent
