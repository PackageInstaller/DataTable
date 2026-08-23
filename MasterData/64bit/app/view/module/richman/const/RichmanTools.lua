local var_0_0 = {
	isPointOrigin = function(self)
		return self.x == 0 and self.y == 0
	end
}

function var_0_0:findParabolaCoefficients(arg_2_1)
	if var_0_0.isPointOrigin(self) then
		g.core.log:error("x1 cannot be zero because the parabola passes through the origin")

		return 0, 0
	end

	arg_2_1 = arg_2_1 or 1

	local var_2_0 = (self.y - arg_2_1 * self.x) / self.x^2

	if (self.y - arg_2_1 * self.x) / self.x^2 > 0 then
		var_2_0 = -var_2_0
	end

	return var_2_0, arg_2_1
end

return var_0_0
