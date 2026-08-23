local Numeric = class("Numeric")

function Numeric:Equal(arg_1_1)
	return math.abs(self - arg_1_1) <= 0.0001
end

return Numeric
