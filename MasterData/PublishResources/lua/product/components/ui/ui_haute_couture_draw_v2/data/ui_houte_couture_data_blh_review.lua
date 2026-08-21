_class("UIHauteCoutureBLH_Review", UIHauteCoutureDataBase)
UIHauteCoutureBLH_Review = UIHauteCoutureBLH_Review

function UIHauteCoutureBLH_Review:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinBLH_Re
end

function UIHauteCoutureBLH_Review:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCoutureBLH_Review:BuyItem()
  Log.exception("BuyItem()方法必须重写：", debug.traceback())
end

function UIHauteCoutureBLH_Review:IsReview()
  return true
end

function UIHauteCoutureBLH_Review:HC_Type()
  return HauteCoutureType.HC_BLH_Re
end

function UIHauteCoutureBLH_Review:GetMainUIInfo()
  return "UIHauteCoutureDrawMainBLH_Review.prefab", UIHauteCoutureDrawMainBLH_Review
end

function UIHauteCoutureBLH_Review:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgBLH.prefab", UIHauteCoutureDrawBgBLH
end

function UIHauteCoutureBLH_Review:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainBLH.prefab", UIHauteCoutureDrawGetItemMainBLH
end

function UIHauteCoutureBLH_Review:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainBLH.prefab", UIHauteCoutureDrawChargeMainBLH
end

function UIHauteCoutureBLH_Review:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgBLH.prefab", UIHauteCoutureDrawChargeBgBLH
end

function UIHauteCoutureBLH_Review:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainBLH.prefab", UIHauteCoutureDrawRulesMainBLH
end

function UIHauteCoutureBLH_Review:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgBLH.prefab", UIHauteCoutureDrawRulesBgBLH
end

function UIHauteCoutureBLH_Review:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainBLH.prefab", UIHauteCoutureDrawVideoMainBLH
end

function UIHauteCoutureBLH_Review:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainBLH.prefab", UIHauteCoutureDrawDynamicProbabilityMainBLH
end

function UIHauteCoutureBLH_Review:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgBLH.prefab", UIHauteCoutureDrawDynamicProbabilityBgBLH
end

function UIHauteCoutureBLH_Review:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title2")
end

function UIHauteCoutureBLH_Review:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgBLH.prefab", UIHauteCoutureDuplicateRewardBgBLH
end

function UIHauteCoutureBLH_Review:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardBLH.prefab", UIHauteCoutureDuplicateRewardBLH
end
