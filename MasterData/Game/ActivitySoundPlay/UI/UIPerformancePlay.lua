local base = require("Game.TinyGames.Music.UI.UIMiniGameMusicMain")
local UIPerformancePlay = class("UIPerformancePlay", base)
local UINMiniGameMusicButtonItem = require("Game.TinyGames.Music.UI.UINMiniGameMusicButtonItem")
local MiniGameMusicConfig = require("Game.TinyGames.Music.Config.MiniGameMusicConfig")
local MiniGameMusicButtonFx = require("Game.TinyGames.Music.Fx.MiniGameMusicButtonFx")
local Queue = require("Framework.Lib.Queue")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local SoundPlayState = {
  Error = -1,
  FreePlay = 0,
  Start = 1,
  Playing = 2,
  Pause = 3,
  CancelPause = 4,
  End = 5
}

function UIPerformancePlay:OnInit()
  self.comboCount = 0
  self.maxCombo = 0
  self.goodStrickCount = 0
  self.noteCount = 0
  self.comboSumScore = 0
  self._musicPlayingTime = 0
  self.buttonItemPool = UIItemPool.New(UINMiniGameMusicButtonItem, self.ui.obj_ButtonItem, false)
  self.buttonFxPool = UIItemPool.New(MiniGameMusicButtonFx, self.ui.obj_Click, false)
  self.preClickFxPool = UIItemPool.New(MiniGameMusicButtonFx, self.ui.obj_PreClick, false)
  self.perfectFxPool = UIItemPool.New(MiniGameMusicButtonFx, self.ui.obj_Perfect, false)
  self.missFxPool = UIItemPool.New(MiniGameMusicButtonFx, self.ui.obj_Miss, false)
  self.buttonFxCloneName = self.buttonFxPool.uiPrefab.name .. "(Clone)"
  self.preClickFxCloneName = self.preClickFxPool.uiPrefab.name .. "(Clone)"
  self.perfectFxCloneName = self.perfectFxPool.uiPrefab.name .. "(Clone)"
  self.missFxCloneName = self.missFxPool.uiPrefab.name .. "(Clone)"
  self.__OnUploadTinyGameScoreEndCallback = BindCallback(self, self._ShowResultWindow)
  self.__OnMusicButtonItemDown = BindCallback(self, self._OnMusicButtonItemDown)
  self.__OnMusicButtonItemUp = BindCallback(self, self._OnMusicButtonItemUp)
  self.__OnHideMusicButtonFx = BindCallback(self, self._OnHideMusicButtonFx)
  self.__NoteOnCallback = BindCallback(self, self.NoteOnCallback)
  self.__NoteOffCallback = BindCallback(self, self.NoteOffCallback)
  self.__BackActionCallback = BindCallback(self, self._BackAction)
  self.mainController = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true)
  self.resloader = cs_ResLoader.Create()
end

