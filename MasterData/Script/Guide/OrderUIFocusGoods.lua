local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local module = {}

function module:OnStart(ca)
  local pos = {x = 0, y = 0}
  if ca.uiType == "HomeTrade" then
    local View = require("UIHomeTrade/UIHomeTradeView")
    local DataModel = require("UIHomeTrade/UITradeDataModel")
    local index = 0
    local curGoodsTable
    if DataModel.CurTradeType == DataModel.TradeType.Buy then
      curGoodsTable = DataModel.CurSellList
    else
      curGoodsTable = DataModel.CurAcquisitionList
    end
    for k, v in ipairs(curGoodsTable) do
      if ca.goodsId == v.goodsId then
        index = k
        break
      end
    end
    if View.Group_Trade and View.Group_Trade.self.IsActive and 0 < index then
      local scroll
      if DataModel.CurTradeType == DataModel.TradeType.Buy then
        scroll = View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL
      else
        scroll = View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL
      end
      scroll.grid.self:MoveToPos(index)
      local tran = scroll.grid.self:GetChildByIndex(index - 1)
      pos = tran.position
    end
  end
  UIGuidanceController.ActiveUIGuide()
  pos = UIGuidanceController.GetLocalPos(pos)
  UIGuidanceController.SetFocus(pos.x, pos.y, ca.w, ca.h, 0, 0)
  UIGuidanceController.PosOffset(ca.offsetX, ca.offsetY)
  UIGuidanceController.ShowFinger(ca.isShowFinger)
  UIGuidanceController.SetBgAlpha(ca.alpha)
end

function module:IsFinish()
  return true
end

return module
