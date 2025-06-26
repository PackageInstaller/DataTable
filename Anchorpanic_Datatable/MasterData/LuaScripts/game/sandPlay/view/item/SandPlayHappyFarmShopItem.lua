-- @FileName:   SandPlayHappyFarmShopItem.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-09-05 10:32:34
-- @Copyright:   (LY) 2024 锚点降临

module("game.sandPlay.view.SandPlayHappyFarmShopItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgPrice = self:getChildGO("mImgPrice"):GetComponent(ty.AutoRefImage)
    self.mTextPrice = self:getChildGO("mTextPrice"):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO("mTxtLimit"):GetComponent(ty.Text)
    self.mImgOver = self:getChildGO("mImgOver")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnBuy"), function()
        if self.mShopVo:isLock() then
            gs.Message.Show(_TT(25031))
            return
        end

        if self.mShopVo:isSoldout() then
            -- 已售罄
            gs.Message.Show(_TT(25011))
            return
        end

        if not self.mShopVo:isEnoughLimit() then
            -- 等级限制
            gs.Message.Show(_TT(25012))
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_VIEW, self.mShopVo)
    end)
end

function setData(self, shopVo)
    super.setData(self, shopVo)
    self.mShopVo = shopVo

    self.mTextName.text = self.mShopVo:getItemName()

    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.mShopVo:getItemTid()), false)
    self.mImgPrice:SetImg(self.mShopVo:getPayIcon(), false)

    local price = self.mShopVo.price
    local namecolorStr = MoneyUtil.getMoneyCountByTid(self.mShopVo:getRealPayType()) < price and "fa3a2bFF" or "ffffffff"
    self.mTextPrice.text = HtmlUtil:color(MoneyUtil.shortValueStr(price), namecolorStr)

    if self.mShopVo:getLimit() > 0 then
        self.mTxtLimit.gameObject:SetActive(true)
        self.mTxtLimit.text = self.mShopVo:getLimitCount()
    else
        self.mTxtLimit.gameObject:SetActive(false)
        self.mTxtLimit.text = ""
    end

    -- 售罄
    if self.mShopVo:isSoldout() then
        self.mImgOver:SetActive(true)
    else
        if self.mShopVo:isLock() then
            self.mImgOver:SetActive(true)
        else
            self.mImgOver:SetActive(false)
        end
    end

end

return _M
