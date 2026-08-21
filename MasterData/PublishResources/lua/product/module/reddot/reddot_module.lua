_class("RedDotModule", GameModule)
RedDotModule = RedDotModule

function RedDotModule:Constructor()
  self._RedDot2GameEvent = {}
  self._RedDotPrivateFunctionList = {}
end

function RedDotModule:Init()
  self.caller:RegisterPushHandler(CEventNotifyLightRedDot, self._HandleNotifyLightRedDot, self)
  self:RegisterRedDotCheckFunciton(self._RequestRedDotStatus4N8)
  self:RegisterRedDotCheckFunciton(self._RequestRedDotStatus4N11)
  self:RegisterRedDotCheckFunciton(self._RequestRedDotStatus4N12)
  self:RegisterRedDotCheckFunciton(self._RequestRedDotStatus4N14)
end

function RedDotModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventNotifyLightRedDot)
end

function RedDotModule:RegisterRedDotCheckFunciton(RedDotStatusFunction)
  table.insert(self._RedDotPrivateFunctionList, RedDotStatusFunction)
end

function RedDotModule:_RequestRedDotStatus4N8(reddottype)
  if reddottype < RedDotType.RDT_N8_FUNCTION_NEW or reddottype > RedDotType.RDT_N8_LINEMISSION then
    return RedDotType.RDT_INVALID
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N8)
  if not localProcess then
    return false
  end
  if reddottype == RedDotType.RDT_N8_FUNCTION_NEW then
    return localProcess:GetStepStatusNew()
  elseif reddottype == RedDotType.RDT_N8_ENTRY_REDDOT then
    return localProcess:GetEntryRedDot()
  elseif reddottype == RedDotType.RDT_N8_LOGIN_AWARD then
    return localProcess:GetLoginAwardRedDot()
  elseif reddottype == RedDotType.RDT_N8_SIMULATOR_PRESTIGE then
    return localProcess:GetPrestigeRedDot()
  elseif reddottype == RedDotType.RDT_N8_SIMULATOR_FUNCTION then
    return localProcess:GetSimulatorRedDot()
  elseif reddottype == RedDotType.RDT_N8_LINEMISSION then
    return localProcess:GetShadowTownRedDot()
  else
    return false
  end
end

function RedDotModule:_RequestRedDotStatus4N11(reddottype)
  if reddottype < RedDotType.RDT_N11_FUNCTION_NEW or reddottype > RedDotType.RDT_N11_FIXLINEMISSION then
    return RedDotType.RDT_INVALID
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N11)
  if not localProcess then
    return false
  end
  if reddottype == RedDotType.RDT_N11_FUNCTION_NEW then
    return localProcess:GetStepStatusNew()
  elseif reddottype == RedDotType.RDT_N11_ENTRY_REDDOT then
    return localProcess:GetEntryRedDot()
  elseif reddottype == RedDotType.RDT_N11_LOGIN_AWARD then
    return localProcess:GetLoginAwardRedDot()
  elseif reddottype == RedDotType.RDT_N11_EASYLINEMISSION then
    return localProcess:GetEasyMissionRedDot()
  elseif reddottype == RedDotType.RDT_N11_HARDLINEMISSION then
    return localProcess:GetHardMissionRedDot()
  elseif reddottype == RedDotType.RDT_N11_FIXLINEMISSION then
    return localProcess:GetEasyMissionRedDot()
  else
    return false
  end
end

function RedDotModule:_RequestRedDotStatus4N12(reddottype)
  if reddottype < RedDotType.RDT_N12_FUNCTION_NEW or reddottype > RedDotType.RDT_N12_ENTRUSTMISSION_NEW then
    return RedDotType.RDT_INVALID
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N12)
  if not localProcess then
    return false
  end
  if reddottype == RedDotType.RDT_N12_FUNCTION_NEW then
    return localProcess:GetStepStatusNew()
  elseif reddottype == RedDotType.RDT_N12_ENTRY_REDDOT then
    return localProcess:GetEntryRedDot()
  elseif reddottype == RedDotType.RDT_N12_LOGIN_AWARD then
    return localProcess:GetLoginAwardRedDot()
  elseif reddottype == RedDotType.RDT_N12_SCORE_AWARD then
    return localProcess:GetScoreRedDot()
  elseif reddottype == RedDotType.RDT_N12_STORY then
    return localProcess:GetStoryRedDot()
  elseif reddottype == RedDotType.RDT_N12_CHALLENGEEMISSION then
    return localProcess:GetChallengeMissionRedDot()
  elseif reddottype == RedDotType.RDT_N12_FIXLINEMISSION then
    return localProcess:GetFixMissionRedDot()
  elseif reddottype == RedDotType.RDT_N12_DAILYMISSION then
    return localProcess:GetDailyMissionRedDot()
  elseif reddottype == RedDotType.RDT_N12_ENTRUSTMISSION then
    return localProcess:GetEntrustMissionRedDot()
  elseif reddottype == RedDotType.RDT_N12_ENTRUSTMISSION_NEW then
    return localProcess:GetEntrustMissionNew()
  else
    return false
  end
