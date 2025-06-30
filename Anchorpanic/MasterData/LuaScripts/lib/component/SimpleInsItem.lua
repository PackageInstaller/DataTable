--[[
-----------------------------------------------------
@filename       : SimpleInsItem
@Description    : 简单的资源克隆item(显示用！只做外部数据显示，不管理数据)
@date           : 2021-01-12 11:55:29
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('lib.component.SimpleInsItem', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    if self.goPoolName then
        self:recover()
    else
        self:destroy()
    end
    LuaPoolMgr:poolRecover(self)
end

-------------------------------------------------------------------
-- 通过已有资源创建新实例
-- goPoolName 资源缓存名，传入则缓存资源
function create(self, rootGo, cusParent, goPoolName)
    local item = self:poolGet()
    local go = nil
    if goPoolName then
        go = gs.GOPoolMgr:GetOther(goPoolName)
    end
    if not go or gs.GoUtil.IsGoNull(go) then
        go = gs.GameObject.Instantiate(rootGo)
    end
    item.goPoolName = goPoolName
    item.m_go = go
    item.m_trans = item.m_go.transform
    item.m_childGos, item.m_childTrans = GoUtil.GetChildHash(item.m_go)
    item.m_isDestroy = goPoolName == nil
    if cusParent then
        item:addOnParent(cusParent)
    end
    item:setActive(true)
    rootGo:SetActive(false)
    return item
end

-- 不重新创建实例，方便使用封装方法
function create2(self, rootGo, isDestroy)
    local item = self:poolGet()
    if not rootGo.activeSelf then
        rootGo:SetActive(true)
    end
    item.m_go = rootGo
    item.m_trans = item.m_go.transform
    item.m_childGos, item.m_childTrans = GoUtil.GetChildHash(item.m_go)
    if isDestroy == nil then
        isDestroy = true
    end
    item.m_isDestroy = isDestroy
    return item
end

function setArgs(self, args)
    self.m_args = args
end

function getArgs(self, args)
    return self.m_args
end

-- 设置坐标
function setPos(self, x, y)
    gs.TransQuick:UIPos(self:getTrans():GetComponent(ty.RectTransform), x or 0, y or 0)
end

-- 设置缩放
function setScale(self, scale)
    if self.m_trans then
        gs.TransQuick:Scale(self.m_trans, scale, scale, scale)
    end
end

-- 获得节点
function getTrans(self)
    return self.m_trans
end

-- 获得节点
function getGo(self)
    return self.m_go
end

-- 添加到父节点
function addOnParent(self, parentTrans)
    self.m_trans:SetParent(parentTrans, false)
end

-- 激活设置
function setActive(self, isActive)
    self.m_go:SetActive(isActive)
end

-- 获取激活状态
function getActive(self)
    return self.m_go.activeSelf
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

-- 为组件加入侦听点击事件
function addUIEvent(self, goName, callBack, soundPath, ...)
    local obj
    if not goName then
        obj = self:getGo()
    else
        obj = self:getChildGO(goName)
    end

    self:addOnClick(obj, callBack, soundPath, ...)

    self.uiEventList = self.uiEventList or {}
    table.insert(self.uiEventList, obj)
end

-- 取文本组件
function getTextCom(self, goName)
    local obj = self:getChildGO(goName)
    if not obj then error('obj is nil', 2) end

    local textCom = obj:GetComponent(ty.Text)
    if not textCom then error('btn no "Text"', 2) end

    return textCom
end

--[[
    设置文本，优先默认名Text的文本
    langId 语言包id,优先
    name 跳过语言包，直接输入文本
    ... 语言包替换参数
]]
function setText(self, goName, langId, name, ...)
    local textCom = self:getTextCom(goName)

    if langId and type(langId) ~= "number" then error('langId not a number', 2) end
    -- 语言包优先
    local str = name
    if langId and type(langId) == "number" and langId > 0 then
        str = _TT(langId, ...)
    end

    textCom.text = str
end

--[[
    设置按钮的文本，优先默认名Text的文本
    langId 语言包id,优先
    name 跳过语言包，直接输入文本
    ... 语言包替换参数
]]
function setBtnLabel(self, goName, langId, name, ...)
    local obj = self:getChildGO(goName)
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

-------------------------------------------------------------------------
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
        params = {...}
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

-- 移除所有页面组件点击侦听
function removeAllUIEvent(self)
    if self.uiEventList then
        for i = #self.uiEventList, 1, -1 do
            self:removeOnClick(self.uiEventList[i])
            table.remove(self.uiEventList, i)
        end
    end
end

-- 回收
function recover(self)
    if self.m_go then
        self:removeAllUIEvent()
        -- print(self.goPoolName, self.m_go)
        gs.GOPoolMgr:RecoverOther(self.goPoolName, self.m_go)
        self.m_go = nil
        self.m_trans = nil
        self.m_childGos = nil
        self.m_childTrans = nil
    end
end

-- 销毁
function destroy(self)
    if self.m_go then
        self:removeAllUIEvent()
        if self.m_isDestroy then
            gs.GameObject.Destroy(self.m_go)
        end

        self.m_go = nil
        self.m_trans = nil
        self.m_childGos = nil
        self.m_childTrans = nil
    end
end

return _M
