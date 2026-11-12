local FormationCharListCtrl = class("FormationCharListCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
FormationCharListCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  labEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Filter_NoAim"
  },
  btnCloseList = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Clear"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  rtCharListContent = {sComponentName = "Transform"},
  btnFilter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Filter"
  },
  imgFilterChoose = {},
  txtBtnListConifrm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  txtBtnListClose = {
    sComponentName = "TMP_Text",
    sLanguageId = "ClearFormation"
  },
  btnOrder = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Order"
  },
  goSortDropdown = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDropdownCtrl"
  },
  imgArrowUpEnable = {},
  imgArrowUpDisable = {},
  imgArrowDownEnable = {},
  imgArrowDownDisable = {},
  btnFavoriteOrder = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_InFavoriteOrder"
  },
  InFavoriteOrder = {
    sNodeName = "InFavoriteOrder",
    sComponentName = "CanvasGroup"
  },
  txtOffLabel = {
    sNodeName = "OffLabel",
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterList_Common"
  },
  txtInLabel = {
    sNodeName = "InLabel",
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterList_Common"
  }
}
FormationCharListCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter",
  Guide_PositionCharPos = "OnEvent_PositionCharPos",
  ForamtionDown = "OnEvent_ForamtionDown",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}

function FormationCharListCtrl:Awake()
end

function FormationCharListCtrl:FadeIn()
end

function FormationCharListCtrl:FadeOut()
end

function FormationCharListCtrl:OnEnable()
  self.mapGridCtrl = {}
  self.gameObject:SetActive(false)
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self.bOpen = false
  self.bInFavorite = true
  self:RefreshFavoriteTopState()
end

function FormationCharListCtrl:OnDisable()
  self:CloseList()
  self.bOpen = false
end

function FormationCharListCtrl:OnDestroy()
end

function FormationCharListCtrl:OnRelease()
end

