_class("UIHauteCoutureDrawProbabiltyItem", UICustomWidget)
UIHauteCoutureDrawProbabiltyItem = UIHauteCoutureDrawProbabiltyItem

function UIHauteCoutureDrawProbabiltyItem:Constructor()
  self._drawTimes = 0
  self._rareLevel = 0
end

function UIHauteCoutureDrawProbabiltyItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIHauteCotureDraw.spriteatlas", LoadType.SpriteAtlas)
  self._prizeName = self:GetUIComponent("UILocalizationText", "prizeName")
  self._guangBoObj = self:GetGameObject("guangboIcon")
  self._prizeImg = self:GetUIComponent("RawImageLoader", "prizeImg")
  self._detail = self:GetUIComponent("UILocalizationText", "detail")
  self._bg = self:GetUIComponent("Image", "bg")
  self._nameBg = self:GetUIComponent("RawImage", "nameBg")
end

function UIHauteCoutureDrawProbabiltyItem:SetData(prizeData, drawTimes, hasGot, probablity)
  self._prizeName.text = StringTable.Get("str_senior_skin_draw_prize_name", prizeData.ID)
  if drawTimes then
    self._drawTimes = drawTimes
  end
  if prizeData.RareLevel then
    self._rareLevel = prizeData.RareLevel
  end
  if hasGot then
    self._detail.text = StringTable.Get("str_senior_skin_draw_got")
  elseif self._rareLevel > self._drawTimes then
    self._detail.text = StringTable.Get("str_senior_skin_draw_left_times", self._rareLevel - self._drawTimes)
  else
    self._detail.text = StringTable.Get("str_senior_skin_draw_probablity", string.format("%.2f", probablity))
  end
  local cfg = Cfg.cfg_item[prizeData.RewardID]
  if cfg == nil then
    Log.fatal("cfg_item is nil.")
  else
    self._prizeImg:LoadImage(cfg.Icon)
  end
  if prizeData.AppendGlow > 0 then
    self._guangBoObj:SetActive(true)
  else
    self._guangBoObj:SetActive(false)
  end
  self._nameBg.color = Color(1, 1, 1, 1)
  if prizeData.UIType == 1 then
    self._bg.sprite = self._atlas:GetSprite("senior_rule_di10")
  elseif prizeData.UIType == 2 then
    self._bg.sprite = self._atlas:GetSprite("senior_rule_di11")
  elseif prizeData.UIType == 3 then
    self._bg.sprite = self._atlas:GetSprite("senior_rule_di12")
  elseif prizeData.UIType == 4 then
    self._nameBg.color = Color(1, 1, 1, 0)
    self._bg.sprite = self._atlas:GetSprite("senior_rule_di06")
  end
end
