local WalkLine = require("app.core.ksmap.entity.WalkLine")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local BossMoveToPosState = class("BossMoveToPosState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function BossMoveToPosState:onCreate()
	self._stUUID = var_0_1.FsmState.MoveToPos
end

function BossMoveToPosState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
	self._map = self._world:getVirtualMap()
	self._pathList = {}
	self._walkLine = WalkLine.new()
	self._nextPos = nil
end

function BossMoveToPosState:doBeforeEntering()
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

function BossMoveToPosState:onTickUpdate(arg_4_1)
	if not self._nextPos then
		self._entity:setMovePos(nil)
		self:setFinish(true)

		return
	end

	local var_4_0 = self._entity:getMoveSpeed() * arg_4_1
	local var_4_1, var_4_2 = self._walkLine:step(var_4_0)

	self._entity:setPosVec2(var_4_1)

	if var_4_0 == 0 or var_4_1.x == self._nextPos.x and var_4_1.y == self._nextPos.y then
		self._nextPos = nil
	end

	if not self._entity.fightTarget or self._entity.fightTarget:needRecover() then
		local var_4_3

		for iter_4_0, iter_4_1 in ipairs((self._map:queryRangeEntities(self._entity.x, self._entity.y, self._maxRange))) do
			if self._entity:isEnemy(iter_4_1) and not iter_4_1:needRecover() then
				var_4_3 = iter_4_1

				break
			end
		end

		if var_4_3 then
			self._entity:setFightTarget(var_4_3)
		end
	end
end

function BossMoveToPosState:doBeforeLeaving()
	self._entity:setMovePos(nil)
end

return BossMoveToPosState
