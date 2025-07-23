-- @FileName:   FieldExplorationEventToggleSkill.lua
-- @Description:   状态开关技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventToggleSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.m_skillDic = {}
end

function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)

    self.tag = self.config.tid .. "_" .. self.mExecuteThing:getData().id
    
    local param =
    {
        enId = self.config.param[2],
        callback = function ()
            for i = 1, #self.config.param[1] do
                local event_param = self.config.param[1][i]
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
                            logError("事件tid" .. eventThing.mData.tid .. "不存在技能id为" .. skill_id .. "的技能,请检查开光执行类型是1还是2")
                            return
                        end

                        local skill = eventThing:getSkill(skill_id)
                        skill:onExecute(eventThing, targetThing)
                    end
                elseif toggle_type == 2 then
                    local skill = self.m_skillDic[skill_id]
                    if not skill then
                        skill = FieldExplorationConst.GetSkill(skill_id)
                        self.m_skillDic[skill_id] = skill
                    end
                    skill:onExecute(eventThing, targetThing)
                end
            end
        end
    }

    local data =
    {
        tag = self.tag,
        params = {},
    }
    table.insert(data.params, param)

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SHOWFUNCLICK, data)
end

function onCancel(self, executeThing, targetThing)
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_HIDEFUNCLICK, self.tag)
end

function recover(self)
    super.recover(self)

    if not table.empty(self.m_skillDic) then
        for skill_id, skill in pairs(self.m_skillDic) do
            skill:recover()
        end
        self.m_skillDic = nil
    end
    self.tag = nil
end

return _M
