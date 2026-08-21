_class("UIHauteCoutureKR", UIHauteCoutureDataBase)
UIHauteCoutureKR = UIHauteCoutureKR

function UIHauteCoutureKR:Constructor()
end

function UIHauteCoutureKR:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinKR
end

function UIHauteCoutureKR:ShopGoodsOnClick()
end

function UIHauteCoutureKR:BuyItem()
end

function UIHauteCoutureKR:IsReview()
  return false
end

function UIHauteCoutureKR:HC_Type()
  return HauteCoutureType.HC_KR
end

function UIHauteCoutureKR:GetMainUIInfo()
end

function UIHauteCoutureKR:GetMainUIBgInfo()
end

function UIHauteCoutureKR:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title3")
end

function UIHauteCoutureKR:GetBgm()
  return CriAudioIDConst.BGMHauteCoutureKR
end
