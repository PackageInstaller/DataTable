local var_0_0 = class("AdvanceRoleOnScreenCondition", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	return CaptureGameMgr:GetPlaceHolderMgr():IsSlotFull(true)
end

return var_0_0
