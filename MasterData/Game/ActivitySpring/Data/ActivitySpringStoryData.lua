local base = require("Game.Common.Data.BaseActivityStoryData")
local ActivitySpringStoryData = class("ActivitySpringStoryData", base)
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")

function ActivitySpringStoryData:InitStoryData(actId)
  base.InitStoryData(self, actId)
end

function ActivitySpringStoryData:FinishTalk(interactId, callback)
  NetworkManager:GetNetwork(NetworkTypeID.Interact):CS_ACTIVITY_Interact(self.actId, interactId, function(args)
    self:FinishTalkCallback(args, interactId, callback)
  end)
end

function ActivitySpringStoryData:FinishTalkCallback(args, interactId, callback)
  base.FinishTalkCallback(self, args, interactId, callback)
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if springCtrl then
    local springData = springCtrl:GetActSpringDataByFrameId(self.actId)
    springData:AddRefreshRedTalk()
    springData:RefreshRedTeamPerformance()
  end
end

function ActivitySpringStoryData:FinishTeamStory(level, callback)
  NetworkManager:GetNetwork(NetworkTypeID.Interact):CS_ACTIVITY_Interact_Story_Award(self.actId, function(args)
    self:FinishTeamStoryCallback(args, level, callback)
  end)
end

function ActivitySpringStoryData:FinishTeamStoryCallback(args, level, callback)
  base.FinishTeamStoryCallback(self, args, level, callback)
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if springCtrl then
    springCtrl:GetActSpringDataByFrameId(self.actId):RefreshRedTeamPerformance()
  end
end

function ActivitySpringStoryData:GetInteractTransDic(interactId)
  local cfg = self._storyCfg[interactId]
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(cfg.reward_ids, cfg.reward_nums)
  return crTransDic
end

function ActivitySpringStoryData:IsInteractTrans()
  return true
end

function ActivitySpringStoryData:CostIsEnough(num, interactId)
  local cfg = self._storyCfg[interactId]
  return num >= cfg.needNum
end

function ActivitySpringStoryData:IsLongTail(interactId)
  local cfg = self._storyCfg[interactId]
  return cfg.stage_id >= ConfigData.activity_interact_main[self.actId].suggest_step
end

function ActivitySpringStoryData:IsSpringMaininteracterComplete()
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

function ActivitySpringStoryData:CheckHaveTalk()
  for heroId, heroHave in pairs(ConfigData.activity_interact.heroActDic[self.actId]) do
    local interactCfg, cantTalk = self:GetNowCfgByHeroId(heroId)
    if not cantTalk and interactCfg.stage_id ~= ActivitySpringStoryEnum.stageEnum.ranReward and self:CostIsEnough(self:GetNowHaveExp(interactCfg.id), interactCfg.id) then
      return true
    end
  end
  return false
end

function ActivitySpringStoryData:GetNextCanGetRewardLevel()
  local targetLevel = 1
  local finalLevel = 0
  local final_step = 0
  local levelList = ConfigData.activity_interact_story_level[self.actId]
  if levelList == nil then
    return 0, 1
  end
  for i, v in pairs(levelList) do
    if v.level > self.gotRewardLevel then
      targetLevel = v.level
      break
    end
    if 0 < v.final_step then
      finalLevel = v.level
      final_step = v.final_step
    end
  end
  if finalLevel <= self.gotRewardLevel and finalLevel ~= 0 then
    targetLevel = self.gotRewardLevel + final_step
  end
  return self.storyLevel, targetLevel
end

function ActivitySpringStoryData:GetNeedExp(interactId)
  local cfg = self._storyCfg[interactId]
  return cfg.needNum
end

function ActivitySpringStoryData:GetNowHaveExp(interactId)
  local cfg = self._storyCfg[interactId]
  return PlayerDataCenter:GetItemCount(cfg.needItem)
end

return ActivitySpringStoryData
