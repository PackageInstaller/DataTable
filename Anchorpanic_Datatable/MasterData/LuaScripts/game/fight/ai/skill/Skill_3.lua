--[[
****************************************************************************
Brief  :Skill_10 塞薇娅 大招-极风打
Author :James Ou
Date   :2020-03-18
****************************************************************************
]]

module('fight.Skill_3', Class.impl('game/fight/ai/skill/BaseSkill'))
-- 技能ID
SKILLID = 3
-- 动作需要时间
ACTION_TIME = 0.5

-- 开始使用技能
function onStartUseSkill(self)
    super.onStartUseSkill(self)
    self:toChanting(ACTION_TIME)
end

-- 吟唱结束触发
function onChantEnd(self)
    super.onChantEnd(self)
    local allTarget = TargetManager:getDiffTeamPeople(self.m_attacker_vo.id)
    for _,v in ipairs(allTarget) do
        local travel = STravelFactory:travel(SKILLID, self.m_attacker_vo.id, v.id)
        if v.id ==self.m_main_target_vo.id then
            local function _hitCall(skillID, casterID, targetIds)
                -- if self.m_actionData then
                --     for _,v in ipairs(self.m_actionData.hero_list) do
                --         if fight.SceneManager:getThing(v.hero_id) then
                --             for _,eft in ipairs(v.effect_list) do
                --                 if eft.type==1 then
                --                     self:toDamage(v.hero_id, eft.count)
                --                 end
                --             end
                --         end
                --     end
                -- end
                self:playEftTmp(SKILLID)
            end
            local function _endCall()
                -- self:setSkillLiveTimeout(self:getActionTime(1), self, self.skillAiComplete)
            end
            self:setTravelEventCall(travel, _hitCall, _endCall)
        end
        travel:start()
    end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
