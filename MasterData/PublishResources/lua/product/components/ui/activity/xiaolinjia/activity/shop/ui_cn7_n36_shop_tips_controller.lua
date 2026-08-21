_class("UICN7N36ShopTipsController", UIController)
UICN7N36ShopTipsController = UICN7N36ShopTipsController

function UICN7N36ShopTipsController:Constructor()
  self._outAnimName = "uieff_UISakuraDrawShopTipsController_out"
  self._outAnimTime = 433
  self._atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
end

function UICN7N36ShopTipsController:OnShow(uiParams)
  self._data = uiParams[1]
  self:_GetComponent()
  self:_OnValue()
end

function UICN7N36ShopTipsController:_GetComponent()
  self._descripution = self:GetUIComponent("UILocalizationText", "Descripution")
  self._contentAnim = self:GetUIComponent("Animation", "Content")
  self._itemInfoName = self:GetUIComponent("UILocalizationText", "Name")
  self._itemInfoCount = self:GetUIComponent("UILocalizationText", "OwnCount")
  self.itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self.itemNumText = self:GetUIComponent("UILocalizationText", "ItemNumText")
  self.itemNumArea = self:GetGameObject("ItemNumArea")
  self.bigAwardFlag = self:GetGameObject("BigAwardFlag")
  self.normalBg = self:GetGameObject("NormalBg")
  self.specialBg = self:GetGameObject("SpecialBg")
  self.restNumText = self:GetUIComponent("UILocalizationText", "RestNumText")
  self._normalBgImg = self:GetUIComponent("Image", "NormalBg")
  self._itemNumBgImg = self:GetUIComponent("Image", "ItemNumBg")
end

function UICN7N36ShopTipsController:_OnValue()
  if self._data ~= nil then
    local itemId = self._data:GetItemId()
    local config = Cfg.cfg_item[itemId]
    if config ~= nil then
      self._itemInfoName:SetText(StringTable.Get(config.Name))
      self._descripution:SetText(StringTable.Get(config.Intro))
      self._itemCount = self._data:GetTotalNum()
      self._itemRestCount = self._data:GetRestNum()
      local itemCount = self._data:GetItemCount()
      self.itemIcon:LoadImage(config.Icon)
      self.itemNumText:SetText(itemCount)
      self.itemNumArea:SetActive(1 < itemCount)
      self.bigAwardFlag:SetActive(self._data:IsBigReward())
      self.normalBg:SetActive(not self._data:IsBigReward())
      self.specialBg:SetActive(self._data:IsBigReward())
      self.restNumText:SetText("<color=#875832>" .. self._itemRestCount .. "</color>" .. "/" .. self._itemCount)
      if not self._data:IsBigReward() then
        self._normalBgImg.sprite = self._atlas:GetSprite(ShopTheme.JackPotCellBg[ShopTheme.Theme])
        self._itemNumBgImg.color = ShopTheme.JackPotCellNumberColor[ShopTheme.Theme]
      else
        self._itemNumBgImg.color = Color(0.9058823529411765, 0.5411764705882353, 0.18823529411764706)
      end
    end
    local roleModule = GameGlobal.GetModule(RoleModule)
    local c = roleModule:GetAssetCount(itemId)
    self._itemInfoCount:SetText(StringTable.Get("str_item_public_owned") .. self:_FormatItemCount(c))
  end
end

function UICN7N36ShopTipsController:BgOnClick()
  self:CloseDialogWithAnim()
end

function UICN7N36ShopTipsController:CloseDialogWithAnim()
  if self._contentAnim then
    self:Lock("UICN7N36ShopTipsController:CloseDialogWithAnim")
    if self._contentAnim then
      self._contentAnim:Play(self._outAnimName)
    end
    self:StartTask(function(TT)
      YIELD(TT, self._outAnimTime)
      self:UnLock("UICN7N36ShopTipsController:CloseDialogWithAnim")
      self:CloseDialog()
    end, self)
  end
end

function UICN7N36ShopTipsController:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end
