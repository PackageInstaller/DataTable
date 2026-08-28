--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-09-09 13:59:55
]]
local CreateRoleRecord = Class("CreateRoleRecord")

--@role: [Game.Battle.Entity.Role#Role]
function  CreateRoleRecord:__init(role)
    self.moudleId = role.moudleId
    self.id = role.id
    self.nowHp = role:GetNowHp()
    self.nowSp = role:GetUltraPoint()
    self.pos = role.standPosition
    self.isSummonCreep = role.isSummonCreep
    self.camp = role.camp
    self.monsterClass = role.monsterClass
    self.typeId = role.typeId
    self.roleType = role.roleType

    if self.isSummonCreep then
        self.attrBaseValues = {}
        for k,v in pairs(role.attr.baseValues) do
            if v and v ~= 0 then
                self.attrBaseValues[k] = v
            end
        end
    else
        self.attrBaseValues = nil
    end
end

function CreateRoleRecord:ToData()
    return {
        r = Constants.RecordType.CreateRole,--战报类型
        moudleId = self.moudleId,
        id = self.id,
        nowHp = self.nowHp,
        nowSp = self.nowSp,
        pos = self.pos,
        isSummonCreep = self.isSummonCreep,
        camp = self.camp,
        monsterClass = self.monsterClass,
        typeId = self.typeId,
        roleType = self.roleType,
        abvs = self.attrBaseValues,
    }
end

return  CreateRoleRecord