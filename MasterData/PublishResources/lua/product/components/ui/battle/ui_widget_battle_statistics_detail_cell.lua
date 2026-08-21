_class("UIWidgetBattleStatisticsDetailCell", UICustomWidget)
UIWidgetBattleStatisticsDetailCell = UIWidgetBattleStatisticsDetailCell

function UIWidgetBattleStatisticsDetailCell:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetBattleStatisticsDetailCell:InitWidget()
  self._headIconLoader = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self._damageBarBaseRect1 = self:GetUIComponent("RectTransform", "DamageBarBase1")
  self._damageBarBaseRect2 = self:GetUIComponent("RectTransform", "DamageBarBase2")
  self._damageBarBaseRect3 = self:GetUIComponent("RectTransform", "DamageBarBase3")
  self._damageBarBaseRect4 = self:GetUIComponent("RectTransform", "DamageBarBase4")
  self._damageBarBaseRectList = {}
  table.insert(self._damageBarBaseRectList, self._damageBarBaseRect1)
  table.insert(self._damageBarBaseRectList, self._damageBarBaseRect2)
  table.insert(self._damageBarBaseRectList, self._damageBarBaseRect3)
  table.insert(self._damageBarBaseRectList, self._damageBarBaseRect4)
  self._maxBarLength = self._damageBarBaseRect1.sizeDelta.x
  self._minBarLength = 10
  self._barHeight = self._damageBarBaseRect1.sizeDelta.y
  self._infoText1 = self:GetUIComponent("UILocalizationText", "InfoText1")
  self._infoText2 = self:GetUIComponent("UILocalizationText", "InfoText2")
  self._infoText3 = self:GetUIComponent("UILocalizationText", "InfoText3")
  self._infoText4 = self:GetUIComponent("UILocalizationText", "InfoText4")
  self._infoTextList = {}
  table.insert(self._infoTextList, self._infoText1)
  table.insert(self._infoTextList, self._infoText2)
  table.insert(self._infoTextList, self._infoText3)
  table.insert(self._infoTextList, self._infoText4)
end

function UIWidgetBattleStatisticsDetailCell:SetData(data)
  self._uiData = data
  self:RefreshUI()
end

function UIWidgetBattleStatisticsDetailCell:RefreshUI()
  local recordData = self._uiData:GetRecordData()
  local petData = self._uiData:GetMatchPet()
  if petData then
    self._headIconLoader:LoadImage(petData:GetPetHead(PetSkinEffectPath.HEAD_ICON_INGAME))
  end
  local normalDamage = recordData:GetPetNormalDamageValue()
  local chainDamage = recordData:GetPetChainDamageValue()
  local activeDamage = recordData:GetPetActiveDamageValue()
  local buffDamage = recordData:GetPetBuffDamageValue()
  local damageList = {}
  table.insert(damageList, normalDamage)
  table.insert(damageList, chainDamage)
  table.insert(damageList, activeDamage)
  table.insert(damageList, buffDamage)
  local maxDetailDamage = self._uiData:GetMaxDetailDamage()
  for index, damage in ipairs(damageList) do
    self:SetBarInfo(self._damageBarBaseRectList[index], self._infoTextList[index], maxDetailDamage, damage)
  end
end

function UIWidgetBattleStatisticsDetailCell:FormatDamage(damageValue)
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

function UIWidgetBattleStatisticsDetailCell:SetBarInfo(rect, text, maxDetailDamage, curDamage)
  local damageValueStr = self:FormatDamage(curDamage)
  local infoStr = damageValueStr
  text:SetText(infoStr)
  if 0 < maxDetailDamage then
    local barLength = curDamage / maxDetailDamage * self._maxBarLength
    if barLength < self._minBarLength then
      barLength = self._minBarLength
    end
    self:PlayAnim(rect, text, barLength, curDamage)
  else
    rect.sizeDelta = Vector2(self._minBarLength, self._barHeight)
  end
end

function UIWidgetBattleStatisticsDetailCell:PlayAnim(rect, text, targetBarLength, tarDamage)
  local barStartVal = self._minBarLength
  local barTargetVal = targetBarLength
  local duration = 1
  DoTweenHelper.DoUpdateFloat(barStartVal, barTargetVal, duration, function(val)
    rect.sizeDelta = Vector2(val, self._barHeight)
  end)
  local damageStartVal = 0
  local damageTargetVal = tarDamage
  DoTweenHelper.DoUpdateInt(damageStartVal, damageTargetVal, duration, function(val)
    local damageValueStr = self:FormatDamage(val)
    text:SetText(damageValueStr)
  end)
end
