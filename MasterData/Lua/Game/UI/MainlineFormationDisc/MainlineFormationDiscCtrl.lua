local MainlineFormationDiscCtrl = class("MainlineFormationDiscCtrl", BaseCtrl)
MainlineFormationDiscCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  distItem = {},
  Disc_ = {
    nCount = 3,
    sCtrlName = "Game.UI.MainlineFormationDisc.MainlineFormationDiscItem"
  },
  animatorRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
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
  discListRoot = {sComponentName = "GameObject"},
  svListRoot = {
    sComponentName = "LoopScrollView"
  },
  imgFilterEmpty = {},
  txtFilterEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Disc_Filter_Empty"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Cancel"
  },
  btnSure = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Sure"
  },
  txtSure = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  btnFilter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Filter"
  },
  imgFilterChoose = {},
  goEffect = {sComponentName = "GameObject"},
  effectRoot = {},
  effectRootAnim = {sNodeName = "effectRoot", sComponentName = "Animator"},
  btnCloseEffect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePreview"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePreview"
  },
  texPreviewEffectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_PreviewEffect"
  },
  btnCore = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnGeneral = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnCoreTog = {
    sNodeName = "btnCore",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoreTog"
  },
  btnGeneralTog = {
    sNodeName = "btnGeneral",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GeneralTog"
  },
  disc_Effect = {
    nCount = 3,
    sCtrlName = "Game.UI.MainlineFormationDisc.MainlineFormationDiscEffect"
  },
  goSortDropdown = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDropdownCtrl"
  },
  btnOrder = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Order"
  },
  imgArrowUpEnable = {},
  imgArrowUpDisable = {},
  imgArrowDownEnable = {},
  imgArrowDownDisable = {}
}
MainlineFormationDiscCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  OpenSelectDiscCard = "OnEvent_OpenSelectDiscCard",
  OpenSelectDiscDetails = "OnEvent_OpenSelectDiscDetails",
  GuideSelectDisc = "OnEvent_GuideSelectDisc",
  [EventId.FilterConfirm] = "RefreshByFilter",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}

function MainlineFormationDiscCtrl:Awake()
  self.tbSortCfg = {
    nSortType = AllEnum.SortType.Level,
    bOrder = false
  }
  self.panelType = 1
  self.bFirstIn = true
  local tmpDisc = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
  self.selectDiscIdList = {}
  self.tmpSelectDiscIdList = {}
  for i = 1, 3 do
    self.selectDiscIdList[i] = tmpDisc[i]
    self.tmpSelectDiscIdList[i] = tmpDisc[i]
  end
end

function MainlineFormationDiscCtrl:OnEnable()
  self.bBack2Formation = false
  self._mapNode.imgFilterEmpty.gameObject:SetActive(false)
  self.tbAllDisc = PlayerData.Disc:GetAllDisc()
  self.tbSortedDisc = {}
  self.tbDiscId = {}
  self.tbGridCtrl = {}
  self.nSelectSkillType = 1
  self:FilterDisc()
  self:SortDisc()
  self:RefrushItemCard(self.panelType == 1)
  self:SetPageBtnText()
  if self.panelType == 2 then
    self:Refresh()
    self._mapNode.animatorRoot:Play("distItem_in")
  end
  self._mapNode.goSortDropdown:SetList(PlayerData.Disc:GetDiscSortNameTextCfg(), 0)
end

function MainlineFormationDiscCtrl:OnDisable()
  self.tbSortedDisc = nil
  self.tbDiscId = nil
  self.tbAllDisc = nil
  self.tbGridCtrl = nil
  self.bFirstIn = false
end

function MainlineFormationDiscCtrl:OnDestroy()
  self.tbSortCfg = nil
  self.selectDiscIdList = nil
  self.tmpSelectDiscIdList = nil
end

function MainlineFormationDiscCtrl:GetDiscMaxSkillNote(nId)
  local tbMaxSkillNote
  if nId ~= 0 then
    local tmpDis = PlayerData.Disc:GetDiscById(nId)
    tbMaxSkillNote = tmpDis.tbShowNote
  end
  return tbMaxSkillNote
end

function MainlineFormationDiscCtrl:RefrushItemCard(isFormal)
  if isFormal then
    for i, v in pairs(self.selectDiscIdList) do
      local tbMaxSkillNote = self:GetDiscMaxSkillNote(v)
      self._mapNode.Disc_[i]:Refresh(v, tbMaxSkillNote, self.panelType == 2)
    end
  else
    for i, v in pairs(self.tmpSelectDiscIdList) do
      local tbMaxSkillNote = self:GetDiscMaxSkillNote(v)
      self._mapNode.Disc_[i]:Refresh(v, tbMaxSkillNote, self.panelType == 2)
    end
  end
end

