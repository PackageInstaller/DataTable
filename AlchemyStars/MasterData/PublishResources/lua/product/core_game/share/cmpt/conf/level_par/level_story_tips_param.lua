_class("LevelStoryTipsParam", Object)
LevelStoryTipsParam = LevelStoryTipsParam

function LevelStoryTipsParam:Constructor(t)
  self._type = t.Type
  self._param = t.Param
  self._tipsID = t.TipsID
  self._speakerType = t.SpeakerType
  self._speakerMonsterID = t.SpeakerMonsterID
end

function LevelStoryTipsParam:GetSpeakerType()
  return self._speakerType
end

function LevelStoryTipsParam:GetSpeakerMonsterID()
  return self._speakerMonsterID
end

function LevelStoryTipsParam:GetType()
  return self._type
end

function LevelStoryTipsParam:GetParam()
  return self._param
end

function LevelStoryTipsParam:GetID()
  return self._tipsID
end

_class("StoryTipsParam", Object)
StoryTipsParam = StoryTipsParam

function StoryTipsParam:Constructor(t)
  self._text = t.Text
  self._duration = nil
  if t.Duration then
    self._duration = t.Duration
  else
    self._duration = BattleConst.StoryTipsDuration
  end
end

function StoryTipsParam:GetText()
  local text = StringTable.Get(self._text)
  return text
end

function StoryTipsParam:GetDuration()
  return self._duration
end
