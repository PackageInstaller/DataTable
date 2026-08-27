local UINEpChipSuitDescItem = class("UINEpChipSuitDescItem", UIBaseNode)
local base = UIBaseNode
local cs_TweenLoopType = CS.DG.Tweening.LoopType

function UINEpChipSuitDescItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEpChipSuitDescItem:InitSuitDescItem(number, active, info, activeColor, lockColor)
  self.ui.tex_Count.text = tostring(number)
  self.ui.tex_Desc.text = tostring(info)
  if active then
    if activeColor ~= nil then
      self.ui.tex_Desc.color = activeColor
    else
      self.ui.tex_Desc.color = Color.white
    end
    self.ui.img_Count.color = self.ui.color_active
    self.ui.tex_Count.color = Color.white
  else
    if lockColor ~= nil then
      self.ui.tex_Desc.color = lockColor
    else
      self.ui.tex_Desc.color = self.ui.color_deactive
    end
    self.ui.img_Count.color = self.ui.color_deactive
    self.ui.tex_Count.color = self.ui.color_fontdeactive
  end
  if not IsNull(self.ui.canvasGroup) then
    self.ui.canvasGroup:DOKill(true)
  end
end

function UINEpChipSuitDescItem:TweenEpChipSuitDescItem()
  self.ui.canvasGroup:DOKill(true)
  self.ui.canvasGroup.alpha = 1
  local t = Time.time % 1.4
  self.ui.canvasGroup:DOFade(0.5, 0.7):From():SetLoops(-1, cs_TweenLoopType.Yoyo):SetLink(self.gameObject):Goto(t, true)
end

function UINEpChipSuitDescItem:OnDelete()
  base.OnDelete(self)
end

return UINEpChipSuitDescItem
