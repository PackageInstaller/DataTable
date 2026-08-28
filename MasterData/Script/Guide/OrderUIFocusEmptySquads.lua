local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local module = {}

function module:OnStart(ca)
  local DataModel = require("UISquads/UISquadsDataModel")
  local squadIndex = DataModel.curSquadIndex or 1
  local curSquadInfo = PlayerData.ServerData.squad[squadIndex]
  local index = -1
  for k, v in pairs(curSquadInfo.role_list) do
    if v == "" or next(v) == nil then
      index = k
      break
    end
  end
  if 0 < index then
    local View = require("UISquads/UISquadsView")
    local tran = View.StaticGrid_List.grid.self:GetChildByIndex(index - 1)
    local pos = tran.position
    UIGuidanceController.ActiveUIGuide()
    pos = UIGuidanceController.GetLocalPos(pos)
    UIGuidanceController.SetFocus(pos.x, pos.y, ca.w, ca.h, 0, 0)
    UIGuidanceController.PosOffset(ca.offsetX, ca.offsetY)
    UIGuidanceController.ShowFinger(ca.isShowFinger)
    UIGuidanceController.SetBgAlpha(ca.alpha)
  end
end

function module:IsFinish()
  return true
end

return module
