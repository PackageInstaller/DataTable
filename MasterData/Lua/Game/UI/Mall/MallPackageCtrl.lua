local MallPackageCtrl = class("MallPackageCtrl", BaseCtrl)
MallPackageCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  cgSv = {
    sNodeName = "sv",
    sComponentName = "CanvasGroup"
  },
  tab = {},
  trTab = {sComponentName = "Transform"},
  svTab = {sComponentName = "ScrollRect"}
}
MallPackageCtrl._mapEventConfig = {
  MallOrderClear = "Refresh",
  OpenMallPackageDetail = "OnEvent_OpenMallPackageDetail"
}

function MallPackageCtrl:Refresh(bResetPos)
  if self._panel.nCurTog ~= AllEnum.MallToggle.Package then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSv, 0)
  
  local function callback(tbList, nTime)
    self:RefreshData(tbList)
    self:RefreshTab()
    self:RefreshList(bResetPos)
    self:SetTimer(nTime)
    if self.nAutoSelectPackageId then
      local nIndex = 1
      for k, v in ipairs(self.tbPackagePage[1]) do
        if v.sId == self.nAutoSelectPackageId then
          nIndex = k
          break
        end
      end
      EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Package, self.tbPackagePage[1][nIndex], {
        AllEnum.CoinItemId.FREESTONE
      })
      self.nAutoSelectPackageId = nil
    end
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSv, 1)
  end
  
  PlayerData.Mall:SendMallPackageListReq(callback)
end

function MallPackageCtrl:RefreshData(tbList)
  local tbPage = PlayerData.Mall:GetPackagePage(GameEnum.MallItemType.Package)
  local tbAllList = {}
  local tbPackageToPage = {}
  for _, v in pairs(tbList) do
    local mapCfg = ConfigTable.GetData("MallPackage", v.sId)
    if mapCfg.Tag == GameEnum.MallItemType.Package then
      local nGroupId = mapCfg.GroupId
      if not tbPackageToPage[nGroupId] then
        tbPackageToPage[nGroupId] = {}
      end
      table.insert(tbPackageToPage[nGroupId], v)
      table.insert(tbAllList, v)
    end
  end
  self.tbPackagePage, self.tbPages = {}, {}
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

function MallPackageCtrl:RefreshList(bResetPos)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  local tbCur = self.tbPackagePage[self.nCurTab]
  self._mapNode.sv:SetAnim(0.04)
  self._mapNode.sv:Init(#tbCur, self, self.OnGridRefresh, self.OnGridBtnClick, not bResetPos)
end

function MallPackageCtrl:RefreshTab()
  self._mapNode.svTab.gameObject:SetActive(true)
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
    RedDotManager.RegisterNode(RedDotDefine.Mall_Tab_New, {
      AllEnum.MallToggle.Package,
      self.tbPages[i].Sort
    }, goTabNew)
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

function MallPackageCtrl:SetTimer(nTime)
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  if 0 < nTime then
    self.timer = self:AddTimer(1, nTime, function()
      self:Refresh(true)
      EventManager.Hit(EventId.CloseMessageBox)
      EventManager.Hit("MallCloseDetail")
    end, true, true, false)
  end
end

function MallPackageCtrl:GetTabState(nCurTab)
  local nState = 2
  if nCurTab == 1 then
    nState = 1
  elseif nCurTab == self.nPageCount then
    nState = 3
  end
  return nState
end

function MallPackageCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbPackagePage[self.nCurTab][nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Mall.MallPackageItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
end

function MallPackageCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Package, self.tbPackagePage[self.nCurTab][nIndex], {
    AllEnum.CoinItemId.FREESTONE
  })
end

function MallPackageCtrl:ResetTab(nTab)
  if not self.ctrlTab then
    return
  end
  if nTab ~= nil then
    self.nCurTab = nTab
  end
  if self.nCurTab and self.nCurTab > 1 then
    local nState = self:GetTabState(self.nCurTab)
    self.ctrlTab[self.nCurTab]:SetSelect(false, nState)
    self.ctrlTab[self.nCurTab - 1]:SetLine(true)
  end
  if nTab == nil then
    self.nCurTab = 1
  end
  self.ctrlTab[self.nCurTab]:SetSelect(true, 1)
  self.nSelectPage = self.tbPages[self.nCurTab] and self.tbPages[self.nCurTab].Id or nil
end

function MallPackageCtrl:GetCurSort()
  if not self.tbPages or not self.tbPages[self.nCurTab] then
    return 0
  end
  return self.tbPages[self.nCurTab].Sort
end

function MallPackageCtrl:Awake()
  self.tbGridCtrl = {}
  self._mapNode.svTab.gameObject:SetActive(false)
end

function MallPackageCtrl:OnEnable()
end

function MallPackageCtrl:OnDisable()
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
  self.nAutoSelectPackageId = nil
end

function MallPackageCtrl:OnDestroy()
end

function MallPackageCtrl:OnBtnClick_ChangeSheet(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  local nSort = self:GetCurSort()
  PlayerData.Mall:RemovePackageNew(GameEnum.MallItemType.Package, nSort)
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

function MallPackageCtrl:OnEvent_OpenMallPackageDetail(sPackageId)
  local nPage = 1
  local nIndex = 1
  for i, v in ipairs(self.tbPackagePage) do
    for j, m in ipairs(v) do
      if m.sId == sPackageId then
        nPage = i
        nIndex = j
        break
      end
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.MallPopup, AllEnum.MallToggle.Package, self.tbPackagePage[nPage][nIndex], {
    AllEnum.CoinItemId.FREESTONE
  })
end

return MallPackageCtrl
