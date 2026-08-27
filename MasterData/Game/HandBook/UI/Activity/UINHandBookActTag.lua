local UINHandBookActTag = class("UINHandBookActTag", UIBaseNode)
local base = UIBaseNode
local CS_DOTween = CS.DG.Tweening.DOTween

function UINHandBookActTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ActItem, self, self.OnClickActTag)
end

function UINHandBookActTag:InitHandBookActTag(name, callback)
  self.ui.tex_ActName.text = name
  self._callback = callback
end

function UINHandBookActTag:PlayBookTagAni(delayTime)
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
  self._tween = CS_DOTween.Sequence()
  self._tween:AppendInterval(delayTime)
  self._tween:AppendCallback(function()
    self.ui.ani_ActItem:Play()
  end)
end

function UINHandBookActTag:OnClickActTag()
  if self._callback ~= nil then
    self._callback()
  end
end

function UINHandBookActTag:OnDelete()
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
  base.OnDelete(self)
end

return UINHandBookActTag
