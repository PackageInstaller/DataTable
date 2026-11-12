local DepotSortCtrl = class("DepotSortCtrl", BaseCtrl)
DepotSortCtrl._mapNodeConfig = {
  btnRarity = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rarity"
  },
  ctrlBtnRarity = {
    sNodeName = "btnRarity",
    sCtrlName = "Game.UI.TemplateEx.TemplateSortBtnCtrl"
  },
  btnLevel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Level"
  },
  ctrlBtnLevel = {
    sNodeName = "btnLevel",
    sCtrlName = "Game.UI.TemplateEx.TemplateSortBtnCtrl"
  },
  btnFilter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Filter"
  },
  imgFilterChoose = {}
}
DepotSortCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "RefreshByFilter"
}

function DepotSortCtrl:RefreshSort(nTog)
  local bReset = self.nCurTog ~= nTog
  self.nCurTog = nTog
  self.tbFilterCfg = {}
  if bReset then
  end
  self:RefreshSortState(bReset)
end

function DepotSortCtrl:RefreshSortState(bReset)
  self._mapNode.btnRarity.gameObject:SetActive(false)
  self._mapNode.btnLevel.gameObject:SetActive(false)
  self._mapNode.btnFilter.gameObject:SetActive(false)
  local isDirty = false
  self._mapNode.imgFilterChoose:SetActive(isDirty)
end

function DepotSortCtrl:RefreshSortText()
  self._mapNode.ctrlBtnRarity:SetText("Depot_SortByRare")
  self._mapNode.ctrlBtnLevel:SetText("Depot_SortByLevel")
end

function DepotSortCtrl:GetSortCfg()
  return self.mapSortCfg
end

function DepotSortCtrl:GetFilterCfg()
  return self.tbFilterCfg
end

function DepotSortCtrl:Awake()
  self.tbFilterCfg = nil
  self.mapSortCfg = nil
  self:RefreshSortText()
end

function DepotSortCtrl:OnEnable()
end

function DepotSortCtrl:OnDisable()
end

function DepotSortCtrl:OnDestroy()
  self.tbFilterCfg = nil
  self.mapSortCfg = nil
end

function DepotSortCtrl:OnBtnClick_Rarity(btn)
  local bSwitch = self.mapSortCfg.nSortType == AllEnum.SortType.Level
  if bSwitch then
    self.mapSortCfg.nSortType = AllEnum.SortType.Rarity
    self.mapSortCfg.bOrder = true
    self._mapNode.ctrlBtnLevel:Refresh(false)
  else
    self.mapSortCfg.bOrder = not self.mapSortCfg.bOrder
  end
  self._mapNode.ctrlBtnRarity:Refresh(self.mapSortCfg.nSortType == AllEnum.SortType.Rarity, self.mapSortCfg.bOrder)
  EventManager.Hit("DepotChangeSort")
end

function DepotSortCtrl:OnBtnClick_Level(btn)
  local bSwitch = self.mapSortCfg.nSortType == AllEnum.SortType.Rarity
  if bSwitch then
    self.mapSortCfg.nSortType = AllEnum.SortType.Level
    self.mapSortCfg.bOrder = true
    self._mapNode.ctrlBtnRarity:Refresh(false)
  else
    self.mapSortCfg.bOrder = not self.mapSortCfg.bOrder
  end
  self._mapNode.ctrlBtnLevel:Refresh(self.mapSortCfg.nSortType == AllEnum.SortType.Level, self.mapSortCfg.bOrder)
  EventManager.Hit("DepotChangeSort")
end

function DepotSortCtrl:OnBtnClick_Filter()
  local tbOption = {
    AllEnum.ChooseOption.Equip_Rarity,
    AllEnum.ChooseOption.Equip_Type,
    AllEnum.ChooseOption.Equip_PowerStyle,
    AllEnum.ChooseOption.Equip_TacticalStyle,
    AllEnum.ChooseOption.Equip_AffiliatedForces
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, tbOption)
end

function DepotSortCtrl:RefreshByFilter()
  local isDirty = false
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  EventManager.Hit("DepotChangeSort")
end

return DepotSortCtrl
