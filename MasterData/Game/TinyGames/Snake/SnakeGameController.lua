local SnakeGameController = class("SnakeGameController")
local SnakeGameConfig = require("Game.TinyGames.Snake.Config.SnakeGameConfig")
local SnakeHead = require("Game.TinyGames.Snake.Entity.SnakeHead")
local SnakeBody = require("Game.TinyGames.Snake.Entity.SnakeBody")
local tinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local CS_Input = CS.UnityEngine.Input
local util = require("XLua.Common.xlua_util")
local TinyGameUtil = require("Game.TinyGames.TinyGameUtil")
local Key = 673312
local SnakeGameState = {
  Inited = 0,
  Play = 1,
  End = 2,
  Pause = 3,
  Ready = 4
}
local SnakeDataType = {
  Empty = 0,
  Snake = 1,
  Food = 2,
  Obstacle = 3
}

function SnakeGameController:ctor(actData, isHistoryOpen, HTGData)
  self.__actData = actData
  self.__snakeGame = actData:GetActTinyGameData()
  self.__isHistoryOpen = isHistoryOpen
  self.__HTGData = HTGData
  self.sComRes = {}
  self:GenHeroIdList()
  self._snakeBodyPool = CommonPool.New(function()
    local go = self.sComRes.snakeBodyPrefab:Instantiate(self._entityRoot)
    local snake = SnakeBody.New(go)
    local heroId = self:GetRandomHeroId()
    snake:SetSnakeSkin(heroId)
    return snake
  end, function(snake)
    snake:ResetSnakeAnimator()
    snake:SetSnakeActive(false)
    return true
  end)
end

function SnakeGameController:GenHeroIdList()
  self.heroIdList = {}
  local heroDataTable = ConfigData.hero_data
  for key, value in pairs(heroDataTable) do
    table.insert(self.heroIdList, key)
  end
end

function SnakeGameController:GetRandomHeroId()
  if self.heroIdList ~= nil then
    local index = math.random(1, #self.heroIdList)
    local heroId = self.heroIdList[index]
    return heroId
  end
  return 1001
end

function SnakeGameController:BindSnakeExitEvent(exitEvent)
  self._exitEvent = exitEvent
end

function SnakeGameController:GetSnakeActEndTime()
  return self.__actData:GetActivityEndTime()
end

function SnakeGameController:GetSnakeRuleId()
  return self.__snakeGame:GetSnakeRuleId()
end

function SnakeGameController:GetSnakeGameData()
  return self.__snakeGame
end

function SnakeGameController:GetGameSnakeScore()
  return self._score ~ Key
end

function SnakeGameController:SetGameSnakeScore(score)
  self._score = score ~ Key
end

function SnakeGameController:EnterSnakeGame()
  NetworkManager.luaNetworkAgent:AddLogoutAutoDelete(self)
  self.comResloader = CS.ResLoader.Create()
  UIManager:DeleteAllWindow()
  
  local function preLoadFunc()
    local headPath
    if PlayerDataCenter.inforData:GetSex() then
      headPath = PathConsts:GetTinyGamePrefabPath(SnakeGameConfig.SnakeHeadPrefab)
    else
      headPath = PathConsts:GetTinyGamePrefabPath(SnakeGameConfig.SnakeHeadBoyPrefab)
    end
    local headPrefabWait = self.comResloader:LoadABAssetAsyncAwait(headPath)
    local bodyPrefabWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetTinyGamePrefabPath(SnakeGameConfig.SnakeBodyPrefab))
    local eatEffectWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetWarChessEffectPrefabPath("FXP_jiuyuan_end"))
    local foodEffectWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetWarChessEffectPrefabPath("FXP_jiuyuan_loop"))
    coroutine.yield(headPrefabWait)
    self.sComRes.snakeHeadPrefab = headPrefabWait.Result
    coroutine.yield(bodyPrefabWait)
    self.sComRes.snakeBodyPrefab = bodyPrefabWait.Result
    coroutine.yield(eatEffectWait)
    self.sComRes.eatEffectPrefab = eatEffectWait.Result
    coroutine.yield(foodEffectWait)
    self.sComRes.foodEffectPrefab = foodEffectWait.Result
    self._entityRoot = CS.UnityEngine.GameObject("ObjectRoot").transform
    self._entityRoot.transform.localPosition = Vector3.New(0, -0.5, 0)
    local headGo = self.sComRes.snakeHeadPrefab:Instantiate(self._entityRoot)
    self._snakeHead = SnakeHead.New(headGo)
    self._snakeHead:SetSnakeActive(headGo)
    self._eatEffect = self.sComRes.eatEffectPrefab:Instantiate()
    self._foodEffect = self.sComRes.foodEffectPrefab:Instantiate()
    self._eatEffect:SetActive(false)
    self._foodEffect:SetActive(false)
    UIManager:ShowWindowAsync(UIWindowTypeID.SnakeGame)
    repeat
      coroutine.yield(nil)
      self.snakeWindow = UIManager:GetWindow(UIWindowTypeID.SnakeGame)
    until self.snakeWindow
  end
  
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.SnakeGame, function(ok)
    self:ShowSnakeGameMain()
  end, util.cs_generator(preLoadFunc))
