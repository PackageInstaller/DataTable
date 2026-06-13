local M = BaseClass("BagHaveItemCondition", BaseCommand)

function M:Execute(args)
    local arg1, arg2 = table.unpack(args)
    local dataMgr = ItemDataMgr:GetInstance()
    local data = dataMgr:GetItemNumById(arg1)
    return data > 0
end

return M