function MainlineFormationDiscCtrl:Refresh()
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Disc)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self:FilterDisc()
  self:SortDisc()
  self:RefreshOrderState()
  local nCurCount = #self.tbSortedDisc
  self._mapNode.imgFilterEmpty.gameObject:SetActive(isDirty and nCurCount == 0)
  if 0 < nCurCount then
    self._mapNode.svListRoot.gameObject:SetActive(true)
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.svListRoot:Init(nCurCount, self, self.OnGridRefresh, self.OnGridBtnClick, self.bFirstIn == false)
  else
    self._mapNode.svListRoot.gameObject:SetActive(false)
  end
end

function MainlineFormationDiscCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.MainlineFormationDisc.MainlineFormationDiscCard")
  end
  local bSelect = false
  if self.panelType == 1 then
    bSelect = table.indexof(self.selectDiscIdList, self.tbSortedDisc[nIndex].nId) > 0
  else
    bSelect = 0 < table.indexof(self.tmpSelectDiscIdList, self.tbSortedDisc[nIndex].nId)
  end
  self.tbGridCtrl[nInstanceId]:Refresh(self.tbSortedDisc[nIndex].nId, self.tbSortedDisc[nIndex].tbShowNote, bSelect)
end

function MainlineFormationDiscCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local tmpId = self.tbDiscId[nIndex]
  local tabIndex = table.indexof(self.tmpSelectDiscIdList, tmpId)
  if tabIndex == 0 then
    local haveEmptyPos = false
    local tmp = 0
    for i, v in pairs(self.tmpSelectDiscIdList) do
      tmp = tmp + 1
      if v == 0 then
        haveEmptyPos = true
        break
      end
    end
    if haveEmptyPos then
      self.tmpSelectDiscIdList[tmp] = tmpId
      self.tbGridCtrl[nInstanceId]:SetSelect(true)
      local tbMaxSkillNote = self:GetDiscMaxSkillNote(tmpId)
      self._mapNode.Disc_[tmp]:Refresh(tmpId, tbMaxSkillNote, self.panelType == 2)
    else
      local strTips = ConfigTable.GetUIText("MainlineFormationDisc_Full")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
    end
  else
    local tmp = 0
    for i, v in pairs(self.tmpSelectDiscIdList) do
      tmp = tmp + 1
      if v == tmpId then
        break
      end
    end
    self.tmpSelectDiscIdList[tmp] = 0
    self._mapNode.Disc_[tmp]:Refresh(0, nil, self.panelType == 2)
    self.tbGridCtrl[nInstanceId]:SetSelect(false)
  end
end

function MainlineFormationDiscCtrl:OnEvent_GuideSelectDisc(tab)
  for i, v in pairs(tab) do
    local tmpId = v
    local tabIndex = table.indexof(self.tmpSelectDiscIdList, tmpId)
    if tabIndex == 0 then
      local haveEmptyPos = false
      local tmp = 0
      for i, v in pairs(self.tmpSelectDiscIdList) do
        tmp = tmp + 1
        if v == 0 then
          haveEmptyPos = true
          break
        end
      end
      if haveEmptyPos then
        self.tmpSelectDiscIdList[tmp] = tmpId
        EventManager.Hit("Disc_Select_Active", tmpId)
        local tbMaxSkillNote = self:GetDiscMaxSkillNote(tmpId)
        self._mapNode.Disc_[tmp]:Refresh(tmpId, tbMaxSkillNote, self.panelType == 2)
      else
        local strTips = ConfigTable.GetUIText("MainlineFormationDisc_Full")
        EventManager.Hit(EventId.OpenMessageBox, strTips)
      end
    end
  end
end

