local SingleRoleOnAnimatedCheck = class("SingleRoleOnAnimatedCheck", CaptureConditionBase)

function SingleRoleOnAnimatedCheck:CheckCondition(arg_1_1)
	local var_1_0 = CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId()))

	if not var_1_0 then
		return false
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[1]) do
		if var_1_0:IsInAnim(iter_1_1) then
			return true
		end
	end

	return false
end

function SingleRoleOnAnimatedCheck:GetConditionRecoomendAnim(arg_2_1)
	return arg_2_1[1] or {}
end

return SingleRoleOnAnimatedCheck
