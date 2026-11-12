local StarTowerNpcAffinityCtrl = class("StarTowerNpcAffinityCtrl", BaseCtrl)
StarTowerNpcAffinityCtrl._mapNodeConfig = {
  btnNpc = {
    sNodeName = "btnNpcTab",
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_NPCTab"
  },
  btnNpcTab = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  redDotAffinityTab = {nCount = 4},
  imgNpcHead = {nCount = 4, sComponentName = "Image"},
  TMPWeekAffinityCount = {sComponentName = "TMP_Text"},
  imgNPC = {sComponentName = "Image"},
  goAffinity = {
    sCtrlName = "Game.UI.StarTowerBook.Affinity.NpcFavorCtrl"
  },
  TMPNPCName = {sComponentName = "TMP_Text"},
  TMPNpcInfo = {sComponentName = "TMP_Text"},
  svAffinityList = {
    sComponentName = "LoopScrollView"
  },
  txtCollect = {sComponentName = "TMP_Text"},
  txtCollectCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Collect"
  },
  btnAffinityReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AffinityReward"
  },
  rtNpcInfo = {sComponentName = "ScrollRect"}
}
StarTowerNpcAffinityCtrl._mapEventConfig = {}
StarTowerNpcAffinityCtrl._mapRedDotConfig = {}

function StarTowerNpcAffinityCtrl:Awake()
  self.tbNPC = {}
  self.mapNpcPlot = {}
  self.mapNpcAffinityData = {}
  self.nTotalPlotCount = 0
  
  local function forEachStartowerNpc(mapData)
    table.insert(self.tbNPC, mapData)
  end
  
  ForEachTableLine(DataTable.StarTowerNPC, forEachStartowerNpc)
  
  local function forEachStartowerNpcPlot(mapData)
    if self.mapNpcPlot[mapData.NPCId] == nil then
      self.mapNpcPlot[mapData.NPCId] = {}
    end
    self.nTotalPlotCount = self.nTotalPlotCount + 1
    table.insert(self.mapNpcPlot[mapData.NPCId], mapData)
  end
  
  local function sort(a, b)
    return a.Id < b.Id
  end
  
  table.sort(self.tbNPC, sort)
  ForEachTableLine(DataTable.NPCAffinityPlot, forEachStartowerNpcPlot)
  
  local function sortPlot(a, b)
    return a.AffinityLevel < b.AffinityLevel
  end
  
  for _, tbPlot in pairs(self.mapNpcPlot) do
    table.sort(tbPlot, sortPlot)
  end
  for i = 1, 4 do
    self._mapNode.btnNpcTab[i]:SetText(self.tbNPC[i].Name)
    self:SetPngSprite(self._mapNode.imgNpcHead[i], self.tbNPC[i].Head)
  end
end

function StarTowerNpcAffinityCtrl:FadeIn()
end

function StarTowerNpcAffinityCtrl:FadeOut()
end

function StarTowerNpcAffinityCtrl:OnEnable()
  for i = 1, 4 do
    RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_Affinity_Reward, self.tbNPC[i].Id, self._mapNode.redDotAffinityTab[i])
  end
end

function StarTowerNpcAffinityCtrl:OnDisable()
  self:UnbindAllGridNodes()
  for i = 1, 4 do
    RedDotManager.UnRegisterNode(RedDotDefine.StarTowerBook_Affinity_Reward, self.tbNPC[i].Id, self._mapNode.redDotAffinityTab[i])
  end
end

function StarTowerNpcAffinityCtrl:OnDestroy()
end

function StarTowerNpcAffinityCtrl:OnRelease()
end

function StarTowerNpcAffinityCtrl:Init()
  self.nCurCount = 0
  for _, value in ipairs(self.tbNPC) do
    local tbPlotCount = PlayerData.StarTower:GetNpcReceivedPlot(value.Id)
    self.nCurCount = self.nCurCount + #tbPlotCount
  end
  self.mapNpcAffinityData = {}
  
  local function forEachStartowerNpc(mapData)
    self.mapNpcAffinityData[mapData.Id] = PlayerData.StarTower:GetNpcAffinityData(mapData.Id)
  end
  
  ForEachTableLine(DataTable.StarTowerNPC, forEachStartowerNpc)
  self.mapAffinityGrid = {}
  self.nCurNpcId = self.tbNPC[1].Id
  if self._panel.nAffinityNpcId ~= 0 and self._panel.nAffinityNpcId ~= nil then
    self.nCurNpcId = self._panel.nAffinityNpcId
  end
  for i = 1, 4 do
    self._mapNode.btnNpcTab[i]:SetDefault(self.nCurNpcId == self.tbNPC[i].Id)
  end
  local nMaxCount = ConfigTable.GetConfigNumber("NPCAffinityNumberOfInteractions")
  local curCount = PlayerData.StarTower:GetNpcAffinityWeekCount()
  local str = orderedFormat(ConfigTable.GetUIText("NPCAffinity_WeekCnt") or "", curCount, nMaxCount)
  NovaAPI.SetTMPText(self._mapNode.TMPWeekAffinityCount, str)
  NovaAPI.SetTMPText(self._mapNode.txtCollect, string.format("%d/%d", self.nCurCount, self.nTotalPlotCount))
  self:RefreshContent(self.nCurNpcId)
