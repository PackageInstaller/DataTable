_class("UIHauteCoutureDrawProbabiltyItemPLM", UICustomWidget)
UIHauteCoutureDrawProbabiltyItemPLM = UIHauteCoutureDrawProbabiltyItemPLM

function UIHauteCoutureDrawProbabiltyItemPLM:Constructor()
  self._drawTimes = 0
  self._rareLevel = 0
  self._atlas = self:GetAsset("UIHauteCoutureGL.spriteatlas", LoadType.SpriteAtlas)
  self._atlas2 = self:GetAsset("UIHauteCoutureDrawPLM.spriteatlas", LoadType.SpriteAtlas)
end

function UIHauteCoutureDrawProbabiltyItemPLM:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawProbabiltyItemPLM:InitWidget()
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
  self.bg = self:GetUIComponent("Image", "bg")
end

function UIHauteCoutureDrawProbabiltyItemPLM:SetData(prizeData, drawTimes, hasGot, probablity, isreplaced)
  self.prizeName:SetText(StringTable.Get(prizeData.Name))
  if drawTimes then
    self._drawTimes = drawTimes
  end
  if prizeData.RareLevel then
    self._rareLevel = prizeData.RareLevel
  end
  if prizeData.UIType == 1 then
    self.bg.sprite = self._atlas2:GetSprite("plmsenior_rule_di03")
  elseif prizeData.UIType == 2 then
    self.bg.sprite = self._atlas2:GetSprite("plmsenior_rule_di07")
  else
    self.bg.sprite = self._atlas2:GetSprite("plmsenior_rule_di04")
  end
  if hasGot then
    self.detail:SetText(StringTable.Get("str_senior_skin_draw_got"))
    self.detailTips:SetText(StringTable.Get("str_senior_skin_draw_rule_get_probability"))
    self.detailbg.sprite = self._atlas:GetSprite("glsenior_rule_di09")
  elseif self._rareLevel - 1 > self._drawTimes then
    self.detail:SetText(StringTable.Get("str_senior_skin_draw_rule_probability_5_times", self._rareLevel - self._drawTimes - 1))
    self.detailTips:SetText(StringTable.Get("str_senior_skin_draw_rule_show_get_probability"))
    self.detailbg.sprite = self._atlas:GetSprite("glsenior_rule_di03")
  else
    self.detailTips:SetText(StringTable.Get("str_senior_skin_draw_rule_get_probability"))
    self.detailbg.sprite = self._atlas:GetSprite("glsenior_rule_di04")
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
    Log.fatal("cfg_item is nil:", id)
  else
    self.prizeImg1:LoadImage(cfg.Icon)
  end
  self.count1:SetText(self:FormatCount(count))
  if prizeData.AppendGlow and prizeData.AppendGlow > 0 then
    self.prize2:SetActive(true)
    self.prizeImg2:LoadImage(Cfg.cfg_item[RoleAssetID.RoleAssetGlow].Icon)
    self.count2:SetText(self:FormatCount(prizeData.AppendGlow))
  else
    self.prize2:SetActive(false)
  end
end

function UIHauteCoutureDrawProbabiltyItemPLM:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
