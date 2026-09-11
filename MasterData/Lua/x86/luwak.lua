lk = {}
lk.math2d = import("support.math2d")
lk.BattleMath = import("support.BattleMath")
lk.FLOAT_PRECISION = 1e-05

function lk.FloatEqual(arg_1_0, arg_1_1)
	if math.abs(arg_1_0 - arg_1_1) <= lk.FLOAT_PRECISION then
		return true
	else
		return false
	end
end