end

function SnakeGameController:ShowSnakeGameMain()
  if self.snakeWindow == nil then
    return
  end
  AudioManager:PlayAudioById(3342)
  self._state = SnakeGameState.Inited
  self:__InitSnakeRankInfo()
  self.snakeWindow:_InitSnakeGameUI(self)
  self.snakeWindow:RefeshSnakeBestScore(self._mineGrade.score, self._rankIndex)
  self.snakeWindow:EnterSnakeInitStateUI()
  self._onUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self._onUpdate)
end

function SnakeGameController:StartSnakeGame()
  if self._state ~= SnakeGameState.Inited then
    return
  end
  self.snakeWindow:InitSnakePlayUI()
  self._state = SnakeGameState.Ready
  local seed = math.random(100, CommonUtil.Int32Max)
  if isGameDev then
    print("snake seed:" .. tostring(seed))
  end
  self._random = CS.FixRandom(seed)
  self._worldData = {}
  for i = 0, SnakeGameConfig.GWorldSizeX - 1 do
    self._worldData[i] = table.GetDefaulValueTable(0)
  end
  self._snakeDir = SnakeGameConfig.PlayerInitDir
  self._lastSnakeDir = self._snakeDir
  self._logicTime = 0
  self._logicInterval = SnakeGameConfig.SnakeInitTime
  self._curLogicInterval = self._logicInterval
  self._isQuickMove = false
  self._foodEntitys = {}
  self:SetGameSnakeScore(0)
  self._snakeEntitys = {}
  self._snakeHead:DirectSetSnakePosDir(SnakeGameConfig.PlayerInitPosX, SnakeGameConfig.PlayerInitPosZ, self._snakeDir)
  self._snakeHead:SetSnakeActive(true)
  self._snakeHead:ResetSnakeAnimator()
  self._snakeHead:PlaySnakeStartAni()
  self._snakeEntitys[1] = self._snakeHead
  self._worldData[self._snakeHead.x][self._snakeHead.z] = SnakeDataType.Snake
  for i = 1, SnakeGameConfig.PlayerInitLength do
    local rdir = SnakeGameConfig.DirResverMap[self._snakeDir]
    local dirVector = SnakeGameConfig.DirVectorMap[rdir]
    if dirVector ~= nil then
      local head = self._snakeHead
      local x = head.x + dirVector.x * i
      local y = head.z + dirVector.y * i
      local snakeBody = self._snakeBodyPool:PoolGet()
      snakeBody:SetSnakeActive(true)
      snakeBody:DirectSetSnakePosDir(x, y, self._snakeDir)
      snakeBody:PlaySnakeStartAni()
      table.insert(self._snakeEntitys, snakeBody)
      self._worldData[x][y] = SnakeDataType.Snake
    end
  end
  self:_GenSnakeFood()
  self.snakeWindow:ShowSnakeReadyUI(function()
    self._state = SnakeGameState.Play
  end)
end

function SnakeGameController:_GenSnakeFood()
  local success, x, z = self:_GenEmptyPoint()
  if not success then
    self:_EndSnakeGame()
    return false
  end
  local snakeBody = self._snakeBodyPool:PoolGet()
  snakeBody:SetSnakeActive(true)
  snakeBody:DirectSetSnakePosDir(x, z, math.random(1, 4))
  local k = x << 16 | z
  self._foodEntitys[k] = snakeBody
  self._worldData[x][z] = SnakeDataType.Food
  self._foodEffect.transform.localPosition = Vector3.New(-x, 0, z)
  self._foodEffect:SetActive(true)
  return true
end

