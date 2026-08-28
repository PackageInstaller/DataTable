--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-09-09 13:59:55
]]
local CreateSkillCatRecord = Class("CreateSkillCatRecord")

--@role: [Game.Battle.Entity.Role#Role]
function  CreateSkillCatRecord:__init(catData, camp)
    self.id = catData.id
    self.catId = catData.catId
    self.type = catData.type
    self.star = catData.star
    self.playerId = catData.playerId
    self.camp = camp
    self.finalSkills = catData.finalSkills
    self.passiveSkills = catData.passiveSkills
end

function CreateSkillCatRecord:ToData()
    return {
        r = Constants.RecordType.CreateSkillCat,--战报类型
        id = self.id,
        cId = self.catId,
        t = self.type,
        s = self.star,
        pId = self.playerId,
        c = self.camp,
        fs = self.finalSkills,
        ps = self.passiveSkills,
    }
end

return  CreateSkillCatRecord