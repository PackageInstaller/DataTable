local UICommonRename = class("UICommonRename", UIBaseWindow)
local base = UIBaseWindow
local CS_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UICommonRename:OnInit()
  UIUtil.AddButtonListener(self.ui.buttonNo, self, self.OnBtnNoClicked)
  UIUtil.AddButtonListener(self.ui.buttonYes, self, self.OnBtnYesClicked)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.characterLimit = self.ui.input_Name.characterLimit
end

function UICommonRename:InitCommonRename(yesAction, cancelAction)
  self.__yesAction = yesAction
  self.__cancelAction = cancelAction
end

function UICommonRename:InitRenameUIArg()
end

function UICommonRename:OnBtnYesClicked()
  local inputName = self.ui.input_Name.text
  if string.IsNullOrEmpty(inputName) then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(53))
    return
  end
  local inputLength = RenameHelper:GetNameLength(inputName)
  if inputLength > self.characterLimit then
    inputName = RenameHelper:ClampNameInLength(inputName, self.characterLimit)
    self.ui.input_Name.text = inputName
    return
  end
  if self.__yesAction ~= nil then
    self.__yesAction(inputName)
  end
end

function UICommonRename:OnBtnNoClicked()
  if self.__cancelAction ~= nil then
    local cancelAction = self.__cancelAction
    self.__cancelAction = nil
    cancelAction()
  end
  UIUtil.PopFromBackStackByUiTab(self)
  self:Delete()
end

function UICommonRename:_BackAction()
  if self.__cancelAction ~= nil then
    local cancelAction = self.__cancelAction
    self.__cancelAction = nil
    cancelAction()
  end
  self:Delete()
end

function UICommonRename:OnDelete()
  base.OnDelete(self)
end

return UICommonRename
