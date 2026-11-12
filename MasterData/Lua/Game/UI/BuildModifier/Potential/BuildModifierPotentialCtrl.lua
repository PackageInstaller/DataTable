local BuildModifierPotentialCtrl = class("BuildModifierPotentialCtrl", BaseCtrl)
BuildModifierPotentialCtrl._mapNodeConfig = {
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgEmptyChar = {nCount = 3},
  imgCharBg = {nCount = 3},
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  txtCharName = {nCount = 3, sComponentName = "TMP_Text"},
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  txtnum = {nCount = 3, sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Member"
  },
  PotentialDepotItem = {},
  PotentialList = {
    nCount = 3,
    sCtrlName = "Game.UI.BuildModifier.Potential.CharPotentialListCtrl"
  },
  imgTickets = {sComponentName = "Image"},
  txtTicketsCountRaidUnlock = {sComponentName = "TMP_Text"},
  btnEditNo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoApply"
  },
  btnEdit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Apply"
  },
  txtPotential = {sComponentName = "TMP_Text"},
  txtAttr = {sComponentName = "TMP_Text"},
  txtBtnBuy = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "BtnBuildModifier_Confirm"
  }
}
BuildModifierPotentialCtrl._mapEventConfig = {
  BuildModifier_ClickPotentialItem = "OnEvent_ClickPotentialItem"
}
BuildModifierPotentialCtrl._mapRedDotConfig = {}

function BuildModifierPotentialCtrl:Awake()
  self.nTotalFixCount = ConfigTable.GetConfigNumber("BuildPotentialModifierPointMax")
  self.tbNeedCoin = ConfigTable.GetConfigNumberArray("BuildPotentialModifierItem")
end

function BuildModifierPotentialCtrl:FadeIn()
end

function BuildModifierPotentialCtrl:FadeOut()
end

function BuildModifierPotentialCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nBuildId = tbParam[1]
  self._mapNode.PotentialDepotItem:SetActive(false)
  
  local function GetBuildCallback(mapBuild)
    local function wait1()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      EventManager.Hit(EventId.ClosePanel, PanelId.BuildModifierPotentialPanel)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_BuildError1"))
    end
    
    local function wait2()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, PanelId.BuildModifierPotentialPanel)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_BuildError2"))
    end
    
    if mapBuild == nil then
      cs_coroutine.start(wait1)
      return
    end
    if mapBuild.bLock or mapBuild.nModifierState ~= AllEnum.BuildModifierState.NotModified and mapBuild.nModifierState ~= AllEnum.BuildModifierState.NoteModified then
      cs_coroutine.start(wait2)
      return
    end
    self._mapBuild = mapBuild
    if not self._panel.hasData then
      self._panel.hasData = true
      self._panel.mapPotentialOrigin = {}
      self._panel.mapEquipmentAddLevel = {}
      for nCharId, tbPotentials in pairs(self._mapBuild.tbPotentials) do
        self._panel.mapEquipmentAddLevel[nCharId] = PlayerData.Equipment:GetEnhancedPotential(nCharId)
        if self._panel.mapPotentialOrigin[nCharId] == nil then
          self._panel.mapPotentialOrigin[nCharId] = {
            nTotalCount = 0,
            mapCount = {}
          }
        end
        for _, mapPotential in ipairs(tbPotentials) do
          self._panel.mapPotentialOrigin[nCharId].mapCount[mapPotential.nPotentialId] = mapPotential.nLevel
          self._panel.mapPotentialOrigin[nCharId].nTotalCount = self._panel.mapPotentialOrigin[nCharId].nTotalCount + mapPotential.nLevel
        end
      end
      self._panel.mapPotentialAfter = clone(self._panel.mapPotentialOrigin)
    end
    self:Refresh()
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
  self._mapNode.TopBarPanel:CreateCoin({
    self.tbNeedCoin[1]
  })
  local nCurCoinCount = PlayerData.Item:GetItemCountByID(self.tbNeedCoin[1])
  local sCount = ""
  if nCurCoinCount >= self.tbNeedCoin[2] then
    sCount = tostring(self.tbNeedCoin[2])
  else
    sCount = string.format("<color=#fa4e6c>%d</color>", self.tbNeedCoin[2])
  end
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCountRaidUnlock, sCount)
  self:SetSprite_Coin(self._mapNode.imgTickets, self.tbNeedCoin[1])
  self:SetBtnState()
end

function BuildModifierPotentialCtrl:OnDisable()
end

