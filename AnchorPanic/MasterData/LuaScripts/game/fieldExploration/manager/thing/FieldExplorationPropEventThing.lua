-- @FileName:   FieldExplorationPropEventThing.lua
-- @Description:   通用道具类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationPropEventThing', Class.impl(fieldExploration.FieldExplorationBaseThing))

function resetData(self)
    super.resetData(self)

    self.mTimeOutSnList = {}

    self.mSkillDic = {}
    self.isOnExecute = false
    self.isDisable = false
end

function createModel(self)
    self:setupModel()
end

--重构函数
function setupModel(self)
    if self.mModel then
        return
    end

    local prefabPath = self:getPrefabPath()
    if string.NullOrEmpty(prefabPath) then
        return
    end

    self.mModel = self:getModel()

    self.mModel.m_rootGo.layer = gs.LayerMask.NameToLayer("Event")
    self.mModel:setupPrefab(prefabPath, false, function ()
        self:onModelLoadFinish()
        if self.mLoadFinishCall then
            self.mLoadFinishCall(self)
        end
    end)
end

function onModelLoadFinish(self)
    self:setPosition(self.mData.createPos)
    self:setAngle(self.mData.angle, true)
    if self.mData.scale then
        self:setScale(self.mData.scale)
    end

    local eventConfig = self:getEventConfig()
    if eventConfig.interact_type ~= FieldExplorationConst.Collider_Type.None then
        self:addCollider()
    end

    --检测有不有需要默认执行的技能
    if not table.empty(eventConfig.skill_id) then
        for _, skill_id in pairs(eventConfig.skill_id) do
            local skillConfig = fieldExploration.FieldExplorationManager:getEventSkillConfig(skill_id)
            if not skillConfig then
                logError("这个技能找不到配置哦~  麻烦曹爷曹老板修改下 id = " .. skill_id)
            end

            if skillConfig.type == FieldExplorationConst.EVENTSKILLTYPE_INITSHOW then--显隐
                local skill = fieldExploration.FieldExplorationEventInitShowSkill.new()
                skill:onExecute(self, fieldExploration.FieldExplorationSceneController:getPlayerThing())
                skill:recover()
                skill = nil
            end
        end
    end

    if eventConfig.trigger_type == FieldExplorationConst.EVENT_TRIGGER_TYPE.AUTO then
        if eventConfig.delay_time ~= 0 then
            self:setTimeOut(eventConfig.delay_time, self.onSkillExecute)
        else
            self:onSkillExecute()
        end
    end

    if self.mModel:haveClipWithHash(FieldExplorationConst.ACT_GOIN) then
        self:addEffect(eventConfig.goin_effct)
        self:addSoundEffct(eventConfig.goin_sound)
        self:playAction(FieldExplorationConst.ACT_GOIN)
        self:getAniLenght(FieldExplorationConst.NAME_GOIN, function (time)
            self:setTimeOut(time, function (thing)
                thing:playAction(FieldExplorationConst.ACT_STAND)

                thing:addEffect(eventConfig.stand_effct)
                thing:addSoundEffct(eventConfig.stand_sound)
            end)
        end)
    else
        self:playAction(FieldExplorationConst.ACT_STAND)

        self:addEffect(eventConfig.stand_effct)
        self:addSoundEffct(eventConfig.stand_sound)
    end

    self:move()
end

function getColliderCall(self)
    return self.mColliderCall
end

