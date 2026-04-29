_class("UISeasonMazeCollageRelicTips", UICustomWidget)
UISeasonMazeCollageRelicTips = UISeasonMazeCollageRelicTips

function UISeasonMazeCollageRelicTips:OnShow()
  self:InitWidgets()
  self.my_relics = {}
  self.uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
end

function UISeasonMazeCollageRelicTips:InitWidgets()
  self._DescTitleText = self:GetUIComponent("UILocalizationText", "DescTitleText")
  self._DescText = self:GetUIComponent("UILocalizedTMP", "DescText")
  
  function self._DescText.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISeasonMaze_RelicHrefInfo", hrefName)
  end
  
  self._CustomSuitTips = self:GetUIComponent("UILocalizationText", "CustomSuitTips")
  self._SuitAreaGo = self:GetGameObject("SuitArea")
  self._SuitAreaGo:SetActive(false)
  self._CustomSuitTitle = self:GetUIComponent("UILocalizationText", "CustomSuitTitle")
  self._contentScrollRect = self:GetUIComponent("ScrollRect", "ContentScroll")
  self._suitScrollRect = self:GetUIComponent("ScrollRect", "SuitScroll")
end

function UISeasonMazeCollageRelicTips:SetData(itemId)
  local cfg = Cfg.cfg_item[itemId]
  if cfg then
    self._DescText:SetText(StringTable.Get(cfg.RpIntro))
  else
    Log.fatal("###error -->UISeasonMazeCollageRelicTips - the cfg_item is nil ! id --> ", itemId)
  end
  self.my_relics = {}
  local mazList = self.uiSeasonMazeModule:GetSeasonMazeRelics()
  for k, v in pairs(mazList) do
    table.insert(self.my_relics, k)
  end
  self._contentScrollRect.verticalNormalizedPosition = 1
  self._suitScrollRect.verticalNormalizedPosition = 1
  return self:CheckSuitArea(itemId)
end

function UISeasonMazeCollageRelicTips:CheckSuitArea(itemId)
  local cfg_prof = Cfg.cfg_item_relic[itemId]
  if cfg_prof.SuiteID == nil or cfg_prof.SuiteID == 0 then
    self._SuitAreaGo:SetActive(false)
  else
    self:RefreshSuit(cfg_prof.SuiteID)
    return true
  end
end

function UISeasonMazeCollageRelicTips:RefreshSuit(suiteID)
  self._SuitAreaGo:SetActive(true)
  local curSuitCount = 0
  local suite_cfg = Cfg.cfg_component_season_maze_suit[suiteID]
  if suite_cfg == nil then
    self._SuitAreaGo:SetActive(false)
    return
  end
  local suits = suite_cfg.RelicList
  for i = 1, #suits do
    local id = suits[i]
    if table.icontains(self.my_relics, id) then
      curSuitCount = curSuitCount + 1
    end
  end
  local suitPercent = "" .. curSuitCount .. "/" .. #suits
  self._CustomSuitTitle:SetText(StringTable.Get(suite_cfg.Name) .. "  (" .. suitPercent .. ")")
  local tips = ""
  for j = 1, #suite_cfg.Words do
    local tip = suite_cfg.Words[j]
    tips = tips .. StringTable.Get(tip) .. "\n"
  end
  self._CustomSuitTips:SetText(tips)
end
