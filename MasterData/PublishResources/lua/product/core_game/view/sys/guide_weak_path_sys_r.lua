_class("GuideWeakPathSystem_Render", ReactiveSystem)
GuideWeakPathSystem_Render = GuideWeakPathSystem_Render

function GuideWeakPathSystem_Render:Constructor(world)
  self._world = world
  self._guideStepEvent = nil
  self._effectEntitys = {}
  self._mats = {}
end

function GuideWeakPathSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.GuideWeakPath)
  local c = Collector:New({group}, {"Added"})
  return c
end

function GuideWeakPathSystem_Render:Filter(entity)
  return entity:HasGuideWeakPath()
end

function GuideWeakPathSystem_Render:TearDown()
  if self._guideStepEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self._guideStepEvent)
    self._guideStepEvent = nil
  end
  self:RemoveTick()
end

function GuideWeakPathSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:OnGuidePath(entities[i])
  end
end

function GuideWeakPathSystem_Render:OnGuidePath(entity)
  local reBoard = self._world:GetRenderBoardEntity()
  local guideWeakPathCmpt = reBoard:GuideWeakPath()
  local refreshType = guideWeakPathCmpt:GetGuideRefreshType()
  if refreshType == GuideRefreshType.StartGuidePath then
    local guideWeakPathCmpt = reBoard:GuideWeakPath()
    local guidePath = guideWeakPathCmpt:GetGuidePath()
    self:_GuideTargetPath()
  elseif refreshType == GuideRefreshType.RestartGuidePath then
    self:ShowWeakLine()
  elseif refreshType == GuideRefreshType.PauseGuidePath then
    if self._guideStepEvent ~= nil then
      GameGlobal.Timer():CancelEvent(self._guideStepEvent)
      self._guideStepEvent = nil
    end
    self:_DestroyGuideWeakLinkLine()
  elseif refreshType == GuideRefreshType.StopGuidePath then
    if self._guideStepEvent ~= nil then
      GameGlobal.Timer():CancelEvent(self._guideStepEvent)
      self._guideStepEvent = nil
    end
    self:_DestroyGuideWeakLinkLine()
  end
end

function GuideWeakPathSystem_Render:AddTick()
  if not self.timerEvent then
    self.lineLerp1 = GuideLerp:New(0, self.targetValue, self.count * 200, "line", true)
    self.time = GameGlobal:GetInstance():GetCurrentTime()
    self.timerEvent = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, function()
      self:Tick()
    end)
  end
end

function GuideWeakPathSystem_Render:RemoveTick()
  if self.timerEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
  end
  self.lineLerp1 = nil
  self.lineLerp2 = nil
end

function GuideWeakPathSystem_Render:Tick()
  local t3 = self._waitTime1 and (GameGlobal:GetInstance():GetCurrentTime() - self._waitTime1) / 3000 or 0
  if not self._waitTime1 or 1 < t3 then
    if 1 < t3 then
      self._waitTime1 = nil
      if self.lineLerp1 then
        self.lineLerp1:Reset()
      end
    end
    if self.lineLerp1 then
      local value, isOver = self.lineLerp1:Lerp()
      if self._mats[1] then
        self._mats[1]:SetFloat("_Panner", value)
      end
      if isOver then
        self._waitTime1 = GameGlobal:GetInstance():GetCurrentTime()
        if self._mats[1] then
          self._mats[1]:SetFloat("_Panner", 0)
        end
      end
    end
  end
  local t2 = (GameGlobal:GetInstance():GetCurrentTime() - self.time) / 500
  if 1 < t2 then
    t2 = 1
  end
  if 1 <= t2 then
    local t4 = self._waitTime2 and (GameGlobal:GetInstance():GetCurrentTime() - self._waitTime2) / 3000 or 0
    if not self._waitTime2 or 1 < t4 then
      if 1 < t4 then
        self._waitTime2 = nil
        if self.lineLerp2 then
          self.lineLerp2:Reset()
        end
      end
      if not self.lineLerp2 then
        self.lineLerp2 = GuideLerp:New(0, self.targetValue, self.count * 200, "line")
      end
      if self.lineLerp2 then
        local value, isOver = self.lineLerp2:Lerp()
        if self._mats[2] then
          self._mats[2]:SetFloat("_Panner", value)
        end
        if isOver then
          self._waitTime2 = GameGlobal:GetInstance():GetCurrentTime()
          if self._mats[2] then
            self._mats[2]:SetFloat("_Panner", 0)
          end
        end
      end
    end
  end
end

function GuideWeakPathSystem_Render:_GuideTargetPath()
  local reBoard = self._world:GetRenderBoardEntity()
  local guideWeakPathCmpt = reBoard:GuideWeakPath()
  local guidePath = guideWeakPathCmpt:GetGuidePath()
  local guidePointCount = #guidePath
  if self._guideStepEvent == nil then
    self._guideStepEvent = GameGlobal.Timer():AddEventTimes(GuideWeakLineConst.WaitTime, TimerTriggerCount.Once, function()
      self:ShowWeakLine()
    end)
  end
end

function GuideWeakPathSystem_Render:ShowWeakLine()
  local guidePath = self:_GetGuidePath()
  self.targetValue = #guidePath * 1.66
  self.count = #guidePath
  TaskManager:GetInstance():CoreGameStartTask(self._CreateGuideMarkEntity, self, guidePath)
  self:AddTick()
end

function GuideWeakPathSystem_Render:_GetGuidePath()
  local reBoard = self._world:GetRenderBoardEntity()
  local guideWeakPathCmpt = reBoard:GuideWeakPath()
  local guidePath = guideWeakPathCmpt:GetGuidePath()
  return guidePath
end

function GuideWeakPathSystem_Render:_CreateGuideMarkEntity(TT, guidePath)
  if not guidePath or #guidePath <= 0 then
    return
  end
  for i = 1, 2 do
    local effectEntity = self._world:GetService("Effect"):CreateWorldPositionEffect(GameResourceConst.GuideWeakPath, Vector3.zero)
    YIELD(TT)
    YIELD(TT)
    local mat
    if effectEntity and effectEntity:View() then
      local go = effectEntity:View():GetGameObject()
      if go then
        local transform = go.transform
        go.transform.localEulerAngles = Vector3(90, 0, 0)
        local lineRender = transform:GetComponent("LineRenderer")
        mat = lineRender.material
        local guidePathMaxCount = #guidePath
        lineRender.positionCount = guidePathMaxCount
        local boardServiceRender = self._world:GetService("BoardRender")
        for guidePosIndex = 1, guidePathMaxCount do
          local realPos = boardServiceRender:GridPos2RenderPos(guidePath[guidePosIndex])
          lineRender:SetPosition(guidePosIndex - 1, realPos)
        end
        mat:SetFloat("_Panner", 0)
        table.insert(self._effectEntitys, effectEntity)
        table.insert(self._mats, mat)
      end
    end
  end
end

function GuideWeakPathSystem_Render:_DestroyGuideWeakLinkLine()
  for _, effectEntity in ipairs(self._effectEntitys) do
    if effectEntity ~= nil then
      self._world:DestroyEntity(effectEntity)
    end
  end
  self._effectEntitys = {}
  if self._mats[1] then
    self._mats[1]:SetFloat("_Panner", 0)
  end
  if self._mats[2] then
    self._mats[2]:SetFloat("_Panner", 0)
  end
  self._mats = {}
  self._waitTime1 = nil
  self._waitTime2 = nil
  self:RemoveTick()
end