function addCollider(self)
    local eventConfig = self:getEventConfig()

    --仅仅只是为了做障碍物阻挡而已
    if not eventConfig.is_cross then
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mModel.m_rootGo:AddComponent(ty.ColliderCall)

            self.mColliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.Event
            self.mColliderCall.ColliderTagID = self.mData.id
            if eventConfig.interact_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
                self.mColliderCall:InitCapsuleCollider(eventConfig.interact_range[1] * 0.01, eventConfig.interact_range[2] * 0.01)
                self.mModel.m_rootGo:GetComponent(ty.CapsuleCollider).center = eventConfig.interact_center

            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
                self.mColliderCall:InitBoxCollider(eventConfig.interact_range[1] * 0.01, self:getColliderHeight(), eventConfig.interact_range[2] * 0.01)
                self.mModel.m_rootGo:GetComponent(ty.BoxCollider).center = eventConfig.interact_center

            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SelfCollider then
                self.mColliderCall:InitSelfCollider()
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SectorCollider then
                self.mColliderCall:InitSectorCollider(eventConfig.interact_range[1] * 0.01, self:getColliderHeight(), eventConfig.interact_range[2])
            end

            self.mColliderCall.IsTrigger = false
        end
    end

    --触发碰撞
    if eventConfig.trigger_type == FieldExplorationConst.EVENT_TRIGGER_TYPE.HAND then
        if not self.mColliderGo or gs.GoUtil.IsGoNull(self.mColliderGo) then
            self.mColliderGo = gs.GameObject()
            self.mColliderGo.name = "collider_Go"
            gs.TransQuick:SetParentOrg(self.mColliderGo.transform, self.mModel.m_trans)

            local colliderCall = self.mColliderGo:AddComponent(ty.ColliderCall)

            if eventConfig.interact_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
                colliderCall:InitCapsuleCollider((eventConfig.interact_range[1] + 20) * 0.01, eventConfig.interact_range[2] * 0.01)
                self.mColliderGo:GetComponent(ty.CapsuleCollider).center = eventConfig.interact_center
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
                colliderCall:InitBoxCollider((eventConfig.interact_range[1] + 20) * 0.01, self:getColliderHeight() + 0.2, (eventConfig.interact_range[2] + 20) * 0.01)
                self.mColliderGo:GetComponent(ty.BoxCollider).center = eventConfig.interact_center
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SelfCollider then
                colliderCall:InitSelfCollider()
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SectorCollider then
                colliderCall:InitSectorCollider((eventConfig.interact_range[1] + 20) * 0.01, self:getColliderHeight() + 0.2, eventConfig.interact_range[2] + 0.01)
            end

            colliderCall.IsTrigger = true

            colliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.Event
            colliderCall.ColliderTagID = self.mData.id
            colliderCall:AddColliderTags(self:getColliderTags())

            colliderCall.onTriggerEnterCall = function (tag, tagId)
                if tag == "AirWall" then
                    return
                end
                self:onColliderEnter(tag, tagId)
            end

            colliderCall.onTriggerExitCall = function (tag, tagId)
                if tag == "AirWall" then
                    return
                end
                self:onCollisionExit(tag, tagId)
            end

            colliderCall:OpenColliderCheck()
        end
    end
end

function enabledCollider(self, value)
    -- local colliders = self.mModel.m_rootGo:GetComponents(ty.Collider)
    -- local colliders = self.mModel.m_rootGo:GetComponents(ty.CapsuleCollider)
    -- if colliders.Length <= 0 then
    --     return
    -- end

    -- for i = 0, colliders.Length - 1 do
    --     colliders[i].enabled = value
    -- end

    if value then
        self:addCollider()
    else
        self:recoverColliderGo()
    end
end

function recoverColliderGo(self)
    if self.mColliderGo and not gs.GoUtil.IsGoNull(self.mColliderGo) then
        gs.GameObject.Destroy(self.mColliderGo)
        self.mColliderGo = nil
    end

    if self.mColliderCall and not gs.GoUtil.IsCompNull(self.mColliderCall) then
        gs.GameObject.Destroy(self.mColliderCall)
        self.mColliderCall = nil
    end

    if self.mModel then
        local CapsuleCollider = self.mModel.m_rootGo:GetComponent(ty.CapsuleCollider)
        gs.GameObject.Destroy(CapsuleCollider)
    end
end

function getColliderHeight(self)
    local eventConfig = self:getEventConfig()
    if eventConfig.interact_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
        return eventConfig.interact_range[2] * 0.01

    elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
        if not eventConfig.interact_range[3] then
            return 1
        end
        return eventConfig.interact_range[3] * 0.01

    elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SelfCollider then
        return 1
    elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SectorCollider then
        if not eventConfig.interact_range[3] then
            return 1
        end
        return eventConfig.interact_range[3] * 0.01
    end
end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Player}
end

--移动
function move(self)
    local eventConfig = self:getEventConfig()
    local posList = eventConfig.movePos
    if table.empty(posList) then
        return
    end

    self:killMoveTween()
    self.m_sequence = gs.DT.DOTween.Sequence()
    for i = 1, #posList do
        local tweener = self.mModel.m_trans:DOMove(gs.Vector3(posList[i].x, posList[i].y, posList[i].z), posList[i].time)
        self.m_sequence:Append(tweener)
    end
    self.m_sequence:SetLoops(-1, gs.DT.LoopType.Yoyo)
    self.m_sequence:Play()
