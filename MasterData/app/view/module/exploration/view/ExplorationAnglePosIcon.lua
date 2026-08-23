local var_0_0 = class("ExplorationAnglePosIcon.lua")

function var_0_0:ctor()
	self._baseRotation = 0
	self._angle = nil
	self._rotationNode = self

	self:calcBorderAngle()
end

function var_0_0:calcBorderAngle()
	local function var_2_0(arg_3_0, arg_3_1)
		return (math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_3_1, arg_3_0)))) + 360) % 360
	end

	self._angle = {
		right = {
			var_2_0(cc.p(display.cx, display.cy), cc.p(display.width, 0)),
			var_2_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height))
		},
		left = {
			var_2_0(cc.p(display.cx, display.cy), cc.p(0, display.height)),
			var_2_0(cc.p(display.cx, display.cy), cc.p(0, 0))
		},
		top = {
			var_2_0(cc.p(display.cx, display.cy), cc.p(0, 0)),
			var_2_0(cc.p(display.cx, display.cy), cc.p(display.width, 0))
		},
		bottom = {
			var_2_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height)),
			var_2_0(cc.p(display.cx, display.cy), cc.p(0, display.height))
		}
	}
end

function var_0_0:_updateArrow(arg_4_1, arg_4_2)
	local var_4_0 = math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_4_2, arg_4_1))))

	self._rotationNode:setRotation(-var_4_0 - self._baseRotation)

	return -var_4_0 % 360
end

function var_0_0:updateCompAngleAndPos(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = cc.pSub(arg_5_1, arg_5_2)

	if math.abs(var_5_0.x) * arg_5_3.x <= display.width / 2 and math.abs(var_5_0.y) * arg_5_3.y <= display.height / 2 then
		self:setVisible(false)

		return
	end

	self:_updateArrow(arg_5_1, arg_5_2)
	self:setVisible(true)
end

return var_0_0
