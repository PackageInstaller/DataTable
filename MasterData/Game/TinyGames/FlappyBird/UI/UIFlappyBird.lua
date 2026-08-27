local UIFlappyBird = class("UIFlappyBird", UIBaseWindow)
local base = UIBaseWindow
local cs_Debug = CS.UnityEngine.Debug
local cs_Tweening = CS.DG.Tweening
local cs_DoTween = cs_Tweening.DOTween
local cs_Material = CS.UnityEngine.Material
local UINFlappyTube = require("Game.TinyGames.FlappyBird.UI.UINFlappyTube")
local UINFlappyChocolate = require("Game.TinyGames.FlappyBird.UI.UINFlappyChocolate")
local UINFlappyAccItem = require("Game.TinyGames.FlappyBird.UI.UINFlappyAccItem")
local UINFlappyGuide = require("Game.TinyGames.FlappyBird.UI.UINFlappyGuide")
local UINFlappyPause = require("Game.TinyGames.FlappyBird.UI.UINFlappyPause")
local UINFlappyResult = require("Game.TinyGames.FlappyBird.UI.UINFlappyResult")
local UINFlappyGiftItem = require("Game.TinyGames.FlappyBird.UI.UINFlappyGiftItem")
local UINFlappyAwardPanel = require("Game.TinyGames.FlappyBird.UI.UINFlappyAwardPanel")
local FlappyBirdAudioConfig = require("Game.TinyGames.FlappyBird.Config.FlappyBirdAudioConfig")
local PreviewTubeCount = 20
local FirstAwardTitleIndex = 0

function UIFlappyBird:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseFlapply, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Play, self, self.OnClickStart)
  self.ui.background.onPressDown:AddListener(BindCallback(self, self.OnClickJump))
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_Guide, self, self.__ShowGuideNode)
  UIUtil.AddButtonListener(self.ui.btn_Pause, self, self.__ShowPause)
  UIUtil.AddButtonListener(self.ui.btn_Ranking, self, self.__ShowRanking)
  UIUtil.AddButtonListener(self.ui.btn_awardPanelBack, self, self.__HideAwardPanel)
  self.tubePool = UIItemPool.New(UINFlappyTube, self.ui.obj_tube)
  for i = 1, PreviewTubeCount do
    local item = self.tubePool:GetOne(false)
    self.tubePool:HideAll()
  end
  self.chocolatePool = UIItemPool.New(UINFlappyChocolate, self.ui.obj_chocolate)
  self.accPool = UIItemPool.New(UINFlappyAccItem, self.ui.obj_accItem)
  self.giftPool = UIItemPool.New(UINFlappyGiftItem, self.ui.awardItem)
  self.__entity2ObjDic = {}
  self.ui.scene:SetActive(false)
  self.__back2Start = BindCallback(self, self.BackToStart)
  self:SetMainPageTween(true)
  self.__midBgMat = cs_Material(self.ui.mat_midBg)
  self.__midProgress = 0
  self.ui.img_midBg.material = self.__midBgMat
  self.__longBgMat = cs_Material(self.ui.mat_midBg)
  self.__longProgress = 0
  self.ui.img_longBg.material = self.__longBgMat
  self.__birdMat = cs_Material(self.ui.mat_BirdNormal)
  self.ui.rmg_bird.material = self.__birdMat
  self.__showAwardFunc = BindCallback(self, self.__ShowAwardPanel)
  self.__hideAwardFunc = BindCallback(self, self.__HideAwardPanel)
  self:PlayStartBgm()
end

function UIFlappyBird:PlayStartBgm()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.BGM)
end

function UIFlappyBird:OnGetScore(score)
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.GetPoint)
  self:RefreshScore(score)
end

function UIFlappyBird:FlappyBirdGameFailure()
  self.ui.btn_Play.gameObject:SetActive(true)
  self.ui.btn_end.gameObject:SetActive(true)
end

function UIFlappyBird:InjectAction(startGameAction, inputJumpAction, resetGameAction, getScoreAction, exitAction, reqShowRanking)
  self.__startGameAction = startGameAction
  self.__inputJumpAction = inputJumpAction
  self.__resetGameAction = resetGameAction
  self.__getScoreAction = getScoreAction
  self.__exitAction = exitAction
  self.__reqShowRanking = reqShowRanking
end

function UIFlappyBird:OnBirdStart()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnStartGame)
end

