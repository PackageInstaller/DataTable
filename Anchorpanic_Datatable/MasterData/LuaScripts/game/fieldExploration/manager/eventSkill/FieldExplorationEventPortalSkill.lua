-- @FileName:   FieldExplorationEventPortalSkill.lua
-- @Description:   传送门技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventPortalSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)
    self.mEventType = self.config.param[1]
    self.mPortalPos = {x = self.config.param[2][1], y = self.config.param[2][2], z = self.config.param[2][3]}
end

function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)
    local ColliderCall = targetThing:getColliderCall()
    if ColliderCall.SelfColliderTag == FieldExplorationConst.ColliderTag.Event then
        if self.mEventType == 0 then
            return
        end

        local eventConfigVo = targetThing:getEventConfig()
        if eventConfigVo.type == self.mEventType then
            targetThing:setPosition(self.mPortalPos)
        end
    elseif ColliderCall.SelfColliderTag == FieldExplorationConst.ColliderTag.Player then
        targetThing:setPosition(self.mPortalPos)
    end
end

return _M
