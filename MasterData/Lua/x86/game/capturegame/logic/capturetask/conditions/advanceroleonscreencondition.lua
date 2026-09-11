local AdvanceRoleOnScreenCondition = class("AdvanceRoleOnScreenCondition", CaptureConditionBase)

function AdvanceRoleOnScreenCondition:CheckCondition(arg_1_1)
	return CaptureGameMgr:GetPlaceHolderMgr():IsSlotFull(true)
end

return AdvanceRoleOnScreenCondition
