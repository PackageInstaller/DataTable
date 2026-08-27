local BaseActivityInteractData = class("BaseActivityInteractData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function BaseActivityInteractData:InitInteractData(actId)
  self.actId = actId
  self.avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  self.interactDic = {}
  self._storyCfg = ConfigData.activity_interact[actId]
  if self._storyCfg == nil then
    error("actInteract act error,id:" .. tostring(actId))
  end
end

function BaseActivityInteractData:UpdateInteractList(interactList)
  self.interactDic = self.interactDic or {}
  for i, v in pairs(interactList) do
    self.interactDic[v] = true
    local cfg = self._storyCfg[v]
    self:CompleteAvgByInteractCfg(cfg)
  end
end

function BaseActivityInteractData:CompleteAvgByInteractCfg(cfg)
  if cfg.story ~= 0 and not ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(cfg.story) then
    ControllerManager:GetController(ControllerTypeId.AvgPlay):RecordAvgPlayed(cfg.story)
    NetworkManager:GetNetwork(NetworkTypeID.Avg):CS_AVG_Complete(cfg.story, 1, nil)
  end
end

function BaseActivityInteractData:FinishTalk(interactId, callback)
  return false
end

function BaseActivityInteractData:SetInteractFininsh(interactId)
  self.interactDic[interactId] = true
end

function BaseActivityInteractData:FinishTalkCallback(args, interactId, callback)
  self:SetInteractFininsh(interactId)
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
  local cfg = self._storyCfg[interactId]
  if #rewardIds == 0 then
    if callback then
      callback()
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRShowOverFunc(function()
      if cfg.story ~= 0 then
        local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
        avgCtrl:StartAvg(nil, cfg.story, callback)
      elseif callback then
        callback()
      end
    end)
    if self:IsInteractTrans() then
      CRData:SetCRItemTransDic(self:GetInteractTransDic(interactId))
    end
    window:AddAndTryShowReward(CRData)
  end)
end

function BaseActivityInteractData:GetInteractTransDic(interactId)
  return nil
end

function BaseActivityInteractData:IsInteractTrans()
  return false
end

function BaseActivityInteractData:CostIsEnough(num, interactId)
  return true
end

function BaseActivityInteractData:CheckHaveTalk()
  return false
end

function BaseActivityInteractData:_CalInteractState(id, main)
  local cfg = self._storyCfg[id]
  if self._preFinishDic[id] ~= nil and not main then
    return
  end
  for i, v in pairs(cfg.pre_interact) do
    self:_CalInteractState(v)
    if not self._preFinishDic[v] then
      self._preFinishDic[id] = false
      return false
    end
  end
  if cfg.stageId == 4 then
    self._preFinishDic[id] = false
    return true
  end
  if not CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
    self._preFinishDic[id] = false
    return false
  end
  if self.interactDic[id] then
    self._preFinishDic[id] = true
    return false
  else
    self._preFinishDic[id] = false
    return true
  end
end

function BaseActivityInteractData:GetThisPhaseStateAndCfg()
  local stateDic = {}
  local cfgDic = {}
  self._preFinishDic = {}
  for i, v in pairs(self._storyCfg) do
    local canTalk = self:_CalInteractState(i, true)
    if canTalk then
      stateDic[i] = true
      cfgDic[i] = v
    end
  end
  return stateDic, cfgDic
end

function BaseActivityInteractData:GetNowCfgByHeroId(heroId)
  local stateDic = {}
  local cfg
  self._preFinishDic = {}
  local cantTalkCfg
  local cantTalkId = 9999
  local cantTalk = false
  for i, v in pairs(self._storyCfg) do
    if v.interact_character == heroId then
      local canTalk = self:_CalInteractState(i, true)
      if canTalk then
        return v, false
      else
        cantTalk = true
        if i < cantTalkId and not self:GetThisTalkStateById(i) then
          cantTalkCfg = v
          cantTalk = true
          cantTalkId = i
        end
      end
    end
  end
  return cantTalkCfg, cantTalk
end

function BaseActivityInteractData:GetThisTalkStateById(id)
  return self.interactDic[id]
end

function BaseActivityInteractData:GetInteractActId()
  return self.actId
end

function BaseActivityInteractData:GetInteractCfg()
  return self._storyCfg
end

function BaseActivityInteractData:GetInteractUIPrefabName()
  return ConfigData.activity_interact_main[self:GetInteractActId()].interact
end

function BaseActivityInteractData:GetNeedExpItemId(interactId)
  local cfg = self._storyCfg[interactId]
  return cfg.needItem
end

function BaseActivityInteractData:GetHeroStoryLevel(heroId)
  return self.storyLevelHeroDic[heroId] or 0
end

function BaseActivityInteractData:GetIsCanInteractHero(heroId)
  return ConfigData.activity_interact.heroActDic[self.actId][heroId]
end

function BaseActivityInteractData:GetIsCanInteractObj(objId)
  return ConfigData.activity_interact.objActDic[self.actId][objId]
end

function BaseActivityInteractData:GetInteractReward(interactId)
  local cfg = self._storyCfg[interactId]
  return cfg.reward
end

return BaseActivityInteractData