function UIFlappyBird:SetIsHistoryOpen(isHistoryOpen, HTGData, isRemaster, endTime)
  self.__isHistoryOpen = isHistoryOpen
  self.__isRemaster = isRemaster
  if self.__isHistoryOpen then
    self.ui.tex_Time.text = HTGData:GetPlayEndTimeStr()
  else
    local date = TimeUtil:TimestampToDate(endTime)
    self.ui.tex_Time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  end
  self:ShowProgressObj()
end

function UIFlappyBird:ShowProgress(progress, birdId, hasGettedJoinReward)
  local strProcess = tostring(progress / 100)
  self.ui.tex_Rate:SetIndex(0, strProcess)
  self.ui.tex_tatalRate.text = strProcess .. "%"
  self.ui.bar.value = progress / 10000
  self:InitGlobleAwards(progress, birdId)
  self.hasGettedJoinReward = hasGettedJoinReward
  if not hasGettedJoinReward then
    self:__ShowFirstAwardPanel(birdId)
  end
  self:ShowProgressObj()
end

function UIFlappyBird:__ShowFirstAwardPanel(birdId)
  local fbConfig = ConfigData.flappy_bird[birdId]
  if fbConfig == nil then
    error("找不到对应的flappy bird 配置，birdid:" .. tostring(birdId))
    return
  end
  self:__ShowAwardPanel(fbConfig.firstAwards, fbConfig, FirstAwardTitleIndex, self.ui.firstAwardPanelRoot)
end

function UIFlappyBird:__ShowRanking()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  self:__HideAwardPanel()
  if self.__reqShowRanking ~= nil then
    self:SetMainUIShow(false)
    self.__reqShowRanking()
  end
end

function UIFlappyBird:SetMainUIShow(active)
  self.ui.main.gameObject:SetActive(active)
end

function UIFlappyBird:InitBird(birdEntity)
  local birdItem = {
    transform = self.ui.obj_bird.transform
  }
  self.__entity2ObjDic[birdEntity] = birdItem
  self:SetEntityPos(birdEntity)
end

function UIFlappyBird:InitTubeEntityFromItemPool(entityList)
  for _, entity in ipairs(entityList) do
    local item = self:__InitEnityFromItemPool(entity, self.tubePool)
    if item ~= nil then
      item:SetImgWithTubeType(entity:GetTubeType())
      item:SetTubeUISize(entity.colliderBox)
    end
  end
end

function UIFlappyBird:__InitEnityFromItemPool(entity, itemPool)
  local entityItem = itemPool:GetOne(true)
  self.__entity2ObjDic[entity] = entityItem
  self:SetEntityPos(entity)
  return entityItem
end

function UIFlappyBird:__RecycleEntityToItemPool(entity, itemPool)
  local item = self.__entity2ObjDic[entity]
  if item ~= nil then
    itemPool:HideOne(item)
    self.__entity2ObjDic[entity] = nil
  end
end

function UIFlappyBird:RecycleATube(tubeEntities)
  for _, tubeEntity in ipairs(tubeEntities) do
    self:__RecycleEntityToItemPool(tubeEntity, self.tubePool)
  end
end

function UIFlappyBird:InitChocolate(ehocolateEntity)
  self:__InitEnityFromItemPool(ehocolateEntity, self.chocolatePool)
end

function UIFlappyBird:RecycleChocolate(ehocolateEntity)
  self:__RecycleEntityToItemPool(ehocolateEntity, self.chocolatePool)
end

function UIFlappyBird:InitAccItem(accEntity)
  self:__InitEnityFromItemPool(accEntity, self.accPool)
end

function UIFlappyBird:RecycleAccItem(accEntity)
  self:__RecycleEntityToItemPool(accEntity, self.accPool)
end

function UIFlappyBird:UpdateEntityRender(timeRate, entity)
  if self.__entity2ObjDic[entity] == nil then
    return
  end
  local trans = self.__entity2ObjDic[entity].transform
  if IsNull(trans) then
    return
  end
  local newPos = entity:LogicPos2UnityPos()
  if not self.ui.isNeedLerp or timeRate <= 0 then
    trans.anchoredPosition = newPos
    return
  end
  local newPos = Vector2.Lerp(trans.anchoredPosition, newPos, timeRate)
  trans.anchoredPosition = newPos
  if isGameDev then
    self:DrawDebugOutLine(entity)
  end
end

