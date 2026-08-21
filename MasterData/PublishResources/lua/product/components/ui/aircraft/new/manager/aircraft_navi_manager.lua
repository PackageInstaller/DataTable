_class("AircraftNaviManager", Object)
AircraftNaviManager = AircraftNaviManager

function AircraftNaviManager:Constructor(main)
  self._groupSeq = 0
  self._main = main
  self._normalGroups = {}
  self._specailGroups = {}
  self._actions = {}
end

function AircraftNaviManager:Init()
end

function AircraftNaviManager:Dispose()
end

function AircraftNaviManager:Update(deltaTimeMS)
  for seq, group in pairs(self._normalGroups) do
    group:Update(deltaTimeMS)
    if group:IsDissolved() then
      self._normalGroups[seq] = nil
    end
  end
  for seq, group in pairs(self._specailGroups) do
    group:Update(deltaTimeMS)
    if group:IsDissolved() then
      self._specailGroups[seq] = nil
    end
  end
end

function AircraftNaviManager:OnPetBlocked(pet, moveAction)
  if self._actions[pet:PstID()] then
    Log.fatal("正在处理该星灵：", pet:TemplateID(), "，是否为拜访:", pet:IsVisitPet())
    return
  end
  AirLog("开始处理拥堵星灵:", pet:TemplateID(), "，唯一id:", pet:PstID())
  self._actions[pet:PstID()] = moveAction
  local nearTarget = AircraftNaviHelper.IsPetNearTarget(pet)
  if nearTarget then
    for _, group in pairs(self._specailGroups) do
      if group:TryAdd(pet) then
        AirLog("趋近目标点星灵加入特殊组:", pet:TemplateID())
        return
      end
    end
    AirLog("趋近目标点星灵未成组:", pet:TemplateID())
    local group = AircraftPetGroupSpecail:New(pet, self:_seq(), function(pet)
      self:onContinue(pet)
    end)
    self._specailGroups[group:Seq()] = group
  else
    for _, group in pairs(self._normalGroups) do
      if group:TryAdd(pet) then
        AirLog("被阻挡星灵加入普通组:", pet:TemplateID())
        return
      end
    end
    AirLog("普通被阻挡星灵未成组:", pet:TemplateID())
    local group = AircraftPetGroupNormal:New(pet, self:_seq(), function(pet)
      self:onContinue(pet)
    end)
    self._normalGroups[group:Seq()] = group
  end
end

function AircraftNaviManager:_seq()
  self._groupSeq = self._groupSeq + 1
  return self._groupSeq
end

function AircraftNaviManager:TryRemovePet(pet)
  if self._actions[pet:PstID()] then
    self._actions[pet:PstID()] = nil
    for key, group in pairs(self._specailGroups) do
      if group:TryRemove(pet) then
        AirLog("删除1个特殊组星灵:", pet:TemplateID())
        return true
      end
    end
    for key, group in pairs(self._normalGroups) do
      if group:TryRemove(pet) then
        AirLog("删除1个拥堵星灵:", pet:TemplateID())
        return true
      end
    end
    Log.exception("找不到需要删除的拥堵星灵:", pet:TemplateID(), "，是否为拜访:", pet:IsVisitPet())
  end
  return false
end

function AircraftNaviManager:onContinue(pet)
  local action = self._actions[pet:PstID()]
  self._actions[pet:PstID()] = nil
  AirLog("星灵拥堵处理完成，继续走:", pet:TemplateID(), "，唯一id:", pet:PstID())
  action:Resume()
end

_class("AircraftNaviHelper", Object)
AircraftNaviHelper = AircraftNaviHelper

function AircraftNaviHelper.IsBlock(pet1, pet2)
  if pet1:GetFloor() == pet2:GetFloor() then
    local distance = Vector3.Distance(pet1:WorldPosition(), pet2:WorldPosition())
    local radius = pet1:NaviRadius() + pet2:NaviRadius()
    if distance < radius + 0.5 then
      return true
    end
  end
  return false
end

