local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}

function Order:OnStart(ca)
  local pos = {x = 0, y = 0}
  if ca.uiType == "ESC" then
    local View = require("UIESC/UIESCView")
    local DataModel = require("UIESC/UIESCDataModel")
    local index = 0
    for k, v in ipairs(DataModel.FuncShowList) do
      if v.funcId == ca.funcId then
        index = k
        break
      end
    end
    if View.NewScrollGrid_BtnList and View.NewScrollGrid_BtnList.self.IsActive and 0 < index then
      View.NewScrollGrid_BtnList.grid.self:MoveToPos(index)
      local tran = View.NewScrollGrid_BtnList.grid.self:GetChildByIndex(index - 1)
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

function Order:IsFinish()
  return true
end

return Order
