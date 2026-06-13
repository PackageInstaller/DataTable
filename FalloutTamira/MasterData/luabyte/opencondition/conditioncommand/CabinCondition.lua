local M = BaseClass("CabinCondition", BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    local cabinData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(arg1)
    if cabinData == nil then
        return false
    end
    for i = 1, #cabinData do
       if cabinData[i]:Level()>=arg2 then
            return true
       end
    end
    return false
end

return M
