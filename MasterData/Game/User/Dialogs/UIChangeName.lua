local UIChangeName = class("UIChangeName", UIBaseNode)
local base = UIBaseNode
local CS_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UIChangeName:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.CloseFunction)
  local num = PlayerDataCenter:GetItemCount(ConfigData.game_config.changeNameItemId)
  num = num + PlayerDataCenter:GetItemCount(ConfigData.game_config.limitTimeChangeNameItemId)
  self.ui.tex_RenameCard.text = num
  local maxInputNum = ConfigData.game_config.playerNameLengthLimit
  self.characterLimit = maxInputNum
  self.ui.username_inputField.characterLimit = maxInputNum
  self.ui.tex_textTips_1:SetIndex(0, tostring(maxInputNum))
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnChangeNameConfirm)
end

function UIChangeName:OnChangeNameConfirm()
  local inputUserName = self.ui.username_inputField.text
  if string.IsNullOrEmpty(inputUserName) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.login_EmptyName))
    return
  end
  if inputUserName == PlayerDataCenter.inforData:GetUserName() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(176))
    return
  end
  local inputLength = RenameHelper:GetNameLength(inputUserName)
  if inputLength > self.characterLimit then
    inputUserName = RenameHelper:ClampNameInLength(inputUserName, self.characterLimit)
    self.ui.username_inputField.text = inputUserName
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    
    local function confimFunc()
      NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_UserNameModify(inputUserName, function()
        if not self.isFromStore then
          local infoUI = UIManager:GetWindow(UIWindowTypeID.UserInfo)
          if infoUI ~= nil then
            infoUI:RefreshPlayerInfo()
          end
        end
      end)
      self.CloseFunction()
    end
    
    win:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(175), inputUserName), confimFunc)
  end)
end

function UIChangeName:OnDelete()
  base.OnDelete(self)
end

return UIChangeName
