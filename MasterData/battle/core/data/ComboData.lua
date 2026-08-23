local var_0_0 = table.insert
local var_0_2 = load("const.BattleConst")
local var_0_3 = loadCfg("core.config.cfg.battle_quality_counter_info")
local var_0_4 = var_0_2.Q_SUPPRESS_MODULE
local var_0_5 = var_0_2.Q_SUPPRESS_TYPE
local ComboData = class("ComboData")
local var_0_8 = load("const.BattleAttr")

function ComboData:create(arg_1_1)
	return ComboData.new(self, arg_1_1)
end

function ComboData:ctor(arg_2_1, arg_2_2)
	self.attrs = {}
	self.skills = {}
	self.advSkills = {}
	self.skillIndex = {}
	self.skillCount = {}
	self.baseInfo = self.attrs
	self.advanceInfo = self.attrs
	self._qualitySuppressData = nil
	self._maxQuality = 0

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.attrs or {}) do
		var_2_0[iter_2_1.type] = iter_2_1.value
	end

	if arg_2_2 then
		var_2_0[var_0_8.INITIAL_COMBO] = arg_2_2.attrs.INITIAL_COMBO
	end

	for iter_2_2, iter_2_3 in pairs(var_0_8) do
		self.attrs[iter_2_2] = var_2_0[iter_2_3] and var_2_0[iter_2_3] or 0
	end

	local var_2_1 = arg_2_1.level or {}

	if arg_2_1.tokens then
		for iter_2_4 = 1, #arg_2_1.tokens do
			self.skills[arg_2_1.tokens[iter_2_4]] = self.skills[arg_2_1.tokens[iter_2_4]] or load("core.data.ComboSkill"):create(var_2_1[iter_2_4])
			self.advSkills[self.skills[arg_2_1.tokens[iter_2_4]]:getAdvId()] = self.skills[arg_2_1.tokens[iter_2_4]]
			self.skillIndex[iter_2_4] = arg_2_1.tokens[iter_2_4]
			self.skillCount[arg_2_1.tokens[iter_2_4]] = 0
		end
	end

	self._isBoss = false
end

function ComboData:updateComboValue(arg_3_1, arg_3_2)
	arg_3_1 = math.max(arg_3_1, -self.baseInfo.INITIAL_COMBO)
	arg_3_1 = math.min(arg_3_1, self.baseInfo.MAXIMUM_COMBO - self.baseInfo.INITIAL_COMBO)

	if not arg_3_2 then
		self.baseInfo.INITIAL_COMBO = self.baseInfo.INITIAL_COMBO + arg_3_1
	end

	return arg_3_1
end

function ComboData:hasSkill(arg_4_1)
	return self.skills[arg_4_1] ~= nil
end

function ComboData:getSkillLevel(arg_5_1)
	if not self.skills[arg_5_1] then
		return 0
	end

	return self.skills[arg_5_1].level
end

function ComboData:updateSkills(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.skills) do
		if iter_6_1:isCooling() and iter_6_1:recover() then
			var_0_0(var_6_0, {
				id = iter_6_0,
				cd_time = iter_6_1:getCD()
			})
		end
	end

	return var_6_0
end

function ComboData:useSkill(arg_7_1)
	if not self.skills[arg_7_1] then
		return
	end

	self.skillCount[arg_7_1] = self.skillCount[arg_7_1] + 1

	return (self.skills[arg_7_1]:calmdown())
end

function ComboData:isSkillReady(arg_8_1, arg_8_2)
	if not self.skills[arg_8_1] or not self.skills[arg_8_1]:isReady() then
		return false
	end

	if self.skills[arg_8_1]:getSkillCfg().rage_value + (arg_8_2 or 0) <= self.baseInfo.INITIAL_COMBO then
		return true
	end

	return false
end

