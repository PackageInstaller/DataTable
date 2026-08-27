local SmashingPenguinsController = class("SmashingPenguinsController", ControllerBase)
local base = ControllerBase
local SmashingPenguinsMapCtrl = require("Game.TinyGames.SmashingPenguins.Ctrl.SmashingPenguinsMapCtrl")
local SmashingPenguinsCamCtrl = require("Game.TinyGames.SmashingPenguins.Ctrl.SmashingPenguinsCamCtrl")
local TinyGameFrameController = require("Game.TinyGames.TinyGameFrameController")
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local SmashingPenguinsGameState = SmashingPenguinsEnum.eGameState
local SmashingPenguinsCharacterAnimState = SmashingPenguinsEnum.eCharacterAnimState
local CS_GameObject = CS.UnityEngine.GameObject
local tinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local EnterGameStateFunc = {
  [SmashingPenguinsGameState.Init] = function(self)
    self.__camMain = UIManager:GetMainCamera()
    self.__lightMain = CS_GameObject.FindWithTag(TagConsts.MainLight)
    self.frameCtrl = TinyGameFrameController.New()
    self.ctrls = {}
    self.smashingPenguinsMapCtrl = SmashingPenguinsMapCtrl.New(self)
    self.smashingPenguinsCamCtrl = SmashingPenguinsCamCtrl.New(self)
    self.netWork = NetworkManager:GetNetwork(NetworkTypeID.FlappyBird)
    self.__OnRenderFrameUpdate = BindCallback(self, self.OnRenderFrameUpdate)
    self.__OnLogicFrameUpdate = BindCallback(self, self.OnLogicFrameUpdate)
  end,
  [SmashingPenguinsGameState.GameReady] = function(self)
    if IsNull(self.playUI) then
      return
    end
    self.playUI:HideAllRes()
    self.playUI:RefreshHighestScore(self.maxScore)
    self:FirstRewardInit()
    if IsNull(self.bgm) then
      self.bgm = AudioManager:PlayAudioById(3301)
    end
    for _, ctrl in ipairs(self.ctrls) do
      ctrl:OnGamePrepare()
    end
    self.lowSpeedFrameCount = 0
    self.isGamePause = false
    self.reGetBombs = {}
    self.getBomb = false
    self.currentScore = 0
    self.logicFrameNum = 0
    self:SetIsAllowShowUseBombBtn(false)
    self._mainCharacter:Hide()
    self._mainCharacter.rigidbody.velocity = Vector3.zero
    self.smashingPenguinsCamCtrl:FollowTargetPos(self._mainCharacter)
  end,
  [SmashingPenguinsGameState.GameStart] = function(self)
    if IsNull(self.playUI) then
      return
    end
    self.playUI:ShowInGameUI()
    self.playUI:SetTrackerShow(false)
    self.playUI.gestureGuideImage:SetActive(false)
    for _, ctrl in ipairs(self.ctrls) do
      ctrl:OnGameStart()
    end
    local startMapBlock = self.smashingPenguinsMapCtrl:GetStartMapBlock(self._mainCharacter, self)
    self._mainCharacter:Show()
    self._mainCharacter:InitEntityData(self._mainCharacter, self)
    self._mainCharacter:SetSmashingPenguinsColliderEnabled(true)
    self.frameCtrl:StartRunning(self.__OnLogicFrameUpdate, self.__OnRenderFrameUpdate)
    self:SetIsAllowShowUseBombBtn(true)
  end,
  [SmashingPenguinsGameState.PrepareToFly] = function(self)
    self.playUI:SetTrackerShow(false)
    self.playUI.gestureGuideImage:SetActive(false)
    if self._guideTimer ~= nil then
      TimerManager:StopTimer(self._guideTimer)
      self._guideTimer = nil
    end
    self._guideTimer = TimerManager:StartTimer(3, function()
      if self._currentCannon ~= nil then
        self.playUI.gestureGuideImage:SetActive(true)
        self.playUI.gestureGuideImage.transform.position = self._currentCannon.transform.position
      end
    end)
    self._mainCharacter:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Cry)
    self._mainCharacter.rigidbody.velocity = Vector3.zero
    self._mainCharacter:SetSmashingPenguinsColliderEnabled(false)
  end,
  [SmashingPenguinsGameState.Fly] = function(self)
    self:SetIsAllowShowUseBombBtn(true)
    self.playUI:SetTrackerShow(false)
    self.playUI.gestureGuideImage:SetActive(false)
  end,
  [SmashingPenguinsGameState.CharacterDie] = function(self)
    if not IsNull(self.bgm) then
      AudioManager:StopAudioByBack(self.bgm)
      self.bgm = nil
    end
    AudioManager:PlayAudioById(1282)
    self.playUI:SetTrackerShow(false)
    self.playUI.gestureGuideImage:SetActive(false)
    self.frameCtrl:StopRunning()
    if self.playUI == nil then
      return
    end
    self.playUI:OnCharacterDie()
    self._mainCharacter:SetSmashingPenguinsAnimState(SmashingPenguinsEnum.eCharacterAnimState.Cry)
  end,
  [SmashingPenguinsGameState.GameEnd] = function(self)
    for _, ctrl in ipairs(self.ctrls) do
      ctrl:OnGameEnd()
    end
    if self:GetIsSmashingPenguinsActOver() then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6033))
      local fakeMsg = {}
      fakeMsg.score = self.currentScore
      fakeMsg.beyondProgress = 0
      self.playUI:ShowSmashingPenguinsResult(fakeMsg, table.emptytable, self.maxScore, self.hasGettedJoinReward, true)
      return
    else
      self:__ReqSmashingPenguinsSettle(self.logicFrameNum)
    end
  end
}

