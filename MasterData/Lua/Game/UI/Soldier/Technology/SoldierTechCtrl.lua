local SoldierTechCtrl = class("SoldierTechCtrl", BaseCtrl)
SoldierTechCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnCloseInfo = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseInfo"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Detail_Btn"
  },
  txtActiveCount = {sComponentName = "TMP_Text"},
  svNode = {sComponentName = "ScrollRect"},
  goNodeContent = {
    sNodeName = "NodeContent"
  },
  TechNodeList = {},
  goTip = {},
  txtTipLock = {sComponentName = "TMP_Text"},
  goInfo = {sNodeName = "---Info---"},
  animInfo = {sNodeName = "---Info---", sComponentName = "Animator"},
  imgNormalBg = {},
  goNormalKeyNode = {
    sCtrlName = "Game.UI.Soldier.Technology.SoldierTechNodeCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgBossBg = {},
  imgCharHead = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  goPersonality = {nCount = 3},
  txtPersonality1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Instinct"
  },
  txtPersonality2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Analyze"
  },
  txtPersonality3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Chaos"
  },
  imgPersonalityPercent = {nCount = 3, sComponentName = "Image"},
  imgSkill = {sComponentName = "Image"},
  txtSkillName = {sComponentName = "TMP_Text"},
  txtSkillDetail = {sComponentName = "TMP_Text"},
  imgSkillInitiative = {},
  txtSkillInitiative = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Active"
  },
  imgSkillPassive = {},
  txtSkillPassive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Passive"
  },
  txtInfoTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Node_Detail_Title"
  },
  txtDesc = {nCount = 2, sComponentName = "TMP_Text"},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Node_Lock"
  },
  btnActiveNode = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActiveNode"
  },
  txtBtnActive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Node_Active_Btn"
  },
  goReqActive = {},
  imgReqActiveIcon = {sComponentName = "Image"},
  txtReqActiveCount = {sComponentName = "TMP_Text"},
  txtActived = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Node_Actived"
  }
}
SoldierTechCtrl._mapEventConfig = {
  SoldierTechNodeSelect = "OnEvent_SelectNode"
}
SoldierTechCtrl._mapRedDotConfig = {}

function SoldierTechCtrl:BuildIdMap(tbNodes)
  self.tbNodeMap = {}
  for _, v in pairs(tbNodes) do
    local mapCfg = ConfigTable.GetData("SoldierTechNode", v.nId)
    if mapCfg then
      local tbPos = mapCfg.Position
      local nCloumn = tbPos[1]
      local nIndex = tbPos[2]
      if not self.tbNodeMap[nCloumn] then
        self.tbNodeMap[nCloumn] = {
          tbId = {}
        }
      end
      self.tbNodeMap[nCloumn].tbId[nIndex] = v.nId
    end
  end
end

function SoldierTechCtrl:ClearNodeContent()
  self.tbNodeList = self.tbNodeList or {}
  self.tbHideNodeList = self.tbHideNodeList or {}
  if next(self.tbNodeList) == nil then
    return
  end
  for _, ctrlNodeList in ipairs(self.tbNodeList) do
    ctrlNodeList.gameObject:SetActive(false)
    table.insert(self.tbHideNodeList, ctrlNodeList)
  end
  self.tbNodeList = {}
end

function SoldierTechCtrl:RefreshActiveCount()
  local nAll, nActive = PlayerData.SoldierData:GetTechActiveNodeCount()
  NovaAPI.SetTMPText(self._mapNode.txtActiveCount, orderedFormat(ConfigTable.GetUIText("Soldier_Tech_Node_Active_Count") or "", nActive, nAll))
end

