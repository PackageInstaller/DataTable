_class("UIHauteCoutureDrawRuleItem", UICustomWidget)
UIHauteCoutureDrawRuleItem = UIHauteCoutureDrawRuleItem

function UIHauteCoutureDrawRuleItem:OnShow(uiParams)
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._content = self:GetUIComponent("UILocalizationText", "content")
  self._prizeImg = self:GetUIComponent("RawImageLoader", "prizeImg")
  self._count = self:GetUIComponent("UILocalizationText", "count")
end

function UIHauteCoutureDrawRuleItem:SetImg(img, count)
  self._prizeImg:LoadImage(img)
  if 1 < count then
    self._count.text = "x" .. count
  end
end

function UIHauteCoutureDrawRuleItem:SetProbablity(value)
  self._currentValue = value
end

function UIHauteCoutureDrawRuleItem:SetData(row, col)
  if row == 1 and col == 1 then
    self._content.gameObject:SetActive(false)
    self._prizeImg.gameObject:SetActive(false)
    self._title.gameObject:SetActive(true)
    self._title.text = StringTable.Get("str_senior_skin_draw_rule_round_title")
  elseif row == 1 then
    self._title.text = StringTable.Get("str_senior_skin_draw_rule_round", col - 1)
    self._content.gameObject:SetActive(false)
    self._prizeImg.gameObject:SetActive(false)
    self._title.gameObject:SetActive(true)
  elseif col == 1 then
    self._title.gameObject:SetActive(false)
    self._content.gameObject:SetActive(false)
    self._prizeImg.gameObject:SetActive(true)
  else
    self._content.gameObject:SetActive(false)
    self._prizeImg.gameObject:SetActive(false)
    self._title.gameObject:SetActive(true)
    self._title.text = "0.01%"
  end
end
