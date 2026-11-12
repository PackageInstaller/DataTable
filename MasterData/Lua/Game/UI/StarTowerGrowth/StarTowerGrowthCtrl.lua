local StarTowerGrowthCtrl = class("StarTowerGrowthCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
StarTowerGrowthCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  tab = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateTabCtrl"
  },
  btnTab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgLayerLock = {nCount = 4},
  goTip = {},
  txtTipLock = {sComponentName = "TMP_Text"},
  NormalNodeList = {},
  KeyNodeList = {},
  NodeContent = {sComponentName = "Transform"},
  HideRoot = {sComponentName = "Transform"},
  svNode = {sComponentName = "ScrollRect"},
  scNode = {
    sNodeName = "svNode",
    sComponentName = "UIScrollToClick"
  },
  rtNormalCenter = {
    sComponentName = "RectTransform"
  },
  rtKeyCenter = {
    sComponentName = "RectTransform"
  },
  btnCloseInfo = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseInfo"
  },
  Info = {
    sNodeName = "---Info---",
    sCtrlName = "Game.UI.StarTowerGrowth.NodeInfoCtrl"
  },
  animInfo = {sNodeName = "---Info---", sComponentName = "Animator"},
  eye_r = {},
  btnQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txtBtnQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_Btn_GetMaterials"
  },
  btnActiveAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActiveAll"
  },
  txtBtnActiveAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_Btn_ActiveAll"
  },
  txtResearchPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_ResearchPreview"
  },
  btnResearchPreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ResearchPreview"
  },
  StarTowerGrowthPreviewWindow = {
    sCtrlName = "Game.UI.StarTowerGrowth.StarTowerGrowthPreviewWindowCtrl"
  }
}
StarTowerGrowthCtrl._mapEventConfig = {
  StarTowerGrowthNodeUnlock = "OnEvent_Unlock",
  StarTowerGrowthNodeSelect = "OnEvent_Select",
  SetGrowthKeyNodeEye = "OnEvent_Eye",
  GuideSelectNote = "OnEvent_GuideSelectNote"
}
local GUIDE_CHECK_NODE_ID = 10301

function StarTowerGrowthCtrl:InitData()
  self.nSelectGroupIndex = nil
  self.nSelectGroupId = nil
  self.nSelectCloumn = nil
  self.nSelectNodeId = nil
  self.tbGroup = nil
  self.nGroupCount = 0
  self.tbNodeMap = {}
  self.tbHideKeyNodeList = {}
  self.tbHideNormalNodeList = {}
  self.tbNodeList = {}
end

function StarTowerGrowthCtrl:BuildIdMap(nGroupId, tbNodes)
  if not self.tbNodeMap[nGroupId] then
    self.tbNodeMap[nGroupId] = {}
  else
    return
  end
  for _, v in pairs(tbNodes) do
    local mapCfg = ConfigTable.GetData("StarTowerGrowthNode", v.nId)
    if mapCfg then
      local tbPos = mapCfg.Position
      local nCloumn = tbPos[1]
      local nIndex = tbPos[2]
      if not self.tbNodeMap[nGroupId][nCloumn] then
        self.tbNodeMap[nGroupId][nCloumn] = {}
        self.tbNodeMap[nGroupId][nCloumn].nType = mapCfg.Type
        self.tbNodeMap[nGroupId][nCloumn].tbId = {}
      end
      self.tbNodeMap[nGroupId][nCloumn].tbId[nIndex] = v.nId
    end
  end
end

function StarTowerGrowthCtrl:RefreshData()
  self.tbGroup = PlayerData.StarTower:GetSortedGrowthGroup()
  self.nGroupCount = #self.tbGroup
end

function StarTowerGrowthCtrl:RefreshSelect()
  for k, v in ipairs(self.tbGroup) do
    if v.bLock then
      break
    end
    self.nSelectGroupIndex = k
    self.nSelectGroupId = v.nId
    if PlayerData.Guide:GetGuideState() then
      EventManager.Hit("Guide_SendTowerGrowthSelectGroupId", self.nSelectGroupId)
    end
  end
end