function SoldierTechCtrl:RefreshNodeList()
  local tbNodes = PlayerData.SoldierData:GetTechNodes()
  if not tbNodes then
    return
  end
  self:RefreshActiveCount()
  self:BuildIdMap(tbNodes)
  self:ClearNodeContent()
  for nCloumn, mapData in ipairs(self.tbNodeMap) do
    local ctrlObj
    local nHideCount = #self.tbHideNodeList
    if 0 < nHideCount then
      ctrlObj = self.tbHideNodeList[nHideCount]
      table.remove(self.tbHideNodeList, nHideCount)
      ctrlObj.gameObject:SetActive(true)
    else
      local goObj = instantiate(self._mapNode.TechNodeList, self._mapNode.goNodeContent.transform)
      goObj:SetActive(true)
      ctrlObj = self:BindCtrlByNode(goObj, "Game.UI.Soldier.Technology.SoldierTechNodeListCtrl")
    end
    ctrlObj.gameObject.transform:SetAsLastSibling()
    self.tbNodeList[nCloumn] = ctrlObj
    local mapNext = self.tbNodeMap[nCloumn + 1]
    ctrlObj:Refresh(nCloumn, tbNodes, mapData.tbId, mapNext)
    ctrlObj.gameObject.name = nCloumn
  end
end

function SoldierTechCtrl:CloseInfo()
  if self.nSelectNodeId and self.nSelectCloumn and self.tbNodeList[self.nSelectCloumn] then
    self.tbNodeList[self.nSelectCloumn]:SetSelect(self.nSelectNodeId, false)
  end
  self.nSelectNodeId = nil
  self.nSelectCloumn = nil
  self._mapNode.animInfo:Play("SoldierTechnologyPanelPopup_out")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animInfo, {
    "SoldierTechnologyPanelPopup_out"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  self:AddTimer(1, nAnimLen, function()
    self._mapNode.goInfo.gameObject:SetActive(false)
  end, true, true, true)
  self:_RestoreContentPadding()
end

local nScrollDuration = 0.25

function SoldierTechCtrl:_ApplyContentCenterPadding()
  local layoutGroup = self._mapNode.goNodeContent:GetComponent("HorizontalLayoutGroup")
  if not layoutGroup then
    return
  end
  local rtViewport = self._mapNode.svNode.viewport
  if not rtViewport then
    return
  end
  local curPad = layoutGroup.padding
  if self.nOriginPadLeft == nil then
    self.nOriginPadLeft = curPad.left
    self.nOriginPadRight = curPad.right
  end
  local nColWidth = 0
  for _, ctrl in pairs(self.tbNodeList) do
    local rt = ctrl.gameObject:GetComponent("RectTransform")
    if rt then
      nColWidth = rt.rect.width
      break
    end
  end
  local nPad = math.max(0, math.floor((rtViewport.rect.width - nColWidth) * 0.5))
  NovaAPI.SetLayoutGroupPadding(self._mapNode.goNodeContent, self.nOriginPadLeft, nPad, curPad.top, curPad.bottom)
end

function SoldierTechCtrl:_RestoreContentPadding()
  if self.nOriginPadLeft == nil then
    return
  end
  local layoutGroup = self._mapNode.goNodeContent:GetComponent("HorizontalLayoutGroup")
  if not layoutGroup then
    return
  end
  local curPad = layoutGroup.padding
  NovaAPI.SetLayoutGroupPadding(self._mapNode.goNodeContent, self.nOriginPadLeft, self.nOriginPadRight, curPad.top, curPad.bottom)
end

function SoldierTechCtrl:_GetMaxActiveColumn()
  if not self.tbNodeMap then
    return nil
  end
  for nCloumn = #self.tbNodeMap, 1, -1 do
    local mapData = self.tbNodeMap[nCloumn]
    if mapData and mapData.tbId then
      for _, nId in pairs(mapData.tbId) do
        local mapNode = PlayerData.SoldierData:GetTechNode(nId)
        if mapNode and mapNode.bActive then
          return nCloumn
        end
      end
    end
  end
  return nil
end

function SoldierTechCtrl:ScrollToColumn(nCloumn, bAnim)
  local ctrl = self.tbNodeList[nCloumn]
  if not ctrl then
    return
  end
  local rtColumn = ctrl.gameObject:GetComponent("RectTransform")
  local rtViewport = self._mapNode.svNode.viewport
  local rtContent = self._mapNode.svNode.content
  if not (rtColumn and rtViewport) or not rtContent then
    return
  end
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  local nViewportWidth = rtViewport.rect.width
  local nRange = rtContent.rect.width - nViewportWidth
  if nRange <= 0 then
    return
  end
  local nColumnWidth = rtColumn.rect.width
  local nColumnLeftX = rtColumn.anchoredPosition.x - nColumnWidth * rtColumn.pivot.x
  local nColumnCenterX = nColumnLeftX + nColumnWidth * 0.5
  local nTarget = math.max(0, math.min(1, (nColumnCenterX - nViewportWidth * 0.5) / nRange))
  if self.scrollTween then
    self.scrollTween:Kill(false)
    self.scrollTween = nil
  end
  if bAnim then
    local nFrom = self._mapNode.svNode.horizontalNormalizedPosition
    EventManager.Hit(EventId.TemporaryBlockInput, nScrollDuration)
    self.scrollTween = CS.DG.Tweening.DOVirtual.Float(nFrom, nTarget, nScrollDuration, function(v)
      self._mapNode.svNode.horizontalNormalizedPosition = v
    end)
  else
    self._mapNode.svNode.horizontalNormalizedPosition = nTarget
  end
end

function SoldierTechCtrl:Awake()
end

function SoldierTechCtrl:OnEnable()
  self._mapNode.goInfo:SetActive(false)
  PlayerData.SoldierData:SendSoldierTechDetailReq(function()
    self:RefreshNodeList()
    local nInitCloumn = self:_GetMaxActiveColumn()
    if nInitCloumn then
      cs_coroutine.start(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:ScrollToColumn(nInitCloumn, false)
      end)
    end
  end)
end

function SoldierTechCtrl:ClearCtrl()
  if self.scrollTween then
    self.scrollTween:Kill(false)
    self.scrollTween = nil
  end
  self:_RestoreContentPadding()
  self.nOriginPadLeft = nil
  self.nOriginPadRight = nil
  if self.tbNodeList then
    for k, v in pairs(self.tbNodeList) do
      self:UnbindCtrlByNode(v)
      self.tbNodeList[k] = nil
    end
  end
  if self.tbHideNodeList then
    for k, v in pairs(self.tbHideNodeList) do
      self:UnbindCtrlByNode(v)
      self.tbHideNodeList[k] = nil
    end
  end
  delChildren(self._mapNode.goNodeContent.transform)
end

function SoldierTechCtrl:OnDisable()
  self:ClearCtrl()
end

function SoldierTechCtrl:OnDestroy()
end

function SoldierTechCtrl:OnBtnClick_CloseInfo()
  self:CloseInfo()
end

function SoldierTechCtrl:OnBtnClick_Detail()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierTechPreviewPanel)
end

