local UICompCopyBattleStatisticAwakerItem, Super = NewViewComponent("UICompCopyBattleStatisticAwakerItem")

function UICompCopyBattleStatisticAwakerItem:_GetPlayerDisplayInfo(row)
  local name = CopyBattleStatisticsDataUtils.ResolvePlayerDisplayName(row)
  local level = CopyBattleStatisticsDataUtils.ResolvePlayerDisplayLevel(row)
  local headIcon = CopyBattleStatisticsDataUtils.ResolvePlayerBattleHeadRes(row)
  return name, level, headIcon, false, true
end

function UICompCopyBattleStatisticAwakerItem:_SetPlayerHeadIcon(ui, headIcon, hideFrame)
  if not ui.UI_Common_Head then
    return
  end
  local headUi = UI_Common_HeadResource(ui.UI_Common_Head)
  if headUi.Image_Awaker_Head then
    self:SetImage(headUi.Image_Awaker_Head, headIcon or "")
    headUi.Image_Awaker_Head:SetActive(nil ~= headIcon and "" ~= headIcon)
  end
  if headUi.UI_Common_HeadFrame then
    headUi.UI_Common_HeadFrame:SetActive(not hideFrame)
  end
end

function UICompCopyBattleStatisticAwakerItem:ctor(uiNode, view, row, mo)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_BattleStatisticsResource(uiNode)
  self._row = row
  self._mo = mo
end

function UICompCopyBattleStatisticAwakerItem:OnEnterComponent()
  self:_Refresh()
end

function UICompCopyBattleStatisticAwakerItem:Refresh(row, mo)
  self._row = row
  self._mo = mo
  self:_Refresh()
end

function UICompCopyBattleStatisticAwakerItem:_Refresh()
  local row = self._row
  local ui = self.ui
  if not row or not ui then
    return
  end
  self:LoadAllLangFont(ui.Text_Name)
  if ui.Image_Assist then
    self:SetActive(ui.Image_Assist, CopyBattleStatisticsDataUtils.IsAssistStatisticRow(row))
  end
  local name, level, headIcon, hideFrame, showBg
  if CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row) then
    name, level, headIcon, hideFrame, showBg = self:_GetPlayerDisplayInfo(row)
  elseif row.awakerData and row.awakerData.tid then
    local ad = row.awakerData
    name = LT.Text(AwakerCfgUtils.GetCfgField("Name", ad.tid))
    level = ad.level or 1
    headIcon = AwakerDataUtils.GetLittleIcon(ad.tid, nil, ad.curSkin)
    hideFrame = true
    showBg = false
  end
  if name then
    self:SetText(ui.Text_Name, name)
    self:SetText(ui.Text_Level, string.format("Lv.%s", level))
    if CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row) then
      self:_SetPlayerHeadIcon(ui, headIcon, hideFrame)
    elseif ui.UI_Common_Head and headIcon and "" ~= headIcon then
      self:AddViewComponentOnce(ui.UI_Common_Head, CompHeadItem, {headIcon = headIcon, hideFrame = hideFrame})
    end
    if ui.Image_Bg then
      self:SetActive(ui.Image_Bg, showBg)
    end
  end
  self:_FillBars(ui, row)
end

function UICompCopyBattleStatisticAwakerItem:_FillBars(ui, row)
  local mo = self._mo
  if not mo then
    return
  end
  local damage = row.damage or 0
  local heal = row.heal or 0
  local shield = row.shield or 0
  local maxDmg = mo:GetMaxDamage()
  local maxHeal = mo:GetMaxHeal()
  local maxShield = mo:GetMaxShield()
  local totalDmg = mo:GetTotalDamage()
  local totalHeal = mo:GetTotalHeal()
  local totalShield = mo:GetTotalShield()
  self:SetText(ui.Text_Damage, math.floor(damage))
  self:SetText(ui.Text_Heal, math.floor(heal))
  self:SetText(ui.Text_Shield, math.floor(shield))
  self:SetImageFillAmount(ui.Image_Damage, mo:GetBarNormalizedByPercentCeil(damage, maxDmg))
  self:SetImageFillAmount(ui.Image_Heal, mo:GetBarNormalizedByPercentCeil(heal, maxHeal))
  self:SetImageFillAmount(ui.Image_Shield, mo:GetBarNormalizedByPercentCeil(shield, maxShield))
  self:SetText(ui.Text_DamageRate, CopyBattleStatisticsDataUtils.FormatSharePercent(damage, totalDmg))
  self:SetText(ui.Text_HealRate, CopyBattleStatisticsDataUtils.FormatSharePercent(heal, totalHeal))
  self:SetText(ui.Text_ShieldRate, CopyBattleStatisticsDataUtils.FormatSharePercent(shield, totalShield))
end

return UICompCopyBattleStatisticAwakerItem
