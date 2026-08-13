class = var_0_10000

local var_0_0 = var_0_10000("SailBoatEffectControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._content = var_1_10003(arg_1_0._tf, "scene_front/content")
	arg_1_0._effects = {}
	arg_1_0._effectPool = {}

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._effects, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_2_0._effects, iter_2_0)
		setActive = var_6

		var_6(var_1_10005.tf, false)

		table = var_6

		var_6.insert(arg_2_0._effectPool, var_1_10005)
	end

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	return
end

function var_0_0.getEffect(arg_4_0, arg_4_1)
	if #arg_4_0._effectPool > 0 then
		for iter_4_0 = 1, #arg_4_0._effectPool do
			if #arg_4_0._effectPool[iter_4_0].name == arg_4_1 then
				table = var_6

				return (var_6.remove(arg_4_0._effectPool, iter_4_0))
			end
		end
	end

	local var_4_0 = var_0_1.GetGameEffectTf(arg_4_1)
	local var_4_1 = {
		tf = var_4_0,
		name = arg_4_1
	}

	GetComponent = var_1_10004
	findTF = iter_4_0

	local var_4_2 = iter_4_0(var_4_0, "img")

	typeof = var_6
	DftAniEvent = var_7

	local var_4_3 = var_1_10004(var_4_2, var_6(var_7))

	var_4.SetEndEvent(var_4_3, function()
		local var_5_0 = arg_4_0

		var_0.effectEnd(var_5_0, var_4_1)

		return
	end)

	return var_4_1
end

function var_0_0.onEventCall(arg_6_0, arg_6_1, arg_6_2)
	SailBoatGameEvent = var_1_10003

	if arg_6_1 == var_1_10003.CREATE_EFFECT then
		local var_6_0 = arg_6_2.effect
		local var_6_1 = arg_6_2.direct
		local var_6_2 = arg_6_2.position
		local var_6_3 = arg_6_2.content

		arg_6_0:createEffect(var_6_0, var_6_1, var_6_2, var_6_3)
	end

	return
end

function var_0_0.createEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getEffect(var_7_0, arg_7_1)

	if arg_7_2 then
		var_7_0 = var_7_1.tf
		var_7_0.localScale = arg_7_2
	end

	if arg_7_3 then
		var_7_0 = var_7_1.tf
		var_7_0.anchoredPosition = arg_7_3
	end

	if arg_7_4 then
		SetParent = var_7_0

		var_7_0(var_7_1.tf, arg_7_4)
	else
		SetParent = var_7_0

		var_7_0(var_7_1.tf, arg_7_0._content)
	end

	setActive = var_7_0

	var_7_0(var_7_1.tf, true)

	table = var_7_0

	var_7_0.insert(arg_7_0._effects, var_7_1)

	return
end

function var_0_0.effectEnd(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0._effects do
		if arg_8_0._effects[iter_8_0] == arg_8_1 then
			table = var_6

			local var_8_0 = var_6.remove(arg_8_0._effects, iter_8_0)

			setActive = var_7

			var_7(var_8_0.tf, false)

			table = var_7

			var_7.insert(arg_8_0._effectPool, var_8_0)

			return
		end
	end

	return
end

function var_0_0.dispose(arg_9_0)
	return
end

function var_0_0.clear(arg_10_0)
	return
end

return var_0_0
