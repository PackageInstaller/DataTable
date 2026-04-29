_class("UIHauteCoutureBLH", UIHauteCoutureDataBase)
UIHauteCoutureBLH = UIHauteCoutureBLH

function UIHauteCoutureBLH:Constructor()
end

function UIHauteCoutureBLH:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinBLH
end

function UIHauteCoutureBLH:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2Controller")
end

function UIHauteCoutureBLH:BuyItem()
end

function UIHauteCoutureBLH:IsReview()
  return false
end

function UIHauteCoutureBLH:HC_Type()
  return HauteCoutureType.HC_BLH
end

function UIHauteCoutureBLH:GetMainUIInfo()
  return "UIHauteCoutureDrawMainBLH.prefab", UIHauteCoutureDrawMainBLH
end

function UIHauteCoutureBLH:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgBLH.prefab", UIHauteCoutureDrawBgBLH
end

function UIHauteCoutureBLH:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainBLH.prefab", UIHauteCoutureDrawGetItemMainBLH
end

function UIHauteCoutureBLH:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainBLH.prefab", UIHauteCoutureDrawChargeMainBLH
end

function UIHauteCoutureBLH:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgBLH.prefab", UIHauteCoutureDrawChargeBgBLH
end

function UIHauteCoutureBLH:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainBLH.prefab", UIHauteCoutureDrawRulesMainBLH
end

function UIHauteCoutureBLH:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgBLH.prefab", UIHauteCoutureDrawRulesBgBLH
end

function UIHauteCoutureBLH:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainBLH.prefab", UIHauteCoutureDrawVideoMainBLH
end

function UIHauteCoutureBLH:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainBLH.prefab", UIHauteCoutureDrawDynamicProbabilityMainBLH
end

function UIHauteCoutureBLH:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgBLH.prefab", UIHauteCoutureDrawDynamicProbabilityBgBLH
end

function UIHauteCoutureBLH:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title4")
end