function BuildModifierPotentialCtrl:OnDestroy()
end

function BuildModifierPotentialCtrl:OnRelease()
end

function BuildModifierPotentialCtrl:SetHint()
end

function BuildModifierPotentialCtrl:Refresh()
  for i = 1, 3 do
    local bEmpty = false
    self._mapNode.imgEmptyChar[i].gameObject:SetActive(bEmpty)
    self._mapNode.imgCharBg[i].gameObject:SetActive(not bEmpty)
    self._mapNode.txtPotentialCount[i].gameObject:SetActive(not bEmpty)
    local nCharId = self._mapBuild.tbChar[i].nTid
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg ~= nil then
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
      self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
      self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
      self:SetAtlasSprite(self._mapNode.imgCharElement[i], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
      NovaAPI.SetTMPText(self._mapNode.txtCharName[i], mapCharCfg.Name)
      NovaAPI.SetTMPText(self._mapNode.txtnum[i], "")
      self:SetCharPotentialTotalCount(nCharId, i)
    end
    local mapAddLevel = self._panel.mapEquipmentAddLevel[nCharId]
    self._mapNode.PotentialList[i]:RefreshPotential(nCharId, self._panel.mapPotentialOrigin[nCharId].mapCount, self._panel.mapPotentialAfter[nCharId].mapCount, mapAddLevel, self._mapNode.PotentialDepotItem)
  end
  self:SetPotentialHint()
end

function BuildModifierPotentialCtrl:SetCharPotentialTotalCount(nCharId, nIdx)
  local nTotalCountOrigin = self._panel.mapPotentialOrigin[nCharId].nTotalCount
  local nTotalCountAfter = self._panel.mapPotentialAfter[nCharId].nTotalCount
  local sCount1
  if nTotalCountOrigin > nTotalCountAfter then
    sCount1 = string.format("<color=#fa4e6c>-%d</color>", nTotalCountOrigin - nTotalCountAfter)
  elseif nTotalCountOrigin < nTotalCountAfter then
    sCount1 = string.format("<color=#10D2D4>+%d</color>", nTotalCountAfter - nTotalCountOrigin)
  else
    sCount1 = ""
  end
  NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[nIdx], nTotalCountOrigin)
  NovaAPI.SetTMPText(self._mapNode.txtnum[nIdx], sCount1)
end

function BuildModifierPotentialCtrl:PotentialCountChange(nPotentialId, nCurCount)
  local mapPotentialCfg = ConfigTable.GetData("Potential", nPotentialId)
  if mapPotentialCfg == nil then
    return
  end
  local nCharId = mapPotentialCfg.CharId
  local nBeforCount = self._panel.mapPotentialAfter[nCharId].mapCount[nPotentialId] or 0
  local nSub = nCurCount - nBeforCount
  self._panel.mapPotentialAfter[nCharId].nTotalCount = self._panel.mapPotentialAfter[nCharId].nTotalCount + nSub
  self._panel.mapPotentialAfter[nCharId].mapCount[nPotentialId] = nCurCount
  local nCountOrigin = self._panel.mapPotentialOrigin[nCharId].mapCount[nPotentialId] or 0
  local nSubOrigin = nCurCount - nCountOrigin
  self._panel.mapChangedPotential[nPotentialId] = nSubOrigin ~= 0 and nSubOrigin or nil
  self._panel.nTotalAddCount = 0
  self._panel.nTotalReduceCount = 0
  for _, nSubCount in pairs(self._panel.mapChangedPotential) do
    if 0 < nSubCount then
      self._panel.nTotalAddCount = self._panel.nTotalAddCount + nSubCount
    elseif nSubCount < 0 then
      self._panel.nTotalReduceCount = self._panel.nTotalReduceCount + math.abs(nSubCount)
    end
  end
  for i = 1, 3 do
    local nCharId = self._mapBuild.tbChar[i].nTid
    self._mapNode.PotentialList[i]:RefreshPotentialCount(self._panel.mapPotentialOrigin[nCharId].mapCount, self._panel.mapPotentialAfter[nCharId].mapCount, self._panel.mapPotentialAfter[nCharId].nTotalCount)
    self:SetCharPotentialTotalCount(nCharId, i)
  end
  self:SetPotentialHint()
  self:SetBtnState()
end

