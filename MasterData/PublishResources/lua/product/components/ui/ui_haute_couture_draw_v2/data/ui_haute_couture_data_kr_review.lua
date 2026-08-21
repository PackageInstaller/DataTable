_class("UIHauteCoutureKR_Review", UIHauteCoutureDataBase)
UIHauteCoutureKR_Review = UIHauteCoutureKR_Review

function UIHauteCoutureKR_Review:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinKR_Re
end

function UIHauteCoutureKR_Review:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCoutureKR_Review:BuyItem()
  Log.exception("BuyItem()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKR_Review:IsReview()
  return true
end

function UIHauteCoutureKR_Review:HC_Type()
  return HauteCoutureType.HC_KR_Re
end

function UIHauteCoutureKR_Review:GetMainUIInfo()
  return "UIHauteCoutureDrawMainKR_Review.prefab", UIHauteCoutureDrawMainKR_Review
end

function UIHauteCoutureKR_Review:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgKR.prefab", UIHauteCoutureDrawBgKR
end

function UIHauteCoutureKR_Review:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainKR.prefab", UIHauteCoutureDrawGetItemMainKR
end

function UIHauteCoutureKR_Review:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainKR.prefab", UIHauteCoutureDrawChargeMainKR
end

function UIHauteCoutureKR_Review:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgKR.prefab", UIHauteCoutureDrawChargeBgKR
end

function UIHauteCoutureKR_Review:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainKR.prefab", UIHauteCoutureDrawRulesMainKR
end

function UIHauteCoutureKR_Review:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgKR.prefab", UIHauteCoutureDrawRulesBgKR
end

function UIHauteCoutureKR_Review:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainKR.prefab", UIHauteCoutureDrawVideoMainKR
end

function UIHauteCoutureKR_Review:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainKR.prefab", UIHauteCoutureDrawDynamicProbabilityMainKR
end

function UIHauteCoutureKR_Review:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgKR.prefab", UIHauteCoutureDrawDynamicProbabilityBgKR
end

function UIHauteCoutureKR_Review:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title2")
end

function UIHauteCoutureKR_Review:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgKR.prefab", nil
end

function UIHauteCoutureKR_Review:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDrawDuplicateRewardKR.prefab", UIHauteCoutureDuplicateRewardKR
end

function UIHauteCoutureKR_Review:GetBgm()
  return CriAudioIDConst.BGMHauteCoutureKR
end
