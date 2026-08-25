local TrinketEditViewBase, Super = NewClass("TrinketEditViewBase", BaseView)

function TrinketEditViewBase:OnBuildView()
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, System.fn(self, self.OnClose))
  self.trinketsIconInfoComp = self:AddViewComponent(self.ui.Group_Parts, UICompEquipedTrinketsInfo, function(uid)
    do return self._IsContextAwakerBoundTrinket, self end
    return self._IsContextAwakerBoundTrinket, self, uid
  end)
  self.trinketsIconInfoComp:SetDelegate(self)
  self.trinketDetailsComp = self:AddViewComponent(self.ui.UI_Team_Item_Trinket_Detail, UICompTrinketDetails, self.ui.NodeEffectLink)
  self.trinketDetailTipsComp = self:AddViewComponent(self.ui.Image_Detail_1, UICompTrinketDetailTipsItem)
  self.trinketDetailContractTipsComp = self:AddViewComponent(self.ui.Image_Detail_2, UICompTrinketDetailTipsItem)
  self:SetButtonText(self.ui.Btn_Strengthen, LT.Text("RoleDetailsEquipDetails_Btn_LevelUp"))
  self:_BindDetailIconBoundLight()
end

function TrinketEditViewBase:_IsContextAwakerBoundTrinket(uid)
  local awakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  if not awakerTid or 0 == awakerTid then
    return false
  end
  return AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) == awakerTid
end

function TrinketEditViewBase:_BindDetailIconBoundLight()
  self._curDetailTrinketUid = Vue.ref(0)
  self._detailIconLightComp = self:AddViewComponentOnce(self.trinketDetailTipsComp.ui.Image_Icon, UICompTrinketIconMat)
  self.binder:BindToRaw(function(_, uid, _)
    local hasBound = 0 ~= uid and self:_IsContextAwakerBoundTrinket(uid)
    self._detailIconLightComp:EnableLight(hasBound, self:_GetCurPartType())
  end, function()
    return self._curDetailTrinketUid.value
  end)
end

function TrinketEditViewBase:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnCloseTrinketDetailsTips, self._CloseItemDetailTips, self)
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, self._OnItemDetailLockStates, self)
end

function TrinketEditViewBase:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_EmptyPosition, System.fn(self, self._CloseItemDetailTips))
  self.trinketDetailContractTipsSV = UIClickableScrollView(self.trinketDetailContractTipsComp.ui.ScrollView, System.fn(self, self._CloseItemDetailTips))
  self.trinketDetailTipsCompSV = UIClickableScrollView(self.trinketDetailTipsComp.ui.ScrollView, System.fn(self, self._CloseItemDetailTips))
  self:AddButtonClickListener(self.ui.Btn_Equip, System.fn(self, self._OnClickBtnEquip))
  self:AddButtonClickListener(self.ui.Btn_Strengthen, System.fn(self, self._OnClickBtnStrengthen))
  self:AddButtonClickListener(self.ui.Btn_Save, System.fn(self, self._OnClickBtnSaved))
end

function TrinketEditViewBase:OnExitView()
  if self.trinketDetailContractTipsSV then
    self.trinketDetailContractTipsSV:Dispose()
  end
  if self.trinketDetailTipsCompSV then
    self.trinketDetailTipsCompSV:Dispose()
  end
  Super.OnExitView(self)
end

function TrinketEditViewBase:OnClose()
  self.compCloseBtn:PlayCloseAnim()
  self:Close()
end

function TrinketEditViewBase:_ShowItemDetailTips(uid)
  local curEquipId = self:_GetCurEquipTrinketUid()
  self.trinketDetailContractTipsComp:SetItemUid(0)
  self.trinketDetailTipsComp:SetItemUid(uid)
  self._curDetailTrinketUid.value = uid
  if 0 == curEquipId then
    self.trinketDetailTipsComp:SetBeingEquiped(false)
    self.trinketDetailTipsComp:SetContrast(nil)
  elseif curEquipId == uid then
    self.trinketDetailTipsComp:SetBeingEquiped(true)
    self.trinketDetailTipsComp:SetContrast(nil)
  else
    self.trinketDetailTipsComp:SetBeingEquiped(false)
    self.trinketDetailTipsComp:SetContrast(nil)
    self.trinketDetailContractTipsComp:SetItemUid(curEquipId)
    self.trinketDetailContractTipsComp:SetBeingEquiped(true)
    self.trinketDetailContractTipsComp:SetContrast(nil)
  end
  self.ui.Image_Compared:SetActive(true)
  self.ui.Btn_EmptyPosition:SetActive(true)
