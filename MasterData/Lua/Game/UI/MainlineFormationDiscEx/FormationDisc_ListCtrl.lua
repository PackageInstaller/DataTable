local FormationDisc_ListCtrl = class("FormationDisc_ListCtrl", BaseCtrl)
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local LocalData = require("GameCore.Data.LocalData")
FormationDisc_ListCtrl._mapNodeConfig = {
  svListRoot = {
    sComponentName = "LoopScrollView"
  },
  imgFilterEmpty = {},
  rtDiscContent = {sComponentName = "Transform"},
  txtFilterEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Disc_Filter_Empty"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClearFormation"
  },
  txtCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "ClearFormation"
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
  btnSwitchSub = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchSub"
  },
  txtSwitchSub = {sComponentName = "TMP_Text"},
  imgFilterChoose = {},
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
FormationDisc_ListCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter",
  ForamtionDown = "OnEvent_ForamtionDown",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}
FormationDisc_ListCtrl._mapRedDotConfig = {}

function FormationDisc_ListCtrl:Awake()
  self.tmpSelectDiscIdList = {}
  self.tbSortedDisc = {}
  self.tbDiscIdMain = {}
  self.tbDiscIdSub = {}
  self.tbGridCtrl = {}
  self.bOpen = false
end

function FormationDisc_ListCtrl:FadeIn()
end

function FormationDisc_ListCtrl:FadeOut()
end

function FormationDisc_ListCtrl:OnEnable()
  self.tbSortCfg = {
    nSortType = PlayerData.Filter.nFormationDiscSrotType,
    bOrder = PlayerData.Filter.bFormationDiscOrder
  }
  local curSortIdx = 1
  local tbSortType = PlayerData.Char:GetCharSortType()
  for nIdx, nSortType in ipairs(tbSortType) do
    if self.tbSortCfg.nSortType == nSortType then
      curSortIdx = nIdx
    end
  end
  self._mapNode.goSortDropdown:SetList(PlayerData.Disc:GetDiscSortNameTextCfg(), curSortIdx - 1)
  self.tbAllDisc = PlayerData.Disc:GetAllDisc()
  self.tbCharId = PlayerData.Team:GetTeamCharId(self._panel.nTeamIndex)
  self.bOpen = true
end

function FormationDisc_ListCtrl:OnDisable()
  self.bOpen = false
  self:UnBindAllGrids()
end

function FormationDisc_ListCtrl:OnDestroy()
end

function FormationDisc_ListCtrl:OnRelease()
end

function FormationDisc_ListCtrl:SortDisc()
  self.tbDiscId = {}
  self.selectMainDiscIdList = {}
  self.selectSubDiscIdList = {}
  local tbDiscIdMap = {}
  for k, v in pairs(self.tbSortedDisc) do
    tbDiscIdMap[v.nId] = v
  end
  for i = 1, #self.tbMainDisc do
    table.insert(self.selectMainDiscIdList, tbDiscIdMap[self.tbMainDisc[i]])
  end
  for i = 1, #self.tbSubDisc do
    table.insert(self.selectSubDiscIdList, tbDiscIdMap[self.tbSubDisc[i]])
  end
  UTILS.SortByPriority(self.tbSortedDisc, {
    AllEnum.DiscSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Disc:GetDiscSortField(), self.tbSortCfg.bOrder)
  local tbMoveToFront = self._panel.nListType == 2 and self.selectSubDiscIdList or self.selectMainDiscIdList
  local tbMoveToBack = self._panel.nListType == 2 and self.selectMainDiscIdList or self.selectSubDiscIdList
  self.tbSortedDisc = self:MoveElementsToFront(self.tbSortedDisc, tbMoveToFront)
  self.tbSortedDisc = self:MoveElementsToBack(self.tbSortedDisc, tbMoveToBack)
  for i = 1, #self.tbSortedDisc do
    table.insert(self.tbDiscId, self.tbSortedDisc[i].nId)
  end
end

function FormationDisc_ListCtrl:MoveElementsToFront(sortedList, elementsToMove)
  local lookup = {}
  for i = 1, #elementsToMove do
    lookup[elementsToMove[i].nId] = true
  end
  local keep = {}
  for i = 1, #sortedList do
    if not lookup[sortedList[i].nId] then
      table.insert(keep, sortedList[i])
    end
  end
  for i = #elementsToMove, 1, -1 do
    table.insert(keep, 1, elementsToMove[i])
  end
  return keep
end

function FormationDisc_ListCtrl:MoveElementsToBack(sortedList, elementsToMove)
  local lookup = {}
  for i = 1, #elementsToMove do
    lookup[elementsToMove[i].nId] = true
  end
  local keep = {}
  for i = 1, #sortedList do
    if not lookup[sortedList[i].nId] then
      table.insert(keep, sortedList[i])
    end
  end
  for i = #elementsToMove, 1, -1 do
    table.insert(keep, elementsToMove[i])
  end
  return keep
end

function FormationDisc_ListCtrl:FilterDisc()
  self.tbSortedDisc = {}
  for _, data in pairs(self.tbAllDisc) do
    local mapCfg = ConfigTable.GetData("Disc", data.nId)
    if mapCfg.Available then
      local isSelect = table.indexof(self.tbMainDisc, data.nId) > 0 or 0 < table.indexof(self.tbSubDisc, data.nId)
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

function FormationDisc_ListCtrl:UnBindAllGrids()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FormationDisc_ListCtrl:Refresh()
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Disc)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self:FilterDisc()
  self:SortDisc()
  self:RefreshOrderState()
  local nCurCount = #self.tbSortedDisc
  self._mapNode.imgFilterEmpty.gameObject:SetActive(isDirty and nCurCount == 0)
  if 0 < nCurCount then
    self._mapNode.svListRoot.gameObject:SetActive(true)
    self._mapNode.svListRoot:Init(nCurCount, self, self.OnGridRefresh, self.OnGridBtnClick, self.bFirstIn == false)
  else
    self._mapNode.svListRoot.gameObject:SetActive(false)
  end
