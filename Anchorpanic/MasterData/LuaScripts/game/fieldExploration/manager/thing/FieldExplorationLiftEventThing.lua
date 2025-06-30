-- @FileName:   FieldExplorationLiftEventThing.lua
-- @Description:   电梯事件
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationLiftEventThing', Class.impl(fieldExploration.FieldExplorationPropEventThing))

--触发(触发方式：计时器定时自动触发、触发器碰撞触发、玩家技能触发)
function onSkillExecute(self)
    local eventConfig = self:getEventConfig()
    if eventConfig then
        if not table.empty(eventConfig.skill_id) then
            local playerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
            for _, skill_id in pairs(eventConfig.skill_id) do
                local skill = self:getSkill(skill_id)
                skill:onExecute(self, playerTing)
            end
        end
    end
end

function getColliderHeight(self)
    return 0.1
end

return _M
