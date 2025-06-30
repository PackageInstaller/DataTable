-- @FileName:   DankeBullet.lua
-- @Description:   蛋壳子弹类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBullet', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

-- 回收
function recover(self)
    LuaPoolMgr:poolRecover(self)
end

function resetData(self)
    self.m_playerThing = danke.DanKeSceneController:getPlayerThing()
    self.m_deltaTime = 0
end

-- 通过已有资源创建新实例
function setupPrefab(self, data)
    local item = self:poolGet()

    item.m_snId = SnMgr:getSn()
    item.m_data = data
    item.m_path = data.path

    item:resetData()

    item.m_loadSn = gs.GOPoolMgr:GetAsyc(item.m_path, function (go, _item)
        _item:loadFinish(go)
    end, item)

    return item
end

function loadFinish(self, go)
    if go == nil or gs.GoUtil.IsGoNull(go) then
        gs.GOPoolMgr:Recover(go, self.m_path)
        logError(self.m_path .. "资源不存在")

        self:poolRecover()
        return
    end

    self.m_go = go
    self.m_trans = go.transform

    local parent = self:getParent()
    if parent and not gs.GoUtil.IsTransNull(parent) and not gs.GoUtil.IsTransNull(self.m_trans) then
        gs.TransQuick:SetParentOrg(self.m_trans, parent)
        local born_pos = self.m_data.born_pos or gs.VEC3_ZERO
        gs.TransQuick:LPos(self.m_trans, born_pos)
    end

    local localScale = self:getScale() * (1 + self.m_data.add_scale)
    self.m_trans.localScale = gs.Vector3(localScale, localScale, 1)
    self.m_ColliderCall = self.m_go:GetComponent(ty.ColliderCall)
    if not self.m_ColliderCall or gs.GoUtil.IsCompNull(self.m_ColliderCall) then
        self.m_ColliderCall = self.m_go:AddComponent(ty.ColliderCall)
        self:initCollider()

        self.m_ColliderCall.SelfColliderTag = DanKeConst.ColliderTag.Player_Bullet
        self.m_ColliderCall:AddColliderTags(self:getColliderTags())
        self.m_ColliderCall:OpenColliderCheck()
        self.m_ColliderCall.IsTrigger = true
    end

    self.m_ColliderCall.ColliderTagID = self.m_snId

    self:initColliderCall()

    self.m_go:SetActive(true)

    self:clearFrame()
    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    self.m_loadSn = nil
end

function initCollider(self)

end

function initColliderCall(self)
    self.m_ColliderCall.onTriggerEnterCall = function (tag, colliderTagID)
        local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = DanKeConst.ColliderTag.Player_Bullet, hit_tag = tag}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_ENTER, data)
    end

    self.m_ColliderCall.onTriggerExitCall = function (tag, colliderTagID)
        local data = {attack_id = self.m_snId, hit_id = colliderTagID, attack_tag = DanKeConst.ColliderTag.Player_Bullet, hit_tag = tag}
        GameDispatcher:dispatchEvent(EventName.DANKE_COLLIDER_EIXT, data)
    end
end

function getColliderTags(self)
    return {DanKeConst.ColliderTag.Normal_Monster, DanKeConst.ColliderTag.Elite_Monster}
end

--攻击
function onAttack(self, thing, collider_args, isforce)
    thing:onHit(self.m_data.damage)

    if self.m_data.params.is_pass ~= 1 then
        self:poolRecover()
    end
end

function onFrame(self)
    self.m_deltaTime = self.m_deltaTime + LoopManager:getDeltaTime()
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function getScale(self)
    return 1
end

function getParent(self)
    return danke.DanKeSceneController:getLayer(DanKeConst.LayerName.Player_bullet).node
end

function getTrans(self)
    return self.m_trans
end

function clearData(self)
    self:clearFrame()

    self.m_data = nil
    self.m_loadSn = nil
    self.m_go = nil
    self.m_trans = nil
    self.m_frameSn = nil
    self.m_path = nil

    self.m_playerThing = nil
    self.m_deltaTime = nil

    self.m_ColliderCall.onTriggerEnterCall = nil
    self.m_ColliderCall.onTriggerExitCall = nil
end

--内部调用回收
function poolRecover(self)
    danke.DanKeSceneController:recoverThing(DanKeConst.ColliderTag.Player_Bullet, self.m_snId)
end

function onRecover(self)
    gs.GOPoolMgr:CancelAsyc(self.m_loadSn)
    if self.m_go and not gs.GoUtil.IsGoNull(self.m_go) then
        gs.GOPoolMgr:Recover(self.m_go, self.m_path)
    end

    self:clearData()
end

return _M
