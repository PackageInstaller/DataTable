local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightSceneUiItem = class("UIFightSceneUiItem", UIBaseNode)

function UIFightSceneUiItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIFightSceneUiItem:SetPosition(position)
  if IsNull(self.transform) then
    return
  end
  self.transform.position = position
end

function UIFightSceneUiItem:GetSceneUiType()
  return DormFightConst.SceneUiType.Undefined
end

return UIFightSceneUiItem
