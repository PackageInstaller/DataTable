_class("UIN28GronruGameAdventure", UICustomWidget)
UIN28GronruGameAdventure = UIN28GronruGameAdventure

function UIN28GronruGameAdventure:Constructor()
  self._pageGameCnt = 0
  self._pageCommunityCnt = 0
end

function UIN28GronruGameAdventure:OnShow(uiParams)
  self._uiPageContent = self:GetUIComponent("UISelectObjectPath", "uiPageContent")
  self._uiSteamMyGame = self:GetUIComponent("RectTransform", "uiSteamMyGame")
  self._uiSteamCommunity = self:GetUIComponent("RectTransform", "uiSteamCommunity")
  self._uiEntranceRoot = self:GetUIComponent("RectTransform", "uiEntrance")
  self._uiErrorRoot = self:GetUIComponent("RectTransform", "uiError")
  self._uiForumRoot = self:GetUIComponent("RectTransform", "uiForum")
  self._uiForumContent = self:GetUIComponent("UISelectObjectPath", "uiForumContent")
  self._redEntrance = self:View():GetUIComponent("UISelectObjectPath", "redEntrance")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._againImage = self:GetUIComponent("RectTransform", "againImage")
  self._againImage.gameObject:SetActive(true)
  self:CreatePagePool()
  self:CreateForumPool()
  self.CheckActivityOverFun = nil
end

function UIN28GronruGameAdventure:OnHide()
end

function UIN28GronruGameAdventure:BtnEntranceOnClick(go)
  if self.CheckActivityOverFun ~= nil and self.CheckActivityOverFun() then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceFolder)
  self:StartTask(function(TT)
    self:Lock("UIN28GronruGameAdventure:BtnEntranceOnClick")
    self._animation:Play("UIN28GronruGameAdventureForum_btnEntrance_click")
    YIELD(TT, 367)
    self:CallUIMethod("UIN28GronruPlatform", "PlayAnimation", "UIN28GronruPlatform_out", 233, function()
    end)
    YIELD(TT, 233)
    self:UnLock("UIN28GronruGameAdventure:BtnEntranceOnClick")
    self:ShowDialog(UIStateType.UIN28GronruGameFlash)
  end)
end

function UIN28GronruGameAdventure:ResetCellSize(go, cellSize)
  if go == nil then
    return
  end
  local rt = go.transform
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2.one * 0.5
  rt.anchorMax = Vector2.one * 0.5
  rt.sizeDelta = cellSize
  rt.anchoredPosition = Vector2.zero
end

function UIN28GronruGameAdventure:CreatePagePool()
  self._pagePool = {}
  local allPage = Cfg.cfg_n28_gronru_adventure_page({})
  for k, v in pairs(allPage) do
    table.insert(self._pagePool, v)
    if self._defaultPage == nil and v.OpenType == UIN28GronruPlatformType.Adventure_Page_Entrance then
      self._defaultPage = v
    end
    if v.SteamType == UIN28GronruPlatformType.Adventure_Steam_Game then
      self._pageGameCnt = self._pageGameCnt + 1
    end
    if v.SteamType == UIN28GronruPlatformType.Adventure_Steam_Community then
      self._pageCommunityCnt = self._pageCommunityCnt + 1
    end
  end
  table.sort(self._pagePool, function(a, b)
    if a.SteamType ~= b.SteamType then
      return a.SteamType < b.SteamType
    end
    return a.ID < b.ID
  end)
  if self._defaultPage == nil then
    self._defaultPage = self._pagePool[1]
  end
  self._pageUiPool1 = self._uiPageContent:SpawnObjects("UIN28GronruGameAdventurePage", self._pageGameCnt)
  self._uiSteamCommunity:SetAsLastSibling()
  self._pageUiPool2 = self._uiPageContent:SpawnObjects("UIN28GronruGameAdventurePage", self._pageGameCnt + self._pageCommunityCnt)
  for i = 1, self._pageGameCnt do
    table.remove(self._pageUiPool2, 1)
  end
  for k, v in pairs(self._pageUiPool1) do
    self:ResetCellSize(v:GetGameObject(), Vector2(540, 102))
  end
  for k, v in pairs(self._pageUiPool2) do
    self:ResetCellSize(v:GetGameObject(), Vector2(540, 102))
  end
end

function UIN28GronruGameAdventure:CreateForumPool()
  self._forumPool = {}
  local allForum = Cfg.cfg_n28_gronru_adventure_forum({})
  for k, v in pairs(allForum) do
    table.insert(self._forumPool, v)
  end
  table.sort(self._forumPool, function(a, b)
    return a.ID < b.ID
  end)
  local dataCount = #self._forumPool
  self._forumUiPool = self._uiForumContent:SpawnObjects("UIN28GronruGameAdventureForum", dataCount)
end

function UIN28GronruGameAdventure:Flush()
  self:FlushPage()
  self:FlushForum()
  self:FlushRedEntrance()
  self:OpenPage(self._defaultPage, true, true)
