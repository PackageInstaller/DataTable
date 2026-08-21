_class("HomelandPetBehaviorFactory", Object)
HomelandPetBehaviorFactory = HomelandPetBehaviorFactory

function HomelandPetBehaviorFactory:Constructor()
  self._behaviors = {}
  self:_Register()
end

function HomelandPetBehaviorFactory:_RegistorBehavior(behaviorType, behavior)
  local _behavior = self._behaviors[behaviorType]
  if nil ~= _behavior then
    Log.error("HomelandPetBehavior is exist! HomelandPetBehaviorType:", behaviorType, ", Behavior:", _behavior)
    return
  end
  self._behaviors[behaviorType] = behavior
end

function HomelandPetBehaviorFactory:CreateHomelandPetBehavior(behaviorType, pet)
  local type = self._behaviors[behaviorType]
  if not type then
    Log.error("HomelandPetBehavior is not exist! HomelandPetBehaviorType:", behaviorType)
    return
  end
  local behavior = type:New(behaviorType, pet)
  if not behavior then
    Log.error("HomelandPetBehavior create fail! HomelandPetBehaviorType:", behaviorType)
    return
  end
  return behavior
end

function HomelandPetBehaviorFactory:_Register()
  self:_RegistorBehavior(HomelandPetBehaviorType.Free, HomelandPetBehaviorFree)
  self:_RegistorBehavior(HomelandPetBehaviorType.Roam, HomelandPetBehaviorRoam)
  self:_RegistorBehavior(HomelandPetBehaviorType.InteractingPlayer, HomelandPetBehaviorInteractingPlayer)
  self:_RegistorBehavior(HomelandPetBehaviorType.Following, HomelandPetBehaviorFollowing)
  self:_RegistorBehavior(HomelandPetBehaviorType.InteractingFurniture, HomelandPetBehaviorInteractingFurniture)
  self:_RegistorBehavior(HomelandPetBehaviorType.TreasureIdle, HomelandPetBehaviorTreasure)
  self:_RegistorBehavior(HomelandPetBehaviorType.GreetPlayer, HomelandPetBehaviorGreetPlayer)
  self:_RegistorBehavior(HomelandPetBehaviorType.StoryWaitingStand, HomelandPetBehaviorStoryWaitingStand)
  self:_RegistorBehavior(HomelandPetBehaviorType.StoryWaitingWalk, HomelandPetBehaviorStoryWaitingWalk)
  self:_RegistorBehavior(HomelandPetBehaviorType.StoryWaitingBuild, HomelandPetBehaviorStoryWaitingBuild)
  self:_RegistorBehavior(HomelandPetBehaviorType.StoryWaitingBuildStand, HomelandPetBehaviorStoryWaitingBuildStand)
  self:_RegistorBehavior(HomelandPetBehaviorType.StoryPlaying, HomelandPetBehaviorStoryPlaying)
  self:_RegistorBehavior(HomelandPetBehaviorType.SwimmingPool, HomelandPetBehaviorSwimmingPool)
  self:_RegistorBehavior(HomelandPetBehaviorType.FishingPrepare, HomelandPetBehaviorFishingPrepare)
  self:_RegistorBehavior(HomelandPetBehaviorType.FishingMatch, HomelandPetBehaviorFishingMatch)
end
