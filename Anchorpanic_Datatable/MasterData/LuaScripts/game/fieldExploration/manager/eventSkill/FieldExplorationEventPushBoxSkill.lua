-- @FileName:   FieldExplorationEventPushBoxSkill.lua
-- @Description:   推箱子技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventPushBoxSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

---执行技能
function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)

    local parent = self.mTargetThing:getTrans()

    local moveMode, dir = self:getMoveMode(self.mExecuteThing, self.mTargetThing)
    if moveMode == FieldExplorationConst.PlayerMoveType.Free_Mode then
        return
    end

    self.mTargetThing:setMoveMode(moveMode)

    local angle_y = 0
    if dir == "Left" then
        angle_y = 270
    elseif dir == "Right" then
        angle_y = 90
    elseif dir == "Forward" then
        angle_y = 0
    elseif dir == "back" then
        angle_y = 180
    end
    self.mTargetThing:setEulerAngles({x = 0, y = angle_y, z = 0})
    self.mExecuteThing:setParent(self.mTargetThing:getTrans(), true)
end

function onCancel(self)
    self.mTargetThing:resetMoveMode()

    self.mExecuteThing:setParent(nil, true)
end

--获取移动模式，玩家朝向
function getMoveMode(self, executeThing, targetThing)
    local targetPos = executeThing:getPosition()
    local playerPos = targetThing:getPosition()

    local target_eventConfig = executeThing:getEventConfig()
    local length = target_eventConfig.interact_range[1] * 0.01 --长
    local width = target_eventConfig.interact_range[2] * 0.01 --宽

    local trans = executeThing:getTrans()
    local angle_1, angle_2 = trans.localEulerAngles.y - 90, trans.localEulerAngles.y - 270
    if math.abs(angle_1) <= 5 or math.abs(angle_2) <= 5 then
        local oldWidth = width
        width = length
        length = oldWidth
    end

    local result = playerPos.x - targetPos.x

    local size_length = (length / 2) + targetThing:getData().config.agent_radius
    if math.abs(result) + 0.2 > size_length then
        if playerPos.x < targetPos.x then
            return FieldExplorationConst.PlayerMoveType.Horizontal_Mode, "Right"
        elseif playerPos.x > targetPos.x then
            return FieldExplorationConst.PlayerMoveType.Horizontal_Mode, "Left"
        end
    else
        result = playerPos.z - targetPos.z
        size_length = (width / 2) + targetThing:getData().config.agent_radius
        if math.abs(result) + 0.2 > size_length then
            if playerPos.z < targetPos.z then
                return FieldExplorationConst.PlayerMoveType.Vertical_Mode, "Forward"
            elseif playerPos.z > targetPos.z then
                return FieldExplorationConst.PlayerMoveType.Vertical_Mode, "back"
            end
        end
    end

    return FieldExplorationConst.PlayerMoveType.Free_Mode, "None"
end

return _M
