local MainlineFormationDiscCtrl = class("MainlineFormationDiscCtrl", BaseCtrl)
MainlineFormationDiscCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtMainDisc = {
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationMainDiscCtrl"
  },
  rtSubDiscSelect = {
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationSubDiscCtrl"
  },
  rtSubDisc = {
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationSubDiscCtrl"
  },
  discListRoot = {
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationDisc_ListCtrl"
  },
  btnOpenList = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenList"
  },
  rtCur = {},
  rtBack = {},
  imgMaskSub = {},
  imgMaskMain = {},
  btnPreviewEffectSub = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preview"
  },
  texPreviewEffectSub = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_PreviewEffect"
  },
  btnFastSwitchSub = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchSub"
  },
  btnFastSwitchMain = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchMain"
  },
  bottomBtnList = {sComponentName = "GameObject"},
  btnFastFormation = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastFormation"
  },
  txtBtnFastFormation = {
    sComponentName = "TMP_Text",
    sLanguageId = "Auto_Formation"
  },
  btnStartBattle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtStartBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Raid"
  },
  btnPreviewEffect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preview"
  },
  texPreviewEffect = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_PreviewEffect"
  },
  animator = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  }
}
MainlineFormationDiscCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  DiscFormation_GridClick = "OnEvent_DiscFormationGridClick",
  ConfirmDiscFormationChoose = "OnEvent_ConfirmDiscFormationChoose",
  DiscFormationSwitchCur = "OnEvent_DiscFormationSwitchCur",
  DiscFormation_OpenList = "OnEvent_OpenList",
  DiscFormation_Detail = "OnEvent_Detail",
  Guide_RefreshDiscFormation = "OnEvent_Guide_RefreshDiscFormation",
  UploadDiscFormation = "OnEvent_UploadFormation",
  [EventId.OpenMessageBox] = "OnEvent_OpenMessageBox"
}
MainlineFormationDiscCtrl._mapRedDotConfig = {}

function MainlineFormationDiscCtrl:Awake()
  self._panel._panelType = 1
end

function MainlineFormationDiscCtrl:FadeIn()
end

function MainlineFormationDiscCtrl:FadeOut()
end

function MainlineFormationDiscCtrl:OnEnable()
  self.bStartClick = false
  self:Refresh()
  if self._panel._panelType == 2 then
    self:OpenList(self._panel.nListType)
  else
    self._panel.nListType = 1
    self._mapNode.rtMainDisc:SetDiscBtnEnable(true)
  end
end

function MainlineFormationDiscCtrl:OnDisable()
  if self._panel._panelType == 2 then
    self._mapNode.discListRoot:SyncFormation()
  end
end

function MainlineFormationDiscCtrl:OnDestroy()
end

function MainlineFormationDiscCtrl:OnRelease()
end

function MainlineFormationDiscCtrl:OnBtnClick_OpenList(btn, nIdx)
  if self._panel._panelType == 2 then
    return
  end
  self:OpenList(nIdx)
end