function UIFlappyBird:SetEntityPos(entity)
  if entity == nil or self.__entity2ObjDic[entity] == nil then
    return
  end
  local trans = self.__entity2ObjDic[entity].transform
  if IsNull(trans) then
    return
  end
  trans.anchoredPosition = entity:LogicPos2UnityPos()
end

function UIFlappyBird:UpdateBirdRotation(birdEntity)
  local birdItem = self.__entity2ObjDic[birdEntity]
  if birdItem == nil then
    return
  end
  local trans = birdItem.transform
  if IsNull(trans) then
    return
  end
  trans.localRotation = Quaternion.Euler(0, 0, birdEntity.velocity.y / 3000)
end

function UIFlappyBird:PlayBirdDeadTween(birdEntity, resultCB)
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnBirdDie)
  local birdItem = self.__entity2ObjDic[birdEntity]
  if self.deadSeq ~= nil then
    self.deadSeq:Kill()
    self.deadSeq = nil
  end
  if birdItem == nil then
    resultCB()
    return
  end
  local trans = birdItem.transform
  if IsNull(trans) then
    resultCB()
    return
  end
  self.deadProcess = {}
  local tweenOver = false
  local animaOver = false
  table.insert(self.deadProcess, tweenOver)
  table.insert(self.deadProcess, animaOver)
  
  local function tryOverFun()
    table.remove(self.deadProcess, 1)
    if #self.deadProcess <= 0 then
      resultCB()
    end
  end
  
  local deadSeq = cs_DoTween.Sequence()
  deadSeq:Append(trans:DOLocalMoveY(-1225, 1.5):SetRelative(true):SetEase(cs_Tweening.Ease.InBack))
  deadSeq:Join(trans:DOLocalRotate(Vector3.New(0, 0, 360), 0.5, cs_Tweening.RotateMode.FastBeyond360):SetLoops(3):SetEase(cs_Tweening.Ease.Linear):SetRelative(true))
  deadSeq:OnComplete(tryOverFun)
  self.deadSeq = deadSeq
  self:FlappyBirdGameFailure()
  self.overTimer = TimerManager:StartTimer(1.5, tryOverFun, self, true)
end

function UIFlappyBird:InitGlobleAwards(progress, birdId)
  local fbConfig = ConfigData.flappy_bird[birdId]
  if fbConfig == nil then
    error("找不到对应的flappy bird 配置，birdid:" .. tostring(birdId))
    return
  end
  self.giftPool:HideAll()
  if fbConfig.progress_precent == nil or #fbConfig.progress_precent <= 0 then
    return
  end
  local totalWidth = self.ui.awardItemRoot.rect.width
  for i = 1, #fbConfig.progress_precent do
    local curPercent = fbConfig.progress_precent[i]
    local giftItem = self.giftPool:GetOne()
    giftItem:InjectAwardData(fbConfig, self.__showAwardFunc, i)
    giftItem:UpdatePosAndTips(progress, curPercent, totalWidth)
  end
end

function UIFlappyBird:__ShowAwardPanel(awards, fbConfig, titleTextIndex, rootTrans)
  if self.awardPanel == nil then
    self.awardPanel = UINFlappyAwardPanel.New()
    self.awardPanel:Init(self.ui.awardView)
  end
  if 0 < titleTextIndex then
    self.ui.btn_awardPanelBack.gameObject:SetActive(true)
  end
  if not IsNull(rootTrans) then
    self.awardPanel.transform:SetParent(rootTrans, false)
  end
  self.awardPanel:ShowAwardList(awards, fbConfig, titleTextIndex)
  self.awardPanel:Show()
end

function UIFlappyBird:__HideAwardPanel()
  if self.awardPanel == nil or not self.awardPanel.active then
    return
  end
  if not self.hasGettedJoinReward then
    return
  else
    self.ui.btn_awardPanelBack.gameObject:SetActive(false)
  end
  self.awardPanel:Hide()
end

function UIFlappyBird:ShowFinger(value)
  self.ui.fingerTips:SetActive(value)
end

function UIFlappyBird:OnDetectedChocolate()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnChocolateGet)
end

function UIFlappyBird:OnClickStart()
  self:OnBirdStart()
  self:__HideAwardPanel()
  self.ui.start:SetActive(true)
  self.tubePool:HideAll()
  self.chocolatePool:HideAll()
  self.accPool:HideAll()
  self.__entity2ObjDic = {}
  self:SetMainUIShow(false)
  self.ui.btn_end.gameObject:SetActive(false)
  self.ui.scene:SetActive(true)
  self.ui.background.interactable = true
  self:__ShowReadGoAndStart()
