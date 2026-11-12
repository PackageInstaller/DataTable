local DiscMatListCtrl = class("DiscMatListCtrl", BaseCtrl)
DiscMatListCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  Empty = {},
  txtEmptyTitle = {sComponentName = "TMP_Text"}
}
DiscMatListCtrl._mapEventConfig = {
  DiscChangeGridMat = "OnEvent_ChangeMat",
  DiscGridClick = "OnEvent_GridClick"
}

function DiscMatListCtrl:InitData()
  if self.tbGridCtrl and next(self.tbGridCtrl) ~= nil then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
  end
  self.tbGridCtrl = {}
  self.mapSelect = nil
  self.nSelectIndex = nil
  self.nPos = nil
end

function DiscMatListCtrl:Open(bOpen)
  if self.gameObject.activeSelf and bOpen or not self.gameObject.activeSelf and not bOpen then
    return
  end
  self.gameObject:SetActive(bOpen)
  self:InitData()
  if not bOpen then
    EventManager.Hit("DiscCloseMatList")
    return
  end
  self:RefreshAllData_BreakLimit()
  self:RefreshListData_BreakLimit()
  self:Refresh()
end

function DiscMatListCtrl:Refresh()
  self._mapNode.Empty:SetActive(self.bEmpty)
  self._mapNode.sv.gameObject:SetActive(not self.bEmpty)
  if self.bEmpty then
    NovaAPI.SetTMPText(self._mapNode.txtEmptyTitle, ConfigTable.GetUIText("Outfit_BreakLimit_NoneMat"))
    return
  end
  self:RefreshList()
end

function DiscMatListCtrl:RefreshList()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.sv.gameObject:SetActive(self.nMatCount > 0)
  if self.nMatCount > 0 then
    self._mapNode.sv:Init(self.nMatCount, self, self.OnGridRefresh, nil, self.nPos ~= nil)
  end
end

function DiscMatListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbMatList[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Disc.DiscGridMatCtrl")
  end
  if self._panel.tbMat[nIndex] then
    self.tbMatList[nIndex].nCost = self._panel.tbMat[nIndex].nCost
    self.tbMatList[nIndex].nAddIndex = self._panel.tbMat[nIndex].nAddIndex
  else
    self.tbMatList[nIndex].nCost = 0
    self.tbMatList[nIndex].nAddIndex = 0
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
  self.tbGridCtrl[nInstanceID]:SetCount(mapData.nCost)
  self.tbGridCtrl[nInstanceID]:SetSelect(self.nSelectIndex == nIndex)
end

function DiscMatListCtrl:RefreshListWithPos()
  self.nPos = self._mapNode.sv:GetScrollPos()
  self:RefreshList()
end

function DiscMatListCtrl:SetSelectData()
  if self.mapSelect then
    for i, mapData in pairs(self.tbMatList) do
      if mapData.nIndex == self.mapSelect.nIndex then
        self.mapSelect = mapData
        self.nSelectIndex = i
        return
      end
    end
  end
end

function DiscMatListCtrl:RefreshAllData_BreakLimit()
  local nMatId, nMatCount = PlayerData.Disc:GetBreakLimitMat(self._panel.nId)
  self.nMatCount = nMatCount
  self.mapDiscMat = {nId = nMatId, nCount = nMatCount}
  self.bEmpty = self.nMatCount == 0
end

function DiscMatListCtrl:RefreshListData_BreakLimit()
  if self.nMatCount > 0 then
    self.tbMatList = {}
    for i = 1, self.mapDiscMat.nCount do
      local mapData = {
        nId = self.mapDiscMat.nId,
        nIndex = i,
        nType = GameEnum.itemStype.DiscLimitBreak,
        nCost = 0,
        nAddIndex = 0
      }
      table.insert(self.tbMatList, mapData)
    end
    self:SetSelectData()
  end
end

function DiscMatListCtrl:Awake()
end

function DiscMatListCtrl:OnEnable()
end

function DiscMatListCtrl:OnDisable()
  if self.tbGridCtrl then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self.tbGridCtrl = {}
  end
end

function DiscMatListCtrl:OnDestroy()
end

function DiscMatListCtrl:OnEvent_ChangeMat()
  if self.gameObject.activeSelf then
    self:RefreshListWithPos()
  end
end

function DiscMatListCtrl:OnEvent_GridClick(nIndex)
  if self.nSelectIndex then
    local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
    if goSelect then
      self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
    end
  end
  self.nSelectIndex = nIndex
  self.mapSelect = self.tbMatList[nIndex]
end

return DiscMatListCtrl
