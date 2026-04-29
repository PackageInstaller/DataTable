_class("UIHauteCoutureQTReview2", UIHauteCoutureDataBase)
UIHauteCoutureQTReview2 = UIHauteCoutureQTReview2

function UIHauteCoutureQTReview2:Constructor()
end

function UIHauteCoutureQTReview2:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinQT3
end

function UIHauteCoutureQTReview2:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2Controller")
end

function UIHauteCoutureQTReview2:BuyItem()
end

function UIHauteCoutureQTReview2:IsReview()
  return false
end

function UIHauteCoutureQTReview2:HC_Type()
  return HauteCoutureType.HC_QT_Re
end

function UIHauteCoutureQTReview2:GetMainUIInfo()
  return "UIHauteCoutureDraw_QT_Main_Review.prefab", UIHauteCoutureDraw_QT_Main_Review
end

function UIHauteCoutureQTReview2:GetMainUIBgInfo()
  return "UIHauteCoutureDraw_QT_Bg.prefab", UIHauteCoutureDraw_QT_Bg
end

function UIHauteCoutureQTReview2:GetGetItemUIInfo()
  return "UIHauteCoutureDraw_QT_GetItemMain.prefab", UIHauteCoutureDraw_QT_GetItemMain
end

function UIHauteCoutureQTReview2:GetChargeUIInfo()
  return "UIHauteCoutureDraw_QT_ChargeMain.prefab", UIHauteCoutureDraw_QT_ChargeMain
end

function UIHauteCoutureQTReview2:GetChargeUIBgInfo()
  return "UIHauteCoutureDraw_QT_ChargeBg.prefab", UIHauteCoutureDraw_QT_ChargeBg
end

function UIHauteCoutureQTReview2:GetRulesUIInfo()
  return "UIHauteCoutureDraw_QT_RulesMain.prefab", UIHauteCoutureDraw_QT_RulesMain
end

function UIHauteCoutureQTReview2:GetRulesUIBgInfo()
  return "UIHauteCoutureDraw_QT_RulesBg.prefab", UIHauteCoutureDraw_QT_RulesBg
end

function UIHauteCoutureQTReview2:GetVideoUIInfo()
  return "UIHauteCoutureDraw_QT_VideoMain.prefab", UIHauteCoutureDraw_QT_VideoMain
end

function UIHauteCoutureQTReview2:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityMain.prefab", UIHauteCoutureDraw_QT_DynamicProbabilityMain
end

function UIHauteCoutureQTReview2:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityBg.prefab", UIHauteCoutureDraw_QT_DynamicProbabilityBg
end

function UIHauteCoutureQTReview2:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title4")
end

function UIHauteCoutureQTReview2:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgQT.prefab", nil
end

function UIHauteCoutureQTReview2:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardQT.prefab", UIHauteCoutureDuplicateRewardQT
end
