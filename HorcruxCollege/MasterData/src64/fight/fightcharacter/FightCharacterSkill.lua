local total_skill_data = require("data.total_skill_data")

function FightCharacter:initSkillList(arg_1_1)
	local var_1_0 = arg_1_1 or self:getAttribute("skills")

	for iter_1_0 = 1, #var_1_0 do
		self._skilllist["skill" .. iter_1_0] = {}
		self._skilllist["skill" .. iter_1_0].id = var_1_0[iter_1_0]
		self._skilllist["skill" .. iter_1_0].cd = 0
		self._skilllist["skill" .. iter_1_0].totalcd = total_skill_data[var_1_0[iter_1_0]].cd
		self._skilllist["skill" .. iter_1_0].maxdistance = total_skill_data[var_1_0[iter_1_0]].max_distance or 640
		self._skilllist["skill" .. iter_1_0].need_attack_count = total_skill_data[var_1_0[iter_1_0]].need_attack_count
	end

	local var_1_1 = self:getAttribute("oc_active_skills")

	if not var_1_1 then
		return
	end

	for iter_1_1 = 1, #var_1_1 do
		self._skilllist["ocskill" .. iter_1_1] = {}
		self._skilllist["ocskill" .. iter_1_1].id = var_1_1[iter_1_1]
		self._skilllist["ocskill" .. iter_1_1].cd = 0
		self._skilllist["ocskill" .. iter_1_1].totalcd = total_skill_data[var_1_1[iter_1_1]].cd
		self._skilllist["ocskill" .. iter_1_1].maxdistance = total_skill_data[var_1_1[iter_1_1]].max_distance or 640
		self._skilllist["ocskill" .. iter_1_1].need_attack_count = total_skill_data[var_1_1[iter_1_1]].need_attack_count
	end
end

function FightCharacter:updateSkillList(arg_2_1)
	if self._skilllist.skill1 == arg_2_1[1] then
		return
	end

	for iter_2_0 = 1, #arg_2_1 do
		self._skilllist["skill" .. iter_2_0] = {}
		self._skilllist["skill" .. iter_2_0].id = arg_2_1[iter_2_0]
		self._skilllist["skill" .. iter_2_0].cd = 0
		self._skilllist["skill" .. iter_2_0].totalcd = total_skill_data[arg_2_1[iter_2_0]].cd
		self._skilllist["skill" .. iter_2_0].maxdistance = total_skill_data[arg_2_1[iter_2_0]].max_distance or 640
		self._skilllist["skill" .. iter_2_0].need_attack_count = total_skill_data[arg_2_1[iter_2_0]].need_attack_count
	end

	local var_2_0 = self:getAttribute("oc_active_skills")

	if not var_2_0 then
		return
	end

	for iter_2_1 = 1, #var_2_0 do
		self._skilllist["ocskill" .. iter_2_1] = {}
		self._skilllist["ocskill" .. iter_2_1].id = var_2_0[iter_2_1]
		self._skilllist["ocskill" .. iter_2_1].cd = 0
		self._skilllist["ocskill" .. iter_2_1].totalcd = total_skill_data[var_2_0[iter_2_1]].cd
		self._skilllist["ocskill" .. iter_2_1].maxdistance = total_skill_data[var_2_0[iter_2_1]].max_distance or 640
		self._skilllist["ocskill" .. iter_2_1].need_attack_count = total_skill_data[var_2_0[iter_2_1]].need_attack_count
	end
end

function FightCharacter:initXPSkill(arg_3_1)
	arg_3_1 = arg_3_1 or self:getAttribute("xpskill")

	if not arg_3_1 then
		return
	end

	self._skilllist.xp = {}
	self._skilllist.xp.id = arg_3_1
	self._skilllist.xp.cd = 0
	self._skilllist.xp.totalcd = total_skill_data[arg_3_1].cd
	self._skilllist.xp.maxdistance = total_skill_data[arg_3_1].max_distance or 640
	self._skilllist.xp.not_use_rage = total_skill_data[arg_3_1].not_use_rage
	self._skilllist.xp.need_attack_count = total_skill_data[arg_3_1].need_attack_count
end

function FightCharacter:updateXPSkill(arg_4_1)
	if arg_4_1 == self._skilllist.xp.id then
		return
	end

	self._skilllist.xp.id = arg_4_1
	self._skilllist.xp.totalcd = total_skill_data[arg_4_1].cd
	self._skilllist.xp.cd = (total_skill_data[arg_4_1].cd - self:getAttribute("cd_minus_const")) * (1 - self:getAttribute("cd_minus"))
	self._skilllist.xp.maxdistance = total_skill_data[arg_4_1].max_distance or 640
	self._skilllist.xp.not_use_rage = total_skill_data[arg_4_1].not_use_rage
	seld._skilllist.xp.need_attack_count = total_skill_data[arg_4_1].need_attack_count
end

function FightCharacter:getNormalSkillList()
	local var_5_0 = {}
	local var_5_1 = 1

	while self._skilllist["skill" .. var_5_1] do
		table.insert(var_5_0, self._skilllist["skill" .. var_5_1].id)

		var_5_1 = var_5_1 + 1
	end

	local var_5_2 = 1

	while self._skilllist["ocskill" .. var_5_2] do
		table.insert(var_5_0, self._skilllist["ocskill" .. var_5_2].id)

		var_5_2 = var_5_2 + 1
	end

	return var_5_0