function UIPerformancePlay:InitMiniGameMusic(gameCfg, rhythmCfg)
  self.comboCount = 0
  self.maxCombo = 0
  self.goodStrickCount = 0
  self.noteCount = 0
  self.comboSumScore = 0
  self._musicPlayingTime = 0
  self.musicCfg = gameCfg
  self._rhythmCfg = rhythmCfg
  ConfigData:LoadDynCfg(eDynConfigData.activity_instrument_main)
  self.instrumentMainCfg = ConfigData.activity_instrument_main[self.musicCfg.id]
  self.pre_range = self.instrumentMainCfg.pre_range / 1000
  self.post_range = self.instrumentMainCfg.post_range / 1000
  self.unit_click_score = self.instrumentMainCfg.click_score
  self.unit_combo_score = self.instrumentMainCfg.combo_score
  self.topStatusData = UIUtil.CreateNewTopStatusData(self)
  self.topStatusData.topBtnOnlyReturn = true
  self.topStatusData:SetTopStatusVisible(true)
  self.topStatusData:SetTopStatusBackAction(self.__BackActionCallback)
  self.topStatusData:PushTopStatusDataToBackStack(true)
  self.mainController:SetMusicInstrument(self.musicCfg.instru_id)
  self.mainController:SetOutMiniGameAudioOpen(false)
  self.buttonItemDic = {}
  self.noteQueue = {}
  self.waittingNoteList = {}
  for index = 1, MiniGameMusicConfig.MaxButtonCount do
    local buttonItem = self.buttonItemPool:GetOne()
    self.buttonItemDic[index] = buttonItem
    buttonItem:InitMusicButtonItem(self.__OnMusicButtonItemDown, self.__OnMusicButtonItemUp, index, self.mainController)
    self.noteQueue[index] = {}
    self.noteQueue[index].timeQueue = Queue.New()
    self.noteQueue[index].btnItem = buttonItem
  end
  self:Refresh()
  if self:IsSoundPlayMode() then
    self:StartSoundPlay()
    self.__update__handle = BindCallback(self, self.OnCoroutineSoundPlay)
    UpdateManager:AddFixedUpdate(self.__update__handle)
  else
    self.soundPlayState = SoundPlayState.FreePlay
  end
  if self.instrumentMainCfg.skin_type == 1 then
    self:__LoadPic(self.instrumentMainCfg.hero_id, self.instrumentMainCfg.skin_id)
  else
    self:__LoadL2D(self.instrumentMainCfg.hero_id, self.instrumentMainCfg.skin_id)
  end
end

function UIPerformancePlay:__LoadL2D(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, 0, true)
      self.heroCubismInteration:SetL2DPosType("GetHero", false)
      self.heroCubismInteration:SetInterationOpenWait(false)
    end
  end)
end

function UIPerformancePlay:__LoadPic(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("GetHero")
  end)
end

function UIPerformancePlay:ReStartSoundPlay()
  self.buttonFxPool:HideAll()
  self.preClickFxPool:HideAll()
  self.perfectFxPool:HideAll()
  self.missFxPool:HideAll()
  self:StartSoundPlay()
end

function UIPerformancePlay:Refresh()
  self:RefreshMusicName()
  self:RefreshMusicProgress()
  self:RefreshPlayScore()
  self:RefreshCombo(false)
end

function UIPerformancePlay:IsSoundPlayMode()
  return self._rhythmCfg ~= nil
end

function UIPerformancePlay:RefreshMusicName()
  local isSoundPlayMode = self:IsSoundPlayMode()
  self.ui.obj_Title:SetActive(isSoundPlayMode)
  if not isSoundPlayMode then
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self._rhythmCfg.rhythm_des)
end

function UIPerformancePlay:RefreshMusicProgress()
  local isSoundPlayMode = self:IsSoundPlayMode()
  self.ui.obj_Progress:SetActive(isSoundPlayMode)
  if not isSoundPlayMode then
    return
  end
end

function UIPerformancePlay:UpdateAudioBarProgress(musicPlayingTime)
  local minutes = math.floor(musicPlayingTime / 60)
  local secondsRemainder = math.floor(musicPlayingTime % 60)
  self.ui.tex_Time.text = string.format("%d:%02d", tostring(minutes), tostring(secondsRemainder))
  if self._audioBarmaterial == nil then
    self._audioBarmaterial = UIUtil.GetImageMaterial(self.ui.audioBar)
  end
  local progress = musicPlayingTime / self._rhythmCfg.audio_time
  self._audioBarmaterial:SetFloat("_progress", progress)
end

function UIPerformancePlay:RefreshPlayScore()
  local isSoundPlayMode = self:IsSoundPlayMode()
  self.ui.obj_Score:SetActive(isSoundPlayMode)
  if not isSoundPlayMode then
    return
  end
  local totalScore = self:GetTotalScore()
  self.ui.tex_Score.text = tostring(totalScore)
end

function UIPerformancePlay:_CalculateLegalComboCount(comboCount)
  return comboCount < self._rhythmCfg.combo_initial and 0 or comboCount
