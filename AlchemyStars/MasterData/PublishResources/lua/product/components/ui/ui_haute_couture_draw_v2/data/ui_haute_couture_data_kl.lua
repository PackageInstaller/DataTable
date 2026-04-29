_class("UIHauteCoutureKL", UIHauteCoutureDataBase)
UIHauteCoutureKL = UIHauteCoutureKL

function UIHauteCoutureKL:Constructor()
end

function UIHauteCoutureKL:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkin
end

function UIHauteCoutureKL:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawController")
end

function UIHauteCoutureKL:BuyItem()
end

function UIHauteCoutureKL:IsReview()
  return false
end

function UIHauteCoutureKL:HC_Type()
  return HauteCoutureType.HC_KL
end

function UIHauteCoutureKL:GetMainUIInfo()
end

function UIHauteCoutureKL:GetMainUIBgInfo()
end

function UIHauteCoutureKL:SideEnterText()
end
