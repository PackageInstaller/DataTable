local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local LoginRewardActData = class("LoginRewardActData", ActivityDataBase)

function LoginRewardActData:Init()
  self.nCanReceives = 0
  self.nActual = 0
  self.tbRewardList = {}
  self.loginRewardActCfg = nil
  self.bIsMove = false
  self:InitRewardList()
end

function LoginRewardActData:InitRewardList()
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

function LoginRewardActData:RefreshLoginData(nReceive, nActual)
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

function LoginRewardActData:ReceiveRewardSuc()
  self:RefreshLoginData(self.nCanReceives, self.nCanReceives)
end

function LoginRewardActData:GetActLoginRewardList()
  return self.tbRewardList
end

function LoginRewardActData:GetCanReceive()
  return self.nCanReceives
end

function LoginRewardActData:GetReceived()
  return self.nActual
end

function LoginRewardActData:CheckCanReceive()
  return self.nCanReceives > self.nActual
end

function LoginRewardActData:GetLoginRewardControlCfg()
  return self.loginRewardActCfg
end

function LoginRewardActData:GetActSortId()
  if self.bIsMove and not self:CheckCanReceive() then
    return 9999
  else
    return self.actCfg.SortId
  end
end

function LoginRewardActData:GetActivityRedDot()
  if self.nActId == 301053 and self:CheckCanReceive() then
    return true
  end
  return self.bRedDot
end

return LoginRewardActData
