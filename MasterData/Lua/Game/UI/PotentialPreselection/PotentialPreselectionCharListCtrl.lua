local PotentialPreselectionCharListCtrl = class("PotentialPreselectionCharListCtrl", BaseCtrl)
PotentialPreselectionCharListCtrl._mapNodeConfig = {
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
  imgArrowDownDisable = {}
}
PotentialPreselectionCharListCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter",
  ForamtionDown = "OnEvent_ForamtionDown",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}
PotentialPreselectionCharListCtrl._mapRedDotConfig = {}

function PotentialPreselectionCharListCtrl:ShowList(tbCurSelectChar)
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self.tbOriginChar = clone(tbCurSelectChar)
  self.gameObject:SetActive(true)
  if self.tbAllChar == nil then
    self.tbAllChar = {}
    
    local function func_EachChar(mapLineData)
      if mapLineData.Visible == true and mapLineData.Available == true then
        local mapChar = {}
        local nCharId = mapLineData.Id
        local mapCharData = PlayerData.Char:GetCharDataByTid(nCharId)
        local nCharLv = 0
        local nCreateTime = 0
        local nCharAdvance = 0
        local nAffinityLevel = 0
        if mapCharData ~= nil then
          nCharLv = PlayerData.Char:GetCharLv(nCharId)
          nCreateTime = PlayerData.Char:GetCreateTime(nCharId)
          nCharAdvance = PlayerData.Char:GetCharAdvance(nCharId)
          local mapData = PlayerData.Char:GetCharAffinityData(nCharId)
          nAffinityLevel = mapData ~= nil and mapData.Level or 0
        end
        mapChar.nId = nCharId
        mapChar.Name = mapLineData.Name
        mapChar.Rare = mapLineData.Grade
        mapChar.Class = mapLineData.Class
        mapChar.EET = mapLineData.EET
        mapChar.Level = nCharLv
        mapChar.CreateTime = nCreateTime
        mapChar.Advance = nCharAdvance
        mapChar.Favorability = nAffinityLevel
        table.insert(self.tbAllChar, mapChar)
      end
    end
    
    ForEachTableLine(DataTable.Character, func_EachChar)
  end
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
  self.tbFilterCfg = {}
  self:RefreshOrderState()
  self:FilterChar()
  self:SortChar()
  for nInstanceId, mapCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self._mapNode.sv:Init(#self.tbSortedChar, self, self.OnGridRefresh, self.OnGridBtnClick)
  self._mapNode.btnConfirm.gameObject:SetActive(true)
  self._mapNode.btnCloseList.gameObject:SetActive(true)
end

function PotentialPreselectionCharListCtrl:Refresh()
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self:FilterChar()
  self:SortChar()
  self:RefreshOrderState()
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

function PotentialPreselectionCharListCtrl:CloseList()
  self.tbFilterCfg = {}
  for nInstanceId, mapCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self.mapGridCtrl = {}
  self.gameObject:SetActive(false)
end

function PotentialPreselectionCharListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nInstanceId = goGrid:GetInstanceID()
  if not self.mapGridCtrl[nInstanceId] then
    self.mapGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.PotentialPreselection.PotentialPreselectionCharItemCtrl")
  end
  local nIndex = gridIndex + 1
  local nCharId = self.tbSortedChar[nIndex]
  local selectIdx = table.indexof(self.curChar, nCharId)
  self.mapGridCtrl[nInstanceId]:RefreshItem(selectIdx, nCharId, self.tbSortCfg.nSortType)
end

function PotentialPreselectionCharListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nCharId = self.tbSortedChar[nIndex]
  local nTeamIdx = table.indexof(self.curChar, nCharId)
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
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Formation_FullTeam") or "")
    end
  end
end

function PotentialPreselectionCharListCtrl:SetGridIndex(nCharId, nIdx)
  local nGirdIdx = table.indexof(self.tbSortedChar, nCharId)
  local trGrid = self._mapNode.rtCharListContent:Find(tostring(nGirdIdx - 1))
  if trGrid ~= nil then
    local nInstanceId = trGrid.gameObject:GetInstanceID()
    self.mapGridCtrl[nInstanceId]:SetSelect(0 < nIdx, nIdx)
  end
end

function PotentialPreselectionCharListCtrl:FilterChar()
  self.tbSortedChar = {}
  for nId, data in pairs(self.tbAllChar) do
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

function PotentialPreselectionCharListCtrl:SortChar()
  local tbCharId = {}
  UTILS.SortByPriority(self.tbSortedChar, {
    AllEnum.CharSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Char:GetCharSortField(), self.tbSortCfg.bOrder)
  self.tbSortedChar = self:MoveElementsToFront(self.tbSortedChar, self.curChar)
  for _, mapCharId in ipairs(self.tbSortedChar) do
    table.insert(tbCharId, mapCharId.nId)
  end
  self.tbSortedChar = tbCharId
end

function PotentialPreselectionCharListCtrl:MoveElementsToFront(sortedList, elementsToMove)
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

function PotentialPreselectionCharListCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function PotentialPreselectionCharListCtrl:RefreshByFilter()
  self:Refresh()
end

function PotentialPreselectionCharListCtrl:Awake()
  self.mapGridCtrl = {}
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
end

function PotentialPreselectionCharListCtrl:OnEnable()
end

function PotentialPreselectionCharListCtrl:OnDisable()
  self:CloseList()
end

function PotentialPreselectionCharListCtrl:OnDestroy()
end

function PotentialPreselectionCharListCtrl:OnRelease()
end

function PotentialPreselectionCharListCtrl:OnEvent_ForamtionDown(nIdx)
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

function PotentialPreselectionCharListCtrl:OnEvent_SortRuleChange(nValue)
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Char:GetCharSortType()[nV]
  self.tbSortCfg.bOrder = false
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function PotentialPreselectionCharListCtrl:OnBtnClick_Order(btn)
  self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function PotentialPreselectionCharListCtrl:OnBtnClick_Clear()
  for i = 1, 3 do
    if self.curChar[i] ~= 0 then
      self:SetGridIndex(self.curChar[i], 0)
      self.curChar[i] = 0
    end
  end
end

function PotentialPreselectionCharListCtrl:OnBtnClick_Confirm()
  local bFull = true
  for _, v in ipairs(self.curChar) do
    if v == 0 then
      bFull = false
      break
    end
  end
  if not bFull then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Char_Not_Full"))
    return
  end
  EventManager.Hit("ClosePreselectionCharList", self.curChar)
end

function PotentialPreselectionCharListCtrl:OnBtnClick_Filter()
  local tbOption = {
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_TacticalStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

return PotentialPreselectionCharListCtrl
