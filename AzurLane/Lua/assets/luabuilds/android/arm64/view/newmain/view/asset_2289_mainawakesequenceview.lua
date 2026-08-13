class = var_0_10000

local var_0_0 = "MainAwakeSequenceView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainSequenceView"))

function var_0_1.Ctor(arg_1_0)
	local var_1_0 = {}

	MainPlayerTestSequence = var_1_10002
	var_1_0[1] = var_1_10002.New()
	MainCompatibleDataSequence = var_2
	var_1_0[2] = var_2.New()
	MainRandomFlagShipSequence = var_2
	var_1_0[3] = var_2.New()
	MainFixSettingDefaultValue = var_2
	var_1_0[4] = var_2.New()
	arg_1_0.sequence = var_1_0

	return
end

function var_0_1.Execute(arg_2_0, arg_2_1)
	if not arg_2_0.executable then
		arg_2_0.executable = arg_2_0:MapSequence(arg_2_0.sequence)
	end

	seriesAsync = var_2

	var_2(arg_2_0.executable, arg_2_1)

	return
end

return var_0_1
