local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local BattlePassData = class("BattlePassData", ActivityBase)
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local factory = require("LuaConfigs.factory")

function BattlePassData:ctor(cfg)
  self.passCfg = cfg
  self.id = cfg.id
end

function BattlePassData.CreateBattlePass(battlepass, cfg)
  local passData = BattlePassData.New(cfg)
  passData:SetActFrameDataByType(ActivityFrameEnum.eActivityType.BattlePass, passData.id)
  local activityFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  passData.__activityData = activityFrameCtr:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.BattlePass, passData.id)
  passData:__UpdateBattlePass(battlepass)
  passData:UpdateActFrameDataSingleMsg(battlepass)
  if passData:IsResidentBP() then
    passData:GenResidentBPSkinList()
  end
  return passData
end

function BattlePassData:__UpdateBattlePass(battlepass)
  self.level = self.passCfg.condition == BattlePassEnum.ConditionType.AchievementLevel and PlayerDataCenter.playerLevel.level or battlepass.lv + battlepass.extraLevel
  self.exp = battlepass.exp
  self.unlockSenior = battlepass.unlockSenior
  self.taken = battlepass.taken
  self.extraPickLevel = battlepass.extraPickLevel
  self.weeklyExp = battlepass.weeklyExp
  self.unlockUltimate = battlepass.unlockUltimate
  self.weeklyNextExpiredTm = battlepass.weeklyNextExpiredTm
  self.maxlevel = ConfigData.battlepass.max_level[self.id]
  self:__UpdateHaveRewardTake()
  if self.passCfg.condition == BattlePassEnum.ConditionType.AchievementLevel and self.level >= self.maxlevel and self.unlockSenior and not self.__haveRewardTake then
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityCtrl:HideActivityByExtraLogic(ActivityFrameEnum.eActivityType.BattlePass, self.id)
  end
  self:UpdateBattlePassTask(battlepass.dailyQuests)
  self:__RefreshPassRedReward()
end

function BattlePassData:UpdateBattlePass(battlepass)
  self:__UpdateBattlePass(battlepass)
end

function BattlePassData:OnTaskChange(taskId)
  if self.dailyQuests == nil then
    return
  end
  if self.taskDic[taskId] == nil then
    return
  end
  self:UpdateBattlePassTask(self.dailyQuests)
end

function BattlePassData:UpdateBattlePassTask(dailyQuests)
  if dailyQuests == nil then
    return
  end
  self.dailyQuests = dailyQuests
  self.taskDic = {}
  self.hasCompletedTask = false
  if self.tasks == nil then
    self.tasks = {}
  else
    table.removeall(self.tasks)
  end
  for _, taskId in ipairs(self.dailyQuests) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData ~= nil then
      table.insert(self.tasks, taskData)
      self.taskDic[taskId] = taskData
      if taskData:CheckComplete() then
        self.hasCompletedTask = true
      end
    end
  end
  if self.__updateCallback ~= nil then
    self.__updateCallback()
  end
  self:__RefreshPassRedTask()
  MsgCenter:Broadcast(eMsgEventId.BattlePassTaskUpdate, self)
end

function BattlePassData:SetBattlePassUpdateCallback(callback)
  self.__updateCallback = callback
end

function BattlePassData:GetBattlePassEndTime()
  if self.__activityData == nil then
    return -1
  end
  return self.__activityData.endTime
end

function BattlePassData:GetBattlePassRewardEndTime()
  if self.__activityData == nil then
    return -1
  end
  return self.__activityData.rewardEndTime
end

function BattlePassData:IsBattlePassValid()
  if self.__activityData == nil then
    return false
  end
  return self.__activityData:IsActivityOpen()
end

function BattlePassData:IsBattlePassRunning()
  if self.__activityData == nil then
    return false
  end
  return self.__activityData:IsInRuningState()
end

function BattlePassData:GetBattlePassActivityId()
  if self.__activityData == nil then
    return 0
  end
  return self.__activityData.id
end

function BattlePassData:GetBattlepassReddot()
  if self.__activityData == nil then
    return nil
  end
  return self.__activityData:GetActivityReddotNode()
end

function BattlePassData:IsBattleType()
  return self.passCfg.condition == BattlePassEnum.ConditionType.BattlePassLevel
end

function BattlePassData:IsBattlepassStanding()
  return self.passCfg.purpose_type == 0