function MainlineFormationDiscCtrl:OnBtnClick_FastFormation()
  local isTips = false
  for i = 1, 3 do
    if self.tbMainDisc[i] ~= 0 or self.tbSubDisc[i] ~= 0 then
      isTips = true
    end
  end
  self.tbSortCfg = {
    nSortType = AllEnum.SortType.Level,
    bOrder = true
  }
  
  local function auto()
    local _, tbTeamMemberId = PlayerData.Team:GetTeamData(self._panel.nTeamIndex)
    local nCharId = tbTeamMemberId[1]
    local charCfgData = DataTable.Character[nCharId]
    local eet = charCfgData.EET
    local tbSortedDisc = {}
    for _, data in pairs(self._mapNode.discListRoot.tbAllDisc) do
      local mapCfg = ConfigTable.GetData("Disc", data.nId)
      if mapCfg.Available then
        data.isEtt = mapCfg.EET == eet
        table.insert(tbSortedDisc, data)
      end
    end
    table.sort(tbSortedDisc, function(a, b)
      return a.isEtt and not b.isEtt or a.isEtt == b.isEtt and a.nRarity < b.nRarity or a.isEtt == b.isEtt and a.nRarity == b.nRarity and a.nLevel > b.nLevel or a.isEtt == b.isEtt and a.nRarity == b.nRarity and a.nLevel == b.nLevel and a.nId < b.nId
    end)
    for i = 1, 6 do
      if i < 4 then
        if tbSortedDisc[i] ~= nil then
          self.tbMainDisc[i] = tbSortedDisc[i].nId
        end
      elseif tbSortedDisc[i] ~= nil and i - 3 <= self.nSubCount then
        self.tbSubDisc[i - 3] = tbSortedDisc[i].nId
      end
    end
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText("Auto_FormationTips")
    })
    self.mapNoteNeed = {}
    for _, nMainDiscId in ipairs(self.tbMainDisc) do
      local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
      if mapDiscData ~= nil then
        local tbNeedNote = mapDiscData.tbSkillNeedNote
        for _, mapNeedNote in ipairs(tbNeedNote) do
          if self.mapNoteNeed[mapNeedNote.nId] == nil then
            self.mapNoteNeed[mapNeedNote.nId] = 0
          end
          self.mapNoteNeed[mapNeedNote.nId] = self.mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
        end
      end
    end
    self.mapNoteSub = {}
    for _, nSubDiscId in ipairs(self.tbSubDisc) do
      local mapDiscData = PlayerData.Disc:GetDiscById(nSubDiscId)
      if mapDiscData ~= nil then
        local tbNeedNote = mapDiscData.tbSubNoteSkills
        for _, mapNeedNote in ipairs(tbNeedNote) do
          if self.mapNoteSub[mapNeedNote.nId] == nil then
            self.mapNoteSub[mapNeedNote.nId] = 0
          end
          self.mapNoteSub[mapNeedNote.nId] = self.mapNoteSub[mapNeedNote.nId] + mapNeedNote.nCount
        end
      end
    end
    self._mapNode.rtMainDisc:Refresh(self.tbMainDisc, self.mapNoteSub)
    self._mapNode.rtSubDisc:Refresh(self.tbSubDisc, self.mapNoteNeed, self.nSubCount)
  end
  
  if PlayerData.Guide:CheckInGuideGroup(27) then
    isTips = false
  end
  if not isTips then
    auto()
    self:UploadFormation(self.tbMainDisc, self.tbSubDisc)
  else
    local function confirmCallback()
      auto()
      
      self:UploadFormation(self.tbMainDisc, self.tbSubDisc)
    end
    
    local function cancelCallback()
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("MainlineFormationDisc_Auto_FormationNotice"),
      callbackConfirm = confirmCallback,
      callbackCancel = cancelCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function MainlineFormationDiscCtrl:OnBtnClick_Preview()
  local tbMain = self.tbTmpMain == nil and self.tbMainDisc or self.tbTmpMain
  local tbSub = self.tbTmpSub == nil and self.tbSubDisc or self.tbTmpSub
  local tbDisc = {}
  for _, v in ipairs(tbMain) do
    table.insert(tbDisc, v)
  end
  for _, v in ipairs(tbSub) do
    table.insert(tbDisc, v)
  end
  local mapDiscData = {}
  for _, nDiscId in pairs(tbDisc) do
    mapDiscData[nDiscId] = PlayerData.Disc:GetDiscById(nDiscId)
  end
  if nil == next(mapDiscData) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineFormationDisc_None"))
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkill, tbDisc, self.mapNoteNeed, mapDiscData)
  end
end

function MainlineFormationDiscCtrl:OnBtnClick_Start()
  if self.bStartClick == true then
    return
  end
  for i = 1, 3 do
    if self.tbMainDisc[i] and self.tbMainDisc[i] == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineFormationDisc_NotEnough"))
      return
    end
  end
  self.bStartClick = true
  if self._panel.bSweep then
    PlayerData.StarTower:EnterTowerFastBattle(self._panel.curRoguelikeId, self._panel.nTeamIndex)
  else
    PlayerData.StarTower:EnterTower(self._panel.curRoguelikeId, self._panel.nTeamIndex, self.selectDiscIdList)
  end
end

