-- @FileName:   FieldExplorationEventTornadoSkill.lua
-- @Description:   龙卷风技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventTornadoSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.time = 0
    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    if self.playOnRange then
        self.time = self.time + gs.Time.deltaTime
        if self.time * 1000 >= self.config.damage_cd then
            self:addBuff()
            self.time = 0

        end
    end
end

function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)
    
    self.playOnRange = true

    self:addBuff()
    self.time = 0

end

function onCancel(self)
    self.playOnRange = false
end

function clearTimeOutSn(self)
    if self.mTimeOutSn then
        LoopManager:clearTimeout(self.mTimeOutSn)
        self.mTimeOutSn = nil
    end
end

function recover(self)
    super.recover(self)

    self:clearTimeOutSn()
end

return _M
