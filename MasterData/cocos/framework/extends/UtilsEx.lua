if not cc.utils.captureNodeCC then
	local var_0_0 = cc.utils.captureNode

	function cc.utils:captureNode(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
		if not arg_1_1.displayObject then
			return
		end

		return self:captureNodeCC(arg_1_1:displayObject(), arg_1_2, arg_1_3, arg_1_4)
	end

	function cc.utils.captureNodeCC(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = false

		if arg_2_1.isClippingEnabled then
			var_2_0 = arg_2_1:isClippingEnabled()
		end

		if arg_2_1.setClippingEnabled then
			arg_2_1:setClippingEnabled(false)
		end

		local var_2_1 = arg_2_4 or 1
		local var_2_2

		if arg_2_2 then
			assert(false, "rectSize is not support")

			var_2_2 = not arg_2_3 and var_0_0(arg_2_0, arg_2_1, cc.p(arg_2_2.width, arg_2_2.height), cc.p(0, 0), var_2_1) or var_0_0(arg_2_0, arg_2_1, cc.p(arg_2_2.width, arg_2_2.height), arg_2_3, var_2_1)
		else
			var_2_2 = var_0_0(arg_2_0, arg_2_1, var_2_1)
		end

		if arg_2_1.setClippingEnabled and var_2_0 then
			arg_2_1:setClippingEnabled(true)
		end

		return var_2_2
	end
end
