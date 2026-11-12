local DormHandbookCtrl = class("DormHandbookCtrl", BaseCtrl)
DormHandbookCtrl._mapNodeConfig = {
  svAchievement = {
    sComponentName = "LoopScrollView"
  },
  svPreset = {
    sComponentName = "LoopScrollView"
  },
  svFurniture = {
    sComponentName = "LoopScrollView"
  },
  rtBar = {
    sComponentName = "LoopScrollView"
  },
  rtQuest = {sComponentName = "Animator"},
  listTog = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 3
  },
  btnToggle = {
    sNodeName = "listTog",
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Toggle"
  },
  rtFurniture = {},
  rtPreset = {
    sNodeName = "rtPresetList"
  },
  rtAchievement = {},
  txtChapter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_HandBook_Title"
  },
  btnCloseQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goHonorTitle = {
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  imgHead = {sComponentName = "Image"},
  txtChrDeatil = {sComponentName = "TMP_Text"},
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRedAchievement = {},
  goRedFurniture = {}
}
DormHandbookCtrl._mapEventConfig = {}
DormHandbookCtrl._mapRedDotConfig = {
  [RedDotDefine.DormRecord_Achievement] = {
    sNodeName = "goRedAchievement"
  },
  [RedDotDefine.DormRecord_Furniture] = {
    sNodeName = "goRedFurniture"
  }
}

function DormHandbookCtrl:Awake()
  self._mapCtrlAchievement = {}
  self._mapCtrlPreset = {}
  self._mapCtrlFurniture = {}
  self._mapCtrlFurnitureToggle = {}
end

function DormHandbookCtrl:FadeIn()
end

function DormHandbookCtrl:FadeOut()
end

