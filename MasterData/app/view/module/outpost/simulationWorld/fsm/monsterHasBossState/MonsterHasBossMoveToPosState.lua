local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local MonsterHasBossMoveToPosState = class("MonsterHasBossMoveToPosState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function MonsterHasBossMoveToPosState:onCreate()
	self._stUUID = var_0_1.FsmState.MoveToPos
end

function MonsterHasBossMoveToPosState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
end

function MonsterHasBossMoveToPosState:doBeforeEntering()
	if not self._entity.movePos then
		self:setFinish(true)

		return
	end

	self:setFinish(false)

	self._nextPos = self._entity.movePos

	self._walkLine:setLine(cc.p(self._entity:getPos()), self._nextPos)

	self._maxRange = self._entity:getAttr():getAttackMaxRange()

	var_0_3:dispatchWorldEvent(OutpostEvent.RoleMove, {
		entity = self._entity,
		nextPos = self._nextPos
	})
end

function MonsterHasBossMoveToPosState:onTickUpdate(arg_4_1)
	if not self._nextPos then
		self._entity:setMovePos(nil)
		self:setFinish(true)

		return
	end

	local var_4_0, var_4_1 = self._walkLine:step(self._entity:getMoveSpeed() * arg_4_1)

	self._entity:setPosVec2(var_4_0)

	if var_4_0.x == self._nextPos.x and var_4_0.y == self._nextPos.y then
		self._nextPos = nil
	end
end

function MonsterHasBossMoveToPosState:doBeforeLeaving()
	self._entity:setMovePos(nil)
end

return MonsterHasBossMoveToPosState
