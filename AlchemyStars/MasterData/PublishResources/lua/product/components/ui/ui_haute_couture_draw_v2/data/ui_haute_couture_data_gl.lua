_class("UIHauteCoutureGL", UIHauteCoutureDataBase)
UIHauteCoutureGL = UIHauteCoutureGL

function UIHauteCoutureGL:Constructor()
end

function UIHauteCoutureGL:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinKR
end

function UIHauteCoutureGL:ShopGoodsOnClick()
end

function UIHauteCoutureGL:BuyItem()
end

function UIHauteCoutureGL:IsReview()
  return false
end

function UIHauteCoutureGL:HC_Type()
  return HauteCoutureType.HC_GL
end

function UIHauteCoutureGL:GetMainUIInfo()
end

function UIHauteCoutureGL:GetMainUIBgInfo()
end

function UIHauteCoutureGL:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title3")
end

function UIHauteCoutureGL:GetBgm()
  return CriAudioIDConst.BGMHauteCoutureGL
end
