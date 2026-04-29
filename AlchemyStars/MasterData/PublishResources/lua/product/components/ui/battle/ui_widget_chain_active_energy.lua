_class("UIWidgetChainActiveEnergy", UICustomWidget)
UIWidgetChainActiveEnergy = UIWidgetChainActiveEnergy

function UIWidgetChainActiveEnergy:OnShow()
  self._on = self:GetGameObject("on")
  self._canvasGroupOn = self._on:GetComponent(typeof(UnityEngine.CanvasGroup))
  self._fx = self:GetGameObject("fx")
  self._animation = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._on:SetActive(false)
  self._fx:SetActive(false)
  self._isLoopEnabled = false
  self._state = false
  self:AttachEvent(GameEventType.UpdateBuffLayerActiveSkillEnergyChange, self.OnEnergyChange)
  self:AttachEvent(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, self.OnPreviewingSkill)
end

function UIWidgetChainActiveEnergy:InitData(pstID, index)
  self._pstID = pstID
  self._index = index
end

function UIWidgetChainActiveEnergy:OnHide()
  self:DetachAllEvents()
end

function UIWidgetChainActiveEnergy:SetLight(b)
  self._animation:Stop()
  self._animation.enabled = false
  self._animation.enabled = true
  if b then
    self._animation:Play("uieff_N26_WidgetChainActiveEnergy_in", UnityEngine.PlayMode.StopAll)
  else
    self._animation:Play("uieff_N26_WidgetChainActiveEnergy_out", UnityEngine.PlayMode.StopAll)
  end
end

function UIWidgetChainActiveEnergy:OnEnergyChange(params)
  if params.petPstID ~= self._pstID then
    return
  end
  if params.index ~= self._index and not params.all then
    return
  end
  self._newState = params.on
  if self:GetGameObject().activeInHierarchy then
    self:DelayedAnimation()
  end
end

function UIWidgetChainActiveEnergy:DelayedAnimation()
  if self._state == nil then
    self._state = false
  end
  if self._newState ~= self._state then
    self:SetLight(self._newState)
    self._state = self._newState
  end
end

function UIWidgetChainActiveEnergy:OnPreviewingSkill(params)
  local pstID = params.pstID
  local index = params.index
  local shutdown = params.shutdown
  if shutdown then
    self._animation:Stop()
    self._on:SetActive(self._state)
    self._canvasGroupOn.alpha = 1
    self._isLoopEnabled = false
    return
  end
  if self._pstID ~= pstID then
    return
  end
  index = index - 1
  local isLoopEnabled = index == self._index
  if isLoopEnabled and self._isLoopEnabled then
    return
  end
  if isLoopEnabled then
    self._animation:Stop()
    self._animation.enabled = false
    self._animation.enabled = true
    self._animation:Play("uieff_N26_WidgetChainActiveEnergy_loop", UnityEngine.PlayMode.StopAll)
    self._isLoopEnabled = true
  else
    self._animation:Stop()
    self._on:SetActive(self._state)
    self._canvasGroupOn.alpha = 1
    self._isLoopEnabled = false
  end
end
