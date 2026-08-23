local var_0_0 = g.core.const.ConstMgr.SpineConst
local FurnitureRoleIdle = class("FurnitureRoleIdle")

function FurnitureRoleIdle:ctor(arg_1_1)
	self._roleObject = arg_1_1.obj:getChild("roleHolderComp"):getChild("CommonKnight")
	self._countDownTime = 0
	self._schedule = nil
end

function FurnitureRoleIdle:_updateRoleIdleAction()
	if self._roleObject and not self._schedule then
		self._countDownTime = 0
		self._schedule = self._roleObject:newSchedule(handler(self, self._onUpdate), 1)
	end
end

function FurnitureRoleIdle:_onUpdate()
	if self._roleObject then
		self._countDownTime = self._countDownTime + 1

		if self._countDownTime >= 7 then
			if math.random(10) < 2 then
				self._roleObject:playAction(var_0_0.ACTION.SHOW)
			end

			self._countDownTime = 0
		end
	end
end

function FurnitureRoleIdle:onUnload()
	self:_cancelIdleSchedule()
end

function FurnitureRoleIdle:_cancelIdleSchedule()
	if self._schedule then
		self._roleObject:cancelSchedule(self._schedule)

		self._schedule = nil
		self._countDownTime = 0
	end
end

return FurnitureRoleIdle
