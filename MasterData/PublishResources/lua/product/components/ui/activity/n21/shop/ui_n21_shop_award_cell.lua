_class("UIN21ShopAwardCell", UICustomWidget)
UIN21ShopAwardCell = UIN21ShopAwardCell

function UIN21ShopAwardCell:OnShow(uiParams)
  self.atlas = self:GetAsset("UIN21.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIN21ShopAwardCell:_GetComponents()
  self.itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self.itemNumText = self:GetUIComponent("UILocalizationText", "ItemNumText")
  self.itemNumArea = self:GetGameObject("ItemNumArea")
  self._star = self:GetGameObject("BigAwardFlag")
  self._starImg = self:GetUIComponent("Image", "BigAwardFlag")
  self.restNumText = self:GetUIComponent("UILocalizationText", "RestNumText")
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "Animation")
  self._img = self:GetUIComponent("Image", "Bg")
  self._itemNumBgImg = self:GetUIComponent("Image", "ItemNumBg")
  self.go = self:GetGameObject()
end

function UIN21ShopAwardCell:InitData(data, itemInfoCallback, unlock, delayTime)
  self._data = data
  self._unlock = unlock
  self._itemId = self._data.m_item_id
  self._itemCount = self._data.m_lottery_limit_count
  self._itemRestCount = self._data.m_lottery_count
  self._itemInfoCallback = itemInfoCallback
  self:FillUi()
  if 0 < delayTime then
    self._canvasGroup.alpha = 0
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(delayTime * 60, function()
      self._animation:Play("UIN21ShopAwardCell")
    end)
  end
end

function UIN21ShopAwardCell:FillUi()
  local itemCfg = Cfg.cfg_item[self._itemId]
  if itemCfg then
    local res = itemCfg.Icon
    self.itemIcon:LoadImage(res)
    local itemCount = self._data.m_count
    local showNumberTex, showTimesTex, bgSprite, starSprite, numSprite
    if self._unlock and self._itemRestCount > 0 then
      showNumberTex = "<color=#ce8a4e>" .. itemCount .. "</color>"
      showTimesTex = "<color=#eee3d6>" .. self._itemRestCount .. "/" .. self._itemCount .. "</color>"
      if self._data.m_is_big_reward then
        bgSprite = "n21_shop_goods1"
      else
        bgSprite = "n21_shop_goods3"
      end
      starSprite = "n21_shop_star1"
      numSprite = "n21_shop_count1"
    else
      showNumberTex = "<color=#797979>" .. itemCount .. "</color>"
      showTimesTex = "<color=#262626>" .. self._itemRestCount .. "/" .. self._itemCount .. "</color>"
      bgSprite = "n21_shop_goods2"
      starSprite = "n21_shop_star2"
      numSprite = "n21_shop_count2"
    end
    self.itemNumText:SetText(showNumberTex)
    self.restNumText:SetText(showTimesTex)
    self._img.sprite = self.atlas:GetSprite(bgSprite)
    self._itemNumBgImg.sprite = self.atlas:GetSprite(numSprite)
    if self._data.m_is_big_reward then
      self._star:SetActive(true)
      self._starImg.sprite = self.atlas:GetSprite(starSprite)
    else
      self._star:SetActive(false)
    end
  end
end

function UIN21ShopAwardCell:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UIN21ShopAwardCell:BgOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data.m_item_id, go.transform.position)
  end
end
