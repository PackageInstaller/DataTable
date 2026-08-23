local OutpostFightEffectApply = require("app.view.module.outpost.simulationWorld.fight.OutpostFightEffectApply")
local OutpostFightEffect = class("OutpostFightEffect", require("app.view.module.outpost.simulationWorld.pool.ObjectPoolItem"))

function OutpostFightEffect:ctor()
	self:onReset()
end

function OutpostFightEffect:onGet(arg_2_1)
	self.fightSystem = arg_2_1
end

function OutpostFightEffect:onReset()
	self.effectType = 0
	self.effectValue = 0
	self.result = nil
	self.attacker = nil
	self.victim = nil
	self.isCrit = false
	self.isDodge = false
	self.isBlock = false
	self._isEffect = false
end

function OutpostFightEffect:setEffect(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.effectType = arg_4_1
	self.attacker = arg_4_2
	self.victim = arg_4_3
	self.effectValue = 0
	self.result = arg_4_4
end

function OutpostFightEffect:applyEffect()
	if self._isEffect then
		return
	end

	self._isEffect = true

	OutpostFightEffectApply["apply" .. self.effectType](self)
end

return OutpostFightEffect