end

function UIN28GronruGameAdventure:FlushPage()
  local idGame = 1
  local idCommunity = 1
  for k, v in pairs(self._pagePool) do
    if v.SteamType == UIN28GronruPlatformType.Adventure_Steam_Game then
      local ui = self._pageUiPool1[idGame]
      ui:Flush(self, v)
      idGame = idGame + 1
    end
    if v.SteamType == UIN28GronruPlatformType.Adventure_Steam_Community then
      local ui = self._pageUiPool2[idCommunity]
      ui:Flush(self, v)
      idCommunity = idCommunity + 1
    end
  end
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self._uiPageContent.transform)
  end)
end

function UIN28GronruGameAdventure:OpenPage(cfgPage, switchPage, switchContent)
  if switchPage then
    if cfgPage.OpenType == UIN28GronruPlatformType.Adventure_Page_Entrance then
      local defaultProject = self:RootUIOwner():GetDefaultProject()
      self:RootUIOwner():BrowserPath(false, StringTable.Get(defaultProject.Name))
    else
      self:RootUIOwner():BrowserPath(false, StringTable.Get(cfgPage.Name))
    end
    for k, v in pairs(self._pageUiPool1) do
      v:SetHighlight(v:GetCfg().ID == cfgPage.ID)
    end
    for k, v in pairs(self._pageUiPool2) do
      v:SetHighlight(v:GetCfg().ID == cfgPage.ID)
    end
  end
  if switchContent then
    self._uiErrorRoot.gameObject:SetActive(cfgPage.OpenType == UIN28GronruPlatformType.Adventure_Page_Error)
    self._uiEntranceRoot.gameObject:SetActive(cfgPage.OpenType == UIN28GronruPlatformType.Adventure_Page_Entrance)
    self._uiForumRoot.gameObject:SetActive(cfgPage.OpenType == UIN28GronruPlatformType.Adventure_Page_Forum)
    self._animation:Play("UIN28GronruGameAdventure_uiEntrance_in")
  end
end

function UIN28GronruGameAdventure:OpenPageAnimation(cfgPage)
  local oldHighlight, newHighlight
  for k, v in pairs(self._pageUiPool1) do
    if v:IsHighlight() then
      oldHighlight = v
    end
    if v:GetCfg().ID == cfgPage.ID then
      newHighlight = v
    end
  end
  for k, v in pairs(self._pageUiPool2) do
    if v:IsHighlight() then
      oldHighlight = v
    end
    if v:GetCfg().ID == cfgPage.ID then
      newHighlight = v
    end
  end
  if oldHighlight ~= nil then
    oldHighlight:ShowNormalHighlight(true, true)
    oldHighlight:PlayAnimation("UIN28GronruGameAdventurePage_out", 117, function()
      self:OpenPage(cfgPage, false, true)
    end)
  end
  if newHighlight ~= nil then
    newHighlight:ShowNormalHighlight(true, true)
    newHighlight:PlayAnimation("UIN28GronruGameAdventurePage_in", 233, function()
      self:OpenPage(cfgPage, true, true)
    end)
  end
end

function UIN28GronruGameAdventure:FlushForum()
  local x = 0
  local y = 1
  local h = 0
  local contentWidth = self._uiForumRoot.rect.width
  for k, v in pairs(self._forumPool) do
    local ui = self._forumUiPool[k]
    ui:Flush(self, v)
    local uiSize = ui:Size()
    x = x + uiSize.x
    h = uiSize.y
    if contentWidth > x then
      ui:SetPos(x - uiSize.x * 0.5, -(y - 0.5) * uiSize.y)
    else
      x = uiSize.x
      y = y + 1
      ui:SetPos(x - uiSize.x * 0.5, -(y - 0.5) * uiSize.y)
    end
  end
  local uiEngine = self._uiForumContent:Engine()
  local trEngine = uiEngine.transform
  local sizeDelta = trEngine.sizeDelta
  trEngine.sizeDelta = Vector2(sizeDelta.x, h * y + 10)
end

function UIN28GronruGameAdventure:FlushRedEntrance()
  local missionComponent = self:CallUIMethod("UIN28GronruPlatform", "GetMissionComponent")
  local showRed = missionComponent:MissionCanRecvReward()
  self._redEntrance.gameObject:SetActive(showRed)
  if showRed then
    self._redEntrance:SpawnOneObject("ManualLoad0")
  end
end

function UIN28GronruGameAdventure:BtnNewsOnClick(go)
  if self.CheckActivityOverFun ~= nil and self.CheckActivityOverFun() then
    return
  end
  self:ShowDialog("UIN28GronruGameForumDetails")
end

function UIN28GronruGameAdventure:OnForumPreview(cfg)
  self:ShowDialog("UIN28GronruGameForumDetails", cfg)
end

function UIN28GronruGameAdventure:SetCheckActivityOverFun(fun)
  self.CheckActivityOverFun = fun
end
