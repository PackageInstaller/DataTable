local UIClickContinue = class("UIClickContinue", UIBaseWindow)
local base = UIBaseWindow

function UIClickContinue:OnInit()
  UIUtil.AddButtonListener(self.ui.bgButton, self, self.OnClickBg)
end

function UIClickContinue:InitContinue(clickEvent, showText, textIndex, bgColor, clickClose)
  textIndex = textIndex == nil and 0
  showText = showText or false
  self.clickEvent = clickEvent
  self.ui.text.gameObject:SetActive(showText)
  if showText then
    self.ui.text:SetIndex(textIndex)
  end
  self.ui.bgImage.color = bgColor or Color.clear
  if clickClose == nil then
    self.clickClose = true
  else
    self.clickClose = clickClose
  end
end

function UIClickContinue:OnClickBg()
  if self.clickEvent ~= nil then
    self.clickEvent()
  end
  if self.clickClose then
    self:Delete()
  end
end

function UIClickContinue:OnDelete()
  base.OnDelete(self)
end

return UIClickContinue
