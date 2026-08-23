local var_0_0 = {
	AddBuff = 1,
	Skill = 2
}
local var_0_1 = g.core.config.outpost_buff_info
local OutpostFightTarget = require("app.view.module.outpost.simulationWorld.fight.OutpostFightTarget")
local OutpostFightBuff = require("app.view.module.outpost.simulationWorld.fight.OutpostFightBuff")
local OutpostPassiveTiming = require("app.view.module.outpost.simulationWorld.fight.OutpostPassiveTiming")
local OutpostPassiveTrigger = class("OutpostPassiveTrigger", require("app.view.module.outpost.simulationWorld.pool.ObjectPoolItem"))

function OutpostPassiveTrigger:ctor()
	self.passiveInfo = nil
	self.timingType = 0
	self.victim = nil
	self.fightSystem = nil
	self._empty = {}
end

function OutpostPassiveTrigger:onGet(arg_2_1)
	self.passiveInfo = arg_2_1.passiveInfo
	self.fightSystem = arg_2_1.fightSystem
	self.victim = arg_2_1.victim
	self.executeCount = 0
	self.timingType = OutpostPassiveTiming.TimingEffect[self.passiveInfo.trigger_type]
	self._prob = self.passiveInfo.trigger_prob
	self._triggerValue = self.passiveInfo.trigger_type_value
	self._rule = OutpostPassiveTiming["timing" .. self.passiveInfo.trigger_type]()
end

function OutpostPassiveTrigger:execute(arg_3_1)
	arg_3_1 = arg_3_1 or self._empty

	if self:_rule(self._triggerValue) and self.fightSystem:bingo(self._prob) then
		self.executeCount = self.executeCount + 1

		if self.passiveInfo.passive_effect_type == var_0_0.AddBuff then
			local var_3_0 = self.victim
			local var_3_1 = {}

			if OutpostFightTarget["findTarget" .. self.passiveInfo.passive_range] then
				var_3_1 = OutpostFightTarget["findTarget" .. self.passiveInfo.passive_range](var_3_0, arg_3_1.victim or self.victim, self.passiveInfo.skill_range_value)
			else
				assert(false, "被动释放的时候 %s 没找到作用目标类型 %s", self.passiveInfo.id, self.passiveInfo.passive_range)
			end

			for iter_3_0, iter_3_1 in ipairs(var_3_1) do
				iter_3_1:addBuff((self.fightSystem.pool:getObj(OutpostFightBuff, {
					fightSystem = self.fightSystem,
					buffInfo = var_0_1.get(self.passiveInfo.passive_effect_value),
					timeType = self.passiveInfo.buff_time_type,
					timeValue = self.passiveInfo.buff_time_value,
					attacker = var_3_0,
					victim = iter_3_1
				})))
			end
		end
	end
end

function OutpostPassiveTrigger:onReset()
	return
end

return OutpostPassiveTrigger
