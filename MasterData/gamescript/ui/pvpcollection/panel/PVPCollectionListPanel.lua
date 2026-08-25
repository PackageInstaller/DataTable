local PVPCollectionFilterType = CommonDefine.PVPCollectionFilterType
local PVPCollectionListPanel, Super = System.NewClass("PVPCollectionListPanel", UIBasePanel)
PVPCollectionListPanel.uiResCls = UI_Pvp_Panel_Collection_ListResource

function PVPCollectionListPanel:ctor(filterType)
  Super.ctor(self)
  self.enterFilterType = filterType
end

function PVPCollectionListPanel:OnBind(binder)
  self.binder = binder
  PVPCollectionDataUtils.ReqServerData()
  CommentController.Instance:ReqOnOpen()
  self.model = binder:createModel(PVPCollectionListPanelModel, self.enterFilterType)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close)))
  binder:BindToText(self.ui.Text_Label, System.fn(self, self._GetFilterTypeLabelText))
  binder:BindToVisible(self.ui.Group_Null_Black, System.fn(self, self._IsCollectionEmpty))
  self:_BindTogglesNew(binder)
  self:_BindScrollView(binder)
  self:_BindBpState(binder)
end

function PVPCollectionListPanel:_BindTogglesNew(binder)
  local toggleObjs = {
    self.ui.Btn_All,
    self.ui.Btn_Filter_1,
    self.ui.Btn_Filter_2,
    self.ui.Btn_Filter_3,
    self.ui.Btn_Filter_4,
    self.ui.Btn_Filter_5,
    self.ui.Btn_Filter_Weapon,
    self.ui.Btn_Filter_KeeperSkill
  }
  local filterTypeList = self.model:GetFilterList()
  for i = 1, #toggleObjs do
    local toggleObj = toggleObjs[i]
    local filterType = filterTypeList[i]
    if toggleObj then
      binder:SetActive(toggleObj, nil ~= filterType)
      self:_BindSingleToggleFunc(binder, toggleObj, filterType)
    end
  end
end

function PVPCollectionListPanel:_BindSingleToggleFunc(binder, obj, filterType)
  if not filterType then
    return
  end
  binder:BindToZ1Toggle(obj, nil, function(isOn)
    if isOn then
      self.model:SetFilterType(filterType)
    end
  end, function()
    return self.model.filterType == filterType
  end, nil, function()
  end, function()
  end)
end

function PVPCollectionListPanel:_BindScrollView(binder)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetCollectionList), System.fn(self, self._OnUpdateCollectionListItem))
end

function PVPCollectionListPanel:_GetFilterTypeLabelText()
  if not self.model.filterType then
    return
  end
  local keyMap = {
    [PVPCollectionFilterType.All] = "PVPCollectFilterTypeName_All",
    [PVPCollectionFilterType.Chaos] = "PVPCollectFilterTypeName_Chaos",
    [PVPCollectionFilterType.Blood] = "PVPCollectFilterTypeName_Blood",
    [PVPCollectionFilterType.Dimension] = "PVPCollectFilterTypeName_Dimension",
    [PVPCollectionFilterType.Ocean] = "PVPCollectFilterTypeName_Ocean",
    [PVPCollectionFilterType.Weapon] = "PVPCollectFilterTypeName_Weapon",
    [PVPCollectionFilterType.KeeperSkill] = "PVPCollectFilterTypeName_KeeperSkill"
  }
  local key = keyMap[self.model.filterType]
  if not key then
    local positionConfig = PVPPositionCfgUtils.GetCfg(self.model.filterType)
    if positionConfig and positionConfig.Name then
      key = positionConfig.Name
    end
  end
  do return LT.Text end
  return LT.Text, key
end

function PVPCollectionListPanel:_GetCollectionList()
  return self.model.showList
end

function PVPCollectionListPanel:_IsCollectionEmpty()
  return not self.model.showList or #self.model.showList <= 0
end

function PVPCollectionListPanel:_OnUpdateCollectionListItem(childBinder, go, index)
  local collectTid = self.model.showList[index]
  
  local function _clickCallback()
    PvpCollectionModel.Instance:SetSelectCollectionTid(collectTid)
    local initData = {
      showList = self.model.showList,
      targetIndex = index
    }
    PvpCollectionController.Instance:OpenPvpCollectionMainView(initData)
  end
  
  childBinder:BindComponent(PVPCollectionPortraitItem(go, collectTid, _clickCallback))
end

function PVPCollectionListPanel:_BindBpState(binder)
  binder:BindToVisible(self.ui.TemporaryUnLock, function()
    return not PVPCollectionDataUtils.IsOwnedAll()
  end)
  binder:BindToText(self.ui.Txt_TemporaryUnLock, function()
    if BattlePassDataUtils.IsCore() then
      do return LT.Text end
      return LT.Text, "PVPBPUnLockTxt"
    else
      do return LT.Text end
      return LT.Text, "PVPBPLockTxt"
    end
  end)
  binder:BindButtonClick(self.ui.TemporaryUnLock, function()
    BattlePassDataUtils.OpenBuyCore()
  end)
end

function PVPCollectionListPanel:Close()
  Super.Close(self)
end

return PVPCollectionListPanel
