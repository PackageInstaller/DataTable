local var_0_0 = g.core.config.outpost_knight_elemental_info
local var_0_1 = g.core.config.outpost_play_info
local var_0_2 = g.core.config.outpost_skill_info
local var_0_3 = g.core.config.outpost_buff_info
local var_0_4 = table.insert
local var_0_5 = table.concat
local OutpostFightEffect = require("app.view.module.outpost.simulationWorld.fight.OutpostFightEffect")
local OutpostFightFormula = require("app.view.module.outpost.simulationWorld.fight.OutpostFightFormula")
local OutpostFightBuff = require("app.view.module.outpost.simulationWorld.fight.OutpostFightBuff")
local OutpostFightTarget = require("app.view.module.outpost.simulationWorld.fight.OutpostFightTarget")
local FightResult = class("FightResult", require("app.view.module.outpost.simulationWorld.pool.ObjectPoolItem"))

function FightResult:ctor()
	self:onReset()
end

function FightResult:onGet(arg_2_1)
	self.fightSystem = arg_2_1
end

function FightResult:onReset()
	self.attacker = nil
	self.victim = nil
	self.skillInfo = nil
	self._effectList = {}
	self.playInfo = nil
	self.elementalInfo = nil
end

function FightResult:setFightAttacker(arg_4_1, arg_4_2, arg_4_3)
	self.attacker = arg_4_1
	self.victim = arg_4_3
	self.skillInfo = arg_4_2
	self.playInfo = var_0_1.fetch(self.skillInfo.id) or var_0_1.get(0)
	self.elementalInfo = var_0_0.get(self.attacker:getElemental())
end

function FightResult:applySkill()
	if self.victim:isDead() then
		return
	end

	local var_5_0 = 1

	while var_0_2.hasKey("skill_affect_type_" .. var_5_0) do
		local var_5_1 = self.skillInfo["skill_affect_type_" .. var_5_0]

		if self.skillInfo["skill_affect_type_" .. var_5_0] > 0 and self.fightSystem:bingo(self.skillInfo["skill_affect_prob_" .. var_5_0]) then
			local var_5_2 = self.skillInfo["formula_" .. var_5_0]
			local var_5_3 = self.skillInfo[var_0_5({
				"formula",
				var_5_0,
				"value",
				1
			}, "_")]
			local var_5_4 = self.skillInfo[var_0_5({
				"formula",
				var_5_0,
				"value",
				2
			}, "_")]
			local var_5_5 = self.skillInfo[var_0_5({
				"formula",
				var_5_0,
				"value",
				3
			}, "_")]
			local var_5_6 = {}

			if OutpostFightTarget["findTarget" .. self.skillInfo["skill_range_" .. var_5_0]] then
				var_5_6 = OutpostFightTarget["findTarget" .. self.skillInfo["skill_range_" .. var_5_0]](self.attacker, self.victim, self.skillInfo["skill_range_value_" .. var_5_0])
			else
				assert(false, "技能释放的时候 %s 没找到作用目标类型 %s", self.skillInfo.id, self.skillInfo["skill_range_" .. var_5_0])
			end

			for iter_5_0, iter_5_1 in ipairs(var_5_6) do
				local var_5_7 = self.fightSystem.pool:getObj(OutpostFightEffect, self.fightSystem)
				local var_5_8 = OutpostFightFormula["formula" .. var_5_2] or OutpostFightFormula.formula0()

				var_5_7:setEffect(var_5_1, self.attacker, iter_5_1, self)
				var_5_8(var_5_7, self.attacker, self.victim, var_5_3, var_5_4, var_5_5)
				var_5_7:applyEffect()
				var_0_4(self._effectList, var_5_7)
			end
		end

		var_5_0 = var_5_0 + 1
	end

	local var_5_9 = 1

	while var_0_2.hasKey("buff_" .. var_5_9) do
		local var_5_10 = self.skillInfo["buff_" .. var_5_9]

		if self.skillInfo["buff_" .. var_5_9] > 0 and self.fightSystem:bingo(self.skillInfo["buff_prop_" .. var_5_9]) then
			local var_5_11 = {}

			if OutpostFightTarget["findTarget" .. self.skillInfo["buff_target_" .. var_5_9]] then
				var_5_11 = OutpostFightTarget["findTarget" .. self.skillInfo["buff_target_" .. var_5_9]](self.attacker, self.victim, self.skillInfo["buff_target_value_" .. var_5_9])
			else
				assert(false, "技能释放的时候 %s 没找到buff作用目标类型 %s", self.skillInfo.id, self.skillInfo["buff_target_" .. var_5_9])
			end

			for iter_5_2, iter_5_3 in ipairs(var_5_11) do
				iter_5_3:addBuff((self.fightSystem.pool:getObj(OutpostFightBuff, {
					fightSystem = self.fightSystem,
					buffInfo = var_0_3.get(var_5_10),
					timeType = self.skillInfo["buff_time_type_" .. var_5_9],
					timeValue = self.skillInfo["buff_time_value_" .. var_5_9],
					attacker = self.attacker,
					victim = iter_5_3
				})))
			end
		end

		var_5_9 = var_5_9 + 1
	end
end

function FightResult:getEffectList()
	return self._effectList
end

function FightResult:dispose()
	for iter_7_0, iter_7_1 in ipairs(self._effectList) do
		iter_7_1:dispose()
	end

	self._effectList = {}

	self:releaseToPool()
end

return FightResult
