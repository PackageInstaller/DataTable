local AwakerFullListItem, Super = System.NewComponent("AwakerFullListItem")

function AwakerFullListItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_ListResource(res)
  self.data = data
  self.model = data.model
  self.awakerData = self.data.awakerData
  self.selected = Vue.ref(false)
end

function AwakerFullListItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick), nil, nil, function()
    return self.model.selectAwakerId ~= self.awakerData.tid
  end)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return AwakerDataUtils.GetAwakerBust end
    return AwakerDataUtils.GetAwakerBust, self.awakerData.tid
  end)
  binder:BindToText(self.ui.Text_Level, function()
    local sortType = self.model.sortType
    local awakerTid = self.awakerData.tid
    if not self.model:HasOwnedAwaker(awakerTid) then
      return ""
    end
    local showText = self.model:GetSortTypeTagContent(sortType, awakerTid)
    return showText
  end)
  binder:BindToVisible(self.ui.Image_Collect, function()
    local awakerTid = self.awakerData.tid
    do return AwakerDataUtils.GetAwakerCollectStateByTid end
    return AwakerDataUtils.GetAwakerCollectStateByTid, awakerTid
  end)
  binder:BindToVisible(self.ui.Text_Level, function()
    local awakerTid = self.awakerData.tid
    if not self.model:HasOwnedAwaker(awakerTid) then
      return false
    end
    return true
  end)
  binder:BindToImage(self.ui.Image_D_Quality_Color, function()
    do return AwakerDataUtils.GetAwakerQualityColor end
    return AwakerDataUtils.GetAwakerQualityColor, self.awakerData.tid
  end)
  binder:BindToImage(self.ui.Image_Career_Icon, function()
    local awakerTid = self.awakerData.tid
    local awakerConfig = self.model:GetAwakerConfig(awakerTid)
    local iconPath = self.model:GetSchoolIcon(awakerConfig.School)
    return iconPath
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.model.selectAwakerId == self.awakerData.tid
  end)
  binder:BindToVisible(self.ui.Group_None, function()
    if self.model:GetIsDark(self.awakerData.tid) then
      return true
    end
    return self.awakerData.state ~= CommonDefine.AwakerState.Owned
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    local ret = false
    if self.awakerData.state ~= CommonDefine.AwakerState.Owned then
      if AwakerSkinUtils.IsAwakerHasNewSkin(self.awakerData.tid) then
        return RedPointDataUtils.RedAttrType.Red
      end
      return ret
    end
    local data = RedPointDataUtils.GetAwakerRedData(self.awakerData.tid)
    if data and not ret then
      ret = RedPointDataUtils.ShowRedPointState(data)
    end
    local isChargeFormHasNewSkin = false
    local chargeForm = AwakerDataUtils.GetChangerForm(self.awakerData.tid)
    if 0 ~= chargeForm and AwakerSkinUtils.IsAwakerHasNewSkin(chargeForm) then
      isChargeFormHasNewSkin = true
    end
    if (AwakerSkinUtils.IsAwakerHasNewSkin(self.awakerData.tid) or isChargeFormHasNewSkin) and ret ~= RedPointDataUtils.RedAttrType.IsNew then
      ret = RedPointDataUtils.RedAttrType.IsNew
    end
    return ret
  end))
  self:_BindPotencyShow(binder)
  self:_BindAwakerFavor(binder)
end

function AwakerFullListItem:_BindAwakerFavor(binder)
  if not self.ui.Image_AwakerFavor then
    return
  end
  local awakerTid = self.awakerData.tid
  binder:BindToVisible(self.ui.Image_AwakerFavor, function()
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, self.awakerData
  end)
end

function AwakerFullListItem:_BindPotencyShow(binder)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    return {
      self.awakerData.tid,
      self.awakerData.potency
    }
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Potency, function()
    local awakerTid = self.awakerData.tid
    do return self.model.HasOwnedAwaker, self.model end
    return self.model.HasOwnedAwaker, self.model, awakerTid
  end)
end

function AwakerFullListItem:OnClick()
  if not (self.data and self.data.awakerData) or not self.data.callback then
    return
  end
  self.data.callback(self.data.awakerData.tid)
end

return AwakerFullListItem
