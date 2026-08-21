_class("UIHauteCoutureDrawProbabiltyItemBLHReview2", UICustomWidget)
UIHauteCoutureDrawProbabiltyItemBLHReview2 = UIHauteCoutureDrawProbabiltyItemBLHReview2

function UIHauteCoutureDrawProbabiltyItemBLHReview2:Constructor()
  self._drawTimes = 0
  self._rareLevel = 0
  self._atlas = self:GetAsset("UIHauteCoutureBLH.spriteatlas", LoadType.SpriteAtlas)
end

function UIHauteCoutureDrawProbabiltyItemBLHReview2:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawProbabiltyItemBLHReview2:InitWidget()
  self.prizeName = self:GetUIComponent("UILocalizationText", "prizeName")
  self.prize1 = self:GetGameObject("prize1")
  self.prize2 = self:GetGameObject("prize2")
  self.prizeImg1 = self:GetUIComponent("RawImageLoader", "prizeImg1")
  self.prizeImg2 = self:GetUIComponent("RawImageLoader", "prizeImg2")
  self.count1 = self:GetUIComponent("UILocalizationText", "count1")
  self.count2 = self:GetUIComponent("UILocalizationText", "count2")
  self.detailbg = self:GetUIComponent("Image", "detailbg")
  self.detail = self:GetUIComponent("UILocalizationText", "detail")
  self.detailTips = self:GetUIComponent("UILocalizationText", "detailTips")
  self._bg = self:GetUIComponent("Image", "bg")
end

function UIHauteCoutureDrawProbabiltyItemBLHReview2:SetData(prizeData, drawTimes, hasGot, probablity, isreplaced)
  self.prizeName:SetText(StringTable.Get(prizeData.Name))
  if drawTimes then
    self._drawTimes = drawTimes
  end
  if prizeData.RareLevel then
    self._rareLevel = prizeData.RareLevel
  end
  if prizeData.UIType <= 2 then
    self.detailbg.sprite = self._atlas:GetSprite("blhsenior_rule_di11")
    self._bg.sprite = self._atlas:GetSprite("blhsenior_rule_di08")
  elseif prizeData.UIType == 3 then
    self.detailbg.sprite = self._atlas:GetSprite("blhsenior_rule_di12")
    self._bg.sprite = self._atlas:GetSprite("blhsenior_rule_di09")
  elseif prizeData.UIType == 4 then
    self.detailbg.sprite = self._atlas:GetSprite("blhsenior_rule_di13")
    self._bg.sprite = self._atlas:GetSprite("blhsenior_rule_di10")
  end
  if hasGot then
    self.detail:SetText(StringTable.Get("str_senior_skin_draw_got"))
    self.detailTips:SetText(StringTable.Get("str_senior_skin_draw_rule_get_probability"))
  elseif self._rareLevel - 1 > self._drawTimes then
    self.detail:SetText(StringTable.Get("str_senior_skin_draw_rule_probability_5_times_kr", self._rareLevel - self._drawTimes - 1))
    self.detailTips:SetText(StringTable.Get("str_senior_skin_draw_rule_show_get_probability"))
  else
    self.detailTips:SetText(StringTable.Get("str_senior_skin_draw_rule_get_probability"))
    if probablity then
      self.detail:SetText(string.format("%.2f", probablity) .. "%")
    end
  end
  local id, count
  if isreplaced then
    id = prizeData.ReplaceRewardID
    count = prizeData.ReplaceRewardCount
  else
    id = prizeData.RewardID
    count = prizeData.RewardCount
  end
  local cfg = Cfg.cfg_item[id]
  if cfg == nil then
    Log.fatal("cfg_item is nil.")
  else
    self.prizeImg1:LoadImage(cfg.Icon)
  end
  self.count1:SetText(self:FormatCount(count))
  if prizeData.AppendGlow and prizeData.AppendGlow > 0 then
    self.prize2:SetActive(true)
    self.prizeImg2:LoadImage("icon_item_3000003")
    self.count2:SetText(self:FormatCount(prizeData.AppendGlow))
  else
    self.prize2:SetActive(false)
  end
end

function UIHauteCoutureDrawProbabiltyItemBLHReview2:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
