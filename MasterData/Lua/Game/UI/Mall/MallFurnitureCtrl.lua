local MallFurnitureCtrl = class("MallFurnitureCtrl", BaseCtrl)
MallFurnitureCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  cgSv = {
    sNodeName = "sv",
    sComponentName = "CanvasGroup"
  },
  tab = {},
  trTab = {sComponentName = "Transform"},
  svTab = {sComponentName = "ScrollRect"},
  goEmpty = {},
  txtFurnitureEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Furniture_Empty"
  }
}
MallFurnitureCtrl._mapEventConfig = {MallOrderClear = "Refresh"}

function MallFurnitureCtrl:Refresh(bResetPos)
  if self._panel.nCurTog ~= AllEnum.MallToggle.Furniture then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSv, 0)
  
  local function callback(tbList, nTime)
    self:RefreshData(tbList)
    self:RefreshTab()
    self:RefreshList(bResetPos)
    self:SetTimer(nTime)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSv, 1)
  end
  
  PlayerData.Mall:SendMallPackageListReq(callback)
end

function MallFurnitureCtrl:RefreshData(tbList)
  local tbPage = PlayerData.Mall:GetPackagePage(GameEnum.MallItemType.Furniture)
  local tbAllList = {}
  local tbPackageToPage = {}
  for _, v in pairs(tbList) do
    local mapCfg = ConfigTable.GetData("MallPackage", v.sId)
    if mapCfg.Tag == GameEnum.MallItemType.Furniture then
      local nGroupId = mapCfg.GroupId
      if not tbPackageToPage[nGroupId] then
        tbPackageToPage[nGroupId] = {}
      end
      table.insert(tbPackageToPage[nGroupId], v)
      table.insert(tbAllList, v)
    end
  end
  self.tbPackagePage, self.tbPages = {}, {}
  table.insert(self.tbPackagePage, tbAllList)
  self.tbPages[1] = {
    Id = 0,
    Name = ConfigTable.GetUIText("Mall_Package_TabAll"),
    Sort = 0
  }
  for _, v in pairs(tbPage) do
    if tbPackageToPage[v.Id] then
      table.insert(self.tbPackagePage, tbPackageToPage[v.Id])
      table.insert(self.tbPages, v)
    end
  end
  self.nPageCount = #self.tbPages
  local nTab
  if self._panel.nDefaultId then
    for k, v in ipairs(self.tbPages) do
      if v.Id == self._panel.nDefaultId then
        nTab = k
        self._panel.nDefaultId = nil
        break
      end
    end
  end
  if nTab == nil and self.nSelectPage then
    for k, v in ipairs(self.tbPages) do
      if v.Id == self.nSelectPage then
        nTab = k
        break
      end
    end
  end
  self.nCurTab = nTab or 1
  self.nSelectPage = self.tbPages[self.nCurTab].Id
end

function MallFurnitureCtrl:RefreshList(bResetPos)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbCurList = self.tbPackagePage[self.nCurTab] or {}
  if #self.tbCurList == 0 then
    self._mapNode.goEmpty.gameObject:SetActive(true)
    self._mapNode.sv.gameObject:SetActive(false)
    self._mapNode.svTab.gameObject:SetActive(false)
  else
    self._mapNode.goEmpty.gameObject:SetActive(false)
    self._mapNode.sv.gameObject:SetActive(true)
    self._mapNode.svTab.gameObject:SetActive(true)
    self._mapNode.sv:SetAnim(0.04)
    self._mapNode.sv:Init(#self.tbCurList, self, self.OnGridRefresh, self.OnGridBtnClick, not bResetPos)
  end
end

function MallFurnitureCtrl:RefreshTab()
  NovaAPI.SetScrollHorizontal(self._mapNode.svTab, self.nPageCount > 4)
  self.ctrlTab = {}
  delChildren(self._mapNode.trTab)
  for i = 1, self.nPageCount do
    local goTab = instantiate(self._mapNode.tab, self._mapNode.trTab)
    goTab:SetActive(true)
    local btn = goTab.transform:Find("btnTab"):GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_ChangeSheet, goTab, i)
    btn.onClick:AddListener(func_Handler)
    self.ctrlTab[i] = self:BindCtrlByNode(goTab, "Game.UI.TemplateEx.TemplateTabCtrl")
    local goTabNew = goTab.transform:Find("btnTab/AnimRoot/redDot_New").gameObject
    if i == 1 then
      RedDotManager.RegisterNode(RedDotDefine.Mall_Page_New, {
        AllEnum.MallToggle.Furniture
      }, goTabNew)
    else
      RedDotManager.RegisterNode(RedDotDefine.Mall_Tab_New, {
        AllEnum.MallToggle.Furniture,
        self.tbPages[i].Sort
      }, goTabNew)
    end
    self.ctrlTab[i]:SetText(self.tbPages[i].Name)
  end
  for i = 1, self.nPageCount do
    local nState = self:GetTabState(i)
    self.ctrlTab[i]:SetSelect(i == self.nCurTab, nState)
    if i == self.nCurTab and 1 < i then
      self.ctrlTab[i - 1]:SetLine(false)
    end
  end
