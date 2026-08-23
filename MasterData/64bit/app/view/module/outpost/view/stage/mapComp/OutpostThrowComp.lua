local RichmanTools = require("app.view.module.richman.const.RichmanTools")
local OutpostThrowComp = class("OutpostThrowComp", require("app.fairyGUI.outpost.UI_OutpostThrowComp"))

function OutpostThrowComp:ctor()
	return
end

function OutpostThrowComp:doPlayFlyAnim(arg_2_1, arg_2_2)
	self._param = arg_2_1
	self._callback = arg_2_2

	self.m_flyLoader:setURL(g.core.common.Goods:convert(arg_2_1.itemInfo).icon)

	arg_2_1.moveDir.y = arg_2_1.moveDir.y - 100
	self._preMove = cc.pMul(cc.pNormalize(arg_2_1.moveDir), 5)
	self._move = cc.p(0, 0)
	self._target = arg_2_1.moveDir

	self:newSchedule(handler(self, self._updateFly))
end

function OutpostThrowComp:_updateFly()
	self._move = cc.pAdd(self._move, self._preMove)

	self.m_flyLoader:setPosition(self._move)

	if cc.pGetDistance(self._move, self._target) < 5 then
		self:onFlyFinish()
	end
end

function OutpostThrowComp:onFlyFinish()
	self:cancelAllSchedule()

	if self._callback then
		self._callback(self._param)
	end

	self:removeSelf()
end

return OutpostThrowComp
