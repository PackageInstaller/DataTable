local UIEffectsCtrl = NewClass("UIEffectsCtrl")
local T_Image = CS.UnityEngine.UI.Image
local T_MaskableGraphic = CS.UnityEngine.UI.MaskableGraphic
local Canvas = CS.UnityEngine.Canvas
local AnimationCurve = CS.UnityEngine.AnimationCurve
local DoTween = CS.DG.Tweening.DOTween

function UIEffectsCtrl:ctor(go)
  self.go = go
  self.imageComp = self.go:GetComponent(typeof(T_Image))
  if self.imageComp then
    self.material = self.imageComp.material
  end
  self.tilngX = 0
  self.tilngY = 0
  self.offsetX = 0
  self.offsetY = 0
  self.dissolveProgress = 0
  self:AnimFunc()
end

function UIEffectsCtrl:OnEnable()
  function self.willRenderCanvasesFunc()
    self:LateUpdate()
  end
  
  Canvas.willRenderCanvases("+", self.willRenderCanvasesFunc)
end

function UIEffectsCtrl:OnDisable()
  if self.willRenderCanvasesFunc then
    Canvas.willRenderCanvases("-", self.willRenderCanvasesFunc)
    self.willRenderCanvasesFunc = nil
  end
  DOTweenUtils.KillAllTweensByTarget(self)
end

function UIEffectsCtrl:LateUpdate()
  if not self.imageComp then
    return
  end
  self.material = self.imageComp.materialForRendering
  if not self.material then
    return
  end
  self:RefreshMatValue()
end

function UIEffectsCtrl:AnimFunc()
  self.animFuncList = {}
  self.animFuncList.TilngX = {
    animFunc = function(animCurve)
      self:PlayAnim(animCurve, function(value)
        self:SetTilngX(value)
      end)
    end
  }
  self.animFuncList.TilngY = {
    animFunc = function(animCurve)
      self:PlayAnim(animCurve, function(value)
        self:SetTilngY(value)
      end)
    end
  }
  self.animFuncList.OffsetX = {
    animFunc = function(animCurve)
      self:PlayAnim(animCurve, function(value)
        self:SetOffsetX(value)
      end)
    end
  }
  self.animFuncList.OffsetY = {
    animFunc = function(animCurve)
      self:PlayAnim(animCurve, function(value)
        self:SetOffsetY(value)
      end)
    end
  }
  self.animFuncList.DissolveProgress = {
    animFunc = function(animCurve)
      self:PlayAnim(animCurve, function(value)
        self:SetDissolveProgress(value)
      end)
    end
  }
end

function UIEffectsCtrl:SetTilngX(tilngX)
  self.tilngX = tilngX
end

function UIEffectsCtrl:SetTilngY(tilngY)
  self.tilngY = tilngY
end

function UIEffectsCtrl:SetOffsetX(offsetX)
  self.offsetX = offsetX
end

function UIEffectsCtrl:SetOffsetY(offsetY)
  self.offsetY = offsetY
end

function UIEffectsCtrl:SetDissolveProgress(dissolveProgress)
  self.dissolveProgress = dissolveProgress
end

function UIEffectsCtrl:SetMatValue(tilngX, tilngY, offsetX, offsetY, dissolveProgress)
  self.tilngX = tilngX or 0
  self.tilngY = tilngY or 0
  self.offsetY = offsetY or 0
  self.dissolveProgress = dissolveProgress or 0
end

function UIEffectsCtrl:RefreshMatValue()
  self.material:SetFloat("_TilngX", self.tilngX)
  self.material:SetFloat("_TilngY", self.tilngY)
  self.material:SetFloat("_OffsetX", self.offsetX)
  self.material:SetFloat("_OffsetY", self.offsetY)
  self.material:SetFloat("_DissolveProgress", self.dissolveProgress)
end

function UIEffectsCtrl:PlayCurveAnim(animData)
  DOTweenUtils.KillAllTweensByTarget(self)
  for curveProperty, curveData in pairs(animData) do
    local funcList = self.animFuncList[curveProperty]
    funcList.animFunc(curveData)
  end
end

function UIEffectsCtrl:PlayAnim(animCurve, setValueFunc)
  local animCurve = animCurve
  local animLength = table.length(animCurve)
  if animLength <= 0 then
    return
  end
  local offsetXTwSequence = DoTween.Sequence(self)
  setValueFunc(animCurve[1].value)
  for i = 2, animLength do
    offsetXTwSequence:Append(DoTween.To(function()
      return self.offsetY
    end, function(offset)
      setValueFunc(offset)
    end, animCurve[i].value, animCurve[i].time - animCurve[i - 1].time, self))
  end
  setValueFunc(animCurve[animLength].value)
end

function UIEffectsCtrl:PlayOffsetYAnim(animCurve)
  if self.offsetYTwSequence then
    self.offsetYTwSequence:Kill()
    self.offsetYTwSequence = nil
  end
  local animCurve = animCurve
  local animLength = table.length(animCurve)
  if animLength <= 0 then
    return
  end
  self.offsetYTwSequence = self.offsetYTwSequence or DoTween.Sequence(self)
  self:SetOffsetY(animCurve[1].value)
  for i = 2, animLength do
    self.offsetYTwSequence:Append(DoTween.To(function()
      return self.offsetY
    end, function(offset)
      self:SetOffsetY(offset)
    end, animCurve[i].value, animCurve[i].time - animCurve[i - 1].time, self))
  end
  self:SetOffsetY(animCurve[animLength].value)
end

return UIEffectsCtrl
