local var_0_0 = table
local var_0_1 = table.insert
local var_0_2 = load("core.rule.BuffRule")
local var_0_3 = load("core.fight.FightResult")
local var_0_4 = load("core.rule.SkillSpecialRule")
local var_0_5 = load("core.Parameters")
local var_0_6 = {}

function var_0_6:update(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = {
		addBuffs = {},
		_addBuffEffect = {},
		addBuff = function(self, arg_2_1)
			var_0_1(self.addBuffs, arg_2_1)
		end,
		addBuffEffect = function(self, arg_3_1)
			var_0_1(self._addBuffEffect, arg_3_1)
			BLog.LogExtraEffect(arg_3_1, 1)
		end
	}

	function var_1_0:update(arg_4_1)
		local var_4_0 = loadCfg("core.config.cfg.buff_info")
		local var_4_1 = {}
		local var_4_2 = {}

		for iter_4_0, iter_4_1 in ipairs(self.addBuffs) do
			local var_4_3 = var_4_0.get(iter_4_1.buffId)
			local var_4_4 = iter_4_1.victim:addBuff(iter_4_1.buffId, iter_4_1.buffTime, iter_4_1.attacker, iter_4_1.buffCheck, iter_4_1.params, self)

			if var_4_4 then
				if not iter_4_1.attacker.isPlayer then
					local var_4_5 = 0

					if var_4_2[iter_4_1.attacker.serialId] then
						var_4_5 = var_4_2[iter_4_1.attacker.serialId]
					else
						var_4_5 = iter_4_1.attacker:doBuff(var_0_2.TYPE.BUFF_LV_UP, 0)
						var_4_2[iter_4_1.attacker.serialId] = var_4_5
					end

					if var_4_5 > 0 then
						var_4_4:addLevel(var_4_5)
					end
				end

				iter_4_1.serialId = var_4_4.serialId
				iter_4_1.buff_effect_index = var_4_4.buff_effect_index
				iter_4_1.buff_show_state = var_4_4.buff_show_state

				var_0_1(var_4_1, iter_4_1)
			end
		end

		self.addBuffs = var_4_1

		if #self.addBuffs > 0 then
			arg_1_2:getBattleData():executeSpRule(var_0_4.TYPE.ADD_BUFF, self.addBuffs)
			arg_1_2:getBattleData():executeKnightSpRule(var_0_4.TYPE.ADD_BUFF, self.addBuffs)
		end

		if not arg_4_1 then
			self:doBuff(var_0_2.TYPE.BUFF_407, nil, {
				fightResult = self
			})
		end

		local var_4_6

		for iter_4_2, iter_4_3 in ipairs(self._addBuffEffect) do
			for iter_4_4, iter_4_5 in ipairs(var_0_3.updateSkillEffect(var_1_0, iter_4_3.attacker, iter_4_3.victim, iter_4_3, arg_1_2) or {}) do
				var_0_1(self._addBuffEffect, iter_4_5)
			end

			var_0_1(var_1_0.effect, iter_4_3)

			if #var_1_0.effect - #self._addBuffEffect > 10000 then
				var_4_6 = 1

				break
			end
		end

		if var_4_6 and g and g.core and BATTLE_PLATFORM == CLIENT then
			local var_4_7 = "可能存在战斗作用效果死循环情况,battleId=" .. arg_1_2:getBattleId() .. ",loopCheckFlag=" .. var_4_6

			g.core.platform.BuglyProxy:error(var_4_7)
			arg_1_1:setBattleError()
			g.core.log:error(var_4_7)
		end
	end

	local var_1_1 = {}
	local var_1_2 = self:doBuff(var_0_2.TYPE.DRAGON_PROTECT, {
		skillId1 = 0,
		isEff = false,
		skillId2 = 0
	})

	if var_1_2.isEff then
		local var_1_3

		for iter_1_0, iter_1_1 in ipairs((self:getBuffs())) do
			if iter_1_1:canClear() then
				if iter_1_1.buffCfg.buff_control_type == 1 then
					var_1_3 = iter_1_1

					break
				elseif not var_1_3 and iter_1_1.buffCfg.buff_increase_type == 2 then
					var_1_3 = iter_1_1
				end
			end
		end

		if var_1_3 ~= nil then
			var_1_3.isDone = true

			var_0_1(var_1_1, self:delBuff(var_1_3.serialId))
			arg_1_2:getBattleData():addPassive({
				isSkill = true,
				knight = self,
				info = loadCfg("core.config.cfg.skill_info").get(var_1_2.skillId1),
				identity = self.identity
			})
		else
			local var_1_4 = {
				isSkill = true,
				knight = self
			}

			var_1_4.info = loadCfg("core.config.cfg.skill_info").get(var_1_2.skillId2)
			var_1_4.identity = self.identity

			arg_1_2:getBattleData():addPassive(var_1_4)
		end
	end

	local var_1_5 = self:doBuff(var_0_2.TYPE.EXILE)

	var_1_0.effect = {}

	local var_1_6 = self:doBuff(var_0_2.TYPE.HOVERING, {
		shield = 0,
		damage = 0
	})

	if var_1_6.shield > 0 then
		var_0_0.insert(var_1_0.effect, {
			effect_type = 15,
			effect_value = var_1_6.shield
		})
	elseif var_1_6.damage > 0 then
		var_0_0.insert(var_1_0.effect, {
			effect_type = 1,
			effect_value = var_1_6.damage
		})
	end

	local var_1_7 = self.identity

	if not var_1_5 then
		if not arg_1_2:isDisableComboRecover() then
			var_0_0.insert(var_1_0.effect, {
				effect_type = 6,
				effect_value = arg_1_1:updateComboValue(arg_1_1:getComboInfo(var_1_7).baseInfo.COMBO_RECOVER_ACTION, var_1_7, true)
			})
		end

		if not arg_1_2:isDisableAngerRecover() then
			if self.baseInfo.ANGER_RECOVER > 0 then
				var_0_0.insert(var_1_0.effect, {
					effect_type = 4,
					effect_value = self.baseInfo.ANGER_RECOVER
				})
			end
		end
	end

	var_1_0.stun = self:doBuff(var_0_2.TYPE.ACT_LIMIT)

	local var_1_8 = self:doBuff(var_0_2.TYPE.CHANCE_LIMIT)

	var_1_0.chanceStun = var_1_8
	var_1_0.stun = var_1_0.stun or var_1_8

	local var_1_9 = self:doBuff(var_0_2.TYPE.FROST_SHOT_HIT_REDUCED)

	if var_1_9 then
		local var_1_10 = self:doBuff(var_0_2.TYPE.FROST_ICE_EXPLOSION)

		if var_1_10 and var_1_10.damage > 0 then
			var_0_1(var_1_0.effect, {
				effect_type = 1,
				effect_value = var_1_10.damage,
				attacker = var_1_10.attacker,
				victim = self
			})
		end
	end

	var_1_0.stun = var_1_0.stun or var_1_9
	var_1_0.stun = var_1_0.stun or var_1_5
	var_1_0.stun = var_1_0.stun or self:doBuff(var_0_2.TYPE.BUFF_529, {
		actionEff = false
	}).actionEff
	var_1_0.stun = var_1_0.stun or self:doBuff(var_0_2.TYPE.BUFF_548, {
		actionEff = false
	}).actionEff
	var_1_0.stun = var_1_0.stun or self:doBuff(var_0_2.TYPE.BUFF_549, {
		actionEff = false
	}, {
		checkAction = true,
		fightResult = var_1_0
	}).actionEff
	arg_1_3 = arg_1_3 or false
	var_1_0.stun = var_1_0.stun and not arg_1_3

	if var_1_0.stun then
		if self.actionFailWarBand then
			local var_1_11 = 0

			var_1_11 = self.classical == arg_1_1:getWarBandClassical(self.identity) and var_0_5.WARBAND_VALUE_SAME_ATTACK_FAULT_VALUE or var_0_5.WARBAND_VALUE_DIFF_ATTACK_FAULT_VALUE

			var_0_0.insert(var_1_0.effect, {
				effect_type = 208,
				effect_value = var_1_11,
				victim = self,
				attacker = self
			})

			self.actionFailWarBand = false
		end
	elseif self.actionWarBand then
		local var_1_12 = 0

		var_1_12 = self.classical == arg_1_1:getWarBandClassical(self.identity) and var_0_5.WARBAND_VALUE_SAME_ATTACK_VALUE or var_0_5.WARBAND_VALUE_DIFF_ATTACK_VALUE

		var_0_0.insert(var_1_0.effect, {
			effect_type = 208,
			effect_value = var_1_12,
			victim = self,
			attacker = self
		})

		self.actionWarBand = false
	end

	if not var_1_5 then
		local var_1_13 = self:doBuff(var_0_2.TYPE.DHOT, {
			exEffects = {},
			addBuffs = {}
		})

		for iter_1_2, iter_1_3 in ipairs(var_1_13.exEffects) do
			var_0_0.insert(var_1_0.effect, iter_1_3)
		end

		for iter_1_4, iter_1_5 in ipairs(var_1_13.addBuffs) do
			var_1_0:addBuff(iter_1_5)
		end

		var_1_0.buff = var_1_13

		for iter_1_6, iter_1_7 in ipairs((arg_1_1:getKnightList(3 - self.identity))) do
			for iter_1_8, iter_1_9 in ipairs((iter_1_7:doBuff(var_0_2.TYPE.RECOVER_BY_DOT, {}, var_1_13))) do
				if iter_1_9.recoverHp > 0 then
					var_0_0.insert(var_1_0.effect, {
						effect_type = 2,
						effect_value = iter_1_9.recoverHp,
						victim = iter_1_7,
						attacker = iter_1_7
					})
				end
			end
		end

		arg_1_1:executeKnightSpRule(var_0_4.TYPE.HDOT_EFFECT, var_1_13)

		local var_1_14 = self:doBuff(var_0_2.TYPE.DEATH_STARE, {
			isSeckill = false,
			damage = 0
		})

		if var_1_14.damage > 0 then
			var_0_0.insert(var_1_0.effect, {
				effect_type = 1,
				effect_value = var_1_14.damage,
				victim = self,
				seckill = var_1_14.isSeckill
			})
		end

		local var_1_15 = self:doBuff(var_0_2.TYPE.BUFF_344, {
			damageValue = 0
		})

		if var_1_15.damageValue > 0 then
			var_0_0.insert(var_1_0.effect, {
				effect_type = 1,
				effect_value = var_1_15.damageValue,
				attacker = var_1_15.attacker,
				victim = self
			})
		end

		local var_1_16 = self:doBuff(var_0_2.TYPE.BUFF_564, {
			isEff = false,
			damage = 0
		}, {
			action = true
		})

		if var_1_16.isEff then
			var_0_0.insert(var_1_0.effect, {
				effect_type = 1,
				effect_value = var_1_16.damage,
				attacker = var_1_16.attacker,
				victim = self
			})
		end

		var_0_0.insertto(var_1_1, self:doBuffRound(var_0_2.ROUND.BEFORE))

		var_1_0.removeList = var_1_1
	else
		var_1_0.buff = {}

		var_0_0.insertto(var_1_1, self:doSpBuffRound(var_0_2.ROUND.BEFORE, var_0_2.TYPE.EXILE))

		var_1_0.removeList = var_1_1
	end

	if var_1_0.removeList and next(var_1_0.removeList) then
		arg_1_1:executeSpRule(var_0_4.TYPE.BUFF_REMOVE, var_1_0.removeList)
		arg_1_1:executeKnightSpRule(var_0_4.TYPE.BUFF_REMOVE, var_1_0.removeList)
	end

	var_1_0.attacker = self

	local var_1_17 = var_0_6.updateAttacker(self, var_1_0, arg_1_2)

	var_1_0:update(var_1_17)

	if not var_1_17 then
		self:doBuff(var_0_2.TYPE.TRANSFORM, {}, {
			fightResult = var_1_0
		})
	end

	return var_1_17, var_1_0
end

function var_0_6:updateAttacker(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.buff) do
		for iter_5_2, iter_5_3 in ipairs(var_0_3.updateSkillEffect(arg_5_1, iter_5_1.attacker, iter_5_1.victim, iter_5_1.buff_effect, arg_5_2) or {}) do
			var_0_1(arg_5_1.effect, iter_5_3)
		end
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_1.effect) do
		local var_5_1 = var_0_3:updateSkillEffect(iter_5_5.attacker or self, iter_5_5.victim or self, iter_5_5, arg_5_2)

		var_5_1 = var_5_1 or {}

		for iter_5_6, iter_5_7 in ipairs(var_5_1) do
			var_0_1(arg_5_1.effect, iter_5_7)
		end
	end

	arg_5_1.is_dead = self.isDead

	if arg_5_1.stun or self.isDead then
		return false
	end

	if self.isGhost then
		return false
	end

	return true
