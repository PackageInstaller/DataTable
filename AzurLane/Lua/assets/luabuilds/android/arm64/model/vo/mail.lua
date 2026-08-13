class = var_0_10000

local var_0_0 = "Mail"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseMail"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.readFlag = arg_1_1.read_flag == 2
	arg_1_0.attachFlag = arg_1_1.attach_flag == 0 or arg_1_1.attach_flag == 2
	arg_1_0.importantFlag = arg_1_1.imp_flag == 1

	return
end

function var_0_1.setReadFlag(arg_2_0, arg_2_1)
	arg_2_0.readFlag = arg_2_1

	return
end

function var_0_1.setImportantFlag(arg_3_0, arg_3_1)
	arg_3_0.importantFlag = arg_3_1

	return
end

function var_0_1.setAttachFlag(arg_4_0, arg_4_1)
	arg_4_0.attachFlag = arg_4_1

	return
end

return var_0_1
