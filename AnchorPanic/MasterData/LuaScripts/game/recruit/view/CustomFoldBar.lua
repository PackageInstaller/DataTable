--[[ 
-----------------------------------------------------
@filename       : CustomFoldBar
@Description    : 自定义折叠页签组件
@date           : 2021-06-09 15:07:19
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('lib.component.CustomFoldBar', Class.impl())

function ctor(self)
    self.btnMap = {}
    self.mainBtnDic = {}

    self.curSelectPage = nil
    self.curSelectItem = nil

    self.curSelectMainPage = nil
    self.curSelectMainItem = nil
end
-- 创建页签组件
function create(self, rootGo, cusParent, callBack, callThis, list, goPoolName)
    local item = LuaPoolMgr:poolGet(self)
    item.rootGo = rootGo
    item.parentTrans = cusParent
    item.callBack = callBack
    item.callThis = callThis
    item.dataList = list
    item.goPoolName = goPoolName

    if item.dataList then
        item:setItems()
    end
    return item
end
-- 传入数据
function setData(self, cusList)
    self.dataList = cusList
    self:setItems()
end

-- 构造页签按钮组
function setItems(self)
    self:poolRecover()

    for i, v in ipairs(self.dataList) do
        if self.mainBtnDic[v.mainPage] == nil then
            -- 创建一级列表
            local btn = self:createMainBtn(v)
            self.mainBtnDic[v.mainPage] = btn
        end
    end

    for i, v in ipairs(self.dataList) do
        local go = self.mainBtnDic[v.mainPage]:getChildGO("GroupSubTabItem")
        local parent = self.mainBtnDic[v.mainPage]:getChildTrans("mGroupSub")
        local item = SimpleInsItem:create(go, parent)

        self:updateBtnInfo(item, v)

        item:addUIEvent("mBtnNomal", function()
            self:setPage(v.page)
        end)

        self:setItemSelect(item, false)

        self.btnMap[v.page] = item
    end
end
-- 更新二级按钮信息
function updateBtnInfo(self, item, data)
    local selectLan = data.selectLan or data.nomalLan
    local selectLanId = data.selectLanId or data.nomalLanId
    local selectLanEn = data.selectLanEn or data.nomalLanEn
    local selectLanEnId = data.selectLanEnId or data.nomalLanEnId

    if item:getChildGO("mTxtNomal") then
        item:setText("mTxtNomal", data.nomalLanId, data.nomalLan)
    end
    if item:getChildGO("mTxtNomalEn") then
        item:setText("mTxtNomalEn", data.nomalLanEnId, data.nomalLanEn)
    end
    if item:getChildGO("mTxtSelect") then
        item:setText("mTxtSelect", selectLanId, selectLan)
    end
    if item:getChildGO("mTxtSelectEn") then
        item:setText("mTxtSelectEn", selectLanEnId, selectLanEn)
    end
end
-- 创建一级按钮
function createMainBtn(self, data)
    local item = SimpleInsItem:create(self.rootGo, self.parentTrans, self.goPoolName)

    self:updateMainBtnInfo(item, data)

    item:addUIEvent("mBtnMainNomal", function()
        self:setMainPage(data.mainPage)
    end)
    item:addUIEvent("mBtnMainSelect", function()
        self:setMainPage(data.mainPage)
    end)

    self:setMainItemSelect(item, false, false)

    return item
end
-- 更新一级按钮信息
function updateMainBtnInfo(self, item, data)
    local selectLan = data.mainSelectLan or data.mainNomalLan
    local selectLanId = data.mainSelectLanId or data.mainNomalLanId
    local selectLanEn = data.mainSelectLanEn or data.mainNomalLanEn
    local selectLanEnId = data.mainSelectLanEnId or data.mainNomalLanEnId

    if item:getChildGO("mTxtMainNomal") then
        item:setText("mTxtMainNomal", data.mainNomalLanId, data.mainNomalLan)
    end
    if item:getChildGO("mTxtMainNomalEn") then
        item:setText("mTxtMainNomalEn", data.mainNomalLanEnId, data.mainNomalLanEn)
    end

    if item:getChildGO("mIcon") and data.iconPath then
        item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(data.iconPath)
    end
    if item:getChildGO("mTxtMainSelect") then
        item:setText("mTxtMainSelect", selectLanId, selectLan)
    end
    if item:getChildGO("mTxtMainSelectEn") then
        item:setText("mTxtMainSelectEn", selectLanEnId, selectLanEn)
    end
end

function setMainPage(self, cusPage, isAuto)
    if self.curSelectMainPage == cusPage then
        if self.curSelectMainItem then
            local isActive = self.curSelectMainItem:getChildGO("mBtnMainSelect").activeSelf
            self:setMainItemSelect(self.curSelectMainItem, not isActive, true)
        end
        return
    end

    if self.curSelectMainItem then
        self:setMainItemSelect(self.curSelectMainItem, false, true)
    end
    local item = self.mainBtnDic[cusPage]
    self:setMainItemSelect(item, true, true)
    self.curSelectMainPage = cusPage
    self.curSelectMainItem = item

    if not isAuto then
        for i, v in ipairs(self.dataList) do
            if v.mainPage == cusPage then
                self:setPage(v.page)
                break
            end
        end
    end
end

-- 设置选中项
function setMainItemSelect(self, cusItem, isSelect, isTween)
    if isSelect then
        local itemH = cusItem:getChildTrans("GroupSubTabItem").rect.height
        local vg = cusItem:getChildGO("mGroupSub"):GetComponent(ty.VerticalLayoutGroup)
        local bottom = vg.padding.bottom
        local spacing = vg.spacing


        cusItem:getChildGO("mGroupSub"):SetActive(true)
        local count = cusItem:getChildTrans("mGroupSub").childCount
        local h = itemH * count + (count - 1) * spacing + bottom

        local mTween1 = cusItem:getChildTrans("mGroupSub"):DOHeight(h, 0.3)
        cusItem:getChildTrans("mGroupSub"):DOScaleY(1, 0.3)

        mTween1:OnUpdate(function ()
            self:forceRebuildLayoutImmediate()
        end)
    else

        local mTween2 = cusItem:getChildTrans("mGroupSub"):DOHeight(0, 0.3)
        cusItem:getChildTrans("mGroupSub"):DOScaleY(0, 0.3)

        mTween2:OnUpdate(function ()
            self:forceRebuildLayoutImmediate()
        end)
    end

    cusItem:getChildGO("mBtnMainSelect"):SetActive(isSelect)
    cusItem:getChildGO("mBtnMainNomal"):SetActive(isSelect == false)
end

-- 更新按钮列表显示信息
function updateBtnListInfo(self, list)
    for i, v in ipairs(list) do
        local btn = self.mainBtnDic[v.mainPage]
        self:updateMainBtnInfo(btn, v)
    end
    for i, v in ipairs(list) do
        local btn = self.btnMap[v.page]
        self:updateBtnInfo(btn, v)
    end

end

-- 选中当前
function setPage(self, cusPage)
    if self.curSelectPage == cusPage then
        return
    end

    if self.curSelectMainItem == nil then
        for i, v in ipairs(self.dataList) do
            if v.page == cusPage then
                self:setMainPage(v.mainPage, true)
                break
            end
        end
    end

    if self.curSelectItem then
        self:setItemSelect(self.curSelectItem, false)
    end
    local item = self.btnMap[cusPage]
    self:setItemSelect(item, true)
    self.curSelectPage = cusPage
    self.curSelectItem = item

    if self.callBack then
        self.callBack(self.callThis, self.curSelectPage)
    end
end
-- 设置选中项
function setItemSelect(self, cusItem, isSelect)
    cusItem:getChildGO("mBtnSelect"):SetActive(isSelect)
    cusItem:getChildGO("mBtnNomal"):SetActive(isSelect == false)
end

-- 获取一个按钮组件:SimpleInsItem
function getItemByPage(self, cusPage)
    local item = self.btnMap[cusPage]
    return item
end

-- 获取一级按钮
function getMainItemByPage(self, cusPage)
    local item = self.mainBtnDic[cusPage]
    return item
end

function forceRebuildLayoutImmediate(self)
    if self.parentTrans and not gs.GoUtil.IsTransNull(self.parentTrans) then 
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.parentTrans:GetComponent(ty.RectTransform))--立即刷新
    end
end

-- 加红点
function addBubble(self, tabPage, posX, posY)
    local item = self.btnMap[tabPage]
    RedPointManager:add(item:getTrans(), nil, posX, posY)
end
-- 移除红点
function removeBubble(self, tabPage)
    local item = self.btnMap[tabPage]
    RedPointManager:remove(item:getTrans())
end
-- 回收按钮
function poolRecover(self)
    for i, v in pairs(self.mainBtnDic) do
        v:poolRecover()
    end
    for i, v in pairs(self.btnMap) do
        v:poolRecover()
    end
    self.btnMap = {}
    self.mainBtnDic = {}
    self.curSelectMainPage = nil
    self.curSelectMainItem = nil
    self.curSelectItem = nil
end
-- 重置
function reset(self)
    self:setMainPage(self.curSelectMainPage)
    
    self.curSelectPage = nil
    self.rootGo = nil
    self.parentTrans = nil
    self.callBack = nil
    self.callThis = nil
    self.dataList = nil
    self.goPoolName = nil
    LuaPoolMgr:poolRecover(self)
    self:poolRecover()
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
