---@class ClassFromJson
local ClassFromJson = Class("ClassFromJson")

ClassFromJson.SetFunc={}
function ClassFromJson:Init(jsonData)
    self:FillFromJson(jsonData)
    self:CheckData()
end

function ClassFromJson:FillFromJson(jsonData)
    local data = checkTable(jsonData)
    for k, v in pairs(data) do
        if isSet(data, k) and table.haskey(self, k) then
            if type(self[k]) == table and self[k].InitFromJson ~= nil then
                self[k]:InitFromJson(v)
            else
                if self.SetFunc[k] ~= nil then
                    local func = self.SetFunc[k]
                    func(self, v)
                else
                    self[k] = v    
                end
            end
            
        end
    end
end

-- 检查数据或生成自定义数据结构
---@protected
function ClassFromJson:CheckData()

end

function ClassFromJson.StringKey_NumberKey(data)
    data = checkTable(data)
    local ret = {}
    for k, v in pairs(data) do
        local index = tonumber(k)
        if index == nil then
            printError("StringKey_NumberKey error, key is not number")
        else
            ret[index] = v
        end
    end
    return ret
end

return ClassFromJson