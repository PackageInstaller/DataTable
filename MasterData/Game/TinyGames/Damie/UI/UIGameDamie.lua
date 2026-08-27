local UIGameDamie = class("UIGameDamie", UIBaseWindow)
local base = UIBaseWindow
local cs_Tweening = CS.DG.Tweening
local cs_DoTween = cs_Tweening.DOTween
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType
local DamieCharaItem = require("Game.TinyGames.Damie.UI.UIDamieCharaItem")
local EfcItem = require("Game.TinyGames.Damie.UI.UIDamieEfcItem")
local DamieRanking = require("Game.TinyGames.Damie.UI.UIGameDamieRanking")
local DamieSettle = require("Game.TinyGames.Damie.UI.UIGameDamieSettle")
local DamiePause = require("Game.TinyGames.Damie.UI.UIGameDamiePause")
local DamieConfig = require("Game.TinyGames.Damie.Config.DamieConfig")
local BossId = DamieConfig.BossId
local BossRemainTime = DamieConfig.BossRemainTime
local SpecialBossRemainTime = DamieConfig.SpecialBossRemainTime
local BossMaxPressedCount = DamieConfig.BossMaxPressedCount
local BossBornScoreTag = DamieConfig.BossBornScoreTag
local TotalTime = DamieConfig.TotalTime
local TimerInterval = DamieConfig.TimerInterval
local StepState = DamieConfig.StepState
local StepTime = DamieConfig.StepTime
local CharaConfig = DamieConfig.CharaConfig
local BonusTimeArg = DamieConfig.BonusTimeArg
local CharaVoSheetName = DamieConfig.CharaVoSheetName

function UIGameDamie:OnInit()
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.GameDamie)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickDamieBack)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.__SwitchToStart)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.__TryShowRanking)
  UIUtil.AddButtonListener(self.ui.btn_Pause, self, self.__PauseGame)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.__ShowInfo)
  self:__InitCharaItem()
  self.grade = {score = 0, allTime = 0}
  self.__stepState = StepState.first
  self.__aliveCharaCount = 0
  self.casterItemIntarval = 1
  self.efcPool = UIItemPool.New(EfcItem, self.ui.pressEfc)
  self.__reStartGame = BindCallback(self, self.__ReStartGame)
  self.__resumeAction = BindCallback(self, self.__Resume2Game)
  self.__exitAction = BindCallback(self, self.__Back2Main)
  self.__isPlaying = false
  self.ui.btn_Pause.interactable = false
  self.__stopProgressInGame = false
  self.__curBossTag = 1
  self.__lastBornedScore = 0
  self.ui.endTime.text = DamieConfig.ActivityEndTime
end

function UIGameDamie:__IsAllDie()
  return self.__aliveCharaCount <= 0
end

function UIGameDamie:InitDamieWithData(activityFwId, gameId, maxScore, isHistoryOpen, HTGData)
  self.__activityFwId = activityFwId
  self.__gameId = gameId
  self.__highestScore = maxScore
  self.__isHistoryOpen = isHistoryOpen
  self.__HTGData = HTGData
  if self.__isHistoryOpen then
    self.ui.endTime.text = HTGData:GetPlayEndTimeStr()
  end
end

function UIGameDamie:InjectExitAction(onExit)
  self.__onExit = onExit
end

function UIGameDamie:__SwitchToStart()
  self:__EnterGame()
end

function UIGameDamie:__EnterGame()
  AudioManager:PlayAudioById(1217)
  self.ui.gaming_node:SetActive(true)
  self.ui.main_node:SetActive(false)
  self:__ShowGameScore(self.grade.score)
  self:__CountDownTipStart(BindCallback(self, self.__GameRun))
end

function UIGameDamie:__GameRun()
  AudioManager:PlayAudioById(1217)
  self.__isPlaying = true
  self.ui.btn_Pause.interactable = true
  self.internalCastIndex = 0
  self.curProgressTime = TotalTime
  self.accTime = 0
  self.totalTimerId = TimerManager:StartTimer(TimerInterval, BindCallback(self, self.__ProgressTimeCb))
end