function FormationCharListCtrl:ShowList(tbCurSelectChar, bFastSelect, nIdx)
  self.tbOriginChar = clone(tbCurSelectChar)
  self.gameObject:SetActive(true)
  self.tbAllChar = PlayerData.Char:GetDataForCharList()
  self.bFastSelect = bFastSelect == true
  self.nIdx = not self.bFastSelect and nIdx or 0
  self.curChar = tbCurSelectChar
  self.tbSortCfg = {
    nSortType = PlayerData.Filter.nFormationCharSrotType,
    bOrder = PlayerData.Filter.bFormationCharOrder
  }
  local curSortIdx = 1
  local tbSortType = PlayerData.Char:GetCharSortType()
  for nIdx, nSortType in ipairs(tbSortType) do
    if self.tbSortCfg.nSortType == nSortType then
      curSortIdx = nIdx
    end
  end
  self._mapNode.goSortDropdown:SetList(PlayerData.Char:GetCharSortNameTextCfg(), curSortIdx - 1)
  self.bOpen = true
  self.mapGridCtrl = {}
  self.tbFilterCfg = {}
  self:RefreshOrderState()
  self:FilterChar()
  self:SortChar()
  self._mapNode.sv:Init(#self.tbSortedChar, self, self.OnGridRefresh, self.OnGridBtnClick)
  self._mapNode.btnConfirm.gameObject:SetActive(true)
  self._mapNode.btnCloseList.gameObject:SetActive(true)
end

function FormationCharListCtrl:Refresh()
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self:FilterChar()
  self:SortChar()
  self:RefreshOrderState()
  self:RefreshFavoriteTopState()
  local nCurCount = #self.tbSortedChar
  if 0 < nCurCount then
    self._mapNode.labEmpty.gameObject:SetActive(false)
    self._mapNode.sv.gameObject:SetActive(true)
    self._mapNode.sv:Init(#self.tbSortedChar, self, self.OnGridRefresh, self.OnGridBtnClick)
  else
    self._mapNode.sv.gameObject:SetActive(false)
    self._mapNode.labEmpty.gameObject:SetActive(true)
  end
end

function FormationCharListCtrl:CloseList()
  self.tbFilterCfg = {}
  for nInstanceId, mapCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self.mapGridCtrl = {}
  self.gameObject:SetActive(false)
  self.bOpen = false
end

function FormationCharListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nInstanceId = goGrid:GetInstanceID()
  if not self.mapGridCtrl[nInstanceId] then
    self.mapGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.FormationEx.FormationCharListItem")
  end
  local nIndex = gridIndex + 1
  local nCharId = self.tbSortedChar[nIndex]
  local selectIdx = table.indexof(self.curChar, nCharId)
  local nMark = self.bFastSelect == true and selectIdx or 0 < selectIdx
  local bBaned = false
  if self.bFastSelect ~= true then
    bBaned = 0 < selectIdx and selectIdx ~= self.nIdx
  end
  self.mapGridCtrl[nInstanceId]:RefreshItem(0 < selectIdx, nMark, nCharId, bBaned, self.tbSortCfg.nSortType)
end

function FormationCharListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nCharId = self.tbSortedChar[nIndex]
  local nTeamIdx = table.indexof(self.curChar, nCharId)
  if self.bFastSelect then
    if 0 < nTeamIdx then
      self.curChar[nTeamIdx] = 0
      self:SetGridIndex(nCharId, 0)
      for idx, CharId in ipairs(self.curChar) do
        self:SetGridIndex(CharId, idx)
      end
    else
      local nPos = table.indexof(self.curChar, 0)
      if 0 < nPos then
        self.curChar[nPos] = nCharId
        for idx, CharId in ipairs(self.curChar) do
          self:SetGridIndex(CharId, idx)
        end
        PlayerData.Voice:PlayCharVoice("swap", nCharId)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Formation_FullTeam") or "")
      end
    end
  elseif self.curChar[self.nIdx] ~= 0 then
    self:SetGridIndex(self.curChar[self.nIdx], 0)
    if self.curChar[self.nIdx] ~= nCharId then
      self.curChar[self.nIdx] = nCharId
      self:SetGridIndex(nCharId, self.nIdx)
    else
      self.curChar[self.nIdx] = 0
    end
  else
    self.curChar[self.nIdx] = nCharId
    self:SetGridIndex(nCharId, self.nIdx)
    PlayerData.Voice:PlayCharVoice("swap", nCharId)
  end
  EventManager.Hit("OnEvent_ChangeTeamModel", self.curChar)
end

function FormationCharListCtrl:SetGridIndex(nCharId, nIdx)
  local nGirdIdx = table.indexof(self.tbSortedChar, nCharId)
  local trGrid = self._mapNode.rtCharListContent:Find(tostring(nGirdIdx - 1))
  if trGrid ~= nil then
    local nInstanceId = trGrid.gameObject:GetInstanceID()
    if self.bFastSelect then
      self.mapGridCtrl[nInstanceId]:SetSelect(0 < nIdx, nIdx)
    else
      self.mapGridCtrl[nInstanceId]:SetSelect(0 < nIdx, nIdx)
    end
  end
end

function FormationCharListCtrl:FilterChar()
  self.tbSortedChar = {}
  for _, data in pairs(self.tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(data.nId)
    local bAvailable = mapCharCfgData.Available
    if bAvailable then
      local isFilter = PlayerData.Filter:CheckFilterByChar(data.nId)
      local bCur = table.indexof(self.curChar, data.nId) > 0
      if isFilter or bCur then
        local mapSkill = PlayerData.Char:GetCharSkillUpgradeData(data.nId)
        local nSkillLevelSum = 0
        for k, v in pairs(mapSkill) do
          nSkillLevelSum = nSkillLevelSum + v.nLv
        end
        data.SkillLevel = nSkillLevelSum
        table.insert(self.tbSortedChar, data)
      end
    end
  end
  print("过滤后 charCount:" .. #self.tbSortedChar)
end

function FormationCharListCtrl:SyncFormation()
  local tbBefireTeamMemberId = PlayerData.Team:GetTeamCharId(self._panel.nTeamIndex)
  local tbDiscId = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
  local bChange = false
  for i = 1, 3 do
    if tbBefireTeamMemberId[i] ~= self.curChar[i] then
      bChange = true
      break
    end
  end
  if not bChange then
    return
  end
  local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
  PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, self.curChar, tbDiscId, nPreselectionId)
end

function FormationCharListCtrl:SortChar()
  local tbCharId = {}
  UTILS.SortByPriority(self.tbSortedChar, {
    AllEnum.CharSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Char:GetCharSortField(), self.tbSortCfg.bOrder, self.bInFavorite)
  self.tbSortedChar = self:MoveElementsToFront(self.tbSortedChar, self.curChar)
  for _, mapCharId in ipairs(self.tbSortedChar) do
    table.insert(tbCharId, mapCharId.nId)
  end
  self.tbSortedChar = tbCharId
end

function FormationCharListCtrl:MoveElementsToFront(sortedList, elementsToMove)
  local lookup = {}
  for _, v in ipairs(elementsToMove) do
    lookup[v] = true
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

function FormationCharListCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function FormationCharListCtrl:RefreshByFilter()
  self:Refresh()
end

function FormationCharListCtrl:OnEvent_ForamtionDown(nIdx)
  local nCurCharId = self.curChar[nIdx]
  self.curChar[nIdx] = 0
  local nGridIdx = table.indexof(self.tbSortedChar, nCurCharId)
  local trGrid = self._mapNode.rtCharListContent:Find(tostring(nGridIdx - 1))
  if trGrid ~= nil then
    local nInstanceId = trGrid.gameObject:GetInstanceID()
    self.mapGridCtrl[nInstanceId]:SetSelect(false, nIdx)
  end
  EventManager.Hit("OnEvent_ChangeTeamModel", self.curChar)
end

function FormationCharListCtrl:OnEvent_SortRuleChange(nValue)
  if not self.bOpen then
    return
  end
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Char:GetCharSortType()[nV]
  self.tbSortCfg.bOrder = false
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function FormationCharListCtrl:OnBtnClick_Order(btn)
  self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function FormationCharListCtrl:OnBtnClick_Close(btn)
  local bChange = false
  for i = 1, 3 do
    if self.curChar[i] ~= self.tbOriginChar[i] then
      bChange = true
    end
  end
  local isSelectAgain = false
  
  local function cancelCallback()
    if isSelectAgain then
      local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
      local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
      local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
      local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
      local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
      local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
      LocalData.SetPlayerLocalData("FormationListTipDay", tostring(_nowD))
    end
    self:OnBtnClick_Confirm()
  end
  
  local function confirmCallback()
    EventManager.Hit("OnEvent_CloseTeamList", false, self.curChar)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    self._mapNode.btnCloseList.gameObject:SetActive(false)
  end
  
  if bChange then
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

function FormationCharListCtrl:OnBtnClick_Clear(btn)
  for i = 1, 3 do
    if self.curChar[i] ~= 0 then
      self:SetGridIndex(self.curChar[i], 0)
      self.curChar[i] = 0
    end
  end
  EventManager.Hit("OnEvent_ChangeTeamModel", self.curChar)
end

function FormationCharListCtrl:OnBtnClick_Confirm(btn)
  EventManager.Hit("OnEvent_CloseTeamList", true, self.curChar)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self._mapNode.btnCloseList.gameObject:SetActive(false)
end

function FormationCharListCtrl:OnBtnClick_Filter()
  local tbOption = {
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_TacticalStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function FormationCharListCtrl:OnEvent_PositionCharPos(_tmpChar)
  for i, v in pairs(self.tbSortedChar) do
    if v == _tmpChar then
      self._mapNode.sv:SetScrollGridPos(i - 1, 0, 0)
      EventManager.Hit("Positioning_Char_Grid", _tmpChar, i - 1)
      break
    end
  end
end

function FormationCharListCtrl:RefreshFavoriteTopState()
  if self.bInFavorite then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.InFavoriteOrder, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.InFavoriteOrder, 0)
  end
end

function FormationCharListCtrl:OnBtnClick_InFavoriteOrder(btn)
  self.bInFavorite = not self.bInFavorite
  local sTip = ""
  if self.bInFavorite then
    sTip = ConfigTable.GetUIText("OpenCharacterCommonTop_Tip")
  else
    sTip = ConfigTable.GetUIText("CloseCharacterCommonTop_Tip")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTip)
  self:Refresh()
end

return FormationCharListCtrl
