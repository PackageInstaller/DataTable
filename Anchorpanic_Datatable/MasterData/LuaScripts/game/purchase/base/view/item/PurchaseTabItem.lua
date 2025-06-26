--[[ 
-----------------------------------------------------
@filename       : PurchaseTabItem
@Description    : 贸易站三级tab
@date           : 2023-04-19 18:39:53
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
-- 
module("game.purchase.base.view.item.PurchaseTabItem", Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("purchase/PurchaseTabItem.prefab")

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
    self.mCurIndex = 1
    --限制时间
    self.mCurTime = 0
end
-- 初始化
function configUI(self)
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnSelect = self:getChildGO("mBtnSelect")
    self.mRedTrans = self:getChildTrans("mRedTrans")
    self.mImgNormal = self:getChildGO("mImgNormal"):GetComponent(ty.AutoRefImage)
    self.mImgSelect = self:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage)
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
    RedPointManager:remove(self.mRedTrans)
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

function updateBubble(self)
    local isBubble = purchase.PurchaseManager:getTabBubbleByType(self.vo.page)
    if (isBubble) then
        RedPointManager:add(self.mRedTrans, nil, 0, 0)
    else
        RedPointManager:remove(self.mRedTrans)
    end
end

function setData(self, cusVo, cusIndex, cusCallBack, cusThisObject, subType, tweenIndex, subChildType, childCallBack)
    self.vo = cusVo
    self.index = cusIndex
    self.callBack = cusCallBack
    self.childCallBack = childCallBack
    self.thisObject = cusThisObject
    self.subType = subType
    self.subChildType = subChildType
    self.tweenIndex = tweenIndex
    self:updateView()
end

function getSubType(self)
    return self.vo.subList or {}
end

function getFunIdList(self)
    return self.vo.pageFuncId
end

function getChildItem(self)
    return purchase.PurchaseChildTabItem
end

function updateView(self)
    self:updateBubble()
    local typeList = self:getSubType()
    self.mImgNormal:SetImg(shop.getPageIcon(self.index), false)
    self.mImgSelect:SetImg(shop.getPageIcon(self.index), false)
    self:getChildGO("mHasChildNomal"):SetActive(false)
    self:getChildGO("mHasChildSelect"):SetActive(false)
    self.mTxtNomal.text = self.vo.nomalLan
    self.mTxtSelect.text = self.vo.nomalLan
    self:setSelect(false)
end

function setSelect(self, bool)
    if bool then
        self.mBtnSelect:SetActive(true)
        self.mBtnNomal:SetActive(false)
        self.mChildContent.gameObject:SetActive(true)
    else
        self.mBtnSelect:SetActive(false)
        self.mBtnNomal:SetActive(true)
    end
    self:clearItems()
    gs.TransQuick:SizeDelta02(self.mChildContent.gameObject:GetComponent(ty.RectTransform), 0)
    local index = 1
    if (#self:getSubType() > 1 and bool) then
        TweenFactory:rotate(self:getChildTrans("mHasChildSelect"), math.Vector3(0, 0, 0), 0)
        self:getChildGO("mHasChildNomal"):SetActive(false)
        self:getChildGO("mHasChildSelect"):SetActive(true)
        self.mChildContent.gameObject:GetComponent(ty.RectTransform).sizeDelta.y = 0
        for i, childType in ipairs(self:getSubType()) do
            if self.subChildType == childType then
                index = i
            end
            if funcopen.FuncOpenManager:isOpen(childType) then
                self:createItem(i)
            end
        end
        self:onClickChildHandler(index)
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
    for k, v in pairs(self.mChildItems) do
        v:setSelect(false)
    end
    local tabItem = self.mChildItems[index]
    tabItem:setSelect(true)
end
function onClickChildHandler(self, index)
    self:setChildIndex(index)
    local funcId = self:getSubType()[index]
    self.childCallBack(self.thisObject, funcId)
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
    self.callBack(self.thisObject, self.index)
    --self.UIObject:GetComponent(ty.Animator):SetTrigger("show")
end
--页签伸缩
function onClickSelectHandler(self)
    local curTime = GameManager:getClientTime()
    if curTime - self.mCurTime > 0.01 then
        if #self:getSubType() > 0 then
            local angle = self:getChildGO("mHasChildSelect"):GetComponent(ty.RectTransform).rotation.z == 0 and 180 or 0
            TweenFactory:rotate(self:getChildTrans("mHasChildSelect"), math.Vector3(0, 0, angle), 0.1)
            if angle == 180 then
                self.mChildContent.gameObject:SetActive(false)
            else
                self.mChildContent.gameObject:SetActive(true)
                self.mChildContent.gameObject:GetComponent(ty.RectTransform).sizeDelta.y = 0
            end
            self:updateTab(angle == 180)
        else
            return
        end
        self.mCurTime = curTime
    end
end

--刷新页签
function updateTab(self, isHide)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mChildContent)
    local needH = isHide and self.h or self.h + 70 * table.nums(self.mChildItems)            --#self.mChildItems
    gs.TransQuick:SizeDelta02(self.UIObject:GetComponent(ty.RectTransform), needH)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mBtnNomal"))
    GameDispatcher:dispatchEvent(EventName.UPDATE_SHOP_TAB_CONTENT)
end

--创建子物体
function createItem(self, i)
    local tabItem = UI.new(self:getChildItem())
    tabItem:setParentTrans(self.mChildContent)
    tabItem:setData(self.vo, i, self.onClickChildHandler, self)
    --table.insert(self.mChildItems, tabItem)
    self.mChildItems[i] = tabItem
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]