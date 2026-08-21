_class("UIHauteCoutureKL_Review", UIHauteCoutureDataBase)
UIHauteCoutureKL_Review = UIHauteCoutureKL_Review

function UIHauteCoutureKL_Review:CostItemID()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinKL_Re
end

function UIHauteCoutureKL_Review:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDraw_Review")
end

function UIHauteCoutureKL_Review:BuyItem()
end

function UIHauteCoutureKL_Review:IsReview()
  return true
end

function UIHauteCoutureKL_Review:HC_Type()
  Log.exception("HC_Type()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKL_Review:GetMainUIInfo()
  Log.exception("GetMainUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKL_Review:GetMainUIBgInfo()
  Log.exception("GetMainUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKL_Review:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title")
end
