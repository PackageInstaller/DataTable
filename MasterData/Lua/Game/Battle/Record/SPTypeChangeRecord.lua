--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-09-09 13:59:55
]]
local 
SPTypeChangeRecord = Class("SPTypeChangeRecord")

--@role: [Game.Battle.Entity.Role#Role]
function  SPTypeChangeRecord:__init(roleId, fromType, toType)
    self.roleId = roleId
    self.fromType = fromType
    self.toType = toType
end

function SPTypeChangeRecord:ToData()
    return {
        r = Constants.RecordType.SPTypeChange,--战报类型
        rId = self.roleId,
        ft = self.fromType,
        tt = self.toType,
    }
end

return  SPTypeChangeRecord