end

function BattlePassData:IsPassFullLevel()
  return self.level >= self.maxlevel
end

function BattlePassData:HasBpOverLimitReward()
  return self.passCfg.limit_reward_id > 0
end

function BattlePassData:GetWeeklyExpLimit()
  return self.passCfg.weekly_exp
end

function BattlePassData:GetPassCfg()
  return self.passCfg
end

function BattlePassData:GetBattlePassMaxLevel()
  return self.maxlevel
end

function BattlePassData:GetPassLevel()
  return self.level
end

function BattlePassData:GetBattlePassUnlockSenior()
  return self.unlockSenior
end

function BattlePassData:IsResidentBP()
  return self.passCfg.resident
end

function BattlePassData:GetResidentBPSkinList()
  return self.bpSkinList, self.bpSkinIndex
end

function BattlePassData:SetResidentBPIndex(index)
  self.bpSkinIndex = index
end

function BattlePassData:IsResidentBPAllSkinCollected()
  return self.isbpSkinAllCollected
end

function BattlePassData:GetCurSkinId()
  local skinId
  local isResident = self:IsResidentBP()
  if isResident then
    local list, index = self:GetResidentBPSkinList()
    skinId = list[index].skinId
  else
    local passCfg = self.passCfg
    skinId = passCfg.banner_skin
  end
  return skinId
end

function BattlePassData:GetBPSkinShopId()
  return self.passCfg.skin_coin_shop
end

function BattlePassData:GetBPSkinCoinId()
  return self.passCfg.skin_coin_id
end

function BattlePassData:GetBpBannerSkinId()
  return self.passCfg.banner_skin
end

function BattlePassData:GetBpSkinCoinGift()
  return self.passCfg.skin_coin_pay
end

function BattlePassData:GetBpTaskData()
  if self.tasks == nil then
    self.tasks = {}
  end
  return self.tasks
end

function BattlePassData:GetHasBpTaskComplete()
  return self.hasCompletedTask
end

function BattlePassData:GetBattlePassTotalExp()
  local totalExp = 0
  local passCfg = ConfigData.battlepass[self.id]
  for i = 1, self.level - 1 do
    local passLevelCfg = passCfg[i]
    if passLevelCfg ~= nil then
      totalExp = totalExp + passLevelCfg.exp
    end
  end
  return self.exp + totalExp
end

function BattlePassData:GetPassCurLevelExp()
  local level = math.min(self.level, self.maxlevel)
  local passLevelCfg = ConfigData.battlepass[self.id][level]
  if passLevelCfg == nil then
    error("battle pass cfg is null,id:" .. tostring(self.id) .. " level:" .. tostring(self.level))
    return 0
  end
  return passLevelCfg.exp
end

function BattlePassData:TryGetExpUpgradeLevel(exp, enableOverlimit)
  enableOverlimit = enableOverlimit or false
  local tmp_exp = exp
  local curExp = self.exp
  local levelup = 0
  local tmpLevel = self.level
  while 0 < tmp_exp do
    local levelexp = 0
    if tmpLevel >= self.maxlevel then
      if not enableOverlimit then
        break
      end
      levelexp = ConfigData.battlepass[self.id][self.maxlevel].exp
    else
      levelexp = ConfigData.battlepass[self.id][tmpLevel].exp
    end
    local needExp = levelexp - curExp
    if tmp_exp < needExp then
      curExp = curExp + tmp_exp
      break
    end
    curExp = 0
    levelup = levelup + 1
    tmpLevel = tmpLevel + 1
    tmp_exp = tmp_exp - needExp
  end
  return levelup, curExp
end

