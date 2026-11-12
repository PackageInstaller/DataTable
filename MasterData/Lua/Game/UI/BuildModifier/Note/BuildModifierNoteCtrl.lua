local BuildModifierNoteCtrl = class("BuildModifierNoteCtrl", BaseCtrl)
BuildModifierNoteCtrl._mapNodeConfig = {
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgNote = {sComponentName = "Image", nCount = 13},
  txtNoteCount = {sComponentName = "TMP_Text", nCount = 13},
  txtAttr = {sComponentName = "TMP_Text"},
  txtPotential = {sComponentName = "TMP_Text"},
  MusicalLSV = {
    sComponentName = "LoopScrollView"
  },
  goSkillList = {
    sCtrlName = "Game.UI.BuildModifier.Note.BuildModifierNoteSkillListCtrl"
  },
  imgTickets = {sComponentName = "Image"},
  txtTicketsCountRaidUnlock = {sComponentName = "TMP_Text"},
  btnEdit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Apply"
  },
  btnEditNo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoApply"
  },
  btnNoteDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  txtNoteDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_NoteInfo"
  },
  txtBtnBuy = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "BtnBuildModifier_Confirm"
  }
}
BuildModifierNoteCtrl._mapEventConfig = {
  BuildModifier_NoteCountChange = "OnEvent_NoteCountChange"
}
BuildModifierNoteCtrl._mapRedDotConfig = {}

function BuildModifierNoteCtrl:Awake()
  self.mapNoteCtrl = {}
  self._panel.totalChangeCount = ConfigTable.GetConfigNumber("BuildNoteModifierPointMax")
  self._panel.tbNeedCoin = ConfigTable.GetConfigNumberArray("BuildNoteModifierItem")
end

function BuildModifierNoteCtrl:FadeIn()
end

function BuildModifierNoteCtrl:FadeOut()
end

function BuildModifierNoteCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nBuildId = tbParam[1]
  
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
    if mapBuild.bLock or mapBuild.nModifierState ~= AllEnum.BuildModifierState.NotModified and mapBuild.nModifierState ~= AllEnum.BuildModifierState.PotentialModified then
      cs_coroutine.start(wait2)
      return
    end
    if not self._panel.bHasData then
      self._panel.bHasData = true
      self._panel.totalAddCount = 0
      self._panel.totalSubCount = 0
      self._mapBuild = mapBuild
      self._panel.mapNoteOrigin = self._mapBuild.tbNotes
      self._panel.mapNoteAfter = clone(self._mapBuild.tbNotes)
    end
    self:RefreshMusicSkillList()
    self:SetNoteHint()
    self._mapNode.goSkillList:Refresh(self._mapBuild.tbDisc, self._panel.mapNoteOrigin, self._panel.mapNoteAfter)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
  self._mapNode.TopBarPanel:CreateCoin({
    self._panel.tbNeedCoin[1]
  })
  local nCurCoinCount = PlayerData.Item:GetItemCountByID(self._panel.tbNeedCoin[1])
  local sCount = ""
  if nCurCoinCount >= self._panel.tbNeedCoin[2] then
    sCount = tostring(self._panel.tbNeedCoin[2])
  else
    sCount = string.format("<color=#fa4e6c>%d</color>", self._panel.tbNeedCoin[2])
  end
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCountRaidUnlock, sCount)
  self:SetSprite_Coin(self._mapNode.imgTickets, self._panel.tbNeedCoin[1])
  self:SetApplyButton()
end

