local FlappyBirdController = class("FlappyBirdController")
local cs_RangFunc = CS.RandomUtility
local TinyGameFrameController = require("Game.TinyGames.TinyGameFrameController")
local FlappyBird_Bird = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_Bird")
local FlappyBird_TubeGroup = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_TubeGroup")
local FlappyBird_Chocolate = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_Chocolate")
local FlappyBird_AccItem = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_AccItem")
local MapConfig = require("Game.TinyGames.FlappyBird.Config.FlappyBirdMapConfig")
local tinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local PlayGroundHeight = 600000
local PlayGroundWidth = 1500000

function FlappyBirdController:ctor(activityFwId, birdConfigId, hasGettedJoinReward, maxScore, isHistoryOpen, HTGData, isRemaster)
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.FlappyBird)
  self.activityFwId = activityFwId
  self.__isHistoryOpen = isHistoryOpen
  self.__HTGData = HTGData
  self.__isRemaster = isRemaster
  self.birdConfigId = birdConfigId
  self.hasGettedJoinReward = hasGettedJoinReward
  self.maxScore = maxScore
  self.frameCtrl = TinyGameFrameController.New()
  local frameLen = self.frameCtrl:GetLogicFrameLen()
  self:InitGameConfigData(frameLen)
  self:FirstRewardInit()
  self.farthestTubX = 0
  self.birdEntity = nil
  self.livingTubeEntities = {}
  self.recycledTubeEntities = {}
  self.livingChocolateEntities = {}
  self.recycledChocolateEntities = {}
  self.livingAccEntities = {}
  self.recycledAccEntities = {}
  self.__inputBuff = false
  self.__score = 0
  self.__passTube = 0
  self.__getChocoTimes = 0
  self.seed = 0
  self.__isAccing = false
  self.__OnLogicFrameUpdate = BindCallback(self, self.OnLogicFrameUpdate)
  self.__OnRenderFrameUpdate = BindCallback(self, self.OnRenderFrameUpdate)
  self.__startGame = BindCallback(self, self.StartPlay)
  self.__inputJump = BindCallback(self, self.InputJump)
  self.__resetGame = BindCallback(self, self.__ResetGame)
  self.__getScore = BindCallback(self, self.__GetScore)
  self.__onExit = BindCallback(self, self.OnExit)
  self.__showRanking = BindCallback(self, self.__ReqShowRanking)
end

function FlappyBirdController:FirstRewardInit()
  local rewardList = ConfigData.flappy_bird[self.birdConfigId].firstAwards
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

function FlappyBirdController:InjectExitAction(exitAction)
  self.__exitAction = exitAction
end

function FlappyBirdController:InjectModifyBirdMsgAction(setMaxScoreAction, setHasGettedJoinRewardAction)
  self.__setMaxScore = setMaxScoreAction
  self.__setGettedJoinRewardAction = setHasGettedJoinRewardAction
end

function FlappyBirdController:InitGameConfigData(frameLen)
  self.originBackGroundMoveSpeed = MapConfig.originBackGroundMoveSpeed * frameLen
  self:__ResetBgViewSpeed()
  self.originDistance = MapConfig.originDistance
  self.evnData = {
    backGroudMoveSpeed = {
      x = self.originBackGroundMoveSpeed,
      y = 0
    },
    gravityScale = MapConfig.gravityScale * frameLen * frameLen // 100,
    jumpForce = MapConfig.jumpForce * frameLen,
    playGroundHeight = PlayGroundHeight,
    minVerticalVelocity = MapConfig.minVerticalVelocity
  }
end

