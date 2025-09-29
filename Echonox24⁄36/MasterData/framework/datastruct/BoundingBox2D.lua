module("framework.datastruct.BoundingBox2D", package.seeall)

local var_0_0 = class("BoundingBox2D")

function var_0_0.ctor(arg_1_0)
	arg_1_0.width = 0
	arg_1_0.height = 0
	arg_1_0.halfWidth = 0
	arg_1_0.halfHeight = 0
	arg_1_0._center = Vector2.New()
end

function var_0_0.setSize(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.width = arg_2_1
	arg_2_0.height = arg_2_2
	arg_2_0.halfWidth = arg_2_0.width * 0.5
	arg_2_0.halfHeight = arg_2_0.height * 0.5
	arg_2_0._minX = arg_2_0._center.x - arg_2_0.halfWidth
	arg_2_0._minY = arg_2_0._center.y - arg_2_0.halfHeight
	arg_2_0._maxX = arg_2_0._center.x + arg_2_0.halfWidth
	arg_2_0._maxY = arg_2_0._center.y + arg_2_0.halfHeight
end

function var_0_0.setCenter(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._center.x = arg_3_1
	arg_3_0._center.y = arg_3_2
	arg_3_0._minX = arg_3_0._center.x - arg_3_0.halfWidth
	arg_3_0._minY = arg_3_0._center.y - arg_3_0.halfHeight
	arg_3_0._maxX = arg_3_0._center.x + arg_3_0.halfWidth
	arg_3_0._maxY = arg_3_0._center.y + arg_3_0.halfHeight
end

function var_0_0.getCenter(arg_4_0)
	return arg_4_0._center
end

function var_0_0.setBorders(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0._minX = arg_5_1
	arg_5_0._minY = arg_5_2
	arg_5_0._maxX = arg_5_3
	arg_5_0._maxY = arg_5_4
	arg_5_0.width = arg_5_3 - arg_5_1
	arg_5_0.height = arg_5_4 - arg_5_2
	arg_5_0.halfWidth = arg_5_0.width * 0.5
	arg_5_0.halfHeight = arg_5_0.height * 0.5
end

function var_0_0.getBorders(arg_6_0)
	return arg_6_0._minX, arg_6_0._minY, arg_6_0._maxX, arg_6_0._maxY
end

function var_0_0.intersects(arg_7_0, arg_7_1)
	if arg_7_0._minX > arg_7_1._maxX or arg_7_0._minY > arg_7_1._maxY or arg_7_0._maxX < arg_7_1._minX or arg_7_0._maxY < arg_7_1._minY then
		return false
	end

	return true
end

function var_0_0.contains(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == nil then
		local var_8_0 = arg_8_1

		if var_8_0.x < arg_8_0._minX or var_8_0.y < arg_8_0._minY or var_8_0.x > arg_8_0._maxX or var_8_0.y > arg_8_0._maxY then
			return false
		end
	elseif arg_8_1 < arg_8_0._minX or arg_8_2 < arg_8_0._minY or arg_8_1 > arg_8_0._maxX or arg_8_2 > arg_8_0._maxY then
		return false
	end

	return true
end

return var_0_0