end

function StarTowerNpcAffinityCtrl:RefreshContent(nNpcId)
  self.nCurNpcId = nNpcId
  local mapNpcCfg = ConfigTable.GetData("StarTowerNPC", nNpcId)
  if mapNpcCfg == nil then
    return
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.rtNpcInfo, 1)
  NovaAPI.SetTMPText(self._mapNode.TMPNPCName, mapNpcCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPNpcInfo, mapNpcCfg.NPCDesc)
  self:SetPngSprite(self._mapNode.imgNPC, mapNpcCfg.Image)
  self._mapNode.goAffinity:Refresh(nNpcId)
  self._mapNode.svAffinityList:Init(#self.mapNpcPlot[nNpcId], self, self.OnGridRefresh, self.OnGridBtnClick)
end

function StarTowerNpcAffinityCtrl:OnGridRefresh(goGrid, nIdx)
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapAffinityGrid[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerBook.Affinity.NpcRelationGridCtrl")
    self.mapAffinityGrid[nInstanceId] = objCtrl
  end
  nIdx = nIdx + 1
  local mapPlot = self.mapNpcPlot[self.nCurNpcId][nIdx]
  objCtrl:Refresh(mapPlot, self.mapNpcAffinityData[self.nCurNpcId])
end

function StarTowerNpcAffinityCtrl:OnGridBtnClick(goGrid, nIdx)
  local mapNpcAffinityData = self.mapNpcAffinityData[self.nCurNpcId]
  if mapNpcAffinityData == nil then
    return
  end
  nIdx = nIdx + 1
  local mapPlot = self.mapNpcPlot[self.nCurNpcId][nIdx]
  if mapPlot.AffinityLevel <= mapNpcAffinityData.Level then
    local function ReceiveCallback(mapShow, mapChange)
      EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
      
      local function waitTransition()
        UTILS.OpenReceiveByDisplayItem(mapShow, mapChange)
      end
      
      EventManager.Hit(EventId.TemporaryBlockInput, 1.5)
      self:AddTimer(1, 1.5, waitTransition, true, true, true)
    end
    
    local function AvgCallback()
      PlayerData.StarTower:ReceiveNpcAffinityReward(self.nCurNpcId, mapPlot.Id, ReceiveCallback)
    end
    
    local function AvgCallbackReveived()
      EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
    end
    
    if not PlayerData.StarTower:GetNpcPlotReceived(self.nCurNpcId, mapPlot.Id) then
      local mapData = {
        nType = AllEnum.StoryAvgType.Plot,
        sAvgId = mapPlot.avgId,
        nNodeId = nil,
        callback = AvgCallback
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.PureAvgStory, mapData)
    else
      do
        local mapData = {
          nType = AllEnum.StoryAvgType.Plot,
          sAvgId = mapPlot.avgId,
          nNodeId = nil,
          callback = AvgCallbackReveived
        }
        EventManager.Hit(EventId.OpenPanel, PanelId.PureAvgStory, mapData)
      end
    end
  else
    local sTip = orderedFormat(ConfigTable.GetUIText("NPCAffinity_UnlockCnd") or "", mapPlot.AffinityLevel)
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function StarTowerNpcAffinityCtrl:UnbindAllGridNodes()
  if self.mapAffinityGrid then
    for goGrid, mapCtrl in pairs(self.mapAffinityGrid) do
      self:UnbindCtrlByNode(mapCtrl)
    end
    self.mapAffinityGrid = {}
  end
end

function StarTowerNpcAffinityCtrl:Back()
  self._panel.nAffinityNpcId = 0
  self:UnbindAllGridNodes()
  EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Main)
end

function StarTowerNpcAffinityCtrl:OnBtnClick_NPCTab(btn, nIdx)
  local nSelectNpcId = self.tbNPC[nIdx].Id
  if self.nCurNpcId == nSelectNpcId then
    return
  end
  for i = 1, 4 do
    if self.nCurNpcId == self.tbNPC[i].Id then
      self._mapNode.btnNpcTab[i]:SetDefault(false)
    end
  end
  self.nCurNpcId = nSelectNpcId
  self._panel.nAffinityNpcId = nSelectNpcId
  self._mapNode.btnNpcTab[nIdx]:SetDefault(true)
  self:RefreshContent(self.nCurNpcId)
end

function StarTowerNpcAffinityCtrl:OnBtnClick_AffinityReward(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.NpcAffinityRewardPanel, self.nCurNpcId)
end

return StarTowerNpcAffinityCtrl