end

function UIFlappyBird:SetMainPageTween(active, cb)
  if self.mainSeq ~= nil then
    self.mainSeq:Pause()
    self.ui.mainFrame.sizeDelta = Vector2.New(0, 1200)
    self.mainSeq:Restart()
  else
    local seq = cs_DoTween.Sequence()
    self.ui.mainFrame.sizeDelta = Vector2.New(0, 1200)
    seq:Append(self.ui.mainFrame:DOSizeDelta(Vector2.New(0, 0), 0.6))
    seq:OnComplete(cb)
    seq:SetAutoKill(false)
    self.mainSeq = seq
  end
end

function UIFlappyBird:__ShowReadGoAndStart()
  self.ui.obj_ready:SetActive(true)
  if self.birdRestPosSeq ~= nil then
    self.birdRestPosSeq:Pause()
    self.ui.birdTrans.anchoredPosition3D = self.ui.birdReadyPos
    self.birdRestPosSeq:Restart()
  else
    local seq = cs_DoTween.Sequence()
    self.ui.birdTrans.anchoredPosition3D = self.ui.birdReadyPos
    seq:Append(self.ui.birdTrans:DOMoveY(0, 1))
    seq:SetAutoKill(false)
    self.birdRestPosSeq = seq
  end
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnReadyGo)
  self.readyTimer = TimerManager:StartTimer(0.8, function()
    self.ui.obj_ready:SetActive(false)
    self.ui.obj_go:SetActive(true)
  end, self, true)
  self.goTimer = TimerManager:StartTimer(1.6, function()
    self.ui.obj_go:SetActive(false)
    if self.__startGameAction ~= nil then
      self.__startGameAction(false)
    end
  end, self, true)
end

function UIFlappyBird:OnClickJump()
  if self.__inputJumpAction == nil then
    return
  end
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnBirdJump)
  self.__inputJumpAction()
end

function UIFlappyBird:RefreshScore(score)
  self.ui.tex_score.text = tostring(score)
end

function UIFlappyBird:RefreshHighestScore(maxScore)
  if maxScore == nil then
    return
  end
  self.ui.cur_textScore.gameObject:SetActive(true)
  self.ui.cur_textScore:SetIndex(0, tostring(maxScore))
end

function UIFlappyBird:ShowProgressObj()
  self.ui.objProgress:SetActive(self.hasGettedJoinReward and (not self.__isHistoryOpen or self.__isRemaster))
end

function UIFlappyBird:BackToStart()
  self:ShowFinger(true)
  self.ui.btn_end.gameObject:SetActive(false)
  self:SetMainUIShow(true)
  self.ui.scene:SetActive(false)
  self.ui.start:SetActive(false)
  self:SetMainPageTween(true)
  self.__midProgress = 0
  self.__longProgress = 0
  if self.__resetGameAction ~= nil then
    self.__resetGameAction()
  end
  self:PlayStartBgm()
end

function UIFlappyBird:OnAccStateChange(bool)
  if bool then
    AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnAccState)
    AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnAccItemGet)
  end
  self.ui.img_invinceable:SetActive(bool)
end

function UIFlappyBird:OnShowInvinciableChange(bool, speed)
  if bool then
    self.__birdMat:EnableKeyword("SPLASH_ON")
    self.__birdMat:SetFloat("_SplashSpeed", speed)
  else
    self.__birdMat:DisableKeyword("SPLASH_ON")
  end
end

function UIFlappyBird:OnCloseFlapply()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  self:BackToGame()
  if self.__exitAction ~= nil then
    self.__exitAction()
  end
  self:Delete()
end

function UIFlappyBird:OnReturnClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFlappyBird:__ShowGuideNode()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  self:__HideAwardPanel()
  self:SetMainUIShow(false)
  if self.uiGuide == nil then
    self.uiGuide = UINFlappyGuide.New()
    self.uiGuide:Init(self.ui.flappyBirdGuide)
    self.uiGuide:InjectBackAction(self.__back2Start)
  end
  self.uiGuide:Show()
end

function UIFlappyBird:__ShowPause()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  if self.uiPause == nil then
    self.uiPause = UINFlappyPause.New()
    self.uiPause:Init(self.ui.flappyBirdPause)
    self.uiPause:InjectPauseAction(BindCallback(self, self.BackToGame), BindCallback(self, self.__CallRestartGame), BindCallback(self, self.OnReturnClicked))
  end
  if self.__getScoreAction ~= nil then
    local score = self.__getScoreAction()
    self.uiPause:ShowScore(score)
  end
  Time:SetTimeScale(0)
  self.__isPause = true
  self.uiPause:Show()
