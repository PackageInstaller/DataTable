module("game.purchase.fashionShop.view.item.FashionShowItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("purchase/FashionShowItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)
    self.mData = nil
end

-- 初始化
function configUI(self)
    self.mGroupTime = self:getChildGO("mGroupTime")
    self.mGroupMoney = self:getChildGO("mGroupMoney")
    self.mImgDiscount = self:getChildGO("mImgDiscount")
    self.mTxtBuy = self:getChildGO("mTxtBuy"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtDiscount = self:getChildGO("mTxtDiscount"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgMoneyIcon = self:getChildGO("mImgMoneyIcon"):GetComponent(ty.AutoRefImage)

    self.mTagContent = self:getChildGO("mTagContent")
    self.mTag1 = self:getChildGO("mTag1")
    self.mTag2 = self:getChildGO("mTag2")
    self.mTag3 = self:getChildGO("mTag3")
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOP, self.updateFashionItemState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOW, self.updateFashionItemState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateFashionItemState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_DISCOUNT, self.updateDiscount, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateFashionItemState, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOW, self.updateFashionItemState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOP, self.updateFashionItemState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateFashionItemState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_DISCOUNT, self.updateDiscount, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateFashionItemState, self)
    if self.mLoopTimeSn then
        LoopManager:removeTimerByIndex(self.mLoopTimeSn)
        self.mLoopTimeSn = nil
    end
end

function initViewText(self)
    -- self.mTxtSellOut.text = _TT(50046)--已持有
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    --  self:addUIEvent(self.mImgIcon.gameObject, self.onClick)
end

function updateDiscount(self)
    self:updateFashionItemState()
end

function setData(self, cusParent, data)
    self:setParentTrans(cusParent)
    self.mData = data
    local showVo = self.mData.itemData

    local tapList = showVo.heroFashionData.tap
   
    self.mTag1:SetActive(table.indexof01(tapList,1) > 0)
    self.mTag2:SetActive(table.indexof01(tapList,2) > 0)
    self.mTag3:SetActive(table.indexof01(tapList,3) > 0)

    self.mImgIcon:SetImg(showVo:getShadowIcon(), false)

    if (showVo:getCanUpdate()) then
        if self.mLoopTimeSn then
            LoopManager:removeTimerByIndex(self.mLoopTimeSn)
            self.mLoopTimeSn = nil
        end
        local function updateTime()
            self:updateFashionItemState()
            -- if showVo:getTime() <= 0 then
            --     local nextFashionVo = purchase.FashionShopManager:getCurShopList()[showVo.id]
            --     GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP)
            --     GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, nextFashionVo)
            --     if self.mLoopTimeSn then
            --         LoopManager:removeTimerByIndex(self.mLoopTimeSn)
            --         self.mLoopTimeSn = nil
            --     end
            -- end
        end
        updateTime()
        self.mLoopTimeSn = LoopManager:addTimer(1, 0, self, updateTime)
    end
    self:updateFashionItemState()
end

--更新状态
function updateFashionItemState(self)
    local needMoney = self.mData.itemData:getMoneyCount()
    local isUseDisc = purchase.FashionShopManager.isUseDiscount
    if isUseDisc and self.mData.itemData:getDiscountCost() > 0 and self.mData.itemData:getDiscount() <= 0 and not self.mData.itemData:getIsSellOut() then
        -- 使用打折卡
        needMoney = self.mData.itemData:getDiscountCost()
        self.mImgDiscount:SetActive(self.mData.itemData:getDiscountCost() > 0)
        self.mTxtDiscount.text = "使用打折卡" --_TT(121192)--"使用打折卡"
    else
        self.mTxtDiscount.text = self.mData.itemData:getDiscount() .. "%" .. _TT(25037)
        self.mImgDiscount:SetActive(self.mData.itemData:getDiscount() > 0)
    end

    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_10(self.mData.itemData:getTime())
    local textColor = (MoneyUtil.getMoneyCountByTid(self.mData.itemData:getMoneyTid()) >= needMoney) and "000000ff" or "D53529ff"
    self.mGroupMoney:SetActive((not self.mData.itemData:getIsSellOut()))

    if self.mData.itemData:getMoneyTid() == MoneyType.MONEY then
        self.mImgMoneyIcon.gameObject:SetActive(false)
        textColor = "000000ff"
        self.mTxtBuy.text = HtmlUtil:color("¥"..needMoney/100, textColor)
    else
        self.mImgMoneyIcon.gameObject:SetActive((not self.mData.itemData:getIsSellOut()))
        self.mImgMoneyIcon:GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(self.mData.itemData:getMoneyTid()), true)
        self.mTxtBuy.text = HtmlUtil:color(needMoney, textColor)
    end
    

    self.mGroupTime:SetActive(self.mData.itemData:getTime() > 0)
end

function onClick(self)
    local showVo = self.mData.itemData
    if showVo.id ~= purchase.FashionShopManager:getFashionShowVo().id then
        GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, showVo)
    end

    --local itemIndex = self.mData.itemIndex
    --gs.Message.Show("点击按钮" .. itemIndex)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]