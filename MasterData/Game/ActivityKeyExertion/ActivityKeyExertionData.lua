local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityKeyExertionData = class("ActivityKeyExertionData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.KeyExertion
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local redDotType = {redDotPackage = 1, redDotTask = 2}

function ActivityKeyExertionData:InitKeyExertionData(actId)
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_keyExertion_main[actId]
  self._token = self._mainCfg.token
  self._progressBar = self._mainCfg.progress_bar
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivityKeyExertion)
  self._taskIdDic = {}
  self._mainColor = ColorUtil.FromHexUnit(self._mainCfg.color)
  for _, taskId in pairs(self._mainCfg.task) do
    self._taskIdDic[taskId] = true
  end
  self:__UpdateKeyExertion()
end

function ActivityKeyExertionData:__UpdateKeyExertion()
  self:RefreshKeyExertionRedPackage()
  self:RefreshKeyExertionRedTask()
end

function ActivityKeyExertionData:RefreshKeyExertionRedPackage()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local expRed = actRed:AddChild(redDotType.redDotPackage)
  expRed:SetRedDotCount(self:CanKeyExertionOpenPackage() and 1 or 0)
end

function ActivityKeyExertionData:RefreshKeyExertionRedTask()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local taskRed = actRed:AddChild(redDotType.redDotTask)
  if self:IsActivityRunning() then
    for taskId, _ in pairs(self._taskIdDic) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        taskRed:SetRedDotCount(1)
        return
      end
    end
  end
  taskRed:SetRedDotCount(0)
end

function ActivityKeyExertionData:CanKeyExertionOpenPackage()
  return self:GetKeyExertionPackageFragmentNum() >= self._progressBar
end

function ActivityKeyExertionData:GetKeyExertionMainCfg()
  return self._mainCfg
end

function ActivityKeyExertionData:GetKeyExertionMainReward()
  return self._mainCfg.preprecess_main_rewardIds, self._mainCfg.preprecess_main_rewardNums
end

function ActivityKeyExertionData:GetKeyExertionAllReward()
  return self._mainCfg.preprecess_all_rewardIds, self._mainCfg.preprecess_all_rewardNums
end

function ActivityKeyExertionData:GetKeyExertionActivityDes()
  return LanguageUtil.GetLocaleText(self._mainCfg.activity_des)
end

function ActivityKeyExertionData:GetKeyExertionMainDes()
  return LanguageUtil.GetLocaleText(self._mainCfg.main_des)
end

function ActivityKeyExertionData:GetKeyExertionAllRewardDes()
  return LanguageUtil.GetLocaleText(self._mainCfg.rewards_des)
end

function ActivityKeyExertionData:GetKeyExertionTokenId()
  return self._token
end

function ActivityKeyExertionData:GetKeyExertionPackageFragmentNum()
  return PlayerDataCenter:GetItemCount(self._token)
end

function ActivityKeyExertionData:GetKeyExertionPackageFragmentMaxNum()
  return self._mainCfg.progress_bar
end

function ActivityKeyExertionData:GetKeyExertionOpenedPackageNum()
  return self:GetKeyExertionPackageFragmentNum() // self._progressBar
end

function ActivityKeyExertionData:GetKeyExertionRedDotType()
  return redDotType
end

function ActivityKeyExertionData:GetKeyExertionTaskIdDic()
  return self._taskIdDic
end

function ActivityKeyExertionData:GetKeyExertionCurrentTaskId()
  return self._mainCfg.task[1]
end

function ActivityKeyExertionData:GetBigRewardId()
  return self._mainCfg.big_reward
end

function ActivityKeyExertionData:GetIsBigRewardAllPicked()
  return (self.bigRewardPickedCount or 0) >= self._mainCfg.reward_times
end

function ActivityKeyExertionData:GetKeyExertionMainColor()
  return self._mainColor
end

function ActivityKeyExertionData:SetBigRewardPickedCount(count)
  self.bigRewardPickedCount = count
end

return ActivityKeyExertionData
