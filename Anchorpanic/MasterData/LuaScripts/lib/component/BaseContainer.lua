--[[ 
-----------------------------------------------------
@filename       : BaseContainer
@Description    : 基础页面容器
@date           : 很久以前
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('lib.component.BaseContainer', Class.impl('lib.event.EventDispatcher'))

-- UI预制体名
UIRes = nil
-- 是否异步
IsAsyn = nil
-- 是否适应全面屏
isAdapta = 0
-- ui资源加载完毕
EVENT_LOAD_FINISH = 'EVENT_LOAD_FINISH'


--构造函数
function ctor(self)
    super.ctor(self)
    self.m_sn = SnMgr:getSn()
    self.m_uicode = 0
    self:initData()
    self:loadAsset()
end

-- 设置界面的所属ui code
function setUICode(self, uicode)
    self.m_uicode = uicode
    self.m_uiCodeData = link.LinkManager:getLinkData(uicode)
end
-- 获取界面配置所属ui code
function getUICode(self)
    return self.m_uicode
end

--析构函数
function dtor(self)
end

-- 初始化数据
function initData(self)
end

function loadAsset(self)
    if (self.UIRes ~= nil and self.UIRes ~= '') then
        if (self.IsAsyn == nil or self.IsAsyn == false) then
            AssetLoader.PreLoad(self.UIRes, self.onLoadAssetComplete, self)
        else
            AssetLoader.PreLoadAsyn(self.UIRes, self.onLoadAssetComplete, self)
        end
    else
        self:configUI()
        self:__active()
        self:dispatchEvent(EVENT_LOAD_FINISH)
    end
end

function isLoadFinish(self)
    if (self.UIObject and not gs.GoUtil.IsGoNull(self.UIObject)) then
        return true
    end
    return false
end

function onLoadAssetComplete(self)
    -- 实例化是一个克隆对象，并不是加载的那个prefab，需要重新取
    self.UIObject = AssetLoader.GetGO(self.UIRes, self)
    self.UITrans = self.UIObject.transform
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)

    self:configUI()
    self:dispatchEvent(EVENT_LOAD_FINISH)
    self:addOnParent()
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = systemSetting.SystemSettingManager:getNotchH()
    if notchHeight ~= nil then
        local minV = self:getAdaptaTrans().offsetMin;
        minV.x = notchHeight;
        self:getAdaptaTrans().offsetMin = minV;

        local maxV = self:getAdaptaTrans().offsetMax;
        maxV.x = -notchHeight;
        self:getAdaptaTrans().offsetMax = maxV;
    end
end

-- 刘海适配缩放节点
function getAdaptaTrans(self)
    return self.UITrans
end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self, cusSiblingIndex)
    local parentTrans = self:getParentTrans()
    if parentTrans then
        self.UITrans:SetParent(parentTrans, false)
        if cusSiblingIndex then
            self.UITrans:SetSiblingIndex(cusSiblingIndex)
        end
        if self.isAdapta == 1 then
            GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
            self:setAdapta()
        end
        self:__active()

    end
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

-- 读取页面对应的音乐id
function getMusicId(self)
    return self.m_uiCodeData.musicID
end


--初始化UI
function configUI(self)

end

-- 内部激活，请勿使用
function __active(self, args)
    guide.GuideUITransHandler:active(self.m_sn)
    self:active(args)
    self:regGuide()

    if self.m_uiCodeData then
        if self:getMusicId() > 0 then
            AudioManager:playMusicById(self:getMusicId())
        end
    end
end

-- 注册引导
function regGuide(self)
    guide.GuideCondition:condition15(self.__cname)

    if self.isReshow then 
        guide.GuideCondition:condition26(self.__cname)
    end
end

-- 内部非激活，请勿使用
function __deActive(self)
    self:removeAllTimer()
    self:clearAllTimeout()
    self:removeEffect()
    guide.GuideUITransHandler:deActive(self.m_sn)
    self:deActive()
    GameDispatcher:removeAllEvent(self)
    GameDispatcher:removeEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)

    --guide.GuideCondition:condition22(self.__cname)
end

--激活
function active(self)

end
--非激活
function deActive(self)

end

function setActive(self, isActive)
    self.UIObject:SetActive(isActive)
end

function getActive(self, isActive)
    return self.UIObject.activeSelf
end

-- 添加到父节点
-- cusParentTrans 父节点
-- cusSiblingIndex 添加显示层级
function setParentTrans(self, cusParentTrans, cusSiblingIndex)
    self.m_parentTrans = cusParentTrans

    self:addOnParent(cusSiblingIndex)
end

-- 取父容器
function getParentTrans(self)
    return self.m_parentTrans
end

-- 设置位置
function setPosition(self, cusX, cusY, cusZ)
    cusX = cusX or 0
    cusY = cusY or 0
    cusZ = cusZ or 0
    if self.UITrans then
        gs.TransQuick:UIPos(self.UITrans, cusX, cusY)
    end
end

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    -- if not obj:GetComponent(ty.Button) then
    --     error('btn is nil', 2)
    -- end
    if obj == "" then
        obj = self.UIObject
    end

    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if soundPath == "" then
            -- 不播音效
        elseif (soundPath == nil) then
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
    -- if not obj:GetComponent(ty.Button) then
    --     error('btn is nil', 2)
    -- end
    gs.UIComponentProxy.RemoveListener(obj)
end

-- 延迟执行回调处理避免自动回收导致id残余
function __timeoutCall(self, idxSn)
    local data = self.m_timeoutData[idxSn]
    if data then
        data.callback(self, data.callBackParams)
        self:clearTimeout(data.id)
        self.m_timeoutData[idxSn] = nil
        SnMgr:disposeSn(idxSn)
    end
