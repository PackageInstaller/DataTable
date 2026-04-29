require("homelandpet_behavior_base")
_class("HomelandPetBehaviorFishingPrepare", HomelandPetBehaviorBase)
HomelandPetBehaviorFishingPrepare = HomelandPetBehaviorFishingPrepare

function HomelandPetBehaviorFishingPrepare:Constructor(behaviorType, pet)
  HomelandPetBehaviorFishingPrepare.super.Constructor(self, behaviorType, pet)
end

function HomelandPetBehaviorFishingPrepare:Dispose()
end

function HomelandPetBehaviorFishingPrepare:Enter()
  HomelandPetBehaviorTreasure.super.Enter(self)
  local type = HomelandMimimapIconMarkType.FishingMatch
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnInitMinimapIconMark, type, self._pet:TemplateID())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAddMinimapIconMark, type, self._pet:TemplateID())
end

function HomelandPetBehaviorFishingPrepare:Update(dms)
  HomelandPetBehaviorFishingPrepare.super.Update(self, dms)
end

function HomelandPetBehaviorFishingPrepare:Exit()
  HomelandPetBehaviorFishingPrepare.super.Exit(self)
  local type = HomelandMimimapIconMarkType.FishingMatch
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnRemoveMinimapIconMark, type, self._pet:TemplateID())
end

function HomelandPetBehaviorFishingPrepare:Finish()
  return false
end
