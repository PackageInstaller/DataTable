_class("UIN19P5AwardItem", UICustomWidget)
UIN19P5AwardItem = UIN19P5AwardItem

function UIN19P5AwardItem:OnShow()
  self.color2color = {
    [1] = "n19p5_choujiang_pin01",
    [2] = "n19p5_choujiang_pin02",
    [3] = "n19p5_choujiang_pin03",
    [4] = "n19p5_choujiang_pin04",
    [5] = "n19p5_choujiang_pin05",
    [6] = "n19p5_choujiang_pin06"
  }
  self:GetComponents()
end

function UIN19P5AwardItem:GetComponents()
  self.Color = self:GetUIComponent("Image", "color")
  self.LessTex = self:GetUIComponent("UILocalizationText", "timeTex")
  self.ItemCount = self:GetUIComponent("UILocalizationText", "countTex")
  self.BigImg = self:GetGameObject("type")
  self.timeGo = self:GetGameObject("time")
  self.BgImg = self:GetUIComponent("Image", "bg")
  self.MaskImg = self:GetUIComponent("Image", "mask")
  self.Icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconRectDefaultSize = self._iconRect.sizeDelta
  self.atlas = self:GetAsset("UIN19P5.spriteatlas", LoadType.SpriteAtlas)
  self.Mask = self:GetGameObject("mask")
  self.hide = self:GetGameObject("hide")
  self.pos = self:GetUIComponent("RectTransform", "pos")
end

function UIN19P5AwardItem:OnValue()
  local id = self.award.m_item_id
  local cfg = Cfg.cfg_item[id]
  if not cfg then
    Log.error("###[UIN19P5AwardItem] cfg is nil ! id --> ", id)
  end
  local color = self.color2color[cfg.Color]
  self.Color.sprite = self.atlas:GetSprite(color)
  local icon = cfg.Icon
  self.Icon:LoadImage(icon)
  self:SetIcon()
  if self.hideCount then
    self.hide:SetActive(false)
    local bgSprite = "n19p5_choujiang_di16"
    self.BgImg.sprite = self.atlas:GetSprite(bgSprite)
  else
    self.hide:SetActive(true)
    local lessTime = self.award.m_lottery_count
    if lessTime < 0 then
      lessTime = 0
    end
    self.LessTex:SetText(lessTime)
    self.Mask:SetActive(lessTime == 0)
    local count = self.award.m_count
    self.ItemCount:SetText(count)
    local bgSprite, maskSprite
    if self.award.m_is_big_reward then
      self.BigImg:SetActive(true)
      bgSprite = "n19p5_choujiang_di14"
      maskSprite = "n19p5_choujiang_di17"
    elseif self.award.m_reward_type == ECampaignLRType.E_CLRT_rare then
      self.BigImg:SetActive(false)
      bgSprite = "n19p5_choujiang_di15"
      maskSprite = "n19p5_choujiang_di18"
    else
      self.BigImg:SetActive(false)
      bgSprite = "n19p5_choujiang_di16"
      maskSprite = "n19p5_choujiang_di19"
    end
    self.MaskImg.sprite = self.atlas:GetSprite(maskSprite)
    self.BgImg.sprite = self.atlas:GetSprite(bgSprite)
  end
end

function UIN19P5AwardItem:SetIcon()
  local isHead = false
  if self.award.m_item_id >= 3750000 and self.award.m_item_id <= 3759999 then
    isHead = true
  end
  if isHead then
    local whRate = 1
    if self.award.m_item_id >= 3751000 and self.award.m_item_id <= 3751999 then
      whRate = 0.8421052631578947
    elseif self.award.m_item_id >= 3752000 and self.award.m_item_id <= 3752999 then
      whRate = 0.6388888888888888
    elseif self.award.m_item_id >= 3753000 and self.award.m_item_id <= 3753999 then
      whRate = 0.6388888888888888
    end
    self._iconRect.sizeDelta = Vector2(self._iconRect.sizeDelta.x, self._iconRect.sizeDelta.x * whRate)
  else
    self._iconRect.sizeDelta = self._iconRectDefaultSize
  end
end

function UIN19P5AwardItem:SetData(award, callback, hideCount, anim)
  self.award = award
  self.callback = callback
  self.hideCount = hideCount
  self.anim = anim
  self:OnValue()
  self:Anim()
end

function UIN19P5AwardItem:Anim()
  if self.anim then
    local posx = 2500
    local duration = 0.12
    self.pos.anchoredPosition = Vector2(posx, 0)
    local yieldTime = self.anim * 1000
    if self.event then
      GameGlobal.Timer():CancelEvent(self.event)
    end
    self.event = GameGlobal.Timer():AddEvent(yieldTime, function()
      self.pos:DOAnchorPosX(0, duration)
    end)
  end
end

function UIN19P5AwardItem:OnHide()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
end

function UIN19P5AwardItem:BgOnClick(go)
  if self.callback then
    self.callback(self.award)
  end
end