function ComboData:getAvailableSkills(arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, #self.skillIndex do
		local var_9_1 = 0

		if arg_9_1 then
			if self.skills[self.skillIndex[iter_9_0]] then
				var_9_1 = arg_9_1(self.skills[self.skillIndex[iter_9_0]]:getAdvId()) or 0
			end
		end

		if self:isSkillReady(self.skillIndex[iter_9_0], var_9_1) then
			var_9_0[#var_9_0 + 1] = {
				id = self.skillIndex[iter_9_0],
				count = self.skillCount[self.skillIndex[iter_9_0]]
			}
		end
	end

	return var_9_0
end

function ComboData:getCanUseSkillIdForAi(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.skillIndex) do
		local var_10_0 = self.skills[iter_10_1]

		if self.skills[iter_10_1] and var_10_0:isReady() then
			if self.baseInfo.INITIAL_COMBO >= var_10_0:getSkillCfg().rage_value + (arg_10_1 and (arg_10_1(var_10_0:getAdvId()) or 0) or 0) then
				return iter_10_1
			else
				break
			end
		end
	end
end

function ComboData:getSkills()
	return self.skills
end

function ComboData:getSkillByAdvId(arg_12_1)
	return self.advSkills[arg_12_1]
end

function ComboData:calculationQualitySuppress()
	self._qualitySuppressData = {}

	if self._isBoss then
		local var_13_0 = 0
		local var_13_1 = 0
		local var_13_2 = {}

		for iter_13_0, iter_13_1 in pairs(self.skills) do
			if iter_13_1 then
				var_13_0 = math.max(var_13_0, iter_13_1:getQuality())
				var_13_1 = math.max(var_13_1, iter_13_1:getStar())
			end
		end

		var_13_2[var_13_0] = var_13_2[var_13_0] or {
			[var_0_5.FORMULA] = 0,
			[var_0_5.BUFF] = 0,
			[var_0_5.PASSIVE] = 0,
			[var_0_5.EFFECT] = 0,
			default = {
				[var_0_5.FORMULA] = 0,
				[var_0_5.BUFF] = 0,
				[var_0_5.PASSIVE] = 0,
				[var_0_5.EFFECT] = 0
			}
		}

		self:_calculationQSData(var_0_4.TOKEN, var_0_5.FORMULA, var_13_0, var_13_1, var_13_2[var_13_0], 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.BUFF, var_13_0, var_13_1, var_13_2[var_13_0], 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.PASSIVE, var_13_0, var_13_1, var_13_2[var_13_0], 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.EFFECT, var_13_0, var_13_1, var_13_2[var_13_0], 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.FORMULA, 999, var_13_1, var_13_2[var_13_0].default, 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.BUFF, 999, var_13_1, var_13_2[var_13_0].default, 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.PASSIVE, 999, var_13_1, var_13_2[var_13_0].default, 4)
		self:_calculationQSData(var_0_4.TOKEN, var_0_5.EFFECT, 999, var_13_1, var_13_2[var_13_0].default, 4)

		self._maxQuality = var_13_0
		self._qualitySuppressData = var_13_2
	else
		local var_13_3 = 0
		local var_13_4 = {}

		for iter_13_2, iter_13_3 in pairs(self.skills) do
			if iter_13_3 then
				local var_13_5 = iter_13_3:getQuality()

				if var_13_3 < var_13_5 then
					var_13_3 = var_13_5
				end

				var_13_4[var_13_5] = var_13_4[var_13_5] or {
					[var_0_5.FORMULA] = 0,
					[var_0_5.BUFF] = 0,
					[var_0_5.PASSIVE] = 0,
					[var_0_5.EFFECT] = 0,
					default = {
						[var_0_5.FORMULA] = 0,
						[var_0_5.BUFF] = 0,
						[var_0_5.PASSIVE] = 0,
						[var_0_5.EFFECT] = 0
					}
				}

				self:_calculationQSData(var_0_4.TOKEN, var_0_5.FORMULA, var_13_5, iter_13_3:getStar(), var_13_4[var_13_5])
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.BUFF, var_13_5, iter_13_3:getStar(), var_13_4[var_13_5])
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.PASSIVE, var_13_5, iter_13_3:getStar(), var_13_4[var_13_5])
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.EFFECT, var_13_5, iter_13_3:getStar(), var_13_4[var_13_5])
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.FORMULA, 999, iter_13_3:getStar(), var_13_4[var_13_5].default)
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.BUFF, 999, iter_13_3:getStar(), var_13_4[var_13_5].default)
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.PASSIVE, 999, iter_13_3:getStar(), var_13_4[var_13_5].default)
				self:_calculationQSData(var_0_4.TOKEN, var_0_5.EFFECT, 999, iter_13_3:getStar(), var_13_4[var_13_5].default)
			end
		end

		self._maxQuality = var_13_3
		self._qualitySuppressData = var_13_4
	end
end

function ComboData:getQualitySuppress(arg_14_1, arg_14_2)
	if not self._qualitySuppressData then
		self:calculationQualitySuppress()
	end

	local var_14_0 = self._maxQuality

	if self._maxQuality < var_0_2.START_QUALITY then
		return 0
	end

	local var_14_1 = self._qualitySuppressData
	local var_14_2 = 0

	if var_14_0 - arg_14_2 >= 1 then
		local var_14_3 = var_14_1[arg_14_2 + 1] or {}
		local var_14_4 = var_14_3[arg_14_1] or 0

		if var_14_4 > 0 then
			var_14_2 = math.clamp(var_14_2 + var_14_4, var_14_3.minValue, var_14_3.maxValue)
		end
	end

	if var_14_0 - arg_14_2 >= 2 then
		local var_14_5

		if var_14_1[arg_14_2 + 2] then
			var_14_5 = var_14_1[arg_14_2 + 2].default or {}
		end

		local var_14_6 = var_14_5[arg_14_1] or 0

		if var_14_6 > 0 then
			var_14_2 = math.clamp(var_14_2 + var_14_6, var_14_5.minValue, var_14_5.maxValue)
		end
	end

	if var_14_0 - arg_14_2 >= 3 then
		-- block empty
	end

	return var_14_2
end

function ComboData:_calculationQSData(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	arg_15_6 = arg_15_6 or 1

	local var_15_0 = var_0_3.get(arg_15_1, arg_15_3, arg_15_4, arg_15_2)

	if var_15_0 then
		arg_15_5.minValue = 1000 - var_15_0.value_low
		arg_15_5.maxValue = 1000 - var_15_0.value_high
		arg_15_5[arg_15_2] = arg_15_5[arg_15_2] + var_15_0.value1 * arg_15_6
	end
end

function ComboData:setIsBoss(arg_16_1)
	return
end

return ComboData
