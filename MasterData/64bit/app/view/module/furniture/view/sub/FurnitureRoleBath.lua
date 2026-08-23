local var_0_0 = g.core.const.ConstMgr.SpineConst
local FurnitureRoleBath = class("FurnitureRoleBath")

function FurnitureRoleBath:ctor(arg_1_1)
	self._target = arg_1_1.obj
	self._roleComp = arg_1_1.obj:getChild("roleHolderComp")
	self._roleObject = self._roleComp:getChild("CommonKnight")
	self._schedule = nil
	self._countDownTime = 0
end

function FurnitureRoleBath:_updateRoleBathAction()
	if self._roleObject and not self._schedule then
		self._countDownTime = 0

		self._roleObject:playAction(var_0_0.LOOP_ACTION.BATHE)

		self._schedule = self._roleObject:newSchedule(handler(self, self._onUpdate), 1)
	end
end

function FurnitureRoleBath:_onUpdate()
	if self._roleObject then
		self._countDownTime = self._countDownTime + 1

		if self._countDownTime >= 300 then
			self:_cancelBathSchedule()
			self._roleObject:playAction(var_0_0.LOOP_ACTION.IDLE)
			self._target:playRoleBathingAni(false)
			self._roleComp:dispatchCompEvent("ROLE_BEHAVIOR_BEGIN", self._target)
		end
	end
end

function FurnitureRoleBath:_cancelBathSchedule()
	if self._schedule then
		self._roleObject:cancelSchedule(self._schedule)

		self._schedule = nil
		self._countDownTime = 0
	end
end

function FurnitureRoleBath:onUnload()
	self:_cancelBathSchedule()
end

return FurnitureRoleBath
