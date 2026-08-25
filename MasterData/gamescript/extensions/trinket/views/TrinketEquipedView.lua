local TrinketChoosenType = CommonDefine.TrinketChoosenType
local TrinketEquipedView, Super = NewClass("TrinketEquipedView", TrinketEditViewBase)
TrinketEquipedView.uiResCls = UI_Team_Panel_Trinket_EquipResource

function TrinketEquipedView:ctor(data, awakerTeamDatas, teamModel, slot, trinkets)
  Super.ctor(self)
  self.awakerData = data
  self.teamModel = teamModel
  self.awakerTeamDatas = awakerTeamDatas
  self.teamSlot = slot
  self.inputTrinkets = trinkets
end

function TrinketEquipedView:OnBuildView()
  Super.OnBuildView(self)
  self.trinketChoosenComp = self:AddViewComponent(self.ui.UI_Team_Item_Suit_Bookmark, UICompTrinketChoosenList)
  self.trinketChoosenComp:SetDelegate(self)
end

function TrinketEquipedView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnTrinketChoosenTypeChanged, self._OnTrinketChoosenTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketChoosenPartTypeChanged, self._OnTrinketTrinketPartTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketChoosen, self._OnTrinketChoosen, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketEquiped, self._OnTrinketEquiped, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketUnequiped, self._OnTrinketUnequiped, self)
  self:RegisterLocalNotify(NotifyId.OnAwakerTakeoffAllTrinkets, self._OnAwakerTakeoffAllTrinkets, self)
  self:RegisterLocalNotify(NotifyId.OnAwakerEquipRecommendTrinket, self._OnAwakerEquipRecommendTrinket, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketPlansData, self._ReloadView, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketSuitPlanChoosen, self._OnTrinketSuitPlanChoosen, self)
  self:RegisterLocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdate, self._OnAwakerTrinketSuitPlanUpdate, self)
  self:RegisterLocalNotify(NotifyId.OnDeleteTrinketSuitPlan, self._ReloadView, self)
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterNotify(NotifyId.OnAwakerEquipedTrinketSuit, self._OnAwakerEquipedTrinketSuit, self)
  self:RegisterNotify(NotifyId.OnTrinketsDeleted, self._OnTrinketsDeleted, self)
  self:RegisterNotify(NotifyId.OnTrinketBoundDataChanged, self._OnTrinketBoundDataChanged, self)
end

function TrinketEquipedView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_Remove, System.fn(self, self._OnClickBtnTakeoffAll))
  self:AddButtonClickListener(self.ui.Btn_Recommend, System.fn(self, self._OnClickBtnRecommend))
  self:AddButtonClickListener(self.ui.Btn_New_SuitPlan, System.fn(self, self._OnClickAddNewSiutPlan))
  self:AddButtonClickListener(self.ui.Btn_Equipment_2, System.fn(self, self._OnClickEquipSiutPlan))
  self:AddButtonClickListener(self.ui.Btn_Add_SuitPlan, System.fn(self, self._OnClickAddNewSiutPlan))
  self:AddButtonClickListener(self.ui.Btn_Delete, System.fn(self, self._OnClickDeletePlan))
  self:AddButtonClickListener(self.ui.Btn_Edit, System.fn(self, self._OnClickEditPlan))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Redact_Time, System.fn(self, self._OnClickRedactPlanName))
end

function TrinketEquipedView:OnEnterView()
  Super.OnEnterView(self)
  AwakerTrinketController.Instance:ReqTrinketSuitPlans()
  AwakerTrinketExtModel.Instance:ResetFilters()
  AwakerTrinketExtModel.Instance:ResetByAwakerData(self.awakerData, self.awakerTeamDatas, self.teamModel, self.teamSlot, self.inputTrinkets)
  self:_RefreshAwaker()
  self:_CloseItemDetailTips()
  self:_RefreshView(true)
end

function TrinketEquipedView:_ReloadView()
  self:_RefreshView(true)
end

function TrinketEquipedView:_RefreshView(reloadData)
  local trinketChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
  local isSingle = trinketChoosenType == TrinketChoosenType.SingleTrinket
  if isSingle then
    self:_RefreshEditView(reloadData)
  else
    self:_RefreshSuitView(reloadData)
  end
end

