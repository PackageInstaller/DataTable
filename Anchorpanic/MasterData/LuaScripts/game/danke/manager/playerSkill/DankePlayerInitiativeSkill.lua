-- @FileName:   DankePlayerInitiativeSkill.lua
-- @Description:   玩家主动技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerInitiativeSkill', Class.impl(danke.DankePlayerBaseSkill))

function resetData(self)
    super.resetData(self)

    self.m_deltaTime = 0
    self.m_lastExecuteTime = -1 --上一次执行技能的时间

    if self.m_cd > 0 then
        self:clearFrame()
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
    else
        self:onExecute()
    end
end

function refreshParam(self)
    super.refreshParam(self)

    self.damage = self.m_skillLevel.damage --伤害
    self.m_cd = self.m_skillLevel.cd * 0.001 --释放CD
end

function onFrame(self)
    self.m_deltaTime = self.m_deltaTime + LoopManager:getDeltaTime()

    if self.m_lastExecuteTime == -1 or self.m_deltaTime - self.m_lastExecuteTime >= self.m_cd then
        self:onExecute()
    end
end

function onExecute(self)
    super.onExecute(self)

    local playThing_attr = self.m_playerThing:getAttr()
    self.m_bulletSpeed = self.m_skillLevel.bullet_speed * (1 + playThing_attr.add_bullet_flyspeed) --子弹飞行速度
    self.m_bulletDamage = self.m_skillLevel.damage * (1 + playThing_attr.damage_ratio)

    self.m_lastExecuteTime = self.m_deltaTime
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function onRecover(self)
    super.onRecover(self)

    self.m_deltaTime = nil

    self.damage = nil
    self.m_cd = nil
    self.m_bulletSpeed = nil

    self:clearFrame()
end

return _M
