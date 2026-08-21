local var_0_0 = class("PopFramingBaseView", ReduxView)

function var_0_0.Back(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2 or var_0_0.BackCallBack

	if manager.guide:IsPlaying() then
		var_1_0()

		return
	end

	if arg_1_1 then
		if arg_1_0.animatorList_ == nil then
			Debug.LogError("Need AnimatorList to Skip")
		end

		if arg_1_0:IsAnimatorEnd() then
			var_1_0()
		else
			for iter_1_0, iter_1_1 in ipairs(arg_1_0.animatorList_) do
				iter_1_1:Update(9999)
			end
		end
	else
		if arg_1_0.playable_ == nil then
			Debug.LogError("Need Playable Director to Skip")
		end

		if arg_1_0.playable_.time / arg_1_0.playable_.duration > 0.999 then
			var_1_0()
		else
			arg_1_0.playable_.time = 9999
		end
	end
end

function var_0_0.BackCallBack(arg_2_0)
	JumpTools.Back()
end

function var_0_0.IsAnimatorEnd(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.animatorList_) do
		if iter_3_1:GetCurrentAnimatorStateInfo(0).normalizedTime < 0.999 then
			return false
		end
	end

	return true
end

return var_0_0
