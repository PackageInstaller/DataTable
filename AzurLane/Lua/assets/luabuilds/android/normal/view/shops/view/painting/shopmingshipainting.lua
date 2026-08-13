class = var_0_10000

local var_0_0 = var_0_10000("ShopMingShiPainting")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._painting = arg_1_1
	findTF = var_1_10002
	arg_1_0.live2dContainer = var_1_10002(arg_1_0._painting, "live2d")
	setActive = var_2

	var_2(arg_1_0.live2dContainer, true)

	return
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	Live2DPainting = var_1_10004

	local var_2_0 = var_1_10004.GenerateData
	local var_2_1 = {}

	Ship = var_1_10006
	var_2_1.ship = var_1_10006.New({
		configId = 312011
	})
	var_2_1.offset = {
		nil,
		nil,
		nil,
		72
	}
	Vector3 = var_6
	var_2_1.position = var_6(0, 0, 0)
	var_2_1.parent = arg_2_0.live2dContainer

	local var_2_2 = var_2_0(var_2_1)

	Live2DPainting = var_2_1

	var_2_1.New(var_2_2, function(arg_3_0)
		arg_2_0.live2dChar = arg_3_0

		if arg_2_0.cacheAnimationName then
			local var_3_0 = arg_2_0

			var_1.Action(var_3_0, arg_2_0.cacheAnimationName)

			arg_2_0.cacheAnimationName = nil
		end

		arg_2_3()

		return
	end)

	return
end

function var_0_0.Action(arg_4_0, arg_4_1)
	if arg_4_0.live2dChar then
		local var_4_0 = arg_4_0.live2dChar

		var_2.TriggerAction(var_4_0, arg_4_1, nil, true)
	else
		arg_4_0.cacheAnimationName = arg_4_1
	end

	return
end

function var_0_0.UnLoad(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.live2dContainer, false)

	if arg_5_0.live2dChar then
		local var_5_0 = arg_5_0.live2dChar

		var_1.Dispose(var_5_0)

		arg_5_0.live2dChar = nil
	end

	return
end

return var_0_0
