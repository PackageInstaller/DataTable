-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/buff/BuffMO.lua

module("logic.battle.unit.comp.buff.BuffMO", package.seeall)

local BuffMO = class("BuffMO", AbstractGlobalReusable)

function BuffMO:ctor(buffCO)
	self._buffCO = buffCO
	self._id = 0
	self._round = 0
	self._layer = 0
	self._maxLayerProgramming = false
	self._forever = false

	self:_initBuffCO()
end

function BuffMO:reuse(buffCO)
	self._buffCO = buffCO
	self._round = 0
	self._forever = false
	self._maxLayerProgramming = false

	self:_initBuffCO()
end

function BuffMO:reset()
	self._buffCO = false
	self._id = 0
	self._round = 0
	self._layer = 0
	self._forever = false
	self._isLayerBuff = false
	self._maxLayerProgramming = false
end

function BuffMO:destroy()
	self._buffCO = nil
	self._id = nil
	self._round = nil
	self._layer = nil
	self._forever = nil
	self._isLayerBuff = nil
	self._maxLayerProgramming = nil
end

function BuffMO:setId(id)
	self._id = id
end

function BuffMO:getId()
	return self._id
end

function BuffMO:getBuffCO()
	return self._buffCO
end

function BuffMO:setCode(code)
	self._buffCO = BuffConfig.instance:getBuffCO(code)

	self:_initBuffCO()
end

function BuffMO:_initBuffCO()
	if self._buffCO then
		local buffEffectCO = BuffConfig.instance:getBuffEffectCO(self._buffCO.buffType)

		self._isLayerBuff = BuffCOUtil.isLayerBuff(buffEffectCO)

		if self._isLayerBuff then
			local _, maxLayerProgramming = BuffCOUtil.getBuffLayerRangeProgramming(self._buffCO)

			self._maxLayerProgramming = maxLayerProgramming
		end
	end
end

function BuffMO:isLayerBuff()
	return self._isLayerBuff
end

function BuffMO:getBuffCode()
	return self._buffCO.id
end

function BuffMO:setRound(round)
	self._round = round
	self._forever = round < 0
end

function BuffMO:getRound()
	return self._round
end

function BuffMO:setLayer(layer)
	self._layer = layer
end

function BuffMO:getLayer()
	return self._layer
end

function BuffMO:getMaxLayerProgramming()
	return self._maxLayerProgramming
end

function BuffMO:decRound(decrement)
	self._round = self._round - decrement
end

function BuffMO:isForever()
	return self._forever
end

return BuffMO
