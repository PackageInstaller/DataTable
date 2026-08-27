local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessTurnCtrl = class("WarChessTurnCtrl", base)

function WarChessTurnCtrl:ctor(wcCtrl)
  self.turnNum = 1
  self.stressLevel = 0
  self.stressPoint = 0
  self.rewindTotalTime = 0
  self.rewindLeftTime = 0
end

function WarChessTurnCtrl:InitWCTurnCtrl(pressurePoint, round)
  self.turnNum = round.roundId
  self.stressLevel = pressurePoint.level
  self.stressPoint = pressurePoint.point
  self.wcStressCfg = WarChessManager:GetWCLevelStressCfg()
  if self.wcStressCfg == nil then
    error("can't get warchess_stress with id:" .. tostring(stressId))
  end
end

function WarChessTurnCtrl:SetWCRewindTimes(totalTime, leftTime)
  self.rewindTotalTime = totalTime
  self.rewindLeftTime = leftTime
end

function WarChessTurnCtrl:GetWCRewindTimes()
  return self.rewindTotalTime, self.rewindLeftTime
end

function WarChessTurnCtrl:GetWCTurnNum()
  return self.turnNum
end

function WarChessTurnCtrl:GetWCStressCfgs()
  return self.wcStressCfg
end

function WarChessTurnCtrl:GetWCStressLevelAndPoint()
  return self.stressLevel, self.stressPoint
end

function WarChessTurnCtrl:SendTurnOver()
  local wid = self.wcCtrl:GetWCId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_RoundStartSingle(wid, function(argList)
    if argList.Count < 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local isSucess = argList[0]
    if isSucess then
      local roundNum = argList[1]
      self.turnNum = roundNum
      self.wcCtrl.mapCtrl:CleanCacheMonsterPower()
      MsgCenter:Broadcast(eMsgEventId.WC_TurnStart, self.turnNum)
      UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(window)
        if window ~= nil then
          window:OnWCTurnOver()
        end
      end)
    end
  end)
end

function WarChessTurnCtrl:WCStressUpdata(pressurePointDiff)
  local lastStressLevel = self.stressLevel
  self.stressLevel = pressurePointDiff.level
  self.stressPoint = pressurePointDiff.point
  MsgCenter:Broadcast(eMsgEventId.WC_StressPointChange, self.stressLevel, self.stressPoint)
  if lastStressLevel ~= self.stressLevel then
    for level = lastStressLevel + 1, self.stressLevel do
      local stressCfg = self.wcStressCfg[level]
      UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(window)
        if window ~= nil then
          window:OnWCStressUpgrade(stressCfg)
        end
      end)
    end
  end
end

function WarChessTurnCtrl:GetWCStressNum()
  return self.stressLevel, self.stressPoint
end

return WarChessTurnCtrl
