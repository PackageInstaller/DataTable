local var_0_0 = {
	GetDistance = function(self, arg_1_1)
		return math.sqrt((self.x - arg_1_1.x) * (self.x - arg_1_1.x) + (self.y - arg_1_1.y) * (self.y - arg_1_1.y))
	end,
	GetMidpoint = function(arg_2_0, arg_2_1)
		return (arg_2_0 + arg_2_1) / 2
	end
}

function var_0_0:GetAngle(arg_3_1)
	local var_3_0 = var_0_0.GetDistance(self, arg_3_1)

	if var_3_0 == 0 then
		return 0
	end

	if self.x - arg_3_1.x < 0 then
		return math.asin((self.y - arg_3_1.y) / var_3_0) / math.pi * -180
	else
		return math.asin((self.y - arg_3_1.y) / var_3_0) / math.pi * 180 + 180
	end
end

return var_0_0
