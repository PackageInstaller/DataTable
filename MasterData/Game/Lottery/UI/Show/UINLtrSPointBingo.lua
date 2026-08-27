local UINLtrSPointBingo = class("UINLtrSPointBingo", UIBaseNode)
local base = UIBaseNode

function UINLtrSPointBingo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrSPointBingo:InitLtrSPointBingo(pos)
  self.transform.anchoredPosition = pos
  self.ui.anim:Rewind()
  self.ui.anim:Play("UI_LSPointBingo_Enter")
  AudioManager:PlayAudioById(1051)
end

function UINLtrSPointBingo:PlayLtrSPointBingoExit()
  AudioManager:PlayAudioById(1052)
  self.ui.anim:Play("UI_LSPointBingo_Exit")
end

function UINLtrSPointBingo:OnDelete()
  base.OnDelete(self)
end

return UINLtrSPointBingo
