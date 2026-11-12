local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharacterRecordCtrl = class("CharacterRecordCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
CharacterRecordCtrl._mapNodeConfig = {
  txtCalInfoHeight = {sComponentName = "TMP_Text"},
  rtTxtCalInfoHeight = {
    sNodeName = "txtCalInfoHeight",
    sComponentName = "RectTransform"
  },
  txtCalInfoWidth = {sComponentName = "TMP_Text"},
  rtTxtCalInfoWidth = {
    sNodeName = "txtCalInfoWidth",
    sComponentName = "RectTransform"
  },
  loopRecordList = {
    sNodeName = "RecordList",
    sComponentName = "LoopScrollView"
  },
  goRecordList = {sNodeName = "RecordList", sComponentName = "GameObject"},
  goVoice = {sNodeName = "Voice", sComponentName = "GameObject"},
  goPlotRoot = {sNodeName = "PlotRoot", sComponentName = "GameObject"},
  ctlPlotRoot = {
    sNodeName = "PlotRoot",
    sCtrlName = "Game.UI.CharacterRecord.CharacterPlotCtrl"
  },
  loopscVoice = {
    sNodeName = "scVoice",
    sComponentName = "LoopScrollView"
  },
  recordTog = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTab"
  },
  ctrlTog = {
    nCount = 3,
    sNodeName = "recordTog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  togRedDot = {nCount = 4},
  txtContentSize = {sComponentName = "TMP_Text"},
  rectContentSize = {
    sNodeName = "txtContentSize",
    sComponentName = "RectTransform"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  }
}
CharacterRecordCtrl._mapEventConfig = {
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.LookUpCharStory] = "OnEvent_OpenStoryPanel",
  [EventId.AffinityChange] = "OnEvent_AffinityChange",
  [EventId.WWiseVoiceEnd] = "OnEvent_WWiseVoiceEnd"
}
local RecordTogType = {
  RecordInfo = 1,
  Voice = 2,
  Plot = 3
}
local InfoGridSize = {
  Info = 88,
  InfoSpacing = 7,
  InfoGrid = 50,
  Lock = 60,
  Special = 137,
  Normal = 124
}
local VoiceGridSize = {Title = 50, Voice = 118.5}
local gridBottom = 42
local nInfoContentMaxWidth = 860

function CharacterRecordCtrl:Awake()
  self.tbGridCtrl = {}
end

function CharacterRecordCtrl:OnEnable()
  self.tbGridCtrl = {}
  self.InitState = {}
  self.InfoGrid = self._mapNode.goRecordList.transform:Find("grid")
  self.curPlayingId = 0
  self.tbVoicePlayingObj = {}
  self:InitTog()
end

function CharacterRecordCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  self.tbVoicePlayingObj = {}
  self.curPlayingId = 0
  if self.curCharId == nil then
    return
  end
  PlayerData.Char:UpdateCharVoiceReddot(self.curCharId, true)
  PlayerData.Char:UpdateCharRecordReddot(self.curCharId, true)
  PlayerData.Char:ResetArchiveContentUpdateRedDot(self.curCharId)
  self:OnStopCharVoice()
  self.bResetTog = true
end

function CharacterRecordCtrl:RegisterTogRedDot(nCharId)
  RedDotManager.RegisterNode(RedDotDefine.Role_Record_Info, nCharId, self._mapNode.togRedDot[1])
  RedDotManager.RegisterNode(RedDotDefine.Role_Record_Voice, nCharId, self._mapNode.togRedDot[2])
  RedDotManager.RegisterNode(RedDotDefine.Role_AffinityPlot, nCharId, self._mapNode.togRedDot[3])
  RedDotManager.RegisterNode(RedDotDefine.Role_RecordReward, nCharId, self._mapNode.togRedDot[4])
end

function CharacterRecordCtrl:RegisterInfoRedDot(charId, characterArchiveId, redDot, bRebind)
  RedDotManager.RegisterNode(RedDotDefine.Role_Record_Info_Item, {charId, characterArchiveId}, redDot, nil, nil, bRebind)
end

