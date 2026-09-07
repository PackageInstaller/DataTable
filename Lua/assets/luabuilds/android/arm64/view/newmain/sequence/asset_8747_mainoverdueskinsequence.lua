local MainOverDueSkinSequence = class("MainOverDueSkinSequence", import(".MainOverDueAttireSequence"))

function MainOverDueSkinSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(ShipSkinProxy):getOverDueSkins()

	if #var_1_0 > 0 then
		self:Display(SkinExpireDisplayPage, var_1_0, arg_1_1)
	else
		arg_1_1()
	end

	return
end

return MainOverDueSkinSequence
