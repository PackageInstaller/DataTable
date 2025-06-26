module("fight.FightAI", Class.impl())
m_find_target_ctl = require('game/fight/ai/target/Target_1')
function setData(self, cusLivethingVo)
    self.m_l_vo = cusLivethingVo
    self.id = cusLivethingVo.id
    -- 当前使用的技能AI
    self.m_curSkillAI = nil
    -- 有效作用的技能AI集合
    self.m_skillAISet = {}

    self.lastSkillVo = nil
    self:startStep()
end

-- 设置收到技能播放完后 是否结束
function setCompleteEnd(self, isEnd)
    self.m_isCompleteEnd = isEnd
end

function startStep(self)
    fight.LiveLooper:addFrame(self.id, 1, 0, self, self.step)
end

function reset(self)
    fight.LiveLooper:removeFrame(self, self.step)
    for _, sAI in pairs(self.m_skillAISet) do
        sAI:removeEventListener(fight.AIEvent.SKILL_AI_COMPLETE, self.onSkillAIComplete, self)
        sAI:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        sAI:reset()
        fight.AIUtil.recoverSkillAI(sAI);
    end
    self.m_skillAISet = {}
    self.m_curSkillAI = nil
end

function step(self, deltaTime)
    if self.m_l_vo:isDead() == false and self.m_l_vo:canUseSkill() == true then
        self:findMainTarget()
        self:tryToUseSkill()
    end
end

function findMainTarget(self)
    -- if self.m_target_vo == nil or self.m_target_vo:isDead() or self.m_target_vo:canBeAttacked() == false then
    --测试阶段先每帧重新选择目标，后期再加入刷新规则
    self.m_target_vo = m_find_target_ctl.findTarget(self.m_l_vo)
    -- end
end

function tryToUseSkill(self)
    local bigSkillVo --= self:getNextSkill()  
    -- local skillVo = self.m_l_vo:getNextSkill()  
    if self:checkExSkill() then
        -- 能量已满，可以释放必杀技
        -- 判断该必杀技是否需要等待当前技能完成
        bigSkillVo = self.m_l_vo:getExSkillVo()
        if bigSkillVo and bigSkillVo:needBreak() then
            if self.m_curSkillAI and self.m_curSkillAI:breakSkill() then
                if self.m_curSkillAI then
                    self.m_curSkillAI:removeEventListener(fight.AIEvent.SKILL_AI_COMPLETE, self.onSkillAIComplete, self)
                end
                self.m_curSkillAI = nil
            end
        end
    end

    if self.m_curSkillAI == nil then
        local skillVo = bigSkillVo
        if skillVo == nil and self:checkExSkill() == false then
            skillVo = self:getNextSkill()
        end
        if not skillVo then
            return
        end


        self.m_curSkillAI = fight.AIUtil.createSkillAI(self.m_l_vo, self.m_target_vo, skillVo)
        self.m_curSkillAI:addEventListener(fight.AIEvent.SKILL_AI_COMPLETE, self.onSkillAIComplete, self)
        self.m_curSkillAI:addEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        if self.m_skillAISet[self.m_curSkillAI:sn()] then
            Debug:log_error("FightAI", "already have skillAI sn [%s] liveID [%s] skillID [%s] ================== !!!", self.m_curSkillAI:sn(), self.id, self.m_curSkillAI:skillID())
        end
        self.m_skillAISet[self.m_curSkillAI:sn()] = self.m_curSkillAI
    else
        self.m_curSkillAI:resetMainTarget(self.m_target_vo)
    end
end

-- 整个技能结束了
function onSkillEnd(self, skillAISn)
    local sAI = self.m_skillAISet[skillAISn]
    if sAI then
        sAI:removeEventListener(fight.AIEvent.SKILL_AI_COMPLETE, self.onSkillAIComplete, self)
        sAI:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        fight.AIUtil.recoverSkillAI(sAI);
        self.m_skillAISet[skillAISn] = nil
        if self.m_curSkillAI and self.m_curSkillAI:sn() == skillAISn then
            self.m_curSkillAI = nil
        end
    end
end
-- 技能放出了，角色可自由活动了
function onSkillAIComplete(self)
    if self.m_curSkillAI ~= nil then
        self.m_curSkillAI:removeEventListener(fight.AIEvent.SKILL_AI_COMPLETE, self.onSkillAIComplete, self)
        -- 这里不回收由技能AI自己回收
        self.m_curSkillAI = nil
    end
    if self.m_isCompleteEnd == true then
        fight.LiveLooper:removeFrame(self, self.step)
        return
    end
end

function getNextSkill(self)
    local skillVo
    local list = self.m_l_vo:getSkills()

    for _, vo in pairs(list) do
        if vo.type == SkillType.DEFAULT then
            skillVo = vo
        else
            local isCd = fight.CDManager:isCDing(self.m_l_vo.id, vo)
            if isCd == false and (self.lastSkillVo == nil or self.lastSkillVo.id ~= vo.id) then
                skillVo = vo
            end
        end
    end
    self.lastSkillVo = skillVo
    return skillVo
end

-- 必杀技是否可以释放
function checkExSkill(self)
    local curMp = self.m_l_vo:getAtt(AttConst.MP)
    local curMpMax = self.m_l_vo:getAtt(AttConst.MP_MAX)
    if curMpMax > 0 and curMp >= curMpMax then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
