_class("BuffViewChangeSkillIncreaseWithLayer", BuffViewBase)
BuffViewChangeSkillIncreaseWithLayer = BuffViewChangeSkillIncreaseWithLayer

function BuffViewChangeSkillIncreaseWithLayer:PlayView(TT)
end

_class("BuffViewRemoveSkillIncreaseWithLayer", BuffViewBase)
BuffViewRemoveSkillIncreaseWithLayer = BuffViewRemoveSkillIncreaseWithLayer

function BuffViewRemoveSkillIncreaseWithLayer:PlayView(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
