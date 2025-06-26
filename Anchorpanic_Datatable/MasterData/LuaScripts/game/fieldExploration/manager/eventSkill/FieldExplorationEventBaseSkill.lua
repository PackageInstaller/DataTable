-- @FileName:   FieldExplorationEventBaseSkill.lua
-- @Description:   场景事件技能基类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventBaseSkill', Class.impl())

function setData(self, config, parent)
    self.config = config

    --- 判断是不是需要添加伤害范围碰撞
    if self.config.range_type ~= FieldExplorationConst.Collider_Type.None then

        self.mGo = gs.GameObject()
        self.mGo.name = "Collider_" .. self.config.type

        self.mTran = self.mGo.transform
        self.mTran:SetParent(parent, false)
        self.mTran.localPosition = gs.VEC3_ZERO

        self.mColliderCall = self.mGo:GetComponent(ty.ColliderCall)
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mGo:AddComponent(ty.ColliderCall)
        end

        if self.config.range_type == FieldExplorationConst.Collider_Type.CapsuleCollider then
            self.mColliderCall:InitCapsuleCollider(self.config.range_subtype[1] * 0.01, 1)
        elseif self.config.range_type == FieldExplorationConst.Collider_Type.BoxCollider then
            self.mColliderCall:InitBoxCollider(self.config.range_subtype[1] * 0.01, 1, self.config.range_subtype[2] * 0.01)
        elseif self.config.range_type == FieldExplorationConst.Collider_Type.SelfCollider then
            self.mColliderCall:InitSelfCollider()
        elseif self.config.range_type == FieldExplorationConst.Collider_Type.BoxCollider then
            self.mColliderCall:InitSectorCollider(self.config.range_subtype[1] * 0.01, self.config.range_subtype[2], 1)
        end

        self.mColliderCall:AddColliderTags(self:getColliderTags())
        self.mColliderCall:OpenColliderCheck()
        self.mColliderCall.SelfColliderTag = FieldExplorationConst.ColliderTag.EventSkill
        self.mColliderCall.IsTrigger = true

        self.mColliderCall.onTriggerEnterCall = function (tag, colliderTagID)
            if tag == "AirWall" then
                return
            end
            self:onTriggerEnterCall(tag, colliderTagID)
        end

        self.mColliderCall.onTriggerStayCall = function (tag, colliderTagID)
            if tag == "AirWall" then
                return
            end
            self:onTriggerStayCall(tag, colliderTagID)
        end

        self.mColliderCall.onTriggerExitCall = function (tag, colliderTagID)
            if tag == "AirWall" then
                return
            end
            self:onTriggerExitCall(tag, colliderTagID)
        end
    end
end

---执行技能
function onExecute(self, executeThing, targetThing)
    self.mExecuteThing = executeThing
    self.mTargetThing = targetThing
end

function onCancel(self, executeThing, targetThing)

end

function addBuff(self)
    self.m_buffList = {}
    if self.mTargetThing then
        if not table.empty(self.config.buff_id) then
            for _, buff_id in pairs(self.config.buff_id) do
                local buff = self.mTargetThing:addBuff(buff_id, self.mExecuteThing)
                self.m_buffList[buff.m_snId] = buff
            end
        end
    end
end

function clearBuff(self)
    if self.mTargetThing then
        if self.m_buffList then
            for snId, buff in pairs(self.m_buffList) do
                self.mTargetThing:removeBuff(snId)
            end
        end
    end
end

--提示器碰撞触发
function onTriggerEnterCall(self, tag, colliderTagID)

end

--提示器碰撞触发
function onTriggerStayCall(self, tag, colliderTagID)

end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)

end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Player}
end

function recover(self)
    if self.mColliderCall and not gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall.onTriggerEnterCall = nil
        self.mColliderCall.onTriggerExitCall = nil

        gs.GameObject.Destroy(self.mColliderCall)
        self.mColliderCall = nil
    end

    if self.mEffct then
        self.mEffct:recover()
        self.mEffct = nil
    end

    if self.mGo then
        gs.GameObject.Destroy(self.mGo)
        self.mGo = nil
        self.mTran = nil
    end
end

return _M
