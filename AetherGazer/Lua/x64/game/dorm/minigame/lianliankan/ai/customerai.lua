local var_0_0 = {}
local var_0_1 = {}

function var_0_0.SetEntity(arg_1_0, arg_1_1)
	var_0_1[arg_1_1] = arg_1_0
end

function var_0_0.Clear()
	var_0_1 = {}
end

function var_0_0.Work(arg_3_0)
	local var_3_0 = var_0_1[arg_3_0]

	Dorm.DormEntityManager.SendDoActionCMD(var_3_0, "sit_eat", false)
end

var_0_0.events = {
	[LIANLIANKAN_CUSTOMER_EAT] = var_0_0.Work
}

return var_0_0
