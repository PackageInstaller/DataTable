--[[
****************************************************************************
Brief  :Skill_10 塞薇娅 大招-极风打
Author :James Ou
Date   :2020-03-18
****************************************************************************
]]

module('fight.Skill_2', Class.impl('game/fight/ai/skill/BaseSkill'))
-- 技能ID
SKILLID = 2
-- 动作需要时间
ACTION_TIME = 0.5
-- 伤害范围半径
INJURY_RADIUS = 4
-- 持续时间
DURATION = 0.2

-- 开始使用技能
function onStartUseSkill(self)
    super.onStartUseSkill(self)
    self:toChanting(ACTION_TIME)
end

-- 吟唱结束触发
function onChantEnd(self)
    super.onChantEnd(self)
    local delayTime = 0
    local travel = STravelFactory:travel(SKILLID, self.m_attacker_vo.id, self.m_main_target_vo.id)
    local function _hitCall(skillID, casterID, targetIds)
        -- if self.m_actionData then
        --     for _,v in ipairs(self.m_actionData.hero_list) do
        --         if fight.SceneManager:getThing(v.hero_id) then
        --             for _,eft in ipairs(v.effect_list) do
        --                 if eft.type==1 then
        --                     self:toDamage(v.hero_id, eft.count)
        --                     BuffHandler:addBuff(self.m_attacker_vo.id, v.hero_id, 20)
        --                 end
        --             end
        --         end
        --     end
        -- end
        self:playEftTmp(SKILLID)
    end
    local function _endCall()
        -- self:setSkillLiveTimeout(self:getActionTime(delayTime), self, self.skillAiComplete)
    end
    self:setTravelEventCall(travel, _hitCall, _endCall)
    travel:start()
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
