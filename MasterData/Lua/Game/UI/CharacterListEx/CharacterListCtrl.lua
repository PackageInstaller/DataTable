local CharacterListCtrl = class("CharacterListCtrl", BaseCtrl)
CharacterListCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgEmpty = {},
  labEmpty = {
    sNodeName = "txt_EmptyTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "Filter_NoAim"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  btnFilter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Filter"
  },
  btnOrder = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Order"
  },
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
  imgFilterChoose = {},
  aniPanel = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  goSortDropdown = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDropdownCtrl"
  },
  imgArrowUpEnable = {},
  imgArrowUpDisable = {},
  imgArrowDownEnable = {},
  imgArrowDownDisable = {}
}
CharacterListCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter",
  Guide_PositionCharPos = "OnEvent_PositionCharPos",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}

function CharacterListCtrl:Refresh()
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Char)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self:SortChar()
  self:FilterChar()
  self:RefreshOrderState()
  self:RefreshFavoriteTopState()
  local nCurCount = #self.tbSortedChar
  if 0 < nCurCount then
    self._mapNode.imgEmpty:SetActive(false)
    self._mapNode.sv.gameObject:SetActive(true)
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.sv:Init(nCurCount, self, self.OnGridRefresh, self.OnGridBtnClick, self.bFirstIn == false)
  else
    self._mapNode.imgEmpty:SetActive(true)
    self._mapNode.sv.gameObject:SetActive(false)
  end
end

function CharacterListCtrl:FilterChar()
  local tbCharId = {}
  local tbSortedChar = {}
  for i = 1, #self.tbCharId do
    local nId = self.tbCharId[i]
    local mapCfg = ConfigTable.GetData_Character(nId)
    if mapCfg.Visible then
      local isFilter = PlayerData.Filter:CheckFilterByChar(nId)
      if isFilter then
        table.insert(tbCharId, nId)
        table.insert(tbSortedChar, self.tbSortedChar[i])
      end
    end
  end
  self.tbSortedChar = tbSortedChar
  self.tbCharId = tbCharId
end

function CharacterListCtrl:GetFragmentsStateFunc(a, b)
  local aWeight = 0
  local bWeight = 0
  if a.nFragments ~= nil then
    if a.nFragments >= a.nNeedFragments then
      aWeight = 1
    else
      aWeight = -1
    end
  end
  if b.nFragments ~= nil then
    if b.nFragments >= b.nNeedFragments then
      bWeight = 1
    else
      bWeight = -1
    end
  end
  return aWeight, bWeight
end

function CharacterListCtrl:SortChar()
  self.tbCharId = {}
  self.tbSortedChar = {}
  UTILS.SortByPriority(self.tbAllChar, {
    AllEnum.CharSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Char:GetCharSortField(), self.tbSortCfg.bOrder, self.bInFavorite)
  UTILS.SortByPriority(self.tbUnlockableChar, {
    AllEnum.CharSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Char:GetCharSortField(), self.tbSortCfg.bOrder)
  UTILS.SortByPriority(self.tbFragmentsChar, {
    AllEnum.CharSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Char:GetCharSortField(), self.tbSortCfg.bOrder)
  for i = 1, #self.tbUnlockableChar do
    table.insert(self.tbCharId, self.tbUnlockableChar[i].nId)
    table.insert(self.tbSortedChar, self.tbUnlockableChar[i])
  end
  for i = 1, #self.tbAllChar do
    table.insert(self.tbCharId, self.tbAllChar[i].nId)
    table.insert(self.tbSortedChar, self.tbAllChar[i])
  end
  for i = 1, #self.tbFragmentsChar do
    table.insert(self.tbCharId, self.tbFragmentsChar[i].nId)
    table.insert(self.tbSortedChar, self.tbFragmentsChar[i])
  end
end

function CharacterListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateCharCtrl")
  end
  local bLocked = self.tbSortedChar[nIndex].nFragments ~= nil
  self.tbGridCtrl[nInstanceId]:SetChar(self.tbSortedChar[nIndex].nId, true, bLocked, nil, self.tbSortCfg.nSortType)
  self:OnRefreshFragmentsState(goGrid, nIndex)
end

function CharacterListCtrl:OnRefreshFragmentsState(goGrid, nIndex)
  local goCharLock = goGrid.transform:Find("btnGrid/AnimRoot/goCharLock")
  local bLocked = self.tbSortedChar[nIndex].nFragments ~= nil
  goCharLock.gameObject:SetActive(bLocked)
  if not bLocked then
    return
  end
  local imgRecruit = goCharLock:Find("imgRecruitBg")
  local imgProgress = goCharLock:Find("imgProgress"):GetComponent("Image")
  local txtProgress = goCharLock:Find("txtProgress"):GetComponent("TMP_Text")
  local imgItem = goCharLock:Find("imgItem"):GetComponent("Image")
  local nFragments = self.tbSortedChar[nIndex].nFragments
  local nNeedFragments = self.tbSortedChar[nIndex].nNeedFragments
  imgRecruit.gameObject:SetActive(nFragments >= nNeedFragments)
  NovaAPI.SetImageFillAmount(imgProgress, nFragments / nNeedFragments)
  NovaAPI.SetTMPText(txtProgress, string.format("%d/%d", nFragments, nNeedFragments))
  local mapData = ConfigTable.GetData_Character(self.tbSortedChar[nIndex].nId)
  self:SetPngSprite(imgItem, ConfigTable.GetData_Item(mapData.FragmentsId).Icon)
end

function CharacterListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local bLocked = self.tbSortedChar[nIndex].nFragments ~= nil
  if not bLocked then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.tbSortedChar[nIndex].nId, self.tbCharId, true)
    self._panel._nFadeInType = 2
  elseif self.tbSortedChar[nIndex].nFragments >= self.tbSortedChar[nIndex].nNeedFragments then
    local mapData = ConfigTable.GetData_Character(self.tbSortedChar[nIndex].nId)
    if mapData ~= nil then
      local stip = orderedFormat(ConfigTable.GetUIText("Confirm_Recruit_Char"), mapData.Name)
      
      local function callBack()
        self:OnEnable()
      end
      
      local function confirmCallback()
        PlayerData.Char:ReqCharFragmentRecruit(self.tbSortedChar[nIndex].nId, callBack)
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = stip,
        callbackConfirm = confirmCallback
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("CharShard_Not_Enough"))
  end
end

function CharacterListCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function CharacterListCtrl:RefreshFavoriteTopState()
  if self.bInFavorite then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.InFavoriteOrder, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.InFavoriteOrder, 0)
  end