function UIGameDamie:__PauseGame()
  if not self.__isPlaying then
    return
  end
  Time:SetTimeScale(0)
  if self.__pauseUI == nil then
    self.__pauseUI = DamiePause.New()
    self.__pauseUI:Init(self.ui.ui_pause)
  end
  self.__pauseUI:Show()
  self.__pauseUI:ShowScore(self.grade.score)
  self.__pauseUI:InjectPauseAction(self.__resumeAction, self.__reStartGame, self.__exitAction)
end

function UIGameDamie:__Back2Main()
  self:__ResetGameState()
  self.ui.gaming_node:SetActive(false)
  self.ui.main_node:SetActive(true)
  self:__ResetTimeScale()
end

function UIGameDamie:__ResetTimeScale()
  Time:SetTimeScale(1)
end

function UIGameDamie:__Resume2Game()
  if not self.__isPlaying then
    self:__ResetTimeScale()
    return
  end
  self.__isPlaying = false
  self.ui.btn_Pause.interactable = false
  self:__CountDownTipStart(BindCallback(self, self.__InternalResume), true)
end

function UIGameDamie:__InternalResume()
  self.__isPlaying = true
  self:__ResetTimeScale()
  self.ui.btn_Pause.interactable = true
end

function UIGameDamie:__ReStartGame()
  self:__ResetTimeScale()
  self:__ResetGameState()
  self:__EnterGame()
end

function UIGameDamie:__ResetGameState()
  self.__isPlaying = false
  self.ui.btn_Pause.interactable = false
  if self.colorSeq ~= nil then
    self.colorSeq:Kill()
    self.colorSeq = nil
  end
  self.ui.progress_img.color = self.ui.normalColor
  self:__StopCountDown()
  self:__StopProgressTimer()
  self:__StopInternalCastTimer()
  self:__HideAllEfcItem()
  self:__HideRemainItem()
  self.__stepState = StepState.first
  self.__aliveCharaCount = 0
  self.accTime = 0
  self.curProgressTime = TotalTime
  self.casterItemIntarval = 1
  self.__curPerCastInterval = nil
  self.internalCastIndex = 0
  self.grade.score = 0
  self.ui.progress_img.fillAmount = 1
  self.__stopProgressInGame = false
  self.__curBossTag = 1
  self.__lastBornedScore = 0
end

function UIGameDamie:__ShowGameScore(value)
  self.ui.tex_Score:SetIndex(0, tostring(value))
end

function UIGameDamie:__AddScore(score)
  self.grade.score = self.grade.score + score
  self:__ShowGameScore(self.grade.score)
end

function UIGameDamie:__ShowInfo()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(ConfigData.game_config.gameDamieGuideInfoPic, nil)
end

function UIGameDamie:__ProgressTimeCb()
  local curInterval = TimerInterval
  if self.__stopProgressInGame then
    curInterval = 0
  end
  self.curProgressTime = self.curProgressTime - curInterval
  self.accTime = self.accTime + curInterval
  local progress = self.curProgressTime / TotalTime
  self.ui.progress_img.fillAmount = progress
  if 0 >= self.curProgressTime then
    self.ui.progress_img.fillAmount = 0
    self:__StopProgressTimer()
    self:__GameOver()
    return
  end
  self:__HandleStepStateAndCaster(curInterval)
end

