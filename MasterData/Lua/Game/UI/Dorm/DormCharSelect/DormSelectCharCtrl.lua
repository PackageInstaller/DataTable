local DormSelectCharCtrl = class("DormSelectCharCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local _
_, Select = ColorUtility.TryParseHtmlString("#264278")
_, Unselect = ColorUtility.TryParseHtmlString("#94AAC0")
DormSelectCharCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  labEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Filter_NoAim"
  },
  btnCloseList = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
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
    sLanguageId = "MainLine_Select_Btn_Cancel"
  },
  goSortRare = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SortRarity"
  },
  goSortAffinity = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SortAffinity"
  },
  imgArrowUpEnable = {},
  imgArrowUpDisable = {},
  imgArrowDownEnable = {},
  imgArrowDownDisable = {},
  labSelected = {sComponentName = "TMP_Text"},
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
  },
  btnHome = {},
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnHelp = {},
  txtTitle = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "Dorm_CharListTitle"
  },
  TopBarPanel = {}
}
DormSelectCharCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter",
  Guide_PositionCharPos = "OnEvent_PositionCharPos",
  ForamtionDown = "OnEvent_ForamtionDown",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}

function DormSelectCharCtrl:Awake()
end

function DormSelectCharCtrl:FadeIn()
end

function DormSelectCharCtrl:FadeOut()
end

function DormSelectCharCtrl:OnEnable()
  self:SetSortBtnLable()
  self.tbSortCfg = {
    nSortType = PlayerData.Filter.nDormCharSrotType,
    bOrder = PlayerData.Filter.bDormCharOrder
  }
  self.mapGridCtrl = {}
  self.gameObject:SetActive(false)
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self.bOpen = false
  self.bInFavorite = false
  self:RefreshFavoriteTopState()
  self._mapNode.btnHome.gameObject:SetActive(false)
  self._mapNode.btnHelp.gameObject:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function DormSelectCharCtrl:OnDisable()
  self.bOpen = false
  self.tbFilterCfg = {}
  for nInstanceId, mapCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self.mapGridCtrl = {}
  self.gameObject:SetActive(false)
  self._mapNode.TopBarPanel:SetActive(true)
end

function DormSelectCharCtrl:OnDestroy()
end

function DormSelectCharCtrl:OnRelease()
end