function CharacterRecordCtrl:RegisterInfoUpdateRedDot(charId, characterArchiveId, redDot, bRebind)
  RedDotManager.RegisterNode(RedDotDefine.Role_Record_InfoUpdate_Item, {charId, characterArchiveId}, redDot, nil, nil, bRebind)
end

function CharacterRecordCtrl:RegisterBaseInfoUpdateRedDot(charId, redDot, bRebind)
  RedDotManager.RegisterNode(RedDotDefine.Role_Record_BaseInfoUpdate_Item, charId, redDot, nil, nil, bRebind)
end

function CharacterRecordCtrl:RegisterVoiceRedDot(charId, characterArchiveId, redDot, bRebind)
  RedDotManager.RegisterNode(RedDotDefine.Role_Record_Voice_Item, {charId, characterArchiveId}, redDot, nil, nil, bRebind)
end

function CharacterRecordCtrl:RegisterRewardRedDot(nCharId, characterArchiveId, redDot, bRebind)
  RedDotManager.RegisterNode(RedDotDefine.Role_RecordRewardItem, {nCharId, characterArchiveId}, redDot, nil, nil, bRebind)
end

function CharacterRecordCtrl:InitTog()
  self._mapNode.ctrlTog[1]:SetText(ConfigTable.GetUIText("CharacterRelation_Tog_1"))
  self._mapNode.ctrlTog[2]:SetText(ConfigTable.GetUIText("CharacterRelation_Tog_2"))
  self._mapNode.ctrlTog[3]:SetText(ConfigTable.GetUIText("CharacterRelation_Tog_3"))
end

function CharacterRecordCtrl:Refresh(nCharId)
  if nil ~= self.curCharId and self.curCharId ~= nCharId then
    self.InitState = {}
    self:OnStopCharVoice()
    self:OnStopCharVoiceBubble()
  end
  local bReset = self.nCurTog == nil or self.nCurTog ~= RecordTogType.RecordInfo or self.bResetTog
  if self.nCurTog == nil or self.curCharId ~= nCharId then
    self.nCurTog = RecordTogType.RecordInfo
  end
  if bReset then
    for k, v in ipairs(self._mapNode.ctrlTog) do
      v:ResetTrigger()
      v:SetTrigger(k == self.nCurTog)
    end
  end
  self.bResetTog = false
  self.ClickedRecordInfoTog = false
  self.ClickedVoiceTog = false
  self.bLevelChanged = true
  self.curCharId = nCharId
  self:OnRefreshPanel()
  self:RegisterTogRedDot(self.curCharId)
end

function CharacterRecordCtrl:OnRefreshPanel()
  local data = PlayerData.Char:GetCharAffinityData(self.curCharId)
  if data == nil then
    return
  end
  self.curFavourLevel = data.Level
  self:SwitchTog()
end

