module('purchase.LimitShopBuyItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTimeSn = nil
    self.mItemList = {}
    self.mItem = self:getChildGO("mItem")
    self.mShopTrans = self:getChildTrans("mShopTrans")
    self.mTxtRightTitle=self:getChildGO("mTxtRightTitle"):GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)
    local dic=param.dic
    self.mTxtRightTitle.text=_TT(50084)
    self:updateLimitShopHandle(dic)
end

function updateLimitShopHandle(self,dic)
    self:clearAllItem()
    for _, vo in pairs(dic) do
        local Item = SimpleInsItem:create(self.mItem, self.mShopTrans, "shopItem_1")
        local itemScroller=Item:getChildGO("mItemScroller"):GetComponent(ty.LyScroller)
        itemScroller:SetItemRender(ShowAwardEmptyItem)
        Item:addUIEvent("mBtnBuy",function ()
            if vo:getPayType() ~= MoneyType.MONEY then
                local isEnought, tips = MoneyUtil.judgeNeedMoneyCountByTid(vo:getPayType(), vo:getPrice(), true, true)
                if (isEnought) then
                    GameDispatcher:dispatchEvent(EventName.REQ_LIMIT_SHOP_BUY, { id = vo:getId(), num = 1 })
                else
                    UIFactory:alertMessge(tips, true, function()
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
                    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
                end
            else
                recharge.sendRecharge(recharge.RechargeType.LIMITSHOP_GIFT, nil, vo:getId())
            end
        end)
        local click = function ()
            local deltaTime = vo:getEndTime() - GameManager:getClientTime()
                Item:getChildGO("mTxtEndTime"):GetComponent(ty.Text).text = TimeUtil.getHMSByTime(deltaTime)
                if deltaTime<=0 then
                    GameDispatcher:dispatchEvent(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL)
            end
        end
        local data={Vo=vo,timeHandle=click}
        Item:setArgs(data)
        Item:getChildGO("mTxtResidue"):SetActive(vo:getIsCanBuy())
        Item:getChildGO("mTxtMoney"):SetActive(vo:getPayType() == MoneyType.MONEY)
        Item:getChildGO("mImgMoney"):SetActive(vo:getPayType() ~= MoneyType.MONEY)
        Item:getChildGO("mImgMoney"):GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(vo:getPayType()), true)
        Item:getChildGO("mIconIttem"):GetComponent(ty.AutoRefImage):SetImg(vo:getIcon(), true)
        Item:getChildGO("mBtnSoldOut"):SetActive(not vo:getIsCanBuy())
        Item:getChildGO("mSoldOut"):SetActive(not vo:getIsCanBuy())
        Item:getChildGO("mMask"):SetActive(vo:getIsCanBuy())
        Item:getChildGO("mImgValue"):SetActive(vo:getIsCanBuy())
        Item:getChildGO("mTxtSoldOut"):GetComponent(ty.Text).text = _TT(25011)
        Item:getChildGO("mTxtValue"):GetComponent(ty.Text).text = vo:getValue()
        Item:getChildGO("mTxtValueDes"):GetComponent(ty.Text).text = _TT(50085)
        Item:getChildGO("mTxtPrice"):GetComponent(ty.Text).text = vo:getPrice()
        Item:getChildGO("mTxtResidue"):GetComponent(ty.Text).text = vo:getResidue()
        self.mTxtRightTitle.gameObject:SetActive(vo:getBuyType()<=1)
        itemScroller.DataProvider = vo:getAwardList()
        table.insert(self.mItemList,Item) 
    end
    self:addTimerHandle()
end

function addTimerHandle(self)
    if #self.mItemList<=0 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL)
        return
    end
    self:updateTime()
    self.mTimeSn = LoopManager:addTimer(1,0,self,self.updateTime)
end

function updateTime(self)
    if #self.mItemList>0 then
        for _, item in ipairs(self.mItemList) do
            item:getArgs().timeHandle()
        end
    end
end

function removeTimer(self)
    if (self.mTimeSn) then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn = nil
    end
end


function clearAllItem(self)
    self:removeTimer()
    if table.nums(self.mItemList)>=0 then
        for k, item in ipairs(self.mItemList) do
            local itemScroller=item:getChildGO("mItemScroller"):GetComponent(ty.LyScroller)
            itemScroller:CleanAllItem()
            item:poolRecover()
            item=nil
        end
    end
    self.mItemList={}
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    self:clearAllItem()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(50025):	"商品已下架"
	语言包: _TT(50024):	"直购描述"
	语言包: _TT(50023):	"直购标题"
	语言包: _TT(50022):	"免费"
]]
