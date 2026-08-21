_class("Monster", BehaviorMgr)
Monster = Monster
Monster.AutoAppendPstID = 1

function Monster:Constructor(monsterId)
  self._monsterId = monsterId
  self.monsterData = MonsterData:New(monsterId)
  self.state = BounceObjState.Alive
  self.pstID = Monster.AutoAppendPstID
  Monster.AutoAppendPstID = Monster.AutoAppendPstID + 1
end

function Monster:GetPstId()
  return self.pstID
end

function Monster:GetMonsterId()
  return self._monsterId
end

function Monster:SetCoreController(coreController)
  self.coreController = coreController
  local generator = self:GetBehavior("MonsterBeHaviorGenerator")
  if generator then
    generator:SetCoreController()
  end
end

function Monster:GetCoreController()
  return self.coreController
end

function Monster:AddBehavior(behavior)
  self.super.AddBehavior(self, behavior)
  behavior:SetMonster(self)
end

function Monster:GetMonsterData()
  return self.monsterData
end

function Monster:OnUpdate(deltaMS)
  self.monsterData.durationMS = self.monsterData.durationMS + deltaMS
  if self.state == BounceObjState.Dead then
    return true
  elseif self.state == BounceObjState.Transformation then
    if self.monsterData.durationMS >= self.endTransformTime then
      if self.transmationEndCall then
        self.transmationEndCall()
      end
      self.state = BounceObjState.Alive
    end
    return false
  elseif self.state == BounceObjState.Deading then
    if self.monsterData.durationMS >= self.deadTime then
      self.state = BounceObjState.Dead
      return true
    end
    return false
  end
  local moveBehavior = self:GetBehavior(MonsterBeHaviorMove:Name())
  if moveBehavior then
    local newPos = moveBehavior:Exec(deltaMS)
    if newPos.x < BounceConst.CanvasMinX or newPos.x > BounceConst.CanvasMaxX then
      return true
    end
  end
  local generatorBehavior = self:GetBehavior(MonsterBeHaviorGenerator:Name())
  if generatorBehavior then
    generatorBehavior:Exec(deltaMS)
  end
  return false
end

function Monster:Clear()
  self:Reset()
  self.state = BounceObjState.Alive
end

function Monster:Destroy()
  self:Release()
end

function Monster:GetRect()
  local viewBeHavior = self:GetBehavior(MonsterBeHaviorView:Name())
  return viewBeHavior:GetRect()
end

function Monster:SetState(state)
  self.state = state
end

function Monster:SetDeadWithDuration(duration)
  if 0 < duration then
    self.state = BounceObjState.Deading
    self.deadTime = self.monsterData.durationMS + duration
  else
    self.state = BounceObjState.Dead
  end
end

function Monster:SetTransformation(duration, callback)
  self.state = BounceObjState.Transformation
  self.transmationEndCall = callback
  self.endTransformTime = self.monsterData.durationMS + duration
end

function Monster:GetBounceRect()
  local behaviorView = self:GetBehavior(MonsterBeHaviorView:Name())
  if behaviorView then
    return behaviorView:GetBounceRect()
  end
  return nil
end

function Monster:GetPosition()
  local behaviorView = self:GetBehavior(MonsterBeHaviorView:Name())
  if behaviorView then
    return behaviorView:GetPosition()
  end
end
