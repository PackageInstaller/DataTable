_class("UIN28GronruGameAlbum", UICustomWidget)
UIN28GronruGameAlbum = UIN28GronruGameAlbum

function UIN28GronruGameAlbum:Constructor()
  self._defaultPage = nil
  self._defaultProject = nil
end

function UIN28GronruGameAlbum:OnShow(uiParams)
  self._uiPageContent = self:GetUIComponent("UISelectObjectPath", "uiPageContent")
  self._uiProjectContent = self:GetUIComponent("UISelectObjectPath", "uiProjectRoot")
  self._uiProjectRoot = self._uiProjectContent:Engine()
  self._uiEmptyRoot = self:GetUIComponent("RectTransform", "uiEmptyRoot")
  self:CreatePagePool()
  self:CreateProjectPool()
end

function UIN28GronruGameAlbum:OnHide()
end

function UIN28GronruGameAlbum:CreatePagePool()
  self._pagePool = {}
  local allPage = Cfg.cfg_n28_gronru_album_page({})
  for k, v in pairs(allPage) do
    table.insert(self._pagePool, v)
    if self._defaultPage == nil and v.OpenType == UIN28GronruPlatformType.Album_Page_Game then
      self._defaultPage = v
    end
  end
  table.sort(self._pagePool, function(a, b)
    return a.ID < b.ID
  end)
  if self._defaultPage == nil then
    self._defaultPage = self._pagePool[1]
  end
end

function UIN28GronruGameAlbum:CreateProjectPool()
  self._projectPool = {}
  local allProject = Cfg.cfg_n28_gronru_album_project({})
  for k, v in pairs(allProject) do
    table.insert(self._projectPool, v)
    if self._defaultProject == nil and v.OpenType == UIN28GronruPlatformType.Album_Project_Adventure then
      self._defaultProject = v
    end
  end
  table.sort(self._projectPool, function(a, b)
    return a.ID < b.ID
  end)
  if self._defaultProject == nil then
    self._defaultProject = self._projectPool[1]
  end
end

function UIN28GronruGameAlbum:GetDefaultProject()
  return self._defaultProject
end

function UIN28GronruGameAlbum:Flush()
  self:FlushPage()
  self:FlushProject()
  self:OpenPage(self._defaultPage, true, true)
  self:OpenProject(self._defaultProject)
end

function UIN28GronruGameAlbum:FlushPage()
  local dataCount = #self._pagePool
  self._pageUiPool = self._uiPageContent:SpawnObjects("UIN28GronruGameAlbumPage", dataCount)
  for k, v in pairs(self._pagePool) do
    local ui = self._pageUiPool[k]
    ui:Flush(self, v)
  end
end

function UIN28GronruGameAlbum:FlushProject()
  local missionComponent = self:CallUIMethod("UIN28GronruPlatform", "GetMissionComponent")
  local dataCount = #self._projectPool
  self._projectUiPool = self._uiProjectContent:SpawnObjects("UIN28GronruGameAlbumProject", dataCount)
  for k, v in pairs(self._projectPool) do
    local ui = self._projectUiPool[k]
    ui:Flush(self, v)
    if v.OpenType == UIN28GronruPlatformType.Album_Project_Adventure then
      ui:ShowRed(missionComponent:MissionCanRecvReward())
    end
  end
end

function UIN28GronruGameAlbum:OpenPage(cfgPage, switchPage, switchContent)
  if switchPage then
    self:RootUIOwner():BrowserPath(true, StringTable.Get(cfgPage.Name))
    self:RootUIOwner():BrowserPath(false, nil)
    for k, v in pairs(self._pagePool) do
      local ui = self._pageUiPool[k]
      ui:SetHighlight(v.ID == cfgPage.ID)
    end
  end
  if switchContent then
    if cfgPage.OpenType == UIN28GronruPlatformType.Album_Page_Empty then
      self._uiProjectRoot.gameObject:SetActive(false)
      self._uiEmptyRoot.gameObject:SetActive(true)
    elseif cfgPage.OpenType == UIN28GronruPlatformType.Album_Page_Game then
      self._uiProjectRoot.gameObject:SetActive(true)
      self._uiEmptyRoot.gameObject:SetActive(false)
    end
  end
end

function UIN28GronruGameAlbum:OpenPageAnimation(cfgPage)
  local oldHighlight, newHighlight
  for k, v in pairs(self._pagePool) do
    local ui = self._pageUiPool[k]
    if ui:IsHighlight() then
      oldHighlight = ui
    end
    if v.ID == cfgPage.ID then
      newHighlight = ui
    end
  end
  if oldHighlight ~= nil then
    oldHighlight:ShowNormalHighlight(true, true)
    oldHighlight:PlayAnimation("UIN28GronruGameAlbumPage_out", 117, function()
      self:OpenPage(cfgPage, false, true)
    end)
  end
  if newHighlight ~= nil then
    newHighlight:ShowNormalHighlight(true, true)
    newHighlight:PlayAnimation("UIN28GronruGameAlbumPage_in", 333, function()
      self:OpenPage(cfgPage, true, true)
    end)
  end
end

function UIN28GronruGameAlbum:OpenProject(cfgProject)
  if cfgProject.OpenType == UIN28GronruPlatformType.Album_Project_Empty then
    self._uiProjectRoot.gameObject:SetActive(false)
    self._uiEmptyRoot.gameObject:SetActive(true)
  elseif cfgProject.OpenType == UIN28GronruPlatformType.Album_Project_Adventure then
    self._uiProjectRoot.gameObject:SetActive(true)
    self._uiEmptyRoot.gameObject:SetActive(false)
  end
end
