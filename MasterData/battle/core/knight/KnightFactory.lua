local var_0_0 = tostring
local var_0_1 = table
local var_0_2 = table.remove
local var_0_3 = table.insert
local var_0_4 = math
local var_0_5 = math.max
local var_0_6 = math.min
local var_0_7 = math.floor
local var_0_8 = load("const.BattleAttr")
local var_0_9 = load("const.BattleAttrRe")
local var_0_10 = load("core.knight.KnightTable")
local var_0_11 = load("const.BattleConst")
local var_0_12 = load("core.rule.BuffRule")
local var_0_13 = loadCfg("core.config.cfg.skill_info")
local var_0_14 = loadCfg("core.config.cfg.succuba_parameter_info")
local var_0_15 = var_0_11.SUCCUBA_PARAM
local var_0_16 = loadCfg("core.config.cfg.skill_mark_info")
local var_0_17 = {}

local function var_0_19(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	local var_1_0 = loadCfg("core.config.cfg.buff_info").get(arg_1_0).toObject()
	local var_1_1 = {
		isDone = false,
		buffDisappearCheck = 0,
		disappearValue1 = 0,
		tickCount = 0,
		passive_skill_serial_id = 0,
		buffCfg = var_1_0,
		serialId = arg_1_1,
		buffTime = arg_1_2,
		originBuffTime = arg_1_2,
		victim = arg_1_3,
		attacker = arg_1_4,
		buffCheckSkill = arg_1_5,
		exports = {},
		params = arg_1_7,
		subBuffs = {},
		level = var_1_0.buff_lv
	}

	if arg_1_7 then
		var_1_1.numberOfLayers = arg_1_7.numberOfLayers or 1
	end

	var_1_1.buffDisappearCheck = var_1_1.buffCfg.buff_disappear_value1

	if var_1_0.buff_disappear == var_0_12.DISAPPEAR.DAMAGE then
		var_1_1.disappearValue1 = var_0_7(arg_1_3.originInfo.INITIAL_HP * var_1_0.buff_disappear_value1 / 1000)
	end

	if var_1_0.buff_disappear == var_0_12.DISAPPEAR.HP_COMPARE then
		var_1_1.disappearValue1 = var_1_0.buff_disappear_value1
	end

	if var_1_0.buff_type == var_0_12.TYPE.PASSIVE_SKILL then
		local var_1_2 = arg_1_3:addPassiveSkill(var_1_0.buff_value_1)

		var_1_2.bindBuffExtraWaveKeep = true
		var_1_1.passive_skill_serial_id = var_1_2.serialId
	end

	for iter_1_0 = 1, 4 do
		if var_1_0["sub_buff_id_" .. iter_1_0] > 0 then
			var_0_3(var_1_1.subBuffs, (var_0_19(var_1_0["sub_buff_id_" .. iter_1_0], 0, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, nil, arg_1_8)))
		end
	end

	function var_1_1:addSubBuff(arg_2_1, arg_2_2)
		var_0_3(self.subBuffs, (var_0_19(arg_2_1, 0, arg_2_2 or arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, nil, arg_1_8)))
	end

	function var_1_1:addBuffTime(arg_3_1)
		self.buffTime = self.buffTime + arg_3_1
		self.buffTime = var_0_5(self.buffTime, 0)

		for iter_3_0, iter_3_1 in ipairs(self.subBuffs) do
			iter_3_1:addBuffTime(arg_3_1)
		end
	end

	function var_1_1:addBuffNumberOfLayer(arg_4_1)
		self.numberOfLayers = self.numberOfLayers + arg_4_1
		self.numberOfLayers = var_0_4.clamp(self.numberOfLayers, 1, self.buffCfg.buff_value_6)

		BLog.LogText(string.format("%s(%d) buff: %d 层数变化到: %d", arg_1_3.knightCfg.name, arg_1_3.serialId, self.buffCfg.id, self.numberOfLayers))

		if arg_4_1 > 0 then
			self:setBuffTimes(self.originBuffTime)
		end

		if self.numberOfLayers <= self.numberOfLayers then
			self.victim:doBuff(var_0_12.TYPE.BUFF_680, {}, {})
		end
	end

	function var_1_1:canClear()
		if self.buffCfg.buff_effect_type == var_0_12.EFFECT_TYPE.ATTACK_DOT then
			if self.victim:getBuffCount(var_0_12.EFFECT_TYPE.HP_DOT) > 0 then
				return false
			end
		elseif self.buffCfg.buff_effect_type == var_0_12.EFFECT_TYPE.HP_DOT and self.victim:getBuffCount(var_0_12.EFFECT_TYPE.ATTACK_DOT) > 0 then
			return false
		end

		return self.buffCfg.not_clear == 0
	end

	function var_1_1:setBuffTimes(arg_6_1)
		self.buffTime = var_0_5(arg_6_1, 0)

		for iter_6_0, iter_6_1 in ipairs(self.subBuffs) do
			iter_6_1:setBuffTimes(arg_6_1)
		end
	end

	function var_1_1:addBuffDisappearValue(arg_7_1)
		self.buffDisappearCheck = self.buffDisappearCheck + arg_7_1
	end

	function var_1_1:addBuffTime2(arg_8_1)
		self:_cancelBuffTime(arg_8_1)

		for iter_8_0, iter_8_1 in ipairs(self.subBuffs) do
			iter_8_1:addBuffTime2(arg_8_1)
		end

		BLog.LogText(string.format("buff: %s 回合数变化数量: %d", var_1_0.buff_name, arg_8_1))
	end

	function var_1_1:doRound(arg_9_1)
		if arg_9_1 == self.buffCfg.buff_open_type then
			if self.buffCfg.buff_time_type ~= 1 or not arg_1_6:isExtraAction() then
				self:_cancelBuffTime(-1)
			end
		end

		for iter_9_0, iter_9_1 in ipairs(self.subBuffs) do
			iter_9_1:doRound(arg_9_1)
		end
	end

	function var_1_1:doResultRound()
		self:_cancelBuffTime(-1)

		for iter_10_0, iter_10_1 in ipairs(self.subBuffs) do
			iter_10_1:doResultRound()
		end
	end

	function var_1_1:doSpRound(arg_11_1, arg_11_2)
		if arg_11_1 == self.buffCfg.buff_open_type and arg_11_2 == self.buffCfg.buff_type then
			self:_cancelBuffTime(-1)
		end

		for iter_11_0, iter_11_1 in ipairs(self.subBuffs) do
			iter_11_1:doSpRound(arg_11_1, arg_11_2)
		end
	end

	function var_1_1:doRemove(arg_12_1)
		for iter_12_0, iter_12_1 in ipairs(self.subBuffs) do
			iter_12_1:doRemove(arg_12_1)
		end

		self.subBuffs = {}

		if self.passive_skill_serial_id > 0 then
			self.victim:removePassiveSkill(self.passive_skill_serial_id)
		end

		if not arg_12_1 then
			self:executePassiveSkill(var_0_12.SKILL_TRIGGER_TYPE.DISAPPEAR)
			self:executePassiveSkill(var_0_12.SKILL_TRIGGER_TYPE.DISAPPEAR2)
		end

		if type(self.rule) == "table" then
			for iter_12_2, iter_12_3 in pairs(self.rule) do
				local var_12_0 = self.victim.buffRules[iter_12_2] or {}

				for iter_12_4, iter_12_5 in ipairs(var_12_0) do
					if iter_12_5 == self then
						var_0_1.remove(var_12_0, iter_12_4)

						break
					end
				end
			end
		else
			local var_12_1 = var_1_1.victim.buffRules[var_1_0.buff_type] or {}

			for iter_12_6, iter_12_7 in ipairs(var_12_1) do
				if iter_12_7 == self then
					var_0_1.remove(var_12_1, iter_12_6)

					break
				end
			end
		end

		if var_1_0.buff_effect_type == 2502 then
			arg_1_6:getBattleData():subtractBuff672SiphonRatio(arg_1_3.identity, arg_1_3.serialId, var_1_0.buff_value_1)
		end

		BLog.LogDelBuff(self)
	end

	function var_1_1:executePassiveSkill(arg_13_1)
		if var_1_0.trigger_skill_type_1 == arg_13_1 then
			if var_1_0.trigger_skill_id_1 > 0 then
				local var_13_0 = var_0_13.get(var_1_0.trigger_skill_id_1)

				if arg_13_1 == var_0_12.SKILL_TRIGGER_TYPE.DISAPPEAR2 or arg_13_1 == var_0_12.SKILL_TRIGGER_TYPE.ADD2 or arg_13_1 == var_0_12.SKILL_TRIGGER_TYPE.AFFECT2 or arg_13_1 == var_0_12.SKILL_TRIGGER_TYPE.ATTACKER_DEAD then
					if var_1_0.extra_wave_keep == 1 then
						arg_1_6:getBattleData():addFastPassive({
							isSkill = true,
							knight = self.victim,
							identity = self.victim.identity,
							info = var_13_0
						})
					else
						arg_1_6:getBattleData():addPassive({
							isSkill = true,
							knight = self.victim,
							identity = self.victim.identity,
							info = var_13_0
						})
					end
				elseif var_1_0.extra_wave_keep == 1 then
					arg_1_6:getBattleData():addFastPassive({
						isSkill = true,
						knight = self.attacker,
						identity = self.attacker.identity,
						info = var_13_0
					})
				else
					arg_1_6:getBattleData():addPassive({
						isSkill = true,
						knight = self.attacker,
						identity = self.attacker.identity,
						info = var_13_0
					})
				end
			end
		end

		if arg_13_1 == var_0_12.SKILL_TRIGGER_TYPE.DISAPPEAR then
			local var_13_1 = self.victim:doBuff(var_0_12.TYPE.BUFF_REMOVE_CHANGE, {
				isEff = false,
				skillId = 0
			}, {
				buff_effect_type = self.buffCfg.buff_effect_type
			})

			if var_13_1.isEff then
				local var_13_2 = var_0_13.get(var_13_1.skillId)

				if var_1_0.extra_wave_keep == 1 then
					arg_1_6:getBattleData():addFastPassive({
						isSkill = true,
						knight = self.victim,
						identity = self.victim.identity,
						info = var_13_2
					})
				else
					arg_1_6:getBattleData():addPassive({
						isSkill = true,
						knight = self.victim,
						identity = self.victim.identity,
						info = var_13_2
					})
				end
			end
		end
	end

	function var_1_1:doClean()
		for iter_14_0 = #self.subBuffs, 1, -1 do
			if self.subBuffs[iter_14_0].isDone then
				self.subBuffs[iter_14_0]:doRemove()
				var_0_2(self.subBuffs, iter_14_0)
			else
				self.subBuffs[iter_14_0]:doClean()
			end
		end
	end

	function var_1_1:_cancelBuffTime(arg_15_1)
		self.buffTime = self.buffTime + arg_15_1
		self.buffTime = var_0_5(self.buffTime, 0)

		if self.buffTime == 0 then
			self.isDone = true
		end
	end

	local var_1_3 = load("core.rule.BuffRule")

	var_1_1.rule = var_1_3.initRule(var_1_1, arg_1_6)

	if arg_1_8 then
		if type(var_1_1.rule) == "table" then
			for iter_1_1, iter_1_2 in pairs(var_1_1.rule) do
				arg_1_3.buffRules[iter_1_1] = arg_1_3.buffRules[iter_1_1] or {}

				var_0_1.insert(arg_1_3.buffRules[iter_1_1], var_1_1)
			end
		else
			arg_1_3.buffRules[var_1_0.buff_type] = arg_1_3.buffRules[var_1_0.buff_type] or {}

			var_0_1.insert(arg_1_3.buffRules[var_1_0.buff_type], var_1_1)
		end
	end

	function var_1_1:execute(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		local var_16_0 = false

		if type(self.rule) == "table" then
			if self.rule[arg_16_1] and (not self.buffCheckSkill or self.buffCheckSkill:check()) then
				local var_16_1, var_16_2 = self.rule[arg_16_1](arg_16_2, arg_16_3)

				if var_16_1 then
					arg_16_2 = var_16_2
					var_16_0 = true
				end
			end
		elseif arg_16_1 == self.buffCfg.buff_type and (not self.buffCheckSkill or self.buffCheckSkill:check()) then
			local var_16_3, var_16_4 = self.rule(arg_16_2, arg_16_3)

			if var_16_3 then
				arg_16_2 = var_16_4
				var_16_0 = true
			end
		end

		if var_16_0 then
			self:checkDisappear(var_1_3.DISAPPEAR.AFFECT, nil, true)
			self:executePassiveSkill(var_1_3.SKILL_TRIGGER_TYPE.AFFECT)
			self:executePassiveSkill(var_1_3.SKILL_TRIGGER_TYPE.AFFECT2)
		end

		if not arg_16_4 then
			for iter_16_0, iter_16_1 in ipairs(self.subBuffs) do
				local var_16_6

				var_16_6, arg_16_2 = iter_16_1:execute(arg_16_1, arg_16_2, arg_16_3)
				var_16_0 = var_16_0 or var_16_6
			end
		end

		BLog.LogBuff(self)

		return var_16_0, arg_16_2
	end

	function var_1_1:checkDisappear(arg_17_1, arg_17_2, arg_17_3)
		if arg_17_1 == self.buffCfg.buff_disappear then
			if arg_17_1 == var_1_3.DISAPPEAR.AFFECT then
				self.buffDisappearCheck = self.buffDisappearCheck - 1

				if self.buffDisappearCheck <= 0 then
					self.isDone = true
				end
			elseif arg_17_1 == var_1_3.DISAPPEAR.DEAD then
				if self.attacker.serialId == arg_17_2 then
					self.isDone = true
				end
			elseif arg_17_1 == var_1_3.DISAPPEAR.AFFECT_ACTION_TIMES then
				if self.disappearValue1 == 1 then
					self.buffDisappearCheck = self.buffDisappearCheck - 1

					if self.buffDisappearCheck <= 0 then
						self.isDone = true
					end
				end
			elseif arg_17_1 == var_1_3.DISAPPEAR.AFFECT_ACTION then
				if self.disappearValue1 == 1 then
					self.isDone = true
				end
			elseif arg_17_1 == var_1_3.DISAPPEAR.SHIELD then
				self.isDone = true
			elseif arg_17_1 == var_1_3.DISAPPEAR.DAMAGE then
				self.disappearValue1 = self.disappearValue1 - arg_17_2

				if self.disappearValue1 <= 0 then
					self.isDone = true
				end
			elseif arg_17_1 == var_1_3.DISAPPEAR.ACTION_TIMES then
				self.buffDisappearCheck = self.buffDisappearCheck - 1

				if self.buffDisappearCheck <= 0 then
					self.isDone = true
				end
			elseif arg_17_1 == var_1_3.DISAPPEAR.HP_COMPARE and self.victim.baseInfo.hpRate < self.disappearValue1 then
				self.isDone = true
			end
		elseif arg_17_1 == var_1_3.DISAPPEAR.AFFECT and (self.buffCfg.buff_disappear == var_1_3.DISAPPEAR.AFFECT_ACTION or self.buffCfg.buff_disappear == var_1_3.DISAPPEAR.AFFECT_ACTION_TIMES) then
			self.disappearValue1 = 1
		end

		if not arg_17_3 then
			for iter_17_0, iter_17_1 in ipairs(self.subBuffs) do
				iter_17_1:checkDisappear(arg_17_1, arg_17_2, arg_17_3)
			end
		end
	end

	function var_1_1:addLevel(arg_18_1)
		self.level = self.level + arg_18_1
	end

	var_1_1:executePassiveSkill(var_1_3.SKILL_TRIGGER_TYPE.ADD)
	var_1_1:executePassiveSkill(var_1_3.SKILL_TRIGGER_TYPE.ADD2)

	return var_1_1
end

local function var_0_20(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = var_0_16.get(arg_19_0)
	local var_19_1 = {
		level = 0,
		id = arg_19_0,
		markCfg = var_19_0,
		attacker = arg_19_2,
		victim = arg_19_1,
		maxLevel = var_19_0.max_num,
		mType = var_19_0.type
	}

	if var_19_0.buff_id > 0 then
		var_19_1.buff = var_0_19(var_19_0.buff_id, 0, 1, arg_19_1, arg_19_2, nil, arg_19_2.battleField)
	end

	function var_19_1:doBuff(arg_20_1, arg_20_2, arg_20_3)
		local var_20_0 = false

		if self.buff then
			for iter_20_0 = 1, self.level do
				local var_20_3, var_20_4 = self.buff:execute(arg_20_1, arg_20_2, arg_20_3)

				if var_20_3 then
					arg_20_2 = var_20_4
				end

				var_20_0 = var_20_0 or var_20_3
			end
		end

		return var_20_0, arg_20_2
	end

	function var_19_1:execute()
		if self.level > 0 then
			for iter_21_0 = 1, 3 do
				if var_19_0["type_" .. iter_21_0] > 0 then
					local var_21_0 = var_0_12.buffAttr[var_19_0["type_" .. iter_21_0]] or var_19_0["type_" .. iter_21_0]

					self.victim.advanceInfo[var_0_9[var_21_0]] = (self.victim.advanceInfo[var_0_9[var_21_0]] or 0) + var_19_0["value_" .. iter_21_0] * (var_19_0.increase_type == 1 and 1 or -1) * self.level
				end
			end
		end
	end

	function var_19_1:addLevel(arg_22_1, arg_22_2)
		self.level = self.level + arg_22_2

		if arg_22_1 > self.id then
			self.id = arg_22_1
			self.markCfg = var_0_16.get(arg_22_1)
		end

		if self.level < self.maxLevel and self.level >= self.maxLevel and self.markCfg.skill_info_id > 0 then
			if self.markCfg.skill_trigger_limit == 0 or self.victim:getMarkSkillNum(self.markCfg.type) < self.markCfg.skill_trigger_limit then
				local var_22_0 = false
				local var_22_1 = var_0_13.get(self.markCfg.skill_info_id)

				if self.markCfg.skill_trigger_merges == 1 then
					self.victim.battleField:getBattleData():addFastPassive({
						isSkill = true,
						knight = self.victim,
						info = var_22_1
					})

					var_22_0 = true
				elseif self.markCfg.skill_trigger_merges == 0 then
					self.victim.battleField:getBattleData():addPassive({
						isSkill = true,
						knight = self.victim,
						info = var_22_1
					})

					var_22_0 = true
				end

				if var_22_0 then
					self.victim:addMarkSkillNum(self.markCfg.type)
					self:delLevel(self.markCfg.mark_purging_num)
				end
			end
		end

		self.level = var_0_6(self.maxLevel, self.level)
	end

	function var_19_1:delLevel(arg_23_1)
		self.level = var_0_5(self.level - arg_23_1, 0)
	end

	function var_19_1.clear(arg_24_0)
		arg_24_0.level = 0
	end

	return var_19_1
end

local function var_0_21(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	return {
		serialId = arg_25_1,
		rules = load("core.rule.SkillSpecialRule").initRule({
			arg_25_0
		}, arg_25_2, arg_25_3, arg_25_4)
	}
end

local function var_0_22(arg_26_0, arg_26_1)
	local var_26_0 = {}

	if arg_26_1 then
		if arg_26_0.passive_skill > 0 then
			var_26_0 = {
				arg_26_0.passive_skill
			}
		end

		local var_26_1 = 1

		while loadCfg("core.config.cfg.monster_info").hasKey("passive_skill_" .. var_26_1) do
			if arg_26_0["passive_skill_" .. var_26_1] > 0 then
				var_0_3(var_26_0, arg_26_0["passive_skill_" .. var_26_1])
			end

			var_26_1 = var_26_1 + 1
		end
	else
		local var_26_2 = 1

		while loadCfg("core.config.cfg.knight_info").hasKey("passive_skill_" .. var_26_2) do
			if arg_26_0["passive_skill_" .. var_26_2] > 0 then
				var_0_3(var_26_0, arg_26_0["passive_skill_" .. var_26_2])
			end

			var_26_2 = var_26_2 + 1
		end
	end

	return var_26_0
end

function var_0_17:createKnight(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = {
		isPlayer = false,
		isDead = false,
		isLock = false,
		assisting = false,
		multiple = 1000,
		exile = false,
		star = 0,
		effectClearBuffNum = 0,
		hide = false,
		tempShield = 0,
		attackDamage = 0,
		KnightLockHpPer = 0,
		isCanSelect = true,
		bloodPoolValue = 0,
		classical = 0,
		serialId = 0,
		actionWarBand = true,
		deadWarBand = true,
		effectClearBuffNum2 = 0,
		hitWarBand = true,
		isLockEnergy = false,
		inspirationCost = 0,
		willAssist = false,
		actionFailWarBand = true,
		sufferDamage = 0,
		bloodPoolMax = 0,
		rebornCount = 0,
		isGhost = false,
		activeWithOutCost = false,
		originInfo = {},
		baseInfo = {},
		advanceInfo = {},
		identity = arg_27_1,
		opIdentity = 3 - arg_27_1,
		buffs = {},
		buffCount = {},
		skills = {},
		passiveSkillIds = {},
		extraSkills = {},
		skillTimes = {},
		skillAffectTimes = {},
		baseData = self,
		user = arg_27_3,
		isMonster = arg_27_2,
		marks = {},
		markSkillNum = {},
		buffRules = {},
		battleField = arg_27_4,
		extraTempValue = {},
		buffAddRecord = {},
		roundAddSuccubaCount = {},
		buffEffectTotalDict = {},
		needSubBuffEffect = {}
	}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(self.attrs) do
		var_27_1[iter_27_1.type] = iter_27_1.value
	end

	for iter_27_2, iter_27_3 in pairs(var_0_8) do
		var_27_0.originInfo[iter_27_2] = var_27_1[iter_27_3] and var_27_1[iter_27_3] or 0
	end

	var_27_0.originInfo.pos = self.pos
	var_27_0.originInfo.id = self.id
	var_27_0.originInfo.skill_level1 = self.skill_level1 or 0
	var_27_0.originInfo.skill_level2 = self.skill_level2 or 0
	var_27_0.skills = self.skills or {}

	if self.multiple then
		var_27_0.multiple = self.multiple + 1000
	end

	function var_27_0:checkAndSetRebornAttr()
		if self.baseData and self.baseData.relive_attrs then
			local var_28_0 = self.baseData.relive_attrs[self.rebornCount + 1] and self.baseData.relive_attrs[self.rebornCount + 1].attrs

			if var_28_0 then
				local var_28_1 = {}

				for iter_28_0, iter_28_1 in ipairs(var_28_0) do
					var_28_1[iter_28_1.type] = iter_28_1.value
				end

				for iter_28_2, iter_28_3 in pairs(var_0_8) do
					self.originInfo[iter_28_2] = var_28_1[iter_28_3] and var_28_1[iter_28_3] or 0
				end

				self.baseInfo.INITIAL_HP = self.originInfo.INITIAL_HP

				return true
			end
		end

		return false
	end

	function var_27_0:getHpRate()
		return var_0_4.floor(self.baseInfo.INITIAL_HP * 1000 / self.originInfo.INITIAL_HP)
	end

	function var_27_0:getTotalDef()
		return var_0_4.floor((self.advanceInfo.PHY_DEFENCE * (1000 + (self.advanceInfo.PHY_DEFENCE_PCT + self.advanceInfo.DEFENCE_PCT)) + self.advanceInfo.MAG_DEFENCE * (1000 + (self.advanceInfo.MAG_DEFENCE_PCT + self.advanceInfo.DEFENCE_PCT))) / 1000)
	end

	function var_27_0:getTotalAtk()
		return var_0_4.max(0, (var_0_4.floor(self.advanceInfo.ATTACK * (1000 + self.advanceInfo.ATTACK_PCT) / 1000)))
	end

	setmetatable(var_27_0.originInfo, {
		__index = function(arg_32_0, arg_32_1)
			if arg_32_1 == "hpRate" then
				return var_27_0:getHpRate()
			elseif arg_32_1 == "totalDef" then
				return var_27_0:getTotalDef()
			elseif arg_32_1 == "totalAtk" then
				return var_27_0:getTotalAtk()
			end
		end
	})
	setmetatable(var_27_0.baseInfo, {
		__index = var_27_0.originInfo
	})
	setmetatable(var_27_0.advanceInfo, {
		__index = var_27_0.baseInfo
	})

	function var_27_0:clearAdvanceInfo()
		local var_33_0 = {}

		setmetatable(var_33_0, {
			__index = self.baseInfo
		})

		self.advanceInfo = var_33_0
	end

	var_27_0.baseInfo.INITIAL_HP = var_27_0.baseInfo.BATTLE_HP

	if var_27_0.baseInfo.BATTLE_HP == 0 then
		var_27_0.isDead = true
	end

	function var_27_0:setKnightTempValue(arg_34_1, arg_34_2)
		self.extraTempValue[arg_34_1] = arg_34_2
	end

	function var_27_0:getKnightTempValue(arg_35_1)
		return self.extraTempValue[arg_35_1]
	end

	function var_27_0.clearKnightTempValue(arg_36_0)
		arg_36_0.extraTempValue = {}
	end

	function var_27_0:getTempShield()
		return self.tempShield
	end

	function var_27_0.setTempShieldValue(arg_38_0, arg_38_1)
		arg_38_0.tempShield = arg_38_1
	end

	function var_27_0:addBuffEffectTotalCount(arg_39_1, arg_39_2, arg_39_3)
		if not self.buffEffectTotalDict[arg_39_1] then
			self.buffEffectTotalDict[arg_39_1] = {
				count = arg_39_2,
				buffInfo = arg_39_3
			}
		else
			self.buffEffectTotalDict[arg_39_1].count = self.buffEffectTotalDict[arg_39_1].count + arg_39_2
		end
	end

	function var_27_0:addNeedSubBuffEffectType(arg_40_1)
		self.needSubBuffEffect[arg_40_1] = self.needSubBuffEffect[arg_40_1] or true
	end

	function var_27_0:getBuffEffectTotalValues(arg_41_1)
		if self.buffEffectTotalDict[arg_41_1] then
			return self.buffEffectTotalDict[arg_41_1].count, self.buffEffectTotalDict[arg_41_1].buffInfo
		end

		return 0, nil
	end

	function var_27_0:subBuffEffectTotalCount()
		for iter_42_0, iter_42_1 in pairs(self.needSubBuffEffect) do
			local var_42_0 = self:getBuffEffectTotalValues(iter_42_0) or 0

			if 1 < var_42_0 then
				self.buffEffectTotalDict[iter_42_0].count = var_42_0 - 1
			else
				self.buffEffectTotalDict[iter_42_0] = nil
			end
		end

		self.needSubBuffEffect = {}
	end

	local var_27_2, var_27_3

	if arg_27_2 then
		arg_27_2 = arg_27_4:getBattlePlayId() ~= var_0_11.ServerPlayId.EXPLORATION_BOSS
		var_27_2 = loadCfg("core.config.cfg." .. (arg_27_2 and "monster_info" or "knight_info"))
		var_27_3 = var_27_2.get(self.id)
	end

	assert(var_27_3, "Cant find " .. (arg_27_2 and "monster_info" or "knight_info") .. " id :" .. self.id .. "  battleField:getBattlePlayId():" .. var_0_0(arg_27_4:getBattlePlayId()))

	local var_27_4 = var_27_3.toObject()

	var_27_0.knightCfg = var_27_4
	var_27_0.star = var_27_4.star or 0
	var_27_0.classical = var_27_4.classical or 0

	local function var_27_6(arg_43_0)
		local var_43_0 = {}

		while var_27_2.hasKey("energy_type_" .. 1) do
			if arg_43_0["energy_type_" .. 1] > 0 then
				var_0_3(var_43_0, {
					type = arg_43_0["energy_type_" .. 1],
					value = arg_43_0["energy_value_" .. 1]
				})
			end
		end

		return var_43_0
	end

	local var_27_7 = var_27_4.common_id
	local var_27_8 = var_27_4.active_skill_id
	local var_27_9 = var_27_4.energy_skill_id
	local var_27_10 = var_27_4.army_skill_id
	local var_27_11 = var_0_22(var_27_4, arg_27_2)
	local var_27_12 = var_27_4.initial_energy
	local var_27_13 = var_27_6(var_27_4)

	if not arg_27_2 and var_27_4.type == 1 and arg_27_3 then
		if self.common_skill_id and self.common_skill_id > 0 and self.active_skill_id and self.active_skill_id > 0 then
			var_27_7 = self.common_skill_id
			var_27_8 = self.active_skill_id
			var_27_9 = self.energy_skill_id or 0
			var_27_10 = self.army_skill_id or 0
		end

		if arg_27_3.dress_id and arg_27_3.dress_id > 0 then
			var_27_11 = {}
			var_27_13 = {}

			local var_27_14 = loadCfg("core.config.cfg.dress_info")
			local var_27_15 = var_27_14.get(arg_27_3.dress_id)
			local var_27_16 = 1
			local var_27_17 = 1
			local var_27_18 = self.dress_level or 0

			while var_27_14.hasKey("enhance_level_" .. var_27_16) do
				if var_27_18 >= var_27_15["enhance_level_" .. var_27_16] then
					var_27_17 = var_27_16
				end

				var_27_16 = var_27_16 + 1
			end

			local var_27_19 = 1

			while var_27_14.hasKey("passive_skill_id_" .. var_27_17 .. "_" .. var_27_19) do
				if var_27_15["passive_skill_id_" .. var_27_17 .. "_" .. var_27_19] > 0 then
					var_0_3(var_27_11, var_27_15["passive_skill_id_" .. var_27_17 .. "_" .. var_27_19])
				end

				var_27_19 = var_27_19 + 1
			end

			var_27_13 = var_27_6(var_27_15)
			var_27_12 = var_27_15.initial_energy
		end

		if self.cardId and self.cardId > 0 then
			local var_27_20 = loadCfg("core.config.cfg.transformation_card_info")
			local var_27_21 = var_27_20.get(self.cardId)
			local var_27_22 = self.dress_num or 0
			local var_27_23 = var_27_21.original_star
			local var_27_24 = 1

			while var_27_20.hasKey("dress_num_" .. var_27_24) do
				if var_27_21["dress_num_" .. var_27_24] > 0 and var_27_22 >= var_27_21["dress_num_" .. var_27_24] then
					var_27_23 = var_27_21["skill_star_" .. var_27_24]
				end

				var_27_24 = var_27_24 + 1
			end

			local var_27_25 = var_0_10.getKnightByAdvIdStar(var_27_21.advance_id, var_27_23)

			if var_27_25 then
				var_27_11 = var_0_22(var_27_25)
				var_27_12 = var_27_25.initial_energy
				var_27_13 = var_27_6(var_27_25)
			end
		end
	end

	if arg_27_2 or arg_27_5 then
		var_27_0.isLock = arg_27_5 and arg_27_5.if_lock == 1 or var_27_4.if_lock == 1
	end

	var_27_0.commonSkillCfg = var_0_13.get(var_27_7)

	assert(var_27_0.commonSkillCfg, "Could not find skill_info with id: " .. var_0_0(var_27_7))

	var_27_0.commonSkillCfg = var_27_0.commonSkillCfg.toObject()
	var_27_0.activeSkillCfg = var_0_13.get(var_27_8)

	assert(var_27_0.activeSkillCfg, "Could not find skill_info with id: " .. var_0_0(var_27_8))

	var_27_0.activeSkillCfg = var_27_0.activeSkillCfg.toObject()

	if var_27_9 and var_27_9 > 0 then
		var_27_0.energySkillCfg = var_0_13.get(var_27_9)

		assert(var_27_0.energySkillCfg, "Could not find skill_info with id: " .. var_0_0(var_27_9))
	end

	if var_27_10 and var_27_10 > 0 then
		var_27_0.warBandSkillCfg = var_0_13.get(var_27_10)

		assert(var_27_0.warBandSkillCfg, "Could not find skill_info with id: " .. var_0_0(var_27_10))
	end

	if self.professionPassives then
		for iter_27_4, iter_27_5 in ipairs(self.professionPassives) do
			var_27_0.skills[#var_27_0.skills + 1] = iter_27_5
		end
	end

	if next(var_27_11) then
		var_27_0.skills = clone(var_27_0.skills)

		for iter_27_6, iter_27_7 in ipairs(var_27_11) do
			var_27_0.skills[#var_27_0.skills + 1] = iter_27_7
		end

		var_27_0.passiveSkillIds = var_27_11
	end

	var_27_0.originInfo.INITIAL_ENERGY = var_27_12
	var_27_0.originInfo.INITIAL_THRESH = var_27_12

	local var_27_26 = load("core.rule.SkillSpecialRule")

	var_27_0.spRules = var_27_26.initRule(var_27_0.skills, var_27_0.identity, arg_27_4, var_27_0)

	function var_27_0:executeSpRule(arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
		local var_44_0 = {}

		if arg_44_1 == var_27_26.TYPE.BUFF_DOING_EFFECT and var_0_12.TYPE.BUFF_594 == arg_44_2.passiveEffectBuffType then
			return arg_44_4, var_44_0
		elseif self:doBuff(var_0_12.TYPE.BUFF_594, false, {
			passiveEffectBuffType = var_0_12.TYPE.BUFF_594
		}) then
			return arg_44_4, var_44_0
		end

		local var_44_1 = {}

		if self.spRules[arg_44_1] then
			for iter_44_0, iter_44_1 in ipairs(self.spRules[arg_44_1]) do
				var_0_3(var_44_1, iter_44_1)
			end
		end

		if self.extraSkills then
			for iter_44_2, iter_44_3 in ipairs(self.extraSkills) do
				if iter_44_3.rules[arg_44_1] then
					var_0_3(var_44_1, iter_44_3.rules[arg_44_1][1])
				end
			end
		end

		if next(var_44_1) then
			for iter_44_4, iter_44_5 in ipairs(var_44_1) do
				if arg_44_3 then
					if iter_44_5.info.passive_skill_type == 4 and iter_44_5.spEffectInfo.special_skill_type == arg_44_3 and iter_44_5:check(arg_44_2) and iter_44_5:execute() then
						arg_44_4 = iter_44_5.spEffectRule(arg_44_4, arg_44_5)

						var_0_3(var_44_0, iter_44_5.spEffectInfo.id)
					end
				elseif iter_44_5.info.passive_skill_type ~= 4 and iter_44_5:check(arg_44_2) and iter_44_5:execute() then
					if iter_44_5.info.passive_skill_type == 3 then
						arg_27_4:getBattleData():addFastPassive({
							knight = var_27_0,
							info = iter_44_5.info,
							check = iter_44_5,
							identity = var_27_0.identity
						})
					elseif iter_44_5.info.passive_skill_type == 1 and iter_44_5.info.if_merge == 1 then
						arg_27_4:getBattleData():addFastPassive({
							knight = var_27_0,
							info = iter_44_5.info,
							identity = var_27_0.identity
						})
					elseif iter_44_5.info.passive_skill_type == 1 or iter_44_5.info.passive_skill_type == 2 then
						arg_27_4:getBattleData():addPassive({
							knight = var_27_0,
							info = iter_44_5.info,
							identity = var_27_0.identity
						})
					end
				end
			end
		end

		if arg_27_4:getBattleData().assistCheck then
			local var_44_2, var_44_3 = arg_27_4:getBattleData():assistCheck(var_27_0.identity, arg_44_1, arg_44_2)

			if var_44_2 then
				arg_27_4:getBattleData():addPassive({
					assist = true,
					knight = var_44_2,
					info = var_44_3
				})
			end
		end

		return arg_44_4, var_44_0
	end

	function var_27_0:getSpRuleSkill(arg_45_1)
		local var_45_0 = var_27_26.triggerTime[arg_45_1] or 0
		local var_45_1 = {}

		if type(var_45_0) == "table" then
			for iter_45_0, iter_45_1 in ipairs(var_45_0) do
				var_0_3(var_45_1, iter_45_1)
			end
		else
			var_0_3(var_45_1, var_45_0)
		end

		local var_45_2 = {}

		for iter_45_2, iter_45_3 in ipairs(var_45_1) do
			if self.spRules[iter_45_3] then
				for iter_45_4, iter_45_5 in ipairs(self.spRules[iter_45_3]) do
					var_0_3(var_45_2, iter_45_5)
				end
			end
		end

		return var_45_2
	end

	function var_27_0:resetSpRule()
		for iter_46_0, iter_46_1 in pairs(self.spRules) do
			for iter_46_2, iter_46_3 in ipairs(iter_46_1) do
				if iter_46_3.info.trigger_maxtime_type == 5 or iter_46_3.info.trigger_maxtime_type == 2 then
					iter_46_3:reset()
				end
			end
		end
	end

	local var_27_27 = 1

	function var_27_0:addPassiveSkill(arg_47_1)
		local var_47_0 = var_0_21(arg_47_1, var_27_27, self.identity, arg_27_4, self)

		var_0_3(self.extraSkills, var_47_0)

		var_27_27 = var_27_27 + 1

		return var_47_0
	end

	function var_27_0:removePassiveSkill(arg_48_1)
		for iter_48_0, iter_48_1 in ipairs(self.extraSkills) do
			if iter_48_1.serialId == arg_48_1 then
				var_0_2(self.extraSkills, iter_48_0)

				return
			end
		end
	end

	function var_27_0:clearPassiveSkill()
		local var_49_0 = {}

		for iter_49_0, iter_49_1 in ipairs(self.extraSkills) do
			if iter_49_1.bindBuffExtraWaveKeep then
				var_0_3(var_49_0, iter_49_1)
			end
		end

		self.extraSkills = var_49_0
	end

	local var_27_28 = load("core.rule.EnergyRule")

	var_27_0.energyRules = var_27_28.initRule(var_27_0, var_27_13)

	function var_27_0:executeEnergyRule(arg_50_1, arg_50_2)
		if self.isLockEnergy then
			return
		end

		if self.energyRules[arg_50_1] then
			for iter_50_0, iter_50_1 in ipairs(self.energyRules[arg_50_1]) do
				if iter_50_1:check(arg_50_2) then
					iter_50_1:execute()
				end
			end
		end
	end

	function var_27_0.addEnergyEffect(arg_51_0, arg_51_1)
		arg_27_4:getBattleData():addEnergyEffect(arg_51_0, arg_51_1)
	end

	function var_27_0:getThreshSkillLeftTimes()
		return self:getEnergySkillLeftTimes()
	end

	function var_27_0:getEnergySkillLeftTimes()
		local var_53_0 = 999

		if self.energySkillCfg then
			if self.energySkillCfg.skill_limit > 0 then
				var_53_0 = var_0_4.max(0, self.energySkillCfg.skill_limit - self:getSkillTimes(self.energySkillCfg.id))
			end
		end

		return var_53_0
	end

	function var_27_0:canReleaseThreshSkill()
		local var_54_0 = self.energySkillCfg
		local var_54_1 = self:doBuff(var_0_12.TYPE.TRANSFORM, {})

		if next(var_54_1) then
			var_54_0 = var_54_1.energySkillCfg
		end

		if var_54_0 then
			if var_54_0.skill_limit > 0 and var_54_0.skill_limit <= self:getSkillTimes(var_54_0.id) then
				return false
			end

			if var_54_0.rage_type == 9 and self.baseInfo.INITIAL_THRESH >= var_54_0.rage_value then
				return true
			end
		end

		return false
	end

	function var_27_0:canReleaseEnergySkill()
		local var_55_0 = self.energySkillCfg
		local var_55_1 = self:doBuff(var_0_12.TYPE.TRANSFORM, {})

		if next(var_55_1) then
			var_55_0 = var_55_1.energySkillCfg
		end

		if var_55_0 then
			if var_55_0.skill_limit > 0 and var_55_0.skill_limit <= self:getSkillTimes(var_55_0.id) then
				return false
			end

			if var_55_0.rage_type == 5 and self.baseInfo.INITIAL_ENERGY >= var_55_0.rage_value then
				return true
			end
		end

		return false
	end

	function var_27_0:canReleaseActiveSkill()
		local var_56_0 = self:doBuff(var_0_12.TYPE.EXTRA_ANGER_COST, 0, 2)

		if self:canChangeAnger(false) then
			local var_56_1 = self:doBuff(var_0_12.TYPE.ANGER_REDUCE, {
				reduceValue = 0
			}, {
				isResult = false
			})

			if var_56_1 and var_56_1.reduceValue > 0 then
				var_56_0 = var_56_0 + var_56_1.reduceValue
			end
		end

		local var_56_2 = self:doBuff(var_0_12.TYPE.ANGER_COST_CHANGE, {
			changeValue = 0
		}, {
			isResult = false
		})

		if var_56_2 and var_56_2.changeValue ~= 0 then
			var_56_0 = var_56_0 + var_56_2.changeValue
		end

		if self.baseInfo.INITIAL_ANGER >= self.activeSkillCfg.rage_value + var_56_0 then
			return true
		end

		return false
	end

	local var_27_29 = 1

	function var_27_0:addBuff(arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5, arg_57_6)
		local var_57_0 = loadCfg("core.config.cfg.buff_info").get(arg_57_1)
		local var_57_1 = arg_27_4:getBattleData()
		local var_57_2 = 0

		var_57_2 = arg_57_3.isPlayer and (arg_57_3.isPet and var_57_1:getQSValue(arg_57_3.identity, var_0_11.Q_SUPPRESS_MODULE.PET, var_0_11.Q_SUPPRESS_TYPE.BUFF, var_57_0.buff_quality) or arg_57_3.isSuccuba and var_57_1:getQSValue(arg_57_3.identity, var_0_11.Q_SUPPRESS_MODULE.SUCCUBA, var_0_11.Q_SUPPRESS_TYPE.BUFF, var_57_0.buff_quality) or var_57_1:getQSValue(arg_57_3.identity, var_0_11.Q_SUPPRESS_MODULE.TOKEN, var_0_11.Q_SUPPRESS_TYPE.BUFF, var_57_0.buff_quality)) or var_57_1:getQSValue(arg_57_3.identity, var_0_11.Q_SUPPRESS_MODULE.KNIGHT, var_0_11.Q_SUPPRESS_TYPE.BUFF, var_57_0.buff_quality)

		if var_57_2 > 0 and arg_27_4:bingo(var_57_2) then
			BLog.LogText(string.format("品质压制成功，buff添加失败：%d %s ,压制千分比：%d", arg_57_1, var_57_0.buff_name, var_57_2))

			return
		end

		local var_57_3 = 0

		if not arg_57_3.isPlayer then
			var_57_3 = arg_57_3:doBuff(var_0_12.TYPE.BUFF_LV_UP, 0)
		end

		if var_57_0.buff_type == var_0_12.TYPE.TRANSFORM and self:getBuffCount(var_0_12.TYPE.TRANSFORM, true) > 0 then
			return
		end

		if (var_57_0.buff_type == var_0_12.TYPE.ACT_LIMIT or var_57_0.buff_control_type == 1) and self:doBuff(var_0_12.TYPE.REMEMBER_LIMIT, false, var_57_0.buff_effect_type) then
			return
		end

		if self:doBuff(var_0_12.TYPE.CONTINUATION_IMMUNITY, false, {
			isAddBuff = true,
			buffCfg = var_57_0
		}) then
			return
		end

		if var_57_0.buff_type == var_0_12.TYPE.ATTR and var_57_0.buff_increase_type == 2 then
			local var_57_4 = self:doBuff(var_0_12.TYPE.IMMUNE_GET_BUFF, {
				immune = false
			}, {
				curBuff = var_57_0,
				buffTime = arg_57_2
			})

			if var_57_4.addBuff then
				arg_57_6:addBuff(var_57_4.addBuff)
			end

			if var_57_4.immune then
				return
			end
		end

		if var_57_0.buff_increase_type == 2 then
			if self:doBuff(var_0_12.TYPE.IMMUNE_DEBUFF, {
				isImmune = false
			}, {
				buffAttacker = arg_57_3
			}).isImmune then
				return
			end

			if self:doBuff(var_0_12.TYPE.IMMUNE_RECORD_BUFF, {
				isImmune = false
			}, {
				buffId = arg_57_1
			}).isImmune then
				return
			end

			if self:doBuff(var_0_12.TYPE.BUFF_507, {
				isImmune = false
			}).isImmune then
				return
			end
		end

		if var_57_0.buff_type == var_0_12.TYPE.ATTR then
			if self:doBuff(var_0_12.TYPE.EXPLORATION_SMELL, {
				isImmune = false
			}, {
				curBuff = var_57_0,
				fightResult = arg_57_6,
				buffTime = arg_57_2
			}).isImmune then
				return
			end

			if var_57_0.buff_increase_type == 2 and self:doBuff(var_0_12.TYPE.BUFF_580, {
				isImmune = false
			}, {
				isAddBuff = true,
				buffId = arg_57_1,
				buffTime = arg_57_2,
				fightResult = arg_57_6
			}).isImmune then
				return
			end
		elseif var_57_0.buff_type == var_0_12.TYPE.DHOT then
			local var_57_5 = self:doBuff(var_0_12.TYPE.BUFF_330, {
				receiveHp = 0,
				isImmune = false,
				addShield = 0
			}, {
				fightResult = arg_57_6,
				buffTime = arg_57_2,
				buffId = arg_57_1
			})

			if var_57_5.isImmune then
				if var_57_5.receiveHp > 0 then
					arg_57_6:addAttackEffect({
						effect_type = 2,
						effect_value = var_57_5.receiveHp,
						attacker = self,
						victim = self
					}, false)
				end

				if var_57_5.addShield > 0 then
					arg_57_6:addAttackEffect({
						effect_type = 15,
						effect_value = var_57_5.addShield,
						attacker = self,
						victim = self
					}, false)
				end

				return
			end

			if self:doBuff(var_0_12.TYPE.BUFF_331, {
				isImmune = false
			}, {
				buffType = var_57_0.buff_type
			}).isImmune then
				return
			end
		elseif var_57_0.buff_type == var_0_12.TYPE.FORBID_BUFF and self:doBuff(var_0_12.TYPE.BUFF_512, false) then
			return
		end

		if self.classical > 0 and self:doBuff(var_0_12.TYPE.BUFF_551, {
			immune = false
		}, {
			buffId = var_57_0.id
		}).immune then
			return
		end

		if var_57_0.buff_control_type == 1 then
			local var_57_6

			if not arg_57_3.isPlayer then
				if arg_57_3:doBuff(var_0_12.TYPE.PROFESSION_BUFF_2, {
					isImmune = false
				}).isImmune then
					return
				end

				var_57_6 = arg_57_3.knightCfg.quality
			else
				var_57_6 = arg_57_3.skillCfg.skill_quality
			end

			if self:doBuff(var_0_12.TYPE.BUFF_596, {
				isImmune = false
			}, {
				quality = var_57_6
			}).isImmune then
				return
			end

			if self:doBuff(var_0_12.TYPE.BUFF_598, {
				isImmune = false
			}, {
				buffInfo = var_57_0,
				addLevel = var_57_3,
				fightResult = arg_57_6
			}).isImmune then
				return
			end
		end

		if var_57_0.buff_increase_type == 2 then
			local var_57_7 = not arg_57_3.isPlayer and arg_57_3.knightCfg.quality or arg_57_3.skillCfg.skill_quality

			if self:doBuff(var_0_12.TYPE.BUFF_642, {
				isImmune = false
			}, {
				quality = var_57_7,
				notResist = var_57_0.not_resist
			}).isImmune then
				return
			end
		end

		if arg_57_4 then
			for iter_57_0, iter_57_1 in ipairs(self.buffs) do
				if iter_57_1.buffCfg.id == arg_57_1 then
					return
				end
			end
		end

		if var_57_0.max_num > 0 and self:getBuffCount(arg_57_1, false, true) >= var_57_0.max_num then
			return
		end

		if var_57_0.buff_type == var_0_12.TYPE.ATTR and var_57_0.buff_increase_type == 1 then
			local var_57_8 = self:doBuff(var_0_12.TYPE.GET_ATTR_BUFF, {}, {
				curBuff = var_57_0,
				buffTime = arg_57_2
			})

			if var_57_8.addBuff then
				arg_57_6:addBuff(var_57_8.addBuff)
			end
		end

		if not arg_57_3.isPlayer and arg_57_3:doBuff(var_0_12.TYPE.BUFF_621, {
			isEff = false,
			buffInfo = var_57_0
		}).isEff then
			arg_57_6:addBuff({
				buffId = arg_57_1,
				buffTime = arg_57_2,
				attacker = arg_57_3,
				victim = self
			})
		end

		self:doBuff(var_0_12.TYPE.BUFF_324, {}, {
			buffInfo = var_57_0,
			fightResult = arg_57_6
		})

		local var_57_9 = var_0_19(arg_57_1, var_27_29, arg_57_2, self, arg_57_3, arg_57_4, arg_27_4, arg_57_5, true)

		var_27_29 = var_27_29 + 1
		self.buffs[#self.buffs + 1] = var_57_9
		self.buffAddRecord[arg_57_1] = self.buffAddRecord[arg_57_1] or 0
		self.buffAddRecord[arg_57_1] = self.buffAddRecord[arg_57_1] + 1

		self:updateBuffCount(var_57_9.buffCfg)
		self:doBuff(var_0_12.TYPE.BUFF_TRIGGER319, {
			isAffect = false,
			buffEffectType = var_57_0.buff_effect_type
		})

		self.exile = self:doBuff(var_0_12.TYPE.EXILE)
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)

		if var_57_9.buffCfg.buff_type ~= var_0_12.TYPE.ERIS_PENDULUM then
			local var_57_10 = self:doBuff(var_0_12.TYPE.ERIS_PENDULUM, {
				addTimes = 0
			}, {
				addBuff = var_57_9
			})

			if var_57_10 and var_57_10.addTimes ~= 0 then
				var_57_9:addBuffTime2(var_57_10.addTimes)
			end
		end

		self:doBuff(var_0_12.TYPE.RETRACE_MARK, {}, {
			isRecord = true
		})
		self:doBuff(var_0_12.TYPE.BUFF_349, {}, {
			fightResult = arg_57_6
		})

		if var_57_0.id == 26412 then
			for iter_57_2, iter_57_3 in ipairs(var_57_1:getKnightList(3 - arg_27_1)) do
				local var_57_11 = iter_57_3:doBuff(var_0_12.TYPE.BUFF_354, {
					damage = 0
				}, {
					attackTarget = self
				})

				if var_57_11.damage > 0 then
					arg_57_6:addBuffEffect({
						effect_type = 1,
						effect_value = var_57_11.damage,
						attacker = self,
						victim = iter_57_3
					})
				end
			end
		end

		self:doBuff(var_0_12.TYPE.BUFF_395, nil, {
			fightResult = arg_57_6,
			buffEffectType = var_57_0.buff_effect_type
		})
		self:doBuff(var_0_12.TYPE.BUFF_374, nil, {
			buffEffectType = var_57_0.buff_effect_type,
			fightResult = arg_57_6,
			buffTime = arg_57_2
		})

		local var_57_12 = self:doBuff(var_0_12.TYPE.BUFF_386, {
			isEff = false
		})

		if var_57_12.isEff and var_57_12.skillCfg then
			arg_27_4:getBattleData():addPassive({
				costLess = true,
				isSkill = true,
				knight = self,
				info = var_57_12.skillCfg,
				identity = self.identity
			})
		end

		self:doBuff(var_0_12.TYPE.BUFF_520, nil, {
			fightResult = arg_57_6
		})

		if var_57_9.buffCfg.buff_type == var_0_12.TYPE.BUFF_608 then
			self:doBuff(var_0_12.TYPE.BUFF_608, nil, {
				fightResult = arg_57_6
			})
		end

		BLog.LogAddBuff(var_57_9)

		return var_57_9
	end

	function var_27_0:updateBuffCount(arg_58_1, arg_58_2)
		self:_updateBuffCount(var_0_12.COUNT_TYPE.BUFF_TYPE .. arg_58_1.buff_type, arg_58_2)
		self:_updateBuffCount(arg_58_1.buff_effect_type, arg_58_2)

		if not arg_58_2 then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.HISTORY .. arg_58_1.buff_effect_type)
		end

		if arg_58_1.buff_control_type == 1 then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.CONTROL, arg_58_2)
		end

		if arg_58_1.buff_control_type == 1 and arg_58_1.buff_increase_type == 2 then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.NEGATIVE_CONTROL, arg_58_2)
		end

		if arg_58_1.hurtlimit == 1 then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.HURT_LIMIT, arg_58_2)
		end

		if arg_58_1.buff_increase_type == 2 and arg_58_1.buff_type == 1 then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.ATTR_NEGATIVE, arg_58_2)
		end

		if arg_58_1.buff_increase_type ~= 0 then
			self:_updateBuffCount((arg_58_1.buff_increase_type == 1 or nil) and (var_0_12.COUNT_TYPE.POSITIVE or var_0_12.COUNT_TYPE.NEGATIVE), arg_58_2)
		end

		if arg_58_1.max_num > 0 then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.BUFF_ID .. arg_58_1.id, arg_58_2)
		end

		if arg_58_1.buff_attribute_type == 2 and (arg_58_1.buff_effect_type == 2 or arg_58_1.buff_effect_type == 3 or arg_58_1.buff_effect_type == 4) then
			self:_updateBuffCount(var_0_12.COUNT_TYPE.DEFENCE_ATTR, arg_58_2)
		end
	end

	function var_27_0:_updateBuffCount(arg_59_1, arg_59_2)
		self.buffCount[arg_59_1] = self.buffCount[arg_59_1] or 0
		self.buffCount[arg_59_1] = arg_59_2 and var_0_5(0, self.buffCount[arg_59_1] - 1) or self.buffCount[arg_59_1] + 1
	end

	function var_27_0:clearBuff()
		local var_60_0 = {}
		local var_60_1 = {}

		for iter_60_0, iter_60_1 in ipairs(self.buffs) do
			if iter_60_1.buffCheck or iter_60_1.buffCfg.extra_wave_keep == 1 then
				var_0_1.insert(var_60_0, #var_60_0 + 1, iter_60_1)
			else
				iter_60_1:doRemove(true)
				self:updateBuffCount(iter_60_1.buffCfg, true)
				var_0_1.insert(var_60_1, iter_60_1)
			end
		end

		self.buffs = var_60_0
		var_27_29 = 1
		self.exile = self:doBuff(var_0_12.TYPE.EXILE)
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)

		return var_60_1
	end

	function var_27_0:delBuff(arg_61_1)
		local var_61_0

		for iter_61_0, iter_61_1 in ipairs(self.buffs) do
			if iter_61_1.serialId == arg_61_1 then
				var_61_0 = iter_61_1

				var_0_2(self.buffs, iter_61_0)
				iter_61_1:doRemove()
				self:updateBuffCount(iter_61_1.buffCfg, true)

				break
			end
		end

		self.exile = self:doBuff(var_0_12.TYPE.EXILE)
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)

		return var_61_0
	end

	function var_27_0:checkHide()
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)
	end

	function var_27_0:getBuffRecord(arg_63_1)
		return self.buffAddRecord[arg_63_1]
	end

	function var_27_0:setBuffTimes(arg_64_1, arg_64_2)
		for iter_64_0, iter_64_1 in ipairs(self.buffs) do
			if iter_64_1.buffCfg.buff_type == arg_64_1 then
				iter_64_1:setBuffTimes(arg_64_2)

				break
			end
		end
	end

	function var_27_0:doBuff(arg_65_1, arg_65_2, arg_65_3)
		local var_65_0 = {}
		local var_65_1 = {}
		local var_65_3 = self.buffRules[arg_65_1] or {}

		if arg_65_1 == 187 then
			local var_65_4 = 0

			for iter_65_0, iter_65_1 in ipairs(var_65_3) do
				if var_65_4 < iter_65_1.buffCfg.buff_value_1 then
					var_65_4 = iter_65_1.buffCfg.buff_value_1
				end
			end

			var_27_0.KnightLockHpPer = var_65_4 / 1000
		end

		for iter_65_2, iter_65_3 in ipairs(var_65_3) do
			local var_65_6, var_65_7 = iter_65_3:execute(arg_65_1, arg_65_2, arg_65_3, true)

			if var_65_6 then
				arg_65_2 = var_65_7

				var_0_3(var_65_0, iter_65_3.buffCfg)
				var_0_3(var_65_1, iter_65_3.attacker)
			end
		end

		if #var_65_0 > 0 then
			arg_27_4:getBattleData():executeSpRule(var_27_26.TYPE.BUFF_DOING_EFFECT, {
				buffInfoList = var_65_0,
				knight = self
			})
			arg_27_4:getBattleData():executeKnightSpRule(var_27_26.TYPE.BUFF_DOING_EFFECT, {
				buffInfoList = var_65_0,
				knight = self,
				buffAttackList = var_65_1,
				passiveEffectBuffType = arg_65_1
			})
		end

		if arg_65_1 == var_0_12.TYPE.ATTR and #self.marks > 0 then
			for iter_65_4, iter_65_5 in ipairs(self.marks) do
				iter_65_5:execute()
			end
		end

		for iter_65_6, iter_65_7 in ipairs(self.marks) do
			local var_65_11, var_65_12 = iter_65_7:doBuff(arg_65_1, arg_65_2, arg_65_3)

			if var_65_11 then
				arg_65_2 = var_65_12
			end
		end

		return arg_65_2, var_65_0
	end

	function var_27_0:canChangeAnger(arg_66_1)
		if arg_66_1 then
			if self:doBuff(var_0_12.TYPE.DISABLE_RECOVER_ANGER) then
				return false
			end

			if self:doBuff(var_0_12.TYPE.NO_GET_ANGER) then
				return false
			end
		else
			if self:doBuff(var_0_12.TYPE.CONDITION_IMMUNITY_LOSE_ANGER) then
				return false
			end

			if self:doBuff(var_0_12.TYPE.RESIST_DEANGER, false) then
				return false
			end
		end

		return true
	end

	function var_27_0:doResultBuff(arg_67_1, arg_67_2, arg_67_3, arg_67_4, arg_67_5)
		local var_67_1 = arg_67_4

		for iter_67_0, iter_67_1 in ipairs(self.buffRules[arg_67_1] or {}) do
			if var_67_1 <= 0 then
				break
			end

			if arg_67_3 == iter_67_1.buffCfg.id then
				var_67_1 = var_67_1 - 1

				if arg_67_5 > 0 and not iter_67_1.isDone then
					local var_67_4, var_67_5 = iter_67_1:execute(arg_67_1, arg_67_2, nil, true)

					if var_67_4 then
						arg_67_2 = var_67_5

						iter_67_1:doResultRound()
					end
				end
			end
		end

		return arg_67_2
	end

	function var_27_0:doResultBuff2(arg_68_1, arg_68_2, arg_68_3, arg_68_4)
		for iter_68_0, iter_68_1 in ipairs(self.buffRules[arg_68_1] or {}) do
			if arg_68_3 == iter_68_1.buffCfg.buff_effect_type and arg_68_4 > 0 and not iter_68_1.isDone then
				local var_68_3, var_68_4 = iter_68_1:execute(arg_68_1, arg_68_2, nil, true)

				if var_68_3 then
					arg_68_2 = var_68_4

					iter_68_1:doResultRound()
					arg_27_4:getBattleData():executeKnightSpRule(var_27_26.TYPE.BUFF_DOING_EFFECT, {
						buffInfoList = {
							iter_68_1.buffCfg
						},
						knight = self,
						buffAttackList = {
							iter_68_1.attacker
						}
					})
				end
			end
		end

		return arg_68_2
	end

	function var_27_0:doBuffRound(arg_69_1)
		local var_69_0 = {}
		local var_69_1 = {}

		for iter_69_0 = 1, #self.buffs do
			self.buffs[iter_69_0]:doRound(arg_69_1)

			if self.buffs[iter_69_0].isDone then
				var_0_3(var_69_0, self.buffs[iter_69_0])
				var_0_3(var_69_1, 1, iter_69_0)
				self.buffs[iter_69_0]:doRemove()
				self:updateBuffCount(self.buffs[iter_69_0].buffCfg, true)
			else
				self.buffs[iter_69_0]:doClean()
			end
		end

		for iter_69_1 = 1, #var_69_1 do
			var_0_2(self.buffs, var_69_1[iter_69_1])
		end

		self.exile = self:doBuff(var_0_12.TYPE.EXILE)
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)

		return var_69_0
	end

	function var_27_0:doSpBuffRound(arg_70_1, arg_70_2)
		local var_70_0 = {}
		local var_70_1 = {}

		for iter_70_0 = 1, #self.buffs do
			self.buffs[iter_70_0]:doSpRound(arg_70_1, arg_70_2)

			if self.buffs[iter_70_0].isDone then
				var_0_3(var_70_0, self.buffs[iter_70_0])
				var_0_3(var_70_1, 1, iter_70_0)
				self.buffs[iter_70_0]:doRemove()
				self:updateBuffCount(self.buffs[iter_70_0].buffCfg, true)
			else
				self.buffs[iter_70_0]:doClean()
			end
		end

		for iter_70_1 = 1, #var_70_1 do
			var_0_2(self.buffs, var_70_1[iter_70_1])
		end

		self.exile = self:doBuff(var_0_12.TYPE.EXILE)
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)

		return var_70_0
	end

	function var_27_0:checkBuffDisappear(arg_71_1, arg_71_2)
		for iter_71_0, iter_71_1 in ipairs(self.buffs) do
			iter_71_1:checkDisappear(arg_71_1, arg_71_2)
		end
	end

	function var_27_0:delBuffByType(arg_72_1)
		for iter_72_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_72_0].buffCfg.buff_type == arg_72_1 then
				var_0_2(self.buffs, iter_72_0)
				self.buffs[iter_72_0]:doRemove()
				self:updateBuffCount(self.buffs[iter_72_0].buffCfg, true)
			end
		end

		self.exile = self:doBuff(var_0_12.TYPE.EXILE)
		self.hide = self:doBuff(var_0_12.TYPE.HIDE_CAN_NOT_SELECT)
	end

	function var_27_0:hasBuffByEffectType(arg_73_1)
		for iter_73_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_73_0].buffCfg.buff_effect_type == arg_73_1 then
				return true
			end
		end

		return false
	end

	function var_27_0:hasBuffByElementalType(arg_74_1)
		for iter_74_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_74_0].buffCfg.buff_elemental_type == arg_74_1 then
				return true
			end
		end

		return false
	end

	function var_27_0:getBuffCntByEffectType(arg_75_1)
		local var_75_0 = 0

		for iter_75_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_75_0].buffCfg.buff_effect_type == arg_75_1 then
				var_75_0 = var_75_0 + 1
			end
		end

		return var_75_0
	end

	function var_27_0:getBuffsByEffectType(arg_76_1)
		local var_76_0 = {}

		for iter_76_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_76_0].buffCfg.buff_effect_type == arg_76_1 then
				var_0_3(var_76_0, self.buffs[iter_76_0])
			end
		end

		return var_76_0
	end

	function var_27_0:getBuffs()
		return self.buffs
	end

	function var_27_0:getBuffCount(arg_78_1, arg_78_2, arg_78_3)
		if arg_78_2 then
			arg_78_1 = var_0_12.COUNT_TYPE.BUFF_TYPE .. arg_78_1
		end

		if arg_78_3 then
			arg_78_1 = var_0_12.COUNT_TYPE.BUFF_ID .. arg_78_1
		end

		if not self.buffCount[arg_78_1] then
			return 0
		end

		return self.buffCount[arg_78_1]
	end

	function var_27_0:transform(arg_79_1)
		self.baseInfo.id = arg_79_1.image_knight_id

		local var_79_0 = var_27_2.get(arg_79_1.image_knight_id).toObject()

		self.knightCfg = var_79_0
		self.commonSkillCfg = var_0_13.get(var_79_0.common_id).toObject()
		self.activeSkillCfg = var_0_13.get(var_79_0.active_skill_id).toObject()
		self.energySkillCfg = nil

		if var_79_0.energy_skill_id > 0 then
			self.energySkillCfg = var_0_13.get(var_79_0.energy_skill_id).toObject()
		end

		self.warBandSkillCfg = nil

		if var_79_0.army_skill_id > 0 then
			self.warBandSkillCfg = var_0_13.get(var_79_0.army_skill_id).toObject()
		end

		self.energyRules = var_27_28.initRule(self, ((function(arg_80_0)
			local var_80_0 = {}

			while var_27_2.hasKey("energy_type_" .. 1) do
				if arg_80_0["energy_type_" .. 1] > 0 then
					var_0_3(var_80_0, {
						type = arg_80_0["energy_type_" .. 1],
						value = arg_80_0["energy_value_" .. 1]
					})
				end
			end

			return var_80_0
		end)(var_79_0)))

		local var_79_2 = var_0_22(var_79_0)

		if arg_79_1.image_type == 1 then
			if next(self.passiveSkillIds) then
				for iter_79_0 = 1, #self.passiveSkillIds do
					self.skills[#self.skills] = nil
				end
			end

			for iter_79_1, iter_79_2 in ipairs(var_79_2) do
				self.skills[#self.skills + 1] = iter_79_2
			end
		else
			self.skills = next(var_79_2) and var_79_2 or {}

			self:clearBuff()
			self:clearPassiveSkill()
		end

		self.passiveSkillIds = var_79_2
		self.spRules = var_27_26.initRule(self.skills, self.identity, arg_27_4, self)

		for iter_79_3, iter_79_4 in pairs(self.spRules) do
			local var_79_3 = self.spRules[iter_79_3] or {}

			for iter_79_5, iter_79_6 in ipairs(iter_79_4) do
				for iter_79_7, iter_79_8 in ipairs(var_79_3) do
					if iter_79_6.info.id == iter_79_8.info.id then
						iter_79_6.count = iter_79_8.count
						iter_79_6.round = iter_79_8.round

						break
					end
				end
			end
		end

		if arg_79_1.hp_inherit_type == 1 then
			self.baseInfo.INITIAL_HP = var_0_4.min(var_0_4.floor(self.baseInfo.INITIAL_HP * arg_79_1.hp_inherit_num / 1000), self.originInfo.INITIAL_HP)
		else
			local var_79_4 = var_0_4.floor(self.originInfo.INITIAL_HP * arg_79_1.hp_inherit_num / 1000)

			self.originInfo.INITIAL_HP = var_79_4
			self.baseInfo.INITIAL_HP = var_79_4
		end

		self.baseInfo.INITIAL_ENERGY = var_79_0.initial_energy
		self.baseInfo.ATTACK = var_0_4.floor(self.baseInfo.ATTACK * arg_79_1.attack_inherit_num / 1000)
		self.baseInfo.PHY_DEFENCE = var_0_4.floor(self.baseInfo.PHY_DEFENCE * arg_79_1.defence_inherit_num / 1000)
		self.baseInfo.MAG_DEFENCE = var_0_4.floor(self.baseInfo.MAG_DEFENCE * arg_79_1.defence_inherit_num / 1000)

		if arg_79_1.other_attributes_inherit_num ~= 1000 then
			for iter_79_9, iter_79_10 in pairs(var_0_8) do
				if iter_79_10 > 100 and iter_79_10 < 600 then
					self.baseInfo[iter_79_9] = var_0_4.floor(self.baseInfo[iter_79_9] * arg_79_1.other_attributes_inherit_num / 1000)
				end
			end
		end

		for iter_79_11 = 1, 4 do
			if arg_79_1["affect_type_" .. iter_79_11] > 0 then
				if arg_79_1["affect_type_" .. iter_79_11] == 1 then
					self.originInfo[var_0_9[arg_79_1["affect_type_" .. iter_79_11]]] = self.originInfo[var_0_9[arg_79_1["affect_type_" .. iter_79_11]]] + arg_79_1["affect_value_" .. iter_79_11]
				end

				self.baseInfo[var_0_9[arg_79_1["affect_type_" .. iter_79_11]]] = self.baseInfo[var_0_9[arg_79_1["affect_type_" .. iter_79_11]]] + arg_79_1["affect_value_" .. iter_79_11]
			end
		end
	end

	function var_27_0:isReal()
		return not self.isDead and not self.willAssist or self.isGhost
	end

	function var_27_0:isValid(arg_82_1)
		local var_82_0 = self.hide

		if self.hide and arg_82_1 then
			local var_82_1 = self:doBuff(var_0_12.TYPE.BUFF_IGNORE_HIDE, {
				isEff = false,
				damage = 0
			}, {
				attacker = arg_82_1
			})

			if var_82_1 and var_82_1.isEff then
				var_82_0 = false
			end

			local var_82_2 = self:doBuff(var_0_12.TYPE.BUFF_356, {
				isEff = false
			}, {
				attacker = arg_82_1
			})

			if var_82_2 and var_82_2.isEff then
				var_82_0 = false
			end
		end

		local var_82_3 = self.exile

		if self.exile and arg_82_1 then
			local var_82_4 = self:doBuff(var_0_12.TYPE.BUFF_356, {
				isEff = false
			}, {
				attacker = arg_82_1
			})

			if var_82_4 and var_82_4.isEff then
				var_82_3 = false
			end
		end

		return self:isReal() and not var_82_3 and not var_82_0
	end

	function var_27_0:canAction()
		return not self.isDead and not self.willAssist and not self.isGhost
	end

	function var_27_0:exitExile()
		local var_84_0

		for iter_84_0, iter_84_1 in ipairs(self.buffs) do
			if iter_84_1.buffCfg.buff_type == var_0_12.TYPE.EXILE then
				var_84_0 = self:delBuff(iter_84_1.serialId)

				break
			end
		end

		return var_84_0
	end

	function var_27_0:addSkillTimes(arg_85_1, arg_85_2)
		self.skillTimes[arg_85_1] = self.skillTimes[arg_85_1] or 0
		arg_85_2 = arg_85_2 or 1
		self.skillTimes[arg_85_1] = self.skillTimes[arg_85_1] + arg_85_2
	end

	function var_27_0:getSkillTimes(arg_86_1)
		return self.skillTimes[arg_86_1] or 0
	end

	function var_27_0:doDead()
		self.isDead = true

		if self.isMonster and self.knightCfg.if_ghost == 1 then
			self.isGhost = true
		end

		for iter_87_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_87_0].buffCfg.buff_position_type == 0 then
				var_0_2(self.buffs, iter_87_0)
				self.buffs[iter_87_0]:doRemove(true)
				self:updateBuffCount(self.buffs[iter_87_0].buffCfg, true)
			end
		end
	end

	function var_27_0:reborn()
		for iter_88_0 = #self.buffs, 1, -1 do
			if self.buffs[iter_88_0].buffCfg.buff_position_type == 0 then
				var_0_2(self.buffs, iter_88_0)
				self.buffs[iter_88_0]:doRemove(true)
				self:updateBuffCount(self.buffs[iter_88_0].buffCfg, true)
			end
		end

		self:clearAdvanceInfo()
	end

	function var_27_0:addRebornCount()
		self.rebornCount = self.rebornCount + 1
	end

	function var_27_0:addMark(arg_90_1, arg_90_2, arg_90_3)
		local var_90_0
		local var_90_1 = var_0_16.get(arg_90_1)

		for iter_90_0, iter_90_1 in ipairs(self.marks) do
			if iter_90_1.mType == var_90_1.type then
				var_90_0 = iter_90_1
			end
		end

		if var_90_0 then
			var_90_0:addLevel(arg_90_1, arg_90_2)
		else
			local var_90_2 = var_0_20(arg_90_1, self, arg_90_3)

			self.marks[#self.marks + 1] = var_90_2

			var_90_2:addLevel(arg_90_1, arg_90_2)
		end
	end

	function var_27_0:removeMark(arg_91_1, arg_91_2)
		local var_91_0

		for iter_91_0, iter_91_1 in ipairs(self.marks) do
			if iter_91_1.mType == arg_91_1 then
				var_91_0 = iter_91_1
			end
		end

		if var_91_0 then
			var_91_0:delLevel(arg_91_2)
		end
	end

	function var_27_0:getMarkLevel(arg_92_1)
		for iter_92_0, iter_92_1 in ipairs(self.marks) do
			if iter_92_1.mType == arg_92_1 then
				return iter_92_1.level
			end
		end

		return 0
	end

	function var_27_0:clearMark()
		local var_93_0 = {}
		local var_93_1 = {}
		local var_93_2 = {}

		for iter_93_0, iter_93_1 in ipairs(self.marks) do
			if iter_93_1.markCfg.extra_wave_keep > 0 then
				var_0_1.insert(var_93_1, iter_93_1)

				var_93_2[iter_93_1.markCfg.type] = self:getMarkSkillNum(iter_93_1.markCfg.type)
			else
				var_0_1.insert(var_93_0, iter_93_1)
			end
		end

		self.marks = var_93_1
		self.markSkillNum = var_93_2

		return var_93_0
	end

	function var_27_0:updateHp(arg_94_1, arg_94_2)
		if self.isDead then
			return
		end

		local var_94_0 = self.baseInfo.INITIAL_HP

		if arg_94_1 >= 0 then
			self.baseInfo.INITIAL_HP = var_0_6(self.baseInfo.INITIAL_HP + arg_94_1, self.originInfo.INITIAL_HP)
		elseif arg_94_2 then
			self.baseInfo.INITIAL_HP = var_0_5(self.baseInfo.INITIAL_HP + arg_94_1, 0)
		elseif self.baseInfo.SHIELD + arg_94_1 < 0 then
			self.baseInfo.SHIELD = 0
			self.baseInfo.INITIAL_HP = var_0_5(self.baseInfo.INITIAL_HP + self.baseInfo.SHIELD + arg_94_1, 0)
		else
			self.baseInfo.SHIELD = self.baseInfo.SHIELD + arg_94_1
		end

		BLog.LogHpChange(self, var_94_0, self.baseInfo.INITIAL_HP, arg_94_1)
	end

	function var_27_0:changeInitialHp(arg_95_1)
		self.originInfo.INITIAL_HP = self.originInfo.INITIAL_HP + arg_95_1
		self.baseInfo.INITIAL_HP = self.originInfo.INITIAL_HP - (self.originInfo.INITIAL_HP - self.baseInfo.INITIAL_HP)
		self.advanceInfo.INITIAL_HP = self.originInfo.INITIAL_HP - (self.originInfo.INITIAL_HP - self.advanceInfo.INITIAL_HP)
	end

	function var_27_0:getSkillAffectTimes(arg_96_1, arg_96_2)
		self.skillAffectTimes[arg_96_1 .. "_" .. arg_96_2] = self.skillAffectTimes[arg_96_1 .. "_" .. arg_96_2] or 0

		return self.skillAffectTimes[arg_96_1 .. "_" .. arg_96_2]
	end

	function var_27_0:addSkillAffectTimes(arg_97_1, arg_97_2, arg_97_3)
		self.skillAffectTimes[arg_97_1 .. "_" .. arg_97_2] = self.skillAffectTimes[arg_97_1 .. "_" .. arg_97_2] or 0
		self.skillAffectTimes[arg_97_1 .. "_" .. arg_97_2] = self.skillAffectTimes[arg_97_1 .. "_" .. arg_97_2] + arg_97_3
	end

	function var_27_0:addMarkSkillNum(arg_98_1)
		self.markSkillNum[arg_98_1] = self.markSkillNum[arg_98_1] or 0
		self.markSkillNum[arg_98_1] = self.markSkillNum[arg_98_1] + 1
	end

	function var_27_0:getMarkSkillNum(arg_99_1)
		return self.markSkillNum[arg_99_1] or 0
	end

	function var_27_0:getSufferDamage()
		return self.sufferDamage
	end

	function var_27_0.setSufferDamage(arg_101_0, arg_101_1)
		arg_101_0.sufferDamage = arg_101_1
	end

	function var_27_0:getAttackDamage()
		return self.attackDamage
	end

	function var_27_0.setAttackDamage(arg_103_0, arg_103_1)
		arg_103_0.attackDamage = arg_103_1
	end

	function var_27_0:addSuccubaCount(arg_104_1, arg_104_2)
		local var_104_0 = self.roundAddSuccubaCount[arg_104_1] or 0
		local var_104_1 = var_104_0
		local var_104_2 = var_0_4.min(var_104_0 + arg_104_2, var_0_14.get(var_0_15.ROUND_RECOVER_ENERGY_MAX).parameter)

		self.roundAddSuccubaCount[arg_104_1] = var_104_2

		return var_104_2 - var_104_1
	end

	function var_27_0:canClearBuff()
		if self:doBuff(var_0_12.TYPE.CLEAT_BUFF_FAILED) then
			return false
		end

		return true
	end

	return var_27_0
end

return var_0_17
