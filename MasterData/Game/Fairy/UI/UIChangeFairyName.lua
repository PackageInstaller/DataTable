local UIChangeFairyName = class("UIChangeFairyName", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UIChangeFairyName:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self.CloseWindow)
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.CloseWindow)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirmNewFairyName)
  UIUtil.SetTopStatus(self, self.BackAction)
  self.nameLengthLimit = ConfigData.game_config.fairyNameLengthLimit
end

function UIChangeFairyName:InitChangeFairyName(fairyData)
  UIUtil.HideTopStatus()
  self.fairyData = fairyData
  local oldName = fairyData:GetFairyCurName()
  self.ui.tex_FairyName.text = string.format(ConfigData:GetTipContent(22010), oldName)
end

function UIChangeFairyName:OnClickConfirmNewFairyName()
  local newName = self:GetInputText()
  local islegalName, errorTipsId = self:IslegalName(newName)
  if not islegalName and errorTipsId ~= nil then
    local text = ConfigData:GetTipContent(errorTipsId)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(text)
    if errorTipsId == TipContent.FairyNameTooLong then
      local inputUserName = RenameHelper:ClampNameInLength(newName, self.nameLengthLimit)
      self.ui.input_newName.text = inputUserName
    end
    return
  end
  local fairyNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Fairy)
  fairyNetCtrl:CS_Fairy_ModifyName(self.fairyData:GetFairyUID(), newName, function()
    self:CloseWindow()
  end)
end

function UIChangeFairyName:GetInputText()
  return self.ui.input_newName.text
end

function UIChangeFairyName:IslegalName(newFairyName)
  if string.IsNullOrEmpty(newFairyName) then
    return false, TipContent.login_EmptyName
  end
  if newFairyName == PlayerDataCenter.inforData:GetUserName() then
    return false, TipContent.NameNotChange
  end
  local inputLength = RenameHelper:GetNameLength(newFairyName)
  if inputLength > self.nameLengthLimit then
    return false, TipContent.FairyNameTooLong
  end
end

function UIChangeFairyName:BackAction()
  self:OnCloseWin()
  self:Delete()
end

function UIChangeFairyName:CloseWindow()
  UIUtil.OnClickBackByUiTab(self)
end

function UIChangeFairyName:OnDelete()
  UIUtil.ReShowTopStatus()
  base.OnDelete(self)
end

return UIChangeFairyName
