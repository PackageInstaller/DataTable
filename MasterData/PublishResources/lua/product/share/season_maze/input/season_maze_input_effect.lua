_class("SeasonMazeInputEffect", Object)
SeasonMazeInputEffect = SeasonMazeInputEffect

function SeasonMazeInputEffect:Constructor()
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self._seasonID = self._uiSeasonMazeModule:GetSeasonID()
  self._seasonMazeManger = self._uiSeasonMazeModule:SeasonMazeManager()
  self._cfg = Cfg.cfg_season_map[self._seasonID]
  self._animNames = {}
  self._animNames[SeasonClickEffectPhase.In] = self._cfg.ClickEffectAnim[SeasonClickEffectPhase.In]
  self._animNames[SeasonClickEffectPhase.Loop] = self._cfg.ClickEffectAnim[SeasonClickEffectPhase.Loop]
  self._time = 0
  self._phase = SeasonClickEffectPhase.None
end

function SeasonMazeInputEffect:_LoadClickEffect()
  self._clickEffectReq = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.ClickEffect, LoadType.GameObject)
  if not self._clickEffectReq then
    Log.error("SeasonMazeInputEffect load ClickEffect fail.")
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

function SeasonMazeInputEffect:Update(deltaTime)
  if self._phase == SeasonClickEffectPhase.None then
    return
  end
  self._time = self._time - deltaTime
  if self._phase == SeasonClickEffectPhase.Click then
    self:SetPhase(SeasonClickEffectPhase.In)
  else
    if self._phase == SeasonClickEffectPhase.In and self._time <= 0 then
      self:_PlayEffect(SeasonClickEffectPhase.Loop)
    else
    end
  end
end

function SeasonMazeInputEffect:Dispose()
  table.clear(self._animNames)
  if self._clickEffectReq then
    self._clickEffectReq:Dispose()
    self._clickEffectReq = nil
  end
  UnityEngine.Object.Destroy(self._gameObject)
end

function SeasonMazeInputEffect:Click()
  self._phase = SeasonClickEffectPhase.Click
end

function SeasonMazeInputEffect:UpdatePosition(position)
  self._transform.position = Vector3(position.x, 0.5, position.z)
end

function SeasonMazeInputEffect:SetPhase(phase)
  if phase == SeasonClickEffectPhase.In then
    self._gameObject:SetActive(true)
    self:_PlayEffect(SeasonClickEffectPhase.In)
  end
end

function SeasonMazeInputEffect:GetPhase()
  return self._phase
end

function SeasonMazeInputEffect:Stop()
  self._phase = SeasonClickEffectPhase.None
  self._gameObject:SetActive(false)
end

function SeasonMazeInputEffect:_PlayEffect(phase)
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
