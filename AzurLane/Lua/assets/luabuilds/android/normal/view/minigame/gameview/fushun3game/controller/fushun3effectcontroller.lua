class = var_0_10000

local var_0_0 = var_0_10000("Fushun3EffectController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._effectTpl = arg_1_1
	arg_1_0._effectPos = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0._effects = {}
	arg_1_0._effectPool = {}

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._effects, 1, -1 do
		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.returnEffectToPool

		table = var_1_10007

		var_2_1(var_2_0, var_1_10007.remove(arg_2_0._effects, iter_2_0))
	end

	return
end

function var_0_0.step(arg_3_0)
	return
end

function var_0_0.returnEffectToPool(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_1.tf, false)

	table = var_1_10002

	var_1_10002.insert(arg_4_0._effectPool, arg_4_1)

	return
end

function var_0_0.addEffectByName(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	if arg_5_0:getOrCreateEffect(nil, arg_5_1) then
		arg_5_0:addEffectToTarget(var_3, arg_5_2)

		table = var_4

		var_4.insert(arg_5_0._effects, var_3)
	end

	return
end

function var_0_0.addEffectByAnim(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	if arg_6_0:getOrCreateEffect(arg_6_1) then
		arg_6_0:addEffectToTarget(var_3, arg_6_2)

		table = var_4

		var_4.insert(arg_6_0._effects, var_3)
	end

	return
end

function var_0_0.addEffectToTarget(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_1.data.parent then
		SetParent = var_7_0

		var_7_0(arg_7_1.tf, arg_7_2)

		var_7_0 = arg_7_1.tf
		var_7_0.localScale = arg_7_2.localScale
		var_7_0 = arg_7_1.tf
		Vector2 = var_4
		var_7_0.anchoredPosition = var_4(0, 0)
		setActive = var_7_0

		var_7_0(arg_7_1.tf, true)

		table = var_7_0

		var_7_0.insert(arg_7_0._effects, arg_7_1)
	else
		setParent = var_7_0

		var_7_0(arg_7_1.tf, arg_7_0._effectPos)

		local var_7_1 = arg_7_1.tf

		Fushun3GameConst = var_4
		var_7_1.localScale = var_4.game_scale_v3

		local var_7_2 = arg_7_1.tf

		var_7_2.position = arg_7_2.position
		setActive = var_7_2

		var_7_2(arg_7_1.tf, true)
	end

	return
end

function var_0_0.getOrCreateEffect(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0 = 1, #arg_8_0._effectPool do
		if arg_8_1 and arg_8_0._effectPool[iter_8_0].data.trigger == arg_8_1 or arg_8_2 and arg_8_0._effectPool[iter_8_0].data.name == arg_8_2 then
			table = var_1_10007

			return var_1_10007.remove(arg_8_0._effectPool, iter_8_0)
		end
	end

	local var_8_0 = arg_8_0:getEffectData(arg_8_1, arg_8_2)

	return arg_8_0:instiateEffect(var_8_0)
end

function var_0_0.instiateEffect(arg_9_0, arg_9_1)
	if arg_9_1 then
		tf = var_1_10002
		instantiate = var_1_10003
		findTF = var_1_10004

		local var_9_0 = var_1_10002(var_1_10003(var_1_10004(arg_9_0._effectTpl, arg_9_1.name)))
		local var_9_1 = {
			tf = var_9_0,
			data = arg_9_1
		}

		GetOrAddComponent = var_4
		findTF = var_5

		local var_9_2 = var_5(var_9_0, "efAnim")

		typeof = var_6
		DftAniEvent = var_7

		local var_9_3 = var_4(var_9_2, var_6(var_7))

		var_4.SetEndEvent(var_9_3, function()
			local var_10_0 = arg_9_0

			var_0.removeEffect(var_10_0, var_9_1)

			return
		end)

		return var_9_1
	end

	return
end

function var_0_0.removeEffect(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_0._effects, 1, -1 do
		if arg_11_0._effects[iter_11_0] == arg_11_1 then
			setActive = var_6

			var_6(arg_11_0._effects[iter_11_0].tf, false)

			local var_11_0 = arg_11_0
			local var_11_1 = arg_11_0.returnEffectToPool

			table = var_8

			var_11_1(var_11_0, var_8.remove(arg_11_0._effects, iter_11_0))
		end
	end

	return
end

function var_0_0.getEffectData(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		local var_12_0 = 1

		Fushun3GameConst = var_1_10004

		for iter_12_0 = var_12_0, #var_1_10004.effect_data do
			Fushun3GameConst = var_1_10007

			if var_1_10007.effect_data[iter_12_0].trigger == arg_12_1 then
				Clone = var_1_10007
				Fushun3GameConst = var_1_10008

				return var_1_10007(var_1_10008.effect_data[iter_12_0])
			end
		end
	elseif arg_12_2 then
		local var_12_1 = 1

		Fushun3GameConst = var_1_10004

		for iter_12_1 = var_12_1, #var_1_10004.effect_data do
			Fushun3GameConst = var_1_10007

			if var_1_10007.effect_data[iter_12_1].name == arg_12_2 then
				Clone = var_1_10007
				Fushun3GameConst = var_1_10008

				return var_1_10007(var_1_10008.effect_data[iter_12_1])
			end
		end
	end

	return
end

return var_0_0
