local CommanderSkill = class("CommanderSkill", import("..BaseVO"))

function CommanderSkill:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.exp = arg_1_1.exp

	return
end

function CommanderSkill:getExp()
	return self.exp
end

function CommanderSkill:bindConfigTable()
	return pg.commander_skill_template
end

function CommanderSkill:getLevel()
	return self:getConfig("lv")
end

function CommanderSkill:isMaxLevel()
	return self:getConfig("next_id") == 0
end

function CommanderSkill:getNextLevelExp()
	return self:getConfig("exp")
end

function CommanderSkill:addExp(arg_7_1)
	self.exp = self.exp + arg_7_1

	while self:canLevelUp() do
		self.exp = self.exp - self:getNextLevelExp()
		self.id = self:getConfig("next_id")
		self.configId = self.id
	end

	return
end

function CommanderSkill:canLevelUp()
	return self:getNextLevelExp() <= self.exp and not self:isMaxLevel()
end

function CommanderSkill:getTacticSkill()
	return self:getConfig("effect_tactic")
end

function CommanderSkill:GetTacticSkillForWorld()
	return self:getConfig("effect_tactic_world")
end

function CommanderSkill:GetSkillGroup()
	local var_11_0 = {}
	local var_11_1 = self:getConfig("prev_id")

	while var_11_1 and var_11_1 ~= 0 do
		table.insert(var_11_0, pg.commander_skill_template[var_11_1])

		var_11_1 = pg.commander_skill_template[var_11_1].prev_id
	end

	table.insert(var_11_0, pg.commander_skill_template[self.configId])

	local var_11_2 = self:getConfig("next_id")

	while var_11_2 and var_11_2 ~= 0 do
		table.insert(var_11_0, pg.commander_skill_template[var_11_2])

		var_11_2 = pg.commander_skill_template[var_11_2].next_id
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.lv < arg_12_1.lv
	end)

	return var_11_0
end

return CommanderSkill
