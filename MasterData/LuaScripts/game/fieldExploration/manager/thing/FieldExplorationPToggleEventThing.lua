-- @FileName:   FieldExplorationPToggleEventThing.lua
-- @Description:   压力开关事件
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationPToggleEventThing', Class.impl(fieldExploration.FieldExplorationPropEventThing))

function addCollider(self)
    local eventConfig = self:getEventConfig()

    --仅仅只是为了做障碍物阻挡而已
    if not eventConfig.is_cross then
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mModel.m_rootGo:AddComponent(ty.ColliderCall)

            self.mColliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.Event
            self.mColliderCall.ColliderTagID = self.mData.id
            if eventConfig.interact_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
                self.mColliderCall:InitCapsuleCollider(eventConfig.interact_range[1] * 0.01, self:getColliderHeight())
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
                self.mColliderCall:InitBoxCollider(eventConfig.interact_range[1] * 0.01, self:getColliderHeight(), eventConfig.interact_range[2] * 0.01)
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SelfCollider then
                self.mColliderCall:InitSelfCollider()
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
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
                colliderCall:InitCapsuleCollider((eventConfig.interact_range[1] + 20) * 0.01, self:getColliderHeight())
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
                colliderCall:InitBoxCollider((eventConfig.interact_range[1] + 20) * 0.01, self:getColliderHeight(), (eventConfig.interact_range[2] + 20) * 0.01)
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.SelfCollider then
                colliderCall:InitSelfCollider()
            elseif eventConfig.interact_type == FieldExplorationConst.Collider_Type.BoxCollider then
                colliderCall:InitSectorCollider((eventConfig.interact_range[1] + 20) * 0.01, self:getColliderHeight(), eventConfig.interact_range[2] + 0.01)
            end

            colliderCall.IsTrigger = true

            colliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.Event
            colliderCall.ColliderTagID = self.mData.id
            colliderCall:AddColliderTags(self:getColliderTags())

            colliderCall.onTriggerStayCall = function (tag, tagId)
                if tag == "AirWall" then
                    return
                end
                -- self.m_stayData = {dt = GameManager:getClientTime(), tag = tag, tagId = tagId}

                -- if not self.m_frameSn then
                --     self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onColliderStay)
                -- end


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

-- function onColliderStay(self)
--     if GameManager:getClientTime() - self.m_stayData.dt > 0.4 then
--         self:onCollisionExit(self, tag, colliderTagID)
--     else
--         self:onColliderEnter(self.m_stayData.tag, self.m_stayData.tagId)
--     end
-- end

-- function clearFrameSn(self)
--     if self.m_frameSn then
--         LoopManager:removeFrameByIndex(self.m_frameSn)
--         self.m_frameSn = nil
--     end
-- end

--碰撞停留
function onColliderEnter(self, tag, colliderTagID)
    if self.isOnExecute then
        return
    end

    super.onColliderEnter(self, tag, colliderTagID)

    self.isOnExecute = true
end

--提示器碰撞退出
function onCollisionExit(self, tag, colliderTagID)
    if not self.isOnExecute then
        return
    end

    super.onCollisionExit(self, tag, colliderTagID)

    self.isOnExecute = false
    -- self.m_stayData = nil

    -- self:clearFrameSn()
end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Player, FieldExplorationConst.ColliderTag.Event}
end

function recover(self)
    super.recover(self)

    -- self:clearFrameSn()

    self.m_stayData = nil
    self.isOnExecute = nil
end

return _M
