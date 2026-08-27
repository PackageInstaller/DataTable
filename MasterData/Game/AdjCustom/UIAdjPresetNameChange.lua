local UIAdjPresetNameChange = class("UIAdjPresetNameChange", UIBaseWindow)
local base = UIBaseWindow
local CS_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UIAdjPresetNameChange:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickCancle)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickCancle)
  self.characterLimit = self.ui.inputField.characterLimit
end

function UIAdjPresetNameChange:InitAdjPresetNameChange(defaultContent, confirmFunc)
  self._defaultContent = defaultContent
  self._confirmFunc = confirmFunc
  self.ui.tex_Tips:SetIndex(0, self._defaultContent)
  self.ui.tex_textTips:SetIndex(0, tostring(self.characterLimit))
end

function UIAdjPresetNameChange:OnClickConfirm()
  if self._confirmFunc == nil then
    return
  end
  local content = self.ui.inputField.text
  if string.IsNullOrEmpty(content) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(53))
    return
  end
  if content == self._defaultContent then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(176))
    return
  end
  local inputLength = RenameHelper:GetNameLength(content)
  if inputLength > self.characterLimit then
    content = RenameHelper:ClampNameInLength(content, self.characterLimit)
    self.ui.inputField.text = content
    return
  end
  self._confirmFunc(content)
  self:Delete()
end

function UIAdjPresetNameChange:OnClickCancle()
  self:Delete()
end

return UIAdjPresetNameChange
