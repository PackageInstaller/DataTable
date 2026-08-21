local var_0_0 = class("MainOverDueSkinSequence", import(".MainOverDueAttireSequence"))

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ShipSkinProxy):getOverDueSkins()

	if #var_1_0 > 0 then
		arg_1_0:Display(SkinExpireDisplayPage, var_1_0, arg_1_1)
	else
		arg_1_1()
	end

	return
end

return var_0_0
