local TrinketPlanEditView, Super = NewClass("TrinketPlanEditView", TrinketEditViewBase)
TrinketPlanEditView.uiResCls = UI_Team_Panel_Edit_SuitResource

function TrinketPlanEditView:ctor(suitPlanId)
  Super.ctor(self)
  self.suitPlanId = suitPlanId
end

function TrinketPlanEditView:OnBuildView()
  Super.OnBuildView(self)
  self.trinketChoosenComp = self:AddViewComponent(self.ui.UI_Team_Item_Suit_Bookmark, UICompTrinketChoiseForSuitPlan)
  self.trinketChoosenComp:SetDelegate(self)
end

function TrinketPlanEditView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnEditTrinketPlanPartTypeChanged, self._OnEditTrinketPlanPartTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnEditTrinketChoosenChanged, self._OnEditTrinketChoosenChanged, self)
  self:RegisterLocalNotify(NotifyId.OnSuitPlanUnequipedTrinket, self._OnSuitPlanUnequipedTrinket, self)
  self:RegisterLocalNotify(NotifyId.OnSuitPlanEquipedTrinket, self._OnSuitPlanEquipedTrinket, self)
  self:RegisterLocalNotify(NotifyId.OnSuitPlanTakeoffAllTrinkets, self._RefreshEditView, self)
  self:RegisterLocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdate, self._OnAwakerTrinketSuitPlanUpdate, self)
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketsDeleted, self._OnTrinketsDeleted, self)
end

function TrinketPlanEditView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_Remove, System.fn(self, self._OnClickBtnTakeoffAll))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Redact_Time, System.fn(self, self._OnClickRedactPlanName))
end

function TrinketPlanEditView:OnEnterView()
  EditTrinketSuitPlanModel.Instance:ResetFilters()
  EditTrinketSuitPlanModel.Instance:ResetTrinketSuitPlanEditedData(self.suitPlanId)
  self:_CloseItemDetailTips()
  Super.OnEnterView(self)
  self:_RefreshEditView(true)
end

function TrinketPlanEditView:_RefreshEditView(reloadData)
  Super._RefreshEditView(self, reloadData)
  self.ui.Group_Awaker:SetActive(false)
  self:_RefreshSuitName()
  self:_RefreshBtnTakeoffAll()
end

function TrinketPlanEditView:_RefreshSuitName()
  self.ui.Group_Name:SetActive(0 ~= self.suitPlanId)
  self:SetText(self.ui.Text_Name, AwakerTrinketExtModel.Instance:GetTrinketPlanName(self.suitPlanId))
end

function TrinketPlanEditView:_OnEditTrinketPlanPartTypeChanged(partType)
  self:_RefreshEditView(true)
  self:_CloseItemDetailTips()
  local uid = self:_GetCurChoosenTrinketUid()
  if 0 ~= uid then
    self:_ShowItemDetailTips(uid)
  end
end

function TrinketPlanEditView:_OnAwakerTrinketSuitPlanUpdate(planId)
  if 0 == self.suitPlanId then
    self.suitPlanId = planId
    EditTrinketSuitPlanModel.Instance:SetPlanId(planId)
  end
  if planId ~= self.suitPlanId then
    return
  end
  self:_RefreshSuitName()
  Alert.Show(10805)
  self:Close()
end

function TrinketPlanEditView:_OnEditTrinketChoosenChanged(uid)
  self:_RefreshEditView(false)
  self:_ShowItemDetailTips(uid)
end

function TrinketPlanEditView:_OnSuitPlanUnequipedTrinket()
  self:_RefreshEditView(false)
end

function TrinketPlanEditView:_OnSuitPlanEquipedTrinket()
  self:_RefreshEditView(false)
end

function TrinketPlanEditView:_OnTrinketUpdategraded()
  self:_RefreshEditView(false)
end

function TrinketPlanEditView:_RefreshBtnTakeoffAll()
  if not EditTrinketSuitPlanModel.Instance:IsEquipAnyTrinkets() then
    self.ui.Btn_Remove:SetActive(false)
    return
  end
  self.ui.Btn_Remove:SetActive(true)
end

