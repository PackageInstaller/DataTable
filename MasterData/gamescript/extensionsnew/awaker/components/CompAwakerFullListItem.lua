local CompAwakerFullListItem, Super = NewViewComponent("CompAwakerFullListItem")

function CompAwakerFullListItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Awaker_Item_ListResource(uiNode)
  self._data = data
  self._model = data.model
  self._awakerData = self._data.awakerData
  self._selected = false
end

function CompAwakerFullListItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnItemUseAwakerLevelUpTidChanged, self._OnSelectChanged, self)
end

function CompAwakerFullListItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function CompAwakerFullListItem:OnEnterComponent()
  self:_RefreshButtonState()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
  self:_RefreshRedDot()
  self:_RefreshPotencyShow()
end

function CompAwakerFullListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompAwakerFullListItem:_OnSelectChanged()
  self:_RefreshButtonState()
  self:_RefreshVisible()
end

function CompAwakerFullListItem:_RefreshText()
  local levelText = self:_GetLevelText()
  self:SetText(self.ui.Text_Level, levelText)
end

function CompAwakerFullListItem:_RefreshImage()
  local awakerTid = self._awakerData.tid
  local awakerConfig = self._model:GetAwakerConfig(awakerTid)
  local iconPath = awakerConfig and self._model:GetSchoolIcon(awakerConfig.School)
  self:SetImage(self.ui.Image_Awaker, AwakerDataUtils.GetAwakerBust(awakerTid))
  self:SetImage(self.ui.Image_D_Quality_Color, AwakerDataUtils.GetAwakerQualityColor(awakerTid))
  self:SetImage(self.ui.Image_Career_Icon, iconPath)
end

function CompAwakerFullListItem:_RefreshVisible()
  local awakerTid = self._awakerData.tid
  self.ui.Image_Collect:SetActive(AwakerDataUtils.GetAwakerCollectStateByTid(awakerTid))
  self.ui.Text_Level:SetActive(self._model:HasOwnedAwaker(awakerTid))
  local selectAwakerId = self._model:GetSelectAwakerId()
  self.ui.Image_Select:SetActive(selectAwakerId == awakerTid)
  local isDark = self._model:GetIsDark(awakerTid) or self._awakerData.state ~= CommonDefine.AwakerState.Owned
  self.ui.Group_None:SetActive(isDark)
end

function CompAwakerFullListItem:_GetLevelText()
  local sortType = self._model:GetSortType()
  local awakerTid = self._awakerData.tid
  if not self._model:HasOwnedAwaker(awakerTid) then
    return ""
  end
  local showText = self._model:GetSortTypeTagContent(sortType, awakerTid)
  return showText
end

function CompAwakerFullListItem:_RefreshRedDot()
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, System.fn(self, self._GetRedShowFunc))
end

function CompAwakerFullListItem:_GetRedShowFunc()
  local ret = false
  if self._awakerData.state ~= CommonDefine.AwakerState.Owned then
    if AwakerSkinUtils.IsAwakerHasNewSkin(self._awakerData.tid) then
      return RedPointDataUtils.RedAttrType.Red
    end
    return ret
  end
  local data = RedPointDataUtils.GetAwakerRedData(self._awakerData.tid)
  if data and not ret then
    ret = RedPointDataUtils.ShowRedPointState(data)
  end
  local isChargeFormHasNewSkin = false
  local chargeForm = AwakerDataUtils.GetChangerForm(self._awakerData.tid)
  if 0 ~= chargeForm and AwakerSkinUtils.IsAwakerHasNewSkin(chargeForm) then
    isChargeFormHasNewSkin = true
  end
  if (AwakerSkinUtils.IsAwakerHasNewSkin(self._awakerData.tid) or isChargeFormHasNewSkin) and ret ~= RedPointDataUtils.RedAttrType.IsNew then
    ret = RedPointDataUtils.RedAttrType.IsNew
  end
  return ret
end

function CompAwakerFullListItem:_RefreshPotencyShow()
  local data = {
    awakerTid = self._awakerData.tid,
    potency = self._awakerData.potency
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompAwakerPotencyItem, data)
  local ownedAwaker = self._model:HasOwnedAwaker(self._awakerData.tid)
  self.ui.UI_Common_Item_Potency:SetActive(ownedAwaker)
end

function CompAwakerFullListItem:_RefreshButtonState()
  local selectAwakerId = self._model:GetSelectAwakerId()
  local isSelected = selectAwakerId == self._awakerData.tid
  local btnState = isSelected and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.Normal
  self:SetButtonState(self.ui.Btn_Click, btnState)
end

function CompAwakerFullListItem:_OnClick()
  if not (self._data and self._data.awakerData) or not self._data.callback then
    return
  end
  self._data.callback(self._data.awakerData.tid)
end

return CompAwakerFullListItem