function CharacterRecordCtrl:OnRefreshRecordInfo()
  self.CharRecordInfoList = {}
  self.tbGridSize = {}
  self.curCharBaseInfoList = {}
  
  local function foreachCharRecord(mapData)
    if mapData.CharacterId == self.curCharId then
      table.insert(self.CharRecordInfoList, mapData)
    end
  end
  
  ForEachTableLine(DataTable.CharacterArchive, foreachCharRecord)
  table.sort(self.CharRecordInfoList, function(a, b)
    return a.Sort < b.Sort
  end)
  for k, v in ipairs(self.CharRecordInfoList) do
    if v.ArchType == GameEnum.ArchType.BaseType then
      local nHeight = 0
      
      local function foreachCharacterArchiveBaseInfo(mapData)
        if mapData.CharacterId == self.curCharId then
          table.insert(self.curCharBaseInfoList, mapData)
          local nWidth = self:CalRecordInfoBaseWidth(mapData.Title)
          nHeight = nHeight + self:CalRecordInfoBaseHeight(mapData.Content, nInfoContentMaxWidth - nWidth - 10)
        end
      end
      
      ForEachTableLine(DataTable.CharacterArchiveBaseInfo, foreachCharacterArchiveBaseInfo)
      nHeight = nHeight + InfoGridSize.Info + (#self.curCharBaseInfoList - 1) * InfoGridSize.InfoSpacing + gridBottom
      table.insert(self.tbGridSize, nHeight)
    elseif v.UnlockAffinityLevel > self.curFavourLevel then
      if v.ArchType == GameEnum.ArchType.SpecialType then
        table.insert(self.tbGridSize, InfoGridSize.Special)
      else
        table.insert(self.tbGridSize, InfoGridSize.Lock)
      end
    elseif v.ArchType == GameEnum.ArchType.SpecialType then
      table.insert(self.tbGridSize, InfoGridSize.Special)
    else
      local height = self:CalRecordInfoGridSize(k)
      table.insert(self.tbGridSize, height)
    end
  end
  if #self.tbGridSize > 0 then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.loopRecordList.gameObject:SetActive(true)
    self._mapNode.loopRecordList:InitEx(self.tbGridSize, self, self.RefreshRecordInfoGrid)
  else
    self._mapNode.loopRecordList.gameObject:SetActive(false)
  end
end

function CharacterRecordCtrl:RefreshRecordInfoGrid(go, index)
  local index = index + 1
  local nInstanceId = go:GetInstanceID()
  if self.tbGridCtrl == nil then
    self.tbGridCtrl = {}
  end
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(go, "Game.UI.CharacterRecord.CharRecordInfoItemCtrl")
  end
  local redDot = go.transform:Find("RedDotRoot/RedDot")
  if self.CharRecordInfoList[index].ArchType == GameEnum.ArchType.SpecialType then
    self:RegisterRewardRedDot(self.curCharId, self.CharRecordInfoList[index].Id, redDot, true)
  else
    self:RegisterInfoRedDot(self.curCharId, self.CharRecordInfoList[index].Id, redDot, true)
  end
  local updateRedDot = go.transform:Find("RedDotRoot/UpdateRedDot")
  if self.CharRecordInfoList[index].ArchType == GameEnum.ArchType.BaseType then
    self:RegisterBaseInfoUpdateRedDot(self.curCharId, updateRedDot, true)
  else
    self:RegisterInfoUpdateRedDot(self.curCharId, self.CharRecordInfoList[index].Id, updateRedDot, true)
  end
  self.tbGridCtrl[nInstanceId]:RefreshGrid(self.CharRecordInfoList[index], self.curCharBaseInfoList)
end

function CharacterRecordCtrl:CalRecordInfoGridSize(index)
  local contentData = ConfigTable.GetData("CharacterArchiveContent", self.CharRecordInfoList[index].RecordId)
  if contentData ~= nil then
    local bUpdate = PlayerData.Char:CheckCharArchiveContentUpdate(self.curCharId, self.CharRecordInfoList[index].RecordId)
    local sContent = bUpdate and contentData.UpdateContent1 or contentData.Content
    sContent = ProcAvgTextContent(sContent, GetLanguageIndex(Settings.sCurrentTxtLanguage))
    NovaAPI.SetTMPText(self._mapNode.txtContentSize, sContent)
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rectContentSize)
  end
  self._mapNode.txtContentSize.gameObject:SetActive(false)
  self._mapNode.txtContentSize.gameObject:SetActive(true)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rectContentSize)
  return self._mapNode.rectContentSize.rect.height + InfoGridSize.Normal
end

function CharacterRecordCtrl:CalRecordInfoBaseHeight(sContent, nWidth)
  self._mapNode.rtTxtCalInfoHeight.sizeDelta = Vector2(nWidth, 100)
  NovaAPI.SetTMPText(self._mapNode.txtCalInfoHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtCalInfoHeight)
  local nHeight = self._mapNode.rtTxtCalInfoHeight.rect.height
  return nHeight
end

function CharacterRecordCtrl:CalRecordInfoBaseWidth(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtCalInfoWidth, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtCalInfoWidth)
  local nWidth = self._mapNode.rtTxtCalInfoWidth.rect.width
  return nWidth
end