function BattlePassData:GetPassLevelReward(startlevel, endlevel, containBase, containSenior, filterSenior)
  local rewardDic = {}
  for level = startlevel, endlevel do
    if not (level > self.maxlevel) or not containBase then
      local passLevelCfg = ConfigData.battlepass[self.id][level]
      if passLevelCfg ~= nil then
        if containBase then
          for index, itemId in pairs(passLevelCfg.base_item_ids) do
            local count = passLevelCfg.base_item_nums[index]
            rewardDic[itemId] = (rewardDic[itemId] or 0) + count
          end
        end
        if containSenior then
          for index, itemId in pairs(passLevelCfg.senior_item_ids) do
            local itemCfg = ConfigData.item[itemId]
            local filter = itemCfg.quality == eItemQualityType.Orange
            if not filterSenior or filterSenior and filter then
              local count = passLevelCfg.senior_item_nums[index]
              rewardDic[itemId] = (rewardDic[itemId] or 0) + count
            end
          end
        end
      end
    end
  end
  local item_ids = {}
  local item_nums = {}
  for itemId, _ in pairs(rewardDic) do
    table.insert(item_ids, itemId)
  end
  table.sort(item_ids)
  for _, itemId in pairs(item_ids) do
    local itemCount = rewardDic[itemId]
    table.insert(item_nums, itemCount)
  end
  return item_ids, item_nums
end

function BattlePassData:GetNoTakenLimitRewardCount()
  if self.passCfg.condition == BattlePassEnum.ConditionType.AchievementLevel then
    return 0
  end
  local count = 0
  if self.level > self.maxlevel then
    count = self.level - self.maxlevel - self.extraPickLevel
  end
  return count
end

function BattlePassData:GetPassDefaultShowLevel()
  if self:IsPassFullLevel() then
    return self.maxlevel
  end
  for level = 1, self.level - 1 do
    local reward = self.taken[level]
    if reward == nil or not reward.base then
      return level
    end
    if self.unlockSenior and not reward.senior then
      return level
    end
  end
  return self.level
end

function BattlePassData:__UpdateHaveRewardTake()
  local havaReward = false
  if self:IsBattlePassValid() then
    havaReward = self:GetNoTakenLimitRewardCount() > 0
    local passLevelsCfg = ConfigData.battlepass[self.id]
    local maxLevel = math.min(self.level, self.maxlevel)
    if not havaReward then
      for level = 1, maxLevel do
        local passLevelCfg = passLevelsCfg[level]
        if passLevelCfg ~= nil then
          local reward = self.taken[level]
          if (reward == nil or not reward.base) and 0 < #passLevelCfg.base_item_ids then
            havaReward = true
            break
          end
          if self.unlockSenior and (reward == nil or not reward.senior) and 0 < #passLevelCfg.senior_item_ids then
            havaReward = true
            break
          end
        end
      end
    end
  end
  self.__haveRewardTake = havaReward
end

function BattlePassData:__RefreshPassRedReward()
  local reddot = self:GetBattlepassReddot()
  if reddot ~= nil then
    local childReddot = reddot:AddChild(BattlePassEnum.RedDotType.Reward)
    childReddot:SetRedDotCount(self.__haveRewardTake and 1 or 0)
  end
end

function BattlePassData:__RefreshPassRedTask()
  local reddot = self:GetBattlepassReddot()
  if reddot ~= nil then
    local childReddot = reddot:AddChild(BattlePassEnum.RedDotType.Task)
    local flag = self.hasCompletedTask and self:IsBattlePassRunning()
    childReddot:SetRedDotCount(flag and 1 or 0)
  end
end

function BattlePassData:PassHaveRewardTake()
  return self.__haveRewardTake
end

function BattlePassData:GetIsThisLeveHaveNewReward(level)
  local passLevelCfg = ConfigData.battlepass[self.id]
  if passLevelCfg[level] ~= nil then
    local reward = self.taken[level]
    if reward == nil then
      return true
    end
    if not reward.base or level <= self.maxlevel and self.unlockSenior and not reward.senior then
      return true
    end
  end
  return false
end

function BattlePassData:GenResidentBPSkinList()
  local list = {}
  for skinId, cfg in pairs(ConfigData.battlepass_skin[ConfigData.buildinConfig.RadioChoiceBpShowId]) do
    if not PlayerDataCenter.skinData:IsHaveSkin(skinId) then
      table.insert(list, {
        skinId = skinId,
        order = cfg.order
      })
    end
  end
  if #list == 0 then
    self.isbpSkinAllCollected = true
    for skinId, cfg in pairs(ConfigData.battlepass_skin[ConfigData.buildinConfig.RadioChoiceBpShowId]) do
      table.insert(list, {
        skinId = skinId,
        order = cfg.order
      })
    end
  else
    self.isbpSkinAllCollected = false
  end
  table.sort(list, function(a, b)
    return a.order < b.order
  end)
  self.bpSkinList = list
  self.bpSkinIndex = 1
end

return BattlePassData
