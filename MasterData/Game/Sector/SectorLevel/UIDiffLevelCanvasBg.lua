local UIDiffLevelCanvasBg = class("UIDiffLevelCanvasBg", UIBaseNode)
local base = UIBaseNode
local cs_DOTween = CS.DG.Tweening.DOTween
local cs_DOTweenEase = CS.DG.Tweening.Ease

function UIDiffLevelCanvasBg:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.aniTime = 0.5
end

function UIDiffLevelCanvasBg:SetCanvasBgParent(parent, sizeDelta)
  self.transform:SetParent(parent)
  if sizeDelta ~= nil then
    self.transform.sizeDelta = sizeDelta
  end
end

function UIDiffLevelCanvasBg:PlayBgAnima(duration)
  if self.backgroundTween == nil then
    local sequence = cs_DOTween.Sequence()
    sequence:AppendInterval(duration or 0)
    sequence:Append(self.ui.img_middle:DOLocalMove(self.ui.v3_middle, self.aniTime))
    sequence:Join(self.ui.img_back:DOLocalMove(self.ui.v3_back, self.aniTime))
    self.backgroundTween = sequence
  else
    self.backgroundTween:Restart()
  end
end

function UIDiffLevelCanvasBg:OnDelete()
  if self.backgroundTween ~= nil then
    self.backgroundTween:Kill()
    self.backgroundTween = nil
  end
  base.OnDelete(self)
end

return UIDiffLevelCanvasBg
