-- @FileName:   FieldExplorationEventLasetShootSkill.lua
-- @Description:   状态开关技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventLasetShootSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.m_laserLength = 10

    self.m_targetThingId = self.config.param[1]
    self.m_executeThingId = self.config.param[2]
    self.m_executeSkillId = self.config.param[3] --目标事件的技能id为空，则全部执行事件上面的技能

    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_LASETSHOOTSKILL_CHECKRAYCAST, self.checkRaycast, self)
end

---执行技能
function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)
    if not self.m_targetThingId then
        logError("激光射线技能参数未配置目标事件,无法发射。请找屌剑 技能id = " .. self.config.tid)
        return
    end

    self.m_shootTrans = self.mExecuteThing:FindNameInChilds("shootPoint")

    self.m_lineRenderer = self.m_shootTrans:GetComponent(ty.LineRenderer)

    self:checkRaycast()
end

function checkRaycast(self)
    local pos = {}
    local startPoint = self.m_shootTrans.position
    local dir = self.m_shootTrans.forward

    table.insert(pos, startPoint)

    local hit_array = nil
    local hit = nil

    local Raycast = function ()
        hit = nil
        hit_array = CS.UnityEngine.Physics.RaycastAll(startPoint, dir, self.m_laserLength)
        if hit_array.Length <= 0 then
            return false
        end

        -- logAll(hit, "-----------")
        -- for i = 0, hit_array.Length - 1 do
        --     logAll(hit_array[i].transform)
        -- end

        local dis = self.m_laserLength
        for i = 0, hit_array.Length - 1 do
            local _hit = hit_array[i]
            if _hit.collider.gameObject.layer ~= gs.LayerMask.NameToLayer("AirWall") and _hit.collider.gameObject.layer ~= gs.LayerMask.NameToLayer("Role") and _hit.collider.isTrigger == false then
                local _dis = math.abs(gs.Vector3.Distance(_hit.point, startPoint))
                if _dis < dis then
                    dis = _dis
                    hit = _hit
                end
            end
        end

        return hit ~= nil
    end

    local isblock = false
    for i = 1, 20 do
        if not Raycast() then
            break
        else
            startPoint = hit.point
            dir = gs.Vector3.Reflect(dir, hit.normal)

            table.insert(pos, startPoint)

            ---如果射线遇到了不是反射事件的碰撞体阻挡(空气墙不进行阻挡)，携带反射技能事件进行反射
            local hitTrans = hit.transform
            local colliderCall = hitTrans:GetComponent(ty.ColliderCall)
            if colliderCall == nil or gs.GoUtil.IsCompNull(colliderCall) then
                isblock = true
                break
            end

            local tag = colliderCall.SelfColliderTag
            --判断是不是事件
            if tag ~= FieldExplorationConst.ColliderTag.Event then
                isblock = true
                break
            end

            local id = colliderCall.ColliderTagID
            local eventThing = fieldExploration.FieldExplorationSceneController:getSceneEvent(id)
            if eventThing == nil then
                isblock = true
                break
            end

            --判断是不是目标事件
            if eventThing.mData.tid == self.m_targetThingId then
                local executeThing = fieldExploration.FieldExplorationSceneController:getSceneEventByTid(self.m_executeThingId)
                if not executeThing then 
                    logError("场景种不存在这个执行事件 id = " .. self.m_executeThingId)
                end

                if self.m_executeSkillId then
                    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
                        local isConfigSkill = false
                        local eventConfig = eventThing:getEventConfig()
                        for _, _skill_id in pairs(eventConfig.skill_id) do
                            if _skill_id == self.m_executeSkillId then
                                isConfigSkill = true
                                break
                            end
                        end

                        if not isConfigSkill then
                            logError("事件tid " .. eventThing.mData.tid .. "不存在技能id为" .. self.m_executeSkillId .. "的技能,请检查配置")
                            return
                        end
                    end

                    local skill = eventThing:getSkill(self.m_executeSkillId)
                    skill:onExecute(executeThing)
                else
                    executeThing:onSkillExecute()
                end

                isblock = true
                break
            end

            --判断是不是携带反射技能
            local haveReflexSkill = false
            local eventConfig = eventThing:getEventConfig()
            for _, skill_id in pairs(eventConfig.skill_id) do
                local skillConfig = fieldExploration.FieldExplorationManager:getEventSkillConfig(skill_id)
                if not skillConfig then
                    logError("这个技能找不到配置哦~  麻烦曹爷曹老板修改下 id = " .. skill_id)
                end
                if skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_LASERREFLEX then--激光发射
                    haveReflexSkill = true
                    break
                end
            end

            if not haveReflexSkill then
                isblock = true
                break
            end
        end
    end

    if not isblock then
        table.insert(pos, startPoint + dir * self.m_laserLength)
    end

    self.m_lineRenderer.positionCount = table.nums(pos)
    self.m_lineRenderer:SetPositions(pos)
end

function recover(self)
    super.recover(self)

    self.m_laserLength = nil
    self.m_shootTrans = nil
    self.m_lineRenderer = nil

    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_LASETSHOOTSKILL_CHECKRAYCAST, self.checkRaycast, self)
end

return _M
