_class("UIHauteCoutureQT", UIHauteCoutureDataBase)
UIHauteCoutureQT = UIHauteCoutureQT

function UIHauteCoutureQT:Constructor()
end

function UIHauteCoutureQT:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinQT
end

function UIHauteCoutureQT:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2Controller")
end

function UIHauteCoutureQT:BuyItem()
end

function UIHauteCoutureQT:IsReview()
  return false
end

function UIHauteCoutureQT:HC_Type()
  return HauteCoutureType.HC_BLH
end

function UIHauteCoutureQT:GetMainUIInfo()
  return "UIHauteCoutureDraw_QT_Main.prefab", UIHauteCoutureDraw_QT_Main
end

function UIHauteCoutureQT:GetMainUIBgInfo()
  return "UIHauteCoutureDraw_QT_Bg.prefab", UIHauteCoutureDraw_QT_Bg
end

function UIHauteCoutureQT:GetGetItemUIInfo()
  return "UIHauteCoutureDraw_QT_GetItemMain.prefab", UIHauteCoutureDraw_QT_GetItemMain
end

function UIHauteCoutureQT:GetChargeUIInfo()
  return "UIHauteCoutureDraw_QT_ChargeMain.prefab", UIHauteCoutureDraw_QT_ChargeMain
end

function UIHauteCoutureQT:GetChargeUIBgInfo()
  return "UIHauteCoutureDraw_QT_ChargeBg.prefab", UIHauteCoutureDraw_QT_ChargeBg
end

function UIHauteCoutureQT:GetRulesUIInfo()
  return "UIHauteCoutureDraw_QT_RulesMain.prefab", UIHauteCoutureDraw_QT_RulesMain
end

function UIHauteCoutureQT:GetRulesUIBgInfo()
  return "UIHauteCoutureDraw_QT_RulesBg.prefab", UIHauteCoutureDraw_QT_RulesBg
end

function UIHauteCoutureQT:GetVideoUIInfo()
  return "UIHauteCoutureDraw_QT_VideoMain.prefab", UIHauteCoutureDraw_QT_VideoMain
end

function UIHauteCoutureQT:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityMain.prefab", UIHauteCoutureDraw_QT_DynamicProbabilityMain
end

function UIHauteCoutureQT:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityBg.prefab", UIHauteCoutureDraw_QT_DynamicProbabilityBg
end

function UIHauteCoutureQT:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title4")
end
