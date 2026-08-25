local ShopTypeToggleListItem, Super = NewViewComponent("ShopTypeToggleListItem")
local TYPEOF_Z1Toggle = typeof(CS.Z1Client.Z1Toggle)
local FindChild = CS.Framework.GameObjectUtil.FindChild

function ShopTypeToggleListItem:ctor(uiNode, view, shopTypeTid, relativeUI, openAnimFunc, groupNode)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Shop_Item_ToggleResource(uiNode)
  self.shopTypeTid = shopTypeTid
  self.relativeUI = relativeUI
  self.openAnimFunc = openAnimFunc
  self.groupNode = groupNode
  local config = ShopExtModel.Instance:GetShopTypeConfig(self.shopTypeTid)
  self.typeTag = config and config.TypeTag
end

function ShopTypeToggleListItem:RegisterNotifications()
end

function ShopTypeToggleListItem:RegisterEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.uiNode, System.fn(self, self._OnToggleValueChanged), System.fn(self, self._OnClickWhenLockedState))
end

function ShopTypeToggleListItem:OnEnterComponent()
  if self.groupNode then
    self.z1ToggleComp = self.ui.uiNode:GetComponent(TYPEOF_Z1Toggle)
    if self.z1ToggleComp then
      self.z1ToggleComp.group = self.groupNode
    end
  end
  self:_Refresh()
  self:_BindRedPointCom()
end

function ShopTypeToggleListItem:_Refresh()
  local unlocked = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.typeTag)
  if not MainShopDataUtils.IsShopInOpenTime(self.shopTypeTid) then
    unlocked = false
  end
  self:SetZ1ToggleUnlock(self.ui.uiNode, unlocked)
  local config = ShopExtModel.Instance:GetShopTypeConfig(self.shopTypeTid)
  if not config then
    return
  end
  local shopTypeName = LT.Text(config.ShopName)
  self:SetText(self.ui.Text_Toggle_Normal, shopTypeName)
  self:SetText(self.ui.Text_Toggle_Select, shopTypeName)
  self:SetText(self.ui.Text_Toggle_Lock, shopTypeName)
  self:SetImage(self.ui.Image_Icon_Toggle_Normal, config.IconNormal)
  self:SetImage(self.ui.Image_Icon_Toggle_Select, config.IconSelect)
  local isRecommendShow = config.TagText ~= nil
  if config.TypeTag == CommonDefine.MainShopTypeTag.MoonCard then
    local monthCardData = ShopExtModel.Instance:GetMonthCardData(CommonDefine.MonthCardType.Diamond)
    isRecommendShow = monthCardData and monthCardData.state == CommonDefine.MonthCardState.NeverPurchased and not RedPointDataUtils.IsMonthCardExpire()
  end
  self.ui.Group_Recommend:SetActive(isRecommendShow)
  if config.TagText then
    self:SetText(self.ui.Text_C_Recommend, LT.Text(self.shopTypeCfg.TagText))
  end
end

function ShopTypeToggleListItem:_IsLocked()
  local unlocked = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.typeTag)
  if not unlocked then
    return true
  end
  local isInOpenTime = MainShopDataUtils.IsShopInOpenTime(self.shopTypeTid)
  if not isInOpenTime then
    return true
  end
end

function ShopTypeToggleListItem:_BindRedPointCom()
  if self:_IsLocked() then
    self:SetActive(self.ui.Com_RedDot, false)
    return
  end
  if self.typeTag then
    local groupRedDot = FindChild(self.ui.Com_RedDot, "Group_RedDot")
    if groupRedDot then
      self:SetActive(groupRedDot.gameObject, false)
    end
    self.view:AddRedPoint(self.ui.Com_RedDot, RedDotDefine.DynamicRedDotID.ShopTypeTabRedDot, {
      shopTypeTid = self.shopTypeTid
    })
  end
end

function ShopTypeToggleListItem:_OnToggleValueChanged(isOn)
  if self.relativeUI then
    self.relativeUI:SetActive(isOn)
  end
  self.ui.Group_Select:SetActive(isOn)
  if isOn then
    self:LocalNotify(NotifyId.OnSelectShopTypeChanged, self.shopTypeTid)
  end
end

function ShopTypeToggleListItem:_OnClickWhenLockedState()
  local unlocked = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.typeTag)
  if not unlocked then
    if self.typeTag == CommonDefine.MainShopTypeTag.BattlePassReview then
      PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.BattlePass, 0)
      return
    end
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Shop, MainShopDataUtils.GetShopRealType(self.typeTag))
    return
  end
  local isInOpenTime, openData = MainShopDataUtils.IsShopInOpenTime(self.shopTypeTid)
  if not isInOpenTime and openData.AlertTips then
    Alert.ShowStr(openData.AlertTips)
    return
  end
end

function ShopTypeToggleListItem:SetToggleOn(isOn)
  self.z1ToggleComp.isOn = isOn
end

function ShopTypeToggleListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return ShopTypeToggleListItem
