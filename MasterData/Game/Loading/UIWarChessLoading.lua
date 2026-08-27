local UIWarChessLoading = class("UIWarChessLoading", UIBaseWindow)
local base = UIBaseWindow
local cs_RenderTexture = CS.UnityEngine.RenderTexture
local cs_DOTween = CS.DG.Tweening.DOTween

function UIWarChessLoading:OnInit()
  self.__permanent = true
  self.bg = self.ui.bG
  self.captureSceen = self.ui.captureSceen
  self.captureSceen.renderCamera = UIManager:GetUICamera()
  self.loadEffectMat = self.bg.material
  if not IsNull(self.loadEffectMat) then
    self.loadEffectMat:SetFloat("_Alpha", 1)
    self.loadEffectMat:SetColor("_MainColor", Color.white)
  end
end

function UIWarChessLoading:OnShow()
  self.captureSceen.renderCamera = UIManager:GetUICamera()
  self:__Capture()
  self:__ClearTimer()
  self.delayOpenTimerId = TimerManager:StartTimer(1, self.__ShowBg, self, true, true, true)
  base.OnShow(self)
end

function UIWarChessLoading:__Capture()
  self.bg.enabled = false
  self.captureSceen.enabled = false
  self.captureSceen.enabled = true
  local temp = self.captureSceen.screenTex
  self.captureSceen.screenTex = nil
  local isHasScreenTex = not IsNull(temp)
  if isHasScreenTex then
    cs_RenderTexture:ReleaseTemporary(temp)
  end
  if isHasScreenTex == false then
    self.captureSceen:Capture()
    self.bg.texture = self.captureSceen.screenTex
  end
  local temp = self.captureSceen.screenTex
  self.captureSceen.screenTex = nil
  if not IsNull(temp) then
    self.cacheRT = temp
    cs_RenderTexture:ReleaseTemporary(temp)
  end
end

function UIWarChessLoading:__ShowBg()
  if not IsNull(self.bg) then
    self.bg.enabled = true
  end
  if self.startAction ~= nil then
    self.startAction()
    self.startAction = nil
  end
end

function UIWarChessLoading:PlayLoadEffect(forcePos, isForward, startAction)
  self.startAction = startAction
  if forcePos ~= nil then
    self.captureSceen:SetWorldToScreenPoint(forcePos)
  else
    self.captureSceen.effectCenter = Vector2.New(0.5, 0.5)
  end
  self.captureSceen:PlayLoadEffect(isForward)
end

function UIWarChessLoading:__ClearTimer()
  if self.delayOpenTimerId ~= nil then
    TimerManager:StopTimer(self.delayOpenTimerId)
    self.delayOpenTimerId = nil
  end
end

function UIWarChessLoading:PlayHideEffect()
  if not IsNull(self.loadEffectMat) then
    self.hideTweener = cs_DOTween.To(function()
      return 1
    end, function(x)
      self.loadEffectMat:SetFloat("_Alpha", x)
    end, 0, self.ui.hideEffectDuration)
    
    local function __OnPlayHideEffectEnd()
      self:Hide()
      self.loadEffectMat:SetFloat("_Alpha", 1)
      self.loadEffectMat:SetColor("_MainColor", Color.white)
      self.hideTweener = nil
      if not IsNull(self.cacheRT) then
        cs_RenderTexture:ReleaseTemporary(self.cacheRT)
        self.cacheRT = nil
      end
    end
    
    self.hideTweener:SetUpdate(true)
    self.hideTweener:SetRecyclable()
    self.hideTweener.onComplete = BindCallback(self, __OnPlayHideEffectEnd)
  else
    self:Hide()
  end
end

function UIWarChessLoading:OnHide()
  self:__ClearTimer()
  self.bg.texture = nil
  local temp = self.captureSceen.screenTex
  self.captureSceen.screenTex = nil
  if not IsNull(temp) then
    cs_RenderTexture:ReleaseTemporary(temp)
  end
  base.OnHide(self)
end

function UIWarChessLoading:OnDelete()
  self:__ClearTimer()
  if not IsNull(self.hideTweener) then
    self.hideTweener:Kill()
    self.hideTweener = nil
  end
  base.OnDelete(self)
end

return UIWarChessLoading
