local M = BaseClass("ClothBuyPopupUICtrl", BaseUICtrl)

function M:Init()
    self._view.rectBuy:onClick(Bind(self, self.OnBuyClick))
    self._view.rectCancel:onClick(Bind(self, self.Close))
    self._view.rectClose:onClick(Bind(self, self.Close))
    self.m_cloth_buy_succ = EventMgr:AddListener(UIMessageNames.SHOP_CLOTH_BUY_SUCC, Bind(self, self.BuySuccess))
end

function M:OnEnter(data)
    self.data = data
    local str = ConfigHelper.GetLocalString(6226)
    local skinCfg = self.data.skinCfg
    local itemCfg = ConfigHelper.GetCfg("item", skinCfg.id)
    local heroName = ConfigHelper.GetHeroName(skinCfg.heroId)
    local skinName = ConfigHelper.GetLocalString(itemCfg.name)
    local desStr = string.format(str, heroName, skinName)
    self._view.txtDes:SetText(desStr)
    self._view.cloth:SetSkinDrawing(skinCfg.id)
    self:_SetCost()
end

function M:_SetCost()
    local shopCfg = self.data.shopCfg
    local finalCfg = ConfigHelper.GetCfg("item", shopCfg.finalItem)
    if finalCfg ~= nil then
        self._view.iconCost:SetPic(finalCfg.icon)
        if shopCfg.finalNum == 0 then
            self._view.txtCost:SetText(5083)
        end
        self._view.txtCost:SetText(tostring(shopCfg.finalNum))
    end
end

function M:OnBuyClick()
    local shopId = ShopDataMgr.clothShopId
    ShopDataMgr:RequestBuyItem(shopId, self.data.shopCfg.id, 1, Bind(self, self.BuySuccess))
    self:Close()
end

function M:BuySuccess()
    --皮肤展示界面
    EventMgr:Broadcast(UIMessageNames.ROLE_FASHION_CHANGE)
    UIContextMgr:GetInstance():Show("ClothShowUI", self.data)
    self:Close()
end

function M:OnClose()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.SHOP_CLOTH_BUY_SUCC, self.m_cloth_buy_succ)
    self.m_cloth_buy_succ = nil
    M.super.OnDispose(self)
end

return M