function StarTowerGrowthCtrl:RefreshContent()
  self:RefreshData()
  self:RefreshSelect()
  self:RefreshTab()
  self:RefreshLock()
  self:RefreshTip()
  self:RefreshNode()
  self:RefreshTopBar()
  self:MoveToFirst()
end

function StarTowerGrowthCtrl:MoveToFirst()
  for _, v in ipairs(self.tbNodeList) do
    local goNode, nType = v:GetReadyNode()
    if goNode then
      local rtTarget = nType == GameEnum.towerGrowthNodeType.Core and self._mapNode.rtKeyCenter or self._mapNode.rtNormalCenter
      self._mapNode.scNode:ScrollToRectTransform(goNode, rtTarget, 0.15)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.15)
      return
    end
  end
end

function StarTowerGrowthCtrl:RefreshTopBar()
  for i = self.nGroupCount, 1, -1 do
    local tbNodes = PlayerData.StarTower:GetGrowthNodesByGroup(i)
    for _, v in pairs(tbNodes) do
      if v.bActive == false then
        self._mapNode.TopBar:SetCoinVisible(true)
        return
      end
    end
  end
  self._mapNode.TopBar:SetCoinVisible(false)
end

function StarTowerGrowthCtrl:RefreshNode()
  local tbNodes = PlayerData.StarTower:GetGrowthNodesByGroup(self.nSelectGroupId)
  self:BuildIdMap(self.nSelectGroupId, tbNodes)
  self:ClearNodeContent()
  local tbCurNodeMap = self.tbNodeMap[self.nSelectGroupId]
  for nCloumn, mapData in ipairs(tbCurNodeMap) do
    local bHasHide = false
    local nKeyCount = #self.tbHideKeyNodeList
    local nNormalCount = #self.tbHideNormalNodeList
    if mapData.nType == GameEnum.towerGrowthNodeType.Core and 0 < nKeyCount then
      self.tbNodeList[nCloumn] = self.tbHideKeyNodeList[nKeyCount]
      table.remove(self.tbHideKeyNodeList, nKeyCount)
      bHasHide = true
    elseif mapData.nType == GameEnum.towerGrowthNodeType.Normal and 0 < nNormalCount then
      self.tbNodeList[nCloumn] = self.tbHideNormalNodeList[nNormalCount]
      table.remove(self.tbHideNormalNodeList, nNormalCount)
      bHasHide = true
    end
    if bHasHide then
      self.tbNodeList[nCloumn].gameObject.transform:SetParent(self._mapNode.NodeContent)
    else
      local goObj, ctrlObj
      if mapData.nType == GameEnum.towerGrowthNodeType.Core then
        goObj = instantiate(self._mapNode.KeyNodeList, self._mapNode.NodeContent)
        ctrlObj = self:BindCtrlByNode(goObj, "Game.UI.StarTowerGrowth.KeyNodeListCtrl")
      elseif mapData.nType == GameEnum.towerGrowthNodeType.Normal then
        goObj = instantiate(self._mapNode.NormalNodeList, self._mapNode.NodeContent)
        ctrlObj = self:BindCtrlByNode(goObj, "Game.UI.StarTowerGrowth.NormalNodeListCtrl")
      end
      goObj:SetActive(true)
      self.tbNodeList[nCloumn] = ctrlObj
    end
    local mapNext = tbCurNodeMap[nCloumn + 1]
    self.tbNodeList[nCloumn]:Refresh(nCloumn, tbNodes, mapData.tbId, mapNext)
    self.tbNodeList[nCloumn]:ClearSelect()
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    local tmpData = PlayerData.StarTower:GetGrowthNode(GUIDE_CHECK_NODE_ID)
    if tmpData ~= nil and tmpData.bActive then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_StarTowerGrowthIdActive")
    end
  end
  
  cs_coroutine.start(wait)
  NovaAPI.SetHorizontalNormalizedPosition(self._mapNode.svNode, 0)
end

function StarTowerGrowthCtrl:RefreshNodeCloumn(nCloumn, tbNodes, tbNodeMap)
  local mapData = tbNodeMap[nCloumn]
  if self.tbNodeList[nCloumn] then
    local mapNext = tbNodeMap[nCloumn + 1]
    self.tbNodeList[nCloumn]:Refresh(nCloumn, tbNodes, mapData.tbId, mapNext)
  end
