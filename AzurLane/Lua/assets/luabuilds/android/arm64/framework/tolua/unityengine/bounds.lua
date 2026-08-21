local var_0_0 = rawget
local var_0_1 = setmetatable
local var_0_2 = type
local var_0_4 = {
	center = Vector3.zero,
	extents = Vector3.zero
}
local var_0_5 = tolua.initget({
	center = Vector3.zero,
	extents = Vector3.zero
})

;({
	center = Vector3.zero,
	extents = Vector3.zero
}).__index = function(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0(var_0_4, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_0(var_0_5, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).__call = function(arg_2_0, arg_2_1, arg_2_2)
	return var_0_1({
		center = arg_2_1,
		extents = arg_2_2 * 0.5
	}, var_0_4)
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).New = function(arg_3_0, arg_3_1)
	return var_0_1({
		center = arg_3_0,
		extents = arg_3_1 * 0.5
	}, var_0_4)
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).Get = function(arg_4_0)
	return arg_4_0.center, (arg_4_0:GetSize())
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetSize = function(arg_5_0)
	return arg_5_0.extents * 2
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).SetSize = function(arg_6_0, arg_6_1)
	arg_6_0.extents = arg_6_1 * 0.5

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetMin = function(arg_7_0)
	return arg_7_0.center - arg_7_0.extents
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).SetMin = function(arg_8_0, arg_8_1)
	arg_8_0:SetMinMax(arg_8_1, arg_8_0:GetMax())

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetMax = function(arg_9_0)
	return arg_9_0.center + arg_9_0.extents
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).SetMax = function(arg_10_0, arg_10_1)
	arg_10_0:SetMinMax(arg_10_0:GetMin(), arg_10_1)

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).SetMinMax = function(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.extents = (arg_11_2 - arg_11_1) * 0.5
	arg_11_0.center = arg_11_1 + arg_11_0.extents

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).Encapsulate = function(arg_12_0, arg_12_1)
	arg_12_0:SetMinMax(var_0.Min(arg_12_0:GetMin(), arg_12_1), var_0.Max(arg_12_0:GetMax(), arg_12_1))

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).Expand = function(arg_13_0, arg_13_1)
	if var_0_2(arg_13_1) == "number" then
		arg_13_1 = arg_13_1 * 0.5

		arg_13_0.extents:Add(var_0.New(arg_13_1, arg_13_1, arg_13_1))
	else
		arg_13_0.extents:Add(arg_13_1 * 0.5)
	end

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).Intersects = function(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetMin()
	local var_14_1 = arg_14_0:GetMax()
	local var_14_2 = arg_14_1:GetMin()
	local var_14_3 = arg_14_1:GetMax()

	return var_14_0.x <= var_14_3.x and var_14_1.x >= var_14_2.x and var_14_0.y <= var_14_3.y and var_14_1.y >= var_14_2.y and var_14_0.z <= var_14_3.z and var_14_1.z >= var_14_2.z
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).Contains = function(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetMin()
	local var_15_1 = arg_15_0:GetMax()

	if arg_15_1.x < var_15_0.x or arg_15_1.y < var_15_0.y or arg_15_1.z < var_15_0.z or arg_15_1.x > var_15_1.x or arg_15_1.y > var_15_1.y or arg_15_1.z > var_15_1.z then
		return false
	end

	return true
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetCenter = function(arg_16_0)
	return arg_16_0.center
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).IntersectRay = function(arg_17_0, arg_17_1)
	local var_17_0 = -Mathf.Infinity
	local var_17_1 = Mathf.Infinity
	local var_17_5 = arg_17_0:GetCenter() - arg_17_1:GetOrigin()
	local var_17_6 = {
		var_17_5.x,
		var_17_5.y,
		var_17_5.z
	}
	local var_17_7 = arg_17_1:GetDirection()

	for iter_17_0 = 1, 3 do
		if (var_17_6[iter_17_0] + ({
			arg_17_0.extents.x,
			arg_17_0.extents.y,
			arg_17_0.extents.z
		})[iter_17_0]) * (1 / ({
			var_17_7.x,
			var_17_7.y,
			var_17_7.z
		})[iter_17_0]) < (var_17_6[iter_17_0] - ({
			arg_17_0.extents.x,
			arg_17_0.extents.y,
			arg_17_0.extents.z
		})[iter_17_0]) * (1 / ({
			var_17_7.x,
			var_17_7.y,
			var_17_7.z
		})[iter_17_0]) then
			if var_17_0 < (var_17_6[iter_17_0] + ({
				arg_17_0.extents.x,
				arg_17_0.extents.y,
				arg_17_0.extents.z
			})[iter_17_0]) * (1 / ({
				var_17_7.x,
				var_17_7.y,
				var_17_7.z
			})[iter_17_0]) then
				var_17_0 = (var_17_6[iter_17_0] + ({
					arg_17_0.extents.x,
					arg_17_0.extents.y,
					arg_17_0.extents.z
				})[iter_17_0]) * (1 / ({
					var_17_7.x,
					var_17_7.y,
					var_17_7.z
				})[iter_17_0])
			end

			if (var_17_6[iter_17_0] - ({
				arg_17_0.extents.x,
				arg_17_0.extents.y,
				arg_17_0.extents.z
			})[iter_17_0]) * (1 / ({
				var_17_7.x,
				var_17_7.y,
				var_17_7.z
			})[iter_17_0]) < var_17_1 then
				var_17_1 = (var_17_6[iter_17_0] - ({
					arg_17_0.extents.x,
					arg_17_0.extents.y,
					arg_17_0.extents.z
				})[iter_17_0]) * (1 / ({
					var_17_7.x,
					var_17_7.y,
					var_17_7.z
				})[iter_17_0])
			end

			if var_17_1 < var_17_0 then
				return false
			end

			if var_17_1 < 0 then
				return false
			end
		else
			if var_17_0 < (var_17_6[iter_17_0] - ({
				arg_17_0.extents.x,
				arg_17_0.extents.y,
				arg_17_0.extents.z
			})[iter_17_0]) * (1 / ({
				var_17_7.x,
				var_17_7.y,
				var_17_7.z
			})[iter_17_0]) then
				var_17_0 = (var_17_6[iter_17_0] - ({
					arg_17_0.extents.x,
					arg_17_0.extents.y,
					arg_17_0.extents.z
				})[iter_17_0]) * (1 / ({
					var_17_7.x,
					var_17_7.y,
					var_17_7.z
				})[iter_17_0])
			end

			if (var_17_6[iter_17_0] + ({
				arg_17_0.extents.x,
				arg_17_0.extents.y,
				arg_17_0.extents.z
			})[iter_17_0]) * (1 / ({
				var_17_7.x,
				var_17_7.y,
				var_17_7.z
			})[iter_17_0]) < var_17_1 then
				var_17_1 = (var_17_6[iter_17_0] + ({
					arg_17_0.extents.x,
					arg_17_0.extents.y,
					arg_17_0.extents.z
				})[iter_17_0]) * (1 / ({
					var_17_7.x,
					var_17_7.y,
					var_17_7.z
				})[iter_17_0])
			end

			if var_17_1 < var_17_0 then
				return false
			end

			if var_17_1 < 0 then
				return false
			end
		end
	end

	return true, var_17_0
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).ClosestPoint = function(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 - arg_18_0:GetCenter()
	local var_18_1 = 0

	for iter_18_0 = 1, 3 do
		if ({
			var_18_0.x,
			var_18_0.y,
			var_18_0.z
		})[iter_18_0] < -({
			arg_18_0.extents.x,
			arg_18_0.extents.y,
			arg_18_0.extents.z
		})[iter_18_0] then
			var_18_1 = var_18_1 + (({
				var_18_0.x,
				var_18_0.y,
				var_18_0.z
			})[iter_18_0] + ({
				arg_18_0.extents.x,
				arg_18_0.extents.y,
				arg_18_0.extents.z
			})[iter_18_0]) * (({
				var_18_0.x,
				var_18_0.y,
				var_18_0.z
			})[iter_18_0] + ({
				arg_18_0.extents.x,
				arg_18_0.extents.y,
				arg_18_0.extents.z
			})[iter_18_0])
			;({
				var_18_0.x,
				var_18_0.y,
				var_18_0.z
			})[iter_18_0] = -({
				arg_18_0.extents.x,
				arg_18_0.extents.y,
				arg_18_0.extents.z
			})[iter_18_0]
		elseif ({
			var_18_0.x,
			var_18_0.y,
			var_18_0.z
		})[iter_18_0] > ({
			arg_18_0.extents.x,
			arg_18_0.extents.y,
			arg_18_0.extents.z
		})[iter_18_0] then
			var_18_1 = var_18_1 + (({
				var_18_0.x,
				var_18_0.y,
				var_18_0.z
			})[iter_18_0] - ({
				arg_18_0.extents.x,
				arg_18_0.extents.y,
				arg_18_0.extents.z
			})[iter_18_0]) * (({
				var_18_0.x,
				var_18_0.y,
				var_18_0.z
			})[iter_18_0] - ({
				arg_18_0.extents.x,
				arg_18_0.extents.y,
				arg_18_0.extents.z
			})[iter_18_0])
			;({
				var_18_0.x,
				var_18_0.y,
				var_18_0.z
			})[iter_18_0] = ({
				arg_18_0.extents.x,
				arg_18_0.extents.y,
				arg_18_0.extents.z
			})[iter_18_0]
		end
	end

	if var_18_1 == 0 then
		return rkPoint, 0
	else
		outPoint = var_0(({
			var_18_0.x,
			var_18_0.y,
			var_18_0.z
		})[1], ({
			var_18_0.x,
			var_18_0.y,
			var_18_0.z
		})[2], ({
			var_18_0.x,
			var_18_0.y,
			var_18_0.z
		})[3]) + arg_18_0:GetCenter()

		return outPoint, var_18_1
	end

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).Destroy = function(arg_19_0)
	arg_19_0.center = nil
	arg_19_0.size = nil

	return
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).__tostring = function(arg_20_0)
	return string.format("Center: %s, Extents %s", tostring(arg_20_0.center), tostring(arg_20_0.extents))
end
;({
	center = Vector3.zero,
	extents = Vector3.zero
}).__eq = function(arg_21_0, arg_21_1)
	return arg_21_0.center == arg_21_1.center and arg_21_0.extents == arg_21_1.extents
end
var_0_5.size = ({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetSize
var_0_5.min = ({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetMin
var_0_5.max = ({
	center = Vector3.zero,
	extents = Vector3.zero
}).GetMax
UnityEngine.Bounds = {
	center = Vector3.zero,
	extents = Vector3.zero
}

setmetatable({
	center = Vector3.zero,
	extents = Vector3.zero
}, {
	center = Vector3.zero,
	extents = Vector3.zero
})

return {
	center = Vector3.zero,
	extents = Vector3.zero
}
