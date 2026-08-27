local UIFloatTextItem = class("UIFloatTextItem", UIBaseNode)
local base = UIBaseNode

function UIFloatTextItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__OnTweenComplete = BindCallback(self, self.OnTweenComplete)
  self.tween = self.transform:DOLocalMove(Vector3.zero, self.ui.stayTime):OnComplete(self.__OnTweenComplete):Pause():SetAutoKill(false)
end

function UIFloatTextItem:InitFloatTextItem(position, textContent, color, recoveryEvent)
  self.recoveryEvent = recoveryEvent
  self.transform.localPosition = position
  self.ui.text.text = textContent
  color = color == nil and self.ui.defaultColor
  self.ui.text.color = color
  local targetPos = self.transform.localPosition + Vector3.up * 100
  self.tween:ChangeEndValue(targetPos):Restart()
end

function UIFloatTextItem:OnTweenComplete()
  if self.recoveryEvent ~= nil then
    self.recoveryEvent(self)
  end
end

function UIFloatTextItem:OnDelete()
  if self.tween ~= nil then
    self.tween:Kill()
  end
  base.OnDelete(self)
end

return UIFloatTextItem
