local base = UIBaseNode
local UINWarChessMainTop_Goal = class("UINWarChessMainTop_Goal", UIBaseNode)
local UINWarChessMainTop_GoalBuff = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_GoalBuff")

function UINWarChessMainTop_Goal:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.goalNode, self, self._OnCliclGoalNode)
  self._isOpen = true
  self.BuffNode = UINWarChessMainTop_GoalBuff.New()
  self.BuffNode:Init(self.ui.obj_buffNode)
  self.BuffNode:Hide()
end

function UINWarChessMainTop_Goal:OnShow()
  if WarChessSeasonManager:GetIsInWCSeason() then
    self.BuffNode:Show()
  end
end

function UINWarChessMainTop_Goal:RefreshWCGoal()
  self.ui.goalBrief:SetActive(not self._isOpen)
  self.ui.goalAll:SetActive(self._isOpen)
  if self._isOpen then
    local wcLevelCfg = WarChessManager:GetWCLevelCfg()
    self.ui.tex_DesSuccess.text = LanguageUtil.GetLocaleText(wcLevelCfg.victory_long)
    self.ui.tex_DesFail.text = LanguageUtil.GetLocaleText(wcLevelCfg.fail_long)
    self.ui.trans_arrow.localEulerAngles = Vector3.New(0, 0, 180)
  else
    local goalStr = LanguageUtil.GetLocaleText(WarChessManager:GetWCLevelCfg().victory)
    self.ui.tex_Des.text = goalStr
    self.ui.trans_arrow.localEulerAngles = Vector3.zero
  end
end

function UINWarChessMainTop_Goal:_OnCliclGoalNode()
  self._isOpen = not self._isOpen
  self:RefreshWCGoal()
end

function UINWarChessMainTop_Goal:GetWCMTGoalBuffPos()
  return self.BuffNode:GetWCMTBuffLocationPos()
end

function UINWarChessMainTop_Goal:OnDelete()
end

return UINWarChessMainTop_Goal
