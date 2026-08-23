local var_0_0 = table.insert
local var_0_2 = load("const.BattleConst")
local var_0_3 = loadCfg("core.config.cfg.battle_quality_counter_info")
local var_0_4 = loadCfg("core.config.cfg.succuba_parameter_info")
local var_0_5 = var_0_2.Q_SUPPRESS_MODULE
local var_0_6 = var_0_2.Q_SUPPRESS_TYPE
local var_0_8 = loadCfg("core.config.cfg.succuba_info")
local var_0_9 = var_0_2.SUCCUBA_PARAM
local SuccubaData = class("SuccubaData")

function SuccubaData:create(arg_1_1)
	return SuccubaData.new(self, arg_1_1)
end

function SuccubaData:ctor(arg_2_1, arg_2_2)
	self.skills = {}
	self.advSkills = {}
	self.skillIndex = {}
	self.skillCount = {}
	self.skillIdMap = {}
	self._lastAttackId = 0
	self._succubaInfos = {}
	self._energyValue = var_0_4.get(var_0_9.INIT_ENERGY_VALUE).parameter
	self._qualitySuppressData = nil

	if not arg_2_1 then
		return
	end

	if arg_2_1 then
		for iter_2_0 = 1, #arg_2_1 do
			self._succubaInfos[iter_2_0] = var_0_8.get(arg_2_1[iter_2_0].id)
			self.skills[arg_2_1[iter_2_0].id] = self.skills[arg_2_1[iter_2_0].id] or load("core.data.SuccubaSkill"):create(arg_2_1[iter_2_0].level)
			self.advSkills[self.skills[arg_2_1[iter_2_0].id]:getAdvId()] = self.skills[arg_2_1[iter_2_0].id]
			self.skillIndex[iter_2_0] = arg_2_1[iter_2_0].id
			self.skillIdMap[arg_2_1[iter_2_0].id] = iter_2_0
			self.skillCount[arg_2_1[iter_2_0].id] = 0
		end
	end
end

function SuccubaData:getShowAdvId()
	if not self.skillIndex[1] then
		return 0
	end

	return self.skills[self.skillIndex[1]]:getAdvId()
end

function SuccubaData:updateSuccubaValue(arg_4_1, arg_4_2)
	arg_4_1 = math.max(arg_4_1, -self._energyValue)
	arg_4_1 = math.min(arg_4_1, var_0_4.get(var_0_9.MAX_ENERGY_VALUE).parameter - self._energyValue)

	if not arg_4_2 then
		self._energyValue = self._energyValue + arg_4_1
	end

	return arg_4_1
end

function SuccubaData:hasSkill(arg_5_1)
	return self.skills[arg_5_1] ~= nil
end

function SuccubaData:getSkillLevel(arg_6_1)
	if not self.skills[arg_6_1] then
		return 0
	end

	return self.skills[arg_6_1].level
end

function SuccubaData:updateSkills(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.skills) do
		if iter_7_1:isCooling() and iter_7_1:recover() then
			var_0_0(var_7_0, {
				id = iter_7_0,
				cd_time = iter_7_1:getCD()
			})
		end
	end

	return var_7_0
end

function SuccubaData:useSkill(arg_8_1)
	if not self.skills[arg_8_1] then
		return
	end

	self._lastAttackId = self.skillIdMap[arg_8_1]
	self.skillCount[arg_8_1] = self.skillCount[arg_8_1] + 1

	return (self.skills[arg_8_1]:calmdown())
end

function SuccubaData:getCdTime(arg_9_1)
	if self.skills[arg_9_1] then
		return self.skills[arg_9_1]:getCD()
	end

	return 0
end

function SuccubaData:isSkillReady(arg_10_1)
	if not self.skills[arg_10_1] or not self.skills[arg_10_1]:isReady() then
		return false
	end

	if self._energyValue >= self.skills[arg_10_1]:getSkillCfg().rage_value then
		return true
	end

	return false
end

function SuccubaData:getAvailableSkills()
	local var_11_0 = {}

	for iter_11_0 = 1, #self.skillIndex do
		if self:isSkillReady(self.skillIndex[iter_11_0]) then
			var_11_0[#var_11_0 + 1] = {
				id = self.skillIndex[iter_11_0],
				count = self.skillCount[self.skillIndex[iter_11_0]]
			}
		end
	end

	return var_11_0
end

