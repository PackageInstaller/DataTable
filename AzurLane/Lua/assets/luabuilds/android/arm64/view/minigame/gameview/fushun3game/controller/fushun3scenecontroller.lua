local var_0_0 = class("Fushun3SceneController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneTf = arg_1_2
	arg_1_0._followTf = arg_1_3
	arg_1_0._sceneBackTf = arg_1_1
	arg_1_0._backGrouds = {}

	for iter_1_0 = 1, #Fushun3GameConst.backgroud_data do
		table.insert(arg_1_0._backGrouds, {
			tf = findTF(arg_1_0._sceneBackTf, Fushun3GameConst.backgroud_data[iter_1_0].name),
			data = Fushun3GameConst.backgroud_data[iter_1_0]
		})
	end

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0._sceneTf.anchoredPosition = Vector2(0, 0)

	for iter_2_0 = 1, #arg_2_0._backGrouds do
		arg_2_0._backGrouds[iter_2_0].tf.anchoredPosition = Vector2(0, 0)
	end

	return
end

function var_0_0.step(arg_3_0)
	local var_3_0 = arg_3_0._sceneTf.anchoredPosition
	local var_3_1 = 0

	if arg_3_0._followTf.anchoredPosition.x + arg_3_0._sceneTf.anchoredPosition.x > 350 then
		var_3_1 = (arg_3_0._followTf.anchoredPosition.x + arg_3_0._sceneTf.anchoredPosition.x - Fushun3GameConst.follow_bound_mid) * Fushun3GameConst.follow_spring * -1
	elseif arg_3_0._followTf.anchoredPosition.x + arg_3_0._sceneTf.anchoredPosition.x < 250 then
		var_3_1 = math.abs(arg_3_0._followTf.anchoredPosition.x + arg_3_0._sceneTf.anchoredPosition.x - Fushun3GameConst.follow_bound_mid) * Fushun3GameConst.follow_spring
	end

	if var_3_1 ~= 0 then
		if math.abs(var_3_1) < 1 then
			var_3_1 = 1 * math.sign(var_3_1)
		end

		var_3_0.x = var_3_0.x + var_3_1
		arg_3_0._sceneTf.anchoredPosition = var_3_0

		for iter_3_0 = 1, #arg_3_0._backGrouds do
			arg_3_0._backGrouds[iter_3_0].tf.anchoredPosition.x = var_3_0.x * arg_3_0._backGrouds[iter_3_0].data.rate
			arg_3_0._backGrouds[iter_3_0].tf.anchoredPosition.y = var_3_0.y * arg_3_0._backGrouds[iter_3_0].data.rate
			arg_3_0._backGrouds[iter_3_0].tf.anchoredPosition = arg_3_0._backGrouds[iter_3_0].tf.anchoredPosition
		end
	end

	return
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
