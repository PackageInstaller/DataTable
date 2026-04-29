_class("UIHauteCoutureQTReview", UIHauteCoutureDataBase)
UIHauteCoutureQTReview = UIHauteCoutureQTReview

function UIHauteCoutureQTReview:Constructor()
end

function UIHauteCoutureQTReview:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinQT3
end

function UIHauteCoutureQTReview:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCoutureQTReview:BuyItem()
end

function UIHauteCoutureQTReview:IsReview()
  return true
end

function UIHauteCoutureQTReview:HC_Type()
  return HauteCoutureType.HC_QT_Re
end

function UIHauteCoutureQTReview:GetMainUIInfo()
  return "UIHauteCoutureDraw_QT_Main_Review.prefab", UIHauteCoutureDraw_QT_Main_Review
end

function UIHauteCoutureQTReview:GetMainUIBgInfo()
  return "UIHauteCoutureDraw_QT_Bg.prefab", UIHauteCoutureDraw_QT_Bg
end

function UIHauteCoutureQTReview:GetGetItemUIInfo()
  return "UIHauteCoutureDraw_QT_GetItemMain.prefab", UIHauteCoutureDraw_QT_GetItemMain
end

function UIHauteCoutureQTReview:GetChargeUIInfo()
  return "UIHauteCoutureDraw_QT_ChargeMain.prefab", UIHauteCoutureDraw_QT_ChargeMain
end

function UIHauteCoutureQTReview:GetChargeUIBgInfo()
  return "UIHauteCoutureDraw_QT_ChargeBg.prefab", UIHauteCoutureDraw_QT_ChargeBg
end

function UIHauteCoutureQTReview:GetRulesUIInfo()
  return "UIHauteCoutureDraw_QT_RulesMain.prefab", UIHauteCoutureDraw_QT_RulesMain
end

function UIHauteCoutureQTReview:GetRulesUIBgInfo()
  return "UIHauteCoutureDraw_QT_RulesBg.prefab", UIHauteCoutureDraw_QT_RulesBg
end

function UIHauteCoutureQTReview:GetVideoUIInfo()
  return "UIHauteCoutureDraw_QT_VideoMain.prefab", UIHauteCoutureDraw_QT_VideoMain
end

function UIHauteCoutureQTReview:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityMain.prefab", UIHauteCoutureDraw_QT_DynamicProbabilityMain
end

function UIHauteCoutureQTReview:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityBg.prefab", UIHauteCoutureDraw_QT_DynamicProbabilityBg
end

function UIHauteCoutureQTReview:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title4")
end

function UIHauteCoutureQTReview:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgQT.prefab", nil
end

function UIHauteCoutureQTReview:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardQT.prefab", UIHauteCoutureDuplicateRewardQT
end
