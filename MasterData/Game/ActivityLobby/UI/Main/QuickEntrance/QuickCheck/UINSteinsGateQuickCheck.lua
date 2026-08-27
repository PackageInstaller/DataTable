local base = require("Game.ActivityLobby.UI.Main.QuickEntrance.QuickCheck.UINCommonQuickCheck")
local UINSteinsGateQuickCheck = class("UINSteinsGateQuickCheck", base)
local cs_DoTween = CS.DG.Tweening.DOTween

function UINSteinsGateQuickCheck:OnInit()
  base.OnInit(self)
end

function UINSteinsGateQuickCheck:InitUINQuickCheck(actLbCtrl, callback)
  base.InitUINQuickCheck(self, actLbCtrl, callback)
  self:SetToDoTip(false)
end

function UINSteinsGateQuickCheck:SetToDoTip(bool, tex)
  self.ui.obj_Info:SetActive(bool)
  if bool then
    self.ui.tex_Des.text = tex
    self:InitQuickCheckTipTween()
  end
end

function UINSteinsGateQuickCheck:InitQuickCheckTipTween()
  if self._showSe ~= nil then
    return
  end
  self._showSe = cs_DoTween.Sequence():SetLink(self.ui.obj_Info)
  self._showSe:Join(self.ui.obj_Info.transform:DOAnchorPosX(-100, 0.55):From())
  self._showSe:Join(self.ui.img_Info:DOFade(0, 0.55):From())
  self._showSe:SetAutoKill(false)
end

function UINSteinsGateQuickCheck:OnShow()
  if self._showSe and self._isTweenPause then
    self._showSe:Restart()
    self._isTweenPause = false
  end
end

function UINSteinsGateQuickCheck:OnHide()
  if self._showSe then
    self._showSe:Pause()
    self._isTweenPause = true
  end
end

function UINSteinsGateQuickCheck:OnDelete()
  if self._showSe ~= nil then
    self._showSe:Kill()
    self._showSe = nil
    self._isTweenPause = nil
  end
  base.OnDelete(self)
end

return UINSteinsGateQuickCheck
