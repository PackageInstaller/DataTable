local BulletEntry = class("BulletEntry", require("app.view.battle.entry.Entry"))
local BattleEffect = require("app.view.battle.BattleEffect")

function BulletEntry:ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self._moveAction = nil
	self._startActor = arg_1_1
	self._targetActor = arg_1_2
	self._frames = arg_1_4
	self._effectName = arg_1_3
	self._hitCallBack = arg_1_6
	self._battleLayer = arg_1_5

	BulletEntry.super.ctor(self)
end

function BulletEntry:initEntry()
	BulletEntry.super.initEntry(self)
	self.addEntryToQueue(self, self, self._step)
end

function BulletEntry:_init()
	if self._isInit == true then
		return
	end

	self._isInit = true

	local var_3_0 = self._startActor:getMissionPos()
	local var_3_1 = self._startActor:getLocationScale()
	local var_3_2 = cc.pAdd(self._targetActor:getInitPosition(), cc.p(0, 70))
	local var_3_3 = self._targetActor:getLocationScale()

	self._spine = BattleEffect.new({
		resId = self._effectName
	})

	self._spine:setPosition(var_3_0.x, var_3_0.y)
	self._battleLayer:getCamera():addToNodeEffect(self._spine)

	if self._targetActor:getIdentity() == 2 then
		self._spine:setScaleX(var_3_1)
	else
		self._spine:setScaleX(-1 * var_3_1)
	end

	self._spine:setScaleY(var_3_1)

	self._moveAction = require("app.core.common.action.Action").newMoveTo(self._frames, var_3_2)

	self._moveAction:startWithTarget(self._spine)
end

function BulletEntry:bindSound(arg_4_1)
	return
end

function BulletEntry:_step()
	self:_init()
	self._moveAction:step(1)

	if self._moveAction:getTotalFrame() - self._moveAction:getElapsed() <= 2 and self._hitCallBack ~= nil then
		self._hitCallBack = nil
	end

	return (self._moveAction:isDone())
end

function BulletEntry:destroyEntry()
	BulletEntry.super.destroyEntry(self)

	if self._spine ~= nil then
		self._spine:dispose()

		self._spine = nil
	end

	self._startActor = nil
	self._endPos = nil
	self._frames = nil
	self._moveAction = nil
	self._hitCallBack = nil
end

return BulletEntry
