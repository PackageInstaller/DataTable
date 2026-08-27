local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoMoney = class("UINWarChessInfoMoney", base)
local CS_DoTween = CS.DG.Tweening.DOTween

function UINWarChessInfoMoney:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoMoney:InitWCGetMoneyItem(itemId, itemNum)
  self.ui.tex_Count.text = tostring(itemNum)
  self.ui.icon.sprite = CRH:GetSpriteByItemId(itemId)
end

function UINWarChessInfoMoney:WCGetMoneyPlayTween()
  if self.sequence == nil then
    local sequence = CS_DoTween.Sequence():AppendCallback(function()
      self.ui.money.alpha = 1
    end):Append(self.transform:DOLocalMoveY(20, 0.3):SetRelative(true)):Join(self.ui.money:DOFade(0, 0.15):From()):Append(self.transform:DOLocalMoveY(20, 0.3):SetRelative(true):SetDelay(1)):Join(self.ui.money:DOFade(0, 0.15):SetDelay(0.15)):AppendCallback(function()
      self:Hide()
    end):SetAutoKill(false)
    self.sequence = sequence
  else
    self.sequence:Restart()
  end
end

function UINWarChessInfoMoney:OnDelete()
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  base.OnDelete(self)
end

return UINWarChessInfoMoney