function MainlineFormationDiscCtrl:SortDisc()
  self.tbDiscId = {}
  self.tbSortSelectDisc = {}
  for i, v in pairs(self.tbSortedDisc) do
    v.isSelect = table.indexof(self.tmpSelectDiscIdList, v.nId) > 0
    if v.isSelect then
      table.insert(self.tbSortSelectDisc, v)
    end
  end
  UTILS.SortByPriority(self.tbSortedDisc, {
    AllEnum.DiscSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Disc:GetDiscSortField(), self.tbSortCfg.bOrder)
  self.tbSortedDisc = self:MoveElementsToFront(self.tbSortedDisc, self.tbSortSelectDisc)
  for i = 1, #self.tbSortedDisc do
    table.insert(self.tbDiscId, self.tbSortedDisc[i].nId)
  end
end

function MainlineFormationDiscCtrl:MoveElementsToFront(sortedList, elementsToMove)
  local lookup = {}
  for _, v in ipairs(elementsToMove) do
    lookup[v.nId] = true
  end
  local moved, rest = {}, {}
  for _, v in ipairs(sortedList) do
    if lookup[v.nId] then
      table.insert(moved, v)
    else
      table.insert(rest, v)
    end
  end
  for _, v in ipairs(rest) do
    table.insert(moved, v)
  end
  return moved
end

function MainlineFormationDiscCtrl:FilterDisc()
  self.tbSortedDisc = {}
  for _, data in pairs(self.tbAllDisc) do
    local mapCfg = ConfigTable.GetData("Disc", data.nId)
    if mapCfg.Available then
      local isSelect = table.indexof(self.tmpSelectDiscIdList, data.nId) > 0
      if isSelect then
        table.insert(self.tbSortedDisc, data)
      end
      if not isSelect then
        local isFilter = PlayerData.Filter:CheckFilterByDisc(data.nId)
        if isFilter then
          table.insert(self.tbSortedDisc, data)
        end
      end
    end
  end
end

function MainlineFormationDiscCtrl:RefreshItemPos()
  self._mapNode.discListRoot:SetActive(false)
  self._mapNode.animatorRoot:Play("distItem_out")
  self.panelType = 1
end

function MainlineFormationDiscCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function MainlineFormationDiscCtrl:OnBtnClick_FastFormation()
  local isTips = false
  for i = 1, 3 do
    if self.selectDiscIdList[i] ~= 0 then
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
    self.tbSortedDisc = {}
    for _, data in pairs(self.tbAllDisc) do
      local mapCfg = ConfigTable.GetData("Disc", data.nId)
      if mapCfg.Available then
        data.isEtt = mapCfg.EET == eet
        table.insert(self.tbSortedDisc, data)
      end
    end
    table.sort(self.tbSortedDisc, function(a, b)
      return a.isEtt and not b.isEtt or a.isEtt == b.isEtt and a.nRarity < b.nRarity or a.isEtt == b.isEtt and a.nRarity == b.nRarity and a.nLevel > b.nLevel or a.isEtt == b.isEtt and a.nRarity == b.nRarity and a.nLevel == b.nLevel and a.nId < b.nId
    end)
    for i = 1, 3 do
      if self.tbSortedDisc[i] then
        self.selectDiscIdList[i] = self.tbSortedDisc[i].nId
      end
    end
    self:RefrushItemCard(true)
    self:CacheTeamInfo()
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText("Auto_FormationTips")
    })
  end
  
  if not isTips then
    auto()
  else
    local function confirmCallback()
      auto()
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

function MainlineFormationDiscCtrl:OnBtnClick_Start()
  for i = 1, 3 do
    if self.selectDiscIdList[i] and self.selectDiscIdList[i] == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineFormationDisc_NotEnough"))
      return
    end
  end
  if self._panel.bSweep then
    PlayerData.StarTower:EnterTowerFastBattle(self._panel.curRoguelikeId, self._panel.nTeamIndex, self._panel.nPreselectionId)
  else
    PlayerData.StarTower:EnterTower(self._panel.curRoguelikeId, self._panel.nTeamIndex, self.selectDiscIdList, self._panel.nPreselectionId)
  end
end

function MainlineFormationDiscCtrl:OnBtnClick_Filter(btn)
  local tbOption = {
    AllEnum.ChooseOption.Star_Rarity,
    AllEnum.ChooseOption.Star_Element,
    AllEnum.ChooseOption.Star_Tag,
    AllEnum.ChooseOption.Star_Note
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function MainlineFormationDiscCtrl:OnBtnClick_Cancel(btn)
  self:RefreshItemPos()
  self.tmpSelectDiscIdList = {
    0,
    0,
    0
  }
  self:RefrushItemCard(true)
end

function MainlineFormationDiscCtrl:OnBtnClick_Sure(btn)
  self:RefreshItemPos()
  for i = 1, #self.tmpSelectDiscIdList do
    self.selectDiscIdList[i] = self.tmpSelectDiscIdList[i]
  end
  self:RefrushItemCard(true)
  self:CacheTeamInfo()
end

function MainlineFormationDiscCtrl:OnEvent_OpenSelectDiscCard(nId)
  if self.panelType == 2 then
  else
    self.panelType = 2
    self._mapNode.discListRoot:SetActive(true)
    self._mapNode.animatorRoot:Play("distItem_in")
    self.tmpSelectDiscIdList = {
      0,
      0,
      0
    }
    for i = 1, #self.selectDiscIdList do
      self.tmpSelectDiscIdList[i] = self.selectDiscIdList[i]
    end
    self:RefrushItemCard(false)
    self:Refresh()
  end
end

function MainlineFormationDiscCtrl:OnEvent_OpenSelectDiscDetails(nId)
  local tab = {}
  if self.panelType == 1 then
    for i, v in pairs(self.selectDiscIdList) do
      if v ~= 0 then
        table.insert(tab, v)
      end
    end
  else
    for i, v in pairs(self.tmpSelectDiscIdList) do
      if v ~= 0 then
        table.insert(tab, v)
      end
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.Disc, nId, tab)
end

