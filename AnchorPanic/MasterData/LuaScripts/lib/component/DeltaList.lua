--[[ 
-----------------------------------------------------
@filename       : DeltaList
@Description    : 差量列表
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('lib.component.DeltaList', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("compent/DeltaList.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mAreaW = 400
    self.mAreaH = 300
    self.mItemMaxW = 150
    self.mItemMaxH = self.mAreaH
    self.mIsShowLeftRightBtn = true
    self.mTweenTime = 0.5
    self.mTweenEaseType = gs.DT.Ease.InSine
    self.mItemGap = 120
    self.mDecayGap = 50

    self.mShowItemList = nil
    self.mItemList = nil
    self.mItemDataList = nil
    self.mCurSelectIndex = nil
    self.mCallHandelr = nil
end

-- 初始化
function configUI(self)
    -- 前一个
    self.mBtnLeft = self:getChildGO("BtnLeft")
    -- 后一个
    self.mBtnRight = self:getChildGO("BtnRight")
    -- 展示容器
    self.mGroupItemList = self:getChildTrans("GroupItemList")
    -- 展示item
    self.mItem = self:getChildGO("Item")
    -- 交互层
    self.mClickTrigger = self:getChildGO("ToucherGesture"):GetComponent(ty.LongPressOrClickEventTrigger)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnLeft)
    self:removeOnClick(self.mBtnRight)
    self:removeTouchEvent()
    self:recoveItemList()
end

-- 手势相关
function addTouchEvent(self)
    local function _onPointDownHandler()
        self.mClickTrigger:SetIsPassEvent(true)
        self:onPointDownHandler()
    end
    self.mClickTrigger.onPointerDown:AddListener(_onPointDownHandler)
    local function _onPointerUpHandler()
        self:onPointerUpHandler()
    end
    self.mClickTrigger.onPointerUp:AddListener(_onPointerUpHandler)
end

function setNode(self, content, item, clickTrigger, btnLeft, btnRight, isUseAlpha, isClick)
    -- 前一个
    self.mBtnLeft = btnLeft or self.mBtnLeft
    -- 后一个
    self.mBtnRight = btnRight or self.mBtnRight
    -- 展示容器
    self.mGroupItemList = content or self.mGroupItemList
    -- 展示item
    self.mItem = item or self.mItem
    --点击层
    self.mClickTrigger = clickTrigger or self.mClickTrigger
    --是否使用透明度渐变
    self.mIsUseAlpha = (isUseAlpha ~= false) and true or false
    --是否启用预制体点击
    self.mIsClick = isClick ~= false and true or false
end

function removeTouchEvent(self)
    self.mClickTrigger.onPointerDown:RemoveAllListeners()
    self.mClickTrigger.onPointerUp:RemoveAllListeners()
end

function onPointDownHandler(self)
    self.mDownTime = gs.Time.time
    self.mDownX = gs.Input.mousePosition.x
end

function onPointerUpHandler(self)
    local deltaX = gs.Input.mousePosition.x - self.mDownX
    if (deltaX > 10) then
        if (gs.Time.time - self.mDownTime < 0.5) then
            self.mClickTrigger:SetIsPassEvent(false)
            self:onClickLeftHandler()
        else
            self.mClickTrigger:SetIsPassEvent(false)
        end
    elseif (deltaX < -10) then
        if (gs.Time.time - self.mDownTime < 0.5) then
            self.mClickTrigger:SetIsPassEvent(false)
            self:onClickRightHandler()
        else
            self.mClickTrigger:SetIsPassEvent(false)
        end
    else
        self.mClickTrigger:SetIsPassEvent(true)
    end
end

function onClickLeftHandler(self)
    if (self.mCurSelectIndex - 1 > 0) then
        self:setSelectIndex(self.mCurSelectIndex - 1, true)
    end
end

function onClickRightHandler(self)
    if (self.mCurSelectIndex + 1 <= #self.mItemDataList) then
        self:setSelectIndex(self.mCurSelectIndex + 1, true)
    end
end

-- 设置界面参数
function setViewParams(self, areaW, areaH, itemMaxW, itemMaxH, isShowLeftRightBtn)
    self.mAreaW = areaW or self.mAreaW
    self.mAreaH = areaH or self.mAreaH
    self.mItemMaxW = itemMaxW or self.mItemMaxW
    self.mItemMaxH = itemMaxH or self.mItemMaxH
    self.mIsShowLeftRightBtn = isShowLeftRightBtn
end

-- 设置缓动参数
function setTweenParams(self, tweenTime, tweenEaseType)
    self.mTweenTime = tweenTime or self.mTweenTime
    self.mTweenEaseType = tweenEaseType or self.mTweenEaseType
end

-- 设置公式参数：an = a1+(n-1)*d，Sn = n*a1+n*(n-1)*d/2
function setFormulaParams(self, a1, d)
    self.mItemGap = a1
    self.mDecayGap = d
end

-- 数据源列表，默认选中项
function setData(self, dataList, selectIndex, parentTrans, itemRender, itemChangeCall)
    self:addOnClick(self.mBtnLeft, self.onClickLeftHandler)
    self:addOnClick(self.mBtnRight, self.onClickRightHandler)
    self:addTouchEvent()
    gs.TransQuick:SizeDelta(self.UIObject:GetComponent(ty.RectTransform), self.mAreaW, self.mAreaH)

    self:recoveItemList()
    self.mCallHandelr = itemChangeCall
    self.mItemDataList = dataList

    for i = 1, #self.mItemDataList do
        local item = SimpleInsItem:create(self.mItem, self.mGroupItemList, "DeltaListItem")
        local data = { itemIndex = i, itemData = self.mItemDataList[i], item = item }
        item:setArgs(data)
        gs.TransQuick:SizeDelta(item:getGo():GetComponent(ty.RectTransform), self.mItemMaxW, self.mItemMaxH)

        if (itemChangeCall and self.mIsClick) then
            item:getChildGO("Toucher"):SetActive(true)
            item:addUIEvent("Toucher", function()
                if self.mCurSelectIndex ~= data.itemIndex then
                    self:setSelectIndex(data.itemIndex, true)
                    itemChangeCall(data)
                end
            end)
        else
            item:getChildGO("Toucher"):SetActive(false)
        end
        table.insert(self.mItemList, item)

        local showItem = itemRender:poolGet()
        showItem:setData(item:getChildTrans("ShowNode"), data)
        table.insert(self.mShowItemList, showItem)
    end
    self:setSelectIndex(selectIndex or 1, false)
    self:setParentTrans(parentTrans)
end

function setSelectIndex(self, selectIndex, isTween)
    local function refreshItem(n, item, lastItemNearX)
        local targetX = 0
        local targetW = 0
        local targetAlpha = 0
        local itemNearX = 0
        local data = item:getArgs()
        local itemData = data.itemData
        local itemIndex = data.itemIndex
        if (itemIndex < selectIndex) then                                -- 左
            item:getGo().name = "左：" .. (selectIndex - n)
            targetAlpha = math.max(0, 1 - math.abs(itemIndex - selectIndex) * 0.3)

            targetX = -self:getTargetX(n)
            if (targetX < lastItemNearX) then
                targetW = math.abs(targetX - lastItemNearX) * 2
                itemNearX = 2 * targetX - lastItemNearX
            else
                targetX = lastItemNearX
                targetW = 0
                itemNearX = targetX
            end
        elseif (itemIndex > selectIndex) then                            -- 右
            item:getGo().name = "右：" .. (selectIndex + n)
            targetAlpha = math.max(0, 1 - math.abs(itemIndex - selectIndex) * 0.3)
            targetX = self:getTargetX(n)
            if (targetX > lastItemNearX) then
                targetW = (targetX - lastItemNearX) * 2
                itemNearX = 2 * targetX - lastItemNearX
            else
                targetX = lastItemNearX
                targetW = 0
                itemNearX = targetX
            end
        else                                                            -- 中
            item:getGo().name = "中：" .. selectIndex
            targetAlpha = 1
            targetX = 0
            targetW = self.mItemMaxW
            itemNearX = 0
        end
        item:getChildGO("mImgBackMask"):SetActive(((self.mIsUseAlpha == false) and (targetAlpha ~= 1)))
        targetAlpha = self.mIsUseAlpha and targetAlpha or 1
        local rect = item:getGo():GetComponent(ty.RectTransform)
        local canvasGroup = item:getChildTrans("ShowNode"):GetComponent(ty.CanvasGroup)
        rect:SetSiblingIndex(0)
        if (isTween) then
            TweenFactory:move2LPosX(rect, targetX, self.mTweenTime, self.mTweenEaseType)
            TweenFactory:widthTo(rect, nil, targetW, self.mTweenTime, self.mTweenEaseType)
            TweenFactory:canvasGroupAlphaTo(canvasGroup, nil, targetAlpha, self.mTweenTime, self.mTweenEaseType)
            if self.mCallHandelr then
                if selectIndex == data.itemIndex then
                    self.mCallHandelr(data)
                end
            end
        else
            gs.TransQuick:LPosX(rect, targetX)
            gs.TransQuick:SizeDelta01(rect, targetW)
            canvasGroup.alpha = targetAlpha
        end
        return itemNearX
    end

    self.mCurSelectIndex = selectIndex
    -- 左
    local lastLeftItemNearX = -self.mItemMaxW / 2
    for i = selectIndex - 1, 1, -1 do
        lastLeftItemNearX = refreshItem(selectIndex - i, self.mItemList[i], lastLeftItemNearX)
    end
    -- 右
    local lastRightItemNearX = self.mItemMaxW / 2
    for i = selectIndex + 1, #self.mItemList do
        lastRightItemNearX = refreshItem(i - selectIndex, self.mItemList[i], lastRightItemNearX)
    end
    -- 中
    refreshItem(0, self.mItemList[selectIndex], self.mItemMaxW / 2)

    self:updateBtnView()
end

-- 按需重写
function getTargetX(self, n)
    -- -- 固定间隔直线方式
    -- return 80 * n + 20
    -- -- 等差求和抛物线方式
    return self.mItemGap * n + n * (n - 1) / 2 * (-self.mDecayGap)
end

function updateBtnView(self)
    if (self.mIsShowLeftRightBtn) then
        if (self.mCurSelectIndex - 1 > 0) then
            self.mBtnLeft:SetActive(true)
        else
            self.mBtnLeft:SetActive(false)
        end
        if (self.mCurSelectIndex + 1 <= #self.mItemDataList) then
            self.mBtnRight:SetActive(true)
        else
            self.mBtnRight:SetActive(false)
        end
    else
        self.mBtnLeft:SetActive(false)
        self.mBtnRight:SetActive(false)
    end
end

-- 回收项
function recoveItemList(self)
    if self.mShowItemList then
        for i, item in pairs(self.mShowItemList) do
            item:poolRecover()
        end
    end
    self.mShowItemList = {}
    if self.mItemList then
        for i, item in pairs(self.mItemList) do
            item:poolRecover()
        end
    end
    self.mItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]