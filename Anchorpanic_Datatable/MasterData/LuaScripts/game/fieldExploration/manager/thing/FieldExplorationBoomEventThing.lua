-- @FileName:   FieldExplorationBoomEventThing.lua
-- @Description:   炸弹事件
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationBoomEventThing', Class.impl(fieldExploration.FieldExplorationPropEventThing))

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    self.mModel:AddFrameCallEvent(FieldExplorationConst.NAME_DIE, function ()
        local eventConfig = self:getEventConfig()
        if eventConfig then
            self:addEffect(eventConfig.idle_effct)

            self:addSoundEffct(eventConfig.idle_sound)
        end
    end, 90)
end

--提示器碰撞触发
function onSkillExecute(self, executeThing, targetThing)
    if self.isOnExecute then return end

    local eventConfig = self:getEventConfig()
    if eventConfig then
        if not table.empty(eventConfig.skill_id) then
            local playerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
            for _, skill_id in pairs(eventConfig.skill_id) do
                local skill = self:getSkill(skill_id)
                skill:onExecute(self, playerTing)
            end
        end

        self.isOnExecute = true
    end

    self:playAction(FieldExplorationConst.ACT_DIE)
    self:getAniLenght(FieldExplorationConst.NAME_DIE, function (time)
        self:setTimeOut(time + 0.5, function (thing)
            fieldExploration.FieldExplorationSceneController:deleteSceneEvent(thing.mData.id)
        end)
    end)
end

function playAction(self, aniHash)
    if not self.mModel then
        return
    end

    self.mModel:playAction(aniHash)

    local eventConfig = self:getEventConfig()
    if eventConfig then
        self:clearEffect()
        self:clearSound()

        if aniHash == FieldExplorationConst.ACT_STAND then
            self:addEffect(eventConfig.stand_effct)

            self:addSoundEffct(eventConfig.stand_sound)
        elseif aniHash == FieldExplorationConst.ACT_GOIN then
            self:addEffect(eventConfig.goin_effct)

            self:addSoundEffct(eventConfig.goin_sound)
        elseif aniHash == FieldExplorationConst.ACT_ATK01 then
            self:addEffect(eventConfig.atk_effct)

            self:addSoundEffct(eventConfig.atk_sound)
        end
    end
end

return _M