function SoldierTechCtrl:OnBtnClick_ActiveNode()
  if not self.nSelectNodeId then
    return
  end
  local nId = self.nSelectNodeId
  local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
  if not mapCfg then
    return
  end
  local nItemId = mapCfg.ItemId1
  local nItemQty = mapCfg.ItemQty1
  if nItemId and 0 < nItemId and nItemQty and 0 < nItemQty then
    local nHas = PlayerData.Item:GetItemCountByID(nItemId)
    if nItemQty > nHas then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Tech_Node_Active_Not_Enough"))
      return
    end
  end
  PlayerData.SoldierData:SendSoldierTechNodeUnlockReq(nId, function()
    self:RefreshNodeList()
    if self.nSelectNodeId and self.nSelectCloumn and self.tbNodeList[self.nSelectCloumn] then
      self.tbNodeList[self.nSelectCloumn]:SetSelect(self.nSelectNodeId, true)
    end
    if self.nSelectNodeId == nId then
      self:RefreshInfo(nId)
    end
  end)
end

function SoldierTechCtrl:RefreshReqActive(mapCfg, bActive)
  local nItemId = mapCfg.ItemId1
  local nItemQty = mapCfg.ItemQty1
  local bShow = not bActive and nItemId and 0 < nItemId and nItemQty and 0 < nItemQty
  self._mapNode.goReqActive:SetActive(bShow)
  if not bShow then
    return
  end
  local mapItem = ConfigTable.GetData_Item(nItemId)
  if mapItem then
    self:SetPngSprite(self._mapNode.imgReqActiveIcon, mapItem.Icon2)
  end
  local nHas = PlayerData.Item:GetItemCountByID(nItemId)
  NovaAPI.SetTMPText(self._mapNode.txtReqActiveCount, tostring(nItemQty))
  NovaAPI.SetTMPColor(self._mapNode.txtReqActiveCount, nItemQty > nHas and Red_Unable or Blue_Normal)
