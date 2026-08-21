--[[ 
-----------------------------------------------------
@filename       : UIEffectMgr
@Description    : UI特效管理器
@date           : 2022-11-01 21:34:07
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("UIEffectMgr", Class.impl())

-- 添加UI特效 (isSort 非ui粒子，设置为true)
function addEffect(self, effectName, parentTrans, localPosX, localPosY, callFun, isSort, isRemoveBefore)
    if effectName and parentTrans and isRemoveBefore then
        self:removeEffect(effectName, parentTrans)
    end
    local effectData = { effectSn = nil, effectName = nil, effectGo = nil, parentTrans = nil }
    if(not self.mEffectList)then
        self.mEffectList = {}
    end
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo

            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            if (localPosX and localPosY) then
                gs.TransQuick:LPosXY(effectTrans, localPosX, localPosY)
            end
            effectData.effectGo:SetActive(true)

            if isSort then
                local rootCanvas = effectGo:GetComponentInParent(ty.Canvas)
                local order = rootCanvas.sortingOrder + 1

                local renderArray = gs.GoUtil.GetRendererComsInChildren(effectGo)
                local len = renderArray.Length - 1
                for i = 0, len do
                    local render = renderArray[i]
                    render.sortingOrder = render.sortingOrder + order
                end
            end

            if callFun then
                callFun(true, effectData.effectGo)
            end
        else
            if effectName and parentTrans then
                self:removeEffect(effectName, parentTrans)
            end
            if callFun then
                callFun(false, nil)
            end
        end
    end
    effectData.effectName = effectName
    effectData.parentTrans = parentTrans
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
    return effectData
end

-- 移除UI特效（如果清理所有特效不要调用该方法，请调用removeAllEffect，职责分明）
function removeEffect(self, effectName, parentTrans)
    if self.mEffectList then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if effectName == effectData.effectName and parentTrans == effectData.parentTrans then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                    return true
                end
            end
        end
        if (effectName == nil) then
            self.mEffectList = {}
            return true
        end
    else
        self.mEffectList = {}
    end
    return false
end

-- 移除UI特效
function removeEffectByVo(self, effectVo)
    if(effectVo)then
        if self.mEffectList then
            for i = #self.mEffectList, 1, -1 do
                local effectData = self.mEffectList[i]
                if (effectData and effectVo == effectData and effectVo.effectName == effectData.effectName and effectVo.parentTrans == effectData.parentTrans) then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                    return true
                end
            end
        else
            self.mEffectList = {}
            return true
        end
    end
    return false
end

function removeAllEffect(self)
    if (self.mEffectList) then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if (effectData) then
                gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                    effectData.effectGo:SetActive(false)
                    gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                end
            end
            table.remove(self.mEffectList, i)
        end
    else
        self.mEffectList = {}
    end
end

return _M