end

function var_0_6.updateAfterAttack(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = arg_6_1:getKnights()

	for iter_6_0, iter_6_1 in var_6_2:ipairs() do
		for iter_6_2 = #iter_6_1.buffs, 1, -1 do
			if iter_6_1.buffs[iter_6_2].buffCfg.buff_type == var_0_2.TYPE.FORCE_MISS then
				iter_6_1.buffs[iter_6_2].rule(true)
			end

			if iter_6_1.buffs[iter_6_2].isDone then
				var_0_0.insert(var_6_1, iter_6_1.buffs[iter_6_2])
				var_0_0.remove(iter_6_1.buffs, iter_6_2)
				iter_6_1.buffs[iter_6_2]:doRemove()
				iter_6_1:updateBuffCount(iter_6_1.buffs[iter_6_2].buffCfg, true)
			else
				iter_6_1.buffs[iter_6_2]:doClean()
			end
		end
	end

	for iter_6_3 = 1, 2 do
		local var_6_4 = true

		for iter_6_4, iter_6_5 in var_6_2:ipairs(iter_6_3) do
			if iter_6_5:isReal() then
				var_6_4 = var_6_4 and iter_6_5.exile
			end
		end

		if var_6_4 then
			for iter_6_6, iter_6_7 in var_6_2:ipairs(iter_6_3) do
				local var_6_5 = iter_6_7:exitExile()

				if var_6_5 then
					var_0_0.insert(var_6_1, var_6_5)
				end
			end
		end
	end

	if #var_6_1 > 0 then
		arg_6_1:executeSpRule(var_0_4.TYPE.BUFF_REMOVE, var_6_1)
		arg_6_1:executeKnightSpRule(var_0_4.TYPE.BUFF_REMOVE, var_6_1)
	end

	var_6_0.removeList = var_6_1

	for iter_6_8, iter_6_9 in arg_6_1:getKnights():ipairs() do
		iter_6_9:subBuffEffectTotalCount()
	end

	return var_6_0
end

function var_0_6:updateNotReady(arg_7_1)
	local var_7_0 = {}

	if not self.isPlayer then
		local var_7_1 = self:doBuffRound(var_0_2.ROUND.AFTER)

		var_7_0.removeList = var_7_1

		if #var_7_1 > 0 then
			arg_7_1:getBattleData():executeSpRule(var_0_4.TYPE.BUFF_REMOVE, var_7_1)
			arg_7_1:getBattleData():executeKnightSpRule(var_0_4.TYPE.BUFF_REMOVE, var_7_1)
		end
	end

	return var_7_0
end

return var_0_6