end

function StarTowerGrowthCtrl:ClearNodeContent()
  if next(self.tbNodeList) == nil then
    return
  end
  for _, ctrlNodeList in ipairs(self.tbNodeList) do
    ctrlNodeList.gameObject.transform:SetParent(self._mapNode.HideRoot)
    local nType = ctrlNodeList:GetType()
    if nType == GameEnum.towerGrowthNodeType.Core then
      table.insert(self.tbHideKeyNodeList, ctrlNodeList)
    elseif nType == GameEnum.towerGrowthNodeType.Normal then
      table.insert(self.tbHideNormalNodeList, ctrlNodeList)
    end
  end
  self.tbNodeList = {}
end

function StarTowerGrowthCtrl:RefreshTip()
  local mapGroup = self.tbGroup[self.nSelectGroupIndex]
  if mapGroup == nil then
    return
  end
  self._mapNode.goTip:SetActive(mapGroup.bLock)
  if mapGroup.bLock then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local mapPreGroup = self.tbGroup[mapGroup.nPreGroup]
    if mapPreGroup == nil then
      mapPreGroup = {nAllNodeCount = 0, nActiveNodeCount = 0}
    end
    local bPreLock = mapPreGroup.nAllNodeCount > mapPreGroup.nActiveNodeCount
    local bWorldClassLock = nCurWorldClass < mapGroup.nWorldClass
    local sTips = ""
    if bPreLock and bWorldClassLock then
      sTips = orderedFormat(ConfigTable.GetUIText("STGrowth_GropLock_Pre_WorldClass"), ConfigTable.GetData("StarTowerGrowthGroup", mapPreGroup.nId).Name, mapGroup.nWorldClass)
    elseif bPreLock then
      sTips = orderedFormat(ConfigTable.GetUIText("STGrowth_GropLock_Pre"), ConfigTable.GetData("StarTowerGrowthGroup", mapPreGroup.nId).Name)
    elseif bWorldClassLock then
      sTips = orderedFormat(ConfigTable.GetUIText("STGrowth_GropLock_WorldClass"), mapGroup.nWorldClass)
    end
    NovaAPI.SetTMPText(self._mapNode.txtTipLock, sTips)
  end
end

function StarTowerGrowthCtrl:RefreshLock()
  for i = 1, self.nGroupCount do
    self._mapNode.imgLayerLock[i]:SetActive(self.tbGroup[i].bLock)
  end
end

function StarTowerGrowthCtrl:RefreshTab()
  for i = 1, 4 do
    if i <= self.nGroupCount then
      self._mapNode.tab[i].gameObject:SetActive(true)
      local nState = self:GetTabState(i)
      local nGroupId = self.tbGroup[i].nId
      local mapCfg = ConfigTable.GetData("StarTowerGrowthGroup", nGroupId)
      if mapCfg then
        self._mapNode.tab[i]:SetSelect(i == self.nSelectGroupIndex, nState)
        self._mapNode.tab[i]:SetText(mapCfg.Name)
      end
      if i == self.nSelectGroupIndex and 1 < i then
        self._mapNode.tab[i - 1]:SetLine(false)
      end
    else
      self._mapNode.tab[i].gameObject:SetActive(false)
    end
  end
end

function StarTowerGrowthCtrl:GetTabState(nCurTab)
  local nState = 2
  if nCurTab == 1 then
    nState = 1
  elseif nCurTab == self.nGroupCount then
    nState = 3
  end
  return nState
end

function StarTowerGrowthCtrl:CloseInfo(callback)
  if not self._mapNode.Info.gameObject.activeSelf then
    return
  end
  if self.nSelectNodeId and self.nSelectCloumn then
    self.tbNodeList[self.nSelectCloumn]:SetSelect(self.nSelectNodeId, false)
  end
  self.nSelectCloumn = nil
  self.nSelectNodeId = nil
  self._mapNode.animInfo:Play("StarTowerGrowth_Info_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  self:AddTimer(1, 0.4, function()
    self._mapNode.Info.gameObject:SetActive(false)
    if callback then
      callback()
    end
  end, true, true, true)
  self._mapNode.btnQuest.gameObject:SetActive(true)
  self._mapNode.btnActiveAll.gameObject:SetActive(true)
  self._mapNode.btnResearchPreview.gameObject:SetActive(true)
