local DiscListCtrl = class("DiscListCtrl", BaseCtrl)
DiscListCtrl._mapNodeConfig = {
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
  imgFilterChoose = {},
  aniPanel = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
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
  imgArrowDownDisable = {},
  btnBreakLimitAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BreakLimitAll"
  },
  txtBtnBreakLimitAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Btn_BreakLimitAll"
  }
}
DiscListCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter",
  SelectTemplateDD = "OnEvent_SortRuleChange"
}

function DiscListCtrl:Refresh()
  local isDirty = PlayerData.Filter:IsDirty(AllEnum.OptionType.Disc)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  self:FilterDisc()
  self:SortDisc()
  self:RefreshOrderState()
  self:RefreshAllBreakLimit()
  local nCurCount = #self.tbSortedDisc
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

function DiscListCtrl:FilterDisc()
  self.tbSortedDisc = {}
  for _, data in pairs(self.tbAllDisc) do
    local mapCfg = ConfigTable.GetData("Disc", data.nId)
    if mapCfg.Visible then
      local isFilter = PlayerData.Filter:CheckFilterByDisc(data.nId)
      if isFilter then
        table.insert(self.tbSortedDisc, data)
      end
    end
  end
end

function DiscListCtrl:SortDisc()
  self.tbDiscId = {}
  UTILS.SortByPriority(self.tbSortedDisc, {
    AllEnum.DiscSortField[self.tbSortCfg.nSortType]
  }, PlayerData.Disc:GetDiscSortField(), self.tbSortCfg.bOrder)
  for i = 1, #self.tbSortedDisc do
    table.insert(self.tbDiscId, self.tbSortedDisc[i].nId)
  end
end

function DiscListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateDiscCtrl")
  end
  self.tbGridCtrl[nInstanceId]:Refresh(self.tbSortedDisc[nIndex].nId)
end

function DiscListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  EventManager.Hit(EventId.OpenPanel, PanelId.Disc, self.tbSortedDisc[nIndex].nId, self.tbDiscId)
  self._panel._nFadeInType = 2
end

function DiscListCtrl:RefreshOrderState()
  self._mapNode.imgArrowUpEnable:SetActive(self.tbSortCfg.bOrder)
  self._mapNode.imgArrowUpDisable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownEnable:SetActive(not self.tbSortCfg.bOrder)
  self._mapNode.imgArrowDownDisable:SetActive(self.tbSortCfg.bOrder)
end

function DiscListCtrl:RefreshAllBreakLimit()
  self.tbMat = PlayerData.Disc:GetAllBreakLimitMat()
  self._mapNode.btnBreakLimitAll.gameObject:SetActive(next(self.tbMat) ~= nil)
end

function DiscListCtrl:FadeIn(bPlayFadeIn)
  if self._panel._nFadeInType == 1 then
    EventManager.Hit(EventId.SetTransition)
    self._mapNode.aniPanel:SetTrigger("tIn")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  end
end

function DiscListCtrl:Awake()
  self.tbFilterCfg = {}
  self.bFirstIn = true
  self.bOpen = false
end

function DiscListCtrl:OnEnable()
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
  self.tbSortedDisc = {}
  self.tbDiscId = {}
  self.tbGridCtrl = {}
  self:Refresh()
  self.bOpen = true
end

function DiscListCtrl:OnDisable()
  self.bOpen = false
  self.tbSortedDisc = nil
  self.tbDiscId = nil
  self.tbAllDisc = nil
  self.bFirstIn = false
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function DiscListCtrl:OnDestroy()
  self.tbFilterCfg = nil
  self.tbSortCfg = nil
end

function DiscListCtrl:RefreshByFilter()
  self:Refresh()
end

function DiscListCtrl:OnEvent_SortRuleChange(nValue)
  if not self.bOpen then
    return
  end
  local nV = nValue + 1
  self.tbSortCfg.nSortType = PlayerData.Disc:GetDiscSortType()[nV]
  self.tbSortCfg.bOrder = false
  PlayerData.Filter:CacheDiscSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function DiscListCtrl:OnBtnClick_Order(btn)
  self.tbSortCfg.bOrder = not self.tbSortCfg.bOrder
  PlayerData.Filter:CacheDiscSort(self.tbSortCfg.nSortType, self.tbSortCfg.bOrder)
  self:Refresh()
end

function DiscListCtrl:OnBtnClick_Filter()
  local tbOption = {
    AllEnum.ChooseOption.Star_Rarity,
    AllEnum.ChooseOption.Star_Element,
    AllEnum.ChooseOption.Star_Tag,
    AllEnum.ChooseOption.Star_Note
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function DiscListCtrl:OnCharacterScreenConfirm(tbFilterCfg)
end

function DiscListCtrl:OnBtnClick_BreakLimitAll()
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSucBar, {
      tbMat = self.tbMat
    }, AllEnum.DiscSucBar.BreakLimitAll)
    self.tbAllDisc = PlayerData.Disc:GetAllDisc()
    if not self.bOpen then
      return
    end
    self:Refresh()
  end
  
  local function allBreak()
    PlayerData.Disc:SendAllDiscLimitBreakReq(callback)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Item,
    sTitle = ConfigTable.GetUIText("Disc_BreakLimitAll_Title"),
    sContent = ConfigTable.GetUIText("Disc_BreakLimitAll_Tip"),
    tbItem = self.tbMat,
    callbackConfirm = function()
      allBreak()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return DiscListCtrl