function SmashingPenguinsController:InjectModifyMsgAction(setMaxScoreAction, setHasGettedJoinRewardAction)
  self.__setMaxScore = setMaxScoreAction
  self.__setGettedJoinRewardAction = setHasGettedJoinRewardAction
end

function SmashingPenguinsController:SetSmashingPenguinsActEndTime(endTime)
  self.endTime = endTime
end

function SmashingPenguinsController:GetIsSmashingPenguinsActOver()
  return PlayerDataCenter.timestamp >= (self.endTime or 0)
end

function SmashingPenguinsController:ShowSmashingPenguinUIMain(activityFwId, miniGameConfigId, hasGettedJoinReward, maxScore, closeCallback)
  if self:GetIsSmashingPenguinsActOver() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6033))
    return
  end
  AudioManager:RecordCurBgm()
  self.activityFwId = activityFwId
  self.miniGameConfigId = miniGameConfigId
  self.hasGettedJoinReward = hasGettedJoinReward
  self.maxScore = maxScore
  self:SetSmashingPenguinsGameState(SmashingPenguinsGameState.Init)
  self.netWork:CS_FlappyBird_ProgressDetail(self.activityFwId, self.miniGameConfigId, function(objList)
    if objList.Count <= 0 then
      error("CS_FlappyBird_SelfRankDetail objList.Count:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    self:__InternalShowSmashingPenguinsUI(msg.progress, self.maxScore, closeCallback)
  end)
end

function SmashingPenguinsController:__InternalShowSmashingPenguinsUI(progress, maxScore, closeCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.SmashingPenguins, function(window)
    if window ~= nil then
      self:EnableMainCamAndLight(false)
      self.playUI = window
      window:InitSmashingPenguinsMain()
      if progress ~= nil then
        window:ShowSmashingPenguinsProgress(progress, self.miniGameConfigId, self.hasGettedJoinReward)
      end
      window:RefreshHighestScore(maxScore)
      window:SetGameEndTime(self.endTime)
      window:SetCloseCallback(closeCallback)
    end
  end)
end

function SmashingPenguinsController:EnableMainCamAndLight(enable)
  if not IsNull(self.__camMain) then
    self.__camMain.gameObject:SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    self.__lightMain:SetActive(enable)
  end
end

function SmashingPenguinsController:FirstRewardInit()
  local rewardList = ConfigData.flappy_bird[self.miniGameConfigId].firstAwards
  self.itemTransDic = {}
  self.firstRewardDic = {}
  for i, v in pairs(rewardList) do
    local itemCfg = ConfigData.item[v.itemId]
    self.firstRewardDic[v.itemId] = v.count
    if itemCfg.overflow_type == eItemTransType.actMoneyX then
      local num = PlayerDataCenter:GetItemOverflowNum(v.itemId, v.count)
      if num ~= 0 then
        self.itemTransDic[v.itemId] = num
      end
    end
  end
end

function SmashingPenguinsController:GetSmashingPenguinsCharacter()
  return self._mainCharacter
end

function SmashingPenguinsController:SetSmashingPenguinsCharacter(characterEntity)
  self._mainCharacter = characterEntity
end

function SmashingPenguinsController:GetSmashingPenguinsCannon()
  return self._currentCannon
end

function SmashingPenguinsController:SetSmashingPenguinsCannon(cannon)
  self._currentCannon = cannon
  self._mainCharacter.canLookAtDir = true
  self._mainCharacter:LookAtDir(Vector3.left, true)
end

function SmashingPenguinsController:GetSmashingPenguinsGameState()
  return self._currentGameState
end

function SmashingPenguinsController:SetSmashingPenguinsGameState(newState)
  if self._currentGameState == newState then
    return
  end
  self._currentGameState = newState
  if EnterGameStateFunc[newState] ~= nil then
    EnterGameStateFunc[newState](self)
  end
end

function SmashingPenguinsController:ClearSmashingPenguinsGameState()
  if self.frameCtrl:GetIsRunning() then
    self.frameCtrl:StopRunning()
  end
  self._currentGameState = nil
end

function SmashingPenguinsController:ReadySmashingPenguins()
  self:SetSmashingPenguinsGameState(SmashingPenguinsGameState.GameReady)
end

function SmashingPenguinsController:StartSmashingPenguins()
  self:SetSmashingPenguinsGameState(SmashingPenguinsGameState.GameStart)
end

function SmashingPenguinsController:RestartSmashingPenguins()
  if self.frameCtrl:GetIsRunning() then
    self.frameCtrl:StopRunning()
  end
  self:ReadySmashingPenguins()
  self:StartSmashingPenguins()
end

function SmashingPenguinsController:EndSmashingPenguins()
  self:SetSmashingPenguinsGameState(SmashingPenguinsGameState.CharacterDie)
end

function SmashingPenguinsController:SmashingPenguinsResult()
  self:SetSmashingPenguinsGameState(SmashingPenguinsGameState.GameEnd)
end

function SmashingPenguinsController:OnExitSmashingPenguins()
  self:EnableMainCamAndLight(true)
  if not IsNull(self.bgm) then
    AudioManager:StopAudioByBack(self.bgm)
    self.bgm = nil
  end
  if not IsNull(self.dragAudio) then
    AudioManager:StopAudioByBack(self.dragAudio)
    self.dragAudio = nil
  end
  AudioManager:ResumeLastBgm()
  if self.frameCtrl:GetIsRunning() then
    self.frameCtrl:StopRunning()
  end
  if self._guideTimer ~= nil then
    TimerManager:StopTimer(self._guideTimer)
    self._guideTimer = nil
  end
  self:Delete()
end

function SmashingPenguinsController:ReqShowRanking()
  self:__ReqShowRanking()
end

function SmashingPenguinsController:OnGestureStart(finger)
  if self.isGamePause then
    self.dragStartPos = nil
    return
  end
  if self._currentGameState ~= SmashingPenguinsEnum.eGameState.PrepareToFly then
    self.dragStartPos = nil
    return
  end
  if self._mainCharacter == nil or self._currentCannon == nil then
    self.dragStartPos = nil
    return
  end
  self._mainCharacter.canLookAtDir = true
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._mainCharacter.gameObject, finger.ScreenPosition)
  local leftX, rightX, downY, upY = self._mainCharacter:GetLocalUnityBorder()
  if rightX < pos.x or leftX > pos.x or upY < pos.y or downY > pos.y then
    return
  end
  self.playUI.gestureGuideImage:SetActive(false)
  self.dragAudio = AudioManager:PlayAudioById(1276)
  self._touchIndex = finger.Index
  self.dragStartPos = self._mainCharacter.transform.localPosition
  self.dragEndPos = nil
