local UINWin21SetLvTexItem = class("UINWin21SetLvTexItem", UIBaseNode)
local base = UIBaseNode

function UINWin21SetLvTexItem:ctor(win)
  self.win = win
end

function UINWin21SetLvTexItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.bgSize = UIManager.BackgroundStretchSize
end

function UINWin21SetLvTexItem:InitWin21SetLvTexItem(cs_DoTween, cs_Ease)
  local showSeq = cs_DoTween.Sequence()
  showSeq:Append(self.ui.rect_Image:DOLocalMove(Vector3.New(-232, -169, 0), 0.33):SetEase(cs_Ease.OutCirc):From())
  showSeq:Join(self.ui.fade_Image:DOFade(0, 0.1):SetLoops(4):From())
  showSeq:SetAutoKill(false)
  showSeq:Pause()
  self.showSeq = showSeq
  local hlightSeq = cs_DoTween.Sequence()
  hlightSeq:Append(self.transform:DOLocalMoveY(16, 1):SetRelative(true))
  hlightSeq:Pause()
  hlightSeq:SetAutoKill(false)
  self.hlightSeq = hlightSeq
end

function UINWin21SetLvTexItem:PlayShowTween()
  self.isShow = true
  self.showSeq:Restart()
end

function UINWin21SetLvTexItem:RewindShowTween()
  self.isShow = false
  self.showSeq:Rewind()
end

function UINWin21SetLvTexItem:PlayHighlightTween()
  self.hlightSeq:Restart()
end

function UINWin21SetLvTexItem:OnMapGesture()
  self.screenPos = UIManager.UICamera:WorldToScreenPoint(self.transform.position)
  local maxX = self.screenPos.x > self.bgSize.x
  local minX = self.screenPos.x < 0
  local maxY = self.screenPos.y > self.bgSize.y
  local minY = self.screenPos.x < 0
  if maxX or minX or maxY or minY then
    self:RewindShowTween()
    return
  end
  if not self.isShow and not self.showSeq.isPlaying then
    self:PlayShowTween()
  end
end

function UINWin21SetLvTexItem:OnDelete()
  self.showSeq:Kill()
  self.showSeq = nil
  self.hlightSeq:Kill()
  self.hlightSeq = nil
  base.OnDelete(self)
end

return UINWin21SetLvTexItem
