_class("SeasonInputEffect", Object)
SeasonInputEffect = SeasonInputEffect

function SeasonInputEffect:Constructor(seasonID)
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  seasonID = self._uiSeasonModule:GetSeasonID()
  self._seasonManger = self._uiSeasonModule:SeasonManager()
  self._cfg = Cfg.cfg_season_map[seasonID]
  self._player = self._seasonManger:SeasonPlayerManager():GetPlayer()
  self._animNames = {}
  self._animNames[SeasonClickEffectPhase.In] = self._cfg.ClickEffectAnim[SeasonClickEffectPhase.In]
  self._animNames[SeasonClickEffectPhase.Loop] = self._cfg.ClickEffectAnim[SeasonClickEffectPhase.Loop]
  self._time = 0
  self._phase = SeasonClickEffectPhase.None
  self:_LoadClickEffect()
end

function SeasonInputEffect:_LoadClickEffect()
  self._clickEffectReq = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.ClickEffect, LoadType.GameObject)
  if not self._clickEffectReq then
    Log.error("SeasonInputEffect load ClickEffect fail.")
    return
  end
  self._gameObject = self._clickEffectReq.Obj
  self._transform = self._gameObject.transform
  local transform = self._player:RealTransform()
  self._transform:SetParent(transform.parent)
  self._transform.position = transform.position
  self._transform.rotation = transform.rotation
  self._animation = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
  self._gameObject:SetActive(false)
end

function SeasonInputEffect:Update(deltaTime)
  if self._phase == SeasonClickEffectPhase.None then
    return
  end
  self._time = self._time - deltaTime
  if self._phase == SeasonClickEffectPhase.Click then
    self:SetPhase(SeasonClickEffectPhase.In)
  elseif self._phase == SeasonClickEffectPhase.In then
    if self._time <= 0 then
      self:_PlayEffect(SeasonClickEffectPhase.Loop)
    else
      local position = self._player:GetLastCorners()
      if position then
        self:UpdatePosition(position)
      end
    end
  end
end

function SeasonInputEffect:Dispose()
  table.clear(self._animNames)
  if self._clickEffectReq then
    self._clickEffectReq:Dispose()
    self._clickEffectReq = nil
  end
  UnityEngine.Object.Destroy(self._gameObject)
end

function SeasonInputEffect:Click()
  self._phase = SeasonClickEffectPhase.Click
end

function SeasonInputEffect:UpdatePosition(position)
  self._transform.position = Vector3(position.x, 0.5, position.z)
end

function SeasonInputEffect:SetPhase(phase)
  if phase == SeasonClickEffectPhase.In then
    self._gameObject:SetActive(true)
    self:_PlayEffect(SeasonClickEffectPhase.In)
  end
end

function SeasonInputEffect:GetPhase()
  return self._phase
end

function SeasonInputEffect:Stop()
  self._phase = SeasonClickEffectPhase.None
  self._gameObject:SetActive(false)
end

function SeasonInputEffect:_PlayEffect(phase)
  self._phase = phase
  local animationState = self._animation:get_Item(self._animNames[self._phase])
  if animationState then
    self._animation:Stop()
    self._animation:Play(animationState.name)
    self._time = animationState.length * 1000
  else
    self._time = 0
  end
end
