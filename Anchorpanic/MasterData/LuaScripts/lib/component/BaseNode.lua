module('lib.component.BaseNode', Class.impl())

--构造函数
function ctor(self)
    self.m_sn = SnMgr:getSn()
end

function setup(self, prefabname)
    if self.m_go then 
        return;
    end

    self.m_prefabName = prefabname
    local rootGo = gs.GOPoolMgr:Get(self.m_prefabName)
    self:initData(rootGo)
end
-- 初始化数据
function initData(self, rootGo)
    self.m_go = rootGo
    self.m_trans = rootGo.transform
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_go)
    guide.GuideUITransHandler:active(self.m_sn)
end

function onAwake(self)
	if self.m_prefabName==nil then
		return
    end
    guide.GuideUITransHandler:active(self.m_sn)
    self:initData(gs.GOPoolMgr:Get(self.m_prefabName))
end
function onRecover(self)
    guide.GuideUITransHandler:deActive(self.m_sn)
    if self.m_go then
        if self.m_prefabName then
            gs.GOPoolMgr:Recover(self.m_go, self.m_prefabName)
        else
            gs.GameObject.Destroy(self.m_go)
        end
        self.m_go = nil
    end
end

function setScale( self, scale )
    if self.m_trans then
        gs.TransQuick:Scale(self.m_trans, scale,scale,scale)
    end
end

function getTrans(self)
    return self.m_trans
end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self,parentTrans)
    self.m_trans:SetParent(parentTrans, false)
end

-- 获取子物品的gameObject
function getChildGO(self, name)
    if not name then
        error('name is nil', 2)
    end
    if self.m_childGos then
        return self.m_childGos[name]
    end
    return nil
end

-- 获取子物品的transform
function getChildTrans(self, name)
    if not name then
        error('name is nil', 2)
    end
    if self.m_childTrans then
        return self.m_childTrans[name]
    end
    return nil
end

function setVisibleByScale(self, visible)
    if visible then 
        self:setScale(1)
    else 
        self:setScale(0)
    end 
end

function setActive(self, isActive)
    if isActive then
        guide.GuideUITransHandler:active(self.m_sn)
    else
        guide.GuideUITransHandler:deActive(self.m_sn)
    end
    self.m_go:SetActive(isActive)
end

function getActive(self)
    return self.m_go.activeSelf
end

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    if not obj:GetComponent(ty.Button) then
        error('btn is nil', 2)
    end
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if(soundPath == nil)then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
        else
            AudioManager:playSoundEffect(soundPath)
        end
        if params then
            callBack(self, unpack(params))
        else
            callBack(self)
        end
    end
    gs.UIComponentProxy.AddListener(obj, func)
end
-- 为组件移除侦听点击事件
function removeOnClick(self, obj)
    gs.UIComponentProxy.RemoveListener(obj)
end

function removeSelf(self)
    self:removeEffect()
    self:clearGuideTrans()
    SnMgr:disposeSn(self.m_sn)
    self.m_sn = nil
    self.m_go = nil
    self.m_trans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
end

-- 移除
function destroy(self)
    if self.m_go then
        gs.GameObject.Destroy(self.m_go)
    end
    self:removeSelf()
end

function setGuideTrans(self, ctrlname, ctrlTrans)
    guide.GuideUITransHandler:addTrans(self.m_sn, ctrlname, ctrlTrans)
end

function clearGuideTrans(self)
    guide.GuideUITransHandler:clearTrans(self.m_sn)
end


function addEffect(self, effectName, parentTrans, localPosX, localPosY, callFun)
    if(effectName)then
        self:removeEffect(effectName)
    end
    local effectData = {effectSn = nil, effectName = nil, effectGo = nil}
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if(effectGo)then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)
            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            if(localPosX and localPosY)then
                gs.TransQuick:LPosXY(effectTrans, localPosX, localPosY)
            end
            if(callFun)then
                callFun(true, effectData.effectGo)
            end
        else
            if(effectName)then
                self:removeEffect(effectName)
            end
            if(callFun)then
                callFun(false, nil)
            end
        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
end

function removeEffect(self, effectName)
    if(self.mEffectList)then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if(effectName == nil or effectName == effectData.effectName)then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if(effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo))then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                    if(effectName ~= nil)then
                        return true
                    end
                end
            end
        end
        if(effectName == nil)then
            self.mEffectList = {}
            return true
        end
    else
        self.mEffectList = {}
    end
    return false
end

return _M