end

function MallFurnitureCtrl:SetTimer(nTime)
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  if 0 < nTime then
    self.timer = self:AddTimer(1, nTime, function()
      self:Refresh(true)
      EventManager.Hit("MallCloseDetail")
    end, true, true, false)
  end
end

function MallFurnitureCtrl:GetTabState(nCurTab)
  local nState = 2
  if nCurTab == 1 then
    nState = 1
  elseif nCurTab == self.nPageCount then
    nState = 3
  end
  return nState
end

function MallFurnitureCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbPackagePage[self.nCurTab][nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Mall.MallFurnitureItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
end

function MallFurnitureCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbPackagePage[self.nCurTab][nIndex]
  if not mapData then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Furniture, mapData, {
    AllEnum.CoinItemId.Furniture
  })
end

function MallFurnitureCtrl:ResetTab()
  if not self.ctrlTab then
    return
  end
  if self.nCurTab and self.nCurTab > 1 then
    local nState = self:GetTabState(self.nCurTab)
    self.ctrlTab[self.nCurTab]:SetSelect(false, nState)
    self.ctrlTab[self.nCurTab - 1]:SetLine(true)
  end
  self.nCurTab = 1
  self.ctrlTab[self.nCurTab]:SetSelect(true, 1)
  self.nSelectPage = self.tbPages[self.nCurTab] and self.tbPages[self.nCurTab].Id or nil
end

function MallFurnitureCtrl:GetCurSort()
  if not self.tbPages or not self.tbPages[self.nCurTab] then
    return 0
  end
  return self.tbPages[self.nCurTab].Sort
end

function MallFurnitureCtrl:Awake()
  self.tbGridCtrl = {}
  self._mapNode.goEmpty.gameObject:SetActive(false)
  self._mapNode.sv.gameObject:SetActive(false)
  self._mapNode.svTab.gameObject:SetActive(false)
end

function MallFurnitureCtrl:OnEnable()
end

function MallFurnitureCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  if self.ctrlTab then
    for nTab, objCtrl in pairs(self.ctrlTab) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTab[nTab] = nil
    end
    self.ctrlTab = nil
  end
end

function MallFurnitureCtrl:OnDestroy()
end

function MallFurnitureCtrl:OnBtnClick_ChangeSheet(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  local nSort = self:GetCurSort()
  PlayerData.Mall:RemovePackageNew(GameEnum.MallItemType.Furniture, nSort)
  local nState = self:GetTabState(self.nCurTab)
  self.ctrlTab[self.nCurTab]:SetSelect(false, nState)
  if self.nCurTab > 1 then
    self.ctrlTab[self.nCurTab - 1]:SetLine(true)
  end
  nState = self:GetTabState(nIndex)
  self.ctrlTab[nIndex]:SetSelect(true, nState)
  if 1 < nIndex then
    self.ctrlTab[nIndex - 1]:SetLine(false)
  end
  self.nCurTab = nIndex
  self.nSelectPage = self.tbPages[self.nCurTab].Id
  self:RefreshList(true)
end

return MallFurnitureCtrl
