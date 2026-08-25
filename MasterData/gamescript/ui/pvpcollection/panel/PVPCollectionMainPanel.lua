local PVPCollectionType = CommonDefine.PVPCollectionType
local PVPCollectionDetailTab = CommonDefine.PVPCollectionDetailTab
local PVPCollectionMainPanel, Super = System.NewClass("PVPCollectionMainPanel", UIBasePanel)
PVPCollectionMainPanel.uiResCls = UI_Pvp_Panel_Collection_MainResource

function PVPCollectionMainPanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function PVPCollectionMainPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(PVPCollectionMainPanelModel, self.data)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back2, System.fn(self, self.Close)))
  self:_BindChildPanelShow(binder)
  self:_BindToggles(binder)
  self:_BindScrollView(binder)
  self:_BindAwakerCollectionName(binder)
  self:_BindCollectionPortrait(binder)
  self:_BindBpState(binder)
end

function PVPCollectionMainPanel:_BindCollectionPortrait(binder)
  self:_BindAwakerCollectionPortrait(binder)
  self:_BindWeaponCollectionPortrait(binder)
  self:_BindKeeperSkillCollectionPortrait(binder)
end

function PVPCollectionMainPanel:_BindBpState(binder)
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

function PVPCollectionMainPanel:_BindChildPanelShow(binder)
  local t = {
    [PVPCollectionDetailTab.Detail] = PVPCollectionDataUtils.OpenCollectionDetailPanel
  }
  binder:BindToRaw(function(_, nTab)
    if not nTab then
      return
    end
    local openFunc = t[nTab]
    if nTab and openFunc then
      openFunc(System.fn(self, self._GetSelectedCollection))
    end
  end, function()
    return self.model.tab
  end)
end

function PVPCollectionMainPanel:_BindAwakerCollectionPortrait(binder)
  local collectionType = PVPCollectionType.Awaker
  binder:BindToVisible(self.ui.Image_Awaker, System.bind(self._IsTargetCollectionType, self, collectionType))
  binder:BindToRaw(function(childBinder, nVal)
    local awakerTid, resNum
    if nVal then
      awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(nVal)
      resNum = AwakerDataUtils.GetAwakerResNum(awakerTid)
    end
    awakerTid = awakerTid or 0
    local portraitAlign = CommonDefine.PortraitAlign.HorizontalCenter
    childBinder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, awakerTid, resNum, nil, portraitAlign))
  end, function()
    return self.model.selectTid
  end)
end

function PVPCollectionMainPanel:_BindWeaponCollectionPortrait(binder)
  local collectionType = PVPCollectionType.Weapon
  binder:BindToVisible(self.ui.Image_Weapon, System.bind(self._IsTargetCollectionType, self, collectionType))
  binder:BindToVisible(self.ui.Text_C_Weapon_Name, System.bind(self._IsTargetCollectionType, self, collectionType))
  binder:BindToImage(self.ui.Image_Weapon_Large, System.fn(self, self._GetWeaponCollectionPortrait))
end

function PVPCollectionMainPanel:_BindKeeperSkillCollectionPortrait(binder)
  local collectionType = PVPCollectionType.KeeperSkill
  binder:BindToVisible(self.ui.Key_Order, System.bind(self._IsTargetCollectionType, self, collectionType))
  binder:BindToVisible(self.ui.Text_C_KeeperSkill_Name, System.bind(self._IsTargetCollectionType, self, collectionType))
  binder:BindToImage(self.ui.Image_Key, System.fn(self, self._GetKeeperSkillCollectionPortrait))
end

function PVPCollectionMainPanel:_BindAwakerCollectionName(binder)
  local collectionType = PVPCollectionType.Awaker
  binder:BindToVisible(self.ui.Text_C_Awaker_Name, System.bind(self._IsTargetCollectionType, self, collectionType))
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, System.fn(self, self._GetAwakerCollectionSchoolIcon))
end

