_class("UIS5HelperController", UIController)
UIS5HelperController = UIS5HelperController

function UIS5HelperController:OnShow(uiParams)
  local tabIndex = 1
  if uiParams and uiParams[1] then
    tabIndex = tonumber(uiParams[1])
  end
  self:InitWidget(tabIndex)
  self:AddListener()
end

function UIS5HelperController:OnHide()
end

function UIS5HelperController:InitWidget(tabIndex)
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

function UIS5HelperController:AddListener()
end

function UIS5HelperController:_InitBanner(tabIndex)
  local bannerGen = self:GetUIComponent("UISelectObjectPath", "BannerRoot")
  self._bannerWidget = bannerGen:SpawnObject("UIS5HelperBanner")
  self._bannerWidget:SetData(tabIndex)
end

function UIS5HelperController:OnUpdate(deltaTimeMS)
  if self._bannerWidget then
    self._bannerWidget:OnUpdate(deltaTimeMS)
  end
end

function UIS5HelperController:_InitTabList(tabIndex)
  self._cfgTab = Cfg.cfg_season_helper_tab({
    SeasonID = UISeasonID.S5
  })
  local validCfg = {}
  local loginModule = GameGlobal.GetModule(LoginModule)
  local now = GetSvrTimeNow()
  for _, cfg in ipairs(self._cfgTab) do
    if cfg.OpenTime then
      local t = loginModule:GetTimeStampByTimeStr(cfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if now >= t then
        validCfg[#validCfg + 1] = cfg
      end
    else
      validCfg[#validCfg + 1] = cfg
    end
  end
  self._cfgTab = validCfg
  table.sort(self._cfgTab, function(a, b)
    return a.TabEnum < b.TabEnum
  end)
  local tabCount = #self._cfgTab
  self._tabPool:SpawnObjects("UIS5HelperTab", tabCount)
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

function UIS5HelperController:OnTabClick(tabId)
  if self._curTab ~= tabId then
    self._curTab = tabId
    self._bannerWidget:SetData(tabId)
    for index, tab in ipairs(self._tabs) do
      tab:OnSelectIndex(tabId)
    end
  end
end
