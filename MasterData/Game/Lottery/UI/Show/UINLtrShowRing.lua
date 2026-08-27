local UINLtrShowRing = class("UINLtrShowRing", UIBaseNode)
local base = UIBaseNode

function UINLtrShowRing:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrShowRing:InitLtrShowRing(pos, color)
  self:__ClearFadeTween()
  self.transform.anchoredPosition = pos
  self.transform.sizeDelta = Vector2.zero
  self.ui.img.color = color
end

function UINLtrShowRing:SetLtrShowRingSize(sizeDelta)
  self.transform.sizeDelta = sizeDelta
end

function UINLtrShowRing:LtrShowRingFade()
  if self.fadeTween ~= nil then
    return
  end
  self.fadeTween = self.ui.img:DOFade(0, 1):OnComplete(function()
    self:__ClearFadeTween()
  end)
end

function UINLtrShowRing:__ClearFadeTween()
  if self.fadeTween ~= nil then
    self.fadeTween:Kill()
    self.fadeTween = nil
  end
end

function UINLtrShowRing:OnDelete()
  self:__ClearFadeTween()
  base.OnDelete(self)
end

return UINLtrShowRing
