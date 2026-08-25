local RedDotType = CommonDefine.RedDotType
local AwakerMiniListToggleItem, Super = System.NewComponent("AwakerMiniListToggleItem")

function AwakerMiniListToggleItem:ctor(res, redFunc)
  Super.ctor(self)
  self.ui = UI_Common_Toggle_ListResource(res)
  self.redFunc = redFunc
end

function AwakerMiniListToggleItem:OnBind(binder)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_UnSelect, RedDotType.Dot, nil, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    if self.redFunc then
      do return end
      return self.redFunc, AwakerDataUtils.GetMockAwakerMap()
    end
  end))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Select, RedDotType.Dot, nil, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    if self.redFunc then
      do return end
      return self.redFunc, AwakerDataUtils.GetMockAwakerMap()
    end
  end))
end

return AwakerMiniListToggleItem
