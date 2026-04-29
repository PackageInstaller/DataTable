_class("SeasonPlayerExpress", Object)
SeasonPlayerExpress = SeasonPlayerExpress

function SeasonPlayerExpress:Constructor(player, manager)
  self._player = player
  self._seasonManager = manager
  self._uiBubble = nil
  self._expressType = SeasonPlayerExpressType.None
  self._index = 0
  self._time = 0
  self._exressCfg = nil
  self._curExpressCfg = nil
  self._animationTime = 0
end

function SeasonPlayerExpress:Update(deltaTime)
  if self._curExpressCfg then
    self._time = self._time - deltaTime
    if self._animationTime > 0 then
      self._animationTime = self._animationTime - deltaTime
      if self._animationTime <= 0 then
        self._player:PlayAnimation(SeasonPlayerAnimation.Stand, 0)
      end
    end
    if self._time <= 0 then
      self:_PlayNext()
    end
    if self._expressType == SeasonPlayerExpressType.Click or self._expressType == SeasonPlayerExpressType.Relax then
      self._player:RotateToPosition(self._player:Position() + Vector3.forward, UnityEngine.Time.deltaTime * 10)
    end
  end
end

function SeasonPlayerExpress:Play(playerExpressType)
  if self._expressType ~= SeasonPlayerExpressType.None then
    Log.error("SeasonPlayerExpress is playing.", self._expressType)
    return
  end
  self._uiBubble = self._seasonManager:SeasonUIManager():UI():Bubble()
  self._expressType = playerExpressType
  self._exressCfg = nil
  self._curExpressCfg = nil
  if self._expressType == SeasonPlayerExpressType.Click then
    local clickCfg = self._player:CurModule():Cfg().Click
    if clickCfg then
      self._exressCfg = clickCfg
      if self._exressCfg then
        self._player:Stop(false)
      end
    end
  elseif self._expressType == SeasonPlayerExpressType.Relax then
    local relaxCfg = self._player:CurModule():Cfg().Relax
    if relaxCfg then
      self._exressCfg = relaxCfg
      if self._exressCfg then
        self._player:Stop(false)
      end
    end
  elseif self._expressType == SeasonPlayerExpressType.Moving then
    local moveingCfg = self._player:CurModule():Cfg().Moving
    if moveingCfg then
      self._exressCfg = moveingCfg
    end
  end
  self:_PlayNext()
end

function SeasonPlayerExpress:_PlayNext()
  if self._exressCfg then
    self._index = self._index + 1
    if self._index > table.count(self._exressCfg) then
      self:Stop()
    else
      self._curExpressCfg = self._exressCfg[self._index][self._player:CurZone()]
      if self._curExpressCfg then
        self._animationTime = 0
        if self._curExpressCfg.anim then
          local state = self._player:PlayAnimation(self._curExpressCfg.anim)
          if state then
            self._animationTime = state.length * 1000
          end
        end
        if self._curExpressCfg.bubble then
          self._uiBubble:Play(self._curExpressCfg.bubble)
        end
        self._time = self._curExpressCfg.time * 1000
      end
    end
  end
end

function SeasonPlayerExpress:Stop()
  self._index = 0
  self._exressCfg = nil
  self._curExpressCfg = nil
  if self._uiBubble then
    self._uiBubble:Stop()
    self._uiBubble = nil
  end
  if self._expressType == SeasonPlayerExpressType.Click or self._expressType == SeasonPlayerExpressType.Relax then
    self._player:PlayAnimation(SeasonPlayerAnimation.Stand, 0)
  end
  self._expressType = SeasonPlayerExpressType.None
end

function SeasonPlayerExpress:Interrupt(ignoreExpressType)
  if self._expressType ~= ignoreExpressType then
    self:Stop()
  end
end

function SeasonPlayerExpress:IsPlaying()
  return self._expressType ~= SeasonPlayerExpressType.None
end
