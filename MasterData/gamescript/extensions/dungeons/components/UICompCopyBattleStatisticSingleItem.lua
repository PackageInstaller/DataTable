local UICompCopyBattleStatisticSingleItem, Super = NewViewComponent("UICompCopyBattleStatisticSingleItem")
local Vector2 = CS.UnityEngine.Vector2
local TEXT_NAME_ANCHORED_Y_WITH_LEVEL_LINE = 18
local TEXT_NAME_ANCHORED_Y_NO_LEVEL_LINE = -1.5
local STATISTIC_ROW_FALLBACK_ICON = "UIResources/AtlasSource/UI_Battle_Card/Battle_Card_Buff_016.png"
local BURST_DEFAULT_ICON = "UIResources/AtlasSource/UI_Battle_Card/Battle_Card_Buff_032.png"
local OVERLIMIT_BURST_ICON = "UIResources/AtlasSource/UI_Battle_Card/Battle_Card_Buff_038.png"
local SKILL_CARD_DEFAULT_ICON = "UIResources/AtlasSource/UI_Common_Image/UI_Comon_Icon_AwakerSkill.png"
local STATUS_TYPE_MAP = {status = true, state = true}

function UICompCopyBattleStatisticSingleItem:_GetPlayerDisplayInfo(row)
  local name = CopyBattleStatisticsDataUtils.ResolvePlayerDisplayName(row)
  local level = CopyBattleStatisticsDataUtils.ResolvePlayerDisplayLevel(row)
  local headIcon = CopyBattleStatisticsDataUtils.ResolvePlayerBattleHeadRes(row)
  return name, level, headIcon, false, true
end

function UICompCopyBattleStatisticSingleItem:ctor(uiNode, view, row, mo, parentOwnerRow)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_StatisticsSingleResource(uiNode)
  self._row = row
  self._mo = mo
  self._parentOwnerRow = parentOwnerRow
end

function UICompCopyBattleStatisticSingleItem:OnEnterComponent()
  self:_Refresh()
end

function UICompCopyBattleStatisticSingleItem:Refresh(row, mo, parentOwnerRow)
  self._row = row
  self._mo = mo
  if nil ~= parentOwnerRow then
    self._parentOwnerRow = parentOwnerRow
  end
  self:_Refresh()
end

function UICompCopyBattleStatisticSingleItem:_Refresh()
  local row = self._row
  local ui = self.ui
  if not row or not ui then
    return
  end
  self:LoadAllLangFont(ui.Text_Name)
  if row._isSingleSummary then
    self:_RefreshSingleSummaryPortrait(ui, row)
  else
    self:_RefreshSkillOrStateIcon(ui, row)
  end
  self:_FillBars(ui, row)
end

function UICompCopyBattleStatisticSingleItem:_RefreshSingleSummaryPortrait(ui, row)
  if ui.Image_Assist then
    self:SetActive(ui.Image_Assist, CopyBattleStatisticsDataUtils.IsAssistStatisticRow(row))
  end
  local headIcon
  local showHeadBg = false
  local hideFrame = true
  if CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row) then
    local name, level
    name, level, headIcon, hideFrame, showHeadBg = self:_GetPlayerDisplayInfo(row)
    self:SetText(ui.Text_Name, name or "")
    if ui.Text_Level then
      self:SetText(ui.Text_Level, string.format("Lv.%s", level or 1))
    end
    self:_ApplyTextNameAnchoredOffset(ui, false)
  elseif row.awakerData and row.awakerData.tid then
    local ad = row.awakerData
    self:SetText(ui.Text_Name, LT.Text(AwakerCfgUtils.GetCfgField("Name", ad.tid)))
    if ui.Text_Level then
      self:SetText(ui.Text_Level, string.format("Lv.%s", ad.level or 1))
    end
    self:_ApplyTextNameAnchoredOffset(ui, false)
    headIcon = AwakerDataUtils.GetLittleIcon(ad.tid, nil, ad.curSkin)
    showHeadBg = false
    hideFrame = true
  end
  if ui.Image_Head_Bg then
    self:SetActive(ui.Image_Head_Bg, showHeadBg)
  end
  if CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row) and ui.UI_Common_Head then
    local headUi = UI_Common_HeadResource(ui.UI_Common_Head)
    if headUi.Image_Awaker_Head then
      self:SetImage(headUi.Image_Awaker_Head, headIcon or "")
      headUi.Image_Awaker_Head:SetActive(nil ~= headIcon and "" ~= headIcon)
    end
    if headUi.UI_Common_HeadFrame then
      headUi.UI_Common_HeadFrame:SetActive(not hideFrame)
    end
  elseif ui.UI_Common_Head and headIcon and "" ~= headIcon then
    self:AddViewComponentOnce(ui.UI_Common_Head, CompHeadItem, {headIcon = headIcon, hideFrame = hideFrame})
  elseif ui.Icon_Skill then
    self:ClearImage(ui.Icon_Skill)
    if headIcon and "" ~= headIcon then
      self:SetImage(ui.Icon_Skill, headIcon)
    end
  end