function AircraftNaviHelper.SameAndNearTarget(pet1, pet2)
  if pet1:HasMoveTarget() and pet2:HasMoveTarget() then
    if Vector3.Distance(pet1:GetMoveTarget(), pet2:GetMoveTarget()) < 0.1 then
      local d1 = pet1:GetMoveTarget() - pet1:WorldPosition()
      d1.y = 0
      if d1:Magnitude() < pet1:NaviRadius() + 0.05 then
        return true
      end
      local d2 = pet2:GetMoveTarget() - pet2:WorldPosition()
      d2.y = 0
      if d2:Magnitude() < pet2:NaviRadius() + 0.05 then
        return true
      end
    end
    return
  end
  return false
end

function AircraftNaviHelper.IsPetNearTarget(pet)
  if pet:HasMoveTarget() then
    local d1 = pet:GetMoveTarget() - pet:WorldPosition()
    d1.y = 0
    if d1:Magnitude() < pet:NaviRadius() + 2 then
      return true
    end
  end
  return false
end

_class("AircraftPetWaiter", Object)
AircraftPetWaiter = AircraftPetWaiter

function AircraftPetWaiter:Constructor(pet, duration)
  self._time = duration
  self._pet = pet
  self._timeUp = false
end

function AircraftPetWaiter:Update(deltaTimeMS)
  self._time = self._time - deltaTimeMS
  if self._time <= 0 then
    self._timeUp = true
  end
end

function AircraftPetWaiter:RemainTime()
  return self._time
end

function AircraftPetWaiter:TimeUp()
  return self._timeUp
end

function AircraftPetWaiter:Pet()
  return self._pet
end

_class("AircraftWaitQueue", Object)
AircraftWaitQueue = AircraftWaitQueue

function AircraftWaitQueue:Constructor()
  self._queue = AircraftQueue:New()
end

_class("AircraftPetGroupNormal", Object)
AircraftPetGroupNormal = AircraftPetGroupNormal

function AircraftPetGroupNormal:Constructor(pet, seq, onContinue)
  self._seq = seq
  self._queue = AircraftQueue:New()
  self._onContinue = onContinue
  self._floor = pet:GetFloor()
  local waiter = AircraftPetWaiter:New(pet, math.random(1200, 3000))
  self._queue:Enqueue(waiter)
end

function AircraftPetGroupNormal:Seq()
  return self._seq
end

function AircraftPetGroupNormal:Update(dt)
  if self:IsDissolved() then
    return
  end
  local waiter = self._queue:Peek()
  waiter:Update(dt)
  if waiter:TimeUp() then
    self._queue:Dequeue()
    self._onContinue(waiter:Pet())
  end
end

function AircraftPetGroupNormal:IsDissolved()
  return self._queue:Count() == 0
end

function AircraftPetGroupNormal:TryAdd(pet)
  if pet:GetFloor() ~= self._floor then
    return false
  end
  local contains = self._queue:ContainsBy(function(w)
    local waiter = w
    if AircraftNaviHelper.IsBlock(waiter:Pet(), pet) then
      return true
    end
  end)
  if contains then
    local waiter = AircraftPetWaiter:New(pet, math.random(1200, 3000))
    self._queue:Enqueue(waiter)
    return true
  end
  return false
end

function AircraftPetGroupNormal:TryRemove(pet)
  local contains = self._queue:RemoveFirst(function(w)
    local waiter = w
    if waiter:Pet():PstID() == pet:PstID() then
      return true
    end
    return false
  end)
  return contains
end

_class("AircraftPetGroupSpecail", AircraftPetGroupNormal)
AircraftPetGroupSpecail = AircraftPetGroupSpecail

function AircraftPetGroupSpecail:Update(dt)
  if self:IsDissolved() then
    return
  end
  local waiter = self._queue:Peek()
  waiter:Update(dt)
  if waiter:TimeUp() then
    local pet = waiter:Pet()
    self._queue:Dequeue()
    self._onContinue(pet)
  end
end

function AircraftPetGroupSpecail:TryAdd(pet)
  if pet:GetFloor() ~= self._floor then
    return false
  end
  local contains = self._queue:ContainsBy(function(w)
    local waiter = w
    if AircraftNaviHelper.SameAndNearTarget(waiter:Pet(), pet) then
      return true
    end
  end)
  if contains then
    pet:NaviObstacle().enabled = false
    local waiter = AircraftPetWaiter:New(pet, math.random(1200, 3000))
    self._queue:Enqueue(waiter)
    return true
  end
  return false
end
