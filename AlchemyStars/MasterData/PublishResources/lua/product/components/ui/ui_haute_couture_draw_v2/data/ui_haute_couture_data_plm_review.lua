_class("UIHauteCouturePLM_Review", UIHauteCoutureDataBase)
UIHauteCouturePLM_Review = UIHauteCouturePLM_Review

function UIHauteCouturePLM_Review:Constructor()
end

function UIHauteCouturePLM_Review:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinPLM_Re
end

function UIHauteCouturePLM_Review:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCouturePLM_Review:BuyItem()
end

function UIHauteCouturePLM_Review:IsReview()
  return true
end

function UIHauteCouturePLM_Review:HC_Type()
  return HauteCoutureType.HC_PLM_Re
end

function UIHauteCouturePLM_Review:GetMainUIInfo()
  return "UIHauteCoutureDrawMainPLM_Review.prefab", UIHauteCoutureDrawMainPLM_Review
end

function UIHauteCouturePLM_Review:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgPLM.prefab", UIHauteCoutureDrawBgPLM
end

function UIHauteCouturePLM_Review:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainPLM.prefab", UIHauteCoutureDrawGetItemMainPLM
end

function UIHauteCouturePLM_Review:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainPLM.prefab", UIHauteCoutureDrawChargeMainPLM
end

function UIHauteCouturePLM_Review:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgPLM.prefab", UIHauteCoutureDrawChargeBgPLM
end

function UIHauteCouturePLM_Review:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainPLM.prefab", UIHauteCoutureDrawRulesMainPLM
end

function UIHauteCouturePLM_Review:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgPLM.prefab", UIHauteCoutureDrawRulesBgPLM
end

function UIHauteCouturePLM_Review:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainPLM.prefab", UIHauteCoutureDrawVideoMainPLM
end

function UIHauteCouturePLM_Review:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainPLM.prefab", UIHauteCoutureDrawDynamicProbabilityMainPLM
end

function UIHauteCouturePLM_Review:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgPLM.prefab", UIHauteCoutureDrawDynamicProbabilityBgPLM
end

function UIHauteCouturePLM_Review:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgPLM.prefab", nil
end

function UIHauteCouturePLM_Review:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardPLM.prefab", UIHauteCoutureDuplicateRewardPLM
end

function UIHauteCouturePLM_Review:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title4")
end