end

function SoldierTechCtrl:RefreshInfo(nId)
  local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
  if not mapCfg then
    return
  end
  local mapNode = PlayerData.SoldierData:GetTechNode(nId)
  local nType = mapCfg.Type
  local bBoss = nType == GameEnum.SoldierTechNodeType.BossAbility
  self._mapNode.imgNormalBg:SetActive(not bBoss)
  self._mapNode.imgBossBg:SetActive(bBoss)
  if bBoss then
    local nBossId = mapCfg.Param
    local mapBoss = nBossId and ConfigTable.GetData("SoldierBossTemplate", nBossId)
    NovaAPI.SetTMPText(self._mapNode.txtCharName, mapBoss and mapBoss.Name or mapCfg.Name)
    if mapBoss then
      self:SetPngSprite(self._mapNode.imgCharHead, mapBoss.SoldierPlayerHead)
      NovaAPI.SetTMPText(self._mapNode.txtSkillName, mapBoss.Title or "")
      NovaAPI.SetTMPText(self._mapNode.txtDesc[2], mapBoss.Desc)
      local nSkillType = mapBoss.SoldierRoleSkillType
      self._mapNode.imgSkillPassive.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3)
      self._mapNode.imgSkillInitiative.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4)
      local showCfg = AllEnum.SoldierBossSkillType[nSkillType]
      if showCfg ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtSkillDetail, ConfigTable.GetUIText(showCfg.sLanguageId))
      end
      for i = 1, 3 do
        local nType = 0
        if i == 1 then
          nType = mapBoss.Personality_Intuition
        elseif i == 2 then
          nType = mapBoss.Personality_Analysis
        elseif i == 3 then
          nType = mapBoss.Personality_Chaos
        end
        local mapGradeCfg = ConfigTable.GetData("SoldierBossPersonalityGrade", nType)
        if mapGradeCfg ~= nil then
          self:SetPngSprite(self._mapNode.imgPersonalityPercent[i], mapGradeCfg.Icon)
        end
      end
    end
    self:SetPngSprite(self._mapNode.imgSkill, mapBoss.SoldierRoleSkillIcon)
  else
    NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
    self._mapNode.goNormalKeyNode:Refresh(nId, mapNode, true)
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc[1], mapCfg.Desc)
  local bActive = mapNode and mapNode.bActive
  local bReady = mapNode and mapNode.bReady
  self._mapNode.txtActived.gameObject:SetActive(bActive)
  self._mapNode.btnActiveNode.gameObject:SetActive(not bActive and bReady)
  self._mapNode.txtLock.gameObject:SetActive(not bActive and not bReady)
  self:RefreshReqActive(mapCfg, bActive)
end

function SoldierTechCtrl:OnEvent_SelectNode(nId, nCloumn, goNode)
  if self.nSelectNodeId == nId then
    return
  end
  if self.nSelectNodeId and self.nSelectCloumn and self.tbNodeList[self.nSelectCloumn] then
    self.tbNodeList[self.nSelectCloumn]:SetSelect(self.nSelectNodeId, false)
  end
  self.nSelectCloumn = nCloumn
  self.nSelectNodeId = nId
  if self.tbNodeList[nCloumn] then
    self.tbNodeList[nCloumn]:SetSelect(nId, true)
  end
  self:RefreshInfo(nId)
  self._mapNode.goInfo:SetActive(true)
  self:_ApplyContentCenterPadding()
  self:ScrollToColumn(nCloumn, true)
end

return SoldierTechCtrl
