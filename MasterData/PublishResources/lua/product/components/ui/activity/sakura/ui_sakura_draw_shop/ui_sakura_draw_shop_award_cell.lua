_class("UISakuraDrawShopAwardCell", UICustomWidget)
UISakuraDrawShopAwardCell = UISakuraDrawShopAwardCell

function UISakuraDrawShopAwardCell:OnShow(uiParams)
  self:InitWidget()
end

function UISakuraDrawShopAwardCell:InitWidget()
  self.itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self.itemNumText = self:GetUIComponent("UILocalizationText", "ItemNumText")
  self.itemNumArea = self:GetGameObject("ItemNumArea")
  self.bigAwardFlag = self:GetGameObject("BigAwardFlag")
  self.normalBg = self:GetGameObject("NormalBg")
  self.specialBg = self:GetGameObject("SpecialBg")
  self.fxGo = self:GetGameObject("Fx")
  self.restNumText = self:GetUIComponent("UILocalizationText", "RestNumText")
end

function UISakuraDrawShopAwardCell:SetData()
end

function UISakuraDrawShopAwardCell:InitData(data, itemInfoCallback)
  self._data = data
  self._itemId = self._data:GetItemId()
  self._itemCount = self._data:GetTotalNum()
  self._itemRestCount = self._data:GetRestNum()
  self._itemInfoCallback = itemInfoCallback
  self:_fillUi()
end

function UISakuraDrawShopAwardCell:_fillUi()
  local itemCfg = Cfg.cfg_item[self._itemId]
  if itemCfg then
    self.itemIcon:DestoryLastImage()
    local res = itemCfg.Icon
    self.itemIcon:LoadImage(res)
    local itemCount = self._data:GetItemCount()
    if 1 < itemCount then
      self.itemNumArea:SetActive(true)
      self.itemNumText:SetText(itemCount)
    else
      self.itemNumArea:SetActive(false)
    end
    self.bigAwardFlag:SetActive(self._data:IsBigReward())
    self.normalBg:SetActive(not self._data:IsBigReward())
    self.specialBg:SetActive(self._data:IsBigReward())
    local showEff = self._data:IsBigReward() and self._itemRestCount > 0
    if self.fxGo then
      self.fxGo:SetActive(showEff)
    end
    self.restNumText:SetText("<color=#F6A201>" .. self._itemRestCount .. "</color>" .. "/" .. self._itemCount)
  end
end

function UISakuraDrawShopAwardCell:ItemIconOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data)
  end
end
