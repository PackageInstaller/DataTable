local var_0_0 = {
	func = {}
}

function var_0_0.register(arg_1_0, arg_1_1)
	var_0_0.func[arg_1_0] = arg_1_1
end

function var_0_0.call(arg_2_0)
	if not var_0_0.func[arg_2_0] then
		return
	else
		var_0_0.func[arg_2_0]()

		var_0_0.func[arg_2_0] = nil

		return
	end
end

function var_0_0.printNames()
	for iter_3_0, iter_3_1 in pairs(var_0_0.func) do
		print(iter_3_0)
	end
end

return var_0_0
