-- @FileName:   SandPlayNPCThing.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayNPCThing', Class.impl(sandPlay.SandPlayBaseThing))

function resetData(self)
    super.resetData(self)

    self.mTimeOutSnList = {}
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    if self.mData.config.base_config.collision_type ~= SandPlayConst.Collider_Type.None then
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mModel.m_rootGo:GetComponent(ty.ColliderCall)
            if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
                self.mColliderCall = self.mModel.m_rootGo:AddComponent(ty.ColliderCall)
            end

            if self.mData.config.base_config.collision_type == SandPlayConst.Collider_Type.CapsuleCollider then
                self.mColliderCall:InitCapsuleCollider(self.mData.config.base_config.collision_range[1] * 0.01, 5)
            elseif self.mData.config.base_config.collision_type == SandPlayConst.Collider_Type.BoxCollider then
                self.mColliderCall:InitBoxCollider(self.mData.config.base_config.collision_range[1] * 0.01, 5, self.mData.config.base_config.collision_range[2] * 0.01)
            elseif self.mData.config.base_config.collision_type == SandPlayConst.Collider_Type.SelfCollider then
                self.mColliderCall:InitSelfCollider()
            elseif self.mData.config.base_config.collision_type == SandPlayConst.Collider_Type.BoxCollider then
                self.mColliderCall:InitSectorCollider(self.mData.config.base_config.collision_range[1] * 0.01, 5, self.mData.config.base_config.collision_range[2] * 0.01)
            end

            self.mColliderCall.IsTrigger = self.mData.config.base_config.is_cross
        end
    end

    if not table.empty(self.mData.config.base_config.bubbleList) then
        --最大显示气泡的间隔时间
        local showBubbleTime = sysParam.SysParamManager:getValue(SysParamType.SandPlayNPCBubbleinterval)
        --停留时间
        self.mBubbleTime = sysParam.SysParamManager:getValue(SysParamType.SandPlayNPCBubbleShowTime)
        self.mBubbbleMinTime, self.mBubbbleMaxTime = showBubbleTime[1], showBubbleTime[2]
        self:showBubble()
    end

    self:createFuncRange()
end

function createFuncRange(self)
    if not table.empty(self.mData.config.base_config.event_ConfigVoList) then
        local interact_range = self.mData.config.base_config.interact_range
        if interact_range > 0 then
            self.mFuncRange = {}
            self.mFuncRange.m_go = gs.GameObject("funcRange")

            self.mFuncRange.m_trans = self.mFuncRange.m_go.transform
            gs.TransQuick:SetParentOrg(self.mFuncRange.m_trans, self.mModel.m_trans)
            self.mFuncRange.colliderCall = self.mFuncRange.m_go:AddComponent(ty.ColliderCall)

            self.mFuncRange.colliderCall:InitCapsuleCollider(interact_range, 5)
            self.mFuncRange.colliderCall.IsTrigger = true

            self.mFuncRange.colliderCall:AddColliderTags({SandPlayConst.ColliderTag.Player})
            self.mFuncRange.colliderCall:OpenColliderCheck()
            self.mFuncRange.colliderCall.onTriggerEnterCall = function (tag, id)
                if tag == "AirWall" then
                    return
                end

                if not table.empty(self.mData.config.pre_event) then
                    for _, eventInfo in pairs(self.mData.config.pre_event) do
                        local npc_id = eventInfo[1]
                        local event_id = eventInfo[2]
                        if not sandPlay.SandPlayManager:getMapEventIsPass(nil, npc_id, event_id) then
                            return
                        end
                    end
                end

                self:onTriggerEnterCall()
            end

            self.mFuncRange.colliderCall.onTriggerExitCall = function (tag, id)
                if tag == "AirWall" then
                    return
                end

                self:onTriggerExitCall()
            end
        end
    end
end

function onTriggerEnterCall(self)
    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    if playThing then
        playThing:setCurFuncNPC(self.mData.id)
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_TRIGGERENTER_NPC)
    end
end

function onTriggerExitCall(self)
    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    if playThing then
        local curFuncNPCId = playThing:getCurFuncNPC()
        if curFuncNPCId == self.mData.id then
            playThing:setCurFuncNPC(nil)
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_TRIGGEREXIT_NPC)
        end
    end
end

function getInfoData(self)
    return
    {
        id = self.mData.config.base_config.npc_id,
        follow_trans = self:getTrans(),
        offset_Y = 1.1,

        fun_name = self.mData.config.base_config.fun_name,
        name = self.mData.config.base_config.name,
        sign_path = self.mData.config.base_config:getSignPath(),
    }
end

function showBubble(self)
    local showBubbleTime = math.random(self.mBubbbleMinTime, self.mBubbbleMaxTime) + self.mBubbleTime
    self.mShowBubbleTimer = self:setTimeOut(showBubbleTime, self.onShowBubble)
end

function onShowBubble(self)
    local text = self.mData.config.base_config:getRandomBubble()
    if text then
        local data = {id = self.mData.id, text = text}
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_SHOWBUBBLE, data)

        self:showBubble()
    else
        self:clearTimeOutSn(self.mShowBubbleTimer)
        self.mShowBubbleTimer = nil
    end
end

function playAction(self, aniHash)
    if not self.mModel then
        return
    end

    self.mModel:playAction(aniHash)
end

function getPrefabPath(self)
    return self.mData.config.base_config.prefab_name
end

function setTimeOut(self, time, funcall)
    local timeOutSn = nil
    timeOutSn = LoopManager:setTimeout(time, self, function (thing)
        if funcall then
            funcall(thing)
        end

        self:clearTimeOutSn(timeOutSn)
    end)

    self.mTimeOutSnList[timeOutSn] = timeOutSn

    return timeOutSn
end

function clearTimeOutSn(self, sn)
    LoopManager:clearTimeout(sn)

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

function getModel(self)

end

function recover(self)
    super.recover(self)

    if self.mColliderCall and not gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall.onTriggerEnterCall = nil
        self.mColliderCall.onCollisionEnterCall = nil
        gs.GameObject.Destroy(self.mColliderCall)
        self.mColliderCall = nil
    end

    if self.mFuncRange and not gs.GoUtil.IsGoNull(self.mFuncRange.m_go) then
        self.mFuncRange.colliderCall.onTriggerEnterCall = nil
        self.mFuncRange.colliderCall.onCollisionEnterCall = nil

        gs.GameObject.Destroy(self.mFuncRange.m_go)
        self.mFuncRange = nil
    end

    self:clearAllTimeOutSn()

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_TRIGGEREXIT_NPC)
end

return _M
