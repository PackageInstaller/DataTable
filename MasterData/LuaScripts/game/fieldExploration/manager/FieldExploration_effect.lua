-- @FileName:   FieldExploration_effect.lua
-- @Description:   特效效果
-- @Author: ZDH
-- @Date:   2023-09-01 14:30:25
-- @Copyright:   (LY) 2023 雷焰网络

module("fieldExploration.FieldExploration_effect", Class.impl())

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
    self.m_finishCall = nil
end

-- 通过已有资源创建新实例
function create(self, path, parentTrans, wpos, finishCall)
    local item = self:poolGet()
    item:resetData()

    item.m_snId = SnMgr:getSn()
    item.m_go = gs.GOPoolMgr:Get(path, false)
    if item.m_go == nil or gs.GoUtil.IsGoNull(item.m_go) then
        LuaPoolMgr:poolRecover(item)
        gs.GOPoolMgr:Recover(item.m_go, path)

        if item.m_finishCall then item.m_finishCall() end
        logAll("特效不存在" .. path)
        return
    end

    item.m_go:SetActive(true)
    item.m_path = path

    if parentTrans and not gs.GoUtil.IsTransNull(parentTrans) and not gs.GoUtil.IsTransNull(item.m_go.transform) then
        wpos = wpos or gs.VEC3_ZERO
        gs.TransQuick:SetParentOrg01(item.m_go, parentTrans)
        gs.TransQuick:LPos(item.m_go.transform, wpos)
    end
    return item
end

-- 回收
function recover(self)
    gs.GOPoolMgr:Recover(self.m_go, self.m_path)
    -- self.m_go:SetActive(false)
    LuaPoolMgr:poolRecover(self)
end
return _M
