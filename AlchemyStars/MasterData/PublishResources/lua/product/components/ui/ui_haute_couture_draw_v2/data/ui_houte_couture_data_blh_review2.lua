_class("UIHauteCoutureBLH_Review2", UIHauteCoutureDataBase)
UIHauteCoutureBLH_Review2 = UIHauteCoutureBLH_Review2

function UIHauteCoutureBLH_Review2:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinBLH_ReRe
end

function UIHauteCoutureBLH_Review2:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCoutureBLH_Review2:BuyItem()
  Log.exception("BuyItem()方法必须重写：", debug.traceback())
end

function UIHauteCoutureBLH_Review2:IsReview()
  return true
end

function UIHauteCoutureBLH_Review2:GetSkinId()
  return 90773
end

function UIHauteCoutureBLH_Review2:HC_Type()
  return HauteCoutureType.HC_BLH_Re
end

function UIHauteCoutureBLH_Review2:GetMainUIInfo()
  return "UIHauteCoutureDrawMainBLH_Review2.prefab", UIHauteCoutureDrawMainBLH_Review2
end

function UIHauteCoutureBLH_Review2:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgBLH.prefab", UIHauteCoutureDrawBgBLH
end

function UIHauteCoutureBLH_Review2:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainBLH.prefab", UIHauteCoutureDrawGetItemMainBLH
end

function UIHauteCoutureBLH_Review2:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainBLH.prefab", UIHauteCoutureDrawChargeMainBLH
end

function UIHauteCoutureBLH_Review2:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgBLH.prefab", UIHauteCoutureDrawChargeBgBLH
end

function UIHauteCoutureBLH_Review2:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainBLH.prefab", UIHauteCoutureDrawRulesMainBLH
end

function UIHauteCoutureBLH_Review2:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgBLH.prefab", UIHauteCoutureDrawRulesBgBLH
end

function UIHauteCoutureBLH_Review2:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainBLH.prefab", UIHauteCoutureDrawVideoMainBLH
end

function UIHauteCoutureBLH_Review2:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainBLH_Review2.prefab", UIHauteCoutureDrawDynamicProbabilityMainBLHReview2
end

function UIHauteCoutureBLH_Review2:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgBLH.prefab", UIHauteCoutureDrawDynamicProbabilityBgBLH
end

function UIHauteCoutureBLH_Review2:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title2")
end

function UIHauteCoutureBLH_Review2:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgBLH.prefab", UIHauteCoutureDuplicateRewardBgBLH
end

function UIHauteCoutureBLH_Review2:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardBLH.prefab", UIHauteCoutureDuplicateRewardBLH
end