function MainlineFormationDiscCtrl:Refresh()
  self.nSubCount = PlayerData.StarTower:GetDiscFormationSubSlot()
  local tmpDisc = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
  self.tbMainDisc = {
    tmpDisc[1] == nil and 0 or tmpDisc[1],
    tmpDisc[2] == nil and 0 or tmpDisc[2],
    tmpDisc[3] == nil and 0 or tmpDisc[3]
  }
  self.tbSubDisc = {
    tmpDisc[4] == nil and 0 or tmpDisc[4],
    tmpDisc[5] == nil and 0 or tmpDisc[5],
    tmpDisc[6] == nil and 0 or tmpDisc[6]
  }
  self.mapNoteNeed = {}
  for _, nMainDiscId in ipairs(self.tbMainDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSkillNeedNote
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteNeed[mapNeedNote.nId] == nil then
          self.mapNoteNeed[mapNeedNote.nId] = 0
        end
        self.mapNoteNeed[mapNeedNote.nId] = self.mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  self.mapNoteSub = {}
  for _, nSubDiscId in ipairs(self.tbSubDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nSubDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSubNoteSkills
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteSub[mapNeedNote.nId] == nil then
          self.mapNoteSub[mapNeedNote.nId] = 0
        end
        self.mapNoteSub[mapNeedNote.nId] = self.mapNoteSub[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  self._mapNode.rtMainDisc:Refresh(self.tbMainDisc, self.mapNoteSub)
  self._mapNode.rtSubDisc:Refresh(self.tbSubDisc, self.mapNoteNeed, self.nSubCount)
  self._mapNode.rtMainDisc:SetTitle(false)
  self._mapNode.rtSubDisc:SetTitle(false)
  self._mapNode.rtSubDiscSelect.gameObject:SetActive(false)
  self._mapNode.btnFastSwitchMain.gameObject:SetActive(false)
  self._mapNode.btnFastSwitchSub.gameObject:SetActive(false)
  self._mapNode.imgMaskMain:SetActive(false)
  self._mapNode.imgMaskSub:SetActive(true)
  self._mapNode.rtMainDisc.gameObject.transform:SetParent(self._mapNode.rtCur.transform)
  self._mapNode.rtSubDiscSelect.gameObject.transform:SetParent(self._mapNode.rtBack.transform)
end

function MainlineFormationDiscCtrl:OpenList(nType)
  self._mapNode.rtSubDiscSelect.gameObject:SetActive(true)
  self._mapNode.discListRoot:OpenList(nType, self.tbMainDisc, self.tbSubDisc, self.nSubCount)
  self._mapNode.rtSubDiscSelect:Refresh(self.tbSubDisc, self.mapNoteNeed, self.nSubCount)
  if nType == 1 then
    self._mapNode.imgMaskMain:SetActive(false)
    self._mapNode.imgMaskSub:SetActive(true)
    self._mapNode.rtMainDisc.gameObject.transform:SetParent(self._mapNode.rtCur.transform)
    self._mapNode.rtSubDiscSelect.gameObject.transform:SetParent(self._mapNode.rtBack.transform)
    self._mapNode.rtMainDisc:SetTitle(true)
    self._mapNode.rtSubDiscSelect:SetTitle(false)
    self._mapNode.btnFastSwitchMain.gameObject:SetActive(false)
    self._mapNode.btnFastSwitchSub.gameObject:SetActive(true)
  else
    self._mapNode.imgMaskMain:SetActive(true)
    self._mapNode.imgMaskSub:SetActive(false)
    self._mapNode.rtSubDiscSelect.gameObject.transform:SetParent(self._mapNode.rtCur.transform)
    self._mapNode.rtMainDisc.gameObject.transform:SetParent(self._mapNode.rtBack.transform)
    self._mapNode.rtMainDisc:SetTitle(false)
    self._mapNode.rtSubDiscSelect:SetTitle(true)
    self._mapNode.btnFastSwitchMain.gameObject:SetActive(true)
    self._mapNode.btnFastSwitchSub.gameObject:SetActive(false)
  end
  self._panel._panelType = 2
  self._mapNode.animator:Play("distItem_in")
  self._mapNode.rtMainDisc:PlayAnim(true)
  self._mapNode.rtMainDisc:SetDiscBtnEnable(false)
  self._mapNode.rtSubDiscSelect:PlayAnim(true)
end

function MainlineFormationDiscCtrl:CloseList()
  self.mapNoteNeed = {}
  for _, nMainDiscId in ipairs(self.tbMainDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSkillNeedNote
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteNeed[mapNeedNote.nId] == nil then
          self.mapNoteNeed[mapNeedNote.nId] = 0
        end
        self.mapNoteNeed[mapNeedNote.nId] = self.mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  self.mapNoteSub = {}
  for _, nSubDiscId in ipairs(self.tbSubDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nSubDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSubNoteSkills
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteSub[mapNeedNote.nId] == nil then
          self.mapNoteSub[mapNeedNote.nId] = 0
        end
        self.mapNoteSub[mapNeedNote.nId] = self.mapNoteSub[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  self._mapNode.rtMainDisc:Refresh(self.tbMainDisc, self.mapNoteSub)
  self._mapNode.rtSubDisc:Refresh(self.tbSubDisc, self.mapNoteNeed, self.nSubCount)
  self._mapNode.rtMainDisc:SetTitle(false)
  self._mapNode.rtSubDisc:SetTitle(false)
  self._mapNode.imgMaskMain:SetActive(false)
  self._mapNode.imgMaskSub:SetActive(true)
  self._mapNode.rtMainDisc.gameObject.transform:SetParent(self._mapNode.rtCur.transform)
  self._mapNode.rtSubDiscSelect.gameObject.transform:SetParent(self._mapNode.rtBack.transform)
  self._panel._panelType = 1
  self._mapNode.animator:Play("distItem_out")
  self._mapNode.rtMainDisc:PlayAnim(false)
  self._mapNode.rtSubDiscSelect:PlayAnim(false)
  self._mapNode.rtMainDisc:SetDiscBtnEnable(true)
  self._mapNode.btnFastSwitchMain.gameObject:SetActive(false)
  self._mapNode.btnFastSwitchSub.gameObject:SetActive(false)
  self.tbTmpMain = nil
  self.tbTmpSub = nil
end

function MainlineFormationDiscCtrl:UploadFormation(tbMainDisc, tbSubDisc, callback)
  local tbTeamMemberId = PlayerData.Team:GetTeamCharId(self._panel.nTeamIndex)
  local tbBeforeDiscId = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
  local tbDisc = {}
  for i = 1, 3 do
    table.insert(tbDisc, tbMainDisc[i] == nil and 0 or tbMainDisc[i])
  end
  for i = 1, 3 do
    table.insert(tbDisc, tbSubDisc[i] == nil and 0 or tbSubDisc[i])
  end
  local bChange = false
  for i = 1, 6 do
    if tbBeforeDiscId[i] ~= tbDisc[i] then
      bChange = true
      break
    end
  end
  if not bChange then
    return
  end
  
  local function Callback()
    if callback ~= nil then
      callback()
    end
    self.tbMainDisc = clone(tbMainDisc)
    self.tbSubDisc = clone(tbSubDisc)
  end
  
  local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
  PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, tbTeamMemberId, tbDisc, nPreselectionId, Callback)
end

function MainlineFormationDiscCtrl:OnBtnClick_SwitchMain()
  self._mapNode.discListRoot:OnBtnClick_Switch1()
  self._mapNode.btnFastSwitchMain.gameObject:SetActive(false)
  self._mapNode.btnFastSwitchSub.gameObject:SetActive(true)
end

function MainlineFormationDiscCtrl:OnBtnClick_SwitchSub()
  self._mapNode.discListRoot:OnBtnClick_Switch2()
  self._mapNode.btnFastSwitchMain.gameObject:SetActive(true)
  self._mapNode.btnFastSwitchSub.gameObject:SetActive(false)
end

function MainlineFormationDiscCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self._panel._panelType == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  elseif self._panel._panelType == 2 then
    self._mapNode.discListRoot:CloseList()
  end
end

function MainlineFormationDiscCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function MainlineFormationDiscCtrl:OnEvent_DiscFormationGridClick(tbMainDisc, tbSubDisc)
  local mapNoteNeed = {}
  for _, nMainDiscId in ipairs(tbMainDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSkillNeedNote
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if mapNoteNeed[mapNeedNote.nId] == nil then
          mapNoteNeed[mapNeedNote.nId] = 0
        end
        mapNoteNeed[mapNeedNote.nId] = mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  local mapNoteSub = {}
  for _, nSubDiscId in ipairs(tbSubDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nSubDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSubNoteSkills
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if mapNoteSub[mapNeedNote.nId] == nil then
          mapNoteSub[mapNeedNote.nId] = 0
        end
        mapNoteSub[mapNeedNote.nId] = mapNoteSub[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  self.tbTmpMain = tbMainDisc
  self.tbTmpSub = tbSubDisc
  self._mapNode.rtMainDisc:Refresh(tbMainDisc, mapNoteSub)
  self._mapNode.rtSubDiscSelect:Refresh(tbSubDisc, mapNoteNeed, self.nSubCount)
end

function MainlineFormationDiscCtrl:OnEvent_ConfirmDiscFormationChoose(bChange, tbMainDisc, tbSubDisc)
  if bChange then
    local function Callback()
      self.tbMainDisc = tbMainDisc
      
      self.tbSubDisc = tbSubDisc
      self:CloseList()
    end
    
    self:UploadFormation(tbMainDisc, tbSubDisc, Callback)
  else
    self:CloseList()
  end
end

function MainlineFormationDiscCtrl:OnEvent_DiscFormationSwitchCur(nType)
  if nType == 1 then
    self._mapNode.imgMaskMain:SetActive(false)
    self._mapNode.imgMaskSub:SetActive(true)
    self._mapNode.rtMainDisc.gameObject.transform:SetParent(self._mapNode.rtCur.transform)
    self._mapNode.rtSubDiscSelect.gameObject.transform:SetParent(self._mapNode.rtBack.transform)
    self._mapNode.rtMainDisc:SetTitle(true)
    self._mapNode.rtSubDiscSelect:SetTitle(false)
    self._mapNode.btnFastSwitchMain.gameObject:SetActive(false)
    self._mapNode.btnFastSwitchSub.gameObject:SetActive(true)
  else
    self._mapNode.imgMaskMain:SetActive(true)
    self._mapNode.imgMaskSub:SetActive(false)
    self._mapNode.rtSubDiscSelect.gameObject.transform:SetParent(self._mapNode.rtCur.transform)
    self._mapNode.rtMainDisc.gameObject.transform:SetParent(self._mapNode.rtBack.transform)
    self._mapNode.rtMainDisc:SetTitle(false)
    self._mapNode.rtSubDiscSelect:SetTitle(true)
    self._mapNode.btnFastSwitchMain.gameObject:SetActive(true)
    self._mapNode.btnFastSwitchSub.gameObject:SetActive(false)
  end
end

function MainlineFormationDiscCtrl:OnEvent_OpenList(nType)
  if self._panel._panelType == 2 then
    return
  end
  self:OpenList(nType)
end

function MainlineFormationDiscCtrl:OnEvent_Detail(nSelectId)
  local tbAllDisc = {}
  for _, nId in ipairs(self.tbMainDisc) do
    if 0 < nId then
      table.insert(tbAllDisc, nId)
    end
  end
  for _, nId in ipairs(self.tbSubDisc) do
    if 0 < nId then
      table.insert(tbAllDisc, nId)
    end
  end
  if table.indexof(tbAllDisc, nSelectId) < 1 then
    table.insert(tbAllDisc, nSelectId)
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.Disc, nSelectId, tbAllDisc)
end

function MainlineFormationDiscCtrl:OnEvent_Guide_RefreshDiscFormation()
  self:Refresh()
end

function MainlineFormationDiscCtrl:OnEvent_UploadFormation(tbMainDisc, tbSubDisc)
  self:UploadFormation(tbMainDisc, tbSubDisc, nil)
end

function MainlineFormationDiscCtrl:OnEvent_OpenMessageBox()
  self.bStartClick = false
end

return MainlineFormationDiscCtrl