end

function SmashingPenguinsController:OnGesture(fingerList)
  if self.isGamePause then
    self.dragStartPos = nil
    return
  end
  if self._currentGameState ~= SmashingPenguinsEnum.eGameState.PrepareToFly then
    self.dragStartPos = nil
    return
  end
  if self._mainCharacter == nil or self._currentCannon == nil then
    self.dragStartPos = nil
    return
  end
  local finger
  for i = 0, fingerList.Count - 1 do
    local item = fingerList[i]
    if item.Index == self._touchIndex then
      finger = item
      break
    end
  end
  if finger == nil then
    self.dragStartPos = nil
    return
  end
  if self._guideTimer ~= nil then
    TimerManager:ResetTimer(self._guideTimer)
  end
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._mainCharacter.gameObject, finger.ScreenPosition)
  local fireVector = self.dragStartPos - pos
  local dragPower = Vector2.Magnitude(fireVector)
  if dragPower > SmashingPenguinsConfig.MaxCannonDragRange then
    local dragDir = Vector2.Normalize(fireVector)
    fireVector = Vector2.New(dragDir.x * SmashingPenguinsConfig.MaxCannonDragRange, dragDir.y * SmashingPenguinsConfig.MaxCannonDragRange)
  end
  self._mainCharacter:LookAtDir(fireVector, true)
  self._currentCannon:LookAtDir(fireVector)
  self._currentCannon:UpdateCannonLine(self._mainCharacter.transform.position)
  self._mainCharacter.transform.localPosition = self.dragStartPos - fireVector
