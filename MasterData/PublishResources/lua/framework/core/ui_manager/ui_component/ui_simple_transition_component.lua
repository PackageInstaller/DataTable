_class("UISimpleTransitionComponent", UIComponent)

function UISimpleTransitionComponent:Constructor()
  self._fadeTime = 0.3333333333333333
  self._moveTime = 0.5
  self._moveDistance = 50
end

function UISimpleTransitionComponent:AfterShow(TT)
  self:PlayEnterAnim(TT)
end

function UISimpleTransitionComponent:BeforeHide(TT)
  self:PlayLeaveAnim(TT)
end

function UISimpleTransitionComponent:PlayEnterAnim(TT)
  local safeAreaNode = self.uiController:GetGameObject().transform:Find("UICanvas/SafeArea")
  if not safeAreaNode then
    return
  end
  local canvasGroup = safeAreaNode.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
  canvasGroup = canvasGroup or safeAreaNode.gameObject:AddComponent(typeof(UnityEngine.CanvasGroup))
  if self.registerInfo.fadeBlurMask then
    local blurMaskTrans = self.uiController:GetGameObject().transform.parent.parent:Find("BGMaskCanvas/BlurMask")
    if blurMaskTrans then
      self._blurMask = blurMaskTrans.gameObject:GetComponent(typeof(UnityEngine.UI.RawImage))
    end
  end
  self._safeAreaNode = safeAreaNode
  self._canvasGroup = canvasGroup
  self._canvasGroup.alpha = 0
  self._canvasGroup:DOFade(1, self._fadeTime)
  if self._blurMask then
    self._blurMask.color = Color(1, 1, 1, 0)
    self._blurMask:DOFade(1, self._fadeTime)
  end
  self._safeAreaNode.localPosition = Vector3(0, -self._moveDistance, 0)
  self._safeAreaNode:DOLocalMoveY(0, self._moveTime):SetEase(DG.Tweening.Ease.OutCirc)
  YIELD(TT, self._moveTime * 1000)
end

function UISimpleTransitionComponent:PlayLeaveAnim(TT)
  if not self._canvasGroup then
    return
  end
  self._canvasGroup:DOFade(0, self._fadeTime)
  if self._blurMask then
    self._blurMask:DOFade(0, self._fadeTime)
  end
  YIELD(TT, self._fadeTime * 1000)
end
