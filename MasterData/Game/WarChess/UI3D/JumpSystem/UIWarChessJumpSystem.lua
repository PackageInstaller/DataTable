local base = UIBaseNode
local UIWarChessJumpSystem = class("UIWarChessJumpSystem", base)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local eGridToward = eWarChessEnum.eGridToward

function UIWarChessJumpSystem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_up, self, self.__OnClickJump, eGridToward.up)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_down, self, self.__OnClickJump, eGridToward.down)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_left, self, self.__OnClickJump, eGridToward.left)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_right, self, self.__OnClickJump, eGridToward.right)
  UIUtil.AddButtonListener(self.ui.btn_cancle, self, self.__OnClickCancle)
end

function UIWarChessJumpSystem:InitWCJumpSystem(jumpCtrl)
  self.__jumpCtrl = jumpCtrl
  local teamData = jumpCtrl:WCJumpGetTeamData()
  local teamIndex = teamData:GetWCTeamIndex()
  self.__heroEntity = jumpCtrl.wcCtrl.teamCtrl:GetWCHeroEntity(teamIndex, nil, nil)
  self:__UpdateUIPos()
end

function UIWarChessJumpSystem:__UpdateUIPos()
  if self.__heroEntity == nil then
    return
  end
  local showPos = self.__heroEntity:WCHeroEntityGetShowPos()
  local uiPos = Vector3.New(showPos.x, showPos.y + 1, showPos.z)
  self.ui.trans_jumpNode.position = uiPos
end

function UIWarChessJumpSystem:__OnClickJump(dir)
  self.__jumpCtrl:WCJumpSubSysJump(dir)
end

function UIWarChessJumpSystem:__OnClickCancle()
  self.__jumpCtrl:WCJumpSubSysCancle()
end

function UIWarChessJumpSystem:OnDelete()
  base.OnDelete(self)
end

return UIWarChessJumpSystem