function FlappyBirdController:ShowFlappyBirdUI()
  if self.__isHistoryOpen and not self.__isRemaster then
    self:__InternalShowFlappyBirdUI(nil, self.maxScore)
    return
  end
  self.netWork:CS_FlappyBird_ProgressDetail(self.activityFwId, self.birdConfigId, function(objList)
    if objList.Count <= 0 then
      error("CS_FlappyBird_SelfRankDetail objList.Count:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    self:__InternalShowFlappyBirdUI(msg.progress, self.maxScore)
  end)
end

function FlappyBirdController:SetFlappyBirdActEndTime(endTime)
  self.endTime = endTime
end

function FlappyBirdController:__InternalShowFlappyBirdUI(progress, maxScore)
  UIManager:ShowWindowAsync(UIWindowTypeID.FlappyBird, function(win)
    if win ~= nil then
      self.playUI = win
      if progress ~= nil then
        win:ShowProgress(progress, self.birdConfigId, self.hasGettedJoinReward)
      end
      win:SetIsHistoryOpen(self.__isHistoryOpen, self.__HTGData, self.__isRemaster, self.endTime)
      win:RefreshHighestScore(maxScore)
      win:InjectAction(self.__startGame, self.__inputJump, self.__resetGame, self.__getScore, self.__onExit, self.__showRanking)
    end
  end)
end

function FlappyBirdController:OnExit()
  self.frameCtrl:StopRunning()
  if self.__exitAction ~= nil then
    self.__exitAction()
  end
  self:OnDelete()
end

function FlappyBirdController:__GetScore()
  return self.__score
end

function FlappyBirdController:InitRandom(seed)
  cs_RangFunc.Init(seed)
end

function FlappyBirdController:StartPlay()
  self.seed = math.random(0, 100000)
  self:InitRandom(self.seed)
  self:InitPlay(self.seed)
  self.frameCtrl:StartRunning(self.__OnLogicFrameUpdate, self.__OnRenderFrameUpdate)
end

function FlappyBirdController:__ResetGame()
  self.frameCtrl:StopRunning()
  self.playUI:RefreshHighestScore(self.maxScore)
  self.__score = 0
  self.__passTube = 0
  self.__getChocoTimes = 0
  self.farthestTubX = self.originDistance
  self.playUI:RefreshScore(self.__score)
  self.playUI:SetMiddleBackgroundSpeed(0, 0)
  self:__ResetBgViewSpeed()
  if self.birdEntity ~= nil then
    self.birdEntity:ResetBird(self.birdEntity)
    self.playUI:UpdateBirdRotation(self.birdEntity)
    self.playUI:SetEntityPos(self.birdEntity)
    self.playUI:OnShowInvinciableChange(false)
  end
  self:__RecycleAllSceneItems()
end

function FlappyBirdController:InitPlay(seed)
  self.__score = 0
  self.__passTube = 0
  self.__getChocoTimes = 0
  self:__RecycleAllSceneItems()
  if self.birdEntity == nil then
    self.birdEntity = FlappyBird_Bird.New(self.evnData)
    self.birdEntity:SetColliderSize(MapConfig.birdSize)
    self.birdEntity:InjectUpdateInvinciableView(BindCallback(self, self.__UpdateBirdInvinciableView), MapConfig.invinciableRemainFrame)
  end
  self.birdEntity:ResetBird()
  self.playUI:InitBird(self.birdEntity)
  self.playUI:RefreshScore(0)
  self:SetBackGroundSpeedX(self.originBackGroundMoveSpeed)
  self.__isAccing = false
  self.playUI:OnAccStateChange(false)
  self.farthestTubX = self.originDistance
  self.__inputBuff = false
end

function FlappyBirdController:__UpdateBirdInvinciableView(value, speed)
  self.playUI:OnShowInvinciableChange(value, speed)
end

function FlappyBirdController:__RecycleAllSceneItems()
  for i = #self.livingTubeEntities, 1, -1 do
    self:__RecycleTubeEntity(i)
  end
  for i = #self.livingChocolateEntities, 1, -1 do
    self:__RecycleChocoEntity(i)
  end
  for i = #self.livingAccEntities, 1, -1 do
    self:__RecycleAccEntity(i)
  end
end

function FlappyBirdController:GenTubes2End()
  local tempGroupData, randomWeightSum = self:__CheckAndGetGroupData()
  while self:IsNeedGenTubeGroup() do
    local groupRandom = cs_RangFunc.Range(1, randomWeightSum)
    local groupData = self:__CheckAndGetGroupDataWithWeight(tempGroupData, groupRandom)
    local posx = self.farthestTubX + groupData.foreGDistance + groupData.groupOffset.x
    local posy = groupData.groupOffset.y + cs_RangFunc.Range(groupData.verticalOffsetRange[1], groupData.verticalOffsetRange[2])
    local tubeGroup = self:GenTube(posx, posy, groupData)
    if groupData.itemChildren ~= nil then
      self:GenSceneItemEntity(posx, posy, groupData.itemChildren)
    end
    self.farthestTubX = posx + groupData.backGDistance
  end
end

function FlappyBirdController:__CheckAndGetGroupData()
  local checkedTubeGroupData = {}
  local randomWeightSum = 0
  for _, v in ipairs(MapConfig.sceneGroupData) do
    local dieScore = v.dieScore or self.__score
    if v.bornScore <= self.__score and dieScore >= self.__score then
      randomWeightSum = randomWeightSum + v.randomWeight
      table.insert(checkedTubeGroupData, v)
    end
  end
  return checkedTubeGroupData, randomWeightSum
end

function FlappyBirdController:__CheckAndGetGroupDataWithWeight(groupData, randomValue)
  local finalIndex = 1
  local groupWeightValue = 0
  for index, v in ipairs(groupData) do
    groupWeightValue = groupWeightValue + v.randomWeight
    if randomValue <= groupWeightValue then
      finalIndex = index
      break
    end
  end
  return groupData[finalIndex]
end

function FlappyBirdController:GenSceneItemEntity(groupPosX, groupPosY, itemChildren)
  for _, v in ipairs(itemChildren) do
    if not (cs_RangFunc.Range(0, 100) > v.itemWeight) then
      local posX = v.itemOffset.x + groupPosX
      local posY = v.itemOffset.y + groupPosY
      if v.itemData.itemType == MapConfig.eItemType.accItem then
        self:GenAccItem(posX, posY, v.itemData)
      elseif v.itemData.itemType == MapConfig.eItemType.scoreItem then
        self:GenChocolate(posX, posY, v.itemData)
      end
    end
  end
end

function FlappyBirdController:IsNeedGenTubeGroup()
  if self.farthestTubX < PlayGroundWidth then
    return true
  else
    return false
  end
end

function FlappyBirdController:InputJump()
  if self.frameCtrl:GetIsRunning() then
    self.__inputBuff = true
  end
end

function FlappyBirdController:GenTube(posx, posy, groupData)
  local type = groupData.groupType
  local newTubeGroupEntity
  if self.recycledTubeEntities[type] == nil or #self.recycledTubeEntities[type] <= 0 then
    newTubeGroupEntity = FlappyBird_TubeGroup.New(self.evnData)
    newTubeGroupEntity:SetGroupType(type)
    newTubeGroupEntity:InitWithGroupData(groupData)
  else
    newTubeGroupEntity = table.remove(self.recycledTubeEntities[type])
  end
  newTubeGroupEntity:SetIsPickScore(false)
  newTubeGroupEntity:SetPos(posx, posy)
  table.insert(self.livingTubeEntities, newTubeGroupEntity)
  local tubeEntityList = newTubeGroupEntity:GetTubeEntityList()
  self.playUI:InitTubeEntityFromItemPool(tubeEntityList)
  return newTubeGroupEntity
end

function FlappyBirdController:__RecycleTubeEntity(index)
  local tubeGroupEntity = self.livingTubeEntities[index]
  if tubeGroupEntity == nil then
    return
  end
  table.remove(self.livingTubeEntities, index)
  local tubeGroupType = tubeGroupEntity:GetTubeGroupType()
  if self.recycledTubeEntities[tubeGroupType] == nil then
    self.recycledTubeEntities[tubeGroupType] = {}
  end
  table.insert(self.recycledTubeEntities[tubeGroupType], tubeGroupEntity)
  local tubeChildrenList = tubeGroupEntity:GetTubeEntityList()
  self.playUI:RecycleATube(tubeChildrenList)
end

function FlappyBirdController:GenChocolate(posx, posy, itemData)
  local newChocolateEntity
  if #self.recycledChocolateEntities <= 0 then
    newChocolateEntity = FlappyBird_Chocolate.New(self.evnData)
  else
    newChocolateEntity = table.remove(self.recycledChocolateEntities)
  end
  newChocolateEntity:SetPos(posx, posy)
  newChocolateEntity:SetColliderSize(-itemData.scale.halfWidth, -itemData.scale.halfHeight, itemData.scale.halfWidth, itemData.scale.halfHeight)
  table.insert(self.livingChocolateEntities, newChocolateEntity)
  self.playUI:InitChocolate(newChocolateEntity)
  return newChocolateEntity
end

function FlappyBirdController:__RecycleChocoEntity(index)
  local chocolateEntity = self.livingChocolateEntities[index]
  if chocolateEntity == nil then
    return
  end
  table.remove(self.livingChocolateEntities, index)
  table.insert(self.recycledChocolateEntities, chocolateEntity)
  self.playUI:RecycleChocolate(chocolateEntity)
end

function FlappyBirdController:GenAccItem(posx, posy, itemData)
  local accEntity
  if #self.recycledAccEntities <= 0 then
    accEntity = FlappyBird_AccItem.New(self.evnData)
  else
    accEntity = table.remove(self.recycledAccEntities)
  end
  accEntity:SetPos(posx, posy)
  accEntity:SetColliderSize(-itemData.scale.halfWidth, -itemData.scale.halfHeight, itemData.scale.halfWidth, itemData.scale.halfHeight)
  table.insert(self.livingAccEntities, accEntity)
  self.playUI:InitAccItem(accEntity)
  return accEntity
end

function FlappyBirdController:__RecycleAccEntity(index)
  local accEntity = self.livingAccEntities[index]
  if accEntity == nil then
    return
  end
  table.remove(self.livingAccEntities, index)
  table.insert(self.recycledAccEntities, accEntity)
  self.playUI:RecycleAccItem(accEntity)
end

function FlappyBirdController:IsFlappyBirdDead()
  if self.birdEntity:IsInvinciable() then
    return false
  end
  if self.birdEntity.pos.y <= -PlayGroundHeight then
    return true
  end
  for _, tubeEntity in ipairs(self.livingTubeEntities) do
    if tubeEntity:IsOnCollission(self.birdEntity) then
      return true
    end
  end
end

function FlappyBirdController:DetectedGetChocolate()
  for index, chocolateEntity in ipairs(self.livingChocolateEntities) do
    if chocolateEntity:IsOnCollission(self.birdEntity) then
      self:__RecycleChocoEntity(index)
      self:__AddScore(chocolateEntity.bonusScore)
      self.__getChocoTimes = self.__getChocoTimes + 1
      self.playUI:RefreshScore(self.__score)
      self.playUI:OnDetectedChocolate()
    end
  end
end

function FlappyBirdController:__AddScore(value)
  self.__score = self.__score + value
end

function FlappyBirdController:DetectedAccItem()
  for index, accEntity in ipairs(self.livingAccEntities) do
    if accEntity:IsOnCollission(self.birdEntity) then
      self:__RecycleAccEntity(index)
      self.birdEntity:SetInvinciable(true, accEntity.invinciableDuration)
      self:__UpdateBirdInvinciableView(true, 13)
      self.birdEntity:ReSetVelocity()
      self:SetAccDuration(true, accEntity.accLastFrame)
      self:SetBackGroundSpeedX(self.originBackGroundMoveSpeed * accEntity.speedRatio)
      self:__MultiBgViewSpeed(accEntity.speedRatio)
    end
  end
end

function FlappyBirdController:__MultiBgViewSpeed(ratio)
  self.midBgViewSpeed = MapConfig.midBgViewSpeed * ratio
  self.longBgViewSpeed = MapConfig.longBgViewSpeed * ratio
end

function FlappyBirdController:SetAccDuration(value, duration)
  self.__isAccing = value
  self.__accDuration = duration
  self.birdEntity:SetGravityInfluenceEnable(not value)
  self.playUI:OnAccStateChange(value)
end

function FlappyBirdController:UpdateAcc()
  if not self.__isAccing then
    return
  end
  if self.__accDuration <= 0 then
    self:SetAccDuration(false, 0)
    self:SetBackGroundSpeedX(self.originBackGroundMoveSpeed)
    self:__ResetBgViewSpeed()
  else
    self.__accDuration = self.__accDuration - 1
  end
end

function FlappyBirdController:SetBackGroundSpeedX(value)
  self.evnData.backGroudMoveSpeed.x = value
end

function FlappyBirdController:GetBackGroundSpeed()
  return self.evnData.backGroudMoveSpeed
end

function FlappyBirdController:__ResetBgViewSpeed()
  self.midBgViewSpeed = MapConfig.midBgViewSpeed
  self.longBgViewSpeed = MapConfig.longBgViewSpeed
end

function FlappyBirdController:OnLogicFrameUpdate(logicFrameNum)
  self:__ForceSetAllEntityPos()
  self:DetectedGetChocolate()
  self:DetectedAccItem()
  if self:IsFlappyBirdDead() then
    self.frameCtrl:StopRunning()
    self.playUI:PlayBirdDeadTween(self.birdEntity, function()
      self:__ReqBirdSettle(logicFrameNum)
    end)
    return true
  end
  self:__HandleSceneItemRecycle()
  self:UpdateAcc()
  if self.__isAccing then
    self.__inputBuff = false
  end
  if self.__inputBuff then
    if not self.birdEntity:IsCompletedFirstJump() then
      self.playUI:ShowFinger(false)
    end
    self.birdEntity:Jump(self.evnData.jumpForce)
    self.__inputBuff = false
  end
  self.birdEntity:OnUpdateLogic()
  self:__InternalLogicUpdateEntityList(self.livingChocolateEntities)
  self:__InternalLogicUpdateEntityList(self.livingAccEntities)
  self:__HandleTubeGen()
  self:__InternalLogicUpdateTubeGroupList()
end

function FlappyBirdController:__HandleTubeGen()
  if not self.birdEntity:IsCompletedFirstJump() then
    return
  end
  local tempMoveSpeed = self:GetBackGroundSpeed()
  self.farthestTubX = self.farthestTubX + tempMoveSpeed.x
  if not self:IsNeedGenTubeGroup() then
    return
  end
  self:GenTubes2End()
end

function FlappyBirdController:__ForceSetAllEntityPos()
  self.playUI:SetEntityPos(self.birdEntity)
  for _, tubeGroupEntity in ipairs(self.livingTubeEntities) do
    local tubeEntityList = tubeGroupEntity:GetTubeEntityList()
    for _k, tubeEntity in ipairs(tubeEntityList) do
      self.playUI:SetEntityPos(tubeEntity)
    end
  end
  for _, entity in ipairs(self.livingChocolateEntities) do
    self.playUI:SetEntityPos(entity)
  end
  for _, entity in ipairs(self.livingAccEntities) do
    self.playUI:SetEntityPos(entity)
  end
end

function FlappyBirdController:__InternalLogicUpdateEntityList(entityList)
  for _, entity in ipairs(entityList) do
    entity:OnUpdateLogic()
  end
end

function FlappyBirdController:__InternalLogicUpdateTubeGroupList()
  for _, entity in ipairs(self.livingTubeEntities) do
    entity:OnUpdateLogic()
    if not (self.birdEntity.pos.x < entity.pos.x) and not entity:GetIsPickScore() then
      entity:SetIsPickScore(true)
      self.__passTube = self.__passTube + 1
      self:__AddScore(entity.bonusScore)
      self.playUI:OnGetScore(self.__score)
    end
  end
end

function FlappyBirdController:__HandleSceneItemRecycle()
  self:__CheckSceneItemAndRecycle(self.livingTubeEntities, self.__RecycleTubeEntity)
  self:__CheckSceneItemAndRecycle(self.livingChocolateEntities, self.__RecycleChocoEntity)
  self:__CheckSceneItemAndRecycle(self.livingAccEntities, self.__RecycleAccEntity)
end

function FlappyBirdController:__CheckSceneItemAndRecycle(livingEntities, recycleFunc)
  if recycleFunc == nil then
    return
  end
  for i = #livingEntities, 1, -1 do
    local tempEntity = livingEntities[i]
    if self:__CheckItemPosBeyondScene(tempEntity) then
      recycleFunc(self, i)
    end
  end
end

function FlappyBirdController:__CheckItemPosBeyondScene(tempEntity)
  return tempEntity.pos.x < -PlayGroundWidth
end

function FlappyBirdController:OnRenderFrameUpdate(timeRate)
  self.playUI:SetMiddleBackgroundSpeed(self.midBgViewSpeed, self.longBgViewSpeed)
  self.playUI:UpdateEntityRender(timeRate, self.birdEntity)
  self.playUI:UpdateBirdRotation(self.birdEntity)
  for _, tubeGroupEntity in ipairs(self.livingTubeEntities) do
    local tubeEntityList = tubeGroupEntity:GetTubeEntityList()
    for _k, tubeEntity in ipairs(tubeEntityList) do
      self.playUI:UpdateEntityRender(timeRate, tubeEntity)
    end
  end
  self:__InternalRenderUpdateEntityList(timeRate, self.livingChocolateEntities)
  self:__InternalRenderUpdateEntityList(timeRate, self.livingAccEntities)
end

function FlappyBirdController:__InternalRenderUpdateEntityList(timeRate, entityList)
  for _, entity in ipairs(entityList) do
    self.playUI:UpdateEntityRender(timeRate, entity)
  end
end

function FlappyBirdController:__ReqBirdSettle(logicFrameNum)
  local combineArg = 0
  if self.__passTube ~= nil and self.__getChocoTimes ~= nil then
    combineArg = self.__passTube << 32 | self.__getChocoTimes
  end
  if self.__isHistoryOpen then
    self.__HTGData:HTGCommonSettle(self.__score, function(tinyGameCenterElem)
      self.maxScore = tinyGameCenterElem.highest
      local rankData = self.__HTGData:GetHTGRankData()
      local allFriendData = rankData.allFriendData
      local mineGrade = rankData.mineGrade
      local finalData = self:__GetResultFriendRankingData(allFriendData, mineGrade)
      self.playUI:ShowFlappyBirdResult({
        score = tinyGameCenterElem.score
      }, finalData, mineGrade, self.hasGettedJoinReward)
    end)
    return
  end
  self.netWork:CS_FlappyBird_Settle(self.activityFwId, self.birdConfigId, self.__score, logicFrameNum, combineArg, function(objList)
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
    self.playUI:ShowFlappyBirdResult(msg, finalData, mineGrade, self.hasGettedJoinReward)
  end)
end

function FlappyBirdController:__ShowFirstReward(msg)
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

function FlappyBirdController:__GetFriendBirdData()
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
    local frindBirdData = v:GetFriendBirdData()
    if frindBirdData ~= nil and frindBirdData.birdId == self.birdConfigId then
      eachFriendGrade.score = frindBirdData.birdScore
    end
    table.insert(allBirdGrades, eachFriendGrade)
  end
  return allBirdGrades
end

function FlappyBirdController:__GetResultFriendRankingData(allFriendData, mineGrade)
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

function FlappyBirdController:__ReqShowRanking()
  local function LocalFunc_Enter()
    if self.__isHistoryOpen then
      local rankData = self.__HTGData:GetHTGRankData()
      
      local allFriendData = rankData.allFriendData
      local mineGrade = rankData.mineGrade
      UIManager:ShowWindowAsync(UIWindowTypeID.FlappyBirdRanking, function(window)
        window:RefreshRankingData(allFriendData, mineGrade, self.__isHistoryOpen, self.__isRemaster)
        window:SetBestScore(self.__HTGData:GetHTGHistoryHighScore())
      end)
      return
    end
    self.netWork:CS_FlappyBird_SelfRankDetail(self.activityFwId, self.birdConfigId, function(objList)
      if objList.Count <= 0 then
        error("CS_FlappyBird_SelfRankDetail objList.Count error:" .. tostring(objList.Count))
        return
      end
      local msg = objList[0]
      local mineGrade = self:__CreateMineGrade(msg)
      local allFriendData = self:__GetFriendBirdData() or {}
      table.insert(allFriendData, mineGrade)
      self:__SortFriendData(allFriendData)
      UIManager:ShowWindowAsync(UIWindowTypeID.FlappyBirdRanking, function(window)
        window:RefreshRankingData(allFriendData, mineGrade, self.__isHistoryOpen, self.__isRemaster)
        if self.__isRemaster then
          local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
          local hisBestScore = activityFrameCtrl:GetTinyGameHistoryHighScore(tinyGameEnum.eType.flappyBird)
          hisBestScore = math.max(hisBestScore, msg.highestScore)
          window:SetBestScore(hisBestScore)
        end
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

function FlappyBirdController:__SortFriendData(allFriendData)
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

function FlappyBirdController:__CreateMineGrade(msg)
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

function FlappyBirdController:GetIsHistoryOpen()
end

function FlappyBirdController:OnDelete()
  self.playUI = nil
  self.activityFwId = nil
  self.birdConfigId = nil
  self.frameCtrl:OnDelete()
end

return FlappyBirdController
