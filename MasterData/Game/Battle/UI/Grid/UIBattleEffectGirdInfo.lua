local UIBattleEffectGirdInfo = class("UIBattleEffectGirdInfo", UIBaseWindow)
local base = UIBaseWindow
local UINBattleGirdInfoNode = require("Game.Battle.UI.Grid.UINBattleGirdInfoNode")

function UIBattleEffectGirdInfo:OnInit()
  self.battleGirdInfoNode = UINBattleGirdInfoNode.New()
  self.battleGirdInfoNode:Init(self.ui.battleGirdInfoNode)
  self.gridInfoSizeDelta = self.battleGirdInfoNode.transform.sizeDelta
  self.gridInfoSizeDelta.y = 0
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  CS.Lean.Touch.LeanTouch.OnFingerDown("+", self.__onFingerDown)
end

function UIBattleEffectGirdInfo:InitBattleGridInfo(dynEffectGrid, worldPos)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  local position = UIManager:World2UIPosition(worldPos)
  local offsetRatio
  if position.x <= 0 and 0 <= position.y then
    offsetRatio = Vector2.New(1, -1)
  elseif position.x <= 0 and 0 >= position.y then
    offsetRatio = Vector2.New(1, 1)
  elseif position.x >= 0 and 0 >= position.y then
    offsetRatio = Vector2.New(-1, 1)
  else
    offsetRatio = Vector2.New(-1, -1)
  end
  local arrowOffset = (self.gridInfoSizeDelta / 2 + self.ui.gridInfoOffset) * offsetRatio + position
  self.battleGirdInfoNode.transform.localPosition = Vector3.New(arrowOffset.x, arrowOffset.y, 0)
  self.battleGirdInfoNode:InitBattleGridInfo(dynEffectGrid)
end

function UIBattleEffectGirdInfo:BackAction()
  self:Hide()
end

function UIBattleEffectGirdInfo:OnFingerDown()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBattleEffectGirdInfo:OnDelete()
  CS.Lean.Touch.LeanTouch.OnFingerDown("-", self.__onFingerDown)
  base.OnDelete(self)
end

return UIBattleEffectGirdInfo