function UIGameDamie:__HandleStepStateAndCaster(curInterval)
  self:__HandleState()
  if not self:__IsAllDie() or self.internalCastIndex > 0 then
    return
  end
  self.casterItemIntarval = self.casterItemIntarval + curInterval
  if self:__CheckBossBorn() then
    self:__CasterBossItem()
    self:__HideAllEfcItem()
    self.casterItemIntarval = 0
    return
  end
  local cfg = CharaConfig[self.__stepState]
  if self.__curCasterInterval == nil then
    self.__curCasterInterval = self:__GetCasterInterval()
    self.__curPerCastInterval = 0
    if cfg.perCastInterval ~= nil then
      self.__curPerCastInterval = cfg.perCastInterval[math.random(1, #cfg.perCastInterval)]
    end
  end
  if self.casterItemIntarval >= self.__curCasterInterval then
    self:__HideAllEfcItem()
    self:__HandleCaster(cfg.casterMaxCount, self.__curPerCastInterval)
    self.casterItemIntarval = 0
    self.__curPerCastInterval = nil
    self.__curCasterInterval = nil
  end
end

function UIGameDamie:__CheckBossBorn()
  local tagCount = #BossBornScoreTag
  if tagCount < self.__curBossTag then
    return
  end
  local tagScore = BossBornScoreTag[self.__curBossTag]
  if tagScore <= self.grade.score - self.__lastBornedScore then
    self.__lastBornedScore = self.grade.score
    self.__curBossTag = math.min(self.__curBossTag + 1, tagCount)
    return true
  end
  return false
end

function UIGameDamie:__GameOver()
  local score = self.grade.score
  self:__ResetGameState()
  if self.__isHistoryOpen then
    self.__HTGData:HTGCommonSettle(score, function(tinyGameCenterElem)
      self:__ShowSettleUI({
        Count = 1,
        [0] = tinyGameCenterElem
      })
    end)
    return
  end
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actCtrl:GetActivityFrameData(self.__activityFwId)
  if actFrameData ~= nil and actFrameData:IsActivityOpen() then
    self.netWork:CS_ACTIVITY_REFRESHDUNGEON_DamieSettle(self.__activityFwId, self.__gameId, score, BindCallback(self, self.__ShowSettleUI))
  else
    self:OnClickDamieBack()
  end
end

function UIGameDamie:__ShowSettleUI(objList)
  if objList.Count <= 0 then
    error("CS_ACTIVITY_REFRESHDUNGEON_DamieSettle objList.Count error:" .. tostring(objList.Count))
    return
  end
  local msg = objList[0]
  if self.__uiSettle == nil then
    self.__uiSettle = DamieSettle.New()
    self.__uiSettle:Init(self.ui.gameOver)
  end
  AudioManager:PlayAudioById(1218)
  self.__uiSettle:Show()
  self.grade.score = msg.score
  local isNew = self.grade.score > (self.__highestScore or 0)
  self.__highestScore = msg.highestScore
  self.__uiSettle:RefreshScore(self.grade.score, isNew)
  local allFriendsData, mineGrade
  if self.__isHistoryOpen then
    local rankData = self.__HTGData:GetHTGRankData()
    allFriendsData = rankData.allFriendData
    mineGrade = rankData.mineGrade
  else
    allFriendsData = self:__GetFriendDamieData() or {}
    mineGrade = self:__CreateMineDamieGrade(self.grade.score)
    table.insert(allFriendsData, mineGrade)
    self:__SortRankDamieData(allFriendsData)
  end
  local finalData = self:__GetResultFriendRankingData(allFriendsData, mineGrade)
  self.__uiSettle:RefreshDamieResultRank(finalData, mineGrade)
  self.__uiSettle:InjectRestartAction(self.__exitAction)
end

function UIGameDamie:__GetResultFriendRankingData(allFriendData, mineGrade)
  local finalData = {}
  for index, v in ipairs(allFriendData) do
    v.grade_index = index
    if v == mineGrade then
      if 1 < index then
        table.insert(finalData, allFriendData[index - 1])
      end
      table.insert(finalData, v)
      local tempIndex = index
      while #finalData < 3 do
        tempIndex = tempIndex + 1
        if tempIndex <= #allFriendData then
          local tempData = allFriendData[tempIndex]
          tempData.grade_index = tempIndex
          table.insert(finalData, tempData)
        else
          return finalData
        end
      end
      return finalData
    end
  end
  return finalData
end

function UIGameDamie:__GetCasterInterval()
  local cfg = CharaConfig[self.__stepState]
  if self.__stepState == StepState.first or self.__stepState == StepState.fourth or self.__stepState == StepState.fifth then
    return cfg.interval
  else
    local intervalIndex = math.random(1, #cfg.interval)
    return cfg.interval[intervalIndex]
  end
end

function UIGameDamie:__HandleState()
  if self.__stepState == StepState.fifth then
    return
  end
  for index, time in ipairs(StepTime) do
    if time >= self.accTime then
      self.__stepState = index
      return
    end
  end
  self.__stepState = StepState.fifth
end

function UIGameDamie:__HideRemainItem()
  if self.itemBoss.active then
    self.itemBoss:Hide()
    self.itemBoss.transform:SetParent(self.ui.charaPool, false)
  end
  for _, pool in ipairs(self.itemPools) do
    for t, item in ipairs(pool.listItem) do
      item.transform:SetParent(self.ui.charaPool, false)
    end
    pool:HideAll()
  end
end

function UIGameDamie:__StopProgressTimer()
  if self.totalTimerId == nil then
    return
  end
  TimerManager:StopTimer(self.totalTimerId)
  self.totalTimerId = nil
end

function UIGameDamie:__CountDownTipStart(action, unscaled)
  self.countDownIndex = 0
  self.ui.tex_Time.gameObject:SetActive(true)
  self.ui.tex_Time:SetIndex(self.countDownIndex)
  self.countDownTimerId = TimerManager:StartTimer(1, BindCallback(self, self.__CountDownCb, action), nil, false, false, unscaled or false)
end

function UIGameDamie:__CountDownCb(action)
  self.countDownIndex = self.countDownIndex + 1
  if self.countDownIndex >= 3 then
    if action ~= nil then
      action()
    end
    self:__StopCountDown()
    self.ui.tex_Time.gameObject:SetActive(false)
    return
  end
  self.ui.tex_Time:SetIndex(self.countDownIndex)
end

function UIGameDamie:__StopCountDown()
  if self.countDownTimerId == nil then
    return
  end
  TimerManager:StopTimer(self.countDownTimerId)
  self.countDownTimerId = nil
end

function UIGameDamie:__InitCharaItem()
  local charaItems = self.ui.charaItems
  self.itemPools = {}
  for k, v in ipairs(charaItems) do
    self.itemPools[k] = UIItemPool.New(DamieCharaItem, v)
  end
  self.__posArray = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
  }
  self.__itemArray = {}
  for i = 1, #charaItems do
    table.insert(self.__itemArray, i)
  end
  self.itemBoss = DamieCharaItem.New()
  self.itemBoss:Init(self.ui.obj_BossPic)
end

function UIGameDamie:__CasterBossItem()
  if self.itemBoss == nil then
    return
  end
  self.itemBoss:Show()
  self.itemBoss:InitWithData(BossId, BossRemainTime, BossMaxPressedCount)
  self.itemBoss:InjectPressFunc(BindCallback(self, self.__OnBossItemPresses, 1, self.itemBoss))
  self.itemBoss:InjectRecycleItemFunc(BindCallback(self, self.__OnRecycleItem, self.itemBoss))
  self:__RandomArray(self.__posArray)
  local posIndex = self.__posArray[1]
  local posRoot = self.ui.pos_roots[posIndex]
  self.itemBoss.transform:SetParent(posRoot, false)
  self.itemBoss:Active()
  self.__stopProgressInGame = true
  self.__aliveCharaCount = self.__aliveCharaCount + 1
end

function UIGameDamie:__GetItem(id, existTime)
  local pool = self.itemPools[id]
  local item = pool:GetOne()
  item:InitWithData(id, existTime)
  item:InjectPressFunc(BindCallback(self, self.__OnNormalItemPressed, 1, item))
  item:InjectRecycleItemFunc(BindCallback(self, self.__OnRecycleItem, item))
  return item
end

function UIGameDamie:__OnNormalItemPressed(score, item)
  if not self.__isPlaying then
    return false
  end
  self:__AddScore(score)
  local efcItem = self.efcPool:GetOne()
  efcItem.transform:SetParent(item.transform.parent, false)
  efcItem:UpdateScore(1, item.dataId)
  efcItem:Active()
  self:__OnHitAudioPlay(item:GetDamieCharaItemHeroId())
  return true
end

function UIGameDamie:__OnBossItemPresses(score, item, remainPressedCount)
  if not self.__isPlaying then
    return false
  end
  self:__AddScore(score)
  item:UpdateScoreGetted(score)
  item:UpdateExistTime(SpecialBossRemainTime)
  item:CheckAndActiveExtraState(true)
  if self.bossEfcItem == nil then
    self.bossEfcItem = self.efcPool:GetOne()
  end
  self.bossEfcItem.transform:SetParent(item.transform.parent, false)
  self.bossEfcItem:UpdateScore(item.scoreGetted, item.dataId)
  AudioManager:PlayAudioById(1214)
  if remainPressedCount <= 0 then
    return true
  end
  return false
end

function UIGameDamie:__HideAllEfcItem()
  for _, v in ipairs(self.efcPool.listItem) do
    v.transform:SetParent(self.ui.charaPool, false)
  end
  self.bossEfcItem = nil
  self.efcPool:HideAll()
end

function UIGameDamie:__OnRecycleItem(item, id)
  self.__aliveCharaCount = self.__aliveCharaCount - 1
  item.transform:SetParent(self.ui.charaPool, false)
  if id == BossId then
    self.__stopProgressInGame = false
    self.curProgressTime = self.curProgressTime + item.scoreGetted * BonusTimeArg
    self.curProgressTime = math.min(self.curProgressTime, TotalTime)
    self:__ShowProgressEfc()
    item:Hide()
    return
  end
  local pool = self.itemPools[id]
  pool:HideOne(item)
end

function UIGameDamie:__ShowProgressEfc()
  if self.colorSeq ~= nil then
    self.colorSeq:Kill()
  end
  AudioManager:PlayAudioById(1215)
  self.colorSeq = cs_DoTween.Sequence()
  self.colorSeq:Append(self.ui.progress_img:DOColor(self.ui.specialColor, 0.3):SetUpdate(true):SetEase(cs_Tweening.Ease.OutQuad):SetAutoKill(false))
  self.colorSeq:Join(self.ui.progress_img.transform:DOPunchPosition(Vector3.New(20, 0, 20), 0.2, 10):SetEase(cs_Tweening.Ease.InQuad):SetLoops(2, cs_DoTweenLoopType.Yoyo))
  self.colorSeq:AppendCallback(function()
    self.ui.progress_img.color = self.ui.normalColor
    self.ui.progress_img.transform.localPosition = Vector3.zero
  end)
end

function UIGameDamie:__HandleCaster(maxCount, perCasteInterval)
  local posCount = maxCount
  if 1 < maxCount then
    posCount = math.random(1, maxCount)
  end
  self:__RandomArray(self.__posArray)
  self:__RandomArray(self.__itemArray)
  perCasteInterval = perCasteInterval or 0
  if perCasteInterval <= 0 then
    for i = 1, posCount do
      self:__InternalCastItem(i)
    end
  else
    self.internalCastIndex = 1
    self:__InternalCastItem(self.internalCastIndex)
    self.internalCastTimeId = TimerManager:StartTimer(perCasteInterval, BindCallback(self, self.__CasteByInterval, maxCount))
  end
end

function UIGameDamie:__CasteByInterval(maxCount)
  self.internalCastIndex = self.internalCastIndex + 1
  self:__InternalCastItem(self.internalCastIndex)
  if maxCount <= self.internalCastIndex then
    self:__StopInternalCastTimer()
  end
end

function UIGameDamie:__StopInternalCastTimer()
  self.internalCastIndex = 0
  if self.internalCastTimeId == nil then
    return
  end
  TimerManager:StopTimer(self.internalCastTimeId)
  self.internalCastTimeId = nil
end

function UIGameDamie:__InternalCastItem(randomIdex)
  local curId
  if randomIdex > #self.__itemArray then
    curId = self.__itemArray[#self.__itemArray]
  else
    curId = self.__itemArray[randomIdex]
  end
  local existTime = self:__GetExistTime()
  local item = self:__GetItem(curId, existTime)
  local curPosId = self.__posArray[randomIdex]
  local posRoot = self.ui.pos_roots[curPosId]
  item.transform:SetParent(posRoot, false)
  item:Active()
  item:Show()
  self.__aliveCharaCount = self.__aliveCharaCount + 1
end

function UIGameDamie:__GetExistTime()
  if self.__stepState == StepState.first or self.__stepState == StepState.fifth then
    return CharaConfig[self.__stepState].remainTime
  else
    local index = math.random(1, 2)
    return CharaConfig[self.__stepState].remainTime[index]
  end
end

function UIGameDamie:__RandomArray(array)
  local length = #array
  for i = 1, length do
    local index_tmp = math.random(i, length)
    if index_tmp ~= i then
      local temp = array[i]
      array[i] = array[index_tmp]
      array[index_tmp] = temp
    end
  end
end

function UIGameDamie:__TryShowRanking()
  local function LocalFunc_Enter()
    local allFriendsData, mineGrade, bestGrade
    
    if self.__isHistoryOpen then
      local rankData = self.__HTGData:GetHTGRankData()
      allFriendsData = rankData.allFriendData
      mineGrade = rankData.mineGrade
      bestGrade = self.__HTGData:GetHTGHistoryHighScore()
    else
      allFriendsData = self:__GetFriendDamieData() or {}
      mineGrade = self:__CreateMineDamieGrade(self.__highestScore or 0)
      table.insert(allFriendsData, mineGrade)
      self:__SortRankDamieData(allFriendsData)
      bestGrade = self.__highestScore or 0
    end
    if self.__uiDamieRanking == nil then
      self.__uiDamieRanking = DamieRanking.New()
      self.__uiDamieRanking:Init(self.ui.rank)
    end
    self.__uiDamieRanking:Show()
    self.__uiDamieRanking:RefreshDamieRankingData(allFriendsData, mineGrade)
    self.__uiDamieRanking:SetBestScore(bestGrade)
  end
  
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(LocalFunc_Enter)
  else
    LocalFunc_Enter()
  end
end

function UIGameDamie:__GetFriendDamieData()
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return nil
  end
  local friendsData = PlayerDataCenter.friendDataCenter:GetFreindList()
  if friendsData == nil or #friendsData <= 0 then
    return nil
  end
  local allGrades = {}
  for _, v in ipairs(friendsData) do
    local eachFriendGrade = {}
    eachFriendGrade.name = v:GetUserName()
    eachFriendGrade.score = 0
    eachFriendGrade.uid = v:GetUserUID()
    local gameDamieData = v:GetFriendDamieData()
    if gameDamieData ~= nil and gameDamieData.gameId == self.__gameId then
      eachFriendGrade.score = gameDamieData.score
    end
    table.insert(allGrades, eachFriendGrade)
  end
  return allGrades
end

function UIGameDamie:__CreateMineDamieGrade(highestScore)
  if self.mineGrade == nil then
    self.mineGrade = {}
  end
  self.mineGrade.name = PlayerDataCenter:GetSelfName()
  self.mineGrade.uid = PlayerDataCenter:GetSelfId()
  self.mineGrade.score = highestScore
  return self.mineGrade
end

function UIGameDamie:__SortRankDamieData(allFriendData)
  if 1 < #allFriendData then
    table.sort(allFriendData, function(a, b)
      if a.score == b.score then
        return a.uid < b.uid
      else
        return a.score > b.score
      end
    end)
  end
end

function UIGameDamie:__OnHitAudioPlay(characterId)
  local dunHeroCfg = ConfigData.activity_refresh_dungeon_hero[characterId]
  if dunHeroCfg == nil then
    error("Cant get activity_refresh_dungeon_hero cfg, heroId : " .. tostring(characterId))
    return
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  local _, cueName = cvCtr:GetSheetNameAndCueName(characterId, dunHeroCfg.voice_id)
  if cueName == nil then
    return
  end
  AudioManager:PlayAudio(cueName, CharaVoSheetName, eAudioSourceType.VoiceSource)
end

function UIGameDamie:BackAction()
  self:Delete()
  if self.__onExit ~= nil then
    self.__onExit()
    self.__onExit = nil
  end
end

function UIGameDamie:OnClickDamieBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIGameDamie:OnDelete()
  self:__ResetGameState()
  AudioManager:RemoveCueSheet(CharaVoSheetName)
  self.itemBoss:Delete()
  for _, pool in ipairs(self.itemPools) do
    pool:DeleteAll()
  end
  self.itemPools = nil
  self.efcPool:DeleteAll()
  if self.colorSeq ~= nil then
    self.colorSeq:Kill()
    self.colorSeq = nil
  end
end

return UIGameDamie