end
-- 添加一个延时执行
function setTimeout(self, cusDelay, callback, cusCallBackParams)
    local idxSn = SnMgr:getSn()
    self.m_timeoutData = self.m_timeoutData or {}
    local id = LoopManager:setTimeout(cusDelay, self, self.__timeoutCall, idxSn)
    self.m_timeoutData[idxSn] = { id = id, delay = cusDelay, callback = callback, callBackParams = cusCallBackParams }
    return id
end
-- 清除一个延时执行
function clearTimeout(self, id)
    if self.m_timeoutData then
        for k, v in pairs(self.m_timeoutData) do
            if v.id == id then
                LoopManager:clearTimeout(v.id)
                self.m_timeoutData[k] = nil
                break
            end
        end
    end
end
-- 移除所有延时执行
function clearAllTimeout(self)
    if self.m_timeoutData then
        for k, data in pairs(self.m_timeoutData) do
            LoopManager:clearTimeout(data.id)
            self.m_timeoutData[k] = nil
        end
    end
    self.m_timeoutData = {}
end
-- 添加一个定时器
function addTimer(self, cusDelay, cusRepeat, callback, cusOverBack, cusOverBackParams)
    self:removeTimer(callback)
    self.m_timeList = self.m_timeList or {}
    local id = LoopManager:addTimer(cusDelay, cusRepeat, self, callback, cusOverBack, cusOverBackParams)
    table.insert(self.m_timeList, { id = id, delay = cusDelay, isRepeat = cusRepeat, callback = callback, overBack = cusOverBack, overBackParams = cusOverBackParams })
    return id
end
-- 移除一个定时器（通过流水号）
function removeTimerByIndex(self, id)
    if self.m_timeList then
        for i, v in ipairs(self.m_timeList) do
            if v.id == id then
                LoopManager:removeTimerByIndex(v.id)
                table.remove(self.m_timeList, i)
                break
            end
        end
    end
end
-- 移除一个定时器(通过方法)
function removeTimer(self, cusCallBack)
    if self.m_timeList then
        for i, v in ipairs(self.m_timeList) do
            if v.callback == cusCallBack then
                LoopManager:removeTimer(self, v.callback)
                table.remove(self.m_timeList, i)
                break
            end
        end
    end
end
-- 移除所有定时器
function removeAllTimer(self)
    if self.m_timeList then
        for i = #self.m_timeList, 1, -1 do
            local data = self.m_timeList[i]
            LoopManager:removeTimerByIndex(data.id)
            table.remove(self.m_timeList, i)
        end
    end
end

--[[ 
    设置按钮的文本，优先默认名Text的文本
    langId 语言包id,优先
    name 跳过语言包，直接输入文本
    ... 语言包替换参数
]]
function setBtnLabel(self, obj, langId, name, ...)
    if not obj then error('obj is nil', 2) end
    if not obj:GetComponent(ty.Button) then error('obj not a Button', 2) end

    local btnLabCom
    local btnLab = obj.transform:Find("Text")
    if btnLab then
        btnLabCom = btnLab:GetComponent(ty.Text)
    else
        local btnLabComs = obj:GetComponentsInChildren(ty.Text)
        if btnLabComs then
            btnLabCom = btnLabComs[0]
        end
    end

    if not btnLabCom then error('btn no "Text"', 2) end

    if langId and type(langId) ~= "number" then error('langId not a number', 2) end
    -- 语言包优先
    local str = name
    if langId and type(langId) == "number" and langId > 0 then
        str = _TT(langId, ...)
    end

    btnLabCom.text = str
end

-- 移除
function destroy(self, isAuto)
    if self.m_sn == nil then
        logError("[" .. tostring(self.UIRes) .. "]  ctor/__active/__deActive/ 基类重写时, 请补回父类的调用")
    else
        self:clearGuideTrans()
        SnMgr:disposeSn(self.m_sn)
        self.m_sn = nil
    end

    if (self.UIRes ~= nil and self.UIRes ~= '') then
        AssetLoader.ReleaseAsset(self.UIRes)
    end
    GameDispatcher:removeEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
    gs.GameObject.Destroy(self.UIObject)
    self.UIObject = nil
    self.UITrans = nil

    self.m_childGos = nil
    self.m_childTrans = nil

    self:removeAllTimer()
    self:clearAllTimeout()

    if isAuto == nil then
        self:__deActive()
    end
end

function setGuideTrans(self, ctrlname, ctrlTrans)
    if not ctrlTrans then
        if ctrlname then
            logError(ctrlname .. " 对应的Trans不存在 ")
        else
            logError("传入参数异常")
        end
    end
    guide.GuideUITransHandler:addTrans(self.m_sn, ctrlname, ctrlTrans)
end

function clearGuideTrans(self)
    guide.GuideUITransHandler:clearTrans(self.m_sn)
end

function getCloseSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_basic_close.prefab")
end

-- 添加界面UI特效 (isSort 非ui粒子，设置为true)
function addEffect(self, effectName, parentTrans, localPosX, localPosY, callFun, isSort)
    if (effectName) then
        self:removeEffect(effectName)
    end
    local effectData = { effectSn = nil, effectName = nil, effectGo = nil }
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)

            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            if (localPosX and localPosY) then
                gs.TransQuick:LPosXY(effectTrans, localPosX, localPosY)
            end

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

            if (callFun) then
                callFun(true, effectData.effectGo)
            end
        else
            if (effectName) then
                self:removeEffect(effectName)
            end
            if (callFun) then
                callFun(false, nil)
            end
        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
end

-- 移除界面UI特效
function removeEffect(self, effectName)
    if (self.mEffectList) then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if (effectName == nil or effectName == effectData.effectName) then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                    if (effectName ~= nil) then
                        return true
                    end
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

return _M