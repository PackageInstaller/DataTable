--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')

local SkillCardCantGetSpBuffType = Constants.SpecialBuffType.SkillCardCantGetSp

local SkillCardCantGetSp = Class("SkillCardCantGetSp", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function SkillCardCantGetSp:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner

    local skillCardIndex = data.effectNum1[1]

    local info = owner.buffMgr:GetSpecialStatus(SkillCardCantGetSpBuffType)
    if info == nil then
        owner.buffMgr:SetSpecialStatus(SkillCardCantGetSpBuffType, {[skillCardIndex] = 1})
    else
        info[skillCardIndex] = info[skillCardIndex] or 0
        info[skillCardIndex] = info[skillCardIndex] + 1
    end
end

function SkillCardCantGetSp:OnRemove()
    local owner = self.buff.owner

    local info = owner.buffMgr:GetSpecialStatus(SkillCardCantGetSpBuffType)
    local skillCardIndex = self.data.effectNum1[1]
    info[skillCardIndex] = info[skillCardIndex] - 1
    if info[skillCardIndex] == 0 then
        info[skillCardIndex] = nil
    end
end

return  SkillCardCantGetSp