function SnakeGameController:_GenEmptyPoint()
  local lastCount = SnakeGameConfig.GWorldPointCount - #self._snakeEntitys
  if lastCount <= 0 then
    return false
  end
  local index = self._random:RandUInt(0, lastCount)
  local x, z
  local ci = 0
  for rx = 0, SnakeGameConfig.GWorldSizeX - 1 do
    for rz = 0, SnakeGameConfig.GWorldSizeZ - 1 do
      if self._worldData[rx][rz] == 0 then
        if ci == index then
          return true, rx, rz
        else
          ci = ci + 1
        end
      end
    end
  end
  return false
end

function SnakeGameController:OnUpdate()
  if CS_Input.GetKeyUp("escape") then
    UIUtil.OnClickBackByUiTab(self)
  end
  if self._state ~= SnakeGameState.Play then
    return
  end
  self:CheckKeyInput()
  self._logicTime = self._logicTime + Time.deltaTime
  if self._logicTime >= self._curLogicInterval then
    self._curLogicInterval = self._logicInterval
    if self._isQuickMove then
      for k, snake in pairs(self._snakeEntitys) do
        snake:ResetSnakeFastForward()
      end
      self._isQuickMove = false
    end
    self._logicTime = 0
    self:_MoveSnake()
  end
end

function SnakeGameController:CheckKeyInput()
  if not CS_Input.anyKeyDown then
    return false
  end
  local dir = 0
  if CS_Input.GetKeyDown("up") then
    dir = 1
  elseif CS_Input.GetKeyDown("down") then
    dir = 2
  elseif CS_Input.GetKeyDown("left") then
    dir = 3
  elseif CS_Input.GetKeyDown("right") then
    dir = 4
  end
  if 0 < dir then
    return self:TryChangeSnakeDir(dir)
  end
  return false
end

function SnakeGameController:TryChangeSnakeDir(dir)
  if self._state ~= SnakeGameState.Play then
    return
  end
  if SnakeGameConfig.DirResverMap[dir] == self._lastSnakeDir then
    return false
  end
  if self._snakeDir == dir then
    return false
  end
  self._snakeDir = dir
  if not self._isQuickMove and not self:_IsNextDirDeaded(dir) and self._lastSnakeDir ~= dir then
    self._curLogicInterval = self._logicInterval * SnakeGameConfig.QuickDirRatio
    self._isQuickMove = true
    if self._logicTime < self._curLogicInterval then
      for k, snake in pairs(self._snakeEntitys) do
        snake:SetSnakeQuick(SnakeGameConfig.QuickDirTimeScale)
      end
    end
  end
  return true
end

function SnakeGameController:_IsNextDirDeaded(dir)
  local dirVector = SnakeGameConfig.DirVectorMap[dir]
  if dirVector == nil then
    return false
  end
  local head = self._snakeEntitys[1]
  if head == nil then
    return false
  end
  local nextx = head.x + dirVector.x
  local nexty = head.z + dirVector.y
  local dataType
  if 0 <= nextx and nextx < SnakeGameConfig.GWorldSizeX and 0 <= nexty and nexty < SnakeGameConfig.GWorldSizeZ then
    dataType = self._worldData[nextx][nexty]
  end
  if dataType == SnakeDataType.Empty or dataType == SnakeDataType.Food then
    return false
  end
  return true
end

