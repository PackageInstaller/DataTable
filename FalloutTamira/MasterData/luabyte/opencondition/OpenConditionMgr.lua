local M = BaseClass("OpenConditionMgr", Singleton)
local tInsert = table.insert

function M:Execute(openConditionId, parameter)
    if openConditionId == 0 then return true end

    local cfg = ConfigHelper.GetCfg("openCondition", openConditionId)
    if cfg == nil then
        Logger.LogError(string.format("openCondition is nil. id = %d", openConditionId))
        return false
    end
    local cmdCtrl = OpenConditionConst[cfg.command]
    if not cmdCtrl then
        Logger.LogError(string.format("openCondition.command = %s is not exist ", cfg.command))
        return false
    end
    local args = {}
    tInsert(args, cfg.unlockParam1)
    tInsert(args, cfg.unlockParam2)
    if parameter then
        tInsert(args, parameter)
    end
    return cmdCtrl:Execute(args)
end

return M