end

function TrinketEditViewBase:_CloseItemDetailTips()
  self.trinketDetailTipsComp:SetItemUid(0)
  self.trinketDetailContractTipsComp:SetItemUid(0)
  self._curDetailTrinketUid.value = 0
  self.ui.Btn_EmptyPosition:SetActive(false)
  self.ui.Image_Compared:SetActive(false)
end

function TrinketEditViewBase:_OnItemDetailLockStates()
  self:RefreshTrinketChoosenView()
end

function TrinketEditViewBase:_IsChoosenTrinketBoundOnly()
  return false
end

function TrinketEditViewBase:_RefreshBtnEquip()
  local curSelectUid = self:_GetCurChoosenTrinketUid()
  local boundOnly = self:_IsChoosenTrinketBoundOnly()
  if 0 == curSelectUid or boundOnly then
    self.ui.Btn_Equip:SetActive(false)
    return
  end
  self.ui.Btn_Equip:SetActive(true)
  local curEquipId = self:_GetCurEquipTrinketUid()
  if 0 == curEquipId then
    self:SetButtonText(self.ui.Btn_Equip, LT.Text("RoleDetailsEquipDetails_Btn_PutOn"))
  elseif curEquipId == curSelectUid then
    self:SetButtonText(self.ui.Btn_Equip, LT.Text("RoleDetailsEquipDetails_Btn_Remove"))
  else
    self:SetButtonText(self.ui.Btn_Equip, LT.Text("RoleDetailsEquipDetails_Btn_Replace"))
  end
end

function TrinketEditViewBase:_OnClickBtnStrengthen()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.TrinketLevelUp, 0)
    return
  end
  local curSelectUid = self:_GetCurChoosenTrinketUid()
  UIManager.Instance:Reopen(Urls.TrinketStrengthenPanel, nil, curSelectUid)
end

function TrinketEditViewBase:_RefreshBtnStrengthen()
  local curSelectUid = self:_GetCurChoosenTrinketUid()
  if 0 == curSelectUid then
    self.ui.Btn_Strengthen:SetActive(false)
    return
  end
  self.ui.Btn_Strengthen:SetActive(true)
  local btnState = CommonDefine.BtnType.High
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
  if not unlocked then
    btnState = CommonDefine.BtnType.Unclickable
  end
  self:SetButtonState(self.ui.Btn_Strengthen, btnState)
end

function TrinketEditViewBase:RefreshByTrinkets(trinkets)
  self.trinketsIconInfoComp:SetTrinkets(trinkets)
  local compareTrinkets = self:_GetComparedTrinkets()
  self.trinketDetailsComp:RefreshDetails(trinkets, compareTrinkets)
end

function TrinketEditViewBase:SetSelectPart(partType)
  self.trinketsIconInfoComp:SelectPart(partType)
end

function TrinketEditViewBase:SetTrinketChoosenViewType(chooseType)
  self.trinketChoosenComp:RefreshView()
end

function TrinketEditViewBase:ReloadTrinketChoosenView()
  self.trinketChoosenComp:RefreshView()
end

function TrinketEditViewBase:RefreshTrinketChoosenView()
  self.trinketChoosenComp:RefreshTableview()
end

function TrinketEditViewBase:_RefreshEditView(reloadData)
  local trinkets = self:_GetTrinkets()
  local curPartType = self:_GetCurPartType()
  self:RefreshByTrinkets(trinkets)
  self:SetSelectPart(curPartType)
  self:_RefreshBtnEquip()
  self:_RefreshBtnStrengthen()
  if reloadData then
    self:ReloadTrinketChoosenView()
  else
    self:RefreshTrinketChoosenView()
  end
end

function TrinketEditViewBase:OnClickTrinketPartType(partType)
end

function TrinketEditViewBase:_GetTrinkets()
  return
end

function TrinketEditViewBase:_GetComparedTrinkets()
  return
end

function TrinketEditViewBase:_GetCurPartType()
  return 1
end

function TrinketEditViewBase:_GetCurChoosenTrinketUid()
  return 0
end

function TrinketEditViewBase:_GetCurEquipTrinketUid()
  return 0
end

function TrinketEditViewBase:_OnClickBtnEquip()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
end

function TrinketEditViewBase:_OnClickBtnSaved()
end

return TrinketEditViewBase
