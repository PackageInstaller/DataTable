local M = BaseClass('PersonalMissionCompletedCondition', BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    return DormDataMgr:IsPassPersonalCopy(arg1, arg2)
end

return M
