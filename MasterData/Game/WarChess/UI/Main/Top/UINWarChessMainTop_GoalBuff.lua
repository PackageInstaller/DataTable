local base = UIBaseNode
local UINWarChessMainTop_GoalBuff = class("UINWarChessMainTop_GoalBuff", UIBaseNode)
local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")

function UINWarChessMainTop_GoalBuff:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.goalNode, self, self._OnCliclGoalBuffNode)
  self._isOpen = true
end

function UINWarChessMainTop_GoalBuff:OnShow()
  self:RefreshWCGoalBuff()
end

function UINWarChessMainTop_GoalBuff:RefreshWCGoalBuff()
  if not WarChessSeasonManager:GetIsInWCSeason() then
    return
  end
  self.ui.goalBrief:SetActive(not self._isOpen)
  self.ui.goalAll:SetActive(self._isOpen)
  local wcSeasonManagerCtrl = WarChessSeasonManager:GetWCSCtrl()
  local roomData = wcSeasonManagerCtrl:WCSGetSurWCSRoomData()
  if not roomData or roomData.BuffId == nil or roomData.BuffId == 0 then
    self:Hide()
    return
  end
  local buffData = WarChessBuffData.CrearteBuffById(roomData.BuffId)
  local buffColorType = buffData:GetWCBuffColorType()
  if self._isOpen then
    self.ui.tex_DesSuccess.text = LanguageUtil.GetLocaleText(buffData.wcBuffCfg.name)
    self.ui.tex_DesSuccess.color = self.ui.color_buffs[buffColorType]
    self.ui.tex_DesFail.text = LanguageUtil.GetLocaleText(buffData.wcBuffCfg.description)
    self.ui.img_Buff.sprite = CRH:GetSprite(buffData.wcBuffCfg.icon, CommonAtlasType.ExplorationIcon)
    self.ui.trans_arrow.localEulerAngles = Vector3.New(0, 0, 180)
  else
    local goalStr = LanguageUtil.GetLocaleText(buffData.wcBuffCfg.name)
    self.ui.tex_Des.text = goalStr
    self.ui.trans_arrow.localEulerAngles = Vector3.zero
  end
end

function UINWarChessMainTop_GoalBuff:_OnCliclGoalBuffNode()
  self._isOpen = not self._isOpen
  self:RefreshWCGoalBuff()
end

function UINWarChessMainTop_GoalBuff:GetWCMTBuffLocationPos()
  return self.ui.location.position
end

function UINWarChessMainTop_GoalBuff:OnDelete()
end

return UINWarChessMainTop_GoalBuff