function TrinketEquipedView:_RefreshEditView(reloadData)
  Super._RefreshEditView(self, reloadData)
  self.ui.Group_Name:SetActive(false)
  self.ui.Btn_Delete:SetActive(false)
  self.ui.Btn_Edit:SetActive(false)
  self:_RefreshBtnTakeoffAll()
  self:_RefreshBtnRecommend()
  self:_RefreshBtnSaveStatus()
end

function TrinketEquipedView:_RefreshBtnSaveStatus()
  local hasAnyTrinkets = AwakerTrinketExtModel.Instance:IsAwakerEquipAnyTrinkets()
  if not hasAnyTrinkets then
    self.ui.Btn_Save:SetActive(false)
    self.ui.Text_CurPlanName:SetActive(false)
    return
  end
  local curPlanId = AwakerTrinketExtModel.Instance:GetCurEquipingPlanId()
  if 0 ~= curPlanId then
    self.ui.Btn_Save:SetActive(false)
    self.ui.Text_CurPlanName:SetActive(true)
    self:SetText(self.ui.Text_CurPlanName, LT.Textf("CurrentTrinketSet", AwakerTrinketExtModel.Instance:GetTrinketPlanName(curPlanId)))
  else
    self.ui.Text_CurPlanName:SetActive(false)
    self.ui.Btn_Save:SetActive(true)
  end
end

function TrinketEquipedView:_RefreshSuitView(reloadData)
  self.ui.Btn_Remove:SetActive(false)
  self.ui.Btn_Recommend:SetActive(false)
  self.ui.Btn_Save:SetActive(false)
  self.ui.Text_CurPlanName:SetActive(false)
  local trinkets = self:_GetTrinkets()
  local curPartType = self:_GetCurPartType()
  self:SetSelectPart(curPartType)
  self:RefreshByTrinkets(trinkets)
  if reloadData then
    self:ReloadTrinketChoosenView()
  else
    self:RefreshTrinketChoosenView()
  end
  self:_RefreshSuitPlanBtnStatus()
end

function TrinketEquipedView:_AdjustDetailTipsPosition()
  local curChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
  if curChoosenType == TrinketChoosenType.SingleTrinket then
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Image_Detail_1.transform, 0, 0)
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Image_Detail_2.transform, 529, 0)
  else
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Image_Detail_1.transform, -205, 0)
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Image_Detail_2.transform, -735, 0)
  end
end

function TrinketEquipedView:_RefreshAwaker()
  local curAwakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  if not curAwakerTid or 0 == curAwakerTid then
    self.ui.Group_Awaker:SetActive(false)
    return
  end
  self.ui.Group_Awaker:SetActive(true)
  local awakerIconPath = AwakerDataUtils.GetLittleIcon(curAwakerTid)
  self:SetImage(self.ui.Icon_Awaker, awakerIconPath)
end

function TrinketEquipedView:_RefreshBtnTakeoffAll()
  local awakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid or table.next(AwakerDataUtils.GetMockAwakerMap()) then
    self.ui.Btn_Remove:SetActive(false)
    return
  end
  if not AwakerTrinketExtModel.Instance:IsAwakerEquipAnyRealTrinkets() then
    self.ui.Btn_Remove:SetActive(false)
    return
  end
  self.ui.Btn_Remove:SetActive(true)
end

function TrinketEquipedView:_RefreshBtnRecommend()
  local awakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  if 0 == awakerTid or table.next(AwakerDataUtils.GetMockAwakerMap()) then
    self.ui.Btn_Recommend:SetActive(false)
    return
  end
  self.ui.Btn_Recommend:SetActive(true)
end

function TrinketEquipedView:_RefreshSuitPlanBtnStatus()
  local curPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  local isChoosenPlan = 0 ~= curPlanId
  self.ui.Btn_Delete:SetActive(isChoosenPlan)
  self.ui.Btn_Edit:SetActive(isChoosenPlan)
  self.ui.Group_Name:SetActive(isChoosenPlan)
  self.ui.Btn_Equipment_2:SetActive(isChoosenPlan)
  if isChoosenPlan then
    self:_RefreshBtnEquipSiutPlan()
    self:SetText(self.ui.Text_Name, AwakerTrinketExtModel.Instance:GetTrinketPlanName(curPlanId))
  end
end

