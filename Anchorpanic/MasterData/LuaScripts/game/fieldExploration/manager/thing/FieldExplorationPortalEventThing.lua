-- @FileName:   FieldExplorationPortalEventThing.lua
-- @Description:   传送门事件
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationPortalEventThing', Class.impl(fieldExploration.FieldExplorationPropEventThing))

--碰撞触发
function onColliderEnter(self, tag, colliderTagID)
    if tag == FieldExplorationConst.ColliderTag.Event then
        local colliderThing = fieldExploration.FieldExplorationSceneController:getSceneEvent(colliderTagID)
        if colliderThing then
            self:onSkillExecute(colliderThing)
        end
    elseif tag == FieldExplorationConst.ColliderTag.Player then
        self:onSkillExecute()
    end
end

--触发(触发方式：计时器定时自动触发、触发器碰撞触发、玩家技能触发)
function onSkillExecute(self, targetThing)
    if self.isDisable then return end
    if self.isOnExecute then return end

    targetThing = targetThing or fieldExploration.FieldExplorationSceneController:getPlayerThing()

    local eventConfig = self:getEventConfig()
    if eventConfig then
        if not table.empty(eventConfig.skill_id) then
            for _, skill_id in pairs(eventConfig.skill_id) do
                local skill = self:getSkill(skill_id)
                skill:onExecute(self, targetThing)
            end
        end

        self.isOnExecute = true
    end

    self:addEffect(eventConfig.atk_effct)
    self:addSoundEffct(eventConfig.atk_sound)
    self:playAction(FieldExplorationConst.ACT_ATK01)

    if eventConfig.repeat_type == FieldExplorationConst.EVENT_REPEAT_TYPE.NOT_REPEAT_1 then
        self:addEffect(eventConfig.idle_effct)
        self:addSoundEffct(eventConfig.idle_sound)
        self:playAction(FieldExplorationConst.ACT_DIE)

        self:getAniLenght(FieldExplorationConst.NAME_DIE, function (time)
            self:setTimeOut(time, function (thing)
                fieldExploration.FieldExplorationSceneController:deleteSceneEvent(self.mData.id)
            end)
        end)

    elseif eventConfig.repeat_type == FieldExplorationConst.EVENT_REPEAT_TYPE.NOT_REPEAT_2 then
        self.isDisable = true
    end
end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Player, FieldExplorationConst.ColliderTag.Event}
end

return _M
