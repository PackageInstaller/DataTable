local var_0_0 = g.core.const.ConstMgr.outpostConst
local KnightNoVitNormalRecoverState = class("KnightNoVitNormalRecoverState", require("app.view.module.outpost.simulationWorld.fsm.baseState.OutpostBaseState"))

function KnightNoVitNormalRecoverState:onCreate()
	self._stUUID = var_0_0.FsmState.NORMAL_RECOVER
end

function KnightNoVitNormalRecoverState:onInitState()
	self._entity = self._ownerFSM._ownerObj
	self._world = self._entity.world
end

function KnightNoVitNormalRecoverState:doBeforeEntering()
	self:setFinish(false)
end

function KnightNoVitNormalRecoverState:onTickUpdate(arg_4_1)
	self:setFinish(true)
end

return KnightNoVitNormalRecoverState
