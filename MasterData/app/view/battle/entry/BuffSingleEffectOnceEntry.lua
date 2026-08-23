local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local BuffSingleEffectOnceEntry = class("BuffSingleEffectOnceEntry", require("app.view.battle.entry.Entry"))
local SpineBase = require("app.view.common.SpineBase")

function BuffSingleEffectOnceEntry:ctor(arg_1_1)
	self._effectName = arg_1_1.effectName
	self._battleLayer = arg_1_1.battleLayer
	self._pos = arg_1_1.pos
	self._container = arg_1_1.container
	self._spineEffect = nil
	self._isInit = false
	self._isDone = false

	self.super.ctor(self)

	return self
end

function BuffSingleEffectOnceEntry:getPosition()
	return
end

function BuffSingleEffectOnceEntry:getSpineEffect()
	return self._spineEffect
end

function BuffSingleEffectOnceEntry:initEntry()
	self.super.initEntry(self)
	self.addEntryToQueue(self, self, self.step)
end

function BuffSingleEffectOnceEntry:setIsDone(arg_5_1)
	self._isDone = arg_5_1
end

function BuffSingleEffectOnceEntry:_createSpine()
	local var_6_0 = {}

	var_6_0.resId = "buff"
	var_6_0.isLoop = false
	var_6_0.path = BattlePath.getSpineBuffPath(self._effectName)
	var_6_0.anim = BattleConst.SPINE_ACTION_TYPE.PLAY

	local var_6_1 = SpineBase.new(var_6_0)

	var_6_1:setPosition(self._pos)

	return var_6_1
end

function BuffSingleEffectOnceEntry:_init()
	if self._isInit == true then
		return
	end

	self._isInit = true
	self._spineEffect = self:_createSpine()

	self._spineEffect:setPosition(self._pos)
	self._container:addChild(self._spineEffect)
end

function BuffSingleEffectOnceEntry:step()
	self:_init()

	return self._isDone
end

function BuffSingleEffectOnceEntry:destroyEntry()
	self.super.destroyEntry(self)

	if self._spineEffect ~= nil and self._spineEffect.dispose then
		self._spineEffect:dispose()

		self._spineEff = nil
	end

	self._effectName = nil
end

return BuffSingleEffectOnceEntry
