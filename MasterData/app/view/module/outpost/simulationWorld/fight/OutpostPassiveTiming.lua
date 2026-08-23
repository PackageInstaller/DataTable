local var_0_0 = {
	TimingType = {
		Default = 1,
		StartAttack = 2
	}
}

var_0_0.TimingEffect = {
	var_0_0.TimingType.Default,
	var_0_0.TimingType.StartAttack
}

function var_0_0.timing1()
	return function(arg_2_0, arg_2_1)
		return true
	end
end

function var_0_0.timing2()
	return function(arg_4_0, arg_4_1)
		return true
	end
end

return var_0_0
