local MiniGameMusicController = class("MiniGameMusicController", ControllerBase)
local base = ControllerBase
local CS_Input = CS.UnityEngine.Input
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local midi = require("Common.Tools.MIDI.lib.midi")
local TinyGameMussicSoundPlayData = require("Game.TinyGames.Music.TinyGameMussicSoundPlayData")
local CustomCSStreamReader = require("Framework.Lib.CustomCSStreamReader")

function MiniGameMusicController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.instrument_music)
  ConfigData:LoadDynCfg(eDynConfigData.instrument_music_audio)
  ConfigData:LoadDynCfg(eDynConfigData.tiny_game_instrument)
  self.instrumentId = 1
end

function MiniGameMusicController:InitTiniGameActivityData(actType, actId, actFrameData)
  self.actType = actType
  self.actId = actId
  self.actFrameData = actFrameData
  local activityFrameId = actFrameData:GetActivityFrameId()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local tinyGameData = activityFrameCtrl:GetTinyGameData(activityFrameId)
  if tinyGameData ~= nil and self.tinyGameMussicSoundPlayData == nil then
    self.tinyGameMussicSoundPlayData = TinyGameMussicSoundPlayData.New(activityFrameId, tinyGameData:GetTinyGameId(), tinyGameData:GetTinyGameCat())
  end
end

function MiniGameMusicController:GetTinyGameSoundPlayData()
  return self.tinyGameMussicSoundPlayData
end

function MiniGameMusicController:SetMusicInstrument(instrumentId)
  self.instrumentId = instrumentId
end

function MiniGameMusicController:SetMusicTimeLine(timeline)
  self.miniGameMusicTimeLine = timeline
end

function MiniGameMusicController:PlayMusicTimeline(isRewind)
  if IsNull(self.miniGameMusicTimeLine) then
    return
  end
  self:StopMusicTimeline()
  if isRewind then
    self.miniGameMusicCo = TimelineUtil.Rewind(self.miniGameMusicTimeLine, nil, false, true)
  else
    self.miniGameMusicCo = TimelineUtil.Play(self.miniGameMusicTimeLine, nil, false, true)
  end
end

function MiniGameMusicController:StopMusicTimeline()
  local commonMaskWin = UIManager:GetWindow(UIWindowTypeID.CommonMask)
  if commonMaskWin ~= nil then
    commonMaskWin:CommonMaskDOKill(false)
    UIManager:HideWindow(UIWindowTypeID.CommonMask)
  end
  if self.miniGameMusicCo == nil then
    return
  end
  TimelineUtil.StopTlCo(self.miniGameMusicCo)
  self.miniGameMusicCo = nil
end

function MiniGameMusicController:_MusicMaskFadeOut(callback)
  UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeOut(0.5, function()
    UIManager:HideWindow(UIWindowTypeID.CommonMask)
    if callback ~= nil then
      callback()
    end
  end)
end

function MiniGameMusicController:_MusicMaskFadeIn(callback)
  UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeIn(0.5, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function MiniGameMusicController:SetOutMiniGameAudioOpen(isOpen)
  if isOpen then
    AudioManager:ResumeLastBgm()
    AudioManager:RemoveAllVoice(true)
    CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen or false
  else
    AudioManager:RecordCurBgm()
    AudioManager:StopSource(eAudioSourceType.BgmSource)
    AudioManager:RemoveAllVoice(true)
    self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
    CS_Input.multiTouchEnabled = true
  end
end

function MiniGameMusicController:_ShowMiniGameFunc(beforeShowCallback, closeCallback, gameCfg)
  self.beforeShowCallback = beforeShowCallback
  self.closeCallback = closeCallback
  self:SetOutMiniGameAudioOpen(false)
  self:PlayMusicTimeline(false)
  self:_MusicMaskFadeIn(function()
    if self.beforeShowCallback ~= nil then
      beforeShowCallback()
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.MiniGameMusic, function(window)
      if window == nil then
        return
      end
      window:InitMiniGameMusic(gameCfg)
    end)
    self:_MusicMaskFadeOut()
  end)
end

