-- @FileName:   FieldExplorationColliderUtil.lua
-- @Description:   碰撞管理类
-- @Author: ZDH
-- @Date:   2023-09-07 17:15:26
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationColliderUtil', Class.impl())

function setupData(self, parentTrans, collider_type, collider_size, colliderTagID, collider_tag, collider_tagList)
    self.m_ColliderGo = gs.GameObject()
    self.m_ColliderGo.name = "collider_Go"
    gs.TransQuick:SetParentOrg(self.m_ColliderGo.transform, parentTrans)

    self.mColliderCall = self.m_ColliderGo:AddComponent(ty.ColliderCall)

    if collider_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
        self.mColliderCall:InitCapsuleCollider(collider_size.range, collider_size.height)
    elseif collider_type == FieldExplorationConst.Collider_Type.BoxCollider then
        self.mColliderCall:InitBoxCollider(collider_size.size_x, collider_size.size_y, collider_size.size_z)
    elseif collider_type == FieldExplorationConst.Collider_Type.SelfCollider then
        self.mColliderCall:InitSelfCollider()
    elseif collider_type == FieldExplorationConst.Collider_Type.BoxCollider then
        self.mColliderCall:InitSectorCollider(collider_size.radius, collider_size.angle, collider_size.height)
    end

    self.mColliderCall.IsTrigger = true

    self.mColliderCall.SelfColliderTag = collider_tag
    self.mColliderCall.ColliderTagID = colliderTagID

    self.mColliderCall:AddColliderTags(collider_tagList)

    self.mColliderCall.onTriggerEnterCall = function (tag, tagId)

    end

    self.mColliderCall.onTriggerExitCall = function (tag, tagId)
    
    end

    self.mColliderCall:OpenColliderCheck()
end

function recover(self)
    self.mColliderCall.onTriggerEnterCall = nil
    self.mColliderCall.onTriggerExitCall = nil

    self.mColliderCall = nil

    gs.GameObject.Destroy(self.m_ColliderGo)
    self.m_ColliderGo = nil
end

return _M
