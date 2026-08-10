local var_0_0 = class("ReserveMimirDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.mimir_id = 0
	arg_1_0.chip_list = {}
end

function var_0_0.UpdateServerData(arg_2_0, arg_2_1)
	arg_2_0.mimir_id = arg_2_1.mimir_id
	arg_2_0.chip_list = cleanProtoTable(arg_2_1.chip_list)
end

function var_0_0.ConvertToSendData(arg_3_0)
	return {
		mimir_id = arg_3_0.mimir_id,
		chip_list = clone(arg_3_0.chip_list)
	}
end

function var_0_0.Reset(arg_4_0)
	arg_4_0.mimir_id = 0
	arg_4_0.chip_list = {}
end

return var_0_0
