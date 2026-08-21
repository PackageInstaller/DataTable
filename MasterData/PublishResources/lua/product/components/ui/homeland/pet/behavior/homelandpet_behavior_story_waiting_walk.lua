require("homelandpet_behavior_base")
_class("HomelandPetBehaviorStoryWaitingWalk", HomelandPetBehaviorBase)
HomelandPetBehaviorStoryWaitingWalk = HomelandPetBehaviorStoryWaitingWalk

function HomelandPetBehaviorStoryWaitingWalk:Constructor(behaviorType, pet)
  HomelandPetBehaviorStoryWaitingWalk.super.Constructor(self, behaviorType, pet)
  self._yieldTime = 0
  self._moveComponent = self:GetComponent(HomelandPetComponentType.Move)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
end

function HomelandPetBehaviorStoryWaitingWalk:Enter()
  HomelandPetBehaviorStoryWaitingWalk.super.Enter(self)
  self._bubbleComponent:Show()
  if self._inited then
    local target = self:GetNextTarget()
    if target then
      self._moveComponent:SetTarget(target)
    end
  end
end

function HomelandPetBehaviorStoryWaitingWalk:Exit()
  HomelandPetBehaviorStoryWaitingWalk.super.Exit(self)
  self._yieldTime = 0
end

function HomelandPetBehaviorStoryWaitingWalk:CanInterrupt()
  return true
end

function HomelandPetBehaviorStoryWaitingWalk:Update(dms)
  if self._type then
    self._yieldTime = self._yieldTime - dms
    if self._yieldTime <= 0 then
      self._yieldTime = 1000
      if self._moveComponent.state == HomelandPetComponentState.Success then
        self._moveComponent:Stop()
        self._moveComponent:Resting()
        local target = self:GetNextTarget()
        if target then
          self._moveComponent:SetTarget(target)
        end
      end
    end
  end
  HomelandPetBehaviorStoryWaitingWalk.super.Update(self, dms)
end

function HomelandPetBehaviorStoryWaitingWalk:GetNextTarget()
  local target
  if self._type == 1 then
    target = HomelandNavmeshTool:GetInstance():GetRandomPositionCircle(self._r, self._coc)
  elseif self._type == 2 then
    local randomList = {}
    for i = 1, #self._posList do
      if self._oldPosIdx == i then
      else
        local data = {}
        data.idx = i
        data.pos = self._posList[i]
        table.insert(randomList, data)
      end
    end
    if 0 < #randomList then
      local idx = math.random(1, #randomList)
      local data = randomList[idx]
      target = data.pos
      self._oldPosIdx = data.idx
    else
      Log.debug("###[HomelandPetBehaviorStoryWaitingWalk] randomList is empty !")
    end
  end
  return target
end

function HomelandPetBehaviorStoryWaitingWalk:TriggerSucc(type, cfg)
  self.triggerSuccParam = {type, cfg}
  self._type = type
  local startPos
  local succ = true
  if self._type == 1 then
    self._coc = Vector3(cfg.WalkPos[1], cfg.WalkPos[2], cfg.WalkPos[3])
    self._r = cfg.WalkR
    startPos = self._coc
  elseif self._type == 2 then
    self._posList = {}
    for i = 1, #cfg.WalkPoints do
      local pos = Vector3(cfg.WalkPoints[i][1], cfg.WalkPoints[i][2], cfg.WalkPoints[i][3])
      table.insert(self._posList, pos)
    end
    if #self._posList <= 0 then
      self._type = nil
      Log.error("###[HomelandPetBehaviorStoryWaitingWalk] 触发失败，#self._posList <= 0。ID-->", cfg.ID)
      succ = false
    else
      startPos = self._posList[1]
    end
  else
    self._type = nil
    Log.error("###[HomelandPetBehaviorStoryWaitingWalk] 触发失败，type[", type, "] ID-->", cfg.ID)
    succ = false
  end
  if startPos then
    self._pet:SetPosition(startPos)
    local target = self:GetNextTarget()
    if target then
      self._moveComponent:SetTarget(target)
    end
  end
  self._inited = true
  return succ
end
