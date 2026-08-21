
module("game.purchase.fashionShop.view.item.FashionPaintingItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImGlow = self:getChildGO("mImGlow")
    self.TextFree = self:getChildGO("TextFree")
    self.mGoToucher = self:getChildGO("ImgToucher")
    self.mGoToucherImg = self:getChildGO("ImgToucher"):GetComponent(ty.AutoRefImage)
    self.mGroupEndTime = self:getChildGO("mGroupEndTime")
    self.mGroupSoldOut = self:getChildGO("mGroupSoldOut")
    self.mGroupMoneyPrice = self:getChildGO("GroupMoneyPrice")
    self.mTextName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.mImgDisco = self:getChildGO('ImgDisco'):GetComponent(ty.Image)
    self.mTextPrice = self:getChildGO("TextPrice"):GetComponent(ty.Text)
    self.mImgBotBg = self:getChildGO("mImgBotBg"):GetComponent(ty.Image)
    self.mTextDisco = self:getChildGO('TextDisco'):GetComponent(ty.Text)
    self.ImgDisco2 = self:getChildGO('ImgDisco2'):GetComponent(ty.Image)
    self.TextDisco2 = self:getChildGO('TextDisco2'):GetComponent(ty.Text)
    self.mTextRemain = self:getChildGO("TextRemain"):GetComponent(ty.Text)
    self.mTextEndTime = self:getChildGO("TextEndTime"):GetComponent(ty.Text)
    self.mTextSoldOut = self:getChildGO('TextSoldOut'):GetComponent(ty.Text)
    self.TextDisco2Dec = self:getChildGO("TextDisco2Dec"):GetComponent(ty.Text)
    self.mGridNode = self:getChildTrans("GridNode"):GetComponent(ty.AutoRefImage)
    self.mGridNodeEff = self:getChildTrans("GridNodeEff"):GetComponent(ty.AutoRefImage)
    self.mTextMoneyPrice = self:getChildGO("TextMoneyPrice"):GetComponent(ty.Text)
    self.mImgMoneyIcon = self:getChildGO('ImgMoneyIcon'):GetComponent(ty.AutoRefImage)
    self.mGroupTime = self:getChildGO("mGroupTime")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mTextSoldOut.text = _TT(25011) -- "已售罄"
    self.TextDisco2Dec.text = "超值"
    self.mIsHot = self:getChildGO("mIsHot")
    self.mBgEff = self:getChildGO("mBgEff")

    self.mImgCost = self:getChildGO("mImgCost"):GetComponent(ty.AutoRefImage)
    self.mTextPriceYuan = self:getChildGO("mTextPriceYuan"):GetComponent(ty.Text)
    self:addOnClick(self.mGoToucher, self.__onClickBuyHadler)

    self.mTagContent = self:getChildGO("mTagContent")
    self.mTag1 = self:getChildGO("mTag1")
    self.mTag2 = self:getChildGO("mTag2")
    self.mTag3 = self:getChildGO("mTag3")
end

function deActive(self)
    super.deActive(self)

    if self.time then
        LoopManager:removeTimerByIndex(self.time)
        self.time = nil
    end
end

function setData(self, param)
    super.setData(self, param)
    local directBuyVo = self.data
    self.mTextPrice.text = directBuyVo:getMoneyCount()
    if directBuyVo.payType == MoneyType.MONEY then
        self.mTextPriceYuan.gameObject:SetActive(true)
        self.mImgCost.gameObject:SetActive(false)
    else
        self.mTextPriceYuan.gameObject:SetActive(false)
        self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(directBuyVo.payType), true)
        self.mImgCost.gameObject:SetActive(true)
    end

    local propsConfigVo = props.PropsManager:getPropsConfigVo(directBuyVo.itemId)
    self.mTextName.text = propsConfigVo.name
    self.mGridNode:SetImg(UrlManager:getPropsIconUrl(directBuyVo.itemId), true)
    self.mGridNodeEff:SetImg(UrlManager:getPropsIconUrl(directBuyVo.itemId), true)
    self.mBgEff:SetActive(propsConfigVo.color == 3)

    self.isBuy = purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(directBuyVo.id)
    self.mGroupSoldOut:SetActive(self.isBuy)

    local paintingDataVo = purchase.FashionShopManager:getPaintingDataById(directBuyVo.fashionDic[1])
    local tapList = paintingDataVo.tapList

    self.mTag1:SetActive(table.indexof01(tapList, 1) > 0)
    self.mTag2:SetActive(table.indexof01(tapList, 2) > 0)
    self.mTag3:SetActive(table.indexof01(tapList, 3) > 0)

    self.mGroupTime:SetActive(directBuyVo:getTime() > 0)
    if (directBuyVo:getTime() > 0) then
        if self.time then
            LoopManager:removeTimerByIndex(self.time)
            self.time = nil
        end
        self:updateTime()
        self.time = LoopManager:addTimer(1, 0, self, self.updateTime)
    end
end

function __onClickBuyHadler(self)
    if self.isBuy then
        gs.Message.Show(_TT(25011))
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PAINTING_PANEL, self.data)
end

function updateTime(self)
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_10(self.data:getTime())

    if self.data:getTime() <= 0 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_COMBO_VIEW)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(50025):"商品已下架"
语言包: _TT(50024):"直购描述"
语言包: _TT(50023):"直购标题"
语言包: _TT(50022):"免费"
]]