end

function UIPerformancePlay:GetTotalScore()
  local comboCount = self:_CalculateLegalComboCount(self.comboCount)
  return self.goodStrickCount * self.unit_click_score + self.comboSumScore + comboCount * self.unit_combo_score
end

function UIPerformancePlay:RefreshCombo(active)
  self.ui.obj_Combo:SetActive(active)
end

function UIPerformancePlay:StartSoundPlay()
  self.comboCount = 0
  self.maxCombo = 0
  self.goodStrickCount = 0
  self.noteCount = 0
  self.comboSumScore = 0
  self._musicPlayingTime = 0
  self.__soundPlayCo = self.mainController:StartSoundPlayMode(self._rhythmCfg, self.resloader, self.__NoteOnCallback, self.__NoteOffCallback)
  self._delayPlayBGMTime = 0
  self.soundPlayState = SoundPlayState.Start
end

function UIPerformancePlay:OnCoroutineSoundPlay()
  self:_OnSoundPlayEnd()
  if self.__soundPlayCo == nil then
    return
  end
  if self.soundPlayState == SoundPlayState.CancelPause then
    self._waittingToReStartTime = self._waittingToReStartTime - Time.fixedDeltaTime
    self.ui.tex_pause.text = Mathf.Ceil(self._waittingToReStartTime)
    if self._waittingToReStartTime < 0 then
      self:Continue()
    end
    return
  end
  if self.soundPlayState == SoundPlayState.Pause or self.soundPlayState == SoundPlayState.End then
    return
  end
  self._musicPlayingTime = self._musicPlayingTime + Time.fixedDeltaTime
  self:UpdateAudioBarProgress(self._musicPlayingTime)
  local status, value = coroutine.resume(self.__soundPlayCo)
  if type(value) == "string" then
    error(value)
    self.__soundPlayCo = nil
    self.soundPlayState = SoundPlayState.Error
    return
  end
  local isEnd = value
  if isEnd == true then
    self.__soundPlayCo = nil
    self.soundPlayState = SoundPlayState.End
    self._delayShowResultTime = 1
    return
  end
  self:_StartPlayBGM()
  self:_UpdateWaittingNoteList()
end

function UIPerformancePlay:_OnSoundPlayEnd()
  if self.soundPlayState == SoundPlayState.End and self._delayShowResultTime ~= nil then
    self._delayShowResultTime = self._delayShowResultTime - Time.fixedDeltaTime
    if self._delayShowResultTime < 0 then
      self._delayShowResultTime = nil
      if self._bgmCallback ~= nil then
        AudioManager:StopAudioByBack(self._bgmCallback)
      end
      local totalScore = self:GetTotalScore()
      local tinigameData = self.mainController:GetTinyGameSoundPlayData()
      if tinigameData ~= nil then
        local musicId = self._rhythmCfg.id
        self.lastHighestScore = tinigameData:GetTinyGameSubLevelHistoryScore(musicId)
        tinigameData:UploadTinyGameScore(totalScore, musicId, self.__OnUploadTinyGameScoreEndCallback)
      else
        self:_ShowResultWindow()
      end
    end
  end
end

function UIPerformancePlay:_StartPlayBGM()
  if self._delayPlayBGMTime == nil then
    return
  end
  self._delayPlayBGMTime = self._delayPlayBGMTime + Time.fixedDeltaTime
  if self._delayPlayBGMTime > self.pre_range then
    local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
    if homeController ~= nil then
      homeController:ResetShowHeroVoiceImme()
    end
    self._bgmCallback = AudioManager:PlayAudioById(self._rhythmCfg.audio_id, function(auBack)
      if auBack == self._bgmCallback then
        self._bgmCallback = nil
      end
    end)
    self._delayPlayBGMTime = nil
    self.soundPlayState = SoundPlayState.Playing
  end
end