function BuildModifierNoteCtrl:OnDisable()
  for _, mapCtrl in pairs(self.mapNoteCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapNoteCtrl = {}
end

function BuildModifierNoteCtrl:OnDestroy()
end

function BuildModifierNoteCtrl:OnRelease()
end

function BuildModifierNoteCtrl:SetApplyButton()
  local bEnable = true
  if self._panel.totalAddCount ~= self._panel.totalSubCount then
    bEnable = false
  end
  if self._panel.totalAddCount == 0 and self._panel.totalSubCount == 0 then
    bEnable = false
  end
  self._mapNode.btnEdit.gameObject:SetActive(bEnable)
  self._mapNode.btnEditNo.gameObject:SetActive(not bEnable)
end

function BuildModifierNoteCtrl:GetShowNoteIds()
  local tbNote = {}
  local tbNoteTop = {}
  
  local function foreachNote(mapData)
    table.insert(tbNote, mapData)
    table.insert(tbNoteTop, mapData)
  end
  
  ForEachTableLine(DataTable.SubNoteSkill, foreachNote)
  
  local function sortTop(a, b)
    return a.Id < b.Id
  end
  
  table.sort(tbNoteTop, sortTop)
  local tbChar = self._mapBuild.tbChar
  local tbElement = {}
  for i = 1, 3 do
    if tbChar[i] ~= nil then
      local mapCharCfg = ConfigTable.GetData_Character(tbChar[i].nTid)
      if mapCharCfg ~= nil and 1 > table.indexof(tbElement, mapCharCfg.EET) then
        table.insert(tbElement, mapCharCfg.EET)
      end
    end
  end
  
  local function sortNote(a, b)
    local eiA = table.indexof(tbElement, a.ElemType)
    local eiB = table.indexof(tbElement, b.ElemType)
    if eiA ~= eiB then
      if eiA * eiB == 0 then
        return eiA ~= 0
      else
        return eiA < eiB
      end
    end
    return a.Id < b.Id
  end
  
  table.sort(tbNote, sortNote)
  return tbNote, tbNoteTop
end

function BuildModifierNoteCtrl:RefreshMusicSkillList()
  self.tbShowNoteId, self.tbShowNoteIdTop = self:GetShowNoteIds()
  self:RefreshTop()
  self._mapNode.MusicalLSV:Init(#self.tbShowNoteId, self, self.OnGridRefreshNote)
end

function BuildModifierNoteCtrl:OnGridRefreshNote(goGrid, nIdx)
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapNoteCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BuildModifier.Note.BuildModifierNoteListGridCtrl")
    self.mapNoteCtrl[nInstanceId] = objCtrl
  end
  nIdx = nIdx + 1
  local nNoteId = self.tbShowNoteId[nIdx].Id
  local nCurCount = self._panel.mapNoteAfter[nNoteId] or 0
  local nOriginCount = self._panel.mapNoteOrigin[nNoteId] or 0
  objCtrl:Refresh(nNoteId, nOriginCount, nCurCount)
  objCtrl:OnEvent_GridRangeChange(self._panel.totalChangeCount, self._panel.totalAddCount, self._panel.totalSubCount)
end

function BuildModifierNoteCtrl:RefreshTop()
  for i = 1, 13 do
    if self.tbShowNoteIdTop[i] ~= nil then
      self._mapNode.imgNote[i].gameObject:SetActive(true)
      local sNoteIconPath = self.tbShowNoteIdTop[i].Icon .. AllEnum.DiscSkillIconSurfix.Small
      self:SetPngSprite(self._mapNode.imgNote[i], sNoteIconPath)
      local nCount = self._panel.mapNoteAfter[self.tbShowNoteIdTop[i].Id] or 0
      local nOriginCount = self._panel.mapNoteOrigin[self.tbShowNoteIdTop[i].Id] or 0
      local sValue
      if nCount > nOriginCount then
        sValue = orderedFormat("<color=#b7d65d>{0}</color>", nCount)
      elseif nCount < nOriginCount then
        sValue = orderedFormat("<color=#fa4e6c>{0}</color>", nCount)
      else
        sValue = orderedFormat("{0}", nCount)
      end
      NovaAPI.SetTMPText(self._mapNode.txtNoteCount[i], sValue)
    else
      self._mapNode.imgNote[i].gameObject:SetActive(false)
    end
  end
end

function BuildModifierNoteCtrl:SetNoteHint()
  local sFreeNote = orderedFormat(ConfigTable.GetUIText("BuildModifier_FreeNote"), self._panel.totalSubCount - self._panel.totalAddCount)
  NovaAPI.SetTMPText(self._mapNode.txtPotential, sFreeNote)
  NovaAPI.SetTMPText(self._mapNode.txtAttr, orderedFormat(ConfigTable.GetUIText("BuildModifier_TotalFixableNote"), self._panel.totalChangeCount, math.max(self._panel.totalAddCount, self._panel.totalSubCount)))
end

function BuildModifierNoteCtrl:OnEvent_NoteCountChange(nNoteId, nCount)
  self._panel.mapNoteAfter[nNoteId] = nCount
  self:RefreshTop()
  local nAdd = 0
  local nSub = 0
  for _, mapNote in ipairs(self.tbShowNoteId) do
    local nCurCount = self._panel.mapNoteAfter[mapNote.Id] or 0
    local nOriginCount = self._panel.mapNoteOrigin[mapNote.Id] or 0
    if nCurCount < nOriginCount then
      nSub = nSub + (nOriginCount - nCurCount)
    elseif nCurCount > nOriginCount then
      nAdd = nAdd + (nCurCount - nOriginCount)
    end
  end
  self._panel.totalAddCount = nAdd
  self._panel.totalSubCount = nSub
  EventManager.Hit("BuildModifier_GridRangeChange", self._panel.totalChangeCount, self._panel.totalAddCount, self._panel.totalSubCount)
  self:SetNoteHint()
  self._mapNode.goSkillList:OnNoteChange()
  self:SetApplyButton()
end

function BuildModifierNoteCtrl:OnBtnClick_Apply()
  local nCurCoinCount = PlayerData.Item:GetItemCountByID(self._panel.tbNeedCoin[1])
  if nCurCoinCount < self._panel.tbNeedCoin[2] then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_NoteTips3"))
    return
  end
  local nFixNumber = math.max(self._panel.totalAddCount, self._panel.totalSubCount)
  local sContent
  if nFixNumber < self._panel.totalChangeCount then
    sContent = orderedFormat(ConfigTable.GetUIText("BuildModifier_NoteTips4"), self._panel.totalChangeCount - nFixNumber)
  else
    sContent = orderedFormat(ConfigTable.GetUIText("BuildModifier_NoteTips5"))
  end
  
  local function ConfirmCallback()
    local function netCallback(bFail)
      if bFail == true then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_PotentialTips7"))
        
        return
      end
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_NoteTips6"))
      EventManager.Hit(EventId.ClosePanel, PanelId.BuildModifierMusicPanel)
    end
    
    local tbNoteChange = {}
    for _, mapNote in ipairs(self.tbShowNoteId) do
      local nCurCount = self._panel.mapNoteAfter[mapNote.Id] or 0
      local nOriginCount = self._panel.mapNoteOrigin[mapNote.Id] or 0
      if nCurCount ~= nOriginCount then
        table.insert(tbNoteChange, {
          Tid = mapNote.Id,
          Qty = nCurCount - nOriginCount
        })
      end
    end
    PlayerData.Build:ModifyBuildNote(self._mapBuild.nBuildId, tbNoteChange, netCallback)
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

function BuildModifierNoteCtrl:OnBtnClick_NoApply()
  if self._panel.totalAddCount ~= self._panel.totalSubCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_NoteTips2"))
  end
  if self._panel.totalAddCount == 0 and self._panel.totalSubCount == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BuildModifier_NoteTips1"))
  end
end

function BuildModifierNoteCtrl:OnBtnClick_NoteDetail()
  local mapNote = {}
  local tbNote = {}
  
  local function foreachNote(mapData)
    table.insert(tbNote, mapData.Id)
  end
  
  ForEachTableLine(DataTable.SubNoteSkill, foreachNote)
  for _, nNoteId in ipairs(tbNote) do
    local nCount = self._panel.mapNoteAfter[nNoteId] or 0
    mapNote[nNoteId] = nCount
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkillInfo, mapNote)
end

return BuildModifierNoteCtrl
