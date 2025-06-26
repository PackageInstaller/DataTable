module("TabBar", Class.impl())
StateButton2 = require 'lib/component/StateButton2'

function ctor(self)
    self:initData()
end

function initData(self)
    self.m_prefabName = UrlManager:getUIPrefabPath("compent/TabBar.prefab")
    self.m_viewportName = "Viewport"
    self.m_contentName = "Content"
    self.m_NodeLineName = "NodeLine"
    self.m_ImgCustomName = "ImgCustom"
    -- 是否可以重复点击触发
    self.m_isRepeatTrigger = false

    -- 物品相关
    self.m_tabBarGo = nil
    self.m_childGos = nil
    self.m_childTrans = nil

    -- 数据相关
    self.m_itemsDic = nil
    self.m_clickCallObj = nil
    self.m_clickCallFun = nil
    self.mCustomList = nil
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:reset()
    gs.GOPoolMgr:Recover(self.m_tabBarGo, self.m_prefabName)
    self.m_tabBarGo = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self.m_itemsDic = nil
    self.m_clickCallObj = nil
    self.m_clickCallFun = nil
    LuaPoolMgr:poolRecover(self)
end

function reset(self)
    self:__resetCustomList()
    self:__resetItemDic()
end

function __resetCustomList(self)
    if (self.mCustomList ~= nil) then
        for i = 1, #self.mCustomList do
            gs.GameObject.Destroy(self.mCustomList[i])
        end
    end
    self.mCustomList = {}
end

function __resetItemDic(self)
    if (self.m_itemsDic ~= nil) then
        for tabType, stateBtn in pairs(self.m_itemsDic) do
            stateBtn:removeBubble(tabType)
            stateBtn:setTipImg(nil, nil, nil)
            stateBtn:removeOnClick()
            stateBtn:poolRecover()
        end
    end
    self.m_itemsDic = {}
end

function __getGo(self)
    if (not self.m_tabBarGo) then
        self.m_tabBarGo = gs.GOPoolMgr:Get(self.m_prefabName)
        self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_tabBarGo)
    end
    if (self.m_tabBarGo) then
        return self.m_tabBarGo
    end
    return nil
end

function addParent(self, cusParentTrans)
    local go = self:__getGo()
    if (not go) then
        return
    end
    go.transform:SetParent(cusParentTrans, false)
    self:__initGo()
end

function __initGo(self)
    local rect = self.m_tabBarGo:GetComponent(ty.RectTransform)
    gs.TransQuick:UIPos(rect, 0, 0)
    -- gs.TransQuick:Anchor(rect, 0.5, 0.5, 0.5, 0.5)
    -- gs.TransQuick:Offset(rect, 0.5, 0.5, 0.5, 0.5)
    gs.TransQuick:Scale(rect, 1, 1, 1)
end

