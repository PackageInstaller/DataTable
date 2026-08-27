local ShieldDuration = 2
local cs_ResLoader = CS.ResLoader
local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightUserHeadNode = require("Game.Fight.Ui.UIFightUserHeadNode")
local UIFightResult = class("UIFightResult", UIBaseWindow)

function UIFightResult:OnInit()
  self._resLoader = cs_ResLoader.Create()
  self._closeTime = 0
  self._headNode = UIFightUserHeadNode.New()
  self._headNode:Init(self.ui.head, self._resLoader)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnBtnClick)
end

function UIFightResult:SetResult(userInfo, resultType)
  if userInfo == nil then
    return
  end
  self._closeTime = Time.realtimeSinceStartup + ShieldDuration
  self._headNode:RefreshUserHead(userInfo:GetAvatarId())
  self._headNode:RefreshUserHeadFrame(userInfo:GetAvatarFrameId())
  self.ui.txt_UserName.text = userInfo:GetUserName()
  self.ui.img_ResultIcon:SetIndex(resultType - 1)
  self.ui.txt_Result:SetIndex(resultType - 1)
end

function UIFightResult:OnReturnBtnClick()
  if Time.realtimeSinceStartup <= self._closeTime then
    return
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:ExitScene()
end

function UIFightResult:OnDelete()
  UIBaseWindow.OnDelete(self)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UIFightResult
