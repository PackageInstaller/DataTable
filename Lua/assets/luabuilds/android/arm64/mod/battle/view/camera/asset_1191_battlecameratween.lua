ys = ys or {}
ys.Battle.BattleCameraTween = class("BattleCameraTween")
ys.Battle.BattleCameraTween.__name = "BattleCameraTween"

function ys.Battle.BattleCameraTween.Ctor(arg_1_0)
	arg_1_0._point = Vector3.zero

	return
end

function ys.Battle.BattleCameraTween:SetFromTo(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	self._point:Set(arg_2_2.x, arg_2_2.y, arg_2_2.z)

	local var_2_0 = LeanTween.value(go(arg_2_1), arg_2_2, arg_2_3, arg_2_4):setOnUpdateVector3(System.Action_UnityEngine_Vector3(function(arg_3_0)
		self._point:Set(arg_3_0.x, arg_3_0.y, arg_3_0.z)

		return
	end))

	if arg_2_5 and arg_2_5 ~= 0 then
		var_2_0:setDelay(arg_2_5)
	end

	if arg_2_6 then
		var_2_0:setEase(LeanTweenType.easeOutExpo)
	end

	if arg_2_7 then
		var_2_0:setOnComplete(System.Action(function()
			arg_2_7()

			return
		end))
	end

	return
end

function ys.Battle.BattleCameraTween:GetCameraPos()
	return self._point
end

function ys.Battle.BattleCameraTween.Dispose(arg_6_0)
	arg_6_0._point = nil

	return
end

return