end

function SmashingPenguinsController:OnGestureEnd(finger)
  if not IsNull(self.dragAudio) then
    AudioManager:StopAudioByBack(self.dragAudio)
    self.dragAudio = nil
  end
  if self.isGamePause then
    self.dragStartPos = nil
    return
  end
  if self._currentGameState ~= SmashingPenguinsEnum.eGameState.PrepareToFly then
    self.dragStartPos = nil
    return
  end
  if self._mainCharacter == nil or self._currentCannon == nil then
    self.dragStartPos = nil
    return
  end
  if self._touchIndex ~= finger.Index then
    self.dragStartPos = nil
    return
  end
  self._touchIndex = nil
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._mainCharacter.gameObject, finger.ScreenPosition)
  self.dragEndPos = pos
  if not IsNull(self.dragStartPos) and not IsNull(self.dragEndPos) then
    self._currentCannon:UpdateCannonLine(self._currentCannon.transform.position)
    local force = self.dragStartPos - self.dragEndPos
    local forceDir = force.normalized
    local forcePower = force.magnitude
    if forcePower >= SmashingPenguinsConfig.MinCannonDragRange then
      AudioManager:PlayAudioById(1277)
      self.smashingPenguinsCamCtrl:SetFollowLimit(self._currentCannon.transform.position, self._mainCharacter.transform.position)
      self._mainCharacter:AddForceToSmashingPenguinsCharacter(forceDir, forcePower * SmashingPenguinsConfig.FirePowerMultiple, SmashingPenguinsConfig.MaxFirePower)
      self:SetSmashingPenguinsGameState(SmashingPenguinsEnum.eGameState.Fly)
      self._currentCannon:SetConnonIsUsed()
      self._currentCannon = nil
      self._mainCharacter:SetSmashingPenguinsUseGravity(true)
      self._mainCharacter:SetSmashingPenguinsColliderEnabled(true)
      if self._guideTimer ~= nil then
        TimerManager:StopTimer(self._guideTimer)
        self._guideTimer = nil
      end
      self.playUI.gestureGuideImage:SetActive(false)
    else
      self._mainCharacter.transform.position = self._currentCannon.transform.position
      self._mainCharacter:LookAtDir(Vector3.left, true)
    end
  end
