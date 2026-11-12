local DiscBreakLimitAllSucCtrl = class("DiscBreakLimitAllSucCtrl", BaseCtrl)
DiscBreakLimitAllSucCtrl._mapNodeConfig = {
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_BreakLimitAll_ConsumedMaterials"
  },
  btnGrid = {},
  goItemList1 = {sComponentName = "Transform"},
  goItemList2 = {},
  sv = {
    sComponentName = "LoopScrollView"
  },
  rtTitle = {sComponentName = "Transform"},
  rtItem = {sComponentName = "Transform"}
}
DiscBreakLimitAllSucCtrl._mapEventConfig = {}

function DiscBreakLimitAllSucCtrl:Open(nType)
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(nType, self.tbAni)
end

function DiscBreakLimitAllSucCtrl:RefreshContent()
  local ani1 = self._mapNode.rtTitle:GetComponent("Animator")
  local ani2 = self._mapNode.rtItem:GetComponent("Animator")
  self.tbAni = {}
  table.insert(self.tbAni, ani1)
  table.insert(self.tbAni, ani2)
  self.tbMat = self._panel.mapData.tbMat
  self.nAllCount = #self.tbMat
  if self.nAllCount <= 8 then
    self._mapNode.goItemList1.gameObject:SetActive(true)
    self._mapNode.goItemList2:SetActive(false)
    self:RefreshNormal()
  else
    self._mapNode.goItemList1.gameObject:SetActive(false)
    self._mapNode.goItemList2:SetActive(true)
    self:RefreshSV()
  end
end

function DiscBreakLimitAllSucCtrl:RefreshNormal()
  for _, v in ipairs(self.tbMat) do
    local nItemId = v.nTid
    local goItem = instantiate(self._mapNode.btnGrid, self._mapNode.goItemList1)
    local ctrlObj = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
    ctrlObj:SetItem(nItemId, nil, v.nCount)
    local btnGrid = goItem:GetComponent("UIButton")
    btnGrid.onClick:RemoveAllListeners()
    
    local function cbSelect()
      self:OnSelectItem(nItemId, btnGrid)
    end
    
    btnGrid.onClick:AddListener(cbSelect)
  end
end

function DiscBreakLimitAllSucCtrl:RefreshSV()
  self._mapNode.sv:Init(self.nAllCount, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function DiscBreakLimitAllSucCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbMat[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid.transform:Find("btnGrid").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetItem(mapItem.nTid, nil, mapItem.nCount)
end

function DiscBreakLimitAllSucCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self:OnSelectItem(self.tbMat[nIndex].nTid, goGrid.transform:Find("btnGrid"))
end

function DiscBreakLimitAllSucCtrl:OnSelectItem(itemId, btn)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, true, true, false)
end

function DiscBreakLimitAllSucCtrl:Awake()
  self.tbGridCtrl = {}
end

function DiscBreakLimitAllSucCtrl:OnEnable()
end

function DiscBreakLimitAllSucCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function DiscBreakLimitAllSucCtrl:OnDestroy()
end

return DiscBreakLimitAllSucCtrl
