local ActivityDivergentNetWork = class("ActivityDivergentNetWork", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityDivergentNetWork:ctor()
  self._refreshQuestTable = {}
  self._buyQuestTable = {}
  self._switchHeroTable = {}
end

function ActivityDivergentNetWork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityHeroDivergent_RefreshQuest, self, proto_csmsg.SC_ActivityHeroDivergent_RefreshQuest, self.SC_ActivityHeroDivergent_RefreshQuest)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityHeroDivergent_BuyQuest, self, proto_csmsg.SC_ActivityHeroDivergent_BuyQuest, self.SC_ActivityHeroDivergent_BuyQuest)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityHeroDivergent_HeroSwitch, self, proto_csmsg.SC_ActivityHeroDivergent_HeroSwitch, self.SC_ActivityHeroDivergent_HeroSwitch)
end

function ActivityDivergentNetWork:CS_ActivityHeroDivergent_RefreshQuest(actId, questId, callback)
  self._refreshQuestTable.actId = actId
  self._refreshQuestTable.questId = questId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_RefreshQuest, proto_csmsg.CS_ActivityHeroDivergent_RefreshQuest, self._refreshQuestTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_RefreshQuest, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityHeroDivergent_RefreshQuest)
end

function ActivityDivergentNetWork:SC_ActivityHeroDivergent_RefreshQuest(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.BACKPACK_NO_ENOUGH_ITEM then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(90))
    else
      local err = "SC_ActivityHeroDivergent_RefreshQuest error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_RefreshQuest)
    return
  end
end

function ActivityDivergentNetWork:CS_ActivityHeroDivergent_BuyQuest(actId, callback)
  self._buyQuestTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_BuyQuest, proto_csmsg.CS_ActivityHeroDivergent_BuyQuest, self._buyQuestTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_BuyQuest, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityHeroDivergent_BuyQuest)
end

function ActivityDivergentNetWork:SC_ActivityHeroDivergent_BuyQuest(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err
    if msg.ret == proto_csmsg_ErrorCode.BACKPACK_NO_ENOUGH_ITEM then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(88))
    else
      local err = "SC_ActivityHeroDivergent_BuyQuest error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_BuyQuest)
    return
  end
end

function ActivityDivergentNetWork:CS_ActivityHeroDivergent_HeroSwitch(actId, heroId, callback)
  self._switchHeroTable.actId = actId
  self._switchHeroTable.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_HeroSwitch, proto_csmsg.CS_ActivityHeroDivergent_HeroSwitch, self._switchHeroTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_HeroSwitch, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityHeroDivergent_HeroSwitch)
end

function ActivityDivergentNetWork:SC_ActivityHeroDivergent_HeroSwitch(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivityHeroDivergent_HeroSwitch error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityHeroDivergent_HeroSwitch)
    return
  end
end

return ActivityDivergentNetWork
