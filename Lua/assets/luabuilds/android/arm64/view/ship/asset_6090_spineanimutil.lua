local SpineAnimUtil = class("SpineAnimUtil")

function SpineAnimUtil:GetCharAnimDirect(arg_1_1, arg_1_2)
	local var_1_0

	if not arg_1_2 or not self or not arg_1_1 then
		do return arg_1_2 end

		var_1_0 = arg_1_2
	end

	if self.skeleton.Data:FindAnimation(var_1_0 .. (arg_1_1 == 1 and "_R" or "_L")) then
		return var_1_0 .. (arg_1_1 == 1 and "_R" or "_L"), true
	end

	return arg_1_2, false
end

function SpineAnimUtil:GetCharAnimationDirect(arg_2_1, arg_2_2)
	if self.SkeletonData:FindAnimation(arg_2_2 .. (arg_2_1 == 1 and "_R" or "_L")) then
		return arg_2_2 .. (arg_2_1 == 1 and "_R" or "_L"), true
	end

	return arg_2_2, false
end

return SpineAnimUtil