end

function RedDotModule:_RequestRedDotStatus4N14(reddottype)
  if reddottype < RedDotType.RDT_N14_FUNCTION_NEW or reddottype > RedDotType.RDT_N14_FISHING_REDDOT then
    return RedDotType.RDT_INVALID
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N14)
  if not localProcess then
    return false
  end
  if reddottype == RedDotType.RDT_N14_FUNCTION_NEW then
    return localProcess:GetStepStatusNew()
  elseif reddottype == RedDotType.RDT_N14_ENTRY_REDDOT then
    return localProcess:GetEntryRedDot()
  elseif reddottype == RedDotType.RDT_N14_LOGIN_AWARD then
    return localProcess:GetLoginAwardRedDot()
  elseif reddottype == RedDotType.RDT_N14_EASYLINEMISSION then
    return localProcess:GetEasyMissionRedDot()
  elseif reddottype == RedDotType.RDT_N14_HARDLINEMISSION_NEW then
    return localProcess:GetHardMissionRedDot()
  elseif reddottype == RedDotType.RDT_N14_FIXLINEMISSION then
    return localProcess:GetFixMissionRedDot()
  elseif reddottype == RedDotType.RDT_N14_FISHING_NEW then
    return localProcess:GetFishingNewMark()
  else
    return false
  end
end

function RedDotModule:RequestPrivteRedDotStatus(reddottype)
  for _, _function in ipairs(self._RedDotPrivateFunctionList) do
    local retRedDot = _function(self, reddottype)
    if retRedDot ~= RedDotType.RDT_INVALID then
      return retRedDot
    end
  end
  return RedDotType.RDT_INVALID
end

function RedDotModule:RequestRedDotStatus(TT, checkList)
  local result = {}
  local netCheckList = {}
  for _, redDot in pairs(checkList) do
    if redDot == RedDotType.RDT_SHOP_EXCHANGE then
      local shopModule = GameGlobal.GetModule(ShopModule)
      result[RedDotType.RDT_SHOP_EXCHANGE] = shopModule:ExchangeRedDotChecker()
    elseif redDot == RedDotType.RDT_BLACKFIST_FUNCTION_NEW then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N7)
      result[redDot] = sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
    elseif redDot == RedDotType.RDT_ENTRY_REDDOT then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N7)
      result[redDot] = localProcess:GetEntryRedDot()
    elseif redDot == RedDotType.RDT_LOGIN_AWARD then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N7)
      result[redDot] = localProcess:GetLoginAwardRedDot()
    elseif redDot == RedDotType.RDT_BLACKFIST_PRESTIGE then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N7)
      result[redDot] = localProcess:GetPrestigeRedDot()
    elseif redDot == RedDotType.RDT_SHADOW_TOWN then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N7)
      result[redDot] = localProcess:GetShadowTownRedDot()
    elseif redDot == RedDotType.RDT_BLACKFIST_FUNCTION then
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N7)
      result[redDot] = localProcess:GetBlackFistRedDot()
    else
      local nRetValue = self:RequestPrivteRedDotStatus(redDot)
      if nRetValue ~= RedDotType.RDT_INVALID then
        result[redDot] = nRetValue
      else
        result[redDot] = false
        netCheckList[#netCheckList + 1] = redDot
      end
    end
  end
  if #netCheckList <= 0 then
    return result
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetRedDotStatusReq)
  request.check_list = netCheckList
  local reply = self:Call(TT, request)
  local replyEvent = reply.msg
  if replyEvent then
    for _, redDot in pairs(replyEvent.red_dot_list) do
      result[redDot] = true
    end
  end
  return result
end

function RedDotModule:ListenRedDot(redDot2GameEvent)
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventListenRedDotStatus)
  for redDot, gameEvent in pairs(redDot2GameEvent) do
    self._RedDot2GameEvent[redDot] = gameEvent
    msg.red_dot_list[#msg.red_dot_list + 1] = redDot
  end
  self:Push(msg)
end

function RedDotModule:UnListenRedDot(RedDotList)
  for _, redDot in pairs(RedDotList) do
    self._RedDot2GameEvent[redDot] = nil
  end
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventUnListenRedDotStatus)
  msg.red_dot_list = RedDotList
  self:Push(msg)
end

function RedDotModule:_HandleNotifyLightRedDot(msg)
  local redDotStatus = msg.red_dot_status
  for redDotType, status in pairs(redDotStatus) do
    local gameEventType = self._RedDot2GameEvent[redDotType]
    if gameEventType ~= nil then
      GameGlobal.EventDispatcher():Dispatch(gameEventType, status)
    end
  end
end
