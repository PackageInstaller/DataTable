-- @FileName:   FieldExplorationEventStepGridSkill.lua
-- @Description:   踩踏格子技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventStepGridSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.m_stepState = false
    self.m_disable = false
end

---执行技能
function onExecute(self, executeThing, targetThing)
    if self.m_disable then
        return
    end

    super.onExecute(self, executeThing, targetThing)

    -- logAll("onExecute----")
    if self.m_stepState then
        local thingIdList = self.config.param[1]
        for i = 1, #thingIdList do
            local thing = fieldExploration.FieldExplorationSceneController:getSceneEventByTid(thingIdList[i])
            if not thing then
                logError("配置了不存在的事件  id = " .. thingIdList[i])
            else
                local eventConfig = thing:getEventConfig()
                for _, skill_id in pairs(eventConfig.skill_id) do
                    local skillConfig = fieldExploration.FieldExplorationManager:getEventSkillConfig(skill_id)
                    if skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_STEPGRID then-- 踩踏地板
                        local skill = thing:getSkill(skill_id)
                        skill:resetStepState()
                    end
                end
            end
        end
    else
        self.m_stepState = true

        self:checkAllStepGridState()
        self:refreshShowEfx()
    end
end

function checkAllStepGridState(self)
    local isPass = true
    local thingIdList = self.config.param[1]
    for i = 1, #thingIdList do
        local thing_id = thingIdList[i]
        local thing = fieldExploration.FieldExplorationSceneController:getSceneEventByTid(thing_id)
        if not thing then
            logError("配置了不存在的事件  id = " .. thing_id)
        else
            local eventConfig = thing:getEventConfig()
            for _, skill_id in pairs(eventConfig.skill_id) do
                local skillConfig = fieldExploration.FieldExplorationManager:getEventSkillConfig(skill_id)
                if skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_STEPGRID then-- 踩踏地板
                    local skill = thing:getSkill(skill_id)
                    if not skill:getStepState() then
                        -- logAll(thing_id,"为踩踏事件id = ")
                        isPass = false
                        break
                    end
                end
            end

            if not isPass then
                break
            end
        end
    end

    -- logAll(isPass, "-----")
    if isPass then
        for i = 1, #thingIdList do
            local thing_id = thingIdList[i]
            local thing = fieldExploration.FieldExplorationSceneController:getSceneEventByTid(thing_id)
            if not thing then
                logError("配置了不存在的事件  id = " .. thing_id)
            else
                local eventConfig = thing:getEventConfig()
                for _, skill_id in pairs(eventConfig.skill_id) do
                    local skillConfig = fieldExploration.FieldExplorationManager:getEventSkillConfig(skill_id)
                    if skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_STEPGRID then-- 踩踏地板
                        local skill = thing:getSkill(skill_id)
                        skill:disable()
                    end
                end
            end
        end

        local executeParam = self.config.param[2]
        local targetThing = fieldExploration.FieldExplorationSceneController:getSceneEventByTid(executeParam[1])
        if targetThing then
            local skill_id = executeParam[2]
            if skill_id == nil then
                targetThing:onSkillExecute()
            else
                local skill = targetThing:getSkill(skill_id)
                skill:onExecute(targetThing)
            end
        end
    end
end

function disable(self)
    self.m_disable = true
end

function resetStepState(self)
    self.m_stepState = false
    -- logAll("重置踩踏板状态")
    self:refreshShowEfx()
end

function refreshShowEfx(self)
    if self.m_stepState then
        self.m_stateEfxSn = self.mExecuteThing:addEffect("fx_gold_10_biaozhi_a_001_g.prefab")
    else
        if self.m_stateEfxSn then
            self.mExecuteThing:removeEffect(self.m_stateEfxSn)
            self.m_stateEfxSn = nil
        end
    end
end

function getStepState(self)
    return self.m_stepState
end

function recover(self)
    super.recover(self)

    self.m_disable = false
end

return _M
