local var_0_0 = class("SailBoatEffectControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._content = findTF(arg_1_0._tf, "scene_front/content")
	arg_1_0._effects = {}
	arg_1_0._effectPool = {}

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._effects, 1, -1 do
		local var_2_0 = table.remove(arg_2_0._effects, iter_2_0)

		setActive(var_2_0.tf, false)
		table.insert(arg_2_0._effectPool, var_2_0)
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
				return (table.remove(arg_4_0._effectPool, iter_4_0))
			end
		end
	end

	local var_4_0 = var_0_1.GetGameEffectTf(arg_4_1)
	local var_4_1 = {
		tf = var_4_0,
		name = arg_4_1
	}

	GetComponent(findTF(var_4_0, "img"), typeof(DftAniEvent)):SetEndEvent(function()
		arg_4_0:effectEnd(var_4_1)

		return
	end)

	return {
		tf = var_4_0,
		name = arg_4_1
	}
end

function var_0_0.onEventCall(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == SailBoatGameEvent.CREATE_EFFECT then
		arg_6_0:createEffect(arg_6_2.effect, arg_6_2.direct, arg_6_2.position, arg_6_2.content)
	end

	return
end

function var_0_0.createEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0:getEffect(arg_7_1)

	if arg_7_2 then
		var_7_0.tf.localScale = arg_7_2
	end

	if arg_7_3 then
		var_7_0.tf.anchoredPosition = arg_7_3
	end

	if arg_7_4 then
		SetParent(var_7_0.tf, arg_7_4)
	else
		SetParent(var_7_0.tf, arg_7_0._content)
	end

	setActive(var_7_0.tf, true)
	table.insert(arg_7_0._effects, var_7_0)

	return
end

function var_0_0.effectEnd(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0._effects do
		if arg_8_0._effects[iter_8_0] == arg_8_1 then
			local var_8_0 = table.remove(arg_8_0._effects, iter_8_0)

			setActive(var_8_0.tf, false)
			table.insert(arg_8_0._effectPool, var_8_0)

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
