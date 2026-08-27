local BrotatoData = class("BrotatoData")
local SectorEnum = require("Game.Sector.SectorEnum")
local TinyGameDataBase = require("Game.TinyGames.Common.TinyGameDataBase")
local TinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function BrotatoData.CreateBrotatoData(brotatoId, parentActivityFrameId)
  local brotatoData = BrotatoData.New()
  brotatoData.isDirty = false
  brotatoData.brotatoId = brotatoId
  brotatoData.mainCfg = ConfigData.tiny_game_brotato[brotatoId]
  brotatoData.difficultyCfg = ConfigData.tiny_game_brotato_difficulty[brotatoId]
  brotatoData.gameBrotatoTokenId = brotatoData.mainCfg.task_item
  if parentActivityFrameId ~= nil then
    brotatoData:InitTinyGame(parentActivityFrameId)
  end
  return brotatoData
end

function BrotatoData:InitTinyGame(parentActivityFrameId)
  if self.isInitTinyGame then
    return
  end
  self.activityFrameId = parentActivityFrameId
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local gameUid = activityFrameCtrl:GetTinyGameDataUidByActFrameId(parentActivityFrameId, TinyGameEnum.eType.brotato)
  if gameUid == 0 then
    return
  end
  self.isInitTinyGame = true
  self.tinyGameData = TinyGameDataBase.New(gameUid, self.brotatoId, TinyGameEnum.eType.brotato)
  local brotatoAchivDatas = {}
  local brotatoAchieveCfgs = ConfigData.tiny_game_brotato_reward[self.brotatoId]
  if brotatoAchieveCfgs ~= nil then
    for id, cfg in pairs(brotatoAchieveCfgs) do
      local stateType
      if cfg.level <= self.tinyGameData:GetTinyGameRewardGotLv() then
        stateType = SectorEnum.eSectorAchivState.Picked
      elseif cfg.point <= self.tinyGameData:GetTinyGameRewardLevelPoint() then
        stateType = SectorEnum.eSectorAchivState.Completed
      else
        stateType = SectorEnum.eSectorAchivState.Normal
      end
      table.insert(brotatoAchivDatas, {
        stcData = {
          activeId = self.gameBrotatoTokenId,
          level = cfg.level,
          activeNum = cfg.point,
          rewardIds = cfg.rewardIds,
          rewardNums = cfg.rewardNums,
          type = 3
        },
        stateType = stateType
      })
    end
  end
  self.brotatoAchivDatas = brotatoAchivDatas
end

function BrotatoData:GetBrotatoAchieveData()
  for _, achivData in ipairs(self.brotatoAchivDatas) do
    local stateType
    if achivData.stcData.level <= self.tinyGameData:GetTinyGameRewardGotLv() then
      stateType = SectorEnum.eSectorAchivState.Picked
    elseif achivData.stcData.activeNum <= self.tinyGameData:GetTinyGameRewardLevelPoint() then
      stateType = SectorEnum.eSectorAchivState.Completed
    else
      stateType = SectorEnum.eSectorAchivState.Normal
    end
    achivData.stateType = stateType
  end
  return self.brotatoAchivDatas
end

function BrotatoData:GetBrotatoMainCfg()
  return self.mainCfg
end

function BrotatoData:GetBrotattoDifficultyCfg()
  return self.difficultyCfg
end

function BrotatoData:GetBrotatoTaskType()
  return self.mainCfg.task_type
end

function BrotatoData:GetBrotatoType()
  return self.mainCfg.type_difficulty
end

function BrotatoData:GetGameBrotatoItemNum()
  local point = self.tinyGameData:GetTinyGameRewardLevelPoint()
  return point
end

function BrotatoData:GetGameBrotatoItemId()
  return self.gameBrotatoTokenId
end

function BrotatoData:GetBrotatoRedDot()
  return self.brotatoRedDot
end

function BrotatoData:GetBrotatoActivityFrameId()
  return self.activityFrameId
end

function BrotatoData:GetTinyGameRankInfo()
  return self.tinyGameData:GetTinyGameRankInfo()
end

function BrotatoData:GetBrotatoGameHistoryScore()
  return self.tinyGameData:GetTinyGameHistoryScore()
end

function BrotatoData:GetParentActivityFrameData()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if activityFrameCtrl == nil then
    return nil
  end
  return activityFrameCtrl:GetActivityFrameData(self:GetBrotatoActivityFrameId())
end

function BrotatoData:IsTinyGameBrotato()
  local parentActFrameData = self:GetParentActivityFrameData()
  if parentActFrameData ~= nil then
    local actCat = parentActFrameData:GetActivityFrameCat()
    return actCat == ActivityFrameEnum.eActivityType.Brotato
  end
  return false
end

function BrotatoData:SetBrotatoRewardPickedLevel(brotatoRewardPickedLevel)
  if brotatoRewardPickedLevel == nil then
    return
  end
  local level = self.tinyGameData:GetTinyGameRewardGotLv()
  if level ~= brotatoRewardPickedLevel then
    self.isDirty = true
  end
  self.tinyGameData:SetTinyGameRewardGotLv(brotatoRewardPickedLevel or 0)
end

function BrotatoData:SetGameBrotatoItemNum(gameBrotatoItemNum)
  if gameBrotatoItemNum == nil then
    return
  end
  local point = self.tinyGameData:GetTinyGameRewardLevelPoint()
  if point ~= gameBrotatoItemNum then
    self.isDirty = true
  end
  self.tinyGameData:SetTinyGameRewardLevelPoint(gameBrotatoItemNum or 0)
end

function BrotatoData:SetBrotatoRedDot(redDot)
  self.brotatoRedDot = redDot
  self:RefreshRedBrotato()
end

function BrotatoData:SetBrotatoDirty()
  self.isDirty = true
end

function BrotatoData:BroadCastBrotatoChange()
  if not self.isDirty then
    return
  end
  self.isDirty = false
  MsgCenter:Broadcast(eMsgEventId.ActivityTinyGameBrotatoChange, self)
  self:RefreshRedBrotato()
end

function BrotatoData:RefreshRedBrotato()
  if not self:IsTinyGameBrotato() then
    return
  end
  local reddot = self:GetBrotatoRedDot()
  if reddot == nil then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local flag = saveUserData:GetIsSReddotClose(reddot.nodePath)
  if flag == nil or flag == false then
    local redCount = 1
    if reddot:GetRedDotCount() ~= redCount then
      reddot:SetRedDotCount(redCount)
    end
    return
  end
  local childReddot = reddot:AddChild(1)
  local flagReward = false
  for k, v in pairs(self.brotatoAchivDatas) do
    if v.stateType == SectorEnum.eSectorAchivState.Completed then
      flagReward = true
    end
  end
  local flagTask = false
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  if taskCtrl == nil then
    return
  end
  local taskDataDic, _ = taskCtrl:GetDatas4Task(self.mainCfg.task_type)
  for _, data in pairs(taskDataDic) do
    if data:CheckComplete() then
      flagTask = true
      break
    end
  end
  local flag = flagReward or flagTask
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

return BrotatoData
