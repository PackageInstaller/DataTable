local UINActSummerLvSwitchBtn = class("UINActSummerLvSwitchBtn", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween

function UINActSummerLvSwitchBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSummerLv)
end

function UINActSummerLvSwitchBtn:InitSummerLvBtn(diffIdx, callback)
  self.index = diffIdx
  self.callback = callback
  self:_InitUI(diffIdx)
  self:_InitTweenByDiffIdx(diffIdx)
  self:SetSummerLvState(false)
end

function UINActSummerLvSwitchBtn:SetSummerLvState(flag)
  if flag == self._flag then
    return
  end
  self._flag = flag
  local index = (self.index - 1) * 2 + (flag and 0 or 1)
  self.ui.img_Buttom:SetIndex(index)
  self.ui.img_Select.image.enabled = flag
  self.ui.img_Bar.fillAmount = flag and 1 or 0
  local texCol = flag and Color.white or self.ui.col_texBlack
  self.ui.tex_Name.text.color = texCol
  self.ui.tex_NameEn.text.color = texCol
  self:_PlayTweenByFlag(flag)
end

function UINActSummerLvSwitchBtn:_InitUI(diffIdx)
  local index = diffIdx - 1
  self.ui.tex_Name:SetIndex(index)
  self.ui.tex_NameEn:SetIndex(index)
  self.ui.img_Select:SetIndex(index)
  local col = index == 0 and self.ui.col_simple or self.ui.col_Hard
  self.ui.img_Bar.color = col
end

function UINActSummerLvSwitchBtn:_InitTweenByDiffIdx(diffIdx)
  if self._seq ~= nil then
    self._seq:Kill()
    self._seq = nil
  end
  local seq = cs_DoTween.Sequence()
  seq:Append(self.ui.img_Bar:DOFillAmount(1, 0.25))
  if diffIdx == 1 then
    seq:Join(self.ui.img_Select.image:DOFillAmount(0, 0.5):From())
  else
    seq:Join(self.ui.img_Select.image:DOFade(0, 0.25):From())
  end
  seq:SetAutoKill(false)
  self._seq = seq
end

function UINActSummerLvSwitchBtn:_PlayTweenByFlag(flag)
  if self._seq == nil then
    self:_InitTweenByDiffIdx(self.index)
  end
  if flag then
    self._seq:Restart()
  else
    self._seq:Pause()
    self._seq:Rewind()
  end
end

function UINActSummerLvSwitchBtn:OnClickSummerLv()
  if self.callback ~= nil then
    self.callback(self.index)
  end
end

function UINActSummerLvSwitchBtn:OnDelete()
  if self._seq ~= nil then
    self._seq:Kill()
    self._seq = nil
  end
  base.OnDelete(self)
end

return UINActSummerLvSwitchBtn
