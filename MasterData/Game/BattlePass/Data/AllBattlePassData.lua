local AllBattlePassData = class("AllBattlePassData")
local BattlePassData = require("Game.BattlePass.Data.BattlePassData")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local NoticeData = require("Game.Notice.NoticeData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function AllBattlePassData:ctor()
  self.passInfos = {}
end

function AllBattlePassData:__UpdateBattlePassInternal(id, battlepass)
  if self.passInfos[id] ~= nil then
    self.passInfos[id]:UpdateBattlePass(battlepass)
    return
  end
  local battlepassCfg = ConfigData.battlepass_type[id]
  if battlepassCfg == nil then
    error("battle pass type is nil,id:" .. tostring(id))
    return
  end
  local passData = BattlePassData.CreateBattlePass(battlepass, battlepassCfg)
  self.passInfos[id] = passData
end

function AllBattlePassData:InitAllBattlePass(data)
  ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  for id, battlepass in pairs(data.infos) do
    self:__UpdateBattlePassInternal(id, battlepass)
    MsgCenter:Broadcast(eMsgEventId.BattlePassChange, id)
  end
  self:__RefreshBattleWeeklyExpiredTm()
end

function AllBattlePassData:__RefreshBattleWeeklyExpiredTm()
  local mainBattlePass = self:GetMainBattlePass()
  if mainBattlePass ~= nil and (self.__mainBattlePassId ~= mainBattlePass.id or self.__mainBattleweeklyExpiredTm ~= mainBattlePass.weeklyNextExpiredTm) then
    self.__mainBattlePassId = mainBattlePass.id
    self.__mainBattleweeklyExpiredTm = mainBattlePass.weeklyNextExpiredTm
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
    timePassCtrl:AddEventTimer(self.__mainBattleweeklyExpiredTm, function()
      NetworkManager:GetNetwork(NetworkTypeID.BattlePass):CS_BATTLEPASS_Detail()
    end)
  end
end

function AllBattlePassData:UpdateAllBattlePass(update)
  for id, battlepass in pairs(update) do
    self:__UpdateBattlePassInternal(id, battlepass)
    MsgCenter:Broadcast(eMsgEventId.BattlePassChange, id)
  end
  self:__RefreshBattleWeeklyExpiredTm()
end

function AllBattlePassData:OnBattlePassTaskChange(taskId)
  for _, passData in pairs(self.passInfos) do
    passData:OnTaskChange(taskId)
  end
end

function AllBattlePassData:OnBattlePassEnd(id)
  self.passInfos[id] = nil
end

function AllBattlePassData:GetMainBattlePass()
  for id, passData in pairs(self.passInfos) do
    if passData:IsBattleType() and passData:IsBattlepassStanding() and passData:IsBattlePassValid() then
      return passData
    end
  end
  return nil
end

function AllBattlePassData:GetBattlePassByActId(actId)
  return self.passInfos[actId]
end

function AllBattlePassData:SetBattlePassUpdateCallbackByActId(actFrameId, callback)
  local battlepassData = self.passInfos[actFrameId]
  if battlepassData ~= nil then
    battlepassData:SetBattlePassUpdateCallback(callback)
  end
end

function AllBattlePassData:UpdatePlayerLevel(level)
  local isHaveNewCouldReward = false
  for k, v in pairs(self.passInfos) do
    if v.passCfg.condition == BattlePassEnum.ConditionType.AchievementLevel then
      v.level = PlayerDataCenter.playerLevel.level
      v:__UpdateHaveRewardTake()
      isHaveNewCouldReward = v:GetIsThisLeveHaveNewReward(level)
    end
  end
  if isHaveNewCouldReward then
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.GrowBagLevelup, nil, nil, nil))
  end
end

function AllBattlePassData:GetBattlePass(id)
  return self.passInfos[id]
end

return AllBattlePassData