end

function SmashingPenguinsController:OnRenderFrameUpdate(timeRate)
  if self.isGamePause then
    return
  end
  if self._currentGameState == SmashingPenguinsEnum.eGameState.Fly and not IsNull(self._mainCharacter) then
    self._mainCharacter:LookAtDir(self._mainCharacter.rigidbody.velocity)
    self.smashingPenguinsCamCtrl:FollowTargetPos(self._mainCharacter)
    self.playUI:SetTrackerPos(self._mainCharacter.transform.position)
  elseif self._currentGameState == SmashingPenguinsEnum.eGameState.PrepareToFly and not IsNull(self._currentCannon) then
    self.smashingPenguinsCamCtrl:FollowTargetPos(self._currentCannon)
  end
end

function SmashingPenguinsController:OnLogicFrameUpdate(logicFrameNum)
  self.logicFrameNum = logicFrameNum
  if IsNull(self.playUI) then
    return
  end
  self.playUI:OnUpdateInGameUI()
  if self._currentGameState ~= SmashingPenguinsEnum.eGameState.Fly or IsNull(self._mainCharacter) then
    return
  end
  if self.isGamePause then
    return
  end
  local characterLocalPosition = self.playUI.mapBlockHolder.transform:InverseTransformPoint(self._mainCharacter.transform.position)
  local currentVelocity = self._mainCharacter.rigidbody.velocity
  self.currentScore = math.floor(-characterLocalPosition.x * SmashingPenguinsConfig.DistanceScoreMultiple)
  self.currentScore = math.clamp(self.currentScore, 0, self.currentScore)
  if self._mainCharacter.isMovingToCannon then
    return
  end
  if currentVelocity.x > 0 and characterLocalPosition.x > SmashingPenguinsConfig.MaxXPos then
    currentVelocity.x = -currentVelocity.x
  end
  if 0 < currentVelocity.y and characterLocalPosition.y > SmashingPenguinsConfig.MaxYPos then
    currentVelocity.y = -currentVelocity.y
  end
  self._mainCharacter.rigidbody.velocity = currentVelocity
  if characterLocalPosition.y > SmashingPenguinsConfig.MinYPosShowTracker then
    self.playUI:SetTrackerShow(true)
  else
    self.playUI:SetTrackerShow(false)
  end
  local sqrtSpeed = currentVelocity.sqrMagnitude
  local maxSqrtSpeed = Mathf.Pow(SmashingPenguinsConfig.MaxSpeed, 2)
  if sqrtSpeed > maxSqrtSpeed then
    self._mainCharacter.rigidbody.velocity = currentVelocity.normalized * SmashingPenguinsConfig.MaxSpeed
    currentVelocity = self._mainCharacter.rigidbody.velocity
    sqrtSpeed = maxSqrtSpeed
  end
  self._mainCharacter.canLookAtDir = sqrtSpeed > SmashingPenguinsConfig.MinSqrtSpeedKeepDir
  self._mainCharacter.canPlayCollisionAudio = sqrtSpeed > SmashingPenguinsConfig.MinSqrtSpeedPlayCollisionAudio
  self._mainCharacter:UpdateSmashingPenguinsAnimState()
  if sqrtSpeed < SmashingPenguinsConfig.MinSqrtSpeedKeepRoll then
    self._mainCharacter:SetSmashingPenguinsAnimState(SmashingPenguinsEnum.eCharacterAnimState.Cry)
    self._mainCharacter.canPlayRollAnim = false
  else
    self._mainCharacter.canPlayRollAnim = true
  end
  if sqrtSpeed < SmashingPenguinsConfig.MinSqrtSpeedKeepAlive then
    self.lowSpeedFrameCount = self.lowSpeedFrameCount + 1
    if self.lowSpeedFrameCount > SmashingPenguinsConfig.MaxLogicFrameNumSpeedKeepAlive then
      self:EndSmashingPenguins()
    end
  else
    self.lowSpeedFrameCount = 0
  end
  if characterLocalPosition.y < SmashingPenguinsConfig.MinYPosKeepAlive then
    self:EndSmashingPenguins()
  end
  self.smashingPenguinsMapCtrl:UpdateSmashingPenguinsMapBlocks(self._mainCharacter, self)