function BuildModifierPotentialCtrl:SetPotentialHint()
  local sFreePotential = orderedFormat(ConfigTable.GetUIText("BuildModifier_FreePotential"), self._panel.nTotalReduceCount - self._panel.nTotalAddCount)
  NovaAPI.SetTMPText(self._mapNode.txtPotential, sFreePotential)
  NovaAPI.SetTMPText(self._mapNode.txtAttr, orderedFormat(ConfigTable.GetUIText("BuildModifier_TotalFixablePotential"), self.nTotalFixCount, math.max(self._panel.nTotalAddCount, self._panel.nTotalReduceCount)))
end

function BuildModifierPotentialCtrl:SetBtnState()
  local bEnable = true
  if self._panel.nTotalAddCount ~= self._panel.nTotalReduceCount then
    bEnable = false
  end
  if self._panel.nTotalAddCount == 0 and self._panel.nTotalReduceCount == 0 then
    bEnable = false
  end
  self._mapNode.btnEdit.gameObject:SetActive(bEnable)
  self._mapNode.btnEditNo.gameObject:SetActive(not bEnable)
end

function BuildModifierPotentialCtrl:OnBtnClick_Apply()
  local nCurCoinCount = PlayerData.Item:GetItemCountByID(self.tbNeedCoin[1])
  if nCurCoinCount < self.tbNeedCoin[2] then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_PotentialTips3"))
    return
  end
  local nFixNumber = math.max(self._panel.nTotalAddCount, self._panel.nTotalReduceCount)
  local sContent
  if nFixNumber < self.nTotalFixCount then
    sContent = orderedFormat(ConfigTable.GetUIText("BuildModifier_PotentialTips4"), self.nTotalFixCount - nFixNumber)
  else
    sContent = orderedFormat(ConfigTable.GetUIText("BuildModifier_PotentialTips5"))
  end
  
  local function ConfirmCallback()
    local function netCallback(bFail)
      if bFail == true then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_PotentialTips7"))
        
        return
      end
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_PotentialTips6"))
      EventManager.Hit(EventId.ClosePanel, PanelId.BuildModifierPotentialPanel)
    end
    
    local tbPotentialChange = {}
    for nPotentialId, nSubCount in pairs(self._panel.mapChangedPotential) do
      table.insert(tbPotentialChange, {Tid = nPotentialId, Qty = nSubCount})
    end
    PlayerData.Build:ModifyBuildPotential(self._mapBuild.nBuildId, tbPotentialChange, netCallback)
  end
  
  local function CancelCallback()
  end
  
  local data = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sContent,
    sContentSub = "",
    callbackConfirm = ConfirmCallback,
    callbackCancel = CancelCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, data)
end

function BuildModifierPotentialCtrl:OnBtnClick_NoApply()
  if self._panel.nTotalAddCount ~= self._panel.nTotalReduceCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_PotentialTips2"))
  end
  if self._panel.nTotalAddCount == 0 and self._panel.nTotalReduceCount == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_PotentialTips1"))
  end
end

function BuildModifierPotentialCtrl:OnEvent_ClickPotentialItem(nPotentialId)
  local mapPotentialCfg = ConfigTable.GetData("Potential", nPotentialId)
  if mapPotentialCfg == nil then
    return
  end
  local nCharId = mapPotentialCfg.CharId
  local nOriginLevel = self._panel.mapPotentialOrigin[nCharId].mapCount[nPotentialId] or 0
  local nAfterLevel = self._panel.mapPotentialAfter[nCharId].mapCount[nPotentialId] or 0
  local nAddLevel = self._panel.mapEquipmentAddLevel[nCharId][nPotentialId] or 0
  
  local function callback(bChange, nPotentialId, nCurCount)
    if not bChange then
      return
    end
    self:PotentialCountChange(nPotentialId, nCurCount)
  end
  
  local nSub = self._panel.mapChangedPotential[nPotentialId] or 0
  local nFixedAdd = self.nTotalFixCount - (self._panel.nTotalAddCount - (0 < nSub and nSub or 0))
  local nFixedReduce = self.nTotalFixCount - (self._panel.nTotalReduceCount - (nSub < 0 and math.abs(nSub) or 0))
  local nFreePoint = self._panel.nTotalReduceCount - self._panel.nTotalAddCount
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildModifierPopupPanel, nPotentialId, nOriginLevel, nAfterLevel, nAddLevel, math.min(self._panel.nMaxPotentialLevel, nAfterLevel + nFreePoint), math.max(1, nOriginLevel - nFixedReduce), nFreePoint, callback)
end

return BuildModifierPotentialCtrl