end

function UICompCopyBattleStatisticSingleItem:_RefreshSkillOrStateIcon(ui, row)
  if ui.Image_Assist then
    self:SetActive(ui.Image_Assist, false)
  end
  if ui.Image_Head_Bg then
    self:SetActive(ui.Image_Head_Bg, false)
  end
  self:SetText(ui.Text_Name, self:_GetSingleRowLabel(row))
  local levelStr
  if ui.Text_Level then
    levelStr = self:_GetSkillRowLevelDisplayString(row)
    self:SetText(ui.Text_Level, levelStr or "")
  end
  local hasLevelLine = nil ~= levelStr and "" ~= tostring(levelStr)
  self:_ApplyTextNameAnchoredOffset(ui, not hasLevelLine)
  local iconPath = self:_GetSingleRowIconPath(row)
  if ui.Icon_Skill then
    self:ClearImage(ui.Icon_Skill)
    if iconPath and "" ~= iconPath then
      self:SetImage(ui.Icon_Skill, iconPath)
    end
  end
end

function UICompCopyBattleStatisticSingleItem:_ApplyTextNameAnchoredOffset(ui, noLevelLine)
  if not (ui and ui.Text_Name) or IsNil(ui.Text_Name) then
    return
  end
  local rt = ui.Text_Name.transform
  local pos = rt.anchoredPosition
  local y = noLevelLine and TEXT_NAME_ANCHORED_Y_NO_LEVEL_LINE or TEXT_NAME_ANCHORED_Y_WITH_LEVEL_LINE
  rt.anchoredPosition = Vector2(pos.x, y)
end

function UICompCopyBattleStatisticSingleItem:_GetSingleRowLabel(row)
  do return CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel end
  return CopyBattleStatisticsDataUtils.ResolveSkillRowDisplayLabel, row
end