function UIPerformancePlay:_UpdateWaittingNoteList()
  for buttonId, noteItem in pairs(self.waittingNoteList) do
    if noteItem ~= nil then
      local timeQueue = noteItem.timeQueue
      while timeQueue:Count() > 0 and not self:IsInCorrectTime(timeQueue:PeekFront()) do
        self:BadStrick(noteItem.btnItem.transform.position)
        timeQueue:PopFront()
      end
      if timeQueue:Count() == 0 then
        self.waittingNoteList[buttonId] = nil
      end
    end
  end
end

function UIPerformancePlay:_ShowResultWindow()
  UIManager:ShowWindowAsync(UIWindowTypeID.PerformanceResult, function(window)
    if window == nil then
      return
    end
    local resultData = {}
    resultData.musicCfg = self.musicCfg
    resultData.rhythmCfg = self._rhythmCfg
    resultData.totalScore = self:GetTotalScore()
    resultData.goodStrickCount = self.goodStrickCount
    resultData.totalNoteCount = self._rhythmCfg.click_num
    resultData.maxCombo = self.maxCombo
    local tinigameData = self.mainController:GetTinyGameSoundPlayData()
    if tinigameData ~= nil and self.lastHighestScore ~= nil then
      resultData.isNewRecord = resultData.totalScore > self.lastHighestScore
    else
      resultData.isNewRecord = false
    end
    resultData.isFullCombo = self.maxCombo == self._rhythmCfg.click_num
    window:InitPerformanceResult(resultData)
  end)
end

function UIPerformancePlay:_OnMusicButtonItemDown(buttonId)
  base._OnMusicButtonItemDown(self, buttonId)
  local Queue = self.noteQueue[buttonId].timeQueue
  local correctTime = Queue:PeekFront()
  if correctTime == nil then
    return
  end
  if not self:IsInCorrectTime(correctTime) then
    self:BadStrick(self.buttonItemDic[buttonId].transform.position)
    return
  end
  self:GoodStrick(self.buttonItemDic[buttonId].transform.position)
  Queue:PopFront()
end

function UIPerformancePlay:NoteOnCallback(buttonId)
  if buttonId ~= nil and self.buttonItemDic[buttonId] ~= nil then
    self.noteQueue[buttonId].timeQueue:PushBack(Time.time + self.pre_range)
    self.waittingNoteList[buttonId] = self.noteQueue[buttonId]
    self:ShowReadyStrike(self.buttonItemDic[buttonId].transform.position)
    self.noteCount = self.noteCount + 1
  end
end

function UIPerformancePlay:NoteOffCallback(buttonId)
  if buttonId == nil or self.buttonItemDic[buttonId] ~= nil then
  end
end

function UIPerformancePlay:ShowMiss(position)
  local missFxItem = self.missFxPool:GetOne()
  missFxItem:InitMiniGameMusicButtonFx(0.5, self.__OnHideMusicButtonFx)
  missFxItem.transform.position = position
end

function UIPerformancePlay:ShowPerfect(position)
  local perfectFxItem = self.perfectFxPool:GetOne()
  perfectFxItem:InitMiniGameMusicButtonFx(0.5, self.__OnHideMusicButtonFx)
  perfectFxItem.transform.position = position
end

function UIPerformancePlay:ShowReadyStrike(position)
  local preClickFxItem = self.preClickFxPool:GetOne()
  preClickFxItem:InitMiniGameMusicButtonFx(1, self.__OnHideMusicButtonFx)
  preClickFxItem.transform.position = position
end

function UIPerformancePlay:DoComboAnim(comboCount)
  if comboCount < self._rhythmCfg.combo_initial then
    return
  end
  if not self.ui.obj_Combo.activeInHierarchy then
    self.ui.obj_Combo:SetActive(true)
  end
  self.ui.tex_ComboCount.text = tostring(comboCount)
  self.ui.tween_Score:DORestart()
end

function UIPerformancePlay:GoodStrick(position)
  self:UpdateSkillScore(true)
  self:DoComboAnim(self.comboCount)
  self:ShowPerfect(position)
  self:RefreshPlayScore()
