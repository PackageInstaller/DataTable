--
-- Author:luqucheng
-- Date: 2019-11-27 11:47:58
--
local gameUtils = CS.GameUtils
local SkillCard = {}
SkillCard = Class('SkillCard')

SkillCard.roleId = nil
SkillCard.skillIndex = nil
SkillCard.star = nil
SkillCard.isUltra = nil
SkillCard.skillCardVo = nil

SkillCard.skillCardId = nil

function  SkillCard:__init( roleId, skillIndex, star, isUltra, id)
    self.roleId = roleId
    self.skillIndex = skillIndex
    self.star = star
    self.isUltra = isUltra
    self.id = id or Core:GetNextSkillCardID()
    -- self.skillCardId = self:GetSkillCardId()
    -- local skinData = setting:Get(self.skillCardId)
end

-- function SkillCard:GetSkillCardId()
--     local roleData = Core:FindRoleDataById(self.roleId)
--     if self.skillIndex == 0 then
--         local ultraInfo = Tools.splitToNum( roleData.finalSkills, '=')
--         return ultraInfo[1]
--     end

--     return roleData.generalSkills[checkString(self.skillIndex)]
-- end

function SkillCard:ToData(  )
    return table.concat( {self.roleId, self.skillIndex, self.star}, "_")
end

return  SkillCard