-- @FileName:   FieldExplorationEventPToggleSkill.lua
-- @Description:   压力开关技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventPToggleSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.m_skillDic = {}
end

function onExecute(self, executeThing, targetThing)
    if self.mExecuteThing then
        return
    end

    self.mExecuteThing = executeThing
    self:onToogle()
end

function onCancel(self, executeThing, targetThing)
    if not self.mExecuteThing then
        return
    end

    if self.mExecuteThing ~= executeThing then
        return
    end

    self:onToogle()

    self.mExecuteThing = nil
end

function onToogle(self)
    for i = 1, #self.config.param do
        local event_param = self.config.param[i]
        local toggle_type = event_param[1]
        local event_id = event_param[2][1]
        local skill_id = event_param[2][2]
        local eventThing = fieldExploration.FieldExplorationSceneController:getSceneEventByTid(event_id)
        if not eventThing then
            logError("场景中找不到这个事件" .. event_id)
        end

        if toggle_type == 1 then
            if skill_id == nil then
                eventThing:onSkillExecute()
            else
                local isConfigSkill = false
                local eventConfig = eventThing:getEventConfig()
                for _, _skill_id in pairs(eventConfig.skill_id) do
                    if _skill_id == skill_id then
                        isConfigSkill = true
                        break
                    end
                end

                if not isConfigSkill then
                    logError("事件" .. eventThing.mData.tid .. "不存在技能id为" .. skill_id .. "的技能,请检查开光执行类型是1还是2")
                    return
                end

                local skill = eventThing:getSkill(skill_id)
                skill:onExecute(eventThing)
            end
        elseif toggle_type == 2 then
            local skill = self.m_skillDic[skill_id]
            if not skill then
                skill = FieldExplorationConst.GetSkill(skill_id)
                self.m_skillDic[skill_id] = skill
            end
            skill:onExecute(eventThing)
        end
    end
end

function recover(self)
    super.recover(self)

    self.mExecuteThing = nil

    if not table.empty(self.m_skillDic) then
        for skill_id, skill in pairs(self.m_skillDic) do
            skill:recover()
        end
        self.m_skillDic = nil
    end
end

return _M