end

function StarTowerGrowthCtrl:OpenInfo()
  self._mapNode.Info.gameObject:SetActive(true)
  self._mapNode.animInfo:Play("StarTowerGrowth_Info_in")
  self._mapNode.btnQuest.gameObject:SetActive(false)
  self._mapNode.btnActiveAll.gameObject:SetActive(false)
  self._mapNode.btnResearchPreview.gameObject:SetActive(false)
end

function StarTowerGrowthCtrl:ClearCtrl()
  for k, v in pairs(self.tbHideKeyNodeList) do
    self:UnbindCtrlByNode(v)
    self.tbHideKeyNodeList[k] = nil
  end
  self.tbHideKeyNodeList = {}
  for k, v in pairs(self.tbHideNormalNodeList) do
    self:UnbindCtrlByNode(v)
    self.tbHideNormalNodeList[k] = nil
  end
  self.tbHideNormalNodeList = {}
  for k, v in pairs(self.tbNodeList) do
    self:UnbindCtrlByNode(v)
    self.tbNodeList[k] = nil
  end
  self.tbNodeList = {}
  delChildren(self._mapNode.HideRoot)
  delChildren(self._mapNode.NodeContent)
end

function StarTowerGrowthCtrl:Awake()
  self.animRoot = self.gameObject.transform:GetComponent("Animator")
  self:InitData()
end

function StarTowerGrowthCtrl:OnEnable()
  local function callback()
    self:RefreshContent()
  end
  
  PlayerData.StarTower:SendTowerGrowthDetailReq(callback)
end

function StarTowerGrowthCtrl:OnDisable()
  self:ClearCtrl()
end

function StarTowerGrowthCtrl:OnDestroy()
end

function StarTowerGrowthCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nSelectGroupIndex then
    return
  end
  self.animRoot:Play("StarTowerGrowth_switch", 0, 0)
  local nState = self:GetTabState(self.nSelectGroupIndex)
  self._mapNode.tab[self.nSelectGroupIndex]:SetSelect(false, nState)
  if self.nSelectGroupIndex > 1 then
    self._mapNode.tab[self.nSelectGroupIndex - 1]:SetLine(true)
  end
  nState = self:GetTabState(nIndex)
  self._mapNode.tab[nIndex]:SetSelect(true, nState)
  if 1 < nIndex then
    self._mapNode.tab[nIndex - 1]:SetLine(false)
  end
  self.nSelectGroupIndex = nIndex
  self.nSelectGroupId = self.tbGroup[self.nSelectGroupIndex].nId
  self.nSelectCloumn = nil
  self.nSelectNodeId = nil
  self:RefreshTip()
  self:RefreshNode()
  self:CloseInfo()
end

function StarTowerGrowthCtrl:OnBtnClick_CloseInfo(btn)
  self:CloseInfo()
end

function StarTowerGrowthCtrl:OnBtnClick_Quest(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerQuest)
end

function StarTowerGrowthCtrl:OnBtnClick_ActiveAll(btn)
  local bAble, sTip = PlayerData.StarTower:CheckGroupReady(self.nSelectGroupId)
  if not bAble then
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  
  local function active()
    local function callback(tbActiveId, bHasCore)
      EventManager.Hit("Guide_SendTowerGrowthSuccess")
      
      if bHasCore then
        WwiseManger:PlaySound("ui_rogue_research_large_button")
      else
        WwiseManger:PlaySound("ui_rogue_research_small_button")
      end
      self:RefreshData()
      self:RefreshTopBar()
      local nPos = NovaAPI.GetHorizontalNormalizedPosition(self._mapNode.svNode)
      self:RefreshNode()
      NovaAPI.SetHorizontalNormalizedPosition(self._mapNode.svNode, nPos)
      self:AddTimer(1, bHasCore and 0.667 or 0.5, function()
        self:RefreshLock()
        local mapGroup = self.tbGroup[self.nSelectGroupIndex]
        if mapGroup.nAllNodeCount == mapGroup.nActiveNodeCount and self.nSelectGroupIndex < self.nGroupCount then
          self:OnBtnClick_Tab(nil, self.nSelectGroupIndex + 1)
        else
          self:MoveToFirst()
        end
      end, true, true, true)
      for _, v in pairs(self.tbNodeList) do
        v:PlayActiveAnimFromActive(tbActiveId)
      end
    end
    
    PlayerData.StarTower:SendTowerGrowthGroupNodeUnlockReq(self.nSelectGroupId, callback)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("STGrowth_Tips_ActiveAll"),
    callbackConfirm = active
  }
  if not PlayerData.Guide:CheckInGuideGroup(22) then
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    active()
  end
