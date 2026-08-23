local var_0_0 = {}
local var_0_1 = load("core.rule.BuffRule")
local var_0_2 = load("core.fight.FightTarget")
local var_0_3 = loadCfg("core.config.cfg.battle_extra_value_info")

function var_0_0:check()
	return var_0_0["_calcSkillAffect" .. self.affectType]
end

function var_0_0:_calcSkillAffect9()
	local var_2_0 = {}
	local var_2_1 = self.skillCfg or {}
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(self.victims) do
		if self.battleField:bingo(self.affectRate) then
			local var_2_3 = iter_2_1.victim:doBuff(var_0_1.TYPE.HIDE, false, {
				attacker = self.attacker,
				victim = iter_2_1.victim,
				skillType = var_2_1.skill_type
			})
			local var_2_4 = iter_2_1.victim:doBuff(var_0_1.TYPE.BUFF_IGNORE_HIDE, {
				isEff = false,
				damage = 0
			}, {
				attacker = self.attacker
			})

			if iter_2_1.victim.advanceInfo.INITIAL_ANGER > 0 and not ((var_2_4 and var_2_4.isEff or nil) and false) then
				table.insert(var_2_2, {
					reAnger = 0,
					target = iter_2_1,
					anger = iter_2_1.victim.advanceInfo.INITIAL_ANGER
				})
			end
		end
	end

	for iter_2_2 = 1, #var_2_2 - self.formulaValue1 do
		table.remove(var_2_2, self.battleField:boundedRandom(1, #var_2_2))
	end

	while 0 < self.formulaValue1 do
		local var_2_6 = false

		for iter_2_3, iter_2_4 in ipairs(var_2_2) do
			if self.formulaValue1 <= 0 then
				break
			end

			local var_2_7

			if iter_2_4.anger > 0 then
				iter_2_4.anger = iter_2_4.anger - 1
				iter_2_4.reAnger = iter_2_4.reAnger + 1
				var_2_6 = true
				var_2_7 = 0 + 1
			end
		end

		if not var_2_6 then
			break
		end
	end

	for iter_2_5, iter_2_6 in ipairs(var_2_2) do
		if iter_2_6.reAnger > 0 then
			table.insert(var_2_0, {
				affectType = 95,
				damage = iter_2_6.reAnger,
				addDamage = iter_2_6.reAnger,
				victim = iter_2_6.target.victim
			})
		end
	end

	return var_2_0
end

function var_0_0:_calcSkillAffect29()
	local var_3_0 = {}

	if self.attacker.isPlayer then
		return {}
	end

	local var_3_1 = self.formulaValue1
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(self.victims) do
		if self.battleField:bingo(self.affectRate) then
			local var_3_3 = 0

			for iter_3_2, iter_3_3 in ipairs((iter_3_1.victim:getBuffs())) do
				if iter_3_3.buffCfg.buff_type == var_0_1.TYPE.ATTR and iter_3_3.buffCfg.buff_increase_type == 1 and #iter_3_3.subBuffs == 0 and not iter_3_3.buffCheckSkill and iter_3_3.buffCfg.not_clear == 0 then
					var_3_3 = var_3_3 + 1
				end
			end

			if var_3_3 > 0 then
				table.insert(var_3_2, {
					victim = iter_3_1.victim,
					buffNum = var_3_3
				})
			end
		end
	end

	if not next(var_3_2) then
		return {}
	end

	local var_3_4 = var_3_2
	local var_3_5 = {}
	local var_3_6 = {}
	local var_3_7 = {}

	for iter_3_4 = 1, var_3_1 do
		local var_3_8 = table.remove(var_3_4, (self.battleField:boundedRandom(1, #var_3_4)))

		var_3_8.buffNum = var_3_8.buffNum - 1

		if var_3_6[var_3_8.victim] then
			var_3_6[var_3_8.victim] = var_3_6[var_3_8.victim] + 1
		else
			table.insert(var_3_7, var_3_8.victim)

			var_3_6[var_3_8.victim] = 1
		end

		if var_3_8.buffNum > 0 then
			table.insert(var_3_5, var_3_8)
		end

		if not next(var_3_4) then
			if not next(var_3_5) then
				break
			end

			var_3_4 = var_3_5
			var_3_5 = {}
		end
	end

	for iter_3_5, iter_3_6 in ipairs(var_3_7) do
		if var_3_6[iter_3_6] and var_3_6[iter_3_6] > 0 then
			table.insert(var_3_0, {
				affectType = 29,
				damage = var_3_6[iter_3_6],
				addDamage = self.formulaValue2,
				addDamage2 = self.formulaValue3,
				victim = iter_3_6
			})
		end
	end

	return var_3_0
end

function var_0_0:_calcSkillAffect32()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((self.attacker:getBuffs())) do
		if iter_4_1.buffCfg.buff_type == var_0_1.TYPE.ATTR and iter_4_1.buffCfg.buff_increase_type == 1 and #iter_4_1.subBuffs == 0 and not iter_4_1.buffCheckSkill and iter_4_1.buffCfg.not_clear == 0 and self.formulaValue3 >= iter_4_1.level then
			table.insert(var_4_0, iter_4_1)
		end
	end

	while self.formulaValue1 < #var_4_0 do
		table.remove(var_4_0, (self.battleField:boundedRandom(1, #var_4_0)))
	end

	local var_4_1 = {}

	for iter_4_2, iter_4_3 in ipairs(self.victims) do
		for iter_4_4, iter_4_5 in ipairs(var_4_0) do
			self.fightResult:addBuff({
				buffId = iter_4_5.buffCfg.id,
				buffTime = iter_4_5.buffTime + self.formulaValue2,
				victim = iter_4_3.victim,
				attacker = self.attacker
			})
		end

		table.insert(var_4_1, {
			affectType = 32,
			damage = self.formulaValue1,
			addDamage = self.formulaValue2,
			addDamage2 = self.formulaValue3,
			victim = iter_4_3.victim
		})
	end

	return var_4_1
end

function var_0_0:_calcSkillAffect33()
	local var_5_0 = self.battleData:getKnightList(3 - self.attacker.identity)

	if not next(var_5_0) then
		return {}
	end

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		table.insert(var_5_1, iter_5_1)
	end

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in ipairs(self.victims) do
		for iter_5_4, iter_5_5 in ipairs((iter_5_3.victim:getBuffs())) do
			if iter_5_5.buffCfg.buff_increase_type == 2 and #iter_5_5.subBuffs == 0 and not iter_5_5.buffCheckSkill and iter_5_5.buffCfg.not_clear == 0 and self.formulaValue2 >= iter_5_5.level then
				local var_5_3, var_5_4

				if not next(var_5_1) then
					for iter_5_6, iter_5_7 in ipairs(var_5_0) do
						table.insert(var_5_1, iter_5_7)
					end

					var_5_3 = var_5_1
					var_5_4 = {
						buffId = iter_5_5.buffCfg.id,
						buffTime = iter_5_5.buffTime + self.formulaValue1
					}
				end

				var_5_4.victim = table.remove(var_5_1, (self.battleField:boundedRandom(1, #var_5_1)))
				var_5_4.attacker = self.attacker

				self.fightResult:addBuff(var_5_4)
				self.fightResult:removeBuff(iter_5_5)
			end
		end

		table.insert(var_5_2, {
			affectType = 33,
			damage = self.formulaValue1,
			addDamage = self.formulaValue2,
			victim = iter_5_3.victim
		})
	end

	return var_5_2
end

function var_0_0:_calcSkillAffect43()
	local var_6_0 = self.formulaValue1 % 1000 - self.formulaValue1 % 10 + math.floor(self.formulaValue1 / 1000) * 1000
	local var_6_1 = self.formulaValue3 % 1000 - self.formulaValue3 % 10 + math.floor(self.formulaValue3 / 1000) * 1000
	local var_6_2 = {}
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in ipairs(self.victims) do
		if self.battleField:bingo(var_6_0) and iter_6_1.victim:canChangeAnger(false) then
			table.insert(var_6_2, {
				addDamage = 0,
				affectType = 3,
				damage = self.formulaValue1 % 10,
				victim = iter_6_1.victim
			})

			var_6_3[iter_6_1.victim.serialId] = true
		end
	end

	for iter_6_2, iter_6_3 in ipairs((var_0_2.getVictimTargets({
		range = self.formulaValue2,
		attacker = self.attacker,
		battleData = self.battleField:getBattleData(),
		battleField = self.battleField,
		targets = {
			self.victims
		}
	}))) do
		if self.battleField:bingo(var_6_1) and iter_6_3.victim:canChangeAnger(false) then
			table.insert(var_6_2, {
				addDamage = 0,
				affectType = 3,
				damage = self.formulaValue3 % 10,
				victim = iter_6_3.victim
			})
		end
	end

	return var_6_2
end

function var_0_0:_calcSkillAffect53()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(self.victims) do
		if iter_7_1.victim:getBuffCount(self.formulaValue1) > 0 then
			var_7_0 = var_7_0 + 1
		end
	end

	local var_7_1 = {}
	local var_7_2 = math.min(var_7_0 * self.formulaValue2, self.formulaValue3)

	if var_7_2 > 0 then
		table.insert(var_7_1, {
			addDamage = 0,
			affectType = 4,
			damage = var_7_2,
			victim = self.attacker
		})
	end

	return var_7_1
end

function var_0_0:_calcSkillAffect70()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.victims) do
		if iter_8_1.victim.advanceInfo.INITIAL_ANGER > 0 then
			table.insert(var_8_0, iter_8_1.victim)
		end
	end

	local var_8_1 = {}
	local var_8_2 = self.attacker:getMarkLevel(self.formulaValue1)

	if var_8_2 == 0 or #var_8_0 == 0 then
		return var_8_1
	end

	if var_8_2 < #var_8_0 then
		for iter_8_2, iter_8_3 in ipairs(var_8_0) do
			var_8_2 = var_8_2 - 1

			table.insert(var_8_1, {
				affectType = 3,
				damage = 1,
				victim = iter_8_3
			})

			if var_8_2 <= 0 then
				break
			end
		end
	else
		while not false do
			local var_8_3 = false
			local var_8_4 = true

			for iter_8_4, iter_8_5 in ipairs(var_8_0) do
				var_8_1[iter_8_4] = var_8_1[iter_8_4] or {
					affectType = 3,
					damage = 0,
					victim = iter_8_5
				}

				if var_8_1[iter_8_4].damage + 1 <= iter_8_5.advanceInfo.INITIAL_ANGER then
					var_8_1[iter_8_4].damage = var_8_1[iter_8_4].damage + 1
					var_8_2 = var_8_2 - 1
					var_8_4 = false
				end

				if var_8_2 <= 0 then
					var_8_3 = true

					break
				end
			end

			if var_8_4 then
				var_8_3 = true
			end
		end
	end

	return var_8_1
end

function var_0_0:_calcSkillAffect73()
	for iter_9_0, iter_9_1 in ipairs(self.victims) do
		if iter_9_1.victim:getBuffCount(self.formulaValue1) > 0 then
			self.fightResult:addBuff({
				buffId = self.formulaValue2,
				buffTime = self.formulaValue3,
				victim = self.attacker,
				attacker = self.attacker
			})
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect74()
	local var_10_0 = var_0_3.get(self.formulaValue1, 1)
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(self.victims) do
		if iter_10_1.victim:getBuffCount(var_10_0.value_1) > 0 then
			var_10_1 = var_10_1 + 1
		end
	end

	return {
		{
			damage = (math.floor(self.attacker.advanceInfo.totalAtk * var_10_0.value_2 / 1000) + math.floor(self.attacker.originInfo.INITIAL_HP * var_10_0.value_3 / 1000)) * var_10_1,
			affectType = var_10_0.value_4,
			victim = self.attacker
		}
	}
end

function var_0_0:_calcSkillAffect84()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self.victims) do
		if iter_11_1.victim:getBuffCount(self.formulaValue1) > 0 then
			var_11_0 = var_11_0 + 1
		end
	end

	return {
		{
			addDamage = 0,
			affectType = 4,
			damage = var_11_0 * self.formulaValue2,
			victim = self.attacker
		}
	}
end

function var_0_0:_calcSkillAffect88()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs((self.battleData:getKnightList(self.attacker.identity))) do
		var_12_0 = var_12_0 + iter_12_1:getBuffCount(self.formulaValue1, false, true)
	end

	if var_12_0 > 0 then
		for iter_12_2 = 1, var_12_0 do
			self.fightResult:addBuff({
				buffId = self.formulaValue2,
				buffTime = self.formulaValue3,
				victim = self.attacker,
				attacker = self.attacker
			})
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect91()
	self.battleData:addBuffEffectTime(self.victims[1].victim.identity, self.formulaValue1, self.formulaValue2)

	for iter_13_0, iter_13_1 in ipairs(self.victims) do
		self.fightResult:addBuff({
			buffId = self.formulaValue1,
			buffTime = self.formulaValue2,
			victim = iter_13_1.victim,
			attacker = self.attacker
		})
	end

	return {}
end

function var_0_0:_calcSkillAffect96()
	local var_14_0 = var_0_3.get(self.formulaValue1, 1)
	local var_14_1 = {
		var_14_0.value_1,
		var_14_0.value_2,
		var_14_0.value_3
	}

	if #self.victims <= 3 then
		for iter_14_0, iter_14_1 in ipairs(self.victims) do
			self.fightResult:addBuff({
				buffId = var_14_1[iter_14_0],
				buffTime = var_14_0.value_4,
				victim = iter_14_1.victim,
				attacker = self.attacker
			})
		end
	else
		local var_14_2 = {}

		for iter_14_2, iter_14_3 in ipairs(self.victims) do
			table.insert(var_14_2, iter_14_2)
		end

		for iter_14_4 = 1, #var_14_2 - 3 do
			table.remove(var_14_2, self.battleField:boundedRandom(1, #var_14_2))
		end

		for iter_14_5, iter_14_6 in ipairs(var_14_2) do
			self.fightResult:addBuff({
				buffId = var_14_1[iter_14_5],
				buffTime = var_14_0.value_4,
				victim = self.victims[iter_14_6].victim,
				attacker = self.attacker
			})
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect97()
	local var_15_0 = {
		[230] = false,
		[232] = false,
		[231] = false
	}
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(self.victims) do
		for iter_15_2, iter_15_3 in pairs(var_15_0) do
			if not iter_15_3 and iter_15_1.victim:getBuffCount(iter_15_2, true) > 0 then
				var_15_0[iter_15_0] = true
				var_15_1 = var_15_1 + 1
			end
		end
	end

	local var_15_2 = {}
	local var_15_3 = math.floor(var_15_1 * self.formulaValue1 * self.attacker.originInfo.INITIAL_HP / 1000)

	table.insert(var_15_2, {
		affectType = 2,
		damage = var_15_3,
		victim = self.attacker
	})
	table.insert(var_15_2, {
		affectType = 15,
		damage = var_15_3,
		victim = self.attacker
	})

	return var_15_2
end

function var_0_0:_calcSkillAffect110()
	local var_16_0 = self.victims or {}
	local var_16_1 = self.battleField
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if self.formulaValue2 <= 0 then
			break
		end

		local var_16_4

		if iter_16_0 == #var_16_0 then
			table.insert(var_16_2, {
				affectType = 16,
				damage = self.formulaValue1,
				addDamage = self.formulaValue2,
				victim = var_16_0[iter_16_0].victim
			})
		else
			local var_16_3 = var_16_1:boundedRandom(0, self.formulaValue2)

			table.insert(var_16_2, {
				affectType = 16,
				damage = self.formulaValue1,
				addDamage = var_16_3,
				victim = var_16_0[iter_16_0].victim
			})

			var_16_4 = self.formulaValue2 - var_16_3
		end
	end

	return var_16_2
end

function var_0_0:_calcSkillAffect113()
	local var_17_0 = self.battleField:getBattleData():getBuff267TotalDamage(self.attacker.identity)

	if var_17_0 == 0 then
		return {}
	end

	local var_17_1 = math.floor(math.floor(var_17_0 * self.formulaValue1 / 1000) / (#self.victims or {}))
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(self.victims) do
		table.insert(var_17_2, {
			affectType = 1,
			damage = var_17_1,
			victim = iter_17_1.victim
		})
		self.battleField:getBattleData():subBuff267TotalDamage(self.attacker.identity, var_17_1)
		self.battleField:getBattleData():debugChangeBuff267DamageValue(self.battleField:getAttackCount(), self.attacker, iter_17_1.victim, -var_17_1)
	end

	return var_17_2
end

function var_0_0:_calcSkillAffect116()
	local var_18_0 = {}
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in ipairs(self.victims) do
		if iter_18_1.victim:canChangeAnger(false) then
			local var_18_2 = math.min(iter_18_1.victim.advanceInfo.INITIAL_ANGER, self.formulaValue1)

			var_18_1 = var_18_1 + var_18_2

			table.insert(var_18_0, {
				affectType = 3,
				suckAnger = true,
				damage = var_18_2,
				victim = iter_18_1.victim
			})
		end
	end

	if self.formulaValue2 <= var_18_1 then
		table.insert(var_18_0, {
			affectType = 18,
			damage = self.formulaValue3,
			victim = self.attacker
		})
	end

	if self.attacker:canChangeAnger(true) and var_18_1 > 0 then
		table.insert(var_18_0, {
			affectType = 4,
			damage = var_18_1,
			victim = self.attacker
		})
	end

	return var_18_0
end

function var_0_0:_calcSkillAffect118()
	if self.formulaValue2 > self.attacker:getMarkLevel(self.formulaValue1) then
		return {}
	end

	local var_19_1 = math.floor(((self.skillResults[#self.skillResults] or {}).damage or 0) * self.formulaValue3 / 1000)
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in ipairs(self.victims) do
		table.insert(var_19_2, {
			affectType = 1,
			damage = var_19_1,
			victim = iter_19_1.victim
		})
	end

	return var_19_2
end

function var_0_0:_calcSkillAffect122()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self.victims) do
		local var_20_1 = iter_20_1.victim:doBuff(var_0_1.TYPE.COMBUSTIBLE_ASH, {
			damage = 0,
			isAffect = false
		}, {
			isClear = true
		})

		if var_20_1.isAffect then
			table.insert(var_20_0, {
				affectType = 1,
				damage = iter_20_1.victim:doBuff(var_0_1.TYPE.BUFF_DAMAGE_CHANGE, var_20_1.damage, {
					type = 290,
					damage = var_20_1.damage
				}),
				victim = iter_20_1.victim
			})

			for iter_20_2, iter_20_3 in ipairs((self.battleData:getNearKnightList(iter_20_1.victim))) do
				table.insert(var_20_0, {
					affectType = 1,
					damage = iter_20_3:doBuff(var_0_1.TYPE.BUFF_DAMAGE_CHANGE, var_20_1.damage, {
						type = 290,
						damage = var_20_1.damage
					}),
					victim = iter_20_3
				})
			end

			if self.formulaValue1 ~= 0 then
				self.fightResult:addBuff({
					buffId = self.formulaValue1,
					buffTime = self.formulaValue2,
					victim = iter_20_1.victim,
					attacker = self.attacker
				})
			end
		end
	end

	return var_20_0
end

function var_0_0:_calcSkillAffect123()
	local var_21_0 = self.attacker

	local function var_21_1(arg_22_0, arg_22_1)
		local var_22_0 = self.battleData:getKnightByIdAndPos(3 - arg_22_0, arg_22_1)

		if not var_22_0 or not var_22_0:isValid(var_21_0) then
			var_22_0 = self.battleData:getNearKnight(3 - arg_22_0, arg_22_1, var_21_0)
		end

		return var_22_0
	end

	for iter_21_0, iter_21_1 in ipairs(self.victims) do
		local var_21_2 = 0

		for iter_21_2, iter_21_3 in ipairs(iter_21_1.victim:getBuffs()) do
			if iter_21_3:canClear() and iter_21_3.buffCfg.buff_type == self.formulaValue2 and iter_21_3.buffCfg.buff_increase_type == self.formulaValue3 and var_21_1(iter_21_1.victim.identity, iter_21_1.victim.originInfo.pos) then
				self.fightResult:addBuff({
					buffId = iter_21_3.buffCfg.id,
					buffTime = iter_21_3.buffTime,
					victim = var_21_1(iter_21_1.victim.identity, iter_21_1.victim.originInfo.pos),
					attacker = self.attacker
				})

				iter_21_3.isDone = true
				var_21_2 = var_21_2 + 1
			end

			if self.formulaValue1 <= var_21_2 then
				break
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect127()
	local var_23_0 = self.attacker:doBuff(var_0_1.TYPE.RECORD_CONTROL_BUFF, {
		recordList = {}
	}, {
		isGet = true
	}).recordList or {}

	if #var_23_0 > 0 then
		if self.formulaValue1 == 0 then
			for iter_23_0, iter_23_1 in ipairs(self.victims) do
				for iter_23_2, iter_23_3 in ipairs(var_23_0) do
					self.fightResult:addBuff({
						buffId = iter_23_3.id,
						buffTime = iter_23_3.buffTime,
						attacker = self.attacker,
						victim = iter_23_1.victim
					})
				end
			end
		elseif self.formulaValue1 == 1 then
			local var_23_1 = 1

			for iter_23_4, iter_23_5 in ipairs(var_23_0) do
				local var_23_2

				if var_23_1 > #self.victims then
					var_23_1 = 1
					var_23_1 = var_23_1 + 1
					var_23_2 = {
						buffId = iter_23_5.id,
						buffTime = iter_23_5.buffTime,
						attacker = self.attacker
					}
				end

				var_23_2.victim = self.victims[var_23_1].victim

				self.fightResult:addBuff(var_23_2)
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect130()
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(self.victims) do
		local var_24_1 = math.min(self.formulaValue1, iter_24_1.victim.advanceInfo.INITIAL_ANGER)

		var_24_0 = var_24_0 + var_24_1

		self.fightResult:addAttackEffect({
			effect_type = 3,
			effect_value = var_24_1,
			attacker = self.attacker,
			victim = iter_24_1.victim
		})
	end

	local var_24_2 = math.min(math.floor(var_24_0 * self.formulaValue2 * 0.001 * self.attacker.advanceInfo.ATTACK), self.attacker.baseInfo.INITIAL_HP * self.formulaValue3 * 0.001)
	local var_24_3 = {}

	for iter_24_2, iter_24_3 in ipairs(self.victims) do
		table.insert(var_24_3, {
			affectType = 1,
			damage = var_24_2,
			victim = iter_24_3.victim
		})
	end

	return var_24_3
end

function var_0_0:_calcSkillAffect133()
	local var_25_1 = math.floor(self.attacker.baseInfo.INITIAL_HP * self.formulaValue1 * 0.001 * #(self.targets[1] or {}))

	if self.formulaValue2 == 0 then
		for iter_25_0, iter_25_1 in ipairs(self.victims) do
			self.fightResult:addAttackEffect({
				effect_type = 2,
				effect_value = var_25_1,
				attacker = self.attacker,
				victim = iter_25_1.victim
			})
		end
	elseif self.formulaValue2 == 1 then
		for iter_25_2, iter_25_3 in ipairs(self.victims) do
			self.fightResult:addAttackEffect({
				effect_type = 15,
				effect_value = var_25_1,
				attacker = self.attacker,
				victim = iter_25_3.victim
			})
		end
	elseif self.formulaValue2 == 2 then
		for iter_25_4, iter_25_5 in ipairs(self.victims) do
			self.fightResult:addAttackEffect({
				effect_type = 2,
				effect_value = var_25_1,
				attacker = self.attacker,
				victim = iter_25_5.victim
			})
			self.fightResult:addAttackEffect({
				effect_type = 15,
				effect_value = var_25_1,
				attacker = self.attacker,
				victim = iter_25_5.victim
			})
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect134()
	local var_26_0, var_26_1

	if self.attacker.isPlayer then
		do return {} end

		var_26_0 = math.floor(self.attacker.originInfo.ATTACK * self.formulaValue2 * 0.001)
		var_26_1 = 0
	end

	for iter_26_0, iter_26_1 in ipairs(self.victims) do
		local var_26_2 = math.min(math.floor(iter_26_1.victim.advanceInfo.SHIELD * self.formulaValue1 * 0.001), var_26_0)

		var_26_1 = var_26_1 + var_26_2

		self.fightResult:addAttackEffect({
			effect_type = 100,
			effect_value = var_26_2,
			attacker = self.attacker,
			victim = iter_26_1.victim
		})
	end

	if self.formulaValue3 == 0 then
		local var_26_3 = self.battleData:getNearKnightList(self.attacker)

		table.insert(var_26_3, self.attacker)

		local var_26_4 = math.floor(var_26_1 / #var_26_3)

		for iter_26_2, iter_26_3 in ipairs(var_26_3) do
			self.fightResult:addAttackEffect({
				effect_type = 15,
				effect_value = var_26_4,
				attacker = self.attacker,
				victim = iter_26_3
			})
		end
	elseif self.formulaValue3 == 1 then
		local var_26_5 = self.battleData:getNearKnightList(self.attacker)

		table.insert(var_26_5, self.attacker)

		for iter_26_4, iter_26_5 in ipairs(var_26_5) do
			self.fightResult:addAttackEffect({
				effect_type = 15,
				effect_value = var_26_1,
				attacker = self.attacker,
				victim = iter_26_5
			})
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect136()
	local var_27_0, var_27_1

	if self.attacker.isPlayer then
		do return {} end

		var_27_0 = 0
		var_27_1 = 0
	end

	for iter_27_0, iter_27_1 in ipairs(self.victims) do
		local var_27_2 = math.min(self.formulaValue2, iter_27_1.victim.advanceInfo.INITIAL_ANGER)

		var_27_0 = var_27_0 + var_27_2

		self.fightResult:addAttackEffect({
			effect_type = 3,
			effect_value = var_27_2,
			attacker = self.attacker,
			victim = iter_27_1.victim
		})

		local var_27_3 = math.min(self.formulaValue1, iter_27_1.victim.advanceInfo.INITIAL_ENERGY)

		var_27_1 = var_27_1 + var_27_3

		self.fightResult:addAttackEffect({
			effect_type = 12,
			effect_value = var_27_3,
			attacker = self.attacker,
			victim = iter_27_1.victim
		})
	end

	self.fightResult:addAttackEffect({
		effect_type = 4,
		effect_value = var_27_0,
		attacker = self.attacker,
		victim = self.attacker
	})
	self.fightResult:addAttackEffect({
		effect_type = 13,
		effect_value = var_27_1,
		attacker = self.attacker,
		victim = self.attacker
	})

	return {}
end

function var_0_0:_calcSkillAffect137()
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(self.victims) do
		local var_28_1 = math.min(self.formulaValue1, iter_28_1.victim.advanceInfo.INITIAL_ENERGY)

		var_28_0 = var_28_0 + var_28_1

		self.fightResult:addAttackEffect({
			effect_type = 12,
			effect_value = var_28_1,
			attacker = self.attacker,
			victim = iter_28_1.victim
		})
	end

	if self.formulaValue2 <= var_28_0 then
		local var_28_2 = math.floor(var_28_0 / self.formulaValue2) * self.formulaValue3

		for iter_28_2, iter_28_3 in ipairs((self.battleData:getKnightList(1))) do
			self.fightResult:addAttackEffect({
				effect_type = 13,
				effect_value = var_28_2,
				attacker = self.attacker,
				victim = iter_28_3
			})
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect138()
	local var_29_0 = self.fightResult
	local var_29_1 = self.formulaValue1
	local var_29_2 = self.formulaValue2
	local var_29_4 = (self.attacker.isPlayer and self.attacker.baseInfo.COMBO_ATTACK or self.attacker.advanceInfo.ATTACK) * self.formulaValue3 * 0.001

	for iter_29_0, iter_29_1 in ipairs(self.victims) do
		local var_29_5 = math.min(math.floor(iter_29_1.victim.advanceInfo.SHIELD * var_29_1 * 0.001), var_29_4)

		var_29_0:addAttackEffect({
			effect_type = 100,
			effect_value = var_29_5,
			attacker = self.attacker,
			victim = iter_29_1.victim
		})
		var_29_0:addAttackEffect({
			effect_type = 1,
			effect_value = math.floor(var_29_5 * var_29_2 * 0.001),
			attacker = self.attacker,
			victim = iter_29_1.victim
		})
	end

	return {}
end

function var_0_0:_calcSkillAffect139()
	for iter_30_0, iter_30_1 in ipairs(self.victims) do
		local var_30_2 = {}

		for iter_30_2, iter_30_3 in ipairs((iter_30_1.victim:getBuffs())) do
			if iter_30_3.buffCfg.buff_attribute_type == 0 and iter_30_3.buffCfg.buff_increase_type == 1 and self.formulaValue3 > iter_30_3.buffTime then
				table.insert(var_30_2, iter_30_3)
			end
		end

		while self.formulaValue1 < #var_30_2 do
			table.remove(var_30_2, (self.battleField:boundedRandom(1, #var_30_2)))
		end

		for iter_30_4, iter_30_5 in ipairs(var_30_2) do
			iter_30_5:addBuffTime(self.formulaValue2)
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect140()
	local var_31_0 = math.floor(self.attacker.advanceInfo.totalAtk * self.formulaValue2 * 0.001)
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in ipairs(self.victims) do
		local var_31_2 = math.min(var_31_0, math.floor(iter_31_1.victim.originInfo.INITIAL_HP * self.formulaValue1 * 0.001))

		var_31_1 = var_31_1 + var_31_2

		self.fightResult:addAttackEffect({
			effect_type = 1,
			effect_value = var_31_2,
			attacker = self.attacker,
			victim = iter_31_1.victim
		})
	end

	self.fightResult:addAttackEffect({
		effect_type = 15,
		effect_value = var_31_1,
		attacker = self.attacker,
		victim = self.attacker
	})

	return {}
end

function var_0_0:_calcSkillAffect141()
	local var_32_1 = 0
	local var_32_2 = self.battleData:getKnightList(self.attacker.identity, true)

	for iter_32_0, iter_32_1 in ipairs(var_32_2) do
		var_32_1 = var_32_1 + iter_32_1.originInfo.INITIAL_HP
	end

	local var_32_3 = math.floor(math.floor(var_32_1 / #var_32_2) * self.formulaValue2 * 0.001)
	local var_32_4 = 0

	for iter_32_2, iter_32_3 in ipairs(self.victims) do
		if iter_32_3.victim.baseInfo.SHIELD > 0 then
			local var_32_5 = math.floor(iter_32_3.victim.baseInfo.SHIELD * self.formulaValue1 * 0.001)

			if var_32_5 < var_32_3 then
				self.fightResult:addAttackEffect({
					effect_type = 100,
					effect_value = var_32_5,
					attacker = self.attacker,
					victim = iter_32_3.victim
				})

				var_32_4 = var_32_4 + var_32_5
				var_32_3 = var_32_3 - var_32_5
			else
				local var_32_6 = var_32_3

				self.fightResult:addAttackEffect({
					effect_type = 100,
					effect_value = var_32_3,
					attacker = self.attacker,
					victim = iter_32_3.victim
				})

				var_32_4 = var_32_4 + var_32_6

				break
			end
		end
	end

	local var_32_7 = self.battleData:getKnightList(self.attacker.identity)
	local var_32_8 = math.floor(var_32_4 / #var_32_7)

	for iter_32_4, iter_32_5 in ipairs(var_32_7) do
		self.fightResult:addAttackEffect({
			effect_type = 15,
			effect_value = var_32_8,
			attacker = self.attacker,
			victim = iter_32_5
		})
	end

	return {}
end

function var_0_0:_calcSkillAffect142()
	local var_33_0 = self.victims
	local var_33_1 = self.fightResult
	local var_33_2 = self.formulaValue1
	local var_33_3 = self.formulaValue2
	local var_33_4 = self.formulaValue3
	local var_33_5 = 0

	var_33_5 = self.attacker.isPlayer and self.attacker.baseInfo.COMBO_ATTACK or self.attacker.advanceInfo.ATTACK

	local var_33_6 = 0

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		if iter_33_1.victim.baseInfo.SHIELD > 0 then
			var_33_6 = var_33_6 + iter_33_1.victim.baseInfo.SHIELD
		end
	end

	local var_33_7 = math.min(math.floor(var_33_5 * 0.001 * var_33_2) + math.floor(var_33_6 * 0.001 * var_33_3), math.floor(var_33_5 * var_33_4 * 0.001))

	for iter_33_2, iter_33_3 in ipairs(var_33_0) do
		if iter_33_3.victim.baseInfo.SHIELD > 0 then
			if var_33_7 > iter_33_3.victim.baseInfo.SHIELD then
				var_33_7 = var_33_7 - iter_33_3.victim.baseInfo.SHIELD

				var_33_1:addAttackEffect({
					effect_type = 100,
					effect_value = iter_33_3.victim.baseInfo.SHIELD,
					attacker = self.attacker,
					victim = iter_33_3.victim
				})
			else
				var_33_1:addAttackEffect({
					effect_type = 100,
					effect_value = var_33_7,
					attacker = self.attacker,
					victim = iter_33_3.victim
				})

				break
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect143()
	local var_34_0 = 0
	local var_34_1 = math.floor(self.formulaValue3 * 0.001 * self.attacker.advanceInfo.totalAtk)

	for iter_34_0, iter_34_1 in ipairs(self.victims) do
		var_34_0 = var_34_0 + math.min(var_34_1, math.floor(iter_34_1.victim.originInfo.INITIAL_HP * self.formulaValue1 * 0.001))
	end

	if self.formulaValue2 == 1 then
		var_34_0 = math.floor(var_34_0 / #self.victims)
	end

	self.fightResult:addAttackEffect({
		effect_type = 204,
		effect_value = var_34_0,
		attacker = self.attacker,
		victim = self.attacker
	})

	return {}
end

function var_0_0:_calcSkillAffect145()
	local var_35_0 = {}
	local var_35_1 = 0

	for iter_35_0, iter_35_1 in ipairs(self.victims) do
		local var_35_2 = math.min(iter_35_1.victim.advanceInfo.INITIAL_ENERGY, self.formulaValue1)

		var_35_1 = var_35_1 + var_35_2

		table.insert(var_35_0, {
			affectType = 12,
			damage = var_35_2,
			victim = iter_35_1.victim
		})
	end

	if self.formulaValue2 <= var_35_1 then
		table.insert(var_35_0, {
			affectType = 18,
			damage = self.formulaValue3,
			victim = self.attacker
		})
		table.insert(var_35_0, {
			affectType = 15,
			damage = math.floor(self.attacker.originInfo.INITIAL_HP * self.formulaValue3 * 0.001),
			victim = self.attacker
		})
	end

	return var_35_0
end

function var_0_0:_calcSkillAffect146()
	local var_36_1 = {}

	for iter_36_0, iter_36_1 in ipairs(self.victims) do
		local var_36_2 = iter_36_1.victim:doBuff(var_0_1.TYPE.BUFF_366, {
			recordValue = 0
		}, {
			isClear = true
		})

		if var_36_2.recordValue > 0 then
			table.insert(var_36_1, {
				affectType = 1,
				damage = math.floor(var_36_2.recordValue * self.formulaValue1 * 0.001),
				victim = iter_36_1.victim
			})
		end
	end

	return var_36_1
end

function var_0_0:_calcSkillAffect147()
	local var_37_3 = 0

	for iter_37_0, iter_37_1 in ipairs(self.victims) do
		for iter_37_2, iter_37_3 in ipairs((iter_37_1.victim:getBuffs())) do
			if iter_37_3.buffCfg.buff_type == var_0_1.TYPE.ATTR and iter_37_3.buffCfg.buff_increase_type == 1 then
				var_37_3 = var_37_3 + 1
				iter_37_3.isDone = true
			end

			if var_37_3 == self.formulaValue1 then
				break
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect148()
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs(self.victims) do
		for iter_38_2, iter_38_3 in ipairs(iter_38_1.victim:getBuffs()) do
			if iter_38_3.buffCfg.buff_type == var_0_1.TYPE.ATTR and iter_38_3.buffCfg.buff_increase_type == 1 then
				var_38_0 = var_38_0 + 1
				iter_38_3.isDone = true

				self.fightResult:addBuff({
					buffId = iter_38_3.buffCfg.id,
					buffTime = iter_38_3.buffTime,
					victim = self.attacker,
					attacker = self.attacker
				})
			end

			if var_38_0 == self.formulaValue1 then
				break
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect149()
	local var_39_0 = self.formulaValue1
	local var_39_1 = 0

	for iter_39_0, iter_39_1 in ipairs(self.victims) do
		for iter_39_2, iter_39_3 in ipairs((iter_39_1.victim:getBuffs())) do
			if (iter_39_3.buffCfg.buff_type == var_0_1.TYPE.ATTR or iter_39_3.buffCfg.buff_type == var_0_1.TYPE.ATTACK_DAMAGE_CHANGE or iter_39_3.buffCfg.buff_type == var_0_1.TYPE.HIT_DAMAGE_CHANGE) and iter_39_3.buffCfg.buff_increase_type == self.formulaValue2 then
				var_39_1 = var_39_1 + 1
				iter_39_3.isDone = true
			end

			if var_39_1 == var_39_0 then
				break
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect151()
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in ipairs(self.victims) do
		for iter_40_2, iter_40_3 in ipairs((iter_40_1.victim:getBuffs())) do
			if iter_40_3.buffCfg.buff_type == self.formulaValue1 then
				var_40_0 = var_40_0 + 1
				iter_40_3.isDone = true
			end

			if self.formulaValue2 <= var_40_0 then
				break
			end
		end
	end

	if var_40_0 <= 0 then
		for iter_40_4, iter_40_5 in ipairs((self.battleData:getKnightList(self.attacker.identity, nil, self.attacker))) do
			if iter_40_5:getBuffCount(1483) > 0 then
				local var_40_1 = math.floor(iter_40_5.originInfo.INITIAL_HP * self.formulaValue3 * 0.001)

				self.fightResult:addAttackEffect({
					effect_type = 2,
					effect_value = var_40_1,
					attacker = self.attacker,
					victim = iter_40_5
				})
				self.fightResult:addAttackEffect({
					effect_type = 15,
					effect_value = var_40_1,
					attacker = self.attacker,
					victim = iter_40_5
				})
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect154()
	local var_41_2 = {}
	local var_41_3 = 0
	local var_41_4 = 0

	for iter_41_0, iter_41_1 in ipairs(self.victims) do
		local var_41_5 = math.min(iter_41_1.victim.advanceInfo.INITIAL_ENERGY, self.formulaValue1)
		local var_41_6 = math.min(iter_41_1.victim.advanceInfo.INITIAL_ANGER, self.formulaValue1)

		var_41_4 = var_41_4 + var_41_5
		var_41_3 = var_41_3 + var_41_6

		table.insert(var_41_2, {
			affectType = 12,
			damage = var_41_5,
			victim = iter_41_1.victim
		})
		table.insert(var_41_2, {
			affectType = 3,
			damage = var_41_6,
			victim = iter_41_1.victim
		})
	end

	local var_41_7 = self.battleData:getKnightList(self.attacker.identity, nil, self.attacker)
	local var_41_8 = math.floor(var_41_3 / #var_41_7)
	local var_41_9 = math.floor(var_41_4 / #var_41_7)

	for iter_41_2, iter_41_3 in ipairs(var_41_7) do
		if var_41_9 > 0 then
			table.insert(var_41_2, {
				affectType = 13,
				damage = var_41_9,
				victim = iter_41_3
			})
		end

		if var_41_8 > 0 then
			table.insert(var_41_2, {
				affectType = 4,
				damage = var_41_8,
				victim = iter_41_3
			})
		end
	end

	return var_41_2
end

function var_0_0:_calcSkillAffect155()
	local var_42_0 = self.formulaValue1
	local var_42_1

	if not self.attacker.isPlayer and self.attacker:getBuffCount(2034) > 0 then
		var_42_0 = var_42_0 + self.formulaValue2
		var_42_1 = {}
	end

	local var_42_2 = math.floor(self.battleData:getComboInfo(self.attacker.identity).advanceInfo.COMBO_ATTACK * self.formulaValue3 * 0.001)
	local var_42_3 = 0

	for iter_42_0, iter_42_1 in ipairs(self.victims) do
		local var_42_4 = math.min(math.min(math.floor(iter_42_1.victim.advanceInfo.INITIAL_HP * var_42_0 * 0.001), var_42_2), iter_42_1.victim.advanceInfo.SHIELD)

		table.insert(var_42_1, {
			affectType = 1,
			damage = var_42_4,
			victim = iter_42_1.victim
		})

		var_42_3 = var_42_3 + var_42_4
	end

	if var_42_3 > 0 then
		for iter_42_2, iter_42_3 in ipairs((self.battleData:getKnightList(self.attacker.identity, nil, self.attacker))) do
			if iter_42_3.serialId == self.attacker.serialId or iter_42_3:getBuffCount(2033) > 0 then
				table.insert(var_42_1, {
					affectType = 15,
					damage = var_42_3,
					victim = iter_42_3
				})
			end
		end
	end

	return var_42_1
end

function var_0_0:_calcSkillAffect170()
	local var_43_0 = 0

	for iter_43_0, iter_43_1 in ipairs(self.victims) do
		if not iter_43_1.victim.isPlayer and iter_43_1.victim:getBuffCount(2202) > 0 then
			var_43_0 = var_43_0 + iter_43_1.victim:getBuffCount(2202)
		end
	end

	local var_43_1 = self.formulaValue1

	if var_43_0 >= 4 then
		var_43_1 = self.formulaValue2
	end

	local var_43_2 = {}

	for iter_43_2, iter_43_3 in ipairs(self.victims) do
		self.fightResult:addBuff({
			buffId = var_43_1,
			buffTime = self.formulaValue3,
			victim = iter_43_3.victim,
			attacker = self.attacker
		})
	end

	return var_43_2
end

function var_0_0:_calcSkillAffect171()
	local var_44_0 = {}
	local var_44_1 = loadCfg("core.config.cfg.buff_gather_info")

	for iter_44_0 = 1, var_44_1.getLength() do
		local var_44_2 = var_44_1.indexOf(iter_44_0)

		if var_44_2.buff_gather == self.formulaValue3 then
			table.insert(var_44_0, var_44_2)
		end
	end

	for iter_44_1, iter_44_2 in ipairs(self.victims) do
		local var_44_3 = iter_44_2.victim:getKnightTempValue("AFFECT_171_BUFF_NUM") or 0

		if var_44_3 < self.formulaValue1 then
			self.fightResult:addBuff({
				buffId = var_44_0[self.battleField:boundedRandom(1, #var_44_0)].gather_buffid,
				buffTime = self.formulaValue2,
				victim = iter_44_2.victim,
				attacker = self.attacker
			})
			iter_44_2.victim:setKnightTempValue("AFFECT_171_BUFF_NUM", var_44_3 + 1)
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect172()
	for iter_45_0, iter_45_1 in ipairs(self.victims) do
		local var_45_0 = {}

		for iter_45_2 = #iter_45_1.victim.buffs, 1, -1 do
			if iter_45_1.victim.buffs[iter_45_2].buffCfg.buff_effect_type == self.formulaValue1 then
				table.insert(var_45_0, iter_45_1.victim.buffs[iter_45_2])
			end
		end

		if #var_45_0 > 0 then
			table.sort(var_45_0, function(arg_46_0, arg_46_1)
				if arg_46_0.buffTime ~= arg_46_1.buffTime then
					return arg_46_0.buffTime > arg_46_1.buffTime
				end

				return false
			end)

			local var_45_1 = {}

			if iter_45_1.victim.originInfo.pos ~= 4 then
				var_45_1[#var_45_1 + 1] = iter_45_1.victim.originInfo.pos - 1
			end

			var_45_1[#var_45_1 + 1] = iter_45_1.victim.originInfo.pos + 3

			if iter_45_1.victim.originInfo.pos ~= 3 then
				var_45_1[#var_45_1 + 1] = iter_45_1.victim.originInfo.pos + 1
			end

			var_45_1[#var_45_1 + 1] = iter_45_1.victim.originInfo.pos - 3

			local var_45_2 = self.battleField:getBattleData():getKnights()

			for iter_45_3 = 1, #var_45_1 do
				local var_45_3 = var_45_2:getKnightByIdAndPos(iter_45_1.victim.identity, var_45_1[iter_45_3])

				if var_45_3 then
					for iter_45_4, iter_45_5 in ipairs(var_45_0) do
						if self.formulaValue2 < 1 then
							break
						end

						self.fightResult:addBuff({
							buffId = iter_45_5.buffCfg.id,
							buffTime = iter_45_5.buffTime,
							victim = var_45_3,
							attacker = self.attacker,
							buffCheck = iter_45_5.buffCheckSkill
						})
					end
				end
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect180()
	local var_47_4 = {}
	local var_47_6 = self.battleField:getBattleData():getBuff648TotalDamage(self.attacker.identity)

	for iter_47_0, iter_47_1 in ipairs(self.victims) do
		table.insert(var_47_4, {
			affectType = 1,
			damage = math.floor(var_47_6 / #self.victims),
			victim = iter_47_1.victim
		})
	end

	self.battleField:getBattleData():setBuff648TotalDamage(self.attacker.identity, 0)

	return var_47_4
end

function var_0_0:_calcSkillAffect181()
	local var_48_2 = {}
	local var_48_3 = 0

	for iter_48_0, iter_48_1 in ipairs(self.victims) do
		var_48_3 = var_48_3 + iter_48_1.victim:getBuffCount(self.formulaValue2)
	end

	local var_48_4 = math.floor(self.attacker.originInfo.INITIAL_HP * self.formulaValue3 * 0.001 * var_48_3)

	for iter_48_2, iter_48_3 in ipairs(self.victims) do
		table.insert(var_48_2, {
			affectType = 2,
			damage = var_48_4,
			victim = iter_48_3.victim
		})
	end

	return var_48_2
end

function var_0_0:_calcSkillAffect182()
	local var_49_0 = {}

	if not next(self.victims) then
		return var_49_0
	end

	local var_49_1 = {}
	local var_49_2 = {}
	local var_49_3 = {}

	for iter_49_0, iter_49_1 in ipairs(self.victims) do
		table.insert(var_49_1, iter_49_1.victim)

		var_49_2[iter_49_1.victim] = iter_49_1.victim:getBuffCount(10001)
		var_49_3[iter_49_1.victim] = 0
	end

	for iter_49_2 = 1, self.formulaValue3 do
		local var_49_4 = math.huge

		for iter_49_3, iter_49_4 in ipairs(var_49_1) do
			if var_49_4 > var_49_2[iter_49_4] then
				var_49_4 = var_49_2[iter_49_4]
			end
		end

		local var_49_5 = {}

		for iter_49_5, iter_49_6 in ipairs(var_49_1) do
			if var_49_2[iter_49_6] == var_49_4 then
				table.insert(var_49_5, iter_49_6)
			end
		end

		local var_49_6 = var_49_5[self.battleField:boundedRandom(1, #var_49_5)]

		var_49_2[var_49_6] = var_49_2[var_49_6] + 1
		var_49_3[var_49_6] = var_49_3[var_49_6] + 1
	end

	for iter_49_7, iter_49_8 in ipairs(var_49_1) do
		for iter_49_9 = 1, var_49_3[iter_49_8] do
			self.fightResult:addBuff({
				buffId = self.formulaValue1,
				buffTime = self.formulaValue2,
				victim = iter_49_8,
				attacker = self.attacker
			})
		end
	end

	return var_49_0
end

function var_0_0:_calcSkillAffect183()
	local var_50_1 = {}

	if not next(self.victims) then
		return var_50_1
	end

	local var_50_2 = 0

	for iter_50_0, iter_50_1 in ipairs(self.victims) do
		var_50_2 = var_50_2 + iter_50_1.victim:getBuffCount(self.formulaValue1)
	end

	if self.formulaValue2 <= var_50_2 then
		self.battleField:getBattleData():addPassive({
			isSkill = true,
			knight = self.attacker,
			info = loadCfg("core.config.cfg.skill_info").get(self.formulaValue3),
			identity = self.attacker.identity
		})
	end

	return var_50_1
end

function var_0_0:_calcSkillAffect184()
	local var_51_1 = math.floor(((self.skillResults[#self.skillResults] or {}).damage or 0) * self.formulaValue1 / 1000)
	local var_51_2 = {}

	for iter_51_0, iter_51_1 in ipairs(self.victims) do
		table.insert(var_51_2, {
			affectType = 1,
			damage = var_51_1,
			victim = iter_51_1.victim
		})
	end

	return var_51_2
end

function var_0_0:_calcSkillAffect185()
	local var_52_0 = {}

	if not next(self.victims) then
		return var_52_0
	end

	local var_52_1 = self.attacker:getKnightTempValue("buff665_record") or 0

	if var_52_1 <= 0 then
		return var_52_0
	end

	local var_52_2 = math.floor(var_52_1 * self.formulaValue1 / 1000)

	if var_52_2 <= 0 then
		return var_52_0
	end

	self.attacker:setKnightTempValue("buff665_record", var_52_1 - var_52_2)

	local var_52_3 = math.floor(var_52_2 / #self.victims)

	for iter_52_0, iter_52_1 in ipairs(self.victims) do
		table.insert(var_52_0, {
			isSpAffect185 = true,
			affectType = 1,
			damage = var_52_3,
			victim = iter_52_1.victim
		})
	end

	return var_52_0
end

function var_0_0:_calcSkillAffect190()
	local var_53_0 = self.attacker
	local var_53_1 = self.battleField
	local var_53_2 = self.battleData
	local var_53_3 = var_0_3.get(self.formulaValue1, 1)

	if not var_53_3 then
		return {}
	end

	local var_53_4 = var_53_3.value_1
	local var_53_5 = {}

	for iter_53_0, iter_53_1 in ipairs(self.victims) do
		if iter_53_1.victim:getBuffCount(2550) > 0 then
			table.insert(var_53_5, iter_53_1.victim)
		end
	end

	local function var_53_6(arg_54_0)
		local var_54_0 = {}

		for iter_54_0, iter_54_1 in ipairs((var_53_2:getKnightList(3 - var_53_0.identity, nil, var_53_0))) do
			if iter_54_1.originInfo.pos > 3 then
				table.insert(var_54_0, iter_54_1)
			end
		end

		local var_54_1 = {}

		for iter_54_2 = 1, arg_54_0 do
			local var_54_2, var_54_3

			if #var_54_0 <= 0 then
				do break end

				var_54_2 = var_54_1
				var_54_3 = var_54_0
			end

			table.insert(var_54_1, table.remove(var_54_0, (var_53_1:boundedRandom(1, #var_54_0))))
		end

		return var_54_1
	end

	if #var_53_5 > 0 then
		local var_53_7 = {}

		for iter_53_2, iter_53_3 in ipairs(var_53_5) do
			table.insert(var_53_7, iter_53_3)
		end

		local var_53_8 = {}

		for iter_53_4 = 1, var_53_4 do
			local var_53_9, var_53_10

			if #var_53_7 <= 0 then
				do break end

				var_53_9 = var_53_8
				var_53_10 = var_53_7
			end

			table.insert(var_53_8, table.remove(var_53_7, (self.battleField:boundedRandom(1, #var_53_7))))
		end

		local var_53_11 = math.floor(self.attacker.originInfo.INITIAL_HP * var_53_3.value_2 / 1000)

		for iter_53_5, iter_53_6 in ipairs(var_53_8) do
			for iter_53_7, iter_53_8 in ipairs(iter_53_6:getBuffs()) do
				if iter_53_8.buffCfg.buff_effect_type == 2550 and iter_53_8:canClear() then
					self.fightResult:removeBuff(iter_53_8)
				end
			end

			self.fightResult:addAttackEffect({
				effect_type = 2,
				effect_value = var_53_11,
				attacker = self.attacker,
				victim = iter_53_6
			})
		end

		if var_53_3.value_4 > 0 then
			for iter_53_9, iter_53_10 in ipairs(var_53_6(var_53_3.value_3)) do
				self.fightResult:addBuff({
					buffId = var_53_3.value_4,
					buffTime = var_53_3.value_5,
					victim = iter_53_10,
					attacker = self.attacker
				})
			end
		end
	else
		local var_53_12 = math.floor(self.attacker.originInfo.INITIAL_HP * var_53_3.value_6 / 1000)

		for iter_53_11, iter_53_12 in ipairs((self.battleData:getKnightList(self.attacker.identity, nil, self.attacker))) do
			if iter_53_12.originInfo.pos <= 3 then
				self.fightResult:addAttackEffect({
					effect_type = 2,
					effect_value = var_53_12,
					attacker = self.attacker,
					victim = iter_53_12
				})
			end
		end

		if var_53_3.value_8 > 0 then
			for iter_53_13, iter_53_14 in ipairs(var_53_6(var_53_3.value_7)) do
				self.fightResult:addBuff({
					buffId = var_53_3.value_8,
					buffTime = var_53_3.value_9,
					victim = iter_53_14,
					attacker = self.attacker
				})
			end
		end
	end

	return {}
end

function var_0_0:_calcSkillAffect191()
	local var_55_0 = {}

	if not next(self.victims) then
		return var_55_0
	end

	local var_55_1 = 0

	for iter_55_0, iter_55_1 in ipairs(self.victims) do
		for iter_55_2, iter_55_3 in ipairs(iter_55_1.victim:getBuffs()) do
			if iter_55_3.buffCfg.buff_type == 680 then
				var_55_1 = var_55_1 + iter_55_3.numberOfLayers
			end
		end
	end

	if var_55_1 <= 0 then
		return var_55_0
	end

	local var_55_2 = var_55_1 * self.formulaValue1

	if self.formulaValue2 < var_55_1 * self.formulaValue1 then
		var_55_2 = self.formulaValue2
	end

	if var_55_2 <= 0 then
		return var_55_0
	end

	local var_55_3 = "spAffect191_boost_" .. self.battleField:getAttackCount()

	self.attacker:setKnightTempValue(var_55_3, (self.attacker:getKnightTempValue(var_55_3) or 0) + var_55_2)

	return var_55_0
end

function var_0_0:_calcSkillAffect199()
	if not next(self.victims) then
		return {}
	end

	local var_56_0 = "buff691Saving"
	local var_56_1 = self.attacker:getKnightTempValue("buff691Saving") or 0

	if var_56_1 <= 0 then
		return {}
	end

	local var_56_2 = math.floor(var_56_1 * self.formulaValue1 / 1000)

	if var_56_2 <= 0 then
		return {}
	end

	if var_56_1 < var_56_2 then
		var_56_2 = var_56_1
	end

	self.attacker:setKnightTempValue(var_56_0, var_56_1 - var_56_2)

	local var_56_3 = math.floor(var_56_2 / #self.victims)

	if var_56_3 <= 0 then
		return {}
	end

	for iter_56_0, iter_56_1 in ipairs(self.victims) do
		self.fightResult:addAttackEffect({
			effect_type = 1,
			effect_value = var_56_3,
			attacker = self.attacker,
			victim = iter_56_1.victim
		})
	end

	return {}
end

return var_0_0
