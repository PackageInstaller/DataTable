local SkillSummonData = class("SkillSummonData")

function SkillSummonData:createSkillSummon(arg_1_1, arg_1_2, arg_1_3)
	return SkillSummonData.new(self, arg_1_1, arg_1_2, arg_1_3)
end

function SkillSummonData:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.serialId = arg_2_1
	self.summonCfg = arg_2_2
	self.triggerTimes = {}
	self.skillTimes = {}
	self.spRules = {}
	self.identity = arg_2_3.identity
	self.owner = arg_2_3
	self.isDone = false
	self.battleField = arg_2_4
	self.attacker = nil

	local var_2_0 = {}

	for iter_2_0 = 1, 3 do
		local var_2_1 = 0

		var_2_1 = iter_2_0 == 1 and arg_2_2.passive_skill_id or arg_2_2["passive_skill_id_" .. iter_2_0]

		if var_2_1 > 0 then
			table.insert(var_2_0, var_2_1)

			local var_2_2 = loadCfg("core.config.cfg.passive_skill_info").get(var_2_1)

			self.triggerTimes[var_2_2.passive_skill_value] = 0
			self.skillTimes[var_2_2.passive_skill_value] = 0
		end
	end

	self.spRules = load("core.rule.SkillSpecialRule"):initRule(self.identity, arg_2_4, arg_2_3)
end

function SkillSummonData:executeSpRule(arg_3_1, arg_3_2)
	if self.spRules[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(self.spRules[arg_3_1]) do
			if iter_3_1:check(arg_3_2) and iter_3_1:execute() then
				self.triggerTimes[iter_3_1.info.passive_skill_value] = self.triggerTimes[iter_3_1.info.passive_skill_value] or 0

				if self.summonCfg.act_max_num == 0 or self.summonCfg.act_max_num > self.triggerTimes[iter_3_1.info.passive_skill_value] then
					self.battleField:getBattleData():addPassive({
						info = iter_3_1.info,
						skillSummon = self
					})

					self.triggerTimes[iter_3_1.info.passive_skill_value] = self.triggerTimes[iter_3_1.info.passive_skill_value] + 1
				end
			end
		end
	end
end

function SkillSummonData:doSkillRelease(arg_4_1)
	self.skillTimes[arg_4_1] = self.skillTimes[arg_4_1] or 0
	self.skillTimes[arg_4_1] = self.skillTimes[arg_4_1] + 1

	local var_4_0 = true

	for iter_4_0, iter_4_1 in pairs(self.skillTimes) do
		if iter_4_1 < self.summonCfg.act_max_num then
			var_4_0 = false

			break
		end
	end

	self.isDone = var_4_0
end

function SkillSummonData:getAttacker()
	if not self.attacker then
		self.attacker = {
			isPlayer = true,
			isDead = false,
			isSummon = true,
			knightCfg = self.owner.knightCfg,
			identity = self.owner.identity,
			opIdentity = 3 - self.owner.identity,
			serialId = (self.owner.identity - 1) * 10 + 7,
			multiple = self.owner.multiple,
			originInfo = self.owner.originInfo,
			baseInfo = self.owner.baseInfo,
			advanceInfo = self.owner.advanceInfo,
			skillCfg = loadCfg("core.config.cfg.skill_info").get(loadCfg("core.config.cfg.passive_skill_info").get(self.summonCfg.passive_skill_id).passive_skill_value),
			addSerialId = self.serialId
		}
	else
		self.attacker.baseInfo = self.owner.baseInfo
		self.attacker.advanceInfo = self.owner.advanceInfo
	end

	return self.attacker
end

return SkillSummonData