end

function FormationDisc_ListCtrl:SwitchRefresh()
  self:FilterDisc()
  self:SortDisc()
  EventManager.Hit("UploadDiscFormation", self.tbMainDisc, self.tbSubDisc)
  self.tbBeforeMain = clone(self.tbMainDisc)
  self.tbBeforeSub = clone(self.tbSubDisc)
  local nCurCount = #self.tbSortedDisc
  self._mapNode.svListRoot:Init(nCurCount, self, self.OnGridRefresh, self.OnGridBtnClick, self.bFirstIn == false)
end

function FormationDisc_ListCtrl:OpenList(nType, tbMainDisc, tbSubDisc, nSubCount)
  self.tbMainDisc = clone(tbMainDisc)
  self.tbSubDisc = clone(tbSubDisc)
  self.tbBeforeMain = tbMainDisc
  self.tbBeforeSub = tbSubDisc
  self.nSubCount = nSubCount
  self._panel.nListType = nType
  local sKey = self._panel.nListType == 1 and "DiscFormation_SwitchSub" or "DiscFormation_SwitchMain"
  NovaAPI.SetTMPText(self._mapNode.txtSwitchSub, ConfigTable.GetUIText(sKey))
  self.mapNoteNeed = {}
  for _, nMainDiscId in ipairs(tbMainDisc) do
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
  self.mapNoteCur = {}
  for _, nMainDiscId in ipairs(tbSubDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSubNoteSkills
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteCur[mapNeedNote.nId] == nil then
          self.mapNoteCur[mapNeedNote.nId] = 0
        end
        self.mapNoteCur[mapNeedNote.nId] = self.mapNoteCur[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  self:Refresh()
end

function FormationDisc_ListCtrl:SyncFormation()
  local tbTeamMemberId = PlayerData.Team:GetTeamCharId(self._panel.nTeamIndex)
  local tbBeforeDiscId = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
  local tbDisc = {}
  for i = 1, 3 do
    table.insert(tbDisc, self.tbMainDisc[i] == nil and 0 or self.tbMainDisc[i])
  end
  for i = 1, 3 do
    table.insert(tbDisc, self.tbSubDisc[i] == nil and 0 or self.tbSubDisc[i])
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
  local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
  PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, tbTeamMemberId, tbDisc, nPreselectionId)
end

function FormationDisc_ListCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function FormationDisc_ListCtrl:OnBtnClick_ClearFormation()
  for i = 1, 3 do
    self.tbMainDisc[i] = 0
    self.tbSubDisc[i] = 0
  end
  self.mapNoteNeed = {}
  self.mapNoteCur = {}
  for _, mapCtrl in pairs(self.tbGridCtrl) do
    mapCtrl:SetSelect(0, 0)
  end
  EventManager.Hit("DiscFormation_GridClick", self.tbMainDisc, self.tbSubDisc)
end

function FormationDisc_ListCtrl:CloseList()
  local function cancelCallback()
    self:OnBtnClick_Sure()
  end
  
  local function confirmCallback()
    self:OnBtnClick_Cancel()
  end
  
  local bDirty = false
  for i = 1, 3 do
    if self.tbMainDisc[i] ~= self.tbBeforeMain[i] or self.tbSubDisc[i] ~= self.tbBeforeSub[i] then
      bDirty = true
    end
  end
  if bDirty then
    local TipsTime = LocalData.GetPlayerLocalData("FormationListTipDay")
    local _tipDay = 0
    if TipsTime ~= nil then
      _tipDay = tonumber(TipsTime)
    end
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local fixedTimeStamp = curTimeStamp + newDayTime * 3600
    local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
    local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
    local nDay = tonumber(os.date("!%d", fixedTimeStamp))
    local nowD = nYear * 366 + nMonth * 31 + nDay
    if nowD == _tipDay then
      confirmCallback()
    else
      local isSelectAgain = false
      
      local function confirmTipCallback()
        if isSelectAgain then
          local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
          local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
          local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
          local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
          local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
          local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
          LocalData.SetPlayerLocalData("FormationListTipDay", tostring(_nowD))
        end
        confirmCallback()
      end
      
      local function againCallback(isSelect)
        isSelectAgain = isSelect
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = orderedFormat(ConfigTable.GetUIText("FormationChangeTips")),
        callbackConfirm = confirmTipCallback,
        callbackAgain = againCallback,
        callbackCancel = cancelCallback,
        bDisableSnap = true
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  else
    cancelCallback()
  end
end

function FormationDisc_ListCtrl:OnGridRefresh(goGrid, nIdx)
  nIdx = nIdx + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.MainlineFormationDiscEx.FormationDisc_ListGridCtrl")
  end
  local mapDisc = self.tbSortedDisc[nIdx]
  if mapDisc == nil then
    return
  end
  self.tbGridCtrl[nInstanceId]:OnGridRefresh(mapDisc, self.mapNoteNeed, self.mapNoteCur, self._panel.nListType, table.indexof(self.tbMainDisc, mapDisc.nId), table.indexof(self.tbSubDisc, mapDisc.nId))
end

function FormationDisc_ListCtrl:OnGridBtnClick(goGrid, nIdx)
  local mapDisc = self.tbSortedDisc[nIdx + 1]
  if self._panel.nListType == 1 then
    if self:GetFormationDiscCount(self.tbMainDisc) == 3 and table.indexof(self.tbMainDisc, mapDisc.nId) <= 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DiscFormation_HintMainFull"))
      return
    end
    if 0 < table.indexof(self.tbSubDisc, mapDisc.nId) then
      local function callback()
        self:SetFormationDisc(self.tbSubDisc, mapDisc.nId)
        
        self:SetFormationDisc(self.tbMainDisc, mapDisc.nId)
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
        self.mapNoteCur = {}
        for _, nMainDiscId in ipairs(self.tbSubDisc) do
          local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
          if mapDiscData ~= nil then
            local tbNeedNote = mapDiscData.tbSubNoteSkills
            for _, mapNeedNote in ipairs(tbNeedNote) do
              if self.mapNoteCur[mapNeedNote.nId] == nil then
                self.mapNoteCur[mapNeedNote.nId] = 0
              end
              self.mapNoteCur[mapNeedNote.nId] = self.mapNoteCur[mapNeedNote.nId] + mapNeedNote.nCount
            end
          end
        end
        local nInstanceId = goGrid:GetInstanceID()
        self.tbGridCtrl[nInstanceId]:OnGridRefresh(mapDisc, self.mapNoteNeed, self.mapNoteCur, self._panel.nListType, table.indexof(self.tbMainDisc, mapDisc.nId), table.indexof(self.tbSubDisc, mapDisc.nId))
        EventManager.Hit("DiscFormation_GridClick", self.tbMainDisc, self.tbSubDisc)
      end
      
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("DiscFormation_MsgNeedSwitch"),
        callbackConfirm = callback
      })
      return
    end
    self:SetFormationDisc(self.tbMainDisc, mapDisc.nId)
  else
    if self:GetFormationDiscCount(self.tbSubDisc) >= self.nSubCount and table.indexof(self.tbSubDisc, mapDisc.nId) <= 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DiscFormation_HintSubFull"))
      return
    end
    if table.indexof(self.tbMainDisc, mapDisc.nId) > 0 then
      local function callback()
        self:SetFormationDisc(self.tbMainDisc, mapDisc.nId)
        
        self:SetFormationDisc(self.tbSubDisc, mapDisc.nId)
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
        self.mapNoteCur = {}
        for _, nMainDiscId in ipairs(self.tbSubDisc) do
          local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
          if mapDiscData ~= nil then
            local tbNeedNote = mapDiscData.tbSubNoteSkills
            for _, mapNeedNote in ipairs(tbNeedNote) do
              if self.mapNoteCur[mapNeedNote.nId] == nil then
                self.mapNoteCur[mapNeedNote.nId] = 0
              end
              self.mapNoteCur[mapNeedNote.nId] = self.mapNoteCur[mapNeedNote.nId] + mapNeedNote.nCount
            end
          end
        end
        local nInstanceId = goGrid:GetInstanceID()
        self.tbGridCtrl[nInstanceId]:OnGridRefresh(mapDisc, self.mapNoteNeed, self.mapNoteCur, self._panel.nListType, table.indexof(self.tbMainDisc, mapDisc.nId), table.indexof(self.tbSubDisc, mapDisc.nId))
        EventManager.Hit("DiscFormation_GridClick", self.tbMainDisc, self.tbSubDisc)
      end
      
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("DiscFormation_MsgNeedSwitchMain"),
        callbackConfirm = callback
      })
      return
    end
    self:SetFormationDisc(self.tbSubDisc, mapDisc.nId)
  end
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
  self.mapNoteCur = {}
  for _, nMainDiscId in ipairs(self.tbSubDisc) do
    local mapDiscData = PlayerData.Disc:GetDiscById(nMainDiscId)
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSubNoteSkills
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteCur[mapNeedNote.nId] == nil then
          self.mapNoteCur[mapNeedNote.nId] = 0
        end
        self.mapNoteCur[mapNeedNote.nId] = self.mapNoteCur[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  local nInstanceId = goGrid:GetInstanceID()
  self.tbGridCtrl[nInstanceId]:OnGridRefresh(mapDisc, self.mapNoteNeed, self.mapNoteCur, self._panel.nListType, table.indexof(self.tbMainDisc, mapDisc.nId), table.indexof(self.tbSubDisc, mapDisc.nId))
  EventManager.Hit("DiscFormation_GridClick", self.tbMainDisc, self.tbSubDisc)
end

function FormationDisc_ListCtrl:OnBtnClick_Filter(btn)
  local tbOption = {
    AllEnum.ChooseOption.Star_Rarity,
    AllEnum.ChooseOption.Star_Element,
    AllEnum.ChooseOption.Star_Tag,
    AllEnum.ChooseOption.Star_Note
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function FormationDisc_ListCtrl:OnBtnClick_SwitchSub(btn)
  self._panel.nListType = self._panel.nListType == 1 and 2 or 1
  local sKey = self._panel.nListType == 1 and "DiscFormation_SwitchSub" or "DiscFormation_SwitchMain"
  NovaAPI.SetTMPText(self._mapNode.txtSwitchSub, ConfigTable.GetUIText(sKey))
  EventManager.Hit("DiscFormationSwitchCur", self._panel.nListType)
  self:SwitchRefresh()
end

function FormationDisc_ListCtrl:OnBtnClick_Switch1()
  if self._panel.nListType == 1 then
    return
  end
  self._panel.nListType = 1
  local sKey = self._panel.nListType == 1 and "DiscFormation_SwitchSub" or "DiscFormation_SwitchMain"
  NovaAPI.SetTMPText(self._mapNode.txtSwitchSub, ConfigTable.GetUIText(sKey))
  EventManager.Hit("DiscFormationSwitchCur", self._panel.nListType)
  self:SwitchRefresh()
end

function FormationDisc_ListCtrl:OnBtnClick_Switch2()
  if self._panel.nListType == 2 then
    return
  end
  self._panel.nListType = 2
  local sKey = self._panel.nListType == 1 and "DiscFormation_SwitchSub" or "DiscFormation_SwitchMain"
  NovaAPI.SetTMPText(self._mapNode.txtSwitchSub, ConfigTable.GetUIText(sKey))
  EventManager.Hit("DiscFormationSwitchCur", self._panel.nListType)
  self:SwitchRefresh()
end

function FormationDisc_ListCtrl:OnBtnClick_Sure()
  local bDirty = false
  for i = 1, 3 do
    if self.tbMainDisc[i] ~= self.tbBeforeMain[i] or self.tbSubDisc[i] ~= self.tbBeforeSub[i] then
      bDirty = true
    end
  end
  if bDirty then
    EventManager.Hit("ConfirmDiscFormationChoose", true, self.tbMainDisc, self.tbSubDisc)
  else
    EventManager.Hit("ConfirmDiscFormationChoose", false)
  end
  self:PlayDiscBGM(nil, self.tbMainDisc, self.tbSubDisc)
end

function FormationDisc_ListCtrl:OnBtnClick_Cancel()
  EventManager.Hit("ConfirmDiscFormationChoose", false)
end

function FormationDisc_ListCtrl:RefreshByFilter()
  self:Refresh()
end

function FormationDisc_ListCtrl:GetFormationDiscCount(tbDisc)
  local nCount = 0
  for _, nDiscId in ipairs(tbDisc) do
    if nDiscId ~= 0 then
      nCount = nCount + 1
    end
  end
  return nCount
end

function FormationDisc_ListCtrl:SetFormationDisc(tbDisc, nDiscId)
  local nIdx = table.indexof(tbDisc, nDiscId)
  if 0 < nIdx then
    tbDisc[nIdx] = 0
  else
    self:PlayDiscBGM(nDiscId)
    for idx, nId in ipairs(tbDisc) do
      if nId == 0 then
        tbDisc[idx] = nDiscId
        return
      end
    end
  end
end

function FormationDisc_ListCtrl:PlayDiscBGM(nDiscId, tbMain, tbSub)
  local tbDisc = {}
  local nCharId = 0
  local sVoiceKey = "music"
  if self.nLastBGMCharId == nil then
    self.nLastBGMCharId = 0
  end
  
  local function getRandomCharId(tbDiscId)
    local tbCharInDisc = {}
    local nRandomIndex = math.random(1, #tbDiscId)
    local mapDiscCfg = ConfigTable.GetData("DiscIP", tbDiscId[nRandomIndex])
    if mapDiscCfg ~= nil then
      tbCharInDisc = mapDiscCfg.CharId
    end
    local bInTeam = false
    for _, v in ipairs(self.tbCharId) do
      if table.indexof(tbCharInDisc, v) > 0 then
        bInTeam = true
        sVoiceKey = "uniMusic"
        return v
      end
    end
    local nRandomCharId = self.tbCharId[math.random(1, #self.tbCharId)]
    sVoiceKey = "music"
    return nRandomCharId
  end
  
  if nDiscId == nil then
    for _, v in ipairs(tbMain) do
      table.insert(tbDisc, v)
    end
    for _, v in ipairs(tbSub) do
      table.insert(tbDisc, v)
    end
  else
    table.insert(tbDisc, nDiscId)
  end
  nCharId = getRandomCharId(tbDisc)
  local nIndex = 0
  while self.nLastBGMCharId == nCharId and nIndex < 10 do
    nCharId = getRandomCharId(tbDisc)
    nIndex = nIndex + 1
  end
  PlayerData.Voice:PlayCharVoice(sVoiceKey, nCharId)
  self.nLastBGMCharId = nCharId
end

function FormationDisc_ListCtrl:OnBtnClick_Order(btn)
  self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  PlayerData.Filter:CacheDiscSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function FormationDisc_ListCtrl:OnEvent_SortRuleChange(nValue)
  if not self.bOpen then
    return
  end
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Disc:GetDiscSortType()[nV]
  self.tbSortCfg.bOrder = false
  PlayerData.Filter:CacheDiscSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function FormationDisc_ListCtrl:OnEvent_ForamtionDown(mapDisc, nType)
  if nType == 1 then
    local nListIdx = table.indexof(self.tbSortedDisc, mapDisc)
    local nIdx = table.indexof(self.tbMainDisc, mapDisc.nId)
    self.tbMainDisc[nIdx] = 0
    local trGrid = self._mapNode.rtDiscContent:Find(tostring(nListIdx - 1))
    if trGrid ~= nil then
      local nInstanceId = trGrid.gameObject:GetInstanceID()
      self.tbGridCtrl[nInstanceId]:SetSelect(0, 0)
    end
  else
    local nListIdx = table.indexof(self.tbSortedDisc, mapDisc)
    local nIdx = table.indexof(self.tbSubDisc, mapDisc.nId)
    self.tbSubDisc[nIdx] = 0
    local trGrid = self._mapNode.rtDiscContent:Find(tostring(nListIdx - 1))
    if trGrid ~= nil then
      local nInstanceId = trGrid.gameObject:GetInstanceID()
      self.tbGridCtrl[nInstanceId]:SetSelect(0, 0)
    end
  end
  EventManager.Hit("DiscFormation_GridClick", self.tbMainDisc, self.tbSubDisc)
end

return FormationDisc_ListCtrl
