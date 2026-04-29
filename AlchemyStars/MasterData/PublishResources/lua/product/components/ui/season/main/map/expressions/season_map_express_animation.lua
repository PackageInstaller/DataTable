require("season_map_express_base")
_class("SeasonMapExpressAnimation", SeasonMapExpressBase)
SeasonMapExpressAnimation = SeasonMapExpressAnimation

function SeasonMapExpressAnimation:Constructor(cfg, eventPoint)
  self._content = self._cfg.Animation
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._time = 0
  self._effectReqs = {}
  self._player = self._seasonManager:SeasonPlayerManager():GetPlayer()
  self._playerAnimationState = nil
  self._executing = false
end

function SeasonMapExpressAnimation:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and self._executing then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._executing = false
      if self._playerAnimationState then
        self._player:PlayAnimation(SeasonPlayerAnimation.Stand, 0)
      end
      for _, _req in pairs(self._effectReqs) do
        _req:Dispose()
      end
      self:Next()
    end
  end
end

function SeasonMapExpressAnimation:Dispose()
  self.super.Dispose(self)
  for _, _req in pairs(self._effectReqs) do
    _req:Dispose()
  end
  table.clear(self._effectReqs)
  self._playerAnimationState = nil
end

function SeasonMapExpressAnimation:OnPlay()
  table.clear(self._effectReqs)
  self._time = 0
  self._playerAnimationState = nil
  self._executing = true
  local eventPoint
  if self._content.id then
    eventPoint = self._seasonManager:SeasonMapManager():GetEventPoint(self._content.id)
  else
    eventPoint = self._eventPoint
  end
  if eventPoint then
    local eventanim = self._content.eventanim
    local eventLoop = self._content.eventloop
    local playeranim = self._content.playeranim
    local playerLoop = self._content.playerloop
    local eventAnimationState = eventPoint:PlayAnimation(eventanim)
    if eventAnimationState then
      eventLoop = eventLoop or 1
      self._time = eventAnimationState.length * eventLoop
    end
    self._playerAnimationState = self._player:PlayAnimation(playeranim)
    if self._playerAnimationState then
      playerLoop = playerLoop or 1
      local time = self._playerAnimationState.length * playerLoop
      if time > self._time then
        self._time = time
      end
    end
    self._time = self._time * 1000
    Log.debug("SeasonMapExpressAnimation time ", self._time)
    local eventEffect = self._content.eventeffect
    local eventHolder = self._content.eventholder
    local playerEffect = self._content.playereffect
    local playerHolder = self._content.playerholder
    self:_PlayEffect(eventPoint, eventHolder, eventEffect)
    self:_PlayEffect(self._player, playerHolder, playerEffect)
    local audioID = self._content.audio
    if audioID then
      AudioHelperController.PlayUISoundAutoRelease(tonumber(audioID))
    end
    self._state = SeasonExpressState.Playing
  else
    self:Next()
  end
end

function SeasonMapExpressAnimation:_PlayEffect(holder, boneName, effectName)
  if effectName then
    local effectReq = ResourceManager:GetInstance():SyncLoadAsset(effectName .. ".prefab", LoadType.GameObject)
    if effectReq and effectReq.Obj then
      local bone = holder:GetBoneNode(boneName)
      local effect = effectReq.Obj
      effect:SetActive(true)
      effect.transform:SetParent(bone)
      effect.transform.localPosition = Vector3.zero
      effect.transform.localRotation = Quaternion.Euler(0, 0, 0)
      self._effectReqs[effectReq] = effectReq
    end
  end
end
