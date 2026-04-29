_class("UIHauteCoutureGL_Review_Review", UIHauteCoutureDataBase)
UIHauteCoutureGL_Review_Review = UIHauteCoutureGL_Review_Review

function UIHauteCoutureGL_Review_Review:CostItemID()
  return 3000342
end

function UIHauteCoutureGL_Review_Review:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawV2ReviewController")
end

function UIHauteCoutureGL_Review_Review:BuyItem()
  Log.exception("BuyItem()方法必须重写：", debug.traceback())
end

function UIHauteCoutureGL_Review_Review:IsReview()
  return true
end

function UIHauteCoutureGL_Review_Review:HC_Type()
  return HauteCoutureType.HC_GL
end

function UIHauteCoutureGL_Review_Review:GetMainUIInfo()
  return "UIHauteCoutureDrawMainGL.prefab", UIHauteCoutureDrawMainGL
end

function UIHauteCoutureGL_Review_Review:GetMainUIBgInfo()
  return "UIHauteCoutureDrawBgGL.prefab", UIHauteCoutureDrawBgGL
end

function UIHauteCoutureGL_Review_Review:GetGetItemUIInfo()
  return "UIHauteCoutureDrawGetItemMainGL.prefab", UIHauteCoutureDrawGetItemMainGL
end

function UIHauteCoutureGL_Review_Review:GetChargeUIInfo()
  return "UIHauteCoutureDrawChargeMainGL.prefab", UIHauteCoutureDrawChargeMainGL
end

function UIHauteCoutureGL_Review_Review:GetChargeUIBgInfo()
  return "UIHauteCoutureDrawChargeBgGL.prefab", UIHauteCoutureDrawChargeBgGL
end

function UIHauteCoutureGL_Review_Review:GetRulesUIInfo()
  return "UIHauteCoutureDrawRulesMainGL.prefab", UIHauteCoutureDrawRulesMainGL
end

function UIHauteCoutureGL_Review_Review:GetRulesUIBgInfo()
  return "UIHauteCoutureDrawRulesBgGL.prefab", UIHauteCoutureDrawRulesBgGL
end

function UIHauteCoutureGL_Review_Review:GetVideoUIInfo()
  return "UIHauteCoutureDrawVideoMainGL.prefab", UIHauteCoutureDrawVideoMainGL
end

function UIHauteCoutureGL_Review_Review:GetDynamicProbablityUIInfo()
  return "UIHauteCoutureDrawDynamicProbabilityMainGL.prefab", UIHauteCoutureDrawDynamicProbabilityMainGL
end

function UIHauteCoutureGL_Review_Review:GetDynamicProbablityUIBgInfo()
  return "UIHauteCoutureDrawDynamicProbabilityBgGL.prefab", UIHauteCoutureDrawDynamicProbabilityBgGL
end

function UIHauteCoutureGL_Review_Review:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title2")
end

function UIHauteCoutureGL_Review_Review:Review_DuplicateRewardBgInfo()
  return "UIHauteCoutureDuplicateRewardBgGL.prefab", nil
end

function UIHauteCoutureGL_Review_Review:Review_DuplicateRewardUIInfo()
  return "UIHauteCoutureDuplicateRewardGL.prefab", UIHauteCoutureDuplicateRewardGL
end