end

function UIPerformancePlay:BadStrick(position)
  self:UpdateSkillScore(false)
  self:RefreshCombo(false)
  self:ShowMiss(position)
  self:RefreshPlayScore()
end

function UIPerformancePlay:UpdateSkillScore(isGood)
  if isGood then
    self.comboCount = self.comboCount + 1
    self.goodStrickCount = self.goodStrickCount + 1
    if self.comboCount > self.maxCombo then
      self.maxCombo = self.comboCount
    end
  else
    local comboCount = self:_CalculateLegalComboCount(self.comboCount)
    self.comboSumScore = self.comboSumScore + comboCount * self.unit_combo_score
    self.comboCount = 0
  end
end

function UIPerformancePlay:_OnHideMusicButtonFx(fxItem)
  if fxItem == nil or IsNull(fxItem.transform) then
    return
  end
  if fxItem.transform.name == self.buttonFxCloneName then
    self.buttonFxPool:HideOne(fxItem)
  elseif fxItem.transform.name == self.preClickFxCloneName then
    self.preClickFxPool:HideOne(fxItem)
  elseif fxItem.transform.name == self.perfectFxCloneName then
    self.perfectFxPool:HideOne(fxItem)
  elseif fxItem.transform.name == self.missFxCloneName then
    self.missFxPool:HideOne(fxItem)
  end
end

function UIPerformancePlay:IsInCorrectTime(CorrectTime)
  local currentTime = Time.time
  local clampValue = Mathf.Clamp(currentTime, CorrectTime - self.pre_range, CorrectTime + self.post_range)
  return currentTime == clampValue
end

function UIPerformancePlay:Pause()
  self.__beforePauseState = self.soundPlayState
  self.soundPlayState = SoundPlayState.Pause
  self._waittingToReStartTime = 3
  if self._bgmCallback ~= nil then
    AudioManager:PauseAudioBack(self._bgmCallback, true)
  end
end

function UIPerformancePlay:CancelPause()
  self.soundPlayState = SoundPlayState.CancelPause
  self.ui.PauseNode:SetActive(true)
end

function UIPerformancePlay:Continue()
  if self.__beforePauseState == SoundPlayState.Pause or self.__beforePauseState == SoundPlayState.CancelPause then
    self.soundPlayState = SoundPlayState.Playing
  else
    self.soundPlayState = self.__beforePauseState
  end
  self.__beforePauseState = nil
  self._waittingToReStartTime = nil
  self.ui.PauseNode:SetActive(false)
  AudioManager:PauseAudioBack(self._bgmCallback, false)
end

function UIPerformancePlay:_BackAction()
  if not self:IsSoundPlayMode() then
    self:Delete()
    return true
  end
  if self.soundPlayState == SoundPlayState.Start then
    return false
  end
  self:Pause()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(53001), function()
    self.soundPlayState = SoundPlayState.End
    self._delayShowResultTime = 0
  end, function()
    self:CancelPause()
  end)
  return false
end

function UIPerformancePlay:OnDelete()
  base.OnDelete(self)
  UpdateManager:RemoveFixedUpdate(self.__update__handle)
  if self._bgmCallback ~= nil then
    AudioManager:StopAudioByBack(self._bgmCallback)
  end
  DestroyUnityObject(self._audioBarmaterial)
  self._audioBarmaterial = nil
  self.ui.heroHolder.gameObject:SetActive(false)
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.mainController:SetOutMiniGameAudioOpen(true)
  self.buttonItemPool:DeleteAll()
  self.buttonItemPool = nil
  self.buttonFxPool:DeleteAll()
  self.buttonFxPool = nil
  self.preClickFxPool:DeleteAll()
  self.preClickFxPool = nil
  self.perfectFxPool:DeleteAll()
  self.perfectFxPool = nil
  self.missFxPool:DeleteAll()
  self.missFxPool = nil
  self.__update__handle = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_instrument_main)
end

return UIPerformancePlay