function TrinketEquipedView:_RefreshBtnEquipSiutPlan()
  local btnState = CommonDefine.BtnType.High
  if self:_CheckSuitPlanEquipedSame() then
    btnState = CommonDefine.BtnType.Unclickable
  end
  self:SetButtonState(self.ui.Btn_Equipment_2, btnState)
end

function TrinketEquipedView:_OnClickRedactPlanName()
  local curPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  local curPlanName = AwakerTrinketExtModel.Instance:GetTrinketPlanName(curPlanId)
  local trinkets = AwakerTrinketExtModel.Instance:GetPlanTrinkets(curPlanId)
  local viewData = {
    suitPlanId = curPlanId,
    suitPlanName = curPlanName,
    trinkets = trinkets
  }
  AwakerTrinketController.Instance:OpenChangeTrinketSuitPlanNameView(viewData)
end

function TrinketEquipedView:_CheckSuitPlanEquipedSame()
  local curAwakerTrinkets = AwakerTrinketExtModel.Instance:GetCurAwakerTrinketsUidList()
  local curEquipPlanId = AwakerTrinketExtModel.Instance:GetPlanIdByTrinkets(curAwakerTrinkets)
  local curChoosedPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  if curEquipPlanId == curChoosedPlanId then
    return true
  end
  return false
end

function TrinketEquipedView:_OnClickAddNewSiutPlan()
  UIManager.Instance:Reopen(Urls.TrinketPlanEditView, 0)
end

function TrinketEquipedView:_OnClickBtnTakeoffAll()
  Alert.Show(10640, nil, function()
    AwakerTrinketController.Instance:TakeOffAllTrinkets()
  end)
end

function TrinketEquipedView:_OnClickBtnRecommend()
  local awakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  AwakerTrinketController.Instance:ReqEquipRecommendTrinket(awakerTid)
end

function TrinketEquipedView:_OnClickEquipSiutPlan()
  if self:_CheckSuitPlanEquipedSame() then
    Alert.Show(10811)
    return
  end
  local planId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  AwakerTrinketController.Instance:ReqEquipTrinketPlan(planId)
end

function TrinketEquipedView:_OnClickDeletePlan()
  local curPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  AwakerTrinketController.Instance:DeleteAwakerTrinketSuitPlan(curPlanId)
end

function TrinketEquipedView:_OnClickEditPlan()
  local curPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  UIManager.Instance:Reopen(Urls.TrinketPlanEditView, curPlanId)
end

function TrinketEquipedView:_OnTrinketChoosenTypeChanged()
  self:_CloseItemDetailTips()
  self:_AdjustDetailTipsPosition()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnTrinketTrinketPartTypeChanged(partType)
  self:_CloseItemDetailTips()
  self:_RefreshView(true)
  local uid = 0
  local curChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
  if curChoosenType == TrinketChoosenType.SingleTrinket then
    uid = AwakerTrinketExtModel.Instance:GetCurChoosenTrinketUid()
  else
    uid = AwakerTrinketExtModel.Instance:GetCurPartPlanTrinketUid()
  end
  if 0 ~= uid then
    self:_ShowItemDetailTips(uid)
  end
end

function TrinketEquipedView:_OnTrinketChoosen(uid, lastUid)
  local isChanged = uid ~= lastUid
  if isChanged then
    self:_RefreshView(false)
  end
  self:_ShowItemDetailTips(uid)
end

