class = var_0_10000

local var_0_0 = var_0_10000("SpineAnimUtil")

function var_0_0.GetCharAnimDirect(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_2 or not arg_1_0 or not arg_1_1 then
		return arg_1_2
	end

	local var_1_0 = arg_1_1 == 1 and "_R" or "_L"
	local var_1_1 = arg_1_2 .. var_1_0
	local var_1_2 = arg_1_0.skeleton.Data

	if var_5.FindAnimation(var_1_2, var_1_1) then
		return var_1_1, true
	end

	return arg_1_2, false
end

function var_0_0.GetCharAnimationDirect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 == 1 and "_R" or "_L"
	local var_2_1 = arg_2_2 .. var_2_0
	local var_2_2 = arg_2_0.SkeletonData

	if var_5.FindAnimation(var_2_2, var_2_1) then
		return var_2_1, true
	end

	return arg_2_2, false
end

return var_0_0
