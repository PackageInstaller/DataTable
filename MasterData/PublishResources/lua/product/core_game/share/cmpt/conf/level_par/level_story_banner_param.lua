_class("LevelStoryBannerParam", Object)
LevelStoryBannerParam = LevelStoryBannerParam

function LevelStoryBannerParam:Constructor(t)
  self._type = t.Type
  self._param = t.Param
  self._bannerID = t.BannerID
  self._showType = t.ShowType
end

function LevelStoryBannerParam:GetType()
  return self._type
end

function LevelStoryBannerParam:GetParam()
  return self._param
end

function LevelStoryBannerParam:GetID()
  return self._bannerID
end

function LevelStoryBannerParam:GetShowType()
  return self._showType
end

_class("StoryBannerParam", Object)
StoryBannerParam = StoryBannerParam

function StoryBannerParam:Constructor(t)
  self._text = t.Text
  self._speaker = t.Speaker
  self._speakerName = t.SpeakerName
  self._headIcon = t.HeadIcon
  self._speakerNameLineType = t.SpeakerLineType
  self._showBlackBg = t.ShowBlackBg
  self._spineName = t.SpineName
  self._spineAnim = t.SpineAnim
end

function StoryBannerParam:GetText()
  local text = StringTable.Get(self._text)
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  text = string.gsub(text, "PlayerName", name)
  return text
end

function StoryBannerParam:GetSpeakerName()
  local speakerName = StringTable.Get(self._speakerName)
  return speakerName
end

function StoryBannerParam:GetHeadIconName()
  return self._headIcon
end

function StoryBannerParam:GetSpeaker()
  return self._speaker
end

function StoryBannerParam:GetSpeakerNameLineType()
  return self._speakerNameLineType
end

function StoryBannerParam:IsSameSpeaker(speaker)
  return self._speaker == speaker
end

function StoryBannerParam:IsSpine()
  return self._spineName ~= nil
end

function StoryBannerParam:GetSpineName()
  return self._spineName
end

function StoryBannerParam:GetSpineAnim()
  return self._spineAnim
end

_class("LevelCutsceneParam", Object)
LevelCutsceneParam = LevelCutsceneParam

function LevelCutsceneParam:Constructor(t)
  self._type = t.Type
  self._param = t.Param
  self._cutsceneID = t.CutsceneID
end

function LevelCutsceneParam:GetID()
  return self._cutsceneID
end

function LevelCutsceneParam:GetType()
  return self._type
end