function DormSelectCharCtrl:ShowList(tbCurSelectChar, bFastSelect, nIdx, tbCharInRoom)
  self.tbCharInRoom = tbCharInRoom
  self.tbOriginChar = clone(tbCurSelectChar)
  self.gameObject:SetActive(true)
  self.tbAllChar = PlayerData.Char:GetDataForCharList()
  self.bFastSelect = bFastSelect == true
  self.nIdx = not self.bFastSelect and nIdx or 0
  self.curChar = tbCurSelectChar
  self.bOpen = true
  self.nGuideOpenVer = (self.nGuideOpenVer or 0) + 1
  self.mapGridCtrl = {}
  self.tbFilterCfg = {}
  self:RefreshOrderState()
  self:FilterChar()
  self:SortChar()
  self._mapNode.sv:Init(#self.tbSortedChar, self, self.OnGridRefresh, self.OnGridBtnClick)
  self._mapNode.btnConfirm.gameObject:SetActive(true)
  self:SetCharCount()
  self:SetSortBtnState(self._mapNode.goSortRare, self.tbSortCfg.nSortType == AllEnum.SortType.Rarity, self.tbSortCfg.bOrder)
  self:SetSortBtnState(self._mapNode.goSortAffinity, self.tbSortCfg.nSortType == AllEnum.SortType.Affinity, self.tbSortCfg.bOrder)
end

function DormSelectCharCtrl:Refresh()
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

function DormSelectCharCtrl:CloseList()
  local function closeCallback()
    self.tbFilterCfg = {}
    
    for nInstanceId, mapCtrl in pairs(self.mapGridCtrl) do
      self:UnbindCtrlByNode(mapCtrl)
      self.mapGridCtrl[nInstanceId] = nil
    end
    self.mapGridCtrl = {}
    self.gameObject:SetActive(false)
    self._mapNode.TopBarPanel:SetActive(true)
    self.bOpen = false
    local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
    DormGuideAdapter.NoteCharClosed()
    EventManager.Hit("DormGuide_CharSelectClosed")
  end
  
  self.animator:Play("LiveTogether_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, closeCallback, true, true, true, nil)
  self._mapNode.TopBarPanel:SetActive(false)
end

function DormSelectCharCtrl:OnGridRefresh(goGrid, gridIndex)
  local nInstanceId = goGrid:GetInstanceID()
  if not self.mapGridCtrl[nInstanceId] then
    self.mapGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormCharSelect.DormCharListItem")
  end
  local nIndex = gridIndex + 1
  local nCharId = self.tbSortedChar[nIndex]
  local selectIdx = table.indexof(self.curChar, nCharId)
  local nMark = selectIdx
  local bBaned = false
  bBaned = self.tbCharInRoom[nCharId] ~= nil
  local nRoomId = bBaned and self.tbCharInRoom[nCharId] or 0
  self.mapGridCtrl[nInstanceId]:RefreshItem(0 < selectIdx, nMark, nCharId, bBaned, self.tbSortCfg.nSortType, nRoomId)
end

function DormSelectCharCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nCharId = self.tbSortedChar[nIndex]
  local nTeamIdx = table.indexof(self.curChar, nCharId)
  if 0 < nTeamIdx then
    self.curChar[nTeamIdx] = 0
    self:SetGridIndex(nCharId, 0)
    for idx, CharId in ipairs(self.curChar) do
      self:SetGridIndex(CharId, idx)
    end
    NovaAPI.DispatchEventWithData("DORM_LUA_SWITCH_ACTOR_CALLBACK", nil, {false, nCharId})
  else
    local nPos = table.indexof(self.curChar, 0)
    if 0 < nPos then
      self.curChar[nPos] = nCharId
      for idx, CharId in ipairs(self.curChar) do
        self:SetGridIndex(CharId, idx)
      end
      PlayerData.Voice:PlayCharVoice("swap", nCharId)
      local nSkinId = 0
      local mapChar = ConfigTable.GetData_Character(nCharId)
      if mapChar ~= nil then
        nSkinId = mapChar.DefaultSkinId
      end
      NovaAPI.DispatchEventWithData("DORM_LUA_SWITCH_ACTOR_CALLBACK", nil, {
        true,
        nCharId,
        nSkinId
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DormTips_RoleFull") or "")
    end
  end
  self:SetCharCount()
  EventManager.Hit("OnEvent_ChangeTeamModel", self.curChar)
end

function DormSelectCharCtrl:SetGridIndex(nCharId, nIdx)
  local nGirdIdx = table.indexof(self.tbSortedChar, nCharId)
  local trGrid = self._mapNode.rtCharListContent:Find(tostring(nGirdIdx - 1))
  if trGrid ~= nil then
    local nInstanceId = trGrid.gameObject:GetInstanceID()
    self.mapGridCtrl[nInstanceId]:SetSelect(0 < nIdx, nIdx)
  end
end

function DormSelectCharCtrl:FilterChar()
  self.tbSortedChar = {}
  for _, data in pairs(self.tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(data.nId)
    local mapDormCharCfgData = ConfigTable.GetData("DormRole", data.nId, false)
    local bAvailable = mapCharCfgData.Available and mapDormCharCfgData ~= nil
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

function DormSelectCharCtrl:SortChar()
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

function DormSelectCharCtrl:SetCharCount()
  local nCurCount = 0
  for _, nCharId in ipairs(self.curChar) do
    if nCharId ~= 0 then
      nCurCount = nCurCount + 1
    end
  end
  local mapDormRoomCfgData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  local maxCharCount = 0
  if mapDormRoomCfgData ~= nil then
    maxCharCount = mapDormRoomCfgData.RoleNum
  end
  NovaAPI.SetTMPText(self._mapNode.labSelected, orderedFormat(ConfigTable.GetUIText("Board_Selected_Count"), nCurCount, maxCharCount))
end

function DormSelectCharCtrl:MoveElementsToFront(sortedList, elementsToMove)
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

function DormSelectCharCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function DormSelectCharCtrl:RefreshByFilter()
  self:Refresh()
end

function DormSelectCharCtrl:OnEvent_ForamtionDown(nIdx)
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

function DormSelectCharCtrl:OnEvent_SortRuleChange(nValue)
  if not self.bOpen then
    return
  end
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Char:GetCharSortType()[nV]
  self.tbSortCfg.bOrder = false
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function DormSelectCharCtrl:OnBtnClick_Close(btn)
  EventManager.Hit("DormCharSelectResult", self.curChar, false)
end

function DormSelectCharCtrl:OnBtnClick_Clear(btn)
  for idx, nCharId in ipairs(self.curChar) do
    if self.curChar[idx] ~= 0 then
      self:SetGridIndex(self.curChar[i], 0)
      self.curChar[idx] = 0
    end
  end
  EventManager.Hit("OnEvent_ChangeTeamModel", self.curChar)
end

function DormSelectCharCtrl:OnBtnClick_Confirm(btn)
  EventManager.Hit("DormCharSelectResult", self.curChar, true)
end

function DormSelectCharCtrl:OnBtnClick_Filter()
  local tbOption = {
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_TacticalStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function DormSelectCharCtrl:OnEvent_PositionCharPos(_tmpChar)
  for i, v in pairs(self.tbSortedChar) do
    if v == _tmpChar then
      self._mapNode.sv:SetScrollGridPos(i - 1, 0, 0)
      EventManager.Hit("Positioning_Char_Grid", _tmpChar, i - 1)
      break
    end
  end
end

function DormSelectCharCtrl:SetSortBtnState(btn, bSelect, bOrder)
  local txtLable = btn.transform:Find("Dropdown/Label"):GetComponent("TMP_Text")
  local imgArrowUp = btn.transform:Find("Dropdown/goDummy/imgArrowUp"):GetComponent("Image")
  local imgArrowDown = btn.transform:Find("Dropdown/goDummy/imgArrowDown"):GetComponent("Image")
  if bSelect then
    NovaAPI.SetImageColor(imgArrowUp, bOrder and Select or Unselect)
    NovaAPI.SetImageColor(imgArrowDown, bOrder and Unselect or Select)
  else
    NovaAPI.SetImageColor(imgArrowUp, Unselect)
    NovaAPI.SetImageColor(imgArrowDown, Unselect)
  end
  NovaAPI.SetTMPColor(txtLable, bSelect and Select or Unselect)
end

function DormSelectCharCtrl:SetSortBtnLable()
  local txtLable1 = self._mapNode.goSortAffinity.transform:Find("Dropdown/Label"):GetComponent("TMP_Text")
  local txtLable2 = self._mapNode.goSortRare.transform:Find("Dropdown/Label"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtLable1, ConfigTable.GetUIText("CharList_Sort_Toggle_Affinity"))
  NovaAPI.SetTMPText(txtLable2, ConfigTable.GetUIText("Depot_SortByRare"))
end

function DormSelectCharCtrl:OnBtnClick_SortRarity(btn)
  if self.tbSortCfg.nSortType == AllEnum.SortType.Rarity then
    self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  else
    self.tbSortCfg.nSortType = AllEnum.SortType.Rarity
    self.tbSortCfg.bOrder = true
  end
  PlayerData.Filter:CacheDormSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:SetSortBtnState(btn, true, self.tbSortCfg.bOrder)
  self:SetSortBtnState(self._mapNode.goSortAffinity, false, self.tbSortCfg.bOrder)
  self:Refresh()
end

function DormSelectCharCtrl:OnBtnClick_SortAffinity(btn)
  if self.tbSortCfg.nSortType == AllEnum.SortType.Affinity then
    self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  else
    self.tbSortCfg.nSortType = AllEnum.SortType.Affinity
    self.tbSortCfg.bOrder = true
  end
  PlayerData.Filter:CacheDormSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:SetSortBtnState(btn, true, self.tbSortCfg.bOrder)
  self:SetSortBtnState(self._mapNode.goSortRare, false, self.tbSortCfg.bOrder)
  self:Refresh()
end

function DormSelectCharCtrl:RefreshFavoriteTopState()
  if self.bInFavorite then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.InFavoriteOrder, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.InFavoriteOrder, 0)
  end
end

function DormSelectCharCtrl:OnBtnClick_InFavoriteOrder(btn)
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

return DormSelectCharCtrl
