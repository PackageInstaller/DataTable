pg = pg or {}
pg.Rect = class("Rect")

function pg.Rect.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0._right = arg_1_1
	arg_1_0._bottom = arg_1_2
	arg_1_0._width = arg_1_3
	arg_1_0._height = arg_1_4
	arg_1_0._left = arg_1_1 + arg_1_3
	arg_1_0._top = arg_1_2 + arg_1_4
	arg_1_0._type = arg_1_5
	arg_1_0._obj = arg_1_6

	return
end

function pg.Rect.CheckPreCollider(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1._left < arg_2_0._right then
		return 0
	end

	if arg_2_1._right > arg_2_0._left or arg_2_1._top < arg_2_0._bottom or arg_2_1._bottom > arg_2_0._top then
		return 1
	end

	if arg_2_3 > 0 then
		if arg_2_2 == 0 then
			return 2
		end

		if (arg_2_0._left - arg_2_1._right) / arg_2_2 >= (arg_2_0._bottom - arg_2_1._top) / arg_2_3 then
			return 4
		end

		return 2
	elseif arg_2_3 < 0 then
		if arg_2_2 == 0 then
			return 3
		end

		if (arg_2_0._left - arg_2_1._right) / arg_2_2 >= (arg_2_0._top - arg_2_1._bottom) / arg_2_3 then
			return 4
		end

		return 3
	else
		return 4
	end

	return
end

function pg.Rect.CheckStillCollider(arg_3_0, arg_3_1)
	if arg_3_1._right > arg_3_0._left or arg_3_1._left < arg_3_0._right or arg_3_1._top < arg_3_0._bottom or arg_3_1._bottom > arg_3_0._top then
		return false
	end

	return true
end

return
