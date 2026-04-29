_class("UICN17N46FishingGameFish", UICustomWidget)
UICN17N46FishingGameFish = UICN17N46FishingGameFish

function UICN17N46FishingGameFish:OnShow()
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self.IsRotate = false
  self._currentRotateTime = 0
  self._rotateTime = 0.2
  self._bornNoRotateSwimTime = 3
  self._currentBornTime = 0
  self._swimSpeedMult = Cfg.cfg_fishing_minigame[1].SkillFishSpeedMult
end

function UICN17N46FishingGameFish:Constructor()
end

function UICN17N46FishingGameFish:SetData(Id, originPos, originRot, shadow)
  self._fishId = Id
  self._fishCfg = Cfg.cfg_fishing_fish({ID = Id})[1]
  self._spine:SetAnimation(0, self._fishCfg.SpineName, true)
  self._spine.transform.localPosition = originPos
  self._spine.transform.localEulerAngles = originRot
  self._startPos = self._spine.transform.localPosition
  self._randomChangeRotationPercent = self._fishCfg.RotateProbability
  self._randomChangeRotationInterval = self._fishCfg.RotateInterval
  self._randomChangeSpeedPercent = self._fishCfg.ChangeSpeedProbability
  self._randomChangeSpeedInterval = self._fishCfg.ChangeSpeedInterval
  self._currentChangeSpeedWait = 0
  self._currentChangeRotationWait = 0
  self._swimSpeed = math.random(self._fishCfg.Speed[1], self._fishCfg.Speed[2])
  self._spine.gameObject.transform.localScale = Vector3.one * self._fishCfg.Scale
  self._spine.transform.parent.gameObject:SetActive(true)
  self.state = FishingFishState.Born
  if shadow then
    self._shadow = shadow
  end
  if self._shadow then
    self._shadow:SetShadow(self._fishCfg.FishShadow, self._fishCfg.ShadowScale)
    self._shadow:UpdatePosAndAngle(originPos, originRot, 30)
    self._shadow:SetVisible(true)
  end
end

function UICN17N46FishingGameFish:Swim(deltaTimeMS, state)
  if self.IsRotate == true then
    self._currentRotateTime = self._currentRotateTime + deltaTimeMS / 1000
    if self._currentRotateTime > self._rotateTime then
      self.IsRotate = false
      self._currentRotateTime = 0
    end
  else
    self._currentChangeRotationWait = self._currentChangeRotationWait + deltaTimeMS / 1000
    self._currentChangeSpeedWait = self._currentChangeSpeedWait + deltaTimeMS / 1000
    if self.state == FishingFishState.Born and self:CheckSwimInScreen() or state == FishingGameState.Skill then
      self.state = FishingFishState.Swimming
    end
    if self.state ~= FishingFishState.Born and self._currentChangeRotationWait >= self._randomChangeRotationInterval then
      local r = math.random(1, 100)
      if r >= self._randomChangeRotationPercent then
        local angles = self._spine.transform.localEulerAngles
        angles.z = angles.z + math.random(-10, 10)
        self._spine.transform.localEulerAngles = angles
      end
      self._currentChangeRotationWait = 0
    end
    if self._currentChangeSpeedWait >= self._randomChangeSpeedInterval then
      local r = math.random(1, 100)
      if r > self._randomChangeSpeedPercent then
        self._swimSpeed = math.random(self._fishCfg.Speed[1], self._fishCfg.Speed[2])
      end
      self._currentChangeSpeedWait = 0
    end
  end
  if state == FishingGameState.Skill then
    self._spine.transform.localPosition = self._spine.transform.localPosition + self._spine.transform.up * deltaTimeMS / 1000 * self._swimSpeed * 50 * self._swimSpeedMult
  else
    self._spine.transform.localPosition = self._spine.transform.localPosition + self._spine.transform.up * deltaTimeMS / 1000 * self._swimSpeed * 50
  end
  self._shadow:UpdatePosAndAngle(self._spine.transform.localPosition, self._spine.transform.localEulerAngles, 30)
end

function UICN17N46FishingGameFish:ForceSetPosition(position, originRot)
  self._spine.transform.localPosition = position
  self._spine.transform.localEulerAngles = originRot
  self._shadow:UpdatePosAndAngle(self._spine.transform.localPosition, self._spine.transform.localEulerAngles, 30)
end

function UICN17N46FishingGameFish:IsSwimmingState()
  return self.state == FishingFishState.Swimming
end

function UICN17N46FishingGameFish:IsDead()
  return self.state == FishingFishState.Die
end

function UICN17N46FishingGameFish:GetFishLength()
  return self._fishCfg.FishLength
end

function UICN17N46FishingGameFish:CheckReachedEdge(topEdgeY, bottomEdgeY, leftEdgeX, rightEdgeX, checkValue)
  local reachTop = (topEdgeY - self._spine.transform.localPosition.y) * (topEdgeY - self._spine.transform.localPosition.y) <= checkValue * checkValue
  if reachTop then
  end
  local reachBottom = (bottomEdgeY - self._spine.transform.localPosition.y) * (bottomEdgeY - self._spine.transform.localPosition.y) <= checkValue * checkValue
  if reachBottom then
  end
  local reachLeft = (leftEdgeX - self._spine.transform.localPosition.x) * (leftEdgeX - self._spine.transform.localPosition.y) <= checkValue * checkValue
  if reachLeft then
  end
  local reachRight = (rightEdgeX - self._spine.transform.localPosition.x) * (rightEdgeX - self._spine.transform.localPosition.y) <= checkValue * checkValue
  if reachRight then
  end
  local vec = Vector3(0, 0, 0)
  if reachTop or reachBottom or reachLeft or reachRight then
    if reachLeft then
      vec = Vector3(0, 0, math.random(30, 150))
    end
    if reachRight then
      vec = Vector3(0, 0, math.random(-150, -30))
    end
    if reachTop then
      vec = Vector3(0, 0, math.random(120, 240))
      if reachLeft then
        vec = Vector3(0, 0, math.random(210, 240))
      end
      if reachRight then
        vec = Vector3(0, 0, math.random(120, 150))
      end
    end
    if reachBottom then
      vec = Vector3(0, 0, math.random(-60, 60))
      if reachLeft then
        vec = Vector3(0, 0, math.random(-60, -30))
      end
      if reachRight then
        vec = Vector3(0, 0, math.random(30, 60))
      end
    end
    self._spine.transform.localEulerAngles = vec
    self:ResetChangeSpeedAndRotationTime()
    return true
  end
  return false
end

function UICN17N46FishingGameFish:ResetChangeSpeedAndRotationTime()
  self._currentChangeRotationWait = 0
  self._currentChangeSpeedWait = 0
end

function UICN17N46FishingGameFish:CheckCatched(camera, netPos, netRadius)
  local screenPos = camera:WorldToScreenPoint(self._spine.transform.position)
  local dis = Vector3.Distance(netPos, screenPos)
  return netRadius > dis and screenPos.y > 0
end

function UICN17N46FishingGameFish:Die()
  self.state = FishingFishState.Die
  self._spine.transform.parent.gameObject:SetActive(false)
  self._shadow:SetVisible(false)
  self._currentRotateTime = 0
  self._currentBornTime = 0
end

function UICN17N46FishingGameFish:CheckSwimInScreen()
  if self._camera then
    local screenPos = self._camera:WorldToScreenPoint(self._spine.transform.position)
    return screenPos.y > self._fishCfg.FishLength
  end
  return false
end

function UICN17N46FishingGameFish:SetCamera(camera)
  self._camera = camera
end

function UICN17N46FishingGameFish:DoSkill()
end
