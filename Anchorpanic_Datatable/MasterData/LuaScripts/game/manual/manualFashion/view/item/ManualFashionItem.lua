module("manual.ManualFashionItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mGroupTime = self:getChildGO("mGroupTime")
    self.mImgSellOut = self:getChildGO("mImgSellOut")
    self.mGroupMoney = self:getChildGO("mGroupMoney")
    self.mImgDiscount = self:getChildGO("mImgDiscount")
    self.mTxtBuy = self:getChildGO("mTxtBuy"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtSellOut = self:getChildGO("mTxtSellOut"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtDiscount = self:getChildGO("mTxtDiscount"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtFashionName = self:getChildGO("mTxtFashionName"):GetComponent(ty.Text)
    self.mTxtFashionSeries = self:getChildGO("mTxtFashionSeries"):GetComponent(ty.Text)
    self.mImgMoneyIcon = self:getChildGO("mImgMoneyIcon"):GetComponent(ty.AutoRefImage)

    self.mTagContent = self:getChildGO("mTagContent")
    self.mTag1 = self:getChildGO("mTag1")
    self.mTag2 = self:getChildGO("mTag2")
    self.mTag3 = self:getChildGO("mTag3")

    self.mImgLock = self:getChildGO("mImgLock")
end

function setData(self, param)
    super.setData(self, param)
    self.mFashionVo = param
    self.mTxtFashionName.text = self.mFashionVo:getName()
    if #self.mFashionVo:getName() > 5 then
        self.mTxtFashionName.fontSize = 26
    else
        self.mTxtFashionName.fontSize = 30
    end
    self.mTxtHeroName.text = self.mFashionVo:getHeroName()
    self.mGroupTime:SetActive(false)
    self.mTxtFashionSeries.text = self.mFashionVo:getFashionSeries()
    
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "fashionShop_Har/" or "fashionShop/"
    local iconUrl = UrlManager:getIconPath(url .. self.mFashionVo.fashionIcon)
    self.mImgIcon:SetImg(iconUrl, true)
    self.mTxtSellOut.text = _TT(50046)--已持有
    self.mImgDiscount:SetActive(false)-- self.mFashionVo:getDiscount() > 0)
    self.mTxtDiscount.gameObject:SetActive(false)--.text = self.mFashionVo:getDiscount() .. "%" .. _TT(25037)

    local tapList = self.mFashionVo.tap
   
    self.mTag1:SetActive(table.indexof01(tapList,1) > 0)
    self.mTag2:SetActive(table.indexof01(tapList,2) > 0)
    self.mTag3:SetActive(table.indexof01(tapList,3) > 0)
   
    self.mImgLock:SetActive(self.mFashionVo.isLock == 1)
end


function addAllUIEvent(self)
    self:addUIEvent(self.mImgIcon.gameObject, self.onClickShowHandler)
end

function onClickShowHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {
        heroTid = self.mFashionVo.heroTid,
        fashionId = self.mFashionVo.fashionId,
        isShow3D = true
    })
    -- GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_VIEW, self.mFashionVo)
    --GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroFashionShow, param = self.mFashionVo})
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M