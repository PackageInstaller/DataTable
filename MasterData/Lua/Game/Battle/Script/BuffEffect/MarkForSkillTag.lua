--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')

local MarkForSkillTagBuffType = Constants.SpecialBuffType.MarkForSkillTag

local MarkForSkillTag = Class("MarkForSkillTag", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function MarkForSkillTag:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner

    local skillTag = data.effectNum1[1]

    local info = owner.buffMgr:GetSpecialStatus(MarkForSkillTagBuffType)
    if info == nil then
        owner.buffMgr:SetSpecialStatus(MarkForSkillTagBuffType, {[skillTag] = 1})
    else
        info[skillTag] = info[skillTag] or 0
        info[skillTag] = info[skillTag] + 1
    end
end

function MarkForSkillTag:OnRemove()
    local owner = self.buff.owner

    local info = owner.buffMgr:GetSpecialStatus(MarkForSkillTagBuffType)
    local skillTag = self.data.effectNum1[1]
    info[skillTag] = info[skillTag] - 1
    if info[skillTag] == 0 then
        info[skillTag] = nil
    end
end

return  MarkForSkillTag