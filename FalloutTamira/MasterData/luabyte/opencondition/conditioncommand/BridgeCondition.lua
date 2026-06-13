local M = BaseClass('BridgeCondition', BaseCommand)

function M:Execute(args)
    local arg1, _ = table.unpack(args)
    local level = OtakuRoomDataMgr:GetInstance():GetBridgeCenterLevel()
    return arg1 <= level
end

return M
