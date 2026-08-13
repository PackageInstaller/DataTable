class = var_0_10000

local var_0_0 = var_0_10000("Fushun3SceneController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneTf = arg_1_2
	arg_1_0._followTf = arg_1_3
	arg_1_0._sceneBackTf = arg_1_1
	arg_1_0._backGrouds = {}

	local var_1_0 = 1

	Fushun3GameConst = var_1_10005

	for iter_1_0 = var_1_0, #var_1_10005.backgroud_data do
		Fushun3GameConst = var_1_10008
		var_1_10008 = var_1_10008.backgroud_data[iter_1_0]
		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_1_0._sceneBackTf, var_1_10008.name)
		table = var_10

		var_10.insert(arg_1_0._backGrouds, {
			tf = var_1_10009,
			data = var_1_10008
		})
	end

	return
end

function var_0_0.start(arg_2_0)
	local var_2_0 = arg_2_0._sceneTf

	Vector2 = var_1_10002
	var_2_0.anchoredPosition = var_1_10002(0, 0)

	for iter_2_0 = 1, #arg_2_0._backGrouds do
		local var_2_1 = arg_2_0._backGrouds[iter_2_0].tf

		Vector2 = var_1_10006
		var_2_1.anchoredPosition = var_1_10006(0, 0)
	end

	return
end

function var_0_0.step(arg_3_0)
	local var_3_0 = arg_3_0._sceneTf.anchoredPosition
	local var_3_1 = arg_3_0._followTf.anchoredPosition.x + var_3_0.x
	local var_3_2 = 0
	local var_3_3

	if 350 < var_3_1 then
		Fushun3GameConst = var_3_3
		var_3_3 = var_3_1 - var_3_3.follow_bound_mid
		Fushun3GameConst = var_1_10006
		var_3_2 = var_3_3 * var_1_10006.follow_spring * -1
	elseif var_3_1 < 250 then
		math = var_3_3
		var_3_3 = var_3_3.abs
		Fushun3GameConst = var_1_10006
		var_3_3 = var_3_3(var_3_1 - var_1_10006.follow_bound_mid)
		Fushun3GameConst = var_6
		var_3_2 = var_3_3 * var_6.follow_spring
	end

	if var_3_2 ~= 0 then
		math = var_3_3

		if var_3_3.abs(var_3_2) < 1 then
			math = var_5
			var_3_2 = 1 * var_5.sign(var_3_2)
		end

		var_3_0.x = var_3_0.x + var_3_2
		arg_3_0._sceneTf.anchoredPosition = var_3_0

		for iter_3_0 = 1, #arg_3_0._backGrouds do
			local var_3_4 = arg_3_0._backGrouds[iter_3_0].tf.anchoredPosition

			var_3_4.x = var_3_0.x * var_9.data.rate
			var_3_4.y = var_3_0.y * var_9.data.rate
			var_9.tf.anchoredPosition = var_3_4
		end
	end

	return
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