function TrinketPlanEditView:_OnClickBtnTakeoffAll()
  Alert.Show(10640, nil, function()
    TrinketPlanEditController.Instance:TakeOffAllTrinkets()
  end)
end

function TrinketPlanEditView:_OnClickRedactPlanName()
  local curPlanId = self.suitPlanId
  local curPlanName = AwakerTrinketExtModel.Instance:GetTrinketPlanName(curPlanId)
  local viewData = {
    suitPlanId = curPlanId,
    suitPlanName = curPlanName,
    trinkets = self:_GetTrinkets()
  }
  AwakerTrinketController.Instance:OpenChangeTrinketSuitPlanNameView(viewData)
end

function TrinketPlanEditView:_OnBagItemDataChanged(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    return
  end
  if ItemDataUtils.GetItemType(itemData.tid) ~= CommonDefine.ItemType.Trinket then
    return
  end
  self:_RefreshEditView(false)
end

function TrinketPlanEditView:_OnTrinketsDeleted(uids)
  EditTrinketSuitPlanModel.Instance:DeleteTrinketFromTrinketsList(uids)
  if 0 ~= self.suitPlanId and not AwakerTrinketExtModel.Instance:GetTrinketPlanData(self.suitPlanId) then
    self.suitPlanId = 0
  end
  self:_RefreshEditView(true)
end

function TrinketPlanEditView:OnClose()
  if EditTrinketSuitPlanModel.Instance:NeedSavePlan() then
    Alert.Show(20207, nil, function()
      Super.OnClose(self)
    end)
  else
    Super.OnClose(self)
  end
end

function TrinketPlanEditView:_OnClickBtnEquip()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  TrinketPlanEditController.Instance:ReqEquipTrinket(self:_GetCurChoosenTrinketUid())
end

function TrinketPlanEditView:_OnClickBtnSaved()
  local suitPlanId = EditTrinketSuitPlanModel.Instance:GetPlanId()
  local suitPlanName = AwakerTrinketExtModel.Instance:GetTrinketPlanName(suitPlanId)
  if 0 == suitPlanId then
    AwakerTrinketController.Instance:OpenTrinketSuitPlanView({
      suitPlanId = suitPlanId,
      suitPlanName = suitPlanName,
      trinkets = self:_GetTrinkets()
    })
  else
    AwakerTrinketController.Instance:UpdateAwakerTrinketSuitPlan(suitPlanId, suitPlanName, self:_GetTrinkets())
  end
end

function TrinketPlanEditView:OnTrinketFilterChanged()
  self:_RefreshEditView(false)
end

function TrinketPlanEditView:_GetTrinkets()
  do return EditTrinketSuitPlanModel.Instance.GetCurTrinkets end
  return EditTrinketSuitPlanModel.Instance.GetCurTrinkets, EditTrinketSuitPlanModel.Instance
end

function TrinketPlanEditView:_GetComparedTrinkets()
  return
end

function TrinketPlanEditView:_GetCurPartType()
  do return EditTrinketSuitPlanModel.Instance.GetCurEditingPartType end
  return EditTrinketSuitPlanModel.Instance.GetCurEditingPartType, EditTrinketSuitPlanModel.Instance
end

function TrinketPlanEditView:OnClickTrinketPartType(partType)
  EditTrinketSuitPlanModel.Instance:SetCurEditingPartType(partType)
end

function TrinketPlanEditView:_GetCurEquipTrinketUid()
  local curPartType = self:_GetCurPartType()
  do return EditTrinketSuitPlanModel.Instance.GetEditTrinketUidOnPart, EditTrinketSuitPlanModel.Instance end
  return EditTrinketSuitPlanModel.Instance.GetEditTrinketUidOnPart, EditTrinketSuitPlanModel.Instance, curPartType
end

function TrinketEditViewBase:_GetCurChoosenTrinketUid()
  do return EditTrinketSuitPlanModel.Instance.GetCurEditingChoosingTrinketUid end
  return EditTrinketSuitPlanModel.Instance.GetCurEditingChoosingTrinketUid, EditTrinketSuitPlanModel.Instance
end

return TrinketPlanEditView
