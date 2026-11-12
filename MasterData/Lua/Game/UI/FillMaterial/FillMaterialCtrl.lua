local FillMaterialCtrl = class("FillMaterialCtrl", BaseCtrl)
FillMaterialCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseDatail = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_Title"
  },
  txtSrcTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_SourceMaterial"
  },
  txtDstTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_TargetMaterial"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  txtBtnConfirm1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goSrcList = {nCount = 2},
  goDstList = {nCount = 2},
  trSrcList = {sNodeName = "goSrcList1", sComponentName = "Transform"},
  trDstList = {sNodeName = "goDstList1", sComponentName = "Transform"},
  goSrcItem = {},
  goDstItem = {},
  svSrc = {
    sComponentName = "LoopScrollView"
  },
  svDst = {
    sComponentName = "LoopScrollView"
  }
}
FillMaterialCtrl._mapEventConfig = {}

function FillMaterialCtrl:Open()
  self._mapNode.blur:SetActive(true)
  self:InitData()
  self:PlayInAni()
  self:RefreshCost()
  self:RefreshGet()
end

function FillMaterialCtrl:InitData()
  self.tbCostItem = {}
  for nId, nCount in pairs(self.tbUseItem) do
    if 0 < nCount then
      table.insert(self.tbCostItem, {nId = nId, nCount = nCount})
    end
  end
  
  local function sort(a, b)
    local mapItemCfgDataA = ConfigTable.GetData_Item(a.nId)
    local mapItemCfgDataB = ConfigTable.GetData_Item(b.nId)
    if mapItemCfgDataA and mapItemCfgDataB and mapItemCfgDataA.Rarity ~= mapItemCfgDataB.Rarity then
      return mapItemCfgDataA.Rarity < mapItemCfgDataB.Rarity
    end
    return a.nId < b.nId
  end
  
  table.sort(self.tbCostItem, sort)
  self.nCostItemCount = #self.tbCostItem
  table.sort(self.tbNeedItem, sort)
  self.nNeedItemCount = #self.tbNeedItem
end

function FillMaterialCtrl:RefreshCost()
  for nInstanceId, objCtrl in pairs(self.tbCostGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbCostGridCtrl[nInstanceId] = nil
  end
  if self.nCostItemCount < 0 then
    return
  end
  self._mapNode.goSrcList[1]:SetActive(self.nCostItemCount < 5)
  self._mapNode.goSrcList[2]:SetActive(self.nCostItemCount >= 5)
  if self.nCostItemCount < 5 then
    delChildren(self._mapNode.trSrcList)
    for _, mapData in ipairs(self.tbCostItem) do
      local goItem = instantiate(self._mapNode.goSrcItem, self._mapNode.trSrcList)
      goItem:SetActive(true)
      local nInstanceID = goItem:GetInstanceID()
      if not self.tbCostGridCtrl[nInstanceID] then
        self.tbCostGridCtrl[nInstanceID] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
      end
      self.tbCostGridCtrl[nInstanceID]:SetItem(mapData.nId, nil, mapData.nCount)
      local btnGrid = goItem.transform:Find("btnGrid"):GetComponent("UIButton")
      btnGrid.onClick:RemoveAllListeners()
      
      local function cbSelect()
        UTILS.ClickItemGridWithTips(mapData.nId, btnGrid.transform, false, true, false)
      end
      
      btnGrid.onClick:AddListener(cbSelect)
    end
  else
    self._mapNode.svSrc:Init(self.nCostItemCount, self, self.OnGridRefresh_Cost, self.OnGridBtnClick_Cost)
  end
end

function FillMaterialCtrl:OnGridRefresh_Cost(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbCostItem[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbCostGridCtrl[nInstanceID] then
    self.tbCostGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbCostGridCtrl[nInstanceID]:SetItem(mapData.nId, nil, mapData.nCount)
end

function FillMaterialCtrl:OnGridBtnClick_Cost(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbCostItem[nIndex]
  local rtItem = goGrid.transform:Find("btnGrid")
  self._mapNode.svSrc:SetScrollGridPos(gridIndex, 0.1, 1)
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, 0.1, function()
    EventManager.Hit(EventId.BlockInput, false)
    UTILS.ClickItemGridWithTips(mapItem.nId, rtItem, true, true, false)
  end, true, true, true)
end

function FillMaterialCtrl:RefreshGet()
  for nInstanceId, objCtrl in pairs(self.tbGetGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGetGridCtrl[nInstanceId] = nil
  end
  if self.nNeedItemCount < 0 then
    return
  end
  self._mapNode.goDstList[1]:SetActive(self.nNeedItemCount < 6)
  self._mapNode.goDstList[2]:SetActive(self.nNeedItemCount >= 6)
  if self.nNeedItemCount < 6 then
    delChildren(self._mapNode.trDstList)
    for _, mapData in ipairs(self.tbNeedItem) do
      local goItem = instantiate(self._mapNode.goDstItem, self._mapNode.trDstList)
      goItem:SetActive(true)
      local nInstanceID = goItem:GetInstanceID()
      if not self.tbCostGridCtrl[nInstanceID] then
        self.tbCostGridCtrl[nInstanceID] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateMatCtrl")
      end
      local nHasCount = PlayerData.Item:GetItemCountByID(mapData.nId)
      self.tbCostGridCtrl[nInstanceID]:SetMat(mapData.nId, mapData.nNeed - nHasCount, mapData.nCount - nHasCount)
      local btnGrid = goItem.transform:Find("btnGrid"):GetComponent("UIButton")
      btnGrid.onClick:RemoveAllListeners()
      
      local function cbSelect()
        UTILS.ClickItemGridWithTips(mapData.nId, btnGrid.transform, false, true, false)
      end
      
      btnGrid.onClick:AddListener(cbSelect)
    end
  else
    self._mapNode.svDst:Init(self.nNeedItemCount, self, self.OnGridRefresh_Get, self.OnGridBtnClick_Get)
  end
end

function FillMaterialCtrl:OnGridRefresh_Get(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbNeedItem[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbCostGridCtrl[nInstanceID] then
    self.tbCostGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateMatCtrl")
  end
  self.tbCostGridCtrl[nInstanceID]:SetMat(mapData.nId, mapData.nNeed, mapData.nCount)
end

function FillMaterialCtrl:OnGridBtnClick_Get(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbNeedItem[nIndex]
  local rtItem = goGrid.transform:Find("btnGrid")
  UTILS.ClickItemGridWithTips(mapItem.nId, rtItem, true, true, false)
end

function FillMaterialCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FillMaterialCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function FillMaterialCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.FillMaterial)
end

function FillMaterialCtrl:Awake()
  self._mapNode.window:SetActive(false)
  self.tbCostGridCtrl = {}
  self.tbGetGridCtrl = {}
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbFillStep = tbParam[1]
    self.tbUseItem = tbParam[2]
    self.tbNeedItem = tbParam[3]
  end
end

function FillMaterialCtrl:OnEnable()
  self:Open()
end

function FillMaterialCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbCostGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbCostGridCtrl[nInstanceId] = nil
  end
  self.tbCostGridCtrl = {}
  for nInstanceId, objCtrl in pairs(self.tbGetGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGetGridCtrl[nInstanceId] = nil
  end
  self.tbGetGridCtrl = {}
end

function FillMaterialCtrl:OnDestroy()
end

function FillMaterialCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function FillMaterialCtrl:OnBtnClick_Confirm()
  local function callback()
    self:PlayOutAni()
  end
  
  PlayerData.Item:SendItemGrowthReq(self.tbFillStep, callback)
end

return FillMaterialCtrl