function UICompCopyBattleStatisticSingleItem:_GetSkillRowLevelDisplayString(row)
  if not row or type(row) ~= "table" then
    return nil
  end
  if self:_IsUtilSkillStatisticRow(row) then
    local parent = self._parentOwnerRow
    local map = parent and parent.skillSlotLevels
    if type(map) == "table" then
      local lv = tonumber(map[CommonDefine.AwakerSkillSlot.Slot_Awake]) or tonumber(map[CommonDefine.AwakerSkillSlot.Slot_Super])
      if lv then
        do return string.format, "Lv.%s" end
        return string.format, "Lv.%s", lv, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
      end
    end
    return nil
  end
  local configId = tonumber(row.defaultOrder)
  local rawStr = row.skillNameRaw and tostring(row.skillNameRaw) or ""
  if (not configId or configId <= 0) and "" ~= rawStr then
    configId = tonumber(string.match(rawStr, ":(%-?%d+)$"))
  end
  local typ = string.lower(tostring(row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  local namePrefix = string.match(rawStr, "^(%a+):")
  local namePrefixLower = namePrefix and string.lower(namePrefix) or ""
  local isStateRow = "status" == typ or "state" == typ or "state" == namePrefixLower and configId and configId > 0
  if isStateRow then
    return nil
  end
  if not configId or configId <= 0 then
    return nil
  end
  local ownerTid = tonumber(row.ownerAwakerTid)
  if not ownerTid or ownerTid <= 0 then
    return nil
  end
  local skillSlot = CopyBattleStatisticsDataUtils.ResolveSkillSlotIndex(ownerTid, configId)
  if not skillSlot or skillSlot <= 0 then
    return nil
  end
  local parent = self._parentOwnerRow
  local map = parent and parent.skillSlotLevels
  if type(map) == "table" then
    local lv = tonumber(map[skillSlot])
    if lv then
      do return string.format, "Lv.%s" end
      return string.format, "Lv.%s", lv, tostring(row.statisticType or "")
    end
  end
  local battleAw = CopyAwakerDataUtils.GetBattleAwakerData(ownerTid)
  local bs = battleAw and battleAw.skills and battleAw.skills[skillSlot]
  local lv2 = bs and tonumber(bs.level or bs.lv)
  if lv2 then
    do return string.format, "Lv.%s" end
    return string.format, "Lv.%s", lv2, tostring(row.statisticType or "")
  end
  local bagAw = AwakerDataUtils.GetAwakerData(ownerTid)
  local gs = bagAw and bagAw.skills and bagAw.skills[skillSlot]
  local lv3 = gs and tonumber(gs.level or gs.lv)
  if lv3 then
    do return string.format, "Lv.%s" end
    return string.format, "Lv.%s", lv3
  end
  return nil
end

function UICompCopyBattleStatisticSingleItem:_IsUtilSkillStatisticRow(row)
  if type(row) ~= "table" then
    return false
  end
  local typ = string.lower(tostring(row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  if "utilskill" == typ then
    return true
  end
  local rawStr = row.skillNameRaw and tostring(row.skillNameRaw) or ""
  local namePrefix = string.match(rawStr, "^(%a+):")
  return namePrefix and string.lower(namePrefix) == "utilskill"
end

function UICompCopyBattleStatisticSingleItem:_GetSingleRowIconPath(row)
  local configId = tonumber(row and row.defaultOrder)
  if (not configId or configId <= 0) and row and row.skillNameRaw then
    configId = tonumber(string.match(tostring(row.skillNameRaw), ":(%-?%d+)$"))
  end
  local typ = string.lower(tostring(row.statisticType or ""))
  typ = string.gsub(typ, "%s+", "")
  if self:_IsUtilSkillStatisticRow(row) then
    local ownerTid = tonumber(row.ownerAwakerTid)
    if ownerTid and ownerTid > 0 then
      local superInfo = AwakerDataUtils.GetSuperUltiSkillInfo(ownerTid)
      if superInfo and superInfo.name and "" ~= superInfo.name then
        return OVERLIMIT_BURST_ICON
      end
    end
    return BURST_DEFAULT_ICON
  end
  if STATUS_TYPE_MAP[typ] then
    local stateIcon = ""
    if configId and configId > 0 then
      stateIcon = StateCfgUtils.GetCfgField("Icon", configId) or ""
      if "" == stateIcon then
        stateIcon = StateCfgUtils.GetCfgField("SmallIcon", configId) or ""
      end
      if "" == stateIcon then
        stateIcon = StateCfgUtils.GetCfgField("StateIcon", configId) or ""
      end
    end
    if stateIcon and "" ~= stateIcon then
      return bc.ICON_PATH_PERFIX .. stateIcon
    end
    return STATISTIC_ROW_FALLBACK_ICON
  end
  local ownerAwakerTid = tonumber(row and row.ownerAwakerTid)
  local skillSlot
  if ownerAwakerTid and ownerAwakerTid > 0 and configId and configId > 0 then
    skillSlot = CopyBattleStatisticsDataUtils.ResolveSkillSlotIndex(ownerAwakerTid, configId)
  end
  if skillSlot == CommonDefine.AwakerSkillSlot.Slot_Super or skillSlot == CommonDefine.AwakerSkillSlot.Slot_Awake then
    return BURST_DEFAULT_ICON
  end
  return SKILL_CARD_DEFAULT_ICON
end

function UICompCopyBattleStatisticSingleItem:_GetSingleMetricBarMax(parentRow, metricSummary, maxDmg, maxHeal, maxShield)
  local cap = parentRow._skillBarsMaxFromDisplayList
  local capDmg = type(cap) == "table" and tonumber(cap.damage) or nil
  local capHeal = type(cap) == "table" and tonumber(cap.heal) or nil
  local capShield = type(cap) == "table" and tonumber(cap.shield) or nil
  local maxSummary = metricSummary and metricSummary.max or {}
  local md = tonumber(maxSummary.damage) or 0
  local mh = tonumber(maxSummary.heal) or 0
  local ms = tonumber(maxSummary.shield) or 0
  if capDmg and capDmg > 0 then
    maxDmg = capDmg
  elseif md > 0 then
    maxDmg = md
  end
  if capHeal and capHeal > 0 then
    maxHeal = capHeal
  elseif mh > 0 then
    maxHeal = mh
  end
  if capShield and capShield > 0 then
    maxShield = capShield
  elseif ms > 0 then
    maxShield = ms
  end
  return maxDmg, maxHeal, maxShield
end

function UICompCopyBattleStatisticSingleItem:_FillBars(ui, row)
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
  if not row._isSingleSummary and self._parentOwnerRow then
    local pr = self._parentOwnerRow
    local metricSummary = CopyBattleStatisticsDataUtils.GetSkillRowsMetricSummary(pr)
    local sumSummary = metricSummary.sum or {}
    if (tonumber(sumSummary.damage) or 0) > 0 then
      totalDmg = sumSummary.damage
    elseif (pr.damage or 0) > 0 then
      totalDmg = pr.damage
    end
    if (tonumber(sumSummary.heal) or 0) > 0 then
      totalHeal = sumSummary.heal
    elseif (pr.heal or 0) > 0 then
      totalHeal = pr.heal
    end
    if (tonumber(sumSummary.shield) or 0) > 0 then
      totalShield = sumSummary.shield
    elseif (pr.shield or 0) > 0 then
      totalShield = pr.shield
    end
    maxDmg, maxHeal, maxShield = self:_GetSingleMetricBarMax(pr, metricSummary, maxDmg, maxHeal, maxShield)
  end
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

return UICompCopyBattleStatisticSingleItem