-- 设置切卡项集
function setItems(self, itemsData, btnType)
    self:__resetItemDic()
    local contentTrans = self.m_childTrans[self.m_contentName]
    for _, tabData in pairs(itemsData) do
        local stateBtn
        if btnType == 2 then
            stateBtn = StateButton2:poolGet()
        else
            stateBtn = StateButton:poolGet()
        end
        stateBtn:addParent(contentTrans)
        stateBtn:setData(
        nil,
        nil,
        tabData.width,
        tabData.height,
        tabData.normalSource,
        tabData.selectSource,
        tabData.content,
        tabData.fontSize,
        tabData.bold,
        tabData.type,

        tabData.fontNormalColor,
        tabData.fontSelectColor,
        tabData.fontOffsetNomal,
        tabData.fontOffsetSelect,
        tabData.fontLineSpace,
        tabData.textAlignment
        )
        stateBtn:setSelectState(false)

        local tabType = tabData.type
        local function onClickHandler()
            self:onClickItemHandler(tabType, stateBtn)
        end
        stateBtn:addOnClick(onClickHandler, UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
        self.m_itemsDic[tabType] = stateBtn
        tabData:poolRecover()
    end
end

-- 点击事件
function onClickItemHandler(self, cusTabType, cusStateBtn)
    local tabType = self:getType()
    if (self.m_isRepeatTrigger or tabType ~= cusTabType) then
        self:setType(cusTabType)
        if (self.m_clickCallObj ~= nil and self.m_clickCallFun ~= nil) then
            self.m_clickCallFun(self.m_clickCallObj, cusTabType)
        end
    end
end

-- 设置触发回调
function setClickCallBack(self, cusCallObj, cusCallFun)
    self.m_clickCallObj = cusCallObj
    self.m_clickCallFun = cusCallFun
end

-- 通过类型设置选中项
function setType(self, cusTabType, cusIsDispatch)
    for tabType, stateBtn in pairs(self.m_itemsDic) do
        if (cusTabType == tabType) then
            stateBtn:setSelectState(true)
        else
            stateBtn:setSelectState(false)
        end
    end
end

-- 获取选中项类型
function getType(self)
    for tabType, stateBtn in pairs(self.m_itemsDic) do
        if (stateBtn:getSelectState()) then
            return tabType
        end
    end
    return nil
end

-- 设置data
function setData(self, cusPosX, cusPosY, cusWidth, cusHeight, cusIsHorizontal, cusGap, top, right, bottom, left)
    local go = self:__getGo()
    if (not go) then
        return
    end
    self:setSize(cusWidth, cusHeight)
    self:setPosition(cusPosX, cusPosY, 0)

    if (cusIsHorizontal == nil) then
        cusIsHorizontal = true
    end
    self:setLayout(cusIsHorizontal, cusGap, top, right, bottom, left)
end

-- 设置大小
function setSize(self, cusWidth, cusHeight)
    local rect = self.m_tabBarGo:GetComponent(ty.RectTransform)
    if not cusHeight then
        gs.TransQuick:SizeDelta01(rect, cusWidth)
    elseif not cusWidth then
        gs.TransQuick:SizeDelta02(rect, cusHeight)
    else
        gs.TransQuick:SizeDelta(rect, cusWidth, cusHeight)
    end
end

-- 设置坐标(锚点在左上角)
function setPosition(self, cusPosX, cusPosY)
    local rect = self.m_tabBarGo:GetComponent(ty.RectTransform)
    if not cusPosY then
        gs.TransQuick:LPosX(rect, cusPosX)
    elseif not cusPosX then
        gs.TransQuick:LPosY(rect, cusPosY)
    else
        gs.TransQuick:LPosXY(rect, cusPosX, cusPosY)
    end
end

-- 设置自适应方式
function setAnchors(self, minX, minY, maxX, maxY)
    local rect = self.m_tabBarGo:GetComponent(ty.RectTransform)
    gs.TransQuick:Anchor(rect, minX, minY, maxX, maxY)
end

function setOffset(self, minX, minY, maxX, maxY)
    local rect = self.m_tabBarGo:GetComponent(ty.RectTransform)
    gs.TransQuick:Offset(rect, minX, minY, -maxX, -maxY)
end

-- 设置布局和间隔
function setLayout(self, cusIsHorizontal, cusGap, top, right, bottom, left)
    -- 设置scroller滚动方向
    local scrollScript = self.m_tabBarGo:GetComponent(ty.ScrollRect)
    if (cusIsHorizontal) then
        scrollScript.horizontal = true
        scrollScript.vertical = false
    else
        scrollScript.horizontal = false
        scrollScript.vertical = true
    end

    -- 设置项布局方式
    local layout
    local contentGo = self.m_childGos[self.m_contentName]
    if (cusIsHorizontal) then
        gs.GoUtil.RemoveComponent(contentGo, ty.VerticalLayoutGroup)
        layout = gs.GoUtil.AddComponent(contentGo, ty.HorizontalLayoutGroup)
    else
        gs.GoUtil.RemoveComponent(contentGo, ty.HorizontalLayoutGroup)
        layout = gs.GoUtil.AddComponent(contentGo, ty.VerticalLayoutGroup)
    end
    layout.childForceExpandHeight = true
    layout.childForceExpandWidth = true
    layout.childControlHeight = false
    layout.childControlWidth = false
    layout.spacing = cusGap or 0
    layout.padding.top = top or 0
    layout.padding.right = right or 0
    layout.padding.bottom = bottom or 0
    layout.padding.left = left or 0
end

-- 设置是否有惯性值
function setElastic(self, cusIsElastic, cusElasticValue)
    -- 设置scroller滚动方向
    local scrollScript = self.m_tabBarGo:GetComponent(ty.ScrollRect)
    if (cusIsElastic) then
        scrollScript.movementType = gs.ScrollRect.MovementType.Elastic
        if (cusElasticValue == nil) then
            cusElasticValue = 0.1
        end
        scrollScript.elasticity = cusElasticValue
    else
        scrollScript.movementType = gs.ScrollRect.MovementType.Clamped
    end
end

-- 设置自定义图片
function setCustomImg(self, cusIsHorizontal, cusGap, top, right, bottom, left, source, w, h, count)
    self:__resetCustomList()

    if(count > 0)then
        -- 设置项布局方式
        local layout
        local nodeLineGo = self.m_childGos[self.m_NodeLineName]
        if (cusIsHorizontal) then
            gs.GoUtil.RemoveComponent(nodeLineGo, ty.VerticalLayoutGroup)
            layout = gs.GoUtil.AddComponent(nodeLineGo, ty.HorizontalLayoutGroup)
        else
            gs.GoUtil.RemoveComponent(nodeLineGo, ty.HorizontalLayoutGroup)
            layout = gs.GoUtil.AddComponent(nodeLineGo, ty.VerticalLayoutGroup)
        end
        layout.childForceExpandHeight = false
        layout.childForceExpandWidth = false
        layout.childControlHeight = false
        layout.childControlWidth = false
        layout.spacing = cusGap or 0
        layout.padding.top = top or 0
        layout.padding.right = right or 0
        layout.padding.bottom = bottom or 0
        layout.padding.left = left or 0
        if(cusIsHorizontal)then
            layout.childAlignment = gs.TextAnchor.MiddleLeft
        else
            layout.childAlignment = gs.TextAnchor.UpperCenter
        end
    
        local customGo = self.m_childGos[self.m_ImgCustomName]
        count = count or 1
        for i = 1, count do
            local cloneGo = gs.GameObject.Instantiate(customGo)
            cloneGo:SetActive(true)
            cloneGo:GetComponent(ty.AutoRefImage):SetImg(source, true)
            gs.TransQuick:SizeDelta(cloneGo:GetComponent(ty.RectTransform), w, h)
            cloneGo.transform:SetParent(nodeLineGo.transform, false)
            table.insert(self.mCustomList, cloneGo)
        end
    end
end

-- 设置是否可以重复点击触发
function setIsRepeatTrigger(self, isRepeat)
    self.m_isRepeatTrigger = isRepeat
end
-- 获取是否可以重复点击触发
function getIsRepeatTrigger(self)
    return self.m_isRepeatTrigger
end

function getStateButton(self, tabType)
    return self.m_itemsDic[tabType]
end

function setCustomTip(self, tabType, source, x, y)
    local stateBtn = self.m_itemsDic[tabType]
    if (stateBtn) then
        stateBtn:setTipImg(source, x, y)
    end
end

function removeAllCustomTip(self)
    for tabType, stateBtn in pairs(self.m_itemsDic) do
        if (stateBtn) then
            stateBtn:setTipImg(nil, nil, nil)
        end
    end
end

function addBubble(self, tabType, resource, x, y, num, showType, moduleType)
    local stateBtn = self.m_itemsDic[tabType]
    if (stateBtn) then
        stateBtn:addBubble(resource, x, y, num, showType, moduleType)
    end
end

function removeBubble(self, tabType)
    local stateBtn = self.m_itemsDic[tabType]
    if (stateBtn) then
        stateBtn:removeBubble()
    end
end

function removeAllBubble(self)
    for tabType, stateBtn in pairs(self.m_itemsDic) do
        if (stateBtn) then
            stateBtn:removeBubble()
        end
    end
end

return _M