function DormHandbookCtrl:OnEnable()
  local function wait()
    self._mapNode.rtQuest.gameObject:SetActive(false)
    
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtQuest.gameObject:SetActive(true)
    self._mapNode.rtQuest:Play("HandBookrtQuest_in")
  end
  
  cs_coroutine.start(wait)
  local tbParam = self:GetPanelParam()
  self._panel.nCurRoom = tbParam[1]
  local bHasAchievement = RedDotManager.GetValid(RedDotDefine.DormRecord_Achievement)
  local bHasFurniture = RedDotManager.GetValid(RedDotDefine.DormRecord_Furniture)
  self.nCurTog = bHasAchievement and 1 or bHasFurniture and 2 or 1
  self.nFurnitureTog = 1
  self._mapNode.listTog[1]:SetText(ConfigTable.GetUIText("Dorm_HandBook_Tog1"))
  self._mapNode.listTog[2]:SetText(ConfigTable.GetUIText("Dorm_HandBook_Tog2"))
  self._mapNode.listTog[3]:SetText(ConfigTable.GetUIText("Dorm_HandBook_Tog3"))
  self._mapNode.listTog[1]:SetDefaultDorm(self.nCurTog == 1)
  self._mapNode.listTog[2]:SetDefaultDorm(self.nCurTog == 2)
  self._mapNode.listTog[3]:SetDefaultDorm(self.nCurTog == 3)
  self._mapNode.rtAchievement:SetActive(self.nCurTog == 1)
  self._mapNode.rtPreset:SetActive(self.nCurTog == 2)
  self._mapNode.rtFurniture:SetActive(self.nCurTog == 3)
  self.tbAchievement = {}
  self.mapAchievementState = {}
  local receivedIds, nTotalCollection = PlayerData.PlayerDormData:GetDormAchievementData()
  self.tbreceivedAchievementIds = receivedIds
  self.nTotalCollection = nTotalCollection
  
  local function GetAchievementState(mapData)
    local bReceived = table.indexof(self.tbreceivedAchievementIds, mapData.Id) > 0
    if bReceived then
      return 0
    end
    local nGoal = mapData.CompleteParams[1]
    if nGoal == nil then
      nGoal = 1
    end
    if nGoal <= self.nTotalCollection then
      return 2
    else
      return 1
    end
  end
  
  local function foreachTableAchievement(mapData)
    local nState = GetAchievementState(mapData)
    self.mapAchievementState[mapData.Id] = nState
    table.insert(self.tbAchievement, mapData.Id)
  end
  
  local function sortAchievement(a, b)
    return a < b
  end
  
  ForEachTableLine(DataTable.DormAchievement, foreachTableAchievement)
  table.sort(self.tbAchievement, sortAchievement)
  self.mapFurniture = {}
  
  local function foreachTableFurniture(mapData)
    if mapData.NotShow < 1 then
      if self.mapFurniture[mapData.Tab] == nil then
        self.mapFurniture[mapData.Tab] = {}
      end
      table.insert(self.mapFurniture[mapData.Tab], mapData.Id)
    end
  end
  
  ForEachTableLine(DataTable.DormFurniture, foreachTableFurniture)
  for _, tbItem in pairs(self.mapFurniture) do
    local function sort(a, b)
      local mapCfgA = ConfigTable.GetData("DormFurniture", a)
      
      local mapCfgB = ConfigTable.GetData("DormFurniture", b)
      if mapCfgA.CollectionValue ~= mapCfgB.CollectionValue then
        return mapCfgA.CollectionValue > mapCfgB.CollectionValue
      end
      return b < a
    end
    
    table.sort(tbItem, sort)
  end
  self.tbSuit = {}
  
  local function foreachTableSuit(mapData)
    if not mapData.noShow then
      table.insert(self.tbSuit, mapData.Id)
    end
  end
  
  table.sort(self.tbSuit)
  ForEachTableLine(DataTable.DormLayoutReward, foreachTableSuit)
  self.mapBag = {}
  
  local function GetBagInfoCallback(mapBag)
    self.mapBag = mapBag
    local nAchievementIdx = 0
    for idx, nId in ipairs(self.tbAchievement) do
      local nState = self.mapAchievementState[nId] or 0
      if nState == 2 then
        nAchievementIdx = idx
        break
      end
    end
    self._mapNode.svAchievement:Init(#self.tbAchievement, self, self.OnAchievementGridRefresh, self.OnAchievementGridClick)
    self._mapNode.svAchievement:SetScrollGridPos(nAchievementIdx - 1)
    self._mapNode.svPreset:Init(#self.tbSuit, self, self.OnSuitGridRefresh, self.OnSuitGridClick)
    self._mapNode.rtBar:Init(8, self, self.OnFurnitureTogGridRefresh, self.OnFurnitureTogGridClick)
    local curTab = self.mapFurniture[self.nFurnitureTog] == nil and {} or self.mapFurniture[self.nFurnitureTog]
    if #curTab == 0 then
      self._mapNode.svFurniture.gameObject:SetActive(false)
    else
      self._mapNode.svFurniture.gameObject:SetActive(true)
      self._mapNode.svFurniture:Init(#curTab, self, self.OnFurnitureGridRefresh, self.OnFurnitureGridClick)
    end
  end
  
  PlayerData.PlayerDormData:GetBagInfo(GetBagInfoCallback)
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  local nLevel = PlayerData.PlayerDormData:GetHonorTitleLevel()
  self._mapNode.goHonorTitle:SetHonotTitle(140001, true, nLevel)
  local sName = PlayerData.Base:GetPlayerNickName()
  NovaAPI.SetTMPText(self._mapNode.txtChrDeatil, sName)
end

function DormHandbookCtrl:OnDisable()
  for goGrid, mapCtrl in pairs(self._mapCtrlAchievement) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapCtrlAchievement = {}
  for goGrid, mapCtrl in pairs(self._mapCtrlPreset) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapCtrlPreset = {}
  for goGrid, mapCtrl in pairs(self._mapCtrlFurniture) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapCtrlFurniture = {}
  for goGrid, mapCtrl in pairs(self._mapCtrlFurnitureToggle) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapCtrlFurnitureToggle = {}
end

function DormHandbookCtrl:OnDestroy()
end

function DormHandbookCtrl:OnRelease()
end

function DormHandbookCtrl:OnAchievementGridRefresh(goGrid, nIdx)
  if self._mapCtrlAchievement[goGrid] == nil then
    self._mapCtrlAchievement[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormHandBook.DormHandbookAchievementGridCtrl")
  end
  nIdx = nIdx + 1
  local nAchievementId = self.tbAchievement[nIdx]
  local bReceived = table.indexof(self.tbreceivedAchievementIds, nAchievementId) > 0
  self._mapCtrlAchievement[goGrid]:Refresh(nAchievementId, bReceived, self.nTotalCollection)
end

function DormHandbookCtrl:OnAchievementGridClick(goGrid, nIdx)
  nIdx = nIdx + 1
  local nAchievementId = self.tbAchievement[nIdx]
  
  local function callback(msgData)
    UTILS.OpenReceiveByChangeInfo(msgData.ChangeInfo)
    local unreceivedIds, nTotalCollection = PlayerData.PlayerDormData:GetDormAchievementData()
    self.tbreceivedAchievementIds = unreceivedIds
    self.nTotalCollection = nTotalCollection
    self._mapNode.svAchievement:Init(#self.tbAchievement, self, self.OnAchievementGridRefresh, self.OnAchievementGridClick, true)
    local nLevel = PlayerData.PlayerDormData:GetHonorTitleLevel()
    self._mapNode.goHonorTitle:SetHonotTitle(140001, true, nLevel)
  end
  
  if self._mapCtrlAchievement[goGrid].bCanReceive then
    PlayerData.PlayerDormData:ReceiveDormAchievement({nAchievementId}, callback)
  end
end

function DormHandbookCtrl:OnSuitGridRefresh(goGrid, nIdx)
  if self._mapCtrlPreset[goGrid] == nil then
    self._mapCtrlPreset[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormHandBook.DormHandbookSuitGridCtrl")
  end
  nIdx = nIdx + 1
  local nSuitId = self.tbSuit[nIdx]
  local bReceived = PlayerData.PlayerDormData:CheckLayoutReceived(nSuitId)
  self._mapCtrlPreset[goGrid]:SetSuit(nSuitId, true, bReceived, self.mapBag)
end

function DormHandbookCtrl:OnSuitGridClick(goGrid, nIdx)
  nIdx = nIdx + 1
  local nSuitId = self.tbSuit[nIdx]
  local tbSuitFurniture = self._panel.mapDormSuitData[nSuitId]
  local mapCurCount = {}
  local mapTotalCount = {}
  for _, mapFurniture in ipairs(tbSuitFurniture) do
    if mapCurCount[mapFurniture.FurnitureId] == nil then
      mapCurCount[mapFurniture.FurnitureId] = self.mapBag[mapFurniture.FurnitureId]
    end
    if mapTotalCount[mapFurniture.FurnitureId] == nil then
      mapTotalCount[mapFurniture.FurnitureId] = self.mapBag[mapFurniture.FurnitureId]
    end
  end
  local nRoom = self._panel.nCurRoom or 0
  local bCurSuit = false
  EventManager.Hit(EventId.OpenPanel, PanelId.DormEditorSuitDetailPanel, nSuitId, tbSuitFurniture, mapCurCount, 0, mapTotalCount, bCurSuit, nil)
end

function DormHandbookCtrl:OnFurnitureGridRefresh(goGrid, nIdx)
  if self._mapCtrlFurniture[goGrid] == nil then
    self._mapCtrlFurniture[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormEditor.TemplateDormFurnitureItem")
  end
  nIdx = nIdx + 1
  local curTab = self.mapFurniture[self.nFurnitureTog]
  if curTab ~= nil then
    local nFurnitrueId = curTab[nIdx]
    local nCount = self.mapBag[nFurnitrueId] == nil and 0 or self.mapBag[nFurnitrueId]
    self._mapCtrlFurniture[goGrid]:RefreshHandbook(nFurnitrueId, nCount)
  end
end

function DormHandbookCtrl:OnFurnitureGridClick(goGrid, nIdx)
  self._mapCtrlFurniture[goGrid]:OnBtnClick_Info()
end

function DormHandbookCtrl:OnFurnitureTogGridRefresh(goGrid, nIdx)
  if self._mapCtrlFurnitureToggle[goGrid] == nil then
    self._mapCtrlFurnitureToggle[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateToggleCtrl")
  end
  nIdx = nIdx + 1
  self._mapCtrlFurnitureToggle[goGrid]:SetText(ConfigTable.GetUIText(string.format("Dorm_FurnitureList_Tog%d", nIdx)))
  self._mapCtrlFurnitureToggle[goGrid]:SetDefault(nIdx == self.nFurnitureTog)
end

function DormHandbookCtrl:OnFurnitureTogGridClick(goGrid, nIdx)
  nIdx = nIdx + 1
  if self.nFurnitureTog == nIdx then
    return
  end
  self.nFurnitureTog = nIdx
  for goGridKey, mapCtrl in pairs(self._mapCtrlFurnitureToggle) do
    mapCtrl:SetDefault(goGridKey == goGrid)
  end
  local curTab = self.mapFurniture[self.nFurnitureTog] == nil and {} or self.mapFurniture[self.nFurnitureTog]
  if #curTab == 0 then
    self._mapNode.svFurniture.gameObject:SetActive(false)
  else
    self._mapNode.svFurniture.gameObject:SetActive(true)
    self._mapNode.svFurniture:Init(#curTab, self, self.OnFurnitureGridRefresh, self.OnFurnitureGridClick)
  end
end

function DormHandbookCtrl:OnBtnClick_Toggle(btn, nIdx)
  if nIdx == self.nCurTog then
    return
  end
  self.nCurTog = nIdx
  self._mapNode.listTog[1]:SetDefaultDorm(nIdx == 1)
  self._mapNode.listTog[2]:SetDefaultDorm(nIdx == 2)
  self._mapNode.listTog[3]:SetDefaultDorm(nIdx == 3)
  self._mapNode.rtAchievement:SetActive(nIdx == 1)
  self._mapNode.rtPreset:SetActive(nIdx == 2)
  self._mapNode.rtFurniture:SetActive(nIdx == 3)
  if nIdx == 3 then
    self._mapNode.rtBar:Init(8, self, self.OnFurnitureTogGridRefresh, self.OnFurnitureTogGridClick, true)
  end
end

function DormHandbookCtrl:OnBtnClick_Close()
  self._mapNode.rtQuest:Play("HandBookrtQuest_out")
  self:AddTimer(1, 0.25, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DormHandbookPanel)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.25)
end

return DormHandbookCtrl
