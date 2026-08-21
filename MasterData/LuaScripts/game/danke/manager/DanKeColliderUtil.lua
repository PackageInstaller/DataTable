-- @FileName:   DanKeColliderUtil.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-09-07 17:15:26
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.util.DanKeColliderUtil', Class.impl())

function setupData(self, trans, targetTrans, range)
    self.mTrans = trans
    self.mTargetTrans = targetTrans
    self.mRange = range

    self.onTriggerEnterCall = nil
    self.onTriggerExitCall = nil

    self.isOnCollider = false

    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    if self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans)and self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans) then
        local distance = gs.Vector3.Distance(gs.Vector3(self.mTrans.position.x, 0, self.mTrans.position.z), gs.Vector3(self.mTargetTrans.position.x, 0, self.mTargetTrans.position.z))
        if math.abs(distance) <= self.mRange then
            if not self.isOnCollider then
                if self.onTriggerEnterCall then
                    self.onTriggerEnterCall()
                end
                self.isOnCollider = true
            end
        else
            if self.isOnCollider then
                if self.onTriggerExitCall then
                    self.onTriggerExitCall()
                end

                self.isOnCollider = false
            end
        end
    end
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function recover(self)
    self:clearFrameSn()

    self.mTrans = nil
    self.mTargetTrans = nil
    self.mRange = nil
    self.onTriggerEnterCall = nil
    self.onTriggerExitCall = nil
end

return _M
