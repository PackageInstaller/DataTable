local cs_ResLoader = CS.ResLoader
local UIFightUserHeadNode = require("Game.Fight.Ui.UIFightUserHeadNode")
local UIFightStart = class("UIFightStart", UIBaseWindow)

function UIFightStart:OnInit()
  self._resLoader = cs_ResLoader.Create()
  self._leftHead = UIFightUserHeadNode.New()
  self._leftHead:Init(self.ui.leftHead, self._resLoader)
  self._rightHead = UIFightUserHeadNode.New()
  self._rightHead:Init(self.ui.rightHead, self._resLoader)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnStartBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnBtnClick)
end

function UIFightStart:Refresh(myUserInfo, opUserInfo)
  if myUserInfo ~= nil then
    self.ui.txt_LeftName.text = myUserInfo:GetUserName()
    self._leftHead:RefreshUserHead(myUserInfo:GetAvatarId())
    self._leftHead:RefreshUserHeadFrame(myUserInfo:GetAvatarFrameId())
  end
  if opUserInfo ~= nil then
    self.ui.txt_RightName.text = opUserInfo:GetUserName()
    self._rightHead:RefreshUserHead(opUserInfo:GetAvatarId())
    self._rightHead:RefreshUserHeadFrame(opUserInfo:GetAvatarFrameId())
  end
end

function UIFightStart:OnStartBtnClick()
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:StartFight()
  self:Delete()
end

function UIFightStart:OnReturnBtnClick()
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:ExitScene()
end

function UIFightStart:OnDelete()
  UIBaseWindow.OnDelete(self)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UIFightStart