function CharacterRecordCtrl:OnRefreshVoice()
  if self.InitState[RecordTogType.Voice] == nil then
    self.InitState[RecordTogType.Voice] = 1
  elseif self.InitState[RecordTogType.Voice] == 1 then
    return
  end
  local tbSortedVoiceData = {}
  local tbVoiceGirdHeight = {}
  self.tbVoiceData = {}
  
  local function foreachLineCharVoice(mapData)
    if mapData.CharacterId == self.curCharId then
      if mapData.ArchVoiceType == GameEnum.ArchVoiceType.SkinVoice then
        local nSkinId = mapData.UnlockSkinId
        if PlayerData.CharSkin:CheckSkinUnlock(nSkinId) then
          table.insert(tbSortedVoiceData, mapData)
        end
      else
        table.insert(tbSortedVoiceData, mapData)
      end
    end
  end
  
  ForEachTableLine(DataTable.CharacterArchiveVoice, foreachLineCharVoice)
  table.sort(tbSortedVoiceData, function(a, b)
    if a.ArchVoiceType == b.ArchVoiceType then
      return a.Sort < b.Sort
    end
    return a.ArchVoiceType < b.ArchVoiceType
  end)
  local nLastType = 0
  for k, v in ipairs(tbSortedVoiceData) do
    if nLastType ~= v.ArchVoiceType then
      nLastType = v.ArchVoiceType
      table.insert(self.tbVoiceData, {
        bTitle = true,
        nType = v.ArchVoiceType
      })
      tbVoiceGirdHeight[#tbVoiceGirdHeight + 1] = VoiceGridSize.Title
    end
    table.insert(self.tbVoiceData, {bTitle = false, mapData = v})
    tbVoiceGirdHeight[#tbVoiceGirdHeight + 1] = VoiceGridSize.Voice
  end
  if 0 < #tbVoiceGirdHeight then
    self._mapNode.loopscVoice.gameObject:SetActive(true)
    self._mapNode.loopscVoice:InitEx(tbVoiceGirdHeight, self, self.RefreshVoiceGrid)
  else
    self._mapNode.loopscVoice.gameObject:SetActive(false)
  end
end

function CharacterRecordCtrl:RefreshVoiceGrid(go, index)
  local index = index + 1
  local trans = go.transform
  local titleRoot = trans:Find("DescRoot")
  local voiceRoot = trans:Find("VoiceRoot")
  local redDot = trans:Find("RedDot")
  LayoutRebuilder.ForceRebuildLayoutImmediate(trans)
  local voiceData = self.tbVoiceData[index]
  if voiceData.bTitle then
    titleRoot.gameObject:SetActive(true)
    voiceRoot.gameObject:SetActive(false)
    local voiceTitle = titleRoot:Find("t_common_04/imgBg/txtTitle"):GetComponent("TMP_Text")
    if voiceData.nType == GameEnum.ArchVoiceType.DailyVoice then
      NovaAPI.SetTMPText(voiceTitle, ConfigTable.GetUIText("Daily_Voice"))
    elseif voiceData.nType == GameEnum.ArchVoiceType.BattlceVoice then
      NovaAPI.SetTMPText(voiceTitle, ConfigTable.GetUIText("Battle_Voice"))
    elseif voiceData.nType == GameEnum.ArchVoiceType.SkinVoice then
      NovaAPI.SetTMPText(voiceTitle, ConfigTable.GetUIText("Skin_Voice"))
    end
    redDot.gameObject:SetActive(false)
  else
    titleRoot.gameObject:SetActive(false)
    voiceRoot.gameObject:SetActive(true)
    local goUnlock = voiceRoot:Find("Unlock")
    local goLock = voiceRoot:Find("Lock")
    local data = voiceData.mapData
    local bLock, lockTxt = self:IsVoiceLock(data)
    goUnlock.gameObject:SetActive(not bLock)
    goLock.gameObject:SetActive(bLock)
    local imgVoice = voiceRoot:GetComponent("Image")
    local color = NovaAPI.GetImageColor(imgVoice)
    color.a = bLock and 0.85 or 1
    NovaAPI.SetImageColor(imgVoice, color)
    local btnPlay = goUnlock:Find("btnPlay"):GetComponent("UIButton")
    local imgPlay = btnPlay.transform:Find("AnimRoot/imgPlay")
    local imgPlaying = btnPlay.transform:Find("AnimRoot/imgPlaying")
    imgPlay.gameObject:SetActive(self.curPlayingId ~= data.Id)
    imgPlaying.gameObject:SetActive(self.curPlayingId == data.Id)
    btnPlay.onClick:RemoveAllListeners()
    self.tbVoicePlayingObj[data.Id] = btnPlay
    if bLock then
      local txtVoiceLockCondition = goLock:Find("txtVoiceLockCondition"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtVoiceLockCondition, lockTxt)
    else
      local txtVoiceTitle = goUnlock:Find("VoiceTitle"):GetComponent("TMP_Text")
      if data.ArchVoiceType == GameEnum.ArchVoiceType.SkinVoice then
        local nSkinId = data.UnlockSkinId
        local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nSkinId)
        if mapSkinCfg ~= nil then
          NovaAPI.SetTMPText(txtVoiceTitle, orderedFormat(data.Title, mapSkinCfg.Name))
        end
      else
        NovaAPI.SetTMPText(txtVoiceTitle, data.Title)
      end
      btnPlay.onClick:AddListener(function()
        RedDotManager.SetValid(RedDotDefine.Role_Record_Voice_Item, {
          self.curCharId,
          data.Id
        }, false)
        if WwiseAudioMgr.VoiceVolume <= 0 or not WwiseAudioMgr.m_voice then
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Sound_Voice_Closed"))
          return
        end
        if self.curPlayingId ~= data.Id then
          imgPlay.gameObject:SetActive(false)
          imgPlaying.gameObject:SetActive(true)
        end
        self:OnBtn_ClickPlayVoice(btnPlay, data.Id)
      end)
    end
    self:RegisterVoiceRedDot(self.curCharId, data.Id, redDot, true)
  end
end

function CharacterRecordCtrl:IsVoiceLock(voiceData)
  if self.curFavourLevel < voiceData.UnlockAffinityLevel then
    return true, orderedFormat(ConfigTable.GetUIText("Affinity_UnLock_Level"), voiceData.UnlockAffinityLevel)
  end
  if voiceData.UnlockPlot ~= 0 and ConfigTable.GetData("Plot", voiceData.UnlockPlot) ~= nil then
    local bFinish = PlayerData.Char:IsCharPlotFinish(self.curCharId, voiceData.UnlockPlot)
    if bFinish then
      return false
    else
      local data = ConfigTable.GetData("Plot", voiceData.UnlockPlot)
      return true, orderedFormat(ConfigTable.GetUIText("Plot_Unlock_Condition"), data.Name)
    end
  end
  return false
end

function CharacterRecordCtrl:OnBtn_ClickPlayVoice(btnPlay, id)
  if self.curPlayingId ~= 0 and self.tbVoicePlayingObj[self.curPlayingId] ~= nil then
    local imgPlay = self.tbVoicePlayingObj[self.curPlayingId].transform:Find("AnimRoot/imgPlay")
    local imgPlaying = self.tbVoicePlayingObj[self.curPlayingId].transform:Find("AnimRoot/imgPlaying")
    imgPlay.gameObject:SetActive(true)
    imgPlaying.gameObject:SetActive(false)
    self.bActivePause = true
    self:OnStopCharVoice()
  end
  if self.curPlayingId ~= id then
    local data = ConfigTable.GetData("CharacterArchiveVoice", id)
    self:OnPlayCharVoice(self.curCharId, data.Source)
    self.curPlayingId = id
  else
    self.curPlayingId = 0
    BubbleVoiceManager.StopBubbleAnim()
  end
end

function CharacterRecordCtrl:OnPlayCharVoice(nCharId, sVoiceKey)
  if nil ~= sVoiceKey then
    local tbKey = string.split(sVoiceKey, "_")
    local sVoiceRes
    if 1 < #tbKey then
      sVoiceRes = WwiseAudioMgr:WwiseVoice_PlayEndCallback(nCharId, tbKey[1], tonumber(tbKey[2]))
    else
      sVoiceRes = WwiseAudioMgr:WwiseVoice_PlayEndCallback(nCharId, sVoiceKey)
    end
    if nil ~= sVoiceRes then
      if 1 < #tbKey then
        self.sCurVoiceKey = tbKey[1]
      else
        self.sCurVoiceKey = sVoiceKey
      end
      self:OnPlayCharVoiceBubble(sVoiceRes)
    end
  end
end

function CharacterRecordCtrl:OnStopCharVoice()
  if nil ~= self.sCurVoiceKey then
    local tbCfg = ConfigTable.GetData("CharacterVoiceControl", self.sCurVoiceKey)
    if nil ~= tbCfg then
      WwiseAudioMgr:WwiseVoice_Stop(tbCfg.voPlayer - 1)
    end
  end
  BubbleVoiceManager.StopBubbleAnim()
end

function CharacterRecordCtrl:OnPlayCharVoiceBubble(sVoiceRes)
  if nil ~= sVoiceRes then
    local tbCfg = ConfigTable.GetData("VoDirectory", sVoiceRes)
    if nil ~= tbCfg then
      BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, tbCfg.voResource)
    end
  end
