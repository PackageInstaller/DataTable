local TimerManager = require("GameCore.Timer.TimerManager")
local BuffItem_TimeSlow = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItem_TimeSlow")
local BuffItem_Patience = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItem_Patience")
local BuffItem_ScoreMul = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItem_ScoreMul")
local BuffItem_Life = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItem_Life")
local BuffItem_AutoOrder = require("Game.UI.Play_IceCreamTruck.Play.Buff.BuffItem_AutoOrder")
local IceCreamBuffRuntimeCtrl = class("IceCreamBuffRuntimeCtrl")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local BuffClassMap = {
  [GameEnum.IceBuffEffect.Time] = BuffItem_TimeSlow,
  [GameEnum.IceBuffEffect.Patience] = BuffItem_Patience,
  [GameEnum.IceBuffEffect.Score] = BuffItem_ScoreMul,
  [GameEnum.IceBuffEffect.HP] = BuffItem_Life,
  [GameEnum.IceBuffEffect.Order] = BuffItem_AutoOrder
}

function IceCreamBuffRuntimeCtrl:Init(ctx)
  self.ctx = ctx
  self.tbActive = {}
end

function IceCreamBuffRuntimeCtrl:Clear()
  if self.tbActive == nil then
    return
  end
  for _, node in pairs(self.tbActive) do
    if node.timer then
      TimerManager.Remove(node.timer, false)
    end
    if node.inst then
      node.inst:Revoke(self.ctx)
    end
  end
  self.tbActive = {}
end

function IceCreamBuffRuntimeCtrl:IsTypeActive(nBuffType)
  return self.tbActive[nBuffType] ~= nil
end

function IceCreamBuffRuntimeCtrl:ReadCfg(nItemId)
  local cfg = ConfigTable.GetData("IceCreamBuff", nItemId)
  if cfg == nil then
    printError("道具ID未配置:" .. tostring(nItemId))
  end
  return cfg
end

function IceCreamBuffRuntimeCtrl:TryUseBuff(nItemId)
  local cfg = self:ReadCfg(nItemId)
  if cfg == nil then
    return false
  end
  local nBuffType = cfg.BuffType
  local BuffClass = BuffClassMap[nBuffType]
  if BuffClass == nil then
    printError("未注册的 BuffType:" .. tostring(nBuffType))
    return false
  end
  if self:IsTypeActive(nBuffType) then
    printLog("同类型 Buff 已生效，无法叠加。BuffType=" .. tostring(nBuffType))
    return false
  end
  local inst = BuffClass.new()
  inst:Init(cfg)
  inst:Apply(self.ctx)
  local nDuration = inst:GetDuration() or 0
  if nDuration <= 0 then
    printLog(string.format("道具 %d 已生效（类型=%s, 瞬发）", nItemId, tostring(nBuffType)))
    EventManager.Hit("Event_IceCreamBuffStart", nBuffType, nItemId, 0)
    return true
  end
  local node = {
    inst = inst,
    timer = nil,
    nLeftSec = nDuration
  }
  self.tbActive[nBuffType] = node
  node.timer = TimerManager.Add(nDuration, 1, self, function()
    self:_OnBuffTick(nBuffType, nItemId)
  end, true, true, false)
  local fScale = self.ctx and self.ctx.getSpeedScale and self.ctx.getSpeedScale() or 1
  if node.timer ~= nil and fScale ~= 1 and 0 < fScale then
    node.timer:SetSpeed(fScale)
  end
  EventManager.Hit("Event_IceCreamBuffStart", nBuffType, nItemId, nDuration)
  self:SetBuffAuido(nItemId, true)
  return true
end

function IceCreamBuffRuntimeCtrl:_OnBuffTick(nBuffType, nItemId)
  local node = self.tbActive[nBuffType]
  if node == nil then
    return
  end
  node.nLeftSec = (node.nLeftSec or 0) - 1
  if node.nLeftSec < 0 then
    node.nLeftSec = 0
  end
  EventManager.Hit("Event_IceCreamBuffTick", nBuffType, nItemId, node.nLeftSec)
  if node.nLeftSec <= 0 then
    self:RemoveBuff(nBuffType, nItemId)
  end
end

function IceCreamBuffRuntimeCtrl:RemoveBuff(nBuffType, nItemId)
  local node = self.tbActive[nBuffType]
  if node == nil then
    return
  end
  self.tbActive[nBuffType] = nil
  if node.timer then
    TimerManager.Remove(node.timer, false)
    node.timer = nil
  end
  if node.inst then
    node.inst:Revoke(self.ctx)
  end
  printLog(string.format("道具 %d 生效结束（类型=%s）", nItemId, tostring(nBuffType)))
  EventManager.Hit("Event_IceCreamBuffEnd", nBuffType, nItemId)
  self:SetBuffAuido(nItemId, false)
end

function IceCreamBuffRuntimeCtrl:InPause(bPause)
  if self.tbActive == nil then
    return
  end
  for _, node in pairs(self.tbActive) do
    if node.timer ~= nil then
      node.timer:Pause(bPause)
    end
  end
end

function IceCreamBuffRuntimeCtrl:SetTimersSpeed(fScale)
  if self.tbActive == nil then
    return
  end
  if fScale == nil or fScale <= 0 then
    fScale = 1
  end
  for _, node in pairs(self.tbActive) do
    if node.timer ~= nil then
      node.timer:SetSpeed(fScale)
    end
  end
end

function IceCreamBuffRuntimeCtrl:SetBuffAuido(nBuffId, bIsUse)
  if nBuffId == 101 then
    if bIsUse then
      WwiseAudioMgr:PostEvent("mode_400013_lowtime_lp")
    else
      WwiseAudioMgr:PostEvent("mode_400013_lowtime_lp_stop")
    end
  elseif nBuffId == 102 then
    if bIsUse then
      WwiseAudioMgr:PostEvent("mode_400013_veryhappy")
    end
  elseif nBuffId == 103 then
    if bIsUse then
      WwiseAudioMgr:PostEvent("mode_400013_doubletime_lp")
    else
      WwiseAudioMgr:PostEvent("mode_400013_doubletime_lp_stop")
    end
  elseif nBuffId == 105 then
    if bIsUse then
      WwiseAudioMgr:PostEvent("mode_400013_auto_lp")
    else
      WwiseAudioMgr:PostEvent("mode_400013_auto_stop")
    end
  end
end

return IceCreamBuffRuntimeCtrl
