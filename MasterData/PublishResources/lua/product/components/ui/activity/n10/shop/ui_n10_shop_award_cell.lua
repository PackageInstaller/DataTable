_class("UIN10ShopAwardCell", UICustomWidget)
UIN10ShopAwardCell = UIN10ShopAwardCell

function UIN10ShopAwardCell:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN10.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIN10ShopAwardCell:_GetComponents()
  self.itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self.itemIconRawImg = self:GetUIComponent("RawImage", "ItemIcon")
  self.itemNumText = self:GetUIComponent("UILocalizationText", "ItemNumText")
  self.itemNumArea = self:GetGameObject("ItemNumArea")
  self.bigAwardFlag = self:GetGameObject("BigAwardFlag")
  self.normalBg = self:GetGameObject("NormalBg")
  self.specialBg = self:GetGameObject("SpecialBg")
  self.fxGo = self:GetGameObject("Fx")
  self.restNumText = self:GetUIComponent("UILocalizationText", "RestNumText")
  self.blackMask = self:GetGameObject("BlackMask")
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._normalBgImg = self:GetUIComponent("Image", "NormalBg")
  self._itemNumBgImg = self:GetUIComponent("Image", "ItemNumBg")
end

function UIN10ShopAwardCell:InitData(data, itemInfoCallback, showBlackMask, delayTime)
  self._data = data
  self._itemId = self._data:GetItemId()
  self._itemCount = self._data:GetTotalNum()
  self._itemRestCount = self._data:GetRestNum()
  self._itemInfoCallback = itemInfoCallback
  self._showBlackMask = showBlackMask
  self:_fillUi()
  if 0 < delayTime then
    self:StartTask(function(TT)
      YIELD(TT, delayTime * 33)
      self._animation:Play("uieff_ShopCell")
    end)
  end
end

function UIN10ShopAwardCell:_fillUi()
  local itemCfg = Cfg.cfg_item[self._itemId]
  if itemCfg then
    local res = itemCfg.Icon
    self.itemIcon:LoadImage(res)
    self.itemIconRawImg.material = UnityEngine.Material:New(self.itemIconRawImg.material)
    self:SetStencil()
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
    end
    self.restNumText:SetText("<color=#875832>" .. self._itemRestCount .. "</color>" .. "/" .. self._itemCount)
    self.blackMask:SetActive(self._itemRestCount <= 0 and self._showBlackMask)
    if not self._data:IsBigReward() then
      self._normalBgImg.sprite = self._atlas:GetSprite(ShopTheme.JackPotCellBg[ShopTheme.Theme])
      self._itemNumBgImg.color = ShopTheme.JackPotCellNumberColor[ShopTheme.Theme]
    else
      self._itemNumBgImg.color = Color(0.9058823529411765, 0.5411764705882353, 0.18823529411764706)
    end
  end
end

function UIN10ShopAwardCell:OnHide()
  UnityEngine.Object.Destroy(self.itemIconRawImg.material)
end

function UIN10ShopAwardCell:ItemIconOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data)
  end
end

function UIN10ShopAwardCell:NormalBgOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data)
  end
end

function UIN10ShopAwardCell:SpecialBgOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data)
  end
end

function UIN10ShopAwardCell:SetStencil()
  self.itemIconRawImg.material:SetFloat("_Stencil", 18)
  self.itemIconRawImg.material:SetFloat("_StencilComp", 4)
  self.itemIconRawImg.material:SetFloat("_StencilOp", 0)
end
