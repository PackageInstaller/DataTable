_class("UIHauteCoutureDrawEnterAniPLM", UICustomWidget)
UIHauteCoutureDrawEnterAniPLM = UIHauteCoutureDrawEnterAniPLM

function UIHauteCoutureDrawEnterAniPLM:Constructor()
  self._clipLength = -1
end

function UIHauteCoutureDrawEnterAniPLM:OnShow()
  self:InitWidgets()
end

function UIHauteCoutureDrawEnterAniPLM:InitWidgets()
  self._eff = self:GetGameObject("eff")
  self._eff2 = self:GetGameObject("eff2")
  self._eff3 = self:GetGameObject("eff3")
  self._eff4 = self:GetGameObject("eff4")
  self._eff5 = self:GetGameObject("eff5")
  self._eff.layer = 10
  self._eff2.layer = 10
  self._eff3.layer = 10
  self._eff4.layer = 10
  self._eff5.layer = 10
  local aniGo = self:GetGameObject("Animation")
  local animation = aniGo:GetComponent("Animation")
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(animation)
  if clips and clips.Length > 0 then
    local clip = clips[0]
    self._clipLength = clip.length
  end
end

function UIHauteCoutureDrawEnterAniPLM:GetClipLength()
  return self._clipLength
end
