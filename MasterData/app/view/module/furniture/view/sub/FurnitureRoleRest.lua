local var_0_0 = g.core.const.ConstMgr.SpineConst
local FurnitureRoleRest = class("FurnitureRoleRest")

function FurnitureRoleRest:ctor(arg_1_1)
	self._target = arg_1_1.obj
	self._roleComp = arg_1_1.obj:getChild("roleHolderComp")
	self._roleObject = self._roleComp:getChild("CommonKnight")
	self._countDownTime = 0
	self._schedule = nil
end

function FurnitureRoleRest:_updateRoleRestAction()
	if self._roleObject and not self._schedule then
		self._countDownTime = 0

		self._roleObject:playAction(var_0_0.LOOP_ACTION.SLEEP)

		self._schedule = self._roleObject:newSchedule(handler(self, self._onUpdate), 1)
	end
end

function FurnitureRoleRest:_onUpdate()
	if self._roleObject then
		self._countDownTime = self._countDownTime + 1

		if self._countDownTime >= 120 then
			self:_cancelRestSchedule()
			self._roleObject:playAction(var_0_0.LOOP_ACTION.IDLE)
			self._roleComp:dispatchCompEvent("ROLE_BEHAVIOR_BEGIN", self._target)
		end
	end
end

function FurnitureRoleRest:_cancelRestSchedule()
	if self._schedule then
		self._roleObject:cancelSchedule(self._schedule)

		self._schedule = nil
		self._countDownTime = 0
	end
end

function FurnitureRoleRest:onUnload()
	self:_cancelRestSchedule()
end

return FurnitureRoleRest
