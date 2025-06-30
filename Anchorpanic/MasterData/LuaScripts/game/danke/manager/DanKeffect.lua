-- @FileName:   DanKeffect.lua
-- @Description:   特效效果
-- @Author: ZDH
-- @Date:   2023-09-01 14:30:25
-- @Copyright:   (LY) 2023 雷焰网络

module("game.danke.util.DanKeffect", Class.impl())

function ctor(self)
    self:resetData()
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function resetData(self)
    self.m_snId = nil
    self.m_go = nil
    self.m_path = nil
end

-- 通过已有资源创建新实例
function create(self, path, parentTrans, wpos)
    local item = self:poolGet()
    item:resetData()

    item.m_snId = SnMgr:getSn()
    item.m_go = gs.GOPoolMgr:Get(path, false)
    if item.m_go == nil or gs.GoUtil.IsGoNull(item.m_go) then
        LuaPoolMgr:poolRecover(item)
        gs.GOPoolMgr:Recover(item.m_go, path)

        logAll("特效不存在" .. path)
        return
    end

    item.m_go:SetActive(true)
    item.m_path = path
    item.m_time = time

    if parentTrans and not gs.GoUtil.IsTransNull(parentTrans) and not gs.GoUtil.IsTransNull(item.m_go.transform) then
        wpos = wpos or gs.VEC3_ZERO
        gs.TransQuick:SetParentOrg01(item.m_go, parentTrans)
        gs.TransQuick:LPos(item.m_go.transform, wpos)
    end
    -- local time = SandPlayConst.getParticleSystemLength(item.m_go.transform)
    -- item.m_isLoop = time > 0

    -- if not item.m_isLoop then
    item.m_autoRecoverSn = LoopManager:setTimeout(2, item, item.poolRecover)
    -- end

    return item
end

--内部调用回收
function poolRecover(self)
    danke.DanKeSceneController:removeEffect(self.m_snId)
end
-- 回收
function recover(self)
    if self.m_autoRecoverSn then
        LoopManager:clearTimeout(self.m_autoRecoverSn)
        self.m_autoRecoverSn = nil
    end

    gs.GOPoolMgr:Recover(self.m_go, self.m_path)
    -- self.m_go:SetActive(false)
    LuaPoolMgr:poolRecover(self)
end
return _M
