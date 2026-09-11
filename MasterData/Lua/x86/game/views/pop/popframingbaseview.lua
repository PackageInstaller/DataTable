local PopFramingBaseView = class("PopFramingBaseView", ReduxView)

function PopFramingBaseView:Back(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2 or PopFramingBaseView.BackCallBack

	if manager.guide:IsPlaying() then
		var_1_0()

		return
	end

	if arg_1_1 then
		if self.animatorList_ == nil then
			Debug.LogError("Need AnimatorList to Skip")
		end

		if self:IsAnimatorEnd() then
			var_1_0()
		else
			for iter_1_0, iter_1_1 in ipairs(self.animatorList_) do
				iter_1_1:Update(9999)
			end
		end
	else
		if self.playable_ == nil then
			Debug.LogError("Need Playable Director to Skip")
		end

		if self.playable_.time / self.playable_.duration > 0.999 then
			var_1_0()
		else
			self.playable_.time = 9999
		end
	end
end

function PopFramingBaseView:BackCallBack()
	JumpTools.Back()
end

function PopFramingBaseView:IsAnimatorEnd()
	for iter_3_0, iter_3_1 in ipairs(self.animatorList_) do
		if iter_3_1:GetCurrentAnimatorStateInfo(0).normalizedTime < 0.999 then
			return false
		end
	end

	return true
end

return PopFramingBaseView
