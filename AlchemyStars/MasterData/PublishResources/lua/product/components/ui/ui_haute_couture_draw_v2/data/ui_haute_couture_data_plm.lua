_class("UIHauteCouturePLM", UIHauteCoutureDataBase)
UIHauteCouturePLM = UIHauteCouturePLM

function UIHauteCouturePLM:Constructor()
end

function UIHauteCouturePLM:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinPLM
end

function UIHauteCouturePLM:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2Controller")
end

function UIHauteCouturePLM:BuyItem()
end

function UIHauteCouturePLM:IsReview()
  return false
end

function UIHauteCouturePLM:HC_Type()
  return HauteCoutureType.HC_PLM
end

function UIHauteCouturePLM:GetMainUIInfo()
  return "UIHauteCoutureDrawMainPLM.prefab", UIHauteCoutureDrawMainPLM
end

function UIHauteCouturePLM:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgPLM.prefab", UIHauteCoutureDrawBgPLM
end

function UIHauteCouturePLM:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainPLM.prefab", UIHauteCoutureDrawGetItemMainPLM
end

function UIHauteCouturePLM:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainPLM.prefab", UIHauteCoutureDrawChargeMainPLM
end

function UIHauteCouturePLM:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgPLM.prefab", UIHauteCoutureDrawChargeBgPLM
end

function UIHauteCouturePLM:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainPLM.prefab", UIHauteCoutureDrawRulesMainPLM
end

function UIHauteCouturePLM:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgPLM.prefab", UIHauteCoutureDrawRulesBgPLM
end

function UIHauteCouturePLM:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainPLM.prefab", UIHauteCoutureDrawVideoMainPLM
end

function UIHauteCouturePLM:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainPLM.prefab", UIHauteCoutureDrawDynamicProbabilityMainPLM
end

function UIHauteCouturePLM:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgPLM.prefab", UIHauteCoutureDrawDynamicProbabilityBgPLM
end

function UIHauteCouturePLM:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title4")
end
