_class("BuffViewPlayBGM", BuffViewBase)
BuffViewPlayBGM = BuffViewPlayBGM

function BuffViewPlayBGM:PlayView(TT, notify)
  local result = self._buffResult
  local bgmID = result:GetBGMID()
  local useLevelBGM = result:GetuseLevelBGM()
  if useLevelBGM and useLevelBGM == 1 then
    local configService = self._world:GetService("Config")
    local levelConfigData = configService:GetLevelConfigData()
    bgmID = levelConfigData:GetBgmID()
  end
  AudioHelperController.PlayBGMById(bgmID, AudioConstValue.BGMCrossFadeTime)
end

function BuffViewPlayBGM:IsNotifyMatch(notify)
  return true
end
