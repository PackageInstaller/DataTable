_class("UIHauteCoutureDrawProbabilityItem", UICustomWidget)
UIHauteCoutureDrawProbabilityItem = UIHauteCoutureDrawProbabilityItem

function UIHauteCoutureDrawProbabilityItem:Constructor()
  self._drawTimes = 0
  self._rareLevel = 0
end

function UIHauteCoutureDrawProbabilityItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIHauteCoutureKL.spriteatlas", LoadType.SpriteAtlas)
  self._prizeName = self:GetUIComponent("UILocalizationText", "prizeName")
  self._guangBoObj = self:GetGameObject("guangboIcon")
  self._prizeImg = self:GetUIComponent("RawImageLoader", "prizeImg")
  self._detail = self:GetUIComponent("UILocalizationText", "detail")
  self._bg = self:GetUIComponent("Image", "bg")
  self._nameBg = self:GetUIComponent("RawImage", "nameBg")
  self._count1 = self:GetUIComponent("UILocalizationText", "count1")
  self._count2 = self:GetUIComponent("UILocalizationText", "count2")
  self._detailBg = self:GetUIComponent("Image", "detailBg")
  self._detailNum = self:GetUIComponent("UILocalizationText", "detailNum")
  self._detailTxt = self:GetUIComponent("UILocalizationText", "detailTxt")
end

function UIHauteCoutureDrawProbabilityItem:SetData(prizeData, drawTimes, hasGot, probablity, replace)
  self._prizeName:SetText(StringTable.Get(prizeData.Name))
  if drawTimes then
    self._drawTimes = drawTimes
  end
  if prizeData.RareLevel then
    self._rareLevel = prizeData.RareLevel
  end
  if hasGot then
    self._detail:SetText(StringTable.Get("str_senior_skin_draw_got"))
  elseif self._rareLevel - 1 > self._drawTimes then
    self._detailTxt:SetText(StringTable.Get("str_senior_skin_draw_rule_show_get_probability"))
    self._detailNum:SetText(StringTable.Get("str_senior_skin_draw_rule_probability_5_times", self._rareLevel - 1))
    self._detailBg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di24")
  else
    self._detailNum:SetText(string.format("%.2f", probablity) .. "%")
    self._detailTxt:SetText(StringTable.Get("str_senior_skin_draw_rule_get_probability"))
    self._detailBg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di25")
  end
  local cfg = Cfg.cfg_item[prizeData.RewardID]
  if replace then
    cfg = Cfg.cfg_item[prizeData.ReplaceRewardID]
  end
  if cfg == nil then
    Log.fatal("cfg_item is nil.")
  else
    self._prizeImg:LoadImage(cfg.Icon)
  end
  if replace then
    self._count1:SetText(self:formatCount(prizeData.ReplaceRewardCount))
  else
    self._count1:SetText(self:formatCount(prizeData.RewardCount))
  end
  self._count2:SetText(self:formatCount(prizeData.AppendGlow))
  if prizeData.AppendGlow > 0 then
    self._guangBoObj:SetActive(true)
  else
    self._guangBoObj:SetActive(false)
  end
  self._nameBg.color = Color(1, 1, 1, 1)
  if prizeData.UIType == 1 then
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di15")
  elseif prizeData.UIType == 2 then
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di16")
  elseif prizeData.UIType == 3 then
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di17")
  elseif prizeData.UIType == 4 then
    self._nameBg.color = Color(1, 1, 1, 0)
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di17")
  end
end

function UIHauteCoutureDrawProbabilityItem:formatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
