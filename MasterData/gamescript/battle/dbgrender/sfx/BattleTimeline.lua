local BattleTimeline = System.NewClass("BattleTimeline")

function BattleTimeline.SimplePlay(assetPath, onComplete, abortSignal)
  local timeline = BattleTimeline.Get(assetPath)
  timeline:SetParent(bg.battleScene.sceneLayer)
  timeline:Play(onComplete, nil, abortSignal)
end

function BattleTimeline.Preload(assetPath, poolRoot)
  Pool.CreateWithTag(BattleTimeline, assetPath, 1, poolRoot)
end

function BattleTimeline.Get(assetPath)
  do return Pool.GetWithTag, BattleTimeline, assetPath end
  return Pool.GetWithTag, BattleTimeline, assetPath, bg.battleScene.factoryLayer
end

function BattleTimeline.Clear(assetPath)
  Pool.ClearWithTag(BattleTimeline, assetPath)
end

function BattleTimeline:ctor(assetPath, poolRoot)
  self.assetPath = assetPath
  self.poolRoot = poolRoot
end

function BattleTimeline:SetParent()
  return self
end

function BattleTimeline:SetTarget(caster, ace)
  self._aceTarget = ace
  if self.abilityController then
    self.abilityController:SetTarget(caster, ace)
  end
  return self
end

function BattleTimeline:SetSpeed(gameSpeed)
  self.gameSpeed = gameSpeed
  if self.amPlayer and not IsNil(self.amPlayer) then
    self.amPlayer:SetSpeed(gameSpeed)
  end
  return self
end

function BattleTimeline:Play(player, direction, looping, onComplete, onEvent, abortSignal)
  if abortSignal then
    abortSignal:AddListener(System.fn(self, self.OnAbort))
  end
  self.player = player
  self.gameSpeed = self.gameSpeed or bg.battleRender.gameSpeed or 1
  self.amPlayer = CS.AMTimeline.AMPlayer.Get(player.gameObject)
  self.amPlayer:Stop()
  self.onComplete = onComplete
  self.amPlayer:SetSpeed(self.gameSpeed)
  self.amPlayer:SetTarget(self._aceTarget and self._aceTarget.transform or nil)
  self.amPlayer:SetLoopingTimes(looping)
  print("========播放技能文件===========", self.assetPath, debug.traceback())
  if string.find(self.assetPath, "TimelineRoot/Skill/Monster/") then
    if 0 == direction then
      direction = 1
    else
      direction = 0
    end
  end
  self.amPlayer:Play(self.player, self.assetPath, direction, function(evtType)
    if 1 ~= evtType then
      return
    end
    if abortSignal then
      abortSignal:RemoveListener(System.fn(self, self.OnAbort))
    end
    if self.onComplete then
      self.onComplete()
    end
    self.pool:Free(self)
  end, function(evtId, evtParams)
    self:OnTLEvent(evtId, evtParams)
    if onEvent then
      onEvent(evtId, evtParams)
    end
  end)
  return self
end

function BattleTimeline:OnTLEvent(eventId, eventParam)
  if not self.amPlayer then
    return
  end
  if eventId == rc.TimeLineEvent.WWiseEvent then
    AudioManager.Instance:PostSoundEvent(eventParam)
  end
end

function BattleTimeline:Resume()
  if self.amPlayer then
    self.amPlayer:Resume()
  end
end

function BattleTimeline:Pause()
  if self.amPlayer then
    self.amPlayer:Pause()
  end
end

function BattleTimeline:Stop()
  if not IsNil(self.amPlayer) then
    self.amPlayer:Stop()
  end
end

function BattleTimeline:OnAbort()
  if not IsNil(self.amPlayer) then
    self.amPlayer:Stop()
    self.amPlayer = nil
  end
  self.pool:Free(self)
end

function BattleTimeline:OnRecycle()
end

function BattleTimeline:Dispose()
  self.onComplete = nil
  if not IsNil(self.amPlayer) then
    self.amPlayer:Stop()
    self.amPlayer = nil
  end
  self.player = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

return BattleTimeline
