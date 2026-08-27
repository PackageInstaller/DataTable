local base = require("Game.Common.Data.BaseActivityInteractData")
local BaseActivityStoryData = class("BaseActivityStoryData", base)
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function BaseActivityStoryData:InitStoryData(actId)
  base.InitInteractData(self, actId)
  self.storyLevel = 0
  self.gotRewardLevel = 0
  self.storyLevelHeroDic = {}
  for heroId, _ in pairs(ConfigData.activity_interact.heroActDic[self.actId]) do
    self.storyLevelHeroDic[heroId] = 0
  end
  self._FinishTalkCallback = BindCallback(self, self.FinishTalkCallback)
end

function BaseActivityStoryData:UpdateStoryLevel(storyLevel, gotRewardLevel, storyLevelHeroDic)
  self.storyLevel = storyLevel or 0
  self.gotRewardLevel = gotRewardLevel or 0
  for heroId, _ in pairs(self.storyLevelHeroDic) do
    self.storyLevelHeroDic[heroId] = storyLevelHeroDic[heroId] or 0
  end
end

function BaseActivityStoryData:SetInteractFininsh(interactId)
  local cfg = self._storyCfg[interactId]
  if cfg.stage_id ~= ActivitySpringStoryEnum.stageEnum.ranReward then
    self.interactDic[interactId] = true
  end
end

function BaseActivityStoryData:FinishTalkCallback(args, interactId, callback)
  local cfg = self._storyCfg[interactId]
  if cfg.stage_id ~= ActivitySpringStoryEnum.stageEnum.main then
    self.storyLevel = self.storyLevel + 1
    self.storyLevelHeroDic[cfg.interact_character] = self.storyLevelHeroDic[cfg.interact_character] or 0
    self.storyLevelHeroDic[cfg.interact_character] = self.storyLevelHeroDic[cfg.interact_character] + 1
  end
  base.FinishTalkCallback(self, args, interactId, callback)
end

function BaseActivityStoryData:FinishTeamStory(callback)
end

function BaseActivityStoryData:FinishTeamStoryCallback(args, level, callback)
  if not args then
    return
  end
  local msg = args[0]
  local rewardIds = {}
  local rewardNums = {}
  for id, num in pairs(msg.rewards) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, num)
  end
  self.gotRewardLevel = level
  local realLevel = level
  if realLevel > ConfigData.activity_interact_story_level.maxLevelDic[self.actId] then
    realLevel = ConfigData.activity_interact_story_level.maxLevelDic[self.actId]
  end
  local id = ConfigData.activity_interact_story_level.levelMapping[self.actId][realLevel]
  local cfg = ConfigData.activity_interact_story_level[self.actId][id]
  
  local function avg2Callback()
    callback(rewardIds, rewardNums)
  end
  
  local function avg1Callback()
    if #cfg.avg_2 > 0 then
      local flag = math.random(1, #cfg.avg_2)
      local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
      avgCtrl:StartAvg(nil, cfg.avg_2[flag], avg2Callback)
    else
      avg2Callback()
    end
  end
  
  if cfg.avg_1 > 0 then
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:StartAvg(nil, cfg.avg_1, avg1Callback)
  else
    avg1Callback()
  end
end

function BaseActivityStoryData:IsLongTail(interactId)
  return false
end

function BaseActivityStoryData:IsSpringMaininteracterComplete()
  if self._tempMaininteracterComplete then
    return true
  end
  local cfgList = self:GetStoryMain()
  for k, cfg in pairs(cfgList) do
    if not self.interactDic[cfg.id] then
      return false
    end
  end
  self._tempMaininteracterComplete = true
  return true
end

function BaseActivityStoryData:GetNextCanGetRewardLevel()
  return 0, 1
end

function BaseActivityStoryData:GetNeedExp(interactId)
  return 0
end

function BaseActivityStoryData:GetNowHaveExp(interactId)
  return 0
end

function BaseActivityStoryData:GetStoryMain()
  if self._tempMainStepDic ~= nil then
    return self._tempMainStepDic
  end
  self._tempMainStepDic = {}
  for k, v in pairs(self._storyCfg) do
    if v.stage_id == ActivitySpringStoryEnum.stageEnum.main then
      self._tempMainStepDic[v.id] = v
    end
  end
  return self._tempMainStepDic
end

function BaseActivityStoryData:GetStoryActId()
  return base.GetInteractActId(self)
end

function BaseActivityStoryData:GetStoryInteractCfg()
  return base.GetInteractCfg(self)
end

function BaseActivityStoryData:GetSpecialUIPrefabName()
  return ConfigData.activity_interact_main[self:GetStoryActId()].addup_prefab
end

function BaseActivityStoryData:GetInteractMainGameName()
  return ConfigData.activity_interact_main[self:GetStoryActId()].name_main_game
end

function BaseActivityStoryData:GetStoryLevelRewards(level)
  local realLevel = level
  local isLongTail = false
  if realLevel >= ConfigData.activity_interact_story_level.maxLevelDic[self.actId] then
    realLevel = ConfigData.activity_interact_story_level.maxLevelDic[self.actId]
    isLongTail = true
  end
  local id = ConfigData.activity_interact_story_level.levelMapping[self.actId][realLevel]
  local cfg = ConfigData.activity_interact_story_level[self.actId][id]
  return isLongTail, cfg.reward_ids, cfg.reward_nums
end

return BaseActivityStoryData