end

function FightCharacter:getSkillAIName(arg_6_1)
	if not self._skilllist[arg_6_1] then
		return nil
	end

	return total_skill_data[self._skilllist[arg_6_1].id].ainame or "xp"
end

function FightCharacter:getSkillCfgName(arg_7_1)
	return total_skill_data[self._skilllist[arg_7_1].id].cfgname or "xp"
end

function FightCharacter:getSkillID(arg_8_1)
	return self._skilllist[arg_8_1].id
end

function FightCharacter:getSkillMaxdistance(arg_9_1)
	return self._skilllist[arg_9_1].maxdistance
end

function FightCharacter:showSkillSP(arg_10_1)
	local var_10_0 = total_skill_data[self:getSkillID(arg_10_1)].fight_talk

	if not var_10_0 then
		return
	end

	require("view.Sprite.TalkSprite")
	self:addChild(TalkSprite:create(var_10_0, self:getAttribute("model_height") * STANDARD_SCALE * self:getAttribute("model_scale") + HPBAR_HEIGHT + 30, nil, 1), 5)
end

function FightCharacter:resetAllCD()
	for iter_11_0, iter_11_1 in pairs(self._skilllist) do
		iter_11_1.cd = (iter_11_1.totalcd - self:getAttribute("cd_minus_const")) * (1 - self:getAttribute("cd_minus"))
	end
end

function FightCharacter:refreshCD(arg_12_1)
	arg_12_1 = arg_12_1 or "xp"

	if not self._skilllist[arg_12_1] then
		return
	end

	self._skilllist[arg_12_1].cd = 0
end

function FightCharacter:refreshAllCD()
	for iter_13_0, iter_13_1 in pairs(self._skilllist) do
		iter_13_1.cd = 0
	end
end

function FightCharacter:joinCD(arg_14_1)
	arg_14_1 = arg_14_1 or "xp"

	if arg_14_1 == "xp" then
		if self._skilllist.xp.not_use_rage then
			return
		end

		if not self.statuspool:checkStatus("ragefree") then
			self:resetRage()
		end

		self:closeRageAdd()

		return
	end

	if not self._skilllist[arg_14_1] then
		return
	end

	if self._skilllist[arg_14_1].need_attack_count then
		self:resetAttackCDCount()
	else
		self._skilllist[arg_14_1].cd = (self._skilllist[arg_14_1].totalcd - self:getAttribute("cd_minus_const")) * (1 - self:getAttribute("cd_minus"))

		if self._skilllist[arg_14_1].cd < 0 then
			self._skilllist[arg_14_1].cd = 0
		end
	end
end

function FightCharacter:minusCD(arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or "xp"

	if not self._skilllist[arg_15_2] then
		return
	end

	self._skilllist[arg_15_2].cd = self._skilllist[arg_15_2].cd - arg_15_1

	if self._skilllist[arg_15_2].cd < 0 then
		self._skilllist[arg_15_2].cd = 0
	end
end

function FightCharacter:minusAllCD(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self._skilllist) do
		iter_16_1.cd = iter_16_1.cd - arg_16_1

		if iter_16_1.cd < 0 then
			iter_16_1.cd = 0
		end
	end
end

function FightCharacter:getCD(arg_17_1)
	arg_17_1 = arg_17_1 or "xp"

	if not self._skilllist[arg_17_1] then
		return 999
	end

	return self._skilllist[arg_17_1].cd
end

function FightCharacter:updateCD(arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or "xp"

	if not self._skilllist[arg_18_2] then
		return
	end

	if self._skilllist[arg_18_2].cd > 0 then
		self._skilllist[arg_18_2].cd = self._skilllist[arg_18_2].cd * (1 - arg_18_1)

		if self._skilllist[arg_18_2].cd < 0 then
			self._skilllist[arg_18_2].cd = 0
		end
	end
end

function FightCharacter:updateCDStatus(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self._skilllist) do
		if iter_19_1.cd > 0 then
			iter_19_1.cd = iter_19_1.cd - arg_19_1 * (1 + global_fight_speedup)
		end
	end
end

function FightCharacter:canSkillCDEnable(arg_20_1)
	if not self._skilllist[arg_20_1] then
		return false
	end

	if self._skilllist[arg_20_1].need_attack_count then
		local var_20_0 = true

		while self._skilllist["skill" .. 1] do
			if self._skilllist["skill" .. 1].need_attack_count and self:getAttackCDCount() + self:getAttribute("skill_cd_count_minus") < self._skilllist["skill" .. 1].need_attack_count then
				var_20_0 = false

				break
			end
		end

		if var_20_0 then
			while self._skilllist["ocskill" .. 1] do
				if self._skilllist["ocskill" .. 1].need_attack_count and self:getAttackCDCount() + self:getAttribute("skill_cd_count_minus") < self._skilllist["ocskill" .. 1].need_attack_count then
					var_20_0 = false

					break
				end
			end
		end

		return var_20_0
	else
		return self:getCD(arg_20_1) <= 0
	end
end

function FightCharacter:resetSkillCD()
	self:setAttackCDCount(100)
end
