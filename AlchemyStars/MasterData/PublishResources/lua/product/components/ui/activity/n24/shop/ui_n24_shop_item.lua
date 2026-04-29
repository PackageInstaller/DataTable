_class("UIN24ShopItem", UICustomWidget)
UIN24ShopItem = UIN24ShopItem

function UIN24ShopItem:Constructor()
  self.size = {
    big = Vector2(353, 370),
    small = Vector2(274, 306)
  }
end

function UIN24ShopItem:OnShow(uiParams)
  self.atlas = self:GetAsset("UIN24.spriteatlas", LoadType.SpriteAtlas)
  self.go = self:GetGameObject()
  self.go:SetActive(false)
  self.anim = self:GetUIComponent("Animation", "UIN24ShopItem")
  self.loe = self:GetUIComponent("LayoutElement", "UIN24ShopItem")
  self.big = self:GetGameObject("big")
  self.bgBig = self:GetUIComponent("Image", "bgBig")
  self.imgIconBig = self:GetUIComponent("RawImageLoader", "imgIconBig")
  self.txtCountItemBig = self:GetUIComponent("UILocalizationText", "txtCountItemBig")
  self.txtCountAwardBig = self:GetUIComponent("UILocalizationText", "txtCountAwardBig")
  self.imgBigFlag = self:GetUIComponent("Image", "imgBigFlag")
  self.small = self:GetGameObject("small")
  self.bgSmall = self:GetUIComponent("Image", "bgSmall")
  self.imgIconSmall = self:GetUIComponent("RawImageLoader", "imgIconSmall")
  self.txtCountItemSmall = self:GetUIComponent("UILocalizationText", "txtCountItemSmall")
  self.txtCountAwardSmall = self:GetUIComponent("UILocalizationText", "txtCountAwardSmall")
end

function UIN24ShopItem:OnHide()
  self.imgIconBig:DestoryLastImage()
  self.imgIconSmall:DestoryLastImage()
end

function UIN24ShopItem:InitData(data, itemInfoCallback, unlock)
  self._data = data
  self._unlock = unlock
  self._itemId = self._data.m_item_id
  self._itemCount = self._data.m_lottery_limit_count
  self._itemRestCount = self._data.m_lottery_count
  self._itemInfoCallback = itemInfoCallback
  self:FillUi()
end

function UIN24ShopItem:FillUi()
  local itemCfg = Cfg.cfg_item[self._itemId]
  if itemCfg then
    local res = itemCfg.Icon
    local hasRest = self._itemRestCount > 0
    local itemCount = self._data.m_count
    local bgSprite, imgIconColor
    local showNumberTex = "x" .. itemCount
    local showTimesTex, starSprite
    if self._unlock and hasRest then
      imgIconColor = Color.white
      showNumberTex = "<color=#f0ede9>" .. showNumberTex .. "</color>"
      showTimesTex = "<color=#f7e2c4>" .. self._itemRestCount .. "/" .. self._itemCount .. "</color>"
      bgSprite = self._data.m_is_big_reward and "n24_shop_di2" or "n24_shop_di4"
      starSprite = "n24_shop_icon1"
    else
      imgIconColor = Color(1, 1, 1, 0.5)
      showNumberTex = "<color=#a1a1a1>" .. showNumberTex .. "</color>"
      if self._itemRestCount > 0 then
        showTimesTex = "<color=#606060>" .. self._itemRestCount .. "/" .. self._itemCount .. "</color>"
      else
        showTimesTex = "<color=#9a9a9a>" .. self._itemRestCount .. "</color><color=#606060>/" .. self._itemCount .. "</color>"
      end
      bgSprite = self._data.m_is_big_reward and "n24_shop_di3" or "n24_shop_di5"
      starSprite = "n24_shop_icon2"
    end
    if self._data.m_is_big_reward then
      self.loe.preferredWidth = self.size.big.x
      self.loe.preferredHeight = self.size.big.y
      self.big:SetActive(true)
      self.small:SetActive(false)
      self.bgBig.sprite = self.atlas:GetSprite(bgSprite)
      self.imgBigFlag.sprite = self.atlas:GetSprite(starSprite)
      self.imgIconBig:LoadImage(res)
      self.imgIconBig:SetColor(imgIconColor)
      self.txtCountItemBig:SetText(showNumberTex)
      self.txtCountAwardBig:SetText(showTimesTex)
    else
      self.loe.preferredWidth = self.size.small.x
      self.loe.preferredHeight = self.size.small.y
      self.big:SetActive(false)
      self.small:SetActive(true)
      self.bgSmall.sprite = self.atlas:GetSprite(bgSprite)
      self.imgIconSmall:LoadImage(res)
      self.imgIconSmall:SetColor(imgIconColor)
      self.txtCountItemSmall:SetText(showNumberTex)
      self.txtCountAwardSmall:SetText(showTimesTex)
    end
  end
end

function UIN24ShopItem:ShowHide(isShow)
  self.go:SetActive(isShow)
end

function UIN24ShopItem:PlayAnim(idx)
  self:StartTask(function(TT)
    if 1 < idx then
      YIELD(TT, (idx - 1) * 60)
    end
    self.go:SetActive(true)
    local key = "UIN24ShopItemPlayAnim" .. self._itemId
    self:Lock(key)
    if self._data.m_is_big_reward then
      self.anim:Play("uieffanim_UIN24ShopItem_big")
    else
      self.anim:Play("uieffanim_UIN24ShopItem_small")
    end
    YIELD(TT, 867)
    self:UnLock(key)
  end, self)
end

function UIN24ShopItem:BgOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data.m_item_id, go.transform.position)
  end
end
