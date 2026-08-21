_class("UIHauteCoutureKL_Review2", UIHauteCoutureDataBase)
UIHauteCoutureKL_Review2 = UIHauteCoutureKL_Review2

function UIHauteCoutureKL_Review2:CostItemID()
  return 3000365
end

function UIHauteCoutureKL_Review2:ShopGoodsOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawControllerKLReview2")
end

function UIHauteCoutureKL_Review2:BuyItem()
end

function UIHauteCoutureKL_Review2:IsReview()
  return true
end

function UIHauteCoutureKL_Review2:HC_Type()
  Log.exception("HC_Type()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKL_Review2:GetMainUIInfo()
  Log.exception("GetMainUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKL_Review2:GetMainUIBgInfo()
  Log.exception("GetMainUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureKL_Review2:SideEnterText()
  return StringTable.Get("str_senior_skin_draw_lobby_enter_title")
end
