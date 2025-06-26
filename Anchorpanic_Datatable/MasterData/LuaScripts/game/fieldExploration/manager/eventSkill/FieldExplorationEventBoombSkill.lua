-- @FileName:   FieldExplorationEventBoombSkill.lua
-- @Description:   炸弹技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventBoombSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))


function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)

    self.isHit = false
    self.mCurMSTime = 0
    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    self.mCurMSTime = self.mCurMSTime + (gs.Time.deltaTime * 1000)

    if self.mCurMSTime >= self.config.decide_time[1] and self.mCurMSTime <= self.config.decide_time[2] then
        if not self.isHit then
            if self.playOnRange then
                self:addBuff()

                self.isHit = true
            end
        end
    elseif self.mCurMSTime > self.config.decide_time[2] then
        self:clearFrameSn()

        gs.GameObject.Destroy(self.mGo)
        self.mGo = nil
    end
    self.mCurMSTime = self.mCurMSTime + 1
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

--提示器碰撞触发
function onTriggerEnterCall(self, tag, colliderTagID)
    self.playOnRange = true
end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)
    self.playOnRange = false
end

function recover(self)
    super.recover(self)

    self:clearFrameSn()
end

return _M