end

function CharacterRecordCtrl:OnStopCharVoiceBubble()
  BubbleVoiceManager.StopBubbleAnim()
end

function CharacterRecordCtrl:OnRefreshPlot()
  if self.InitState[RecordTogType.Plot] == nil then
    self.InitState[RecordTogType.Plot] = 1
  elseif self.InitState[RecordTogType.Plot] == 1 then
    return
  end
  self._mapNode.ctlPlotRoot:RefreshContent(self.curCharId)
end

function CharacterRecordCtrl:SwitchTog()
  self._mapNode.goRecordList:SetActive(self.nCurTog == RecordTogType.RecordInfo)
  self._mapNode.goVoice:SetActive(self.nCurTog == RecordTogType.Voice)
  self._mapNode.goPlotRoot:SetActive(self.nCurTog == RecordTogType.Plot)
  if self.nCurTog == RecordTogType.RecordInfo then
    self:OnRefreshRecordInfo()
  elseif self.nCurTog == RecordTogType.Voice then
    self:OnRefreshVoice()
  elseif self.nCurTog == RecordTogType.Plot then
    self:OnRefreshPlot()
  end
end

function CharacterRecordCtrl:OnBtnClick_ChangeTab(btn, nIndex)
  if nIndex == self.nCurTog then
    return
  end
  self._mapNode.ctrlTog[nIndex]:SetTrigger(true)
  self._mapNode.ctrlTog[self.nCurTog]:SetTrigger(false)
  if self.nCurTog == RecordTogType.Voice then
    if self.bLevelChanged == true or self.ClickedVoiceTog ~= true then
      PlayerData.Char:UpdateCharVoiceReddot(self.curCharId, true)
      self.bLevelChanged = false
      self.ClickedVoiceTog = true
    end
  elseif self.nCurTog == RecordTogType.RecordInfo and (self.bLevelChanged == true or self.ClickedRecordInfoTog ~= true) then
    PlayerData.Char:UpdateCharRecordReddot(self.curCharId, true)
    PlayerData.Char:ResetArchiveContentUpdateRedDot(self.curCharId)
    self.bLevelChanged = false
    self.ClickedRecordInfoTog = true
  end
  self.nCurTog = nIndex
  self:SwitchTog()
