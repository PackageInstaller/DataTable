_class("UIN29ShopItem", UICustomWidget)
UIN29ShopItem = UIN29ShopItem

function UIN29ShopItem:Constructor()
  self.size = {
    big = Vector2(361, 344),
    small = Vector2(299, 324)
  }
end

function UIN29ShopItem:OnShow(uiParams)
  self.atlas = self:GetAsset("UIN29Lottery.spriteatlas", LoadType.SpriteAtlas)
  self.go = self:GetGameObject()
  self.go:SetActive(false)
  self.anim = self:GetUIComponent("Animation", "UIN29ShopItem")
  self.big = self:GetGameObject("big")
  self.bgBig = self:GetUIComponent("Image", "bgBig")
  self.imgIconBig = self:GetUIComponent("RawImageLoader", "imgIconBig")
  self.txtCountItemBig = self:GetUIComponent("UILocalizationText", "txtCountItemBig")
  self.txtCountAwardBig = self:GetUIComponent("UILocalizationText", "txtCountAwardBig")
  self.imgBigFlag = self:GetUIComponent("Image", "imgBigFlag")
  self.bigMaskGo = self:GetGameObject("bigMask")
  self.small = self:GetGameObject("small")
  self.bgSmall = self:GetUIComponent("Image", "bgSmall")
  self.imgIconSmall = self:GetUIComponent("RawImageLoader", "imgIconSmall")
  self.txtCountItemSmall = self:GetUIComponent("UILocalizationText", "txtCountItemSmall")
  self.txtCountAwardSmall = self:GetUIComponent("UILocalizationText", "txtCountAwardSmall")
  self.smallMaskGo = self:GetGameObject("smallMask")
  self.imgIconBigShadow = self:GetUIComponent("RawImageLoader", "imgIconBigShadow")
  self.imgIconSmallShadow = self:GetUIComponent("RawImageLoader", "imgIconSmallShadow")
end

function UIN29ShopItem:OnHide()
  self.imgIconBig:DestoryLastImage()
  self.imgIconSmall:DestoryLastImage()
end

function UIN29ShopItem:InitData(data, itemInfoCallback, unlock)
  self._data = data
  self._unlock = unlock
  self._itemId = self._data.m_item_id
  self._itemCount = self._data.m_lottery_limit_count
  self._itemRestCount = self._data.m_lottery_count
  self._itemInfoCallback = itemInfoCallback
  self:FillUi()
end

function UIN29ShopItem:FillUi()
  local itemCfg = Cfg.cfg_item[self._itemId]
  if itemCfg then
    local res = itemCfg.Icon
    local hasRest = self._itemRestCount > 0
    local itemCount = self._data.m_count
    local showNumberTex = "x" .. itemCount
    local showTimesTex
    local canGet = self._unlock and hasRest
    if self._data.m_is_big_reward then
      showTimesTex = "<color=#fffae7>" .. self._itemRestCount .. "</color>" .. "<color=#b9b2aa>/" .. self._itemCount .. "</color>"
      self.big:SetActive(true)
      self.small:SetActive(false)
      self.imgIconBig:LoadImage(res)
      self.imgIconBigShadow:LoadImage(res)
      self.txtCountItemBig:SetText(showNumberTex)
      self.txtCountAwardBig:SetText(showTimesTex)
      self.bigMaskGo:SetActive(not canGet)
    else
      showTimesTex = "<color=#9a7c5f>" .. self._itemRestCount .. "</color>" .. "<color=#292624>/" .. self._itemCount .. "</color>"
      self.big:SetActive(false)
      self.small:SetActive(true)
      self.imgIconSmall:LoadImage(res)
      self.imgIconSmallShadow:LoadImage(res)
      self.txtCountItemSmall:SetText(showNumberTex)
      self.txtCountAwardSmall:SetText(showTimesTex)
      self.smallMaskGo:SetActive(not canGet)
    end
  end
end

function UIN29ShopItem:ShowHide(isShow)
  self.go:SetActive(isShow)
end

function UIN29ShopItem:PlayAnim(idx)
  self:StartTask(function(TT)
    if 1 < idx then
      YIELD(TT, (idx - 1) * 60)
    end
    self.go:SetActive(true)
    local key = "UIN29ShopItemPlayAnim" .. self._itemId
    self:Lock(key)
    if self._data.m_is_big_reward then
      self.anim:Play("uieff_UIN29ShopItem_big")
    else
      self.anim:Play("uieff_UIN29ShopItem_small")
    end
    YIELD(TT, 867)
    self:UnLock(key)
  end, self)
end

function UIN29ShopItem:PlayOutAnim()
  self.anim:Play("uieff_UIN29ShopItem_out")
end

function UIN29ShopItem:BgOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data.m_item_id, go.transform.position)
  end
end
