local var_0_0 = class("NewEducateMinigameHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.games = {}
	arg_1_0.view = arg_1_2

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	setActive(arg_2_0._go, true)

	arg_2_0.config = pg.child2_minigame[arg_2_1]

	if not arg_2_0.games[arg_2_0.config.view_name] then
		arg_2_0.games[arg_2_0.config.view_name] = _G[arg_2_0.config.view_name].New(arg_2_0._tf)

		arg_2_0.games[arg_2_0.config.view_name]:RegisterView(arg_2_0.view)
	end

	arg_2_0.games[arg_2_0.config.view_name]:ExecuteAction("Show", arg_2_1, function(arg_3_0)
		arg_2_2((arg_2_0:GetNextId(arg_3_0)))

		return
	end)

	return
end

function var_0_0.GetNextId(arg_4_0, arg_4_1)
	if type(arg_4_1) ~= "number" then
		arg_4_1 = 0
	end

	local var_4_0 = arg_4_0.config.result_data

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.config.result_data) do
		if arg_4_1 >= iter_4_1[1][1] and arg_4_1 >= iter_4_1[1][2] then
			return iter_4_1[2][1]
		end
	end

	return var_4_0[#var_4_0][2][1]
end

function var_0_0.Reset(arg_5_0)
	setActive(arg_5_0._go, false)

	return
end

function var_0_0.Destroy(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.games) do
		iter_6_1:Destroy()
	end

	return
end

return var_0_0
