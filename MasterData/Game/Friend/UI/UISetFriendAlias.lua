local UISetFriendAlias = class("UISetFriendAlias", UIBaseWindow)
local base = UIBaseWindow
local CS_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UISetFriendAlias:OnInit()
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self._OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self._OnClickCancle)
end

function UISetFriendAlias:InitSetFriendAlias(userInfoData)
  self.userInfoData = userInfoData
  if userInfoData == nil then
    self:_OnClickCancle()
    return
  end
  local friendRealName = userInfoData:GetUserName()
  self.ui.text_textTips:SetIndex(0, friendRealName)
  local maxInputNum = ConfigData.game_config.friendSetAliasLimit
  self.characterLimit = maxInputNum
  self.ui.inputField.characterLimit = maxInputNum
  self.ui.text_textTips2:SetIndex(0, tostring(maxInputNum))
  if userInfoData:GetIsHaveAlias() then
    self.ui.inputField.text = userInfoData:GetAlias()
  end
end

function UISetFriendAlias:_BackAction()
  self:Delete()
end

function UISetFriendAlias:_OnClickCancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UISetFriendAlias:_OnClickConfirm()
  local inputUserName = self.ui.inputField.text
  if inputUserName == nil then
    return
  end
  local inputLength = RenameHelper:GetNameLength(inputUserName)
  if inputLength > self.characterLimit then
    inputUserName = RenameHelper:ClampNameInLength(inputUserName, self.characterLimit)
    self.ui.inputField.text = inputUserName
    return
  end
  self.friendNetworkCtrl:CS_FRIEND_Alias(self.userInfoData:GetUserUID(), inputUserName, function()
    self.userInfoData:SetAlias(inputUserName)
    self:_OnClickCancle()
    PlayerDataCenter.friendDataCenter:UpdateFriendUI()
    PlayerDataCenter.friendDataCenter:BroadCastFriendListChange()
  end)
end

function UISetFriendAlias:OnDelete()
  base.OnDelete(self)
end

return UISetFriendAlias
