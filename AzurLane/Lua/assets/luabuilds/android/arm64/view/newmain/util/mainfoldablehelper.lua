class = var_0_10000

local var_0_0 = var_0_10000("MainFoldableHelper")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.foldPosition = arg_1_0:InitFoldPositions(arg_1_2)

	return
end

function var_0_0.IsInit(arg_2_0)
	return arg_2_0._tf ~= nil
end

function var_0_0.InitFoldPositions(arg_3_0, arg_3_1)
	if not arg_3_0:IsInit() then
		return nil
	end

	local var_3_0 = arg_3_0._tf.anchoredPosition
	local var_3_1 = 1500
	local var_3_2 = 200
	local var_3_3 = var_3_0.x
	local var_3_4 = 0
	local var_3_5 = var_3_0.y
	local var_3_6 = 0

	if arg_3_1.x > 0 then
		var_3_4 = var_3_0.x + var_3_1
	elseif arg_3_1.x < 0 then
		var_3_4 = var_3_0.x - var_3_1
	end

	if arg_3_1.y > 0 then
		var_3_6 = var_3_0.y + var_3_2
	elseif arg_3_1.y < 0 then
		var_3_6 = var_3_0.y - var_3_2
	end

	Vector4 = var_9

	return var_9(var_3_3, var_3_4, var_3_5, var_3_6)
end

function var_0_0.Fold(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0:IsInit() then
		return
	end

	LeanTween = var_3

	var_3.cancel(arg_4_0._tf.gameObject)

	if arg_4_0.foldPosition.y ~= 0 then
		if arg_4_1 then
			Vector2 = var_4_0

			local var_4_0

			if not var_4_0(var_3.x, var_3.y) then
				Vector2 = var_4_0
				var_4_0 = var_4_0(var_3.y, var_3.x)
			end

			arg_4_0:LeanTweenValue(var_4_0, arg_4_2, true)

			if var_3.w ~= 0 then
				if arg_4_1 then
					Vector2 = var_4_1

					local var_4_1

					if not var_4_1(var_3.z, var_3.w) then
						Vector2 = var_4_1
						var_4_1 = var_4_1(var_3.w, var_3.z)
					end

					arg_4_0:LeanTweenValue(var_4_1, arg_4_2, false)

					return
				end
			end
		end
	end
end

function var_0_0.LeanTweenValue(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0(arg_6_0)
		if arg_5_3 then
			setAnchoredPosition = var_1

			var_1(arg_5_0._tf.gameObject, {
				x = arg_6_0
			})
		else
			setAnchoredPosition = var_1

			var_1(arg_5_0._tf.gameObject, {
				y = arg_6_0
			})
		end

		return
	end

	if arg_5_2 <= 0 then
		var_5_0(arg_5_1.y)

		return
	end

	LeanTween = var_5

	local var_5_1 = var_5.value(arg_5_0._tf.gameObject, arg_5_1.x, arg_5_1.y, arg_5_2)
	local var_5_2 = var_5.setOnUpdate

	System = var_8

	local var_5_3 = var_5_2(var_5_1, var_8.Action_float(var_5_0))
	local var_5_4 = var_5.setEase

	LeanTweenType = var_8

	var_5_4(var_5_3, var_8.easeInOutExpo)

	return
end

function var_0_0.Dispose(arg_7_0)
	if not arg_7_0:IsInit() then
		return nil
	end

	LeanTween = var_1

	var_1.cancel(arg_7_0._tf.gameObject)

	return
end

return var_0_0
