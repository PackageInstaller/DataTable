-- @FileName:   DankeMonsterBaseSkill.lua
-- @Description:   玩家技能基类类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterSkill.DankeMonsterBaseSkill', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function recover(self)
    LuaPoolMgr:poolRecover(self)
end

function create(self, executeThing, skillVo)
    local item = self:poolGet()

    item.m_skillVo = skillVo
    item.m_executeThing = executeThing

    item:resetData()

    return item
end

function resetData(self)
    self.m_isCdFinishCall = false

    self.m_lastExecuteTime = 0 --上一次执行技能的时间

    self.m_deltaTime = 0

    self:clearFrame()
    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function onFrame(self)
    self.m_deltaTime = self.m_deltaTime + LoopManager:getDeltaTime()

    if not self:isOnCd() then
        self.m_isCdFinishCall = false
        self:onCdFinishCall()
    end
end

function onExecute(self)
    self.m_isCanExecute = true
end

function onExecuteFinish(self)
    self.m_lastExecuteTime = self.m_deltaTime
    self.m_isCanExecute = false --默认不能执行技能

    if self.m_executeThing.skillExecuteFinish then
        self.m_executeThing:skillExecuteFinish(self)
    end
end

function onCdFinishCall(self)
    if self.m_isCdFinishCall then
        return
    end

    if self.m_executeThing.onExecuteSkill then
        self.m_executeThing:onExecuteSkill()
    end
    self.m_isCdFinishCall = true
end

function isOnCd(self)
    return self.m_deltaTime - self.m_lastExecuteTime <= self.m_skillVo.cd
end

function getDataVo(self)
    return self.m_skillVo
end

function onRecover(self)
    self.m_skillVo = nil

    self.m_isCdFinishCall = nil
    self.m_lastExecuteTime = nil
    self.m_deltaTime = nil
    self.m_executeThing = nil

    self:clearFrame()
end

return _M
