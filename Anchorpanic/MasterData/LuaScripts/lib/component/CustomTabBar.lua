--[[
-----------------------------------------------------
@filename       : CustomTabBar
@Description    : 自定义页签组件
@date           : 2021-03-10 16:46:03
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('lib.component.CustomTabBar', Class.impl())

function ctor(self)
    self.btnList = {}
    self.btnMap = {}

    -- 锁定列表
    self.lockMap = {}

    self.curSelectPage = nil
    self.curSelectItem = nil
end
-- 创建页签组件
-- goPoolName 回收时按钮组件使用的命名(唯一)
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

    for i, v in pairs(self.dataList) do
        local item = SimpleInsItem:create(self.rootGo, self.parentTrans, self.goPoolName)

        local selectLan = v.selectLan or v.nomalLan
        local selectLanId = v.selectLanId or v.nomalLanId
        local selectLanEn = v.selectLanEn or v.nomalLanEn
        local selectLanEnId = v.selectLanEnId or v.nomalLanEnId
        local selectIcon = v.selectIcon or v.nomalIcon
        local isSign = v.sign or false

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
        if item:getChildGO("mImgNomalIcon") then
            if v.nomalIcon then
                item:getChildGO("mImgNomalIcon"):GetComponent(ty.AutoRefImage):SetImg(v.nomalIcon, false)
                item:getChildGO("mImgNomalIcon"):SetActive(true)
            else
                item:getChildGO("mImgNomalIcon"):SetActive(false)
            end
        end
        if item:getChildGO("mImgSelectIcon") then
            if selectIcon then
                item:getChildGO("mImgSelectIcon"):GetComponent(ty.AutoRefImage):SetImg(selectIcon, false)
                item:getChildGO("mImgSelectIcon"):SetActive(true)
            else
                item:getChildGO("mImgSelectIcon"):SetActive(false)
            end
        end

        if (item:getChildGO("mBtnNomal"):GetComponent(ty.Button)) then
            item:addUIEvent("mBtnNomal", function()
                if self.m_NoClick then
                    return
                end

                self:setPage(v.page)
                local anim = item.m_go:GetComponent(ty.Animator)
                if not gs.GoUtil.IsCompNull(anim) then
                    anim:SetTrigger("show")
                end
                local selectDotween = item:getChildGO("mBtnSelect"):GetComponent(ty.UIDoTween)
                if selectDotween then
                    selectDotween:BeginTween()
                end
            end, UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
        end

        if (item:getChildGO("mBtnSelect"):GetComponent(ty.Button)) then
            item:addUIEvent("mBtnSelect", function()
                if self.m_NoClick then
                    return
                end

                self:setPage(v.page)
            end)
        end

        if item:getChildGO("mImgSign") then
            item:getChildGO("mImgSign"):SetActive(isSign)
        end

        self:setItemSelect(item, false)

        table.insert(self.btnList, item)
        self.btnMap[v.page] = item
    end

    self.curSelectPage = nil
    self.curSelectItem = nil

    self:showTabTween()
end

-- 排队添加页签(美术不要了，白给)
function showTabTween(self)
    -- LoopManager:removeFrameByIndex(self.mShowFrameId)
    -- for i, v in ipairs(self.btnList) do
    --     v:setActive(false)
    -- end

    -- self.index = 1
    -- self.mShowFrameId = LoopManager:addFrame(1, 0, self, function()
    --     local item = self.btnList[self.index]
    --     item:setActive(true)
    --     self.index = self.index + 1

    --     if self.index > #self.btnList then
    --         LoopManager:removeFrameByIndex(self.mShowFrameId)
    --     end
    -- end)
end

-- 更新按钮列表显示信息
function updateBtnListInfo(self, list)
    for i, v in ipairs(list) do
        local item = self.btnMap[v.page]
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
    end
end

--设置是否可以点击
function setCanClick(self, val)
    self.m_NoClick = val
end

-- 设置重复触发
function setDispatcherSame(self, isFilterSame)
    self.isFilterSame = isFilterSame
end

-- 设置类型（和page转换）
function setType(self, cusType, cusIsDispatch)
    self:setPage(cusType, cusIsDispatch)
end
-- 选中当前
function setPage(self, cusPage, cusIsDispatch)
    if self.lockMap[cusPage] then
        for i, v in ipairs(self.dataList) do
            if v.funcId and cusPage == v.page then
                funcopen.FuncOpenManager:isOpen(v.funcId, true)
                break
            end
        end
        return
    end
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

function setHideItem(self, indexs)
    for k, v in pairs(self.btnMap) do
        v:getGo():SetActive(true)
    end
    for i = 1, #indexs do
        self.btnMap[indexs[i]]:getGo():SetActive(false)
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

function setDefIsSelect(self,isSelect)
    for _, cusItem in pairs(self.btnMap) do
        cusItem:getChildGO("mBtnSelect"):SetActive(isSelect)
        cusItem:getChildGO("mBtnNomal"):SetActive(isSelect == false)
    end
end

-- 设置某项锁定状态
function setItemLock(self, cusPage, cusState)
    local item = self.btnMap[cusPage]
    if item then
        self.lockMap[cusPage] = cusState
        if item:getChildGO("mImgLock") then
            item:getChildGO("mImgLock"):SetActive(cusState)
        end
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

-- 加红点
function addBubbleWithImg(self, tabPage, imgPath, posX, posY)
    local item = self.btnMap[tabPage]
    if item then
        RedPointManager:add(item:getTrans(), imgPath, posX, posY)
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
    LoopManager:removeFrameByIndex(self.mShowFrameId)
    for i, v in ipairs(self.btnList) do
        v:poolRecover()
    end
    self.btnList = {}
    self.btnMap = {}
    self.lockMap = {}
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
