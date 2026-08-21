_class("UISuperChainSkill", UIController)
UISuperChainSkill = UISuperChainSkill

function UISuperChainSkill:OnShow(uiParams)
  local screenPos = table.unpack(uiParams)
  local uiCamera = GameGlobal.UIStateManager():GetControllerCamera("UISuperChainSkill")
  local worldPos = uiCamera:ScreenToWorldPoint(screenPos)
  worldPos.z = 0
  local go = self:GetGameObject("CenterAnchor")
  go.transform.position = worldPos
end
