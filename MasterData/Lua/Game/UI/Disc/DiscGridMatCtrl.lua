local DiscGridMatCtrl = class("DiscGridMatCtrl", BaseCtrl)
DiscGridMatCtrl._mapNodeConfig = {
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  ctrlMat = {
    sNodeName = "tc_mat_grid_01",
    sCtrlName = "Game.UI.TemplateEx.TemplateMatGridCtrl"
  }
}
DiscGridMatCtrl._mapEventConfig = {}

function DiscGridMatCtrl:Refresh(mapData)
  self.mapData = mapData
  self._mapNode.ctrlMat:RerfeshGrid(mapData)
end

function DiscGridMatCtrl:SetCount(nCount)
  self._mapNode.ctrlMat:SetGridCount(nCount)
end

function DiscGridMatCtrl:SetSelect(bSelect)
  self._mapNode.ctrlMat:SetSelect(bSelect)
end

function DiscGridMatCtrl:SetLock(bLock)
  self._mapNode.ctrlMat:SetLock(bLock)
end

function DiscGridMatCtrl:AddMat(btn)
  if btn.Operate_Type == 0 then
    local mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
    local nMaxStar = mapDisc.nMaxStar - mapDisc.nStar
    local nHasStar = 0
    for _, _ in pairs(self._panel.tbMat) do
      nHasStar = nHasStar + 1
    end
    if nMaxStar <= nHasStar then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("OUTFIT_15"))
      return
    end
    local nAddIndex = PlayerData.Disc:GetIndexOfNewBreakLimitMat(self._panel.tbMat)
    if nAddIndex == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("OUTFIT_16"))
      return
    end
    self.mapData.nAddIndex = nAddIndex
    self.mapData.nCost = 1
    self._panel:ChangeMatList(self.mapData)
    EventManager.Hit("DiscChangeSelectedMat", true)
    self:SetCount(self.mapData.nCost)
  elseif btn.Operate_Type == 3 then
    return
  end
end

function DiscGridMatCtrl:ReduceMat(btn)
  if btn.Operate_Type == 0 then
    self.mapData.nCost = 0
    self._panel:ChangeMatList(self.mapData, true)
    EventManager.Hit("DiscChangeSelectedMat", true)
    self:SetCount(self.mapData.nCost)
  elseif btn.Operate_Type == 3 then
    return
  end
end

function DiscGridMatCtrl:Awake()
end

function DiscGridMatCtrl:OnEnable()
end

function DiscGridMatCtrl:OnDisable()
end

function DiscGridMatCtrl:OnDestroy()
end

function DiscGridMatCtrl:OnBtnClick_Add(btn)
  if not self._panel.tbMat[self.mapData.nIndex] then
    self:AddMat(btn)
  else
    self:ReduceMat(btn)
  end
  EventManager.Hit("DiscGridClick", tonumber(self.gameObject.name) + 1)
  self:SetSelect(true)
end

function DiscGridMatCtrl:OnBtnClick_Reduce(btn)
  self:ReduceMat(btn)
  EventManager.Hit("DiscGridClick", tonumber(self.gameObject.name) + 1)
  self:SetSelect(true)
end

return DiscGridMatCtrl
