_class("UISimpleHauteCoutureDrawEnterAniDIY_GED", UICustomWidget)
UISimpleHauteCoutureDrawEnterAniDIY_GED = UISimpleHauteCoutureDrawEnterAniDIY_GED

function UISimpleHauteCoutureDrawEnterAniDIY_GED:Constructor()
  self._clipLength = -1
  self._camera = nil
end

function UISimpleHauteCoutureDrawEnterAniDIY_GED:OnShow()
  self:InitWidgets()
end

function UISimpleHauteCoutureDrawEnterAniDIY_GED:InitWidgets()
  local aniGo = self:GetGameObject("Animation")
  local animation = aniGo:GetComponent("Animation")
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(animation)
  if clips and clips.Length > 0 then
    local clip = clips[0]
    self._clipLength = clip.length
  end
end

function UISimpleHauteCoutureDrawEnterAniDIY_GED:GetClipLength()
  return self._clipLength
end

function UISimpleHauteCoutureDrawEnterAniDIY_GED:Play()
  self._camera = GameGlobal.UIStateManager():GetControllerCamera("UISimpleHauteCoutureMainController")
  self:Shot()
end

function UISimpleHauteCoutureDrawEnterAniDIY_GED:Shot()
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "Animation")
  self._shot.width = UnityEngine.Screen.width
  self._shot.height = UnityEngine.Screen.height
  self._shot.blurTimes = 0
  self._shot.OwnerCamera = self._camera
  self._shot:CleanRenderTexture()
  self:StartTask(function(TT)
    YIELD(TT, 1533)
    local rt = self._shot:RefreshBlurTexture()
    local cacheRt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cacheRt)
    local texGo = self:GetGameObject("Tex")
    local renderer = texGo:GetComponent("MeshRenderer")
    local csMaterial = renderer.material
    csMaterial:SetTexture("_MainTex", rt)
    renderer.material = csMaterial
  end)
end
