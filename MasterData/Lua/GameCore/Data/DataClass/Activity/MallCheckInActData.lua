local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local MallCheckInActData = class("MallCheckInActData", ActivityDataBase)

function MallCheckInActData:Init()
  self.nCanReceives = 0
  self.nActual = 0
  self.tbRewardList = {}
  self.loginRewardActCfg = nil
  self.bIsMove = false
  self.bActive = false
  self:InitRewardList()
end

function MallCheckInActData:InitRewardList()
  local mapActCfg = ConfigTable.GetData("LoginRewardControl", self.nActId)
  if nil == mapActCfg then
    return
  end
  self.loginRewardActCfg = mapActCfg
  local tbRewardList = CacheTable.GetData("_LoginRewardGroup", mapActCfg.RewardsGroup)
  if tbRewardList == nil then
    printError(string.format("LoginRewardGroup表中不存在奖励组id为 %s 的配置！！！", mapActCfg.RewardsGroup))
    return
  end
  table.sort(tbRewardList, function(a, b)
    return a.Order < b.Order
  end)
  self.tbRewardList = tbRewardList
  self.bIsMove = self.loginRewardActCfg.IsMove or false
end

function MallCheckInActData:HitMallChangeEvent()
  PlayerData.Mall:UpdateMallActivityRedDot()
  EventManager.Hit("MallActivityChange", self.nActId)
end

function MallCheckInActData:RefreshActivityData(mapActData)
  ActivityDataBase.RefreshActivityData(self, mapActData)
  self:HitMallChangeEvent()
end

function MallCheckInActData:RefreshStateData(bRedDot, bBanner)
  ActivityDataBase.RefreshStateData(self, bRedDot, bBanner)
  self:HitMallChangeEvent()
end

function MallCheckInActData:RefreshMallLoginData(mapMsgData)
  self.bActive = mapMsgData.active == true
  self:RefreshLoginData(mapMsgData.LoginDays or 0, mapMsgData.Received or 0)
  self:HitMallChangeEvent()
end

function MallCheckInActData:RefreshLoginData(nReceive, nActual)
  self.nCanReceives = nReceive
  self.nActual = nActual
  for k, v in ipairs(self.tbRewardList) do
    v.Status = 0
    if k <= nReceive then
      v.Status = 1
    end
    if k <= nActual then
      v.Status = 2
    end
  end
end

function MallCheckInActData:ReceiveRewardSuc()
  self:RefreshLoginData(self.nCanReceives, self.nCanReceives)
  self:HitMallChangeEvent()
end

function MallCheckInActData:GetActLoginRewardList()
  return self.tbRewardList
end

function MallCheckInActData:GetCanReceive()
  return self.nCanReceives
end

function MallCheckInActData:GetReceived()
  return self.nActual
end

function MallCheckInActData:GetActive()
  return self.bActive
end

function MallCheckInActData:CheckCanReceive()
  return self.bActive and self.nCanReceives > self.nActual
end

function MallCheckInActData:CheckMallRedDot()
  return self:CheckCanReceive()
end

function MallCheckInActData:GetActivityRedDot()
  return self.bRedDot or self:CheckCanReceive()
end

function MallCheckInActData:GetLoginRewardControlCfg()
  return self.loginRewardActCfg
end

return MallCheckInActData