function MainlineFormationDiscCtrl:SetPageBtnText()
  self._mapNode.btnCore:SetText(ConfigTable.GetUIText("Disc_Btn_CoreSkill"))
  self._mapNode.btnGeneral:SetText(ConfigTable.GetUIText("Disc_Btn_CommonSkill"))
end

function MainlineFormationDiscCtrl:OnBtnClick_Preview()
  self._mapNode.effectRoot:SetActive(false)
  self._mapNode.goEffect:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.effectRoot:SetActive(true)
    self._mapNode.effectRootAnim:Play("t_window_04_t_in")
    self.nSelectSkillType = 1
    self:SetDiscEffectMsg()
    self:SetDiscEffectSelect()
  end
  
  cs_coroutine.start(wait)
end

function MainlineFormationDiscCtrl:OnBtnClick_ClosePreview()
  local function waitCallback()
    self._mapNode.effectRoot:SetActive(false)
    
    self._mapNode.goEffect:SetActive(false)
  end
  
  self._mapNode.effectRootAnim:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, waitCallback, true, true, true, nil)
end

function MainlineFormationDiscCtrl:OnBtnClick_CoreTog()
  if self.nSelectSkillType == 1 then
    return
  end
  self.nSelectSkillType = 1
  self:SetDiscEffectSelect()
end

function MainlineFormationDiscCtrl:OnBtnClick_GeneralTog()
  if self.nSelectSkillType == 2 then
    return
  end
  self.nSelectSkillType = 2
  self:SetDiscEffectSelect()
end

function MainlineFormationDiscCtrl:SetDiscEffectMsg()
  for i, v in pairs(self.selectDiscIdList) do
    self._mapNode.disc_Effect[i]:Refresh(v)
  end
end

function MainlineFormationDiscCtrl:SetDiscEffectSelect()
  self._mapNode.btnCore:SetDefault(self.nSelectSkillType == 1)
  self._mapNode.btnGeneral:SetDefault(self.nSelectSkillType == 2)
  for i = 1, 3 do
    self._mapNode.disc_Effect[i]:ShowType(self.nSelectSkillType)
  end
end

function MainlineFormationDiscCtrl:RefreshByFilter()
  self:Refresh()
end

function MainlineFormationDiscCtrl:OnBtnClick_Order(btn)
  self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  self:Refresh()
end

function MainlineFormationDiscCtrl:OnEvent_SortRuleChange(nValue)
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Disc:GetDiscSortType()[nV]
  self.tbSortCfg.bOrder = false
  self:Refresh()
end

function MainlineFormationDiscCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.panelType == 1 then
    self.bBack2Formation = true
    EventManager.Hit(EventId.CloesCurPanel)
  elseif self.panelType == 2 then
    self:RefreshItemPos()
    self.tmpSelectDiscIdList = {
      0,
      0,
      0
    }
    self:RefrushItemCard(true)
  end
end

function MainlineFormationDiscCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function MainlineFormationDiscCtrl:CheckFormationDiscChanged()
  local emptyCount = 0
  for i = 1, 3 do
    if self.selectDiscIdList[i] == 0 then
      emptyCount = emptyCount + 1
    end
  end
  if emptyCount == 3 then
    return true, true
  end
  for i = 1, 3 do
    if self.selectDiscIdList[i] == 0 then
      return false, false
    end
  end
  local _tmpDisc = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
  for i = 1, 3 do
    if table.indexof(self.selectDiscIdList, _tmpDisc[i]) == 0 then
      return true, false
    end
  end
  return false, false
end

function MainlineFormationDiscCtrl:CacheTeamInfo()
  local isSave, isEmpty = self:CheckFormationDiscChanged()
  if isSave then
    local _, tbTeamMemberId = PlayerData.Team:GetTeamData(self._panel.nTeamIndex)
    
    local function Callback()
      local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
      if isEmpty then
        PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, 1, tbTeamMemberId, {
          0,
          0,
          0
        }, nPreselectionId)
      else
        PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, 1, tbTeamMemberId, self.selectDiscIdList, nPreselectionId)
      end
    end
    
    local PlayerFormationReq = {}
    PlayerFormationReq.Formation = {}
    PlayerFormationReq.Formation.Number = self._panel.nTeamIndex
    PlayerFormationReq.Formation.Captain = 1
    PlayerFormationReq.Formation.CharIds = tbTeamMemberId
    if not isEmpty then
      PlayerFormationReq.Formation.DiscIds = self.selectDiscIdList
    end
    HttpNetHandler.SendMsg(NetMsgId.Id.player_formation_req, PlayerFormationReq, nil, Callback)
  end
end

return MainlineFormationDiscCtrl
