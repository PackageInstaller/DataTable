_class("UnscaledCountDownSystem_Render", Object)
UnscaledCountDownSystem_Render = UnscaledCountDownSystem_Render

function UnscaledCountDownSystem_Render:Constructor(world)
  self._world = world
  self._unscaledCountDownGroup = world:GetGroup(world.BW_WEMatchers.UnscaledCountDownRender)
  self._timeService = self._world:GetService("Time")
  self._utilDataSvc = self._world:GetService("UtilData")
end

function UnscaledCountDownSystem_Render:Execute()
  self:ExecuteEntities(self._unscaledCountDownGroup:GetEntities())
end

function UnscaledCountDownSystem_Render:ExecuteEntities(entities)
  for i, e in ipairs(entities) do
    local cdCmpt = e:UnscaledCountDownRender()
    local isActive = cdCmpt:GetIsActive()
    if isActive then
      if cdCmpt:GetIsRunning() then
        local curRestTimeMs = cdCmpt:GetCurRestTimeMs()
        if curRestTimeMs and 0 < curRestTimeMs then
          local deltaTime = GameGlobal:GetInstance():GetUnscaledDeltaTime()
          curRestTimeMs = curRestTimeMs - deltaTime
          cdCmpt:SetCurRestTimeMs(curRestTimeMs)
          if curRestTimeMs <= 0 then
            cdCmpt:SetIsWaitTrigger(true)
            cdCmpt:SetIsRunning(false)
            self:_CountDownFinish(cdCmpt)
          end
        end
      elseif cdCmpt:GetIsWaitTrigger() then
        self:_CountDownFinish(cdCmpt)
      end
    end
  end
end

function UnscaledCountDownSystem_Render:PlayNotify(TT, flagID)
  local notify = NTClientUnscaledCountDownFinish:New(flagID)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
end

function UnscaledCountDownSystem_Render:_CountDownFinish(cdCmpt)
  local flagID = cdCmpt:GetFlagID()
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  if gameFsmStateID == GameStateID.WaitInput then
    if self._utilDataSvc:GetStatAutoFight() then
      return
    end
    local gridTouchCmpt = self._world:GridTouch()
    if gridTouchCmpt then
      local isTouchPlayer = gridTouchCmpt:IsTouchPlayer()
      if isTouchPlayer then
        return
      end
    end
    if self._utilDataSvc then
      local isInputEnable = self._utilDataSvc:GetMainStateInputEnable()
      if not isInputEnable then
        return
      end
    end
  else
    return
  end
  local state = 1
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SyncClientUnscaledCountDownFinish, flagID, state)
  cdCmpt:SetIsWaitTrigger(false)
  cdCmpt:SetWaitPlayNotify(true)
  Log.info("UnscaledCD _CountDownFinish, flagID:", flagID)
end
