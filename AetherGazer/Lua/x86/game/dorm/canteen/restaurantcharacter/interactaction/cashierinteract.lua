local var_0_0 = import(".InteractUtil")
local var_0_1 = var_0_0.NewTask
local var_0_2 = var_0_0.IsCustomer

return function(arg_1_0)
	local var_1_0 = arg_1_0.targetType
	local var_1_1 = arg_1_0.entityID
	local var_1_2 = arg_1_0.entityData
	local var_1_3 = arg_1_0.finish

	if var_0_2(var_1_0) then
		var_0_1(function()
			Dorm.DormEntityManager.PlayAnimeDuringInteract(var_1_1, "cashier")
		end):WaitForSec(5):Then(function()
			var_1_2.cashierObject = nil

			print("收银成功")
			var_1_3:Notify()
		end):Start()
	end
end
