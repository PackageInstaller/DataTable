require("ui_intro_type1_widget")
_class("UIActivityCN6N35IntroType1Widget", UIIntroType1Widget)
UIActivityCN6N35IntroType1Widget = UIActivityCN6N35IntroType1Widget

function UIActivityCN6N35IntroType1Widget:SetData(uiView, cfgId)
  self._uiView = uiView
  self._cfg = Cfg.cfg_intro_loader_type_1[cfgId]
  if not self._cfg then
    Log.exception("UIIntroType1Widget:SetData() cfg_intro_loader_type_1[", cfgId, "] error")
    self:CloseDialog()
    return
  end
  self:_SetTitle()
  self:_SetSubTitle()
  self:_SetIntro()
  self._rawImage = self:GetUIComponent("RawImage", "MainBg")
  self._rawImageLoader = self:GetUIComponent("RawImageLoader", "MainBg")
  self._lastMaterial = self._rawImage.material
  self._reqEffectMat = ResourceManager:GetInstance():SyncLoadAsset("uieff_N35N6_rongjie02" .. ".mat", LoadType.Mat)
  if self._reqEffectMat then
    self._effectMat = self._reqEffectMat.Obj
    self._rawImageLoader:SetMat("uieff_N35N6_rongjie02", self._effectMat, false)
    self._rawImage.material:SetTexture("_MainTex", self._lastMaterial:GetTexture("_MainTex"))
  end
  local animName = self._cfg and self._cfg.ShowAnim
  local duration = self._cfg and self._cfg.ShowAnimTime or 0
  self:_PlayAnimation(animName, duration, nil)
end
