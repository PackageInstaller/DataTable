local var_0_0 = class("CheckCustomNameShip", import("model.vo.Ship"))

function var_0_0.getName(arg_1_0)
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return arg_1_0:GetDefaultName()
	else
		return var_0_0.super.getName(arg_1_0)
	end

	return
end

return var_0_0
