local var_0_0 = {}
local var_0_1

function var_0_0.SetEntity(arg_1_0)
	var_0_1 = arg_1_0
end

function var_0_0.Work()
	if var_0_1 then
		Dorm.DormEntityManager.SendDoActionCMD(var_0_1, "manners", "01", false)
	end
end

var_0_0.events = {
	[LIANLIANKAN_USE_ITEM] = var_0_0.Work
}

return var_0_0