end

function SmashingPenguinsController:SetSmashingPenguinsGamePause(isPause)
  if self.isGamePause == isPause then
    return
  end
  self.isGamePause = isPause
  if isPause then
    local gamePauseData = {}
    self.gamePauseData = gamePauseData
    gamePauseData.characterVelocity = self._mainCharacter.rigidbody.velocity
    gamePauseData.characterGravityScale = self._mainCharacter.rigidbody.gravityScale
    self._mainCharacter.rigidbody.velocity = Vector2.zero
    self._mainCharacter.rigidbody.gravityScale = 0
  else
    self._mainCharacter.rigidbody.velocity = self.gamePauseData.characterVelocity
    self._mainCharacter.rigidbody.gravityScale = self.gamePauseData.characterGravityScale
    self.gamePauseData = nil
  end
end

function SmashingPenguinsController:ReGetBomb(bombEntity)
  self.reGetBombs[bombEntity] = true
end

function SmashingPenguinsController:RemoveReGetBomb(bombEntity)
  self.reGetBombs[bombEntity] = nil
end

function SmashingPenguinsController:GetBomb()
  AudioManager:PlayAudioById(1275)
  self.getBomb = true
  self:SetIsAllowShowUseBombBtn(true)
end

function SmashingPenguinsController:SetIsAllowShowUseBombBtn(isAllow)
  if IsNull(self.playUI) then
    return
  end
  if isAllow and self.getBomb and self._currentGameState == SmashingPenguinsEnum.eGameState.Fly then
    self.playUI:SetUseBombBtnShow(true)
    return
  end
  self.playUI:SetUseBombBtnShow(false)
end

function SmashingPenguinsController:UseSmashingPenguinsBomb()
  if self.isGamePause or self.isMovingToCannon or self._currentGameState ~= SmashingPenguinsEnum.eGameState.Fly then
    return
  end
  if not self.getBomb then
    return
  end
  if IsNull(self.playUI) then
    return
  end
  AudioManager:PlayAudioById(1280)
  local explosion = self.playUI.explosionPool:GetOne()
  explosion:InitSmashingPenguinsExplosion()
  explosion.transform.position = self._mainCharacter.transform.position
  local force = Vector2.New(SmashingPenguinsConfig.BombForce.x, SmashingPenguinsConfig.BombForce.y)
  local forceDir = force.normalized
  local forcePower = force.magnitude
  local velocity = self._mainCharacter.rigidbody.velocity
  if velocity.x > 0 then
    velocity.x = velocity.x * SmashingPenguinsConfig.VelocityMultipleBeforeBomb.x
  end
  if velocity.y < 0 then
    velocity.y = velocity.y * SmashingPenguinsConfig.VelocityMultipleBeforeBomb.y
  end
  self._mainCharacter.rigidbody.velocity = velocity
  self._mainCharacter:AddForceToSmashingPenguinsCharacter(forceDir, forcePower)
  self._mainCharacter:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Roll)
  for bombEntity, canPick in pairs(self.reGetBombs) do
    if not bombEntity.isUsed and canPick then
      bombEntity:SetBombGotten()
      return
    end
  end
  if not table.IsEmptyTable(self.reGetBombs) then
    error("炸弹未清空！")
    self.reGetBombs = {}
  end
  self.getBomb = false
  self:SetIsAllowShowUseBombBtn(false)
end

