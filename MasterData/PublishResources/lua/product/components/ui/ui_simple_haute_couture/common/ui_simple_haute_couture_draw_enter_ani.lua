_class("UISimpleHauteCoutureDrawEnterAni", UICustomWidget)
UISimpleHauteCoutureDrawEnterAni = UISimpleHauteCoutureDrawEnterAni

function UISimpleHauteCoutureDrawEnterAni:Constructor()
  self._clipLength = -1
end

function UISimpleHauteCoutureDrawEnterAni:OnShow()
  self._bg1 = self:GetUIComponent("RawImageLoader", "bg1")
  self._bg2 = self:GetUIComponent("RawImageLoader", "bg2")
  self:InitWidgets()
end

function UISimpleHauteCoutureDrawEnterAni:InitWidgets()
  local aniGo = self:GetGameObject("Animation")
  local animation = aniGo:GetComponent("Animation")
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(animation)
  if clips and clips.Length > 0 then
    local clip = clips[0]
    self._clipLength = clip.length
  end
end

function UISimpleHauteCoutureDrawEnterAni:GetClipLength()
  return self._clipLength
end

function UISimpleHauteCoutureDrawEnterAni:SetData(cfg)
  self._cfg = cfg
  self._bg1:LoadImage(self._cfg.EnterPic[1])
  self._bg2:LoadImage(self._cfg.EnterPic[2])
end
