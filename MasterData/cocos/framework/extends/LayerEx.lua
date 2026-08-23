function cc.Layer:onTouch(arg_1_1, arg_1_2, arg_1_3)
	if type(arg_1_2) ~= "boolean" then
		arg_1_2 = false
	end

	if type(arg_1_3) ~= "boolean" then
		arg_1_3 = false
	end

	self:registerScriptTouchHandler(function(arg_2_0)
		local var_2_0 = {
			...
		}
		local var_2_1 = {
			name = arg_2_0
		}

		if arg_1_2 then
			var_2_0 = var_2_0[1]

			local var_2_2 = {}

			for iter_2_0 = 1, #var_2_0, 3 do
				var_2_2[var_2_0[iter_2_0 + 2]] = {
					x = var_2_0[iter_2_0],
					y = var_2_0[iter_2_0 + 1],
					id = var_2_0[iter_2_0 + 2]
				}
			end

			var_2_1.points = var_2_2
		else
			var_2_1.x = var_2_0[1]
			var_2_1.y = var_2_0[2]
		end

		return arg_1_1(var_2_1)
	end, arg_1_2, 0, arg_1_3)
	self:setTouchEnabled(true)

	return self
end

function cc.Layer:removeTouch()
	self:unregisterScriptTouchHandler()
	self:setTouchEnabled(false)

	return self
end

function cc.Layer:onKeypad(arg_4_1)
	self:registerScriptKeypadHandler(arg_4_1)
	self:setKeyboardEnabled(true)

	return self
end

function cc.Layer:removeKeypad()
	self:unregisterScriptKeypadHandler()
	self:setKeyboardEnabled(false)

	return self
end

function cc.Layer:onAccelerate(arg_6_1)
	self:registerScriptAccelerateHandler(arg_6_1)
	self:setAccelerometerEnabled(true)

	return self
end

function cc.Layer:removeAccelerate()
	self:unregisterScriptAccelerateHandler()
	self:setAccelerometerEnabled(false)

	return self
end

function cc.LayerColor:getClassName()
	return self.__cname
end
