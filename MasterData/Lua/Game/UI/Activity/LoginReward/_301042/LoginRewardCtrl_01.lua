local LoginRewardCtrl_01 = class("LoginRewardCtrl_01", BaseCtrl)
LoginRewardCtrl_01._mapNodeConfig = {
  goCommon = {
    sNodeName = "---Common---"
  }
}
LoginRewardCtrl_01._mapEventConfig = {}

function LoginRewardCtrl_01:UnbindCtrl()
  if self.activityCtrl ~= nil then
    self:UnbindCtrlByNode(self.activityCtrl)
    self.activityCtrl = nil
  end
end

function LoginRewardCtrl_01:InitActData(actData)
  if self.activityCtrl == nil then
    self.activityCtrl = self:BindCtrlByNode(self._mapNode.goCommon, "Game.UI.Activity.LoginReward.LoginRewardCtrl_List")
  end
  self.actData = actData
  self.nActId = actData:GetActId()
  self.activityCtrl:InitActData(actData)
end

function LoginRewardCtrl_01:ClearActivity()
  self:UnbindCtrl()
end

function LoginRewardCtrl_01:OnDisable()
  self:UnbindCtrl()
end

return LoginRewardCtrl_01
