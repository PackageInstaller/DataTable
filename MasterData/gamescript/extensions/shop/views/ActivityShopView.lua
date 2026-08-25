local ActivityShopView, Super = NewClass("ActivityShopView", ShopViewBase)
ActivityShopView.uiResCls = UI_Recharge_Panel_Main_OptimizedResource

function ActivityShopView:ctor(activityTid, targetShopTypeTid)
  Super.ctor(self, targetShopTypeTid)
  self.activityTid = activityTid
end

function ActivityShopView:OnBuildView()
  Super.OnBuildView(self)
end

function ActivityShopView:RegisterEvents()
  Super.RegisterEvents(self)
end

function ActivityShopView:RegisterNotifications()
  Super.RegisterNotifications(self)
end

function ActivityShopView:OnEnterView()
  Super.OnEnterView(self)
end

function ActivityShopView:_OnSelectShopTypeChanged(shopTypeTid)
  Super._OnSelectShopTypeChanged(self, shopTypeTid)
  self:_RefreshShopTitle()
  self:_RefreshBgImage()
end

function ActivityShopView:_GetShopTitle()
  local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(self.curShopTypeTid)
  if not shopTypeConfig then
    do return Super._GetShopTitle end
    return Super._GetShopTitle, self, nil
  end
  local key = "ShopName_" .. shopTypeConfig.TypeTag
  do return LT.Text end
  return LT.Text, key
end

function ActivityShopView:_GetShopTypeList()
  do return ShopExtModel.Instance.GetShopTypeListByActivityTid, ShopExtModel.Instance end
  return ShopExtModel.Instance.GetShopTypeListByActivityTid, ShopExtModel.Instance, self.activityTid
end

return ActivityShopView
