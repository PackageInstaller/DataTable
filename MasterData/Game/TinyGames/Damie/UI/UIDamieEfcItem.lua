local UIDamieEfcItem = class("UIDamieEfcItem", UIBaseNode)
local base = UIBaseNode
local cs_Tweening = CS.DG.Tweening
local cs_DoTween = cs_Tweening.DOTween
local cs_DoTweenLoopType = cs_Tweening.LoopType

function UIDamieEfcItem:OnShow()
  base.OnShow(self)
  if self.hideTimer ~= nil then
    TimerManager:StopTimer(self.hideTimer)
    self.hideTimer = nil
  end
  self.ui.obj_Punch:SetActive(true)
end

function UIDamieEfcItem:Active()
  self.hideTimer = TimerManager:StartTimer(0.4, BindCallback(self, self.__HidePunch), nil, true, false, true)
end

function UIDamieEfcItem:__HidePunch()
  self.ui.obj_Punch:SetActive(false)
  self.ui.imag_PunchEfc.transform.localScale = Vector3.zero
  self.ui.img_GetScore:SetActive(false)
end

function UIDamieEfcItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tex_GetScore:SetIndex(1)
end

function UIDamieEfcItem:UpdateScore(score, id)
  self.ui.img_GetScore:SetActive(true)
  self.ui.tex_GetScore:SetIndex(0, tostring(score))
  AudioManager:PlayAudioById(1213)
  if self:IsPair(id) and self.shakeSeq ~= nil then
    if self.dataId == 18 then
      if self.shakeSeq:IsComplete() then
        self.shakeSeq:Rewind()
        self:UpdatePunch()
        return
      end
    else
      self.shakeSeq:Pause()
      self.ui.obj_Punch.transform:SetLocalScale(1, 1, 1)
      self.ui.img_Punch:SetLocalScale(1, 1, 1)
      self.ui.imag_PunchEfc.transform:SetLocalScale(0, 0, 0)
      self.shakeSeq:Rewind()
    end
  end
  if self.shakeSeq ~= nil then
    self.shakeSeq:Kill()
    self.shakeSeq = nil
  end
  self.ui.obj_Punch.transform:SetLocalScale(1, 1, 1)
  self.ui.img_Punch:SetLocalScale(1, 1, 1)
  self.ui.imag_PunchEfc.transform:SetLocalScale(0, 0, 0)
  self.shakeSeq = cs_DoTween.Sequence()
  self.shakeSeq:SetUpdate(true)
  self.shakeSeq:SetAutoKill(false)
  if self.dataId == 18 then
    self.shakeSeq:Append(self.ui.obj_Punch.transform:DOPunchScale(Vector3.New(0.7, 0.7, 0), 0.1, 1, 1):SetEase(cs_Tweening.Ease.InQuad))
  else
    self.shakeSeq:Append(self.ui.obj_Punch.transform:DOScale(Vector2.New(0.8, 0.8), 0.1):SetEase(cs_Tweening.Ease.OutQuad):SetLoops(2, cs_DoTweenLoopType.Yoyo))
    self.shakeSeq:Insert(0.05, self.ui.imag_PunchEfc.transform:DOScale(Vector2.one, 0.1))
  end
end

function UIDamieEfcItem:IsPair(id)
  if self.dataId ~= id then
    self.dataId = id
    return false
  end
  return true
end

function UIDamieEfcItem:UpdatePunch()
  local trans = self.ui.img_Punch
  trans:SetLocalScale(-trans.localScale.x, trans.localScale.y, trans.localScale.z)
end

function UIDamieEfcItem:UpdateState()
  self.ui.imag_PunchEfc:SetActive(true)
end

function UIDamieEfcItem:OnHide()
  base.OnHide(self)
  if self.hideTimer ~= nil then
    TimerManager:StopTimer(self.hideTimer)
    self.hideTimer = nil
  end
  self.ui.tex_GetScore:SetIndex(1)
  self.ui.img_Punch:SetLocalScale(1, 1, 1)
  self.ui.obj_Punch.transform:SetLocalScale(1, 1, 1)
  self.ui.imag_PunchEfc.transform:SetLocalScale(0, 0, 0)
end

function UIDamieEfcItem:OnDelete()
  base.OnDelete(self)
  if self.shakeSeq ~= nil then
    self.shakeSeq:Kill()
    self.shakeSeq = nil
  end
end

return UIDamieEfcItem
