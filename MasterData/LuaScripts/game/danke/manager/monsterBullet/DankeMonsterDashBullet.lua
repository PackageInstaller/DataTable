-- @FileName:   DankeMonsterDashBullet.lua
-- @Description:   怪物冲撞子弹
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterBullet.DankeMonsterDashBullet', Class.impl(danke.DankeMonsterBaseBullet))

-- 通过已有资源创建新实例
function setupPrefab(self, executeThing, data)
    local item = self:poolGet()

    item.m_snId = SnMgr:getSn()
    item.m_data = data
    item.m_executeThing = executeThing

    item:resetData()

    local go = gs.GameObject()
    item:loadFinish(go)

    return item
end

function loadFinish(self, go)
    super.loadFinish(self, go)

    local scale = self.m_data.scale
    self.m_trans.localScale = gs.Vector3(scale, scale, 1)
end

function onFrame(self)
    local execute_pos = self.m_executeThing:getPosition()
    gs.TransQuick:LPos(self.m_trans, execute_pos.x, execute_pos.y, 0)
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(self.m_data.size + 0.07, self.m_data.size + 0.07)
end

function onRecover(self)
    gs.GOPoolMgr:CancelAsyc(self.m_loadSn)
    if self.m_go and not gs.GoUtil.IsGoNull(self.m_go) then
        gs.GameObject.Destroy(self.m_go)
        self.m_go = nil
        self.m_trans = nil
    end

    self:clearData()
end

return _M
