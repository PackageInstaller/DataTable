local GuideTouchComp = class("GuideTouchComp", require("app.fairyGUI.guide.UI_GuideTouchComp"))
local var_0_1 = 0.017444444444444446

function GuideTouchComp:ctor()
	return
end

function GuideTouchComp:updateView(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_3 then
		local var_2_0 = g.core.utils.Tools.calAngle(arg_2_2.centerPos1.x, arg_2_2.centerPos1.y, arg_2_2.centerPos.x, arg_2_2.centerPos.y)

		if arg_2_5 then
			var_2_0 = var_2_0 + 180
		end

		self.m_line:setRotation(var_2_0)
		self.m_dragController:setSelectedIndex(1)

		local var_2_1 = math.sqrt(math.pow(math.abs(arg_2_2.centerPos1.x - arg_2_2.centerPos.x), 2) + math.pow(math.abs(arg_2_2.centerPos1.y - arg_2_2.centerPos.y), 2))

		self.m_line:setWidth(var_2_1)

		local var_2_2 = self.m_line:getPosition()

		self._startPos = {
			x = var_2_2.x + math.cos(var_2_0 * var_0_1) * var_2_1,
			y = var_2_2.y + math.sin(var_2_0 * var_0_1) * var_2_1
		}

		self:playDragAnim(arg_2_4)
	else
		self.m_clickTransition:play(-1, 0)
	end
end

function GuideTouchComp:playTimes(arg_3_1, arg_3_2)
	self.m_clickTransition:play(arg_3_1, 0, arg_3_2)
end

function GuideTouchComp:playDragAnim(arg_4_1)
	local var_4_0 = {
		start = {
			self._startPos.x,
			self._startPos.y
		},
		start2 = {
			self._startPos.x,
			self._startPos.y
		},
		star3 = {
			self._startPos.x,
			self._startPos.y
		},
		star4 = {
			self._startPos.x,
			self._startPos.y
		},
		pos1 = {
			self._startPos.x,
			self._startPos.y
		},
		pos2 = {
			self._startPos.x,
			self._startPos.y
		}
	}

	if arg_4_1 then
		self.m_drag_2Transition:changeParams(var_4_0):play()
	else
		self.m_drag_2Transition:changeParams(var_4_0):play(-1, 0)
	end
end

return GuideTouchComp