function TrinketEquipedView:_OnAwakerEquipedTrinketSuit()
  Alert.Show(10812)
  AwakerTrinketExtModel.Instance:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnBagItemDataChanged(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    return
  end
  if ItemDataUtils.GetItemType(itemData.tid) ~= CommonDefine.ItemType.Trinket then
    return
  end
  self:_RefreshView(false)
end

function TrinketEquipedView:_OnTrinketsDeleted(uids)
  AwakerTrinketExtModel.Instance:DeleteTrinketFromTrinketsList(uids)
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnTrinketBoundDataChanged()
  AwakerTrinketExtModel.Instance:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnTrinketEquiped(uid)
  AwakerTrinketExtModel.Instance:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnTrinketUnequiped(uid)
  AwakerTrinketExtModel.Instance:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnAwakerTakeoffAllTrinkets()
  AwakerTrinketExtModel.Instance:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnAwakerEquipRecommendTrinket()
  AwakerTrinketExtModel.Instance:CalFilterTrinketsList()
  self:_RefreshView(true)
end

function TrinketEquipedView:_OnTrinketSuitPlanChoosen(uid)
  self:_RefreshView(false)
end

function TrinketEquipedView:_OnAwakerTrinketSuitPlanUpdate(id, isNewPlan)
  self:_RefreshView(isNewPlan)
  if isNewPlan then
    local curChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
    if curChoosenType == TrinketChoosenType.SingleTrinket then
      AwakerTrinketExtModel.Instance:SetCurTrinketChoosenType(TrinketChoosenType.TrinketSuit)
      Alert.Show(10805)
    end
  end
end

function TrinketEquipedView:_OnTrinketUpdategraded()
  self:_RefreshView(false)
end

function TrinketEquipedView:_OnClickBtnEquip()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  local curSelectUid = AwakerTrinketExtModel.Instance:GetCurChoosenTrinketUid()
  AwakerTrinketController.Instance:ReqEquipTrinket(curSelectUid)
end

function TrinketEquipedView:_OnClickBtnSaved()
  local trinkets = AwakerTrinketExtModel.Instance:GetCurAwakerTrinketsUidList()
  AwakerTrinketController.Instance:OpenTrinketSuitPlanView({
    suitPlanId = 0,
    trinkets = trinkets,
    suitPlanName = nil
  })
end

function TrinketEquipedView:OnTrinketFilterChanged()
  self:_RefreshView(false)
end

function TrinketEquipedView:_GetTrinkets()
  local curChoosenType = AwakerTrinketExtModel.Instance:GetCurTrinketChoosenType()
  if curChoosenType == TrinketChoosenType.SingleTrinket then
    do return AwakerTrinketExtModel.Instance.GetCurAwakerTrinketsDisplayMap end
    return AwakerTrinketExtModel.Instance.GetCurAwakerTrinketsDisplayMap, AwakerTrinketExtModel.Instance
  end
  do return AwakerTrinketExtModel.Instance.GetCurShowTrinkets end
  return AwakerTrinketExtModel.Instance.GetCurShowTrinkets, AwakerTrinketExtModel.Instance
end

function TrinketEquipedView:_GetComparedTrinkets()
  do return AwakerTrinketExtModel.Instance.GetCurAwakerTrinketsDisplayMap end
  return AwakerTrinketExtModel.Instance.GetCurAwakerTrinketsDisplayMap, AwakerTrinketExtModel.Instance
end

function TrinketEquipedView:_GetCurPartType()
  do return AwakerTrinketExtModel.Instance.GetCurPartType end
  return AwakerTrinketExtModel.Instance.GetCurPartType, AwakerTrinketExtModel.Instance
end

function TrinketEquipedView:OnClickTrinketPartType(partType)
  AwakerTrinketExtModel.Instance:SetCurPartType(partType)
end

function TrinketEquipedView:_GetCurEquipTrinketUid()
  local equipUid = AwakerTrinketExtModel.Instance:GetCurEquipTrinketUid()
  return equipUid
end

function TrinketEquipedView:_IsChoosenTrinketBoundOnly()
  local model = AwakerTrinketExtModel.Instance
  local curSelectUid = model:GetCurChoosenTrinketUid()
  if 0 == curSelectUid then
    return false
  end
  local boundAwakerTid = AwakerDataUtils.IsTrinketBoundByAnyAwaker(curSelectUid)
  return nil ~= boundAwakerTid
end

function TrinketEquipedView:_GetCurChoosenTrinketUid()
  do return AwakerTrinketExtModel.Instance.GetCurChoosenTrinketUid end
  return AwakerTrinketExtModel.Instance.GetCurChoosenTrinketUid, AwakerTrinketExtModel.Instance
end

function TrinketEquipedView:RegisterCloseCb(func)
  self.closeCb = func
end

function TrinketEquipedView:OnExitView()
  if self.teamModel then
    self.teamModel:SetTrinketsGroupWithTeamSlot(AwakerTrinketExtModel.Instance:GetCurAwakerTrinketsUidList(), self.teamSlot)
  end
  if self.closeCb then
    local trinketsRst = AwakerTrinketExtModel.Instance:GetCurAwakerTrinketsUidList()
    if not self.teamModel then
      trinketsRst = AwakerTrinketExtModel.Instance:StripBoundTrinkets(trinketsRst)
    end
    self.closeCb(trinketsRst)
  end
  Super.OnExitView(self)
end

return TrinketEquipedView
