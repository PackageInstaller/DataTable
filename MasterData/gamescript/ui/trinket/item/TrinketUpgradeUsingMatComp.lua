local Button = CS.UnityEngine.UI.Button
local TrinketUpgradeUsingMatComp, Super = System.NewComponent("TrinketUpgradeUsingMatComp", CommonIconItem)

function TrinketUpgradeUsingMatComp:BindPress(binder)
  self.binder = binder
  self:_BindPressDown(binder)
end

function TrinketUpgradeUsingMatComp:IsCanLongPress()
  return false
end

function TrinketUpgradeUsingMatComp:_BindPressDown(binder)
  local btnObj = self.ui.Btn_Click:GetComponent(typeof(Button))
  if not btnObj then
    self.ui.Btn_Click:AddComponent(typeof(Button))
  end
  binder:BindButtonClick(self.ui.Btn_Click, function()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, self.uid.value, self.tid.value)
  end)
end

return TrinketUpgradeUsingMatComp
