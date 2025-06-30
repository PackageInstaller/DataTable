module('lib.component.BaseItemRender', Class.impl())
--[[_s
@todo: 重用列表lua渲染器，使用时请继承本类
@todo: 该方法由C#类 LyScroller的子项渲染器ItemRender 调用
@param: go 列表子项GameObject
@param: param 列表子项对应处理的数据
@author: Jacob
]]
function onInit(self, go)
    self.m_sn = SnMgr:getSn()
    self.UIObject = go
    self.UITrans = go.transform
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
    self.mGroupItem = self.m_childGos["mGroupItem"]
end

-- 由MonoBehaviour Start 调用
function onStart(self)
    self:showUIAnimator()
    self:showDOTween()
end

function setData(self, param)
    guide.GuideUITransHandler:active(self.m_sn)
    self.data = param
end

function getData(self)
    return self.data
end

-- 缓动顺序
function getTweenIndex(self)
    if type(self.data) ~= "table" then
        return nil
    end
    return self.data.tweenId
end


-- 播放UI入场动效
function showUIAnimator(self)
    local anim = self.UIObject:GetComponent(ty.Animator)
    if not gs.GoUtil.IsCompNull(anim) then
        if self:getTweenIndex() then
            self:onAnimStart(self:getTweenIndex() * 0.06)
        else
            anim:SetTrigger("show")
        end
    end
end

function onAnimStart(self, time)
    local function callTween()
        if (not gs.GoUtil.IsCompNull(self.UIObject:GetComponent(ty.Animator))) then
            self.UIObject:GetComponent(ty.Animator):SetTrigger("show")
        end
    end
    self.aniTimeSn = LoopManager:setTimeout(time, self, callTween)
end

function showDOTween(self)
    local tween = self.UIObject:GetComponent(ty.UIDoTween)
    if not gs.GoUtil.IsCompNull(tween) and self:getTweenIndex() then
        if self.mGroupItem then
            self.mGroupItem:SetActive(false)
            self:onTweenStart(self:getTweenIndex() * 0.02)
        end
    end
end

function onTweenStart(self, time)
    local function callTween()
        if (not gs.GoUtil.IsCompNull(self.UIObject:GetComponent(ty.UIDoTween))) then
            if self.mGroupItem then
                self.mGroupItem:SetActive(true)
                self.UIObject:GetComponent(ty.UIDoTween):BeginTween()
            end
        end
    end
    LoopManager:clearTimeout(self.tweenTimeSn)
    self.tweenTimeSn = LoopManager:setTimeout(time, self, callTween)
end

-- override 虚拟列表被激活时自动调用
function active(self)
    self:addAllUIEvent()
end

-- override 虚拟列表被非激活时自动调用
function deActive(self)
    self:removeAllUIEvent()
    if self.mGroupItem then
        self.mGroupItem:SetActive(true)
    end
    LoopManager:clearTimeout(self.tweenTimeSn)
    LoopManager:clearTimeout(self.aniTimeSn)
    LoopManager:removeFrameByIndex(self.aniFrameSn)
    LoopManager:removeFrameByIndex(self.tweenFrameSn)

    guide.GuideUITransHandler:deActive(self.m_sn)
    -- print("BaseItemRender deActive")
end


-- 渲染器item销毁
function onDelete(self)
    self:deActive()
    self:destroy()
    -- print("BaseItemRender onDelete")
end

-- 获取子物品的gameObject
function getChildGO(self, name)
    if self.m_childGos then
        return self.m_childGos[name]
    end
    return nil
end

-- 获取子物品的transform
function getChildTrans(self, name)
    if self.m_childTrans then
        return self.m_childTrans[name]
    end
    return nil
end

-- UI事件管理
function addAllUIEvent(self)

end

-- 为组件加入侦听点击事件
function addUIEvent(self, obj, callBack, soundPath, ...)
    self:addOnClick(obj, callBack, soundPath, ...)

    self.uiEventList = self.uiEventList or {}
    table.insert(self.uiEventList, obj)
end
-- 移除所有页面组件点击侦听
function removeAllUIEvent(self)
    if self.uiEventList then
        for k, v in ipairs(self.uiEventList) do
            self:removeOnClick(v)
        end
    end
end

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if (soundPath == nil) then
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

function setGuideTrans(self, ctrlname, ctrlTrans)
    guide.GuideUITransHandler:addTrans(self.m_sn, ctrlname, ctrlTrans)
end

function clearGuideTrans(self)
    guide.GuideUITransHandler:clearTrans(self.m_sn)
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

-- 销毁
function destroy(self)
    guide.GuideUITransHandler:deActive(self.m_sn)
    -- gs.GameObject.Destroy(self.UIObject) -- 虚拟列表已创建资源缓存机制，不需要直接销毁
    self.UIObject = nil
    self.UITrans = nil
    self.tweenFrameSn = nil
    self.aniFrameSn = nil
    self.m_childGos = nil
    self.m_childTrans = nil
end

return _M