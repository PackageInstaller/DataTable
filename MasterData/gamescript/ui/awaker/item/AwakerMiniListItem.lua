local AwakerMiniListItem, Super = System.NewComponent("AwakerMiniListItem")

function AwakerMiniListItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_List_2Resource(res)
  self.data = data
  self.model = data.model
  self.awakerData = self.data.awakerData
  self.selected = Vue.ref(false)
end

function AwakerMiniListItem:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick), nil, nil, function()
    return self.model.selectAwakerId ~= self.awakerData.tid
  end)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return self.model.GetLittleIcon, self.model end
    return self.model.GetLittleIcon, self.model, self.awakerData.tid
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    do return AwakerDataUtils.GetAwakerQualityColor end
    return AwakerDataUtils.GetAwakerQualityColor, self.awakerData.tid
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.model.selectAwakerId == self.awakerData.tid
  end)
  binder:BindToVisible(self.ui.Group_None, function()
    local hasOwned = self.model:HasOwnedAwaker(self.awakerData.tid)
    return not hasOwned
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    local ret = false
    if self.awakerData.state ~= CommonDefine.AwakerState.Owned then
      return ret
    end
    local data = RedPointDataUtils.GetAwakerRedData(self.awakerData.tid, not self.model:GetShowOriginBtn())
    if data and not ret then
      ret = RedPointDataUtils.ShowRedPointState(data)
    end
    return ret
  end))
end

function AwakerMiniListItem:OnClick()
  if not (self.data and self.data.awakerData) or not self.data.callback then
    return
  end
  self.data.callback(self.data.awakerData.tid)
end

return AwakerMiniListItem
