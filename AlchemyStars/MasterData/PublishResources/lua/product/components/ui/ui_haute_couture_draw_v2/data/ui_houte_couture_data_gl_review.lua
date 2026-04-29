_class("UIHauteCoutureGL_Review", UIHauteCoutureDataBase)
UIHauteCoutureGL_Review = UIHauteCoutureGL_Review

function UIHauteCoutureGL_Review:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinGL_Re
end

function UIHauteCoutureGL_Review:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCoutureGL_Review:BuyItem()
  Log.exception("BuyItem()方法必须重写：", debug.traceback())
end

function UIHauteCoutureGL_Review:IsReview()
  return true
end

function UIHauteCoutureGL_Review:HC_Type()
  return HauteCoutureType.HC_GL_Re
end

function UIHauteCoutureGL_Review:GetMainUIInfo()
  return "UIHauteCoutureDrawMainGL_Review.prefab", UIHauteCoutureDrawMainGL_Review
end

function UIHauteCoutureGL_Review:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgGL.prefab", UIHauteCoutureDrawBgGL
end

function UIHauteCoutureGL_Review:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainGL.prefab", UIHauteCoutureDrawGetItemMainGL
end

function UIHauteCoutureGL_Review:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainGL.prefab", UIHauteCoutureDrawChargeMainGL
end

function UIHauteCoutureGL_Review:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgGL.prefab", UIHauteCoutureDrawChargeBgGL
end

function UIHauteCoutureGL_Review:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainGL.prefab", UIHauteCoutureDrawRulesMainGL
end

function UIHauteCoutureGL_Review:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgGL.prefab", UIHauteCoutureDrawRulesBgGL
end

function UIHauteCoutureGL_Review:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainGL.prefab", UIHauteCoutureDrawVideoMainGL
end

function UIHauteCoutureGL_Review:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainGL.prefab", UIHauteCoutureDrawDynamicProbabilityMainGL
end

function UIHauteCoutureGL_Review:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgGL.prefab", UIHauteCoutureDrawDynamicProbabilityBgGL
end

function UIHauteCoutureGL_Review:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title2")
end

function UIHauteCoutureGL_Review:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgGL.prefab", UIHauteCoutureDuplicateRewardBgGL
end

function UIHauteCoutureGL_Review:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardGL.prefab", UIHauteCoutureDuplicateRewardGL
end
