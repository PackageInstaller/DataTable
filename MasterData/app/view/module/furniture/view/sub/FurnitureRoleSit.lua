local var_0_0 = g.core.const.ConstMgr.SpineConst
local FurnitureRoleSit = class("FurnitureRoleSit")

function FurnitureRoleSit:ctor(arg_1_1)
	self._target = arg_1_1.obj
	self._roleComp = arg_1_1.obj:getChild("roleHolderComp")
	self._roleObject = self._roleComp:getChild("CommonKnight")
	self._schedule = nil
	self._countDownTime = 0
end

function FurnitureRoleSit:_updateRoleSitDownAction()
	if self._roleObject and not self._schedule then
		self._countDownTime = 0

		self._roleObject:playAction(var_0_0.LOOP_ACTION.SIT)

		self._schedule = self._roleObject:newSchedule(handler(self, self._onUpdate), 1)
	end
end

function FurnitureRoleSit:_onUpdate()
	if self._roleObject then
		self._countDownTime = self._countDownTime + 1

		if self._countDownTime >= 30 then
			self:_cancelSitSchedule()
			self._roleObject:playAction(var_0_0.LOOP_ACTION.IDLE)
			self._roleComp:dispatchCompEvent("ROLE_BEHAVIOR_BEGIN", self._target)
		end
	end
end

function FurnitureRoleSit:_cancelSitSchedule()
	if self._schedule then
		self._roleObject:cancelSchedule(self._schedule)

		self._schedule = nil
		self._countDownTime = 0
	end
end

function FurnitureRoleSit:onUnload()
	self:_cancelSitSchedule()
end

return FurnitureRoleSit
