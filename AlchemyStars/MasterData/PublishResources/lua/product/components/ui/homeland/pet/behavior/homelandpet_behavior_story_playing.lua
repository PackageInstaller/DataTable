require("homelandpet_behavior_base")
_class("HomelandPetBehaviorStoryPlaying", HomelandPetBehaviorBase)
HomelandPetBehaviorStoryPlaying = HomelandPetBehaviorStoryPlaying

function HomelandPetBehaviorStoryPlaying:Constructor(behaviorType, pet)
  HomelandPetBehaviorStoryPlaying.super.Constructor(self, behaviorType, pet)
end

function HomelandPetBehaviorStoryPlaying:Enter()
  HomelandPetBehaviorStoryPlaying.super.Enter(self)
end

function HomelandPetBehaviorStoryPlaying:Exit()
  HomelandPetBehaviorStoryPlaying.super.Exit(self)
end

function HomelandPetBehaviorStoryPlaying:CanInterrupt()
  return true
end
