--[[ 
-----------------------------------------------------
@filename       : PurchaseMainTabItem
@Description    : 贸易站三级tab
@date           : 2023-04-19 18:39:53
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
-- 
module("game.purchase.base.view.item.PurchaseMainTabItem", Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("purchase/PurchaseMainTabItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构
function dtor(self)
end

function initData(self)
    self.mChildItems = {}
    --当前索引
    self.mCurIndex = 0
    --限制时间
    self.mCurTime = 0
end

-- 初始化
function configUI(self)
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnSelect = self:getChildGO("mBtnSelect")
    self.mGroupSelect = self:getChildTrans("mGroupSelect")
    self.mTxtSelect = self:getChildGO("mTxtSelect"):GetComponent(ty.Text)
    self.mTxtNomal = self:getChildGO("mTxtNomal"):GetComponent(ty.Text)
    self.mChildContent = self:getChildTrans("mChildContent")
    self.h = self.UIObject:GetComponent(ty.RectTransform).sizeDelta.y
end

-- 激活
function active(self)
    super.active(self)
    purchase.PurchaseManager:addEventListener(purchase.PurchaseManager.BUBBLE_CHANGE, self.updateBubble, self)
    self:addOnClick(self.mBtnNomal, self.onNomalClick, UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
    self:addOnClick(self.mBtnSelect, self.onClickSelectHandler)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:updateRed(true)
    purchase.PurchaseManager:removeEventListener(purchase.PurchaseManager.BUBBLE_CHANGE, self.updateBubble, self)
    self:removeOnClick(self.mBtnNomal)
    self:removeOnClick(self.mBtnSelect)
    self.mCurIndex = 0
    self:clearItems()
    if self.tweenSign then
        LoopManager:removeFrameByIndex(self.tweenSign)
        self.tweenSign = nil
        self.tweenIndex = nil
    end
end

function setData(self, cusVo, cusIndex, childCallBack, cusThisObject, subType, tweenIndex, list, subChildType, showType, callBack)
    self.vo = cusVo
    self.index = cusIndex
    self.childCallBack = childCallBack
    self.cusCallBack = callBack
    self.thisObject = cusThisObject
    self.subType = self.vo.page == showType and subType or nil
    self.showType = showType
    self.subChildType = self.vo.page == showType and subChildType or nil
    self.tweenIndex = tweenIndex
    self.mList = list
    self:updateView()
    self:updateBubble()
end

function updateBubble(self)
    self:updateRed()
end

function updateRed(self, isRemove)
    local isFlag = false
    self:setBubble(false)
    for _, vo in ipairs(self:getSubType()) do
        if purchase.PurchaseManager:getTabBubbleByType(vo.page) then
            isFlag = true
            break
        end
    end
    if isRemove == nil then
        self:setBubble(isFlag)
    end
end

function getSubType(self)
    return self.mList
end

function getChildItem(self)
    return purchase.PurchaseTabItem
end

function updateView(self)
    self:updateSubType()
    self:updateSubChildType()
    self:getChildGO("mHasChildNomal"):SetActive(false)
    self:getChildGO("mHasChildSelect"):SetActive(false)
    self.mTxtNomal.text = self.vo.nomalLan
    self.mTxtSelect.text = self.vo.nomalLan
    self:setSelect(self.showType == self.index)
end

function updateSubType(self)
    if (not self.subType) then
        for _, subTypeVo in ipairs(self:getSubType()) do
            if funcopen.FuncOpenManager:isOpen(subTypeVo.funcId) then
                self.subType = subTypeVo.funcId
                break
            end
        end
    end
end

function updateSubChildType(self)
    if (not self.subChildType and (self:getSubType()[self.index].subList)) then
        for _, subChildType in ipairs(self:getSubType()[self.index].subList) do
            self.subChildType = subChildType
            break
        end
    end
end

function setBubble(self, isRed)
    RedPointManager:remove(self.mGroupSelect)
    RedPointManager:remove(self.mBtnNomal.transform)
    if isRed then
        RedPointManager:add(self.mGroupSelect, nil, 95.5, -13)
        RedPointManager:add(self.mBtnNomal.transform, nil, 95.5, 13)
    end
end

function setSelect(self, bool)
    if bool then
        self.mBtnSelect:SetActive(true)
        self.mBtnNomal:SetActive(false)
    else
        self.mBtnSelect:SetActive(false)
        self.mBtnNomal:SetActive(true)
        self.subChildType = nil
        self.subType = nil
        self:updateSubType()
        self:updateSubChildType()
    end
    self:clearItems()
    gs.TransQuick:SizeDelta02(self.mChildContent.gameObject:GetComponent(ty.RectTransform), 0)
    local index = 1
    if (bool) then
        TweenFactory:rotate(self:getChildTrans("mHasChildSelect"), math.Vector3(0, 0, 0), 0)
        self:getChildGO("mHasChildNomal"):SetActive(false)
        self:getChildGO("mHasChildSelect"):SetActive(true)
        self.mChildContent.gameObject:GetComponent(ty.RectTransform).sizeDelta.y = 0
        for i, subTypeVo in ipairs(self:getSubType()) do
            if self.subType == subTypeVo.funcId then
                index = i
            end
            if funcopen.FuncOpenManager:isOpen(subTypeVo.funcId) then
                self:createItem(subTypeVo, i)
            end
        end
        self:onChildCallBack(index)
    else
        if #self:getSubType() > 1 then
            self:getChildGO("mHasChildNomal"):SetActive(true)
        else
            self:getChildGO("mHasChildNomal"):SetActive(false)
        end
        self:getChildGO("mHasChildSelect"):SetActive(false)
        gs.TransQuick:SizeDelta02(self.UIObject:GetComponent(ty.RectTransform), self.h)
    end
    self:updateTab()
end
--设置子物体显示
function setChildIndex(self, index)
    for k, item in pairs(self.mChildItems) do
        item:setSelect(false)
    end
    self.mCurIndex = index
    local tabItem = self.mChildItems[index]
    tabItem:setSelect(true)
end

function onChildCallBack(self, index)
    self:setChildIndex(index)
    if not self:getSubType()[index].subList then
        self:childCallback1(self:getSubType()[index].funcId)
    end
end

function childCallback1(self, funcId)
    local args=nil
    if funcId==funcopen.FuncOpenConst.FUNC_ID_PURCHASE_DIRECT_BUY and self.subChildType then
        args={subChildTabIndex=self.subChildType}
    else
        args={subChildTabIndex=nil}
    end
    self.childCallBack(self.thisObject, funcId,args)
end

--删除子物体
function clearItems(self)
    for k, v in pairs(self.mChildItems) do
        v:destroy()
    end
    self.mChildItems = {}
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mChildContent)
end
--未选中回调
function onNomalClick(self)
    self.cusCallBack(self.thisObject, self.index)
end
--页签伸缩
function onClickSelectHandler(self)
    local curTime = GameManager:getClientTime()
    if curTime - self.mCurTime > 0.01 then
        local angle = self:getChildGO("mHasChildSelect"):GetComponent(ty.RectTransform).rotation.z == 0 and 180 or 0
        TweenFactory:rotate(self:getChildTrans("mHasChildSelect"), math.Vector3(0, 0, angle), 0.3)
        if angle == 180 then
            self:clearItems()
        else
            local index = 1
            self:clearItems()
            self.mChildContent.gameObject:GetComponent(ty.RectTransform).sizeDelta.y = 0
            for i, subTypeVo in ipairs(self:getSubType()) do
                if funcopen.FuncOpenManager:isOpen(subTypeVo.funcId) then
                    self:createItem(subTypeVo, i)
                end
            end
            self:setChildIndex(self.mCurIndex)
        end
        self:updateTab()
    else
        return
    end
    self.mCurTime = curTime
end

--刷新页签
function updateTab(self)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mChildContent)
    local needH = self.h + 70 * table.nums(self.mChildItems)
    gs.TransQuick:SizeDelta02(self.UIObject:GetComponent(ty.RectTransform), needH)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mBtnNomal"))
    GameDispatcher:dispatchEvent(EventName.UPDATE_SHOP_TAB_CONTENT)
end

--创建子物体
function createItem(self, vo, i)
    local tabItem = UI.new(self:getChildItem())
    tabItem:setParentTrans(self.mChildContent)
    tabItem:setData(vo, i, self.onChildCallBack, self, self.subType, i, self.subChildType, self.childCallback1)
    self.mChildItems[i] = tabItem
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]