function MiniGameMusicController:ShowMiniGameMusicUIMain(beforeShowCallback, closeCallback, gameCfgId)
  local musicCfg = ConfigData.tiny_game_instrument[gameCfgId]
  if musicCfg == nil then
    return
  end
  PlayerClickCollectManager:BtnClickNumCollect(1008)
  local avgid = musicCfg.instru_avg
  if 0 < avgid then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgid)
    if not played then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgid, function()
        self:_ShowMiniGameFunc(beforeShowCallback, closeCallback, musicCfg)
      end)
      return
    end
  end
  self:_ShowMiniGameFunc(beforeShowCallback, closeCallback, musicCfg)
end

function MiniGameMusicController:GetMusicUiCfg(keyId)
  return ConfigData.instrument_music[keyId]
end

function MiniGameMusicController:GetMusicAudioIdByKeyId(keyId)
  return ConfigData.instrument_music_audio[self.instrumentId][keyId].audio_id
end

function MiniGameMusicController:StartSoundPlayMode(rhythmCfg, resloader, noteOnCallback, noteOffCallback)
  local currentNote
  local currentTickCount = 0
  local detlaTimeAccumulation = 0
  local noteToBtnMap = {}
  for index, data in ipairs(ConfigData.instrument_music) do
    noteToBtnMap[data.note] = index
  end
  local midiAsset = resloader:LoadABAsset(PathConsts:GetMidiPath(rhythmCfg.midi))
  if midiAsset == nil then
    error("文件不存在！" .. PathConsts:GetMidiPath(rhythmCfg.midi))
    return
  end
  if self.midiSteamReader ~= nil then
    self.midiSteamReader:close()
    self.midiSteamReader = nil
  end
  local midiBytes = midiAsset.bytes
  self.midiSteamReader = CustomCSStreamReader.New(midiBytes)
  self.midiSteamReader:seek("set")
  local tracks = midi.processHeader(self.midiSteamReader)
  self.midiSteamReader:seek("set")
  local musicLenth = 0
  local co = coroutine.create(function()
    midi.processTrack(self.midiSteamReader, function(type, arg1, arg2, arg3, arg4)
      if type == "noteOn" then
        currentNote = arg2
        if currentNote ~= nil then
          if noteToBtnMap[currentNote] ~= nil then
            if noteOnCallback ~= nil then
              noteOnCallback(noteToBtnMap[currentNote])
            end
          else
            error("no note!!! note == " .. currentNote)
          end
        end
      end
      if type == "deltatime" then
        currentTickCount = currentTickCount + arg1
      end
      if type == "noteOff" then
        if currentNote ~= nil and noteToBtnMap[currentNote] ~= nil and noteOffCallback ~= nil then
          noteOffCallback(noteToBtnMap[currentNote])
        end
        currentNote = nil
      end
      local quarterNoteTick = rhythmCfg.quarterNoteTick
      local BPM = rhythmCfg.bpm
      local onTickTime = 50 / BPM / quarterNoteTick
      while 0 < currentTickCount do
        detlaTimeAccumulation = detlaTimeAccumulation + Time.fixedDeltaTime
        while onTickTime < detlaTimeAccumulation and 0 < currentTickCount do
          detlaTimeAccumulation = detlaTimeAccumulation - onTickTime
          currentTickCount = currentTickCount - 1
          musicLenth = musicLenth + onTickTime
        end
        coroutine.yield()
      end
    end, rhythmCfg.button_track)
    self.midiSteamReader:close()
    self.midiSteamReader = nil
    return true
  end)
  return co
end

function MiniGameMusicController:OnExitMiniGameMusic()
  if self.midiSteamReader ~= nil then
    self.midiSteamReader:close()
    self.midiSteamReader = nil
  end
  self:PlayMusicTimeline(true)
  self:_MusicMaskFadeIn(function()
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
    self:_MusicMaskFadeOut()
  end)
  self:SetOutMiniGameAudioOpen(true)
end

function MiniGameMusicController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.instrument_music)
  ConfigData:ReleaseDynCfg(eDynConfigData.instrument_music_audio)
  ConfigData:ReleaseDynCfg(eDynConfigData.tiny_game_instrument)
  base.OnDelete(self)
end

return MiniGameMusicController
