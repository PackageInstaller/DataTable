--[[ 
-----------------------------------------------------
@filename       : CustomTabBar2
@Description    : 替换 TabBar 临时组件
@date           : 2021-11-20 16:46:12
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('lib.component.CustomTabBar2', Class.impl())

function ctor(self)
    self.btnList = {}
    self.btnMap = {}

    self.curSelectPage = nil
    self.curSelectItem = nil
end
-- 创建页签组件
-- goPoolName 回收时按钮组件使用的命名(唯一)
function create(self, rootGo, cusParent, callBack, callThis, lineGo, goPoolName)
    local item = LuaPoolMgr:poolGet(self)
    item.rootGo = rootGo
    item.parentTrans = cusParent
    item.callBack = callBack
    item.callThis = callThis
    item.dataList = list
    item.goPoolName = goPoolName
    item.lineGo = lineGo

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

    for i, v in pairs(self.dataList) do
        local item = SimpleInsItem:create(self.rootGo, self.parentTrans, self.goPoolName)

        local selectLan = v.selectLan or v.nomalLan
        local selectLanId = v.selectLanId or v.nomalLanId
        local selectLanEn = v.selectLanEn or v.nomalLanEn
        local selectLanEnId = v.selectLanEnId or v.nomalLanEnId

        if item:getChildGO("mTxtNomal") then
            item:setText("mTxtNomal", v.nomalLanId, v.nomalLan)
        end
        if item:getChildGO("mTxtNomalEn") then
            item:setText("mTxtNomalEn", v.nomalLanEnId, v.nomalLanEn)
        end
        if item:getChildGO("mTxtSelect") then
            item:setText("mTxtSelect", selectLanId, selectLan)
        end
        if item:getChildGO("mTxtSelectEn") then
            item:setText("mTxtSelectEn", selectLanEnId, selectLanEn)
        end

        if (item:getChildGO("mBtnNomal"):GetComponent(ty.Button)) then
            item:addUIEvent("mBtnNomal", function()
                self:setPage(v.page)
            end, UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
        end

        if (item:getChildGO("mBtnSelect"):GetComponent(ty.Button)) then
            item:addUIEvent("mBtnSelect", function()
                self:setPage(v.page)
            end)
        end

        self:setItemSelect(item, false)

        if i < #self.dataList then
            local mImgLine = gs.GameObject.Instantiate(self.lineGo)
            mImgLine.transform:SetParent(self.parentTrans, false)
            mImgLine:SetActive(true)
            table.insert(self.lineList, mImgLine)
        end

        table.insert(self.btnList, item)
        self.btnMap[v.page] = item
    end
end
function setDispatcherSame(self, isFilterSame)
    self.isFilterSame = isFilterSame
end
function setType(self, cusType, cusIsDispatch)
    self:setPage(cusType, cusIsDispatch)
end
-- 选中当前
function setPage(self, cusPage, cusIsDispatch)
    if (self.isFilterSame ~= false) then
        if self.curSelectPage == cusPage then
            return
        end
    end
    if self.curSelectItem then
        self:setItemSelect(self.curSelectItem, false)
    end
    local item = self.btnMap[cusPage]
    self:setItemSelect(item, true)
    self.curSelectPage = cusPage
    self.curSelectItem = item

    if cusIsDispatch ~= false and self.callBack then
        self.callBack(self.callThis, self.curSelectPage)
    end
end
-- 设置选中项
function setItemSelect(self, cusItem, isSelect)
    if (cusItem == nil) then
    else
        cusItem:getChildGO("mBtnSelect"):SetActive(isSelect)
        cusItem:getChildGO("mBtnNomal"):SetActive(isSelect == false)
    end
end

-- 获取一个按钮组件:SimpleInsItem
function getItemByPage(self, cusPage)
    local item = self.btnMap[cusPage]
    return item
end

-- 加红点
function addBubble(self, tabPage, posX, posY)
    local item = self.btnMap[tabPage]
    if item then
        RedPointManager:add(item:getTrans(), nil, posX, posY)
    end
end

-- 移除红点
function removeBubble(self, tabPage)
    local item = self.btnMap[tabPage]
    if item then
        RedPointManager:remove(item:getTrans())
    end
end

function removeAllBubble(self)
    for i, v in ipairs(self.btnList) do
        RedPointManager:remove(v:getTrans())
    end
end

-- 回收按钮
function poolRecover(self)
    for i, v in ipairs(self.btnList) do
        v:poolRecover()
    end
    self.lineList = {}
    self.btnList = {}
    self.btnMap = {}
end
-- 重置
function reset(self)
    self:removeAllBubble()
    self:poolRecover()
    self.isFilterSame = nil
    self.curSelectPage = nil
    self.curSelectItem = nil
    self.rootGo = nil
    self.parentTrans = nil
    self.callBack = nil
    self.callThis = nil
    self.dataList = nil
    self.goPoolName = nil
    LuaPoolMgr:poolRecover(self)
end


-- 设置是否可以重复点击触发
function setIsRepeatTrigger(self, isRepeat)
    self.m_isRepeatTrigger = isRepeat
    self:setDispatcherSame((not isRepeat))
end
-- 获取是否可以重复点击触发
function getIsRepeatTrigger(self)
    return self.m_isRepeatTrigger
end

function getStateButton(self, tabType)
    return self.btnMap[tabType]
end


return _M