function SmashingPenguinsController:__ReqSmashingPenguinsSettle(logicFrameNum)
  local combineArg = self.currentScore
  self.netWork:CS_FlappyBird_Settle(self.activityFwId, self.miniGameConfigId, self.currentScore, logicFrameNum, combineArg, function(objList)
    if objList.Count <= 0 then
      error("CS_FlappyBird_Settle objList.Count error:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    self:__ShowFirstReward(msg)
    local mineGrade = self:__CreateMineGrade(msg)
    local allFriendData = self:__GetFriendBirdData() or {}
    table.insert(allFriendData, mineGrade)
    self:__SortFriendData(allFriendData)
    local finalData = self:__GetResultFriendRankingData(allFriendData, mineGrade)
    if not self.hasGettedJoinReward and msg.rewards ~= nil and 0 < table.count(msg.rewards) then
      self.hasGettedJoinReward = true
      if self.__setGettedJoinRewardAction ~= nil then
        self.__setGettedJoinRewardAction(true)
      end
    end
    self.playUI:ShowSmashingPenguinsResult(msg, finalData, mineGrade, self.hasGettedJoinReward)
  end)
end

function SmashingPenguinsController:__ShowFirstReward(msg)
  if msg.rewards ~= nil and table.count(msg.rewards) > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(self.firstRewardDic):SetCRNotHandledGreat(true)
      CRData:SetCRItemTransDic(self.itemTransDic)
      window:AddAndTryShowReward(CRData)
    end)
  end
end

function SmashingPenguinsController:__GetFriendBirdData()
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return nil
  end
  local friendsData = PlayerDataCenter.friendDataCenter:GetFreindList()
  if friendsData == nil or #friendsData <= 0 then
    return nil
  end
  local allBirdGrades = {}
  for _, v in ipairs(friendsData) do
    local eachFriendGrade = {}
    eachFriendGrade.name = v:GetUserName()
    eachFriendGrade.score = 0
    eachFriendGrade.uid = v:GetUserUID()
    local frindPenguinsData = v:GetFriendPenguinsData(self.miniGameConfigId)
    if frindPenguinsData ~= nil and frindPenguinsData.gameId == self.miniGameConfigId and frindPenguinsData.gameCat == tinyGameEnum.eType.penguins then
      eachFriendGrade.score = frindPenguinsData.score
    end
    table.insert(allBirdGrades, eachFriendGrade)
  end
  return allBirdGrades
end

function SmashingPenguinsController:__GetResultFriendRankingData(allFriendData, mineGrade)
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

function SmashingPenguinsController:__ReqShowRanking()
  local function LocalFunc_Enter()
    self.netWork:CS_FlappyBird_SelfRankDetail(self.activityFwId, self.miniGameConfigId, function(objList)
      if objList.Count <= 0 then
        error("CS_FlappyBird_SelfRankDetail objList.Count error:" .. tostring(objList.Count))
        
        return
      end
      local msg = objList[0]
      local mineGrade = self:__CreateMineGrade(msg)
      local allFriendData = self:__GetFriendBirdData() or {}
      table.insert(allFriendData, mineGrade)
      self:__SortFriendData(allFriendData)
      UIManager:ShowWindowAsync(UIWindowTypeID.SmashingPenguinsRanking, function(window)
        window:RefreshRankingData(allFriendData, mineGrade)
      end)
    end)
  end
  
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(LocalFunc_Enter)
  else
    LocalFunc_Enter()
  end
end

function SmashingPenguinsController:__SortFriendData(allFriendData)
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

function SmashingPenguinsController:__CreateMineGrade(msg)
  if self.mineGrade == nil then
    self.mineGrade = {}
  end
  self.mineGrade.name = PlayerDataCenter:GetSelfName()
  self.mineGrade.uid = PlayerDataCenter:GetSelfId()
  if msg == nil then
    self.mineGrade.score = 0
    self.mineGrade.bydProgress = 0
  else
    self.mineGrade.score = msg.highestScore or 0
    self.mineGrade.bydProgress = msg.beyondProgress or 0
    self.maxScore = msg.highestScore
    if self.__setMaxScore ~= nil then
      self.__setMaxScore(msg.highestScore)
    end
  end
  return self.mineGrade
end

return SmashingPenguinsController