end

function killMoveTween(self)
    if self.m_sequence then
        self.m_sequence:Kill()
        self.m_sequence = nil
    end
end

function getSkill(self, skill_id)
    local skill = self.mSkillDic[skill_id]
    if not skill then
        skill = FieldExplorationConst.GetSkill(skill_id, self.mModel.m_trans)
        self.mSkillDic[skill_id] = skill
    end

    return skill
end

function getAllSkill(self)
    return self.mSkillDic
end

--触发(触发方式：计时器定时自动触发、触发器碰撞触发、玩家技能触发)
function onSkillExecute(self)
    if self.isDisable then return end
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
    end

    if eventConfig.repeat_type ~= FieldExplorationConst.EVENT_REPEAT_TYPE.REPEAT then
        self.isDisable = true
    end
end

--技能取消
function onSkillCancel(self)
    if not self.isOnExecute then return end

    local eventConfig = self:getEventConfig()
    if eventConfig then
        if not table.empty(eventConfig.skill_id) then
            local playerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
            for _, skill_id in pairs(eventConfig.skill_id) do
                local skill = self:getSkill(skill_id)
                skill:onCancel(self, playerTing)
            end
        end
    end

    self.isOnExecute = false
end

--碰撞触发 手动触发才会碰撞
function onColliderEnter(self, tag, colliderTagID)
    local eventConfig = self:getEventConfig()

    if eventConfig.delay_time == 0 then
        self:onSkillExecute()
    else
        self:setTimeOut(eventConfig.delay_time, self.onSkillExecute)
    end
end

--提示器碰撞退出
function onCollisionExit(self, tag, colliderTagID)
    self:onSkillCancel()
end

function playAction(self, aniHash)
    if not self.mModel then
        return
    end

    self.mModel:playAction(aniHash)
end

function getAniLenght(self, aniName, callback)
    if self.mModel then
        self.mModel:getAniLenght(aniName, callback)
    end
end

function getModel(self)
    return fieldExploration.FieldExplorationEventModel.new()
end

function getPrefabPath(self)
    local eventConfig = self:getEventConfig()
    if not eventConfig then
        return ""
    end

    ---策划陈剑的需求，毫无意义的操作。只是为了方便自身的操作 （2024.7.30）
    local baseData = RefMgr:getData("mothodplay_res")
    if not baseData[eventConfig.prefab_name] then
        logError(eventConfig.prefab_name .. " 不存在mothodplay_res 表里，请找尊贵的土著陈剑大人~")
    end
    return baseData[eventConfig.prefab_name].prefab_name

    -- return eventConfig.prefab_name
end

function getEventConfig(self)
    local eventConfig = fieldExploration.FieldExplorationManager:getEventConfigVo(self.mData.tid)

    if not eventConfig then
        logError("荒野行动事件配置不存在 .. evenId" .. self.mData.tid)
    end

    return eventConfig
end

function setTimeOut(self, time, funcall)
    self.deltaTime = 0
    local timeOutSn = nil
    timeOutSn = LoopManager:addFrame(1, -1, self, function (thing, deltaTime)
        thing.deltaTime = thing.deltaTime + LoopManager:getDeltaTime()
        if thing.deltaTime >= time then
            if funcall then
                funcall(thing)
            end

            self:clearTimeOutSn(timeOutSn)
        end
    end)

    self.mTimeOutSnList[timeOutSn] = timeOutSn
end

function clearTimeOutSn(self, sn)
    LoopManager:removeFrameByIndex(sn)

    if self.mTimeOutSnList and self.mTimeOutSnList[sn] then
        self.mTimeOutSnList[sn] = nil

    end
end

function clearAllTimeOutSn(self)
    for _, sn in pairs(self.mTimeOutSnList) do
        self:clearTimeOutSn(sn)
    end

    self.mTimeOutSnList = nil
end

function recover(self)
    super.recover(self)

    self:clearAllTimeOutSn()
    self:killMoveTween()

    if not table.empty(self.mSkillDic) then
        for skill_id, skill in pairs(self.mSkillDic) do
            skill:recover()
        end
        self.mSkillDic = nil
    end

    self:recoverColliderGo()

    self.isDisable = false
    self.isOnExecute = false
end

return _M
