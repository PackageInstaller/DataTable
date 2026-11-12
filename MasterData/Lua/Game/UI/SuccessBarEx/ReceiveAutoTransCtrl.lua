local ReceiveAutoTransCtrl = class("ReceiveAutoTransCtrl", BaseCtrl)
ReceiveAutoTransCtrl._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  SuccessBar = {
    sCtrlName = "Game.UI.SuccessBarEx.SuccessBarCtrl"
  },
  txtDstTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoTrans_DstItem"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoTrans_Tip"
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
  },
  ani1 = {sNodeName = "Src", sComponentName = "Animator"},
  ani2 = {sNodeName = "Arrow", sComponentName = "Animator"},
  ani3 = {sNodeName = "Dst", sComponentName = "Animator"}
}
ReceiveAutoTransCtrl._mapEventConfig = {}

function ReceiveAutoTransCtrl:Open()
  self:RefreshContent()
  self._mapNode.SuccessBar.gameObject:SetActive(true)
  self._mapNode.SuccessBar:PlayAni(AllEnum.SuccessBar.Purple, self.tbAni, 4)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.8)
end

function ReceiveAutoTransCtrl:RefreshContent()
  self.tbAni = {}
  self.tbSrc = self._panel.tbSrc
  self.tbDst = self._panel.tbDst
  local nSrcCount = #self.tbSrc
  self._mapNode.goSrcList[1]:SetActive(nSrcCount < 8)
  self._mapNode.goSrcList[2]:SetActive(8 <= nSrcCount)
  if nSrcCount < 8 then
    delChildren(self._mapNode.trSrcList)
    for _, mapItem in ipairs(self.tbSrc) do
      local goItem = instantiate(self._mapNode.goSrcItem, self._mapNode.trSrcList)
      goItem:SetActive(true)
      self:RefreshGrid(goItem, mapItem)
      local btnGrid = goItem.transform:Find("btnGrid"):GetComponent("UIButton")
      btnGrid.onClick:RemoveAllListeners()
      
      local function cbSelect()
        self:OnSelectItem(mapItem.Tid, btnGrid)
      end
      
      btnGrid.onClick:AddListener(cbSelect)
    end
  else
    self._mapNode.svSrc:Init(nSrcCount, self, self.OnGridRefreshSrc, self.OnGridBtnClickSrc)
  end
  table.insert(self.tbAni, self._mapNode.ani1)
  table.insert(self.tbAni, self._mapNode.ani2)
  local nDstCount = #self.tbDst
  self._mapNode.goDstList[1]:SetActive(nDstCount < 6)
  self._mapNode.goDstList[2]:SetActive(6 <= nDstCount)
  if nDstCount < 6 then
    delChildren(self._mapNode.trDstList)
    for _, mapItem in ipairs(self.tbDst) do
      local goItem = instantiate(self._mapNode.goDstItem, self._mapNode.trDstList)
      goItem:SetActive(true)
      self:RefreshGrid(goItem, mapItem)
      local btnGrid = goItem.transform:Find("btnGrid"):GetComponent("UIButton")
      btnGrid.onClick:RemoveAllListeners()
      
      local function cbSelect()
        self:OnSelectItem(mapItem.Tid, btnGrid)
      end
      
      btnGrid.onClick:AddListener(cbSelect)
    end
  else
    self._mapNode.svDst:Init(nDstCount, self, self.OnGridRefreshDst, self.OnGridBtnClickDst)
  end
  table.insert(self.tbAni, self._mapNode.ani3)
end

function ReceiveAutoTransCtrl:OnGridRefreshSrc(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbSrc[nIndex]
  self:RefreshGrid(goGrid, mapItem)
end

function ReceiveAutoTransCtrl:OnGridRefreshDst(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbDst[nIndex]
  self:RefreshGrid(goGrid, mapItem)
end

function ReceiveAutoTransCtrl:RefreshGrid(goGrid, mapItem)
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid.transform:Find("btnGrid").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local mapCfg = ConfigTable.GetData_Item(mapItem.Tid)
  if mapCfg then
    if mapCfg.Type == GameEnum.itemType.Char then
      self.tbGridCtrl[nInstanceId]:SetChar(mapItem.Tid, mapItem.Qty, nil, mapItem.rewardType)
    else
      self.tbGridCtrl[nInstanceId]:SetItem(mapItem.Tid, mapCfg.Rarity, mapItem.Qty, nil, nil, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.First, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.Three, true)
    end
  end
end

function ReceiveAutoTransCtrl:OnGridBtnClickSrc(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self:OnSelectItem(self.tbSrc[nIndex].Tid, goGrid.transform:Find("btnGrid"))
end

function ReceiveAutoTransCtrl:OnGridBtnClickDst(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self:OnSelectItem(self.tbDst[nIndex].Tid, goGrid.transform:Find("btnGrid"))
end

function ReceiveAutoTransCtrl:OnSelectItem(itemId, btn)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, false, true, false)
end

function ReceiveAutoTransCtrl:Awake()
  self.tbGridCtrl = {}
end

function ReceiveAutoTransCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function ReceiveAutoTransCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ReceiveAutoTransCtrl:OnDestroy()
end

function ReceiveAutoTransCtrl:OnBtnClick_Close(btn)
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.ReceiveAutoTrans)
end

return ReceiveAutoTransCtrl
