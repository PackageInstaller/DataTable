_class("UIWidgetBattleStatisticsTotalCell", UICustomWidget)
UIWidgetBattleStatisticsTotalCell = UIWidgetBattleStatisticsTotalCell

function UIWidgetBattleStatisticsTotalCell:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetBattleStatisticsTotalCell:InitWidget()
  self._petIconAreaGo = self:GetGameObject("PetIconArea")
  self._specialIconAreaGo = self:GetGameObject("SpecialIconArea")
  self._headIconLoader = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self._infoText = self:GetUIComponent("UILocalizationText", "InfoText")
  self._infoText1 = self:GetUIComponent("UILocalizationText", "InfoText1")
  self._damageBarBaseRect = self:GetUIComponent("RectTransform", "DamageBarBase")
  self._maxBarLength = self._damageBarBaseRect.sizeDelta.x
  self._minBarLength = 10
  self._barHeight = self._damageBarBaseRect.sizeDelta.y
end

function UIWidgetBattleStatisticsTotalCell:SetData(data)
  self._uiData = data
  self:RefreshUI()
end

function UIWidgetBattleStatisticsTotalCell:RefreshUI()
  local recordData = self._uiData:GetRecordData()
  local petData = self._uiData:GetMatchPet()
  if petData then
    self._petIconAreaGo:SetActive(true)
    self._specialIconAreaGo:SetActive(false)
    self._headIconLoader:LoadImage(petData:GetPetHead(PetSkinEffectPath.HEAD_ICON_INGAME))
  else
    self._petIconAreaGo:SetActive(false)
    self._specialIconAreaGo:SetActive(true)
  end
  local allDamageValue = recordData:GetAllDamageValue()
  self._targetDamageValue = allDamageValue
  local percentage = recordData:GetPercentageInt()
  local damageValueStr = self:FormatDamage(allDamageValue)
  local infoStr = damageValueStr
  local infoStr1 = string.format("(%d%%)", percentage)
  self._infoText:SetText(infoStr)
  if self._infoText1 then
    self._infoText1:SetText(infoStr1)
  end
  self._targetBarLength = self._minBarLength
  local needPlayAnim = false
  local maxDamage = self._uiData:GetMaxTotalDamage()
  if 0 < maxDamage then
    local barLength = allDamageValue / maxDamage * self._maxBarLength
    if barLength < self._minBarLength then
      barLength = self._minBarLength
    end
    self._targetBarLength = barLength
    needPlayAnim = true
    self._damageBarBaseRect.sizeDelta = Vector2(self._minBarLength, self._barHeight)
  else
    self._targetBarLength = self._minBarLength
    needPlayAnim = true
    self._damageBarBaseRect.sizeDelta = Vector2(self._minBarLength, self._barHeight)
  end
  if needPlayAnim then
    self:PlayAnim()
  end
end

function UIWidgetBattleStatisticsTotalCell:FormatDamage(damageValue)
  local count = damageValue
  if 10000000 <= count then
    local c = math.modf(count / 100000)
    local str = tostring(c * 0.1) .. "M"
    return str
  elseif 10000 <= count then
    local c = math.modf(count / 100)
    local str = tostring(c * 0.1) .. "K"
    return str
  else
    return tostring(count)
  end
end

function UIWidgetBattleStatisticsTotalCell:PlayAnim()
  local barStartVal = self._minBarLength
  local barTargetVal = self._targetBarLength
  local duration = 1
  DoTweenHelper.DoUpdateFloat(barStartVal, barTargetVal, duration, function(val)
    self._damageBarBaseRect.sizeDelta = Vector2(val, self._barHeight)
  end)
  local damageStartVal = 0
  local damageTargetVal = self._targetDamageValue
  DoTweenHelper.DoUpdateInt(damageStartVal, damageTargetVal, duration, function(val)
    local damageValueStr = self:FormatDamage(val)
    self._infoText:SetText(damageValueStr)
  end)
  local percentAlphaStart = 0
  local baseAlphaVal = 500
  local percentAlphaTarget = 255 + baseAlphaVal
  DoTweenHelper.DoUpdateInt(percentAlphaStart, percentAlphaTarget, duration, function(val)
    local alphaVal = val
    if val > baseAlphaVal then
      alphaVal = alphaVal - baseAlphaVal
    else
      alphaVal = 0
    end
    local alpha = alphaVal / 255
    self._infoText1.color = Color(1, 1, 1, alpha)
  end)
end