function SuccubaData:getCanUseSkillIdForAi()
	local var_12_0 = self._lastAttackId + 1

	if not self.skillIndex[self._lastAttackId + 1] then
		var_12_0 = 1
	end

	if self.skills[self.skillIndex[var_12_0]] and self.skills[self.skillIndex[var_12_0]]:isReady() and self._energyValue >= self.skills[self.skillIndex[var_12_0]]:getSkillCfg().rage_value then
		return self.skillIndex[var_12_0]
	end
end

function SuccubaData:getSuccubaSort()
	local var_13_0 = self._lastAttackId + 1
	local var_13_1 = {}

	while not false do
		if self.skillIndex[var_13_0] then
			table.insert(var_13_1, self.skillIndex[self.skillIdMap[self.skillIndex[var_13_0]]])

			var_13_0 = var_13_0 + 1
		else
			var_13_0 = 1
		end

		local var_13_2

		if var_13_0 == self._lastAttackId + 1 then
			var_13_2 = true
		end
	end

	return var_13_1
end

function SuccubaData:getSkills()
	return self.skills
end

function SuccubaData:getSkillByAdvId(arg_15_1)
	return self.advSkills[arg_15_1]
end

function SuccubaData:calculationQualitySuppress()
	self._qualitySuppressData = {}

	local var_16_0 = 0
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(self.skills) do
		if iter_16_1 then
			local var_16_2 = iter_16_1:getQuality()

			if var_16_0 < var_16_2 then
				var_16_0 = var_16_2
			end

			var_16_1[var_16_2] = var_16_1[var_16_2] or {
				[var_0_6.FORMULA] = 0,
				[var_0_6.BUFF] = 0,
				[var_0_6.PASSIVE] = 0,
				[var_0_6.EFFECT] = 0,
				default = {
					[var_0_6.FORMULA] = 0,
					[var_0_6.BUFF] = 0,
					[var_0_6.PASSIVE] = 0,
					[var_0_6.EFFECT] = 0
				}
			}

			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.FORMULA, var_16_2, iter_16_1:getStar(), var_16_1[var_16_2])
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.BUFF, var_16_2, iter_16_1:getStar(), var_16_1[var_16_2])
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.PASSIVE, var_16_2, iter_16_1:getStar(), var_16_1[var_16_2])
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.EFFECT, var_16_2, iter_16_1:getStar(), var_16_1[var_16_2])
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.FORMULA, 999, iter_16_1:getStar(), var_16_1[var_16_2].default)
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.BUFF, 999, iter_16_1:getStar(), var_16_1[var_16_2].default)
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.PASSIVE, 999, iter_16_1:getStar(), var_16_1[var_16_2].default)
			self:_calculationQSData(var_0_5.SUCCUBA, var_0_6.EFFECT, 999, iter_16_1:getStar(), var_16_1[var_16_2].default)
		end
	end

	self._qualitySuppressData = var_16_1
	self._maxQuality = var_16_0
end

function SuccubaData:_calculationQSData(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = var_0_3.get(arg_17_1, arg_17_3, arg_17_4, arg_17_2)

	if var_17_0 then
		arg_17_5.minValue = 1000 - var_17_0.value_low
		arg_17_5.maxValue = 1000 - var_17_0.value_high
		arg_17_5[arg_17_2] = arg_17_5[arg_17_2] + var_17_0.value1
	end
end

function SuccubaData:getQualitySuppress(arg_18_1, arg_18_2)
	if not self._qualitySuppressData then
		self:calculationQualitySuppress()
	end

	local var_18_0 = self._maxQuality

	if self._maxQuality < var_0_2.START_QUALITY then
		return 0
	end

	local var_18_1 = self._qualitySuppressData
	local var_18_2 = 0

	if var_18_0 - arg_18_2 >= 1 then
		local var_18_3 = var_18_1[arg_18_2 + 1] or {}
		local var_18_4 = var_18_3[arg_18_1] or 0

		if var_18_4 > 0 then
			var_18_2 = math.clamp(var_18_2 + var_18_4, var_18_3.minValue, var_18_3.maxValue)
		end
	end

	if var_18_0 - arg_18_2 >= 2 then
		local var_18_5

		if var_18_1[arg_18_2 + 2] then
			var_18_5 = var_18_1[arg_18_2 + 2].default or {}
		end

		local var_18_6 = var_18_5[arg_18_1] or 0

		if var_18_6 > 0 then
			var_18_2 = math.clamp(var_18_2 + var_18_6, var_18_5.minValue, var_18_5.maxValue)
		end
	end

	if var_18_0 - arg_18_2 >= 3 then
		-- block empty
	end

	return var_18_2
end

function SuccubaData:getSuccubaInfo()
	return self._succubaInfos
end

return SuccubaData
