local typeof = _ENV.typeof
local TMP_Text = CS.TMPro.TMP_Text
local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local CardDisplayComponent, Super = System.NewComponent("CardDisplayComponent")

function CardDisplayComponent:ctor(...)
  Super.ctor(self, ...)
end

function CardDisplayComponent:SetCardDesc(desc)
  if not self.ui or IsNil(self.ui.Text_Desc) then
    return
  end
  self.binder:SetText(self.ui.Text_Desc, desc, false)
  self.binder:RemoveUnderline(self.ui.Text_Desc)
  FrameWaiter.RemoveWaiter(self.frameTicker)
  local prePos = self.ui.uiNode.transform.localPosition
  local farPos = CS.UnityEngine.Vector3(9999, 9999, 0)
  self.ui.uiNode.transform.localPosition = farPos
  self.frameTicker = FrameWaiter.OnNextFrame(function()
    self:CheckTextBottomAlign()
    local curPos = self.ui.uiNode.transform.localPosition
    if curPos ~= farPos then
      self.ui.uiNode.transform.localPosition = prePos
    end
  end, 0)
end

return CardDisplayComponent