end

function UIFlappyBird:__CallRestartGame()
  self:BackToGame()
  self:BackToStart()
  self:OnClickStart()
end

function UIFlappyBird:BackToGame()
  self.__isPause = false
  Time:SetTimeScale(1)
end

function UIFlappyBird:ShowFlappyBirdResult(respMsg, resultRankData, mineGrade, hasGettedJoinReward)
  self.hasGettedJoinReward = hasGettedJoinReward
  self:ShowProgressObj()
  self:__HideAwardPanel()
  self.ui.btn_end.gameObject:SetActive(false)
  if self.resultNode == nil then
    self.resultNode = UINFlappyResult.New()
    self.resultNode:Init(self.ui.flappyBirdResult)
    self.resultNode:InjectRestartAction(self.__back2Start)
  end
  self.resultNode:Show()
  self.resultNode:RefreshScore(respMsg.score, respMsg.beyondProgress, self.__isHistoryOpen, self.__isRemaster)
  self.resultNode:RefreshResultRank(resultRankData, mineGrade)
end

function UIFlappyBird:SetMiddleBackgroundSpeed(midNum, longNum)
  if self.__isPause then
    return
  end
  self.__midProgress = self.__midProgress + midNum
  self.__midProgress = self.__midProgress - math.floor(self.__midProgress)
  self.__midBgMat:SetFloat("_Progress", self.__midProgress)
  self.__longProgress = self.__midProgress + longNum
  self.__longProgress = self.__longProgress - math.floor(self.__longProgress)
  self.__longBgMat:SetFloat("_Progress", self.__longProgress)
end

function UIFlappyBird:OnDelete()
  self.__isPause = false
  if self.readyTimer ~= nil then
    TimerManager:StopTimer(self.readyTimer)
    self.readyTimer = nil
  end
  if self.goTimer ~= nil then
    TimerManager:StopTimer(self.goTimer)
    self.goTimer = nil
  end
  if self.overTimer ~= nil then
    TimerManager:StopTimer(self.overTimer)
    self.overTimer = nil
  end
  base.OnDelete(self)
  if self.uiGuide ~= nil then
    self.uiGuide:OnDelete()
  end
  if self.uiPause ~= nil then
    self.uiPause:OnDelete()
  end
  if self.mainSeq ~= nil then
    self.mainSeq:Kill()
    self.mainSeq = nil
  end
  if self.deadSeq ~= nil then
    self.deadSeq:Kill()
    self.deadSeq = nil
  end
  if self.birdRestPosSeq ~= nil then
    self.birdRestPosSeq:Kill()
    self.birdRestPosSeq = nil
  end
  if self.__midBgMat ~= nil then
    DestroyUnityObject(self.__midBgMat)
    self.__midBgMat = nil
  end
  if self.__longBgMat ~= nil then
    DestroyUnityObject(self.__longBgMat)
    self.__longBgMat = nil
  end
  if self.__birdMat ~= nil then
    DestroyUnityObject(self.__birdMat)
    self.__birdMat = nil
  end
  self.tubePool:DeleteAll()
  self.chocolatePool:DeleteAll()
  self.accPool:DeleteAll()
  self.giftPool:DeleteAll()
end

function UIFlappyBird:DrawDebugOutLine(entity, duration)
  duration = duration or 0
  local item = self.__entity2ObjDic[entity]
  if item == nil then
    return
  end
  local pos = item.transform.position
  local left = pos.x + entity.colliderBox.left / 1000 * 0.04962022
  local bottom = pos.y + entity.colliderBox.bottom / 1000 * 0.04962022
  local right = pos.x + entity.colliderBox.right / 1000 * 0.04962022
  local top = pos.y + entity.colliderBox.top / 1000 * 0.04962022
  local LB = Vector2.New(left, bottom)
  local RB = Vector2.New(right, bottom)
  local LT = Vector2.New(left, top)
  local RT = Vector2.New(right, top)
  cs_Debug.DrawLine(LB, RB, Color.green, duration)
  cs_Debug.DrawLine(RB, RT, Color.green)
  cs_Debug.DrawLine(RT, LT, Color.green)
  cs_Debug.DrawLine(LT, LB, Color.green)
end

return UIFlappyBird
