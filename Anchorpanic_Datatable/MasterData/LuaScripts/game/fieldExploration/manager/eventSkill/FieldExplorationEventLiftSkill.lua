-- @FileName:   FieldExplorationEventLiftSkill.lua
-- @Description:   事件电梯技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventLiftSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

end

--提示器碰撞触发
function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)
    if not self.m_workPosY then
        self.m_executeThing_postion = self.mExecuteThing:getPosition()
        self.m_workPosY = self.m_executeThing_postion.y
    end

    -- self.mTimerOutSn = LoopManager:setTimeout(0.2, self, self.onWork)
    self:onWork()
end

--电梯运行
function onWork(self)
    if not self.mLiftState then
        if self.config.param[1] == 1 then
            self.mLiftState = 1
        else
            self.mLiftState = -1
        end
    else
        self.mLiftState = self.mLiftState *- 1
    end
    self:killTween()
    -- self:clearTimerOutSn()

    self.m_workPosY = self.m_workPosY + self.config.param[3] * self.mLiftState
    local position = gs.Vector3(self.m_executeThing_postion.x, self.m_workPosY, self.m_executeThing_postion.z)
    self.mMoveTween = TweenFactory:move2pos(self.mExecuteThing:getTrans(), position, self.config.param[2] * 0.001, gs.DT.Ease.InOutQuint, function ()
        self:killTween()
        -- self:clearTimerOutSn()
    end)
end

function killTween(self)
    if self.mMoveTween then
        self.mMoveTween:Kill()
        self.mMoveTween = nil
    end
end

-- function clearTimerOutSn(self)
--     if self.mTimerOutSn then
--         LoopManager:clearTimeout(self.mTimerOutSn)
--         self.mTimerOutSn = nil
--     end
-- end

function recover(self)
    super.recover(self)

    -- self:clearTimerOutSn()
    self:killTween()
end

return _M
