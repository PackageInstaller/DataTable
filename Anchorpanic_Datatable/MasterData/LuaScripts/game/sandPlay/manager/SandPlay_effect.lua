-- @FileName:   SandPlay_effect.lua
-- @Description:   特效效果
-- @Author: ZDH
-- @Date:   2023-09-01 14:30:25
-- @Copyright:   (LY) 2023 雷焰网络

module("sandPlay.SandPlay_effect", Class.impl())

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
function create(self, thing, path, parentTrans, lifeTime, lpos)
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
    item.m_thing = thing

    if not gs.GoUtil.IsTransNull(item.m_go.transform) then
        if parentTrans and not gs.GoUtil.IsTransNull(parentTrans) then
            gs.TransQuick:SetParentOrg01(item.m_go, parentTrans)
            gs.TransQuick:LPos(item.m_go.transform, gs.VEC3_ZERO)
        else
            gs.TransQuick:SetParentOrg01(item.m_go, nil)
        end
    end

    if lpos then
        gs.TransQuick:LPos(item.m_go.transform, lpos)
    end

    lifeTime = lifeTime or 2
    if lifeTime > 0 then
        item.m_autoRecoverSn = LoopManager:setTimeout(lifeTime, item, item.onLifeTimeRecover)
    end

    return item
end

function onLifeTimeRecover(self)
    if self.m_thing then
        self.m_thing:removeEffect(self.m_snId)
    else
        self:recover()
    end
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