function PVPCollectionMainPanel:_BindScrollView(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_Head_List, System.fn(self, self._GetCollectionList), System.fn(self, self._OnUpdateCollectionListItem))
  if self.data.targetIndex and self.data.targetIndex <= #self.model.showList then
    binder:CircularScrollTo(self.ui.ScrollView_Awaker_Head_List, self.data.targetIndex)
  end
end

function PVPCollectionMainPanel:_BindToggles(binder)
  self:_BindSingleToggleFunc(binder, self.ui.Grope_Container_1, PVPCollectionDetailTab.Detail)
  self:_BindSingleToggleFunc(binder, self.ui.Grope_Container_2, PVPCollectionDetailTab.Rank)
  self:_BindSingleToggleFunc(binder, self.ui.Grope_Container_3, PVPCollectionDetailTab.Comment)
  binder:SetActive(self.ui.Com_RedDot_1, false)
  binder:SetActive(self.ui.Com_RedDot_2, false)
  binder:SetActive(self.ui.Com_RedDot_3, false)
end

function PVPCollectionMainPanel:_BindSingleToggleFunc(binder, obj, tab)
  binder:BindToZ1Toggle(obj, nil, function(isOn)
    if isOn then
      self.model:SetTab(tab)
    end
  end, function()
    return self.model.tab == tab
  end, nil, function()
    return tab ~= PVPCollectionDetailTab.Detail
  end, function()
    Alert.ShowWithParams(10237, {""})
  end)
end

function PVPCollectionMainPanel:_IsTargetCollectionType(targetType)
  local collectTid = self.model.selectTid
  if not (targetType and collectTid) or 0 == collectTid then
    return
  end
  local collectionType = self.model:GetCollectionType(collectTid)
  return collectionType and collectionType == targetType
end

function PVPCollectionMainPanel:_GetWeaponCollectionPortrait()
  do return PVPCollectionDataUtils.GetWeaponCollectionPortrait end
  return PVPCollectionDataUtils.GetWeaponCollectionPortrait, self.model.selectTid
end

function PVPCollectionMainPanel:_GetKeeperSkillCollectionPortrait()
  do return PVPCollectionDataUtils.GetKeeperSkillDetailsImage end
  return PVPCollectionDataUtils.GetKeeperSkillDetailsImage, self.model.selectTid
end

function PVPCollectionMainPanel:_GetAwakerCollectionName()
  if not self:_IsTargetCollectionType(PVPCollectionType.Awaker) then
    return
  end
  do return self.model.GetCollectionName, self.model end
  return self.model.GetCollectionName, self.model, self.model.selectTid
end

function PVPCollectionMainPanel:_GetAwakerCollectionSchoolIcon()
  if not self:_IsTargetCollectionType(PVPCollectionType.Awaker) then
    return
  end
  local positionTid = PVPCollectionDataUtils.GetAwakerPosition(self.model.selectTid)
  local positionConfig = PVPCollectionDataUtils.GetPositionConfig(positionTid)
  return positionConfig and positionConfig.CollectDetailsPositionIcon
end

function PVPCollectionMainPanel:_GetCollectionList()
  return self.model.showList
end

function PVPCollectionMainPanel:_GetSelectedCollection()
  return self.model.selectTid
end

function PVPCollectionMainPanel:_OnUpdateCollectionListItem(childBinder, go, index)
  local collectTid = self.model.showList[index]
  
  local function _clickCallback()
    self.model:SetSelectTid(collectTid)
  end
  
  local function _IsSelectedFunc()
    return self.model.selectTid == collectTid
  end
  
  childBinder:BindComponent(PVPCollectionIconItem(go, collectTid, _clickCallback, _IsSelectedFunc))
end

function PVPCollectionMainPanel:Close()
  PVPCollectionDataUtils.CloseCollectionDetailPanel()
  Super.Close(self)
end

return PVPCollectionMainPanel
