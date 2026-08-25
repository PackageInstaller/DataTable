local UIAnimationController = CS.Z1Client.UIAnimationController
local currTypeTag
local MainShopTabItem, Super = System.NewComponent("MainShopTabItem")

function MainShopTabItem:ctor(uiNode, relativeUI, typeTag, openAnim)
  Super.ctor(self)
  self.rootUINode = uiNode
  self.ui = UI_Shop_Item_ToggleResource(uiNode)
  self.typeTag = typeTag
  self.shopTypeCfg = MainShopDataUtils.GetShopTypeCfgByTypeTag(typeTag)
  self.relativeUI = relativeUI
  self.textName = self.shopTypeCfg.ShopName
  self.openAnim = openAnim
end

function MainShopTabItem:SetCallBack(callback)
  self.callback = callback
end

function MainShopTabItem:OnBind(binder)
  self.binder = binder
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:SetText(self.ui.Text_Toggle_Normal, LT.Text(self.textName))
  binder:SetText(self.ui.Text_Toggle_Select, LT.Text(self.textName))
  binder:SetText(self.ui.Text_Toggle_Lock, LT.Text(self.textName))
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_Toggle_Normal, nil, 230)
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_Toggle_Select, nil, 230)
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_Toggle_Lock, nil, 230)
  binder:BindToImage(self.ui.Image_Icon_Toggle_Normal, function()
    return self.shopTypeCfg.IconNormal
  end)
  binder:BindToImage(self.ui.Image_Icon_Toggle_Select, function()
    return self.shopTypeCfg.IconSelect
  end)
  binder:BindToZ1Toggle(self.rootUINode, nil, function(isOn)
    if self.relativeUI then
      binder:SetActive(self.relativeUI, isOn)
    end
    binder:SetActive(self.ui.Group_Select, isOn)
    if isOn then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Shop, RedPointDataUtils.RedAttrType.IsNew, MainShopDataUtils.GetShopRealType(self.typeTag))
      self.callback(self.typeTag)
      if currTypeTag ~= self.typeTag then
        if self.openAnim and ShopDataUtils.initMainAnim then
          self.openAnim()
        end
        ShopDataUtils.initMainAnim = true
      end
      currTypeTag = self.typeTag
    end
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    return not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.typeTag)
  end)
  binder:BindButtonClick(self.ui.Group_Lock, function()
    local unlocked = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(self.typeTag)
    if not unlocked then
      if self.typeTag == CommonDefine.MainShopTypeTag.BattlePassReview then
        PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.BattlePass, 0)
        return
      end
      PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Shop, MainShopDataUtils.GetShopRealType(self.typeTag))
    end
  end)
  binder:BindToVisible(self.ui.Group_Normal, function()
    do return MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag end
    return MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag, self.typeTag
  end)
  if self.typeTag then
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
      do return RedPointDataUtils.GetShopTagRedData end
      return RedPointDataUtils.GetShopTagRedData, self.typeTag
    end))
  end
  if self.shopTypeCfg.TagText then
    self.ui.Group_Recommend:SetActive(true)
    self.binder:SetText(self.ui.Text_C_Recommend, self.shopTypeCfg.TagText)
  end
  self.binder:SetActive(self.ui.UI_Main_Item_Time_End, self.typeTag == CommonDefine.MainShopTypeTag.LimitedTimeGiftBox)
  if self.typeTag == CommonDefine.MainShopTypeTag.LimitedTimeGiftBox then
    self.binder:BindComponent(MainTimeEndComp(self.ui.UI_Main_Item_Time_End, function()
      do return end
      return LimitTimeGiftUtils.GetShortestEndTime, nil
    end))
  end
end

function MainShopTabItem:_PlayCtorAnim()
  self.uiAnimationController:PlayState("UI_Vx_Common_Item_01")
end

return MainShopTabItem