end

function CharacterListCtrl:FadeIn(bPlayFadeIn)
  if self._panel._nFadeInType == 1 then
    EventManager.Hit(EventId.SetTransition)
    self._mapNode.aniPanel:SetTrigger("tIn")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  end
end

function CharacterListCtrl:Awake()
  self.tbFilterCfg = {}
  self.bOpen = false
end

function CharacterListCtrl:OnEnable()
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
  self.bInFavorite = true
  self.tbAllChar = {}
  local ownedChar = PlayerData.Char:GetDataForCharList()
  local fragmentsChar = PlayerData.Item:GetCharFragmentsData()
  self.tbUnlockableChar = {}
  self.tbFragmentsChar = {}
  for _, mapChar in pairs(ownedChar) do
    local mapSkill = PlayerData.Char:GetCharSkillUpgradeData(mapChar.nId)
    local nSkillLevelSum = 0
    for k, v in pairs(mapSkill) do
      nSkillLevelSum = nSkillLevelSum + v.nLv
    end
    mapChar.SkillLevel = nSkillLevelSum
    table.insert(self.tbAllChar, mapChar)
  end
  for k, v in ipairs(fragmentsChar) do
    if v.nFragments >= v.nNeedFragments then
      table.insert(self.tbUnlockableChar, v)
    else
      table.insert(self.tbFragmentsChar, v)
    end
  end
  self.tbSortedChar = {}
  self.tbCharId = {}
  self.tbGridCtrl = {}
  self._mapNode.imgFilterChoose:SetActive(false)
  self:Refresh()
  self.bOpen = true
end

function CharacterListCtrl:OnDisable()
  self.tbSortedChar = nil
  self.tbCharId = nil
  self.tbAllChar = nil
  self.bFirstIn = false
  self.bOpen = false
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function CharacterListCtrl:OnDestroy()
  self.tbFilterCfg = nil
  self.tbSortCfg = nil
end

function CharacterListCtrl:RefreshByFilter()
  self:Refresh()
end

function CharacterListCtrl:OnEvent_SortRuleChange(nValue)
  if not self.bOpen then
    return
  end
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Char:GetCharSortType()[nV]
  self.tbSortCfg.bOrder = false
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function CharacterListCtrl:OnBtnClick_Order(btn)
  self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  PlayerData.Filter:CacheCharSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function CharacterListCtrl:OnBtnClick_Filter()
  local tbOption = {
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces,
    AllEnum.ChooseOption.Char_TacticalStyle
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function CharacterListCtrl:OnBtnClick_InFavoriteOrder()
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

function CharacterListCtrl:OnEvent_PositionCharPos(_tmpChar)
  for i, v in pairs(self.tbSortedChar) do
    if v.nId == _tmpChar then
      self._mapNode.sv:SetScrollGridPos(i - 1, 0, 0)
      EventManager.Hit("Positioning_Char_Grid", _tmpChar, i - 1)
      break
    end
  end
end

return CharacterListCtrl
