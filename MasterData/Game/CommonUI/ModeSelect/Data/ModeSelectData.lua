local ModeSelectData = class("ModeSelectData")

function ModeSelectData:ctor(actFrameId)
  self._actFrameId = actFrameId
  self._mainCfg = ConfigData.act_general_ep_main[actFrameId]
end

function ModeSelectData:getMainCfg()
  return self._mainCfg
end

function ModeSelectData:GetActLongId()
  return self._actFrameId
end

function ModeSelectData:SetGetEnvRedDotNodeCallback(callback)
  self.__GetEnvReddotNode = callback
end

function ModeSelectData:SetGetInfinityRewardReddotNodeCallback(callback)
  self.__GetInfinityRewardReddotNode = callback
end

function ModeSelectData:SetGetInifinityCurrentScoreCallback(callback)
  self.__getInifinityCurrentScoreCallback = callback
end

function ModeSelectData:SetGetInifinityPickedScoreCallback(callback)
  self.__getInifinityPickedScoreCallback = callback
end

function ModeSelectData:SetRefreshInifinityPickedScoreCallback(callback)
  self.__refreshInifinityPickedScoreCallback = callback
end

function ModeSelectData:GetGetInifinityCurrentScoreCallback()
  return self.__getInifinityCurrentScoreCallback
end

function ModeSelectData:GetGetInifinityPickedScoreCallback()
  return self.__getInifinityPickedScoreCallback
end

function ModeSelectData:GetRefreshInifinityPickedScoreCallback()
  return self.__refreshInifinityPickedScoreCallback
end

function ModeSelectData:GetEnvRedDotNode(envid)
  if self.__GetEnvReddotNode ~= nil then
    return self.__GetEnvReddotNode(envid)
  end
  return nil
end

function ModeSelectData:GetInfinityRewardRedDotNode(diffId)
  if self.__GetInfinityRewardReddotNode ~= nil then
    return self.__GetInfinityRewardReddotNode(diffId)
  end
  return nil
end

function ModeSelectData:ShowMsInfinityReward(diffCfg)
  local rewardList = {}
  local rewardId = diffCfg.reward_id
  local rewardCfgList = ConfigData.act_general_ep_reward_id[rewardId]
  local totalScore = 0
  for index, cfg in ipairs(rewardCfgList) do
    totalScore = totalScore + cfg.need_num
    local reward = {
      score = totalScore,
      rewardIds = cfg.rewardIds,
      rewardNums = cfg.rewardNums
    }
    table.insert(rewardList, reward)
  end
  local pickedScore = 0
  local currentScore = 0
  local diffId = diffCfg.difficulty_id
  local getCurrentScoreCallback = self:GetGetInifinityCurrentScoreCallback()
  if getCurrentScoreCallback ~= nil then
    currentScore = getCurrentScoreCallback(diffId)
  end
  local getPickedScoreCallback = self:GetGetInifinityPickedScoreCallback()
  if getPickedScoreCallback ~= nil then
    pickedScore = getPickedScoreCallback(diffId)
  end
  
  local function OnClickReceiveAllFunc()
    local networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    networkCtrl:CS_Activity_General_Bp_Reward(self:GetActLongId(), diffId, function(args)
      UIManager:DeleteWindow(UIWindowTypeID.StageRewardPreview)
      local currentScore = 0
      local diffId = diffId
      local getCurrentScoreCallback = self:GetGetInifinityCurrentScoreCallback()
      if getCurrentScoreCallback ~= nil then
        currentScore = getCurrentScoreCallback(diffId)
      end
      local refreshCallback = self:GetRefreshInifinityPickedScoreCallback()
      if refreshCallback ~= nil then
        refreshCallback(diffId, currentScore)
      end
    end)
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.StageRewardPreview, function(win)
    if win == nil then
    end
    win:InitUIStageRewardPreviewV2(rewardList, pickedScore, currentScore, OnClickReceiveAllFunc)
  end)
end

return ModeSelectData
