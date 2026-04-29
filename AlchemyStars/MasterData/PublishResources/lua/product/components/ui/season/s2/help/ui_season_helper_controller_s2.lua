_class("UISeasonHelperControllerS2", UIController)
UISeasonHelperControllerS2 = UISeasonHelperControllerS2

function UISeasonHelperControllerS2:OnShow(uiParams)
  local tabIndex = 1
  if uiParams and uiParams[1] then
    tabIndex = tonumber(uiParams[1])
  end
  self:InitWidget(tabIndex)
  self:AddListener()
end

function UISeasonHelperControllerS2:OnHide()
end

function UISeasonHelperControllerS2:InitWidget(tabIndex)
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self._tabPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self:_InitTabList(tabIndex)
  self:_InitBanner(tabIndex)
  self._curTab = 1
  if tabIndex then
    self._curTab = tabIndex
  end
end

function UISeasonHelperControllerS2:AddListener()
end

function UISeasonHelperControllerS2:_InitBanner(tabIndex)
  local bannerGen = self:GetUIComponent("UISelectObjectPath", "BannerRoot")
  self._bannerWidget = bannerGen:SpawnObject("UISeasonHelperBannerS2")
  self._bannerWidget:SetData(tabIndex)
end

function UISeasonHelperControllerS2:OnUpdate(deltaTimeMS)
  if self._bannerWidget then
    self._bannerWidget:OnUpdate(deltaTimeMS)
  end
end

function UISeasonHelperControllerS2:_InitTabList(tabIndex)
  self._cfgTab = Cfg.cfg_season_helper_tab({
    SeasonID = UISeasonID.S2
  })
  table.sort(self._cfgTab, function(a, b)
    return a.TabEnum < b.TabEnum
  end)
  local tabCount = #self._cfgTab
  self._tabPool:SpawnObjects("UISeasonHelperTabS2", tabCount)
  self._tabs = self._tabPool:GetAllSpawnList()
  for i, v in ipairs(self._cfgTab) do
    self._tabs[i]:SetData(v, function(tabId)
      self:OnTabClick(tabId)
    end)
  end
  for index, tab in ipairs(self._tabs) do
    tab:OnSelectIndex(tabIndex)
  end
end

function UISeasonHelperControllerS2:OnTabClick(tabId)
  if self._curTab ~= tabId then
    self._curTab = tabId
    self._bannerWidget:SetData(tabId)
    for index, tab in ipairs(self._tabs) do
      tab:OnSelectIndex(tabId)
    end
  end
end
