local var_0_0 = g.core.const.ConstMgr.FurnitureConst.ROLE_ACTION
local var_0_1 = g.core.const.ConstMgr.SpineConst
local FurnitureRoleBath = require("app.view.module.furniture.view.sub.FurnitureRoleBath")
local FurnitureRoleRun = require("app.view.module.furniture.view.sub.FurnitureRoleRun")
local FurnitureRoleRest = require("app.view.module.furniture.view.sub.FurnitureRoleRest")
local FurnitureRoleSit = require("app.view.module.furniture.view.sub.FurnitureRoleSit")
local FurnitureRoleIdle = require("app.view.module.furniture.view.sub.FurnitureRoleIdle")
local FurnitureRoleBehavior = class("FurnitureRoleBehavior")

function FurnitureRoleBehavior:ctor()
	self._roleComp = nil
	self._behaviorType = nil
	self._routeArray = nil
end

function FurnitureRoleBehavior:setRoleObj(arg_2_1)
	self._roleComp = arg_2_1

	local var_2_0 = {
		obj = self._roleComp
	}

	self._roleIdle = FurnitureRoleIdle.new(var_2_0)
	self._roleRun = FurnitureRoleRun.new(var_2_0)
	self._roleBath = FurnitureRoleBath.new(var_2_0)
	self._roleRest = FurnitureRoleRest.new(var_2_0)
	self._roleSit = FurnitureRoleSit.new(var_2_0)
end

function FurnitureRoleBehavior:stopRoleAction()
	self._roleIdle:_cancelIdleSchedule()
	self._roleBath:_cancelBathSchedule()
	self._roleRest:_cancelRestSchedule()
	self._roleSit:_cancelSitSchedule()
	self._roleComp:stopAllFGActions()
	self._roleComp:getChild("roleHolderComp"):getChild("CommonKnight"):playAction(var_0_1.LOOP_ACTION.IDLE)
end

function FurnitureRoleBehavior:updateBeHaviorType(arg_4_1)
	self._behaviorType = arg_4_1

	self:beginRoleAction()
end

function FurnitureRoleBehavior:setRouteArray(arg_5_1)
	if self._roleRun then
		self._roleRun:setRouteData(arg_5_1)
	end
end

function FurnitureRoleBehavior:beginRoleAction()
	if self._behaviorType == var_0_0.IDLE then
		self._roleIdle:_updateRoleIdleAction()
	elseif self._behaviorType == var_0_0.RUN then
		self._roleRun:_updateRoleRunAction()
	elseif self._behaviorType == var_0_0.BATH then
		self._roleBath:_updateRoleBathAction()
	elseif self._behaviorType == var_0_0.REST then
		self._roleRest:_updateRoleRestAction()
	elseif self._behaviorType == var_0_0.SIT then
		self._roleSit:_updateRoleSitDownAction()
	end
end

return FurnitureRoleBehavior