end

function CharacterRecordCtrl:OnEvent_OpenStoryPanel(id)
  EventManager.Hit(EventId.OpenPanel, PanelId.CharacterStory, self.curCharId, id)
end

function CharacterRecordCtrl:OnEvent_AffinityChange(charId, curLevel, lastFavourLevel)
  if lastFavourLevel < curLevel then
    self.InitState = {}
    self:OnRefreshPanel()
    self.ClickedRecordInfoTog = false
    self.ClickedVoiceTog = false
    self.bLevelChanged = true
  end
end

function CharacterRecordCtrl:OnEvent_WWiseVoiceEnd()
  if not self.bActivePause and self.curPlayingId ~= 0 and self.tbVoicePlayingObj[self.curPlayingId] ~= nil then
    local imgPlay = self.tbVoicePlayingObj[self.curPlayingId].transform:Find("AnimRoot/imgPlay")
    local imgPlaying = self.tbVoicePlayingObj[self.curPlayingId].transform:Find("AnimRoot/imgPlaying")
    imgPlay.gameObject:SetActive(true)
    imgPlaying.gameObject:SetActive(false)
    self.curPlayingId = 0
  end
  self.bActivePause = false
end

function CharacterRecordCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  if nOpenPanelId ~= PanelId.CharacterRelation then
    self.nCurTog = nil
  end
end

return CharacterRecordCtrl
