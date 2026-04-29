_class("UISeasonMazeCollage", UIController)
UISeasonMazeCollage = UISeasonMazeCollage

function UISeasonMazeCollage:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
  self._collageDagaMgr = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeCollageDataMgr()
  local mazeComponent = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeComponent()
  local mazeComponentInfo = mazeComponent:GetComponentInfo()
  self._collageDagaMgr:Refresh(mazeComponentInfo.save_info.lv)
end

function UISeasonMazeCollage:OnShow(uiParams)
  local defaultTab = uiParams[1]
  self:InitWidget()
  self:InitTabsAndContents(defaultTab)
end

function UISeasonMazeCollage:InitTabsAndContents(defaultTab)
  self._tabCfgs = {
    [1] = {
      name = "str_season_maze_bag_relic_title",
      contentPool = "relic",
      contentScript = "UISeasonMazeCollageContentRelic",
      type = SeasonMazeCollageType.Relic
    },
    [2] = {
      name = "str_season_maze_bag_active_card_title",
      contentPool = "card",
      contentScript = "UISeasonMazeCollageContentCard",
      type = SeasonMazeCollageType.Card
    },
    [3] = {
      name = "str_season_maze_room_flea_bead",
      contentPool = "bead",
      contentScript = "UISeasonMazeCollageContentBead",
      type = SeasonMazeCollageType.Bead
    },
    [4] = {
      name = "str_season_maze_once_item_info_title",
      contentPool = "prop",
      contentScript = "UISeasonMazeCollageContentProp",
      type = SeasonMazeCollageType.Prop
    }
  }
  self.tabsWidget = self.tabsPool:SpawnObjects("UISeasonMazeCollageTab", #self._tabCfgs)
  for i, widget in ipairs(self.tabsWidget) do
    widget:SetData(i, self._tabCfgs[i].name, function(index)
      self:OnTabSelect(index)
    end)
  end
  defaultTab = defaultTab or 1
  for i, widget in ipairs(self.tabsWidget) do
    widget:SetSelect(defaultTab == i)
  end
  self.contentsWidget = {}
  for i, cfg in ipairs(self._tabCfgs) do
    local pool = self:GetUIComponent("UISelectObjectPath", cfg.contentPool)
    local widget = pool:SpawnObject(cfg.contentScript)
    widget:OnInit(function(itemID, pos, type)
      self:OnItemClick(itemID, pos, type)
    end)
    self.contentsWidget[i] = widget
  end
  self:OnTabSelect(defaultTab)
end

function UISeasonMazeCollage:OnItemClick(itemID, pos, type)
  self:_RefreshTabRedpoint()
  if type == SeasonMazeCollageType.Bead then
    local cfg = Cfg.cfg_component_season_maze_autobead[itemID]
    if cfg then
      self._beadTips:SetData(StringTable.Get(cfg.Name), StringTable.Get(cfg.Desc))
    end
    self.beadSelectInfo:SetCustomPos(pos)
  elseif type == SeasonMazeCollageType.Prop then
    local cfg = Cfg.cfg_component_season_maze_once[itemID]
    if cfg then
      self._beadTips:SetData(StringTable.Get(cfg.Name), StringTable.Get(cfg.Desc))
    end
    self.beadSelectInfo:SetCustomPos(pos)
  elseif type == SeasonMazeCollageType.Relic then
    local hasSuite = self._relicTips:SetData(itemID)
    if hasSuite then
      local size = Vector2(860, 590)
      self.relicSelectInfo:SetCustomPos(pos, size)
    else
      local size = Vector2(860, 300)
      self.relicSelectInfo:SetCustomPos(pos, size)
    end
  elseif type == SeasonMazeCollageType.Card then
    self._cardTips:SetData(itemID)
    self.cardSelectInfo:SetCustomPos(pos)
  end
end

function UISeasonMazeCollage:_RefreshTabRedpoint()
  for i, widget in ipairs(self.tabsWidget) do
    local cfg = self._tabCfgs[i]
    local type = cfg.type
    local hasRed = self._collageDagaMgr:HasNewCollageByType(type)
    widget:SetRed(hasRed)
  end
end

function UISeasonMazeCollage:OnTabSelect(index, forceUpdate)
  if self._curIndex == index and not forceUpdate then
    return
  end
  self._curIndex = index
  for i, widget in ipairs(self.tabsWidget) do
    widget:SetSelect(self._curIndex == i)
  end
  if self._lastContent then
    self._lastContent:OnExit()
  end
  self._lastContent = self.contentsWidget[self._curIndex]
  self._lastContent:OnEnter()
  self:_RefreshTabRedpoint()
end

function UISeasonMazeCollage:InitWidget()
  self.tabsPool = self:GetUIComponent("UISelectObjectPath", "tabs")
  local beadPool = self:GetUIComponent("UISelectObjectPath", "beadTips")
  self.beadSelectInfo = beadPool:SpawnObject("UISelectInfo")
  local size = Vector2(480, 100)
  self._beadTips = self.beadSelectInfo:CreateCustom("UISeasonMazeCollageBeadTips.prefab", "UISeasonMazeCollageBeadTips", size)
  local relicPool = self:GetUIComponent("UISelectObjectPath", "relicTips")
  self.relicSelectInfo = relicPool:SpawnObject("UISelectInfo")
  local size = Vector2(860, 582)
  self._relicTips = self.relicSelectInfo:CreateCustom("UISeasonMazeCollageRelicTips.prefab", "UISeasonMazeCollageRelicTips", size)
  local cardPool = self:GetUIComponent("UISelectObjectPath", "cardTips")
  self.cardSelectInfo = cardPool:SpawnObject("UISelectInfo")
  local size = Vector2(480, 430)
  self._cardTips = self.cardSelectInfo:CreateCustom("UISeasonMazeCollageCardTips.prefab", "UISeasonMazeCollageCardTips", size)
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UISMazeCommonTopButton")
  self.backBtns:SetData(function()
    if self._lastContent then
      self._lastContent:ClearNew()
    end
    local uiController = GameGlobal.UIStateManager():GetController("UISeasonMazeEnterController")
    if uiController then
      uiController:RefershBtnsNew()
    end
    self:CloseDialog()
  end, function()
    local pageIdx = self._curIndex + 1
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp6, pageIdx)
  end, function()
    if self._lastContent then
      self._lastContent:ClearNew()
    end
    UICommonHelper:GetInstance():SwitchToUIMain()
  end, nil, nil, nil, nil, nil)
end
