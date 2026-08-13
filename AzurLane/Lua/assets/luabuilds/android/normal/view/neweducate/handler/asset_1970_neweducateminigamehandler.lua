class = var_0_10000

local var_0_0 = var_0_10000("NewEducateMinigameHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.games = {}
	arg_1_0.view = arg_1_2

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	setActive = var_1_10003

	var_1_10003(arg_2_0._go, true)

	pg = var_1_10003
	arg_2_0.config = var_1_10003.child2_minigame[arg_2_1]

	local var_2_0 = arg_2_0.config.view_name

	if not arg_2_0.games[var_2_0] then
		local var_2_1 = arg_2_0.games

		_G = var_5
		var_2_1[var_2_0] = var_5[var_2_0].New(arg_2_0._tf)

		local var_2_2 = arg_2_0.games[var_2_0]

		var_4.RegisterView(var_2_2, arg_2_0.view)
	end

	local var_2_3 = arg_2_0.games[var_2_0]

	var_4.ExecuteAction(var_2_3, "Show", arg_2_1, function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.GetNextId(var_3_0, arg_3_0)

		arg_2_2(var_3_1)

		return
	end)

	return
end

function var_0_0.GetNextId(arg_4_0, arg_4_1)
	type = var_1_10002

	if var_1_10002(arg_4_1) ~= "number" then
		arg_4_1 = 0
	end

	local var_4_0 = arg_4_0.config.result_data

	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(var_4_0) do
		if arg_4_1 >= iter_4_1[1][1] and arg_4_1 >= iter_4_1[1][2] then
			return iter_4_1[2][1]
		end
	end

	return var_4_0[#var_4_0][2][1]
end

function var_0_0.Reset(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._go, false)

	return
end

function var_0_0.Destroy(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.games) do
		iter_6_1:Destroy()
	end

	return
end

return var_0_0
