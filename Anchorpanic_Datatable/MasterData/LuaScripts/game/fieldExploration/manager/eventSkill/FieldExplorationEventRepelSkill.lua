-- @FileName:   FieldExplorationEventRepelSkill.lua
-- @Description:   击退技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventRepelSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.mMaxDistance = 1
    self.mMaxSpeed = 0.1

    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
    self.isHit = false
end

function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)

    self.mCurForwardDistance = 0
    self.mSpeed = self.mMaxSpeed
end

function onFrame(self)
    self.mSpeed = gs.Mathf.Lerp(self.mSpeed, 0, gs.Time.deltaTime)
    self.mCurForwardDistance = self.mCurForwardDistance + self.mSpeed

    if self.mCurForwardDistance > self.mMaxDistance then
        self:clearFrameSn()
        self.mSpeed = self.mMaxDistance - self.mCurForwardDistance
    end

    local forward = self.mExecuteThing:getPosition() - self.mTargetThing:getPosition()

    self.mTargetThing:setTranForward(self.mSpeed * -1, forward.normalized)
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function recover(self)
    super.recover(self)

    self:clearFrameSn()
end
return _M
