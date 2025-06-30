-- @FileName:   DanKeBaseSpriteModel.lua
-- @Description:   蛋壳模型基类
-- @Author: ZDH
-- @Date:   2023-07-25 15:35:17
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.model.DanKeBaseSpriteModel', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

-- 回收
function recover(self)
    LuaPoolMgr:poolRecover(self)
end

function resetData(self)
    self.m_finishCall = nil
    self.m_path = nil
    self.m_parent = nil

    self.m_go = nil
    self.m_trans = nil
    self.m_animator = nil
    self.m_spriteRenderer = nil

    self.m_material = nil

    self.m_loadSn = nil
    self.m_sortIndex = 0
end

-- 通过已有资源创建新实例
function setupPrefab(self, path, parentTrans, finishCall)
    local item = self:poolGet()

    item.m_finishCall = finishCall
    item.m_path = path
    item.m_parent = parentTrans
    item.m_loadSn = gs.GOPoolMgr:GetAsyc(path, function (go, _item)
        _item:loadFinish(go)
    end, item)

    return item
end

function loadFinish(self, go)
    if go == nil or gs.GoUtil.IsGoNull(go) then
        logError(self.m_path.."资源不存在")

        gs.GOPoolMgr:Recover(go, self.m_path)
        LuaPoolMgr:poolRecover(self)
        if self.m_finishCall then self.m_finishCall(self) end
        return
    end

    self.m_go = go
    self.m_trans = go.transform

    self.m_go:SetActive(true)

    self.m_animator = self.m_go:GetComponent(ty.Animator)
    self.m_spriteRenderer = self.m_go:GetComponent(ty.SpriteRenderer)
    self.m_spriteRenderer.sortingOrder = self.m_sortIndex

    self.m_material = self.m_spriteRenderer.material

    if self.m_parent and not gs.GoUtil.IsTransNull(self.m_parent) and not gs.GoUtil.IsTransNull(self.m_trans) then
        gs.TransQuick:SetParentOrg(self.m_trans, self.m_parent)
        gs.TransQuick:LPos(self.m_trans, gs.VEC3_ZERO)
    end
    if self.m_finishCall then self.m_finishCall(self) end

    self.m_loadSn = nil
end

function setSortIndex(self, sortIndex)
    self.m_sortIndex = sortIndex

    if self.m_spriteRenderer and not gs.GoUtil.IsCompNull(self.m_spriteRenderer) then
        self.m_spriteRenderer.sortingOrder = self.m_sortIndex
    end
end

function IsPlayingShortNameHash(self, actHash)
    local info = self.m_animator:GetCurrentAnimatorStateInfo(0);
    if (info.shortNameHash == actHash) then
        return true
    end

    return false
end

function playAction(self, actName)
    if not self.m_animator or gs.GoUtil.IsCompNull(self.m_animator) then

    end

    local actHash = gs.Animator.StringToHash(actName)
    if not self:IsPlayingShortNameHash(actHash) then
        self.m_animator:Play(actName, 0, 0)
    end
end

function setHitAnim(self, toggle)
    if self.m_material then
        if toggle then
            self.m_material:EnableKeyword("_HIT_EFFECT")
        else
            self.m_material:DisableKeyword("_HIT_EFFECT")
        end
    end
end

-- 获取动作时长
function getAniLenght(self, aniName)
    if self.m_animator then
        return AnimatorUtil.getAnimatorClipTime(self.m_animator, aniName)
    end
end

function getTrans(self)
    return self.m_trans
end

function onRecover(self)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.GOPoolMgr:CancelAsyc(self.m_loadSn)
        self.m_loadSn = nil
    else
        gs.GOPoolMgr:Recover(self.m_go, self.m_path)
    end

    self:resetData()
end

return _M