function SnakeGameController:_MoveSnake()
  local dirVector = SnakeGameConfig.DirVectorMap[self._snakeDir]
  if dirVector == nil then
    return
  end
  local head = self._snakeEntitys[1]
  if head == nil then
    return
  end
  self._lastSnakeDir = self._snakeDir
  local nextx = head.x + dirVector.x
  local nexty = head.z + dirVector.y
  local dataType
  if 0 <= nextx and nextx < SnakeGameConfig.GWorldSizeX and 0 <= nexty and nexty < SnakeGameConfig.GWorldSizeZ then
    dataType = self._worldData[nextx][nexty]
  end
  AudioManager:PlayAudioById(1265)
  if dataType == SnakeDataType.Empty then
    self:_MoveSnakeStep(nextx, nexty, self._snakeDir)
    return
  elseif dataType == SnakeDataType.Food then
    self._eatEffect:SetActive(false)
    self._eatEffect:SetActive(true)
    self._eatEffect.transform.localPosition = Vector3.New(-nextx, 0, nexty)
    local newInterval = SnakeGameConfig.SnakeInitTime - (SnakeGameConfig.SnakeInitTime - SnakeGameConfig.SnakeMinTime) * math.min(1, (#self._snakeEntitys - SnakeGameConfig.PlayerInitLength) / SnakeGameConfig.SnakeIncreaseNumber)
    local isNewSpeed = self._logicInterval ~= newInterval
    self._logicInterval = newInterval
    self._curLogicInterval = self._logicInterval
    local snakeTail = self._snakeEntitys[#self._snakeEntitys]
    local tailX, tailZ = snakeTail.x, snakeTail.z
    local tailDir = snakeTail.esdir
    self:_MoveSnakeStep(nextx, nexty, self._snakeDir)
    local k = nextx << 16 | nexty
    local snakeBody = self._foodEntitys[k]
    if snakeBody ~= nil then
      self._foodEntitys[k] = nil
      snakeBody:DirectSetSnakePosDir(tailX, tailZ, tailDir)
      snakeBody:PlaySnakeStartAni()
      table.insert(self._snakeEntitys, snakeBody)
      self._worldData[tailX][tailZ] = SnakeDataType.Snake
    end
    AudioManager:PlayAudioById(1266)
    if not self:_GenSnakeFood() then
      self._foodEffect:SetActive(false)
      self:_EndSnakeGame()
      return
    end
    local newScore = self:GetGameSnakeScore() + 1
    self:SetGameSnakeScore(newScore)
    self.snakeWindow:RefreshSnakeScore(newScore)
    if isNewSpeed then
      self:_RefreshSnakeAniSpeed()
    end
    return
  end
  self:_EndSnakeGame()
end

function SnakeGameController:_MoveSnakeStep(nextx, nexty, dir)
  self._worldData[nextx][nexty] = SnakeDataType.Snake
  for _, snake in pairs(self._snakeEntitys) do
    local x, z = snake.x, snake.z
    local d = snake.esdir
    snake:MoveSnakeEntity(nextx, nexty, self._logicInterval)
    snake:RotateSnakeDir(dir, self._logicInterval)
    nextx, nexty = x, z
    dir = d
  end
  self._worldData[nextx][nexty] = nil
end

function SnakeGameController:_RefreshSnakeAniSpeed()
  local aniPower = SnakeGameConfig.SnakeInitTime / SnakeGameConfig.SnakeMinTime - 1
  local numRatio = math.min(1, (#self._snakeEntitys - 1 - SnakeGameConfig.PlayerInitLength) / SnakeGameConfig.SnakeIncreaseNumber)
  local animatorSpeed = 1 + aniPower * numRatio
  for k, snake in pairs(self._snakeEntitys) do
    snake:SetSnakeAniSpeed(animatorSpeed)
  end
end

function SnakeGameController:_EndSnakeGame()
  if self._state == SnakeGameState.End then
    return
  end
  self._state = SnakeGameState.End
  for k, snake in pairs(self._snakeEntitys) do
    snake:SnakeEntityDead()
  end
  UIUtil.AddOneCover("SnakeGame")
  self._endTimer = TimerManager:StartTimer(SnakeGameConfig.EndWaitTime, self.__RealEndSnakeGame, self, true)
end

function SnakeGameController:__RealEndSnakeGame()
  self._endTimer = nil
  UIUtil.CloseOneCover("SnakeGame")
  local score = self:GetGameSnakeScore()
  local isOverBest, isReward = self:__RefreshSnakeMaxScore(score)
  self.snakeWindow:InitSnakeEndUI(score, self.__snakeGame:GetTinyGameHistoryScore(), self._rankIndex)
  local rewardIds, rewardNums = self.__snakeGame:GetSnakeGameReward()
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(rewardIds, rewardNums)
  self.__snakeGame:UploadTinyGameScore(score, function()
    if isOverBest then
      self.snakeWindow:RefeshSnakeBestScore(self._mineGrade.score, self._rankIndex)
      self.snakeWindow:InitSnakeRewardUI()
    end
    if isReward then
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList(self.__snakeGame:GetSnakeGameReward())
        CRData:SetCRItemTransDic(crTransDic)
        window:AddAndTryShowReward(CRData)
      end)
    end
  end)
end

function SnakeGameController:__RefreshSnakeMaxScore(score)
  local isNewHistory = score > self.__snakeGame:GetTinyGameHistoryScore()
  if not isNewHistory then
    return false, false
  end
  self._mineGrade.score = score
  self._rankIndex = TinyGameUtil.SortTinyGameRankDatas(self._allFriendRanks, self._mineGrade)
  local joinScore, isReward = self.__snakeGame:GetSnakeRewardState()
  local ableReward = not isReward and score >= joinScore
  return true, ableReward
end

function SnakeGameController:_RecycleSnakeEntityState()
  self._snakeHead:SetSnakeActive(false)
  for i = 2, #self._snakeEntitys do
    local snakeBody = self._snakeEntitys[i]
    self._snakeBodyPool:PoolPut(snakeBody)
  end
  for _, foodBody in pairs(self._foodEntitys) do
    self._snakeBodyPool:PoolPut(foodBody)
  end
  self._eatEffect:SetActive(false)
  self._foodEffect:SetActive(false)
end

function SnakeGameController:__InitSnakeRankInfo()
  local allFriendRanks, mineGrade = self.__snakeGame:GetTinyGameRankInfo()
  self._mineGrade = mineGrade
  self._allFriendRanks = allFriendRanks
  self._rankIndex = TinyGameUtil.SortTinyGameRankDatas(self._allFriendRanks, self._mineGrade)
end

function SnakeGameController:__EnterSnakeRank()
  UIManager:ShowWindowAsync(UIWindowTypeID.SnakeGameRank, function(window)
    if window == nil then
      return
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local hisBestScore = activityFrameCtrl:GetTinyGameHistoryHighScore(tinyGameEnum.eType.snake)
    window:RefreshSnakeGameRank(self._allFriendRanks, self._mineGrade, self._rankIndex)
    window:SetSnakeRankHisHighScore(hisBestScore)
  end)
end

function SnakeGameController:ClickSnakeRank()
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(function()
      self:__InitSnakeRankInfo()
      self.snakeWindow:RefeshSnakeBestScore(self._mineGrade.score, self._rankIndex)
      self:__EnterSnakeRank()
    end)
  else
    self:__EnterSnakeRank()
  end
end

function SnakeGameController:ClickSnakeGameReturn()
  if self._state == SnakeGameState.Inited then
    self:ExitTinySnakeGame()
    return true
  elseif self._state == SnakeGameState.Play then
    self._state = SnakeGameState.Pause
    Time.unity_time.timeScale = 0
    self.snakeWindow:EnterSnakePauseUI(true)
  elseif self._state == SnakeGameState.End then
    self:_RecycleSnakeEntityState()
    self.snakeWindow:EnterSnakeInitStateUI()
    self._state = SnakeGameState.Inited
  end
  return false
end

function SnakeGameController:ClickSnakeContinue(showReady)
  if self._state ~= SnakeGameState.Pause then
    return
  end
  self.snakeWindow:EnterSnakePauseUI(false)
  if showReady then
    self.snakeWindow:ShowSnakeReadyUI(function()
      self._state = SnakeGameState.Play
      Time.unity_time.timeScale = 1
    end)
  else
    self._state = SnakeGameState.Play
    Time.unity_time.timeScale = 1
  end
end

function SnakeGameController:ClickSnakeGiveup()
  if self._state ~= SnakeGameState.Pause then
    return
  end
  self:ClickSnakeContinue()
  self:_EndSnakeGame()
end

function SnakeGameController:ClickSnakeRetry()
  if self._state ~= SnakeGameState.Pause and self._state ~= SnakeGameState.End then
    return
  end
  Time.unity_time.timeScale = 1
  self:_RecycleSnakeEntityState()
  self.snakeWindow:EnterSnakeInitStateUI()
  self._state = SnakeGameState.Inited
  self:StartSnakeGame()
end

function SnakeGameController:ExitTinySnakeGame()
  NetworkManager.luaNetworkAgent:RemoveLogoutAutoDelete(self)
  UIManager:DeleteAllWindow()
  if self._exitEvent ~= nil then
    self._exitEvent()
  end
  self:Delete()
end

function SnakeGameController:Delete()
  self:OnDelete()
end

function SnakeGameController:OnDelete()
  if self.comResloader ~= nil then
    self.comResloader:Put2Pool()
    self.comResloader = nil
  end
  if self._endTimer ~= nil then
    TimerManager:StopTimer(self._endTimer)
    self._endTimer = nil
  end
  self.snakeWindow = nil
  UpdateManager:RemoveUpdate(self._onUpdate)
end

return SnakeGameController