end

function StarTowerGrowthCtrl:OnBtnClick_ResearchPreview()
  local nDifficulty = PlayerData.StarTower:GetGlobalMaxDifficult()
  local nMaxDifficulty = nDifficulty
  self._mapNode.StarTowerGrowthPreviewWindow:OpenPanel(nDifficulty, nMaxDifficulty)
end

function StarTowerGrowthCtrl:OnEvent_Unlock()
  self:RefreshData()
  self:RefreshTopBar()
  local tbNodes = PlayerData.StarTower:GetGrowthNodesByGroup(self.nSelectGroupId)
  local tbCurNodeMap = self.tbNodeMap[self.nSelectGroupId]
  if self.nSelectCloumn == nil then
    return
  end
  self:RefreshNodeCloumn(self.nSelectCloumn, tbNodes, tbCurNodeMap)
  self:RefreshNodeCloumn(self.nSelectCloumn + 1, tbNodes, tbCurNodeMap)
  
  local function callback()
    self:RefreshLock()
    local mapGroup = self.tbGroup[self.nSelectGroupIndex]
    if mapGroup.nAllNodeCount == mapGroup.nActiveNodeCount and self.nSelectGroupIndex < self.nGroupCount then
      self:OnBtnClick_Tab(nil, self.nSelectGroupIndex + 1)
    end
  end
  
  self.tbNodeList[self.nSelectCloumn]:PlayActiveAnim(self.nSelectNodeId, callback)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    local tmpData = PlayerData.StarTower:GetGrowthNode(GUIDE_CHECK_NODE_ID)
    if tmpData ~= nil and tmpData.bActive then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_StarTowerGrowthIdActive")
    end
  end
  
  cs_coroutine.start(wait)
end

function StarTowerGrowthCtrl:OnEvent_Select(nId, nCloumn, goNode)
  if self.nSelectNodeId == nId then
    return
  end
  if self.nSelectNodeId and self.nSelectCloumn then
    self.tbNodeList[self.nSelectCloumn]:SetSelect(self.nSelectNodeId, false)
  end
  self.nSelectCloumn = nCloumn
  self.nSelectNodeId = nId
  self.tbNodeList[nCloumn]:SetSelect(nId, true)
  local tbNodes = PlayerData.StarTower:GetGrowthNodesByGroup(self.nSelectGroupId)
  if self._mapNode.Info.gameObject.activeSelf then
    self._mapNode.animInfo:Play("StarTowerGrowth_Info_out")
    self:AddTimer(1, 0.2, function()
      self._mapNode.Info:Refresh(tbNodes[nId])
      self:OpenInfo()
    end, true, true, true)
  else
    self._mapNode.Info:Refresh(tbNodes[nId])
    self:OpenInfo()
  end
  local mapCfg = ConfigTable.GetData("StarTowerGrowthNode", nId)
  if mapCfg then
    local rtTarget = mapCfg.Type == GameEnum.towerGrowthNodeType.Core and self._mapNode.rtKeyCenter or self._mapNode.rtNormalCenter
    self._mapNode.scNode:ScrollToRectTransform(goNode, rtTarget, 0.15)
  end
end

function StarTowerGrowthCtrl:OnEvent_Eye(bOpen)
  self._mapNode.eye_r:SetActive(bOpen)
end

function StarTowerGrowthCtrl:OnEvent_GuideSelectNote(nColumn, nIndex)
  if self.tbNodeList[nColumn] ~= nil then
    self.tbNodeList[nColumn]:Guide_SelectNode(nIndex)
  end
end

return StarTowerGrowthCtrl
