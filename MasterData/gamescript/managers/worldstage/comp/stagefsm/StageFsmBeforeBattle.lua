local StageFsmBeforeBattle, Super = System.NewClass("StageFsmBeforeBattle", LinearFsmState)
StageFsmBeforeBattle.isSkipRecoverBattle = false

function StageFsmBeforeBattle:GetBattleTriggerData()
  if SceneMgr.Instance:IsInCopies() then
    return
  end
  local triggerData = self.entity:GetStageTriggerData() or {}
  local data = triggerData.data or {}
  if not data.checkStartBattleAgain and not data.prize and data.battleTid and 0 ~= data.battleTid then
    Logger.Info("BeforeBattleTid", data.battleTid or "nil")
    return triggerData
  end
end

function StageFsmBeforeBattle:IsValid()
  if self:GetBattleTriggerData() then
    return true
  end
end

function StageFsmBeforeBattle:CheckEnter()
  do return self.IsValid end
  return self.IsValid, self
end

function StageFsmBeforeBattle:CheckExit()
  if Super.CheckExit(self) then
    return true
  end
  if self.entity:GetStageExitData() then
    return true
  end
end

function StageFsmBeforeBattle:Enter()
  local triggerData = self:GetBattleTriggerData()
  MapOneLineManager.BeforeEnterUid = triggerData.uid
  local stageData = self.entity.stageData
  stageData.gearTriggerData = nil
  EventMgr.Instance.BattleResult:RegisterEvent(System.fn(self, self.OnBattleResult))
  local isRecovering = WorldRecoveryManager.Instance:IsRecovery()
  BattleManager.Instance:EnterBattle(triggerData.data, isRecovering)
end

function StageFsmBeforeBattle:OnBattleResult(battleResult)
  if battleResult == CommonDefine.BattleResult.Win then
    EventMgr.Instance.BattleFinish:RegisterEvent(System.fn(self, self.OnBattleFinish))
  end
  EventMgr.Instance.BattleResult:RemoveEvent(System.fn(self, self.OnBattleResult))
  if self.entity:IsOneBattleStage() and battleResult == CommonDefine.BattleResult.Win then
    return
  end
  local triggerData = self:GetBattleTriggerData()
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearHandle", function(data)
    EventMgr.Instance.OnGearHandle:Dispatch(data)
    self.entity:ClearStageTriggerData()
    WorldRecoveryManager.Instance:ClearRecoverEventData()
    local sceneType = CommonDefine.SceneType.Copies
    if not self.entity:IsOneLineMap() then
      CopyDataUtils.HandleGearBattleResult(data, sceneType, function()
      end)
    end
  end, function(errorData)
    Logger.Warn("WorldRequest.OnGearHandle Error", table.tostring(errorData))
  end, triggerData.uid, {})
end

function StageFsmBeforeBattle:OnBattleFinish()
  EventMgr.Instance.BattleFinish:RemoveEvent(System.fn(self, self.OnBattleFinish))
  self:SetFinish()
end

function StageFsmBeforeBattle:Reset()
  Super.Reset(self)
  if self.protoBinder then
    self.protoBinder:teardown()
    self.protoBinder = nil
  end
  EventMgr.Instance.BattleResult:RemoveEvent(System.fn(self, self.OnBattleResult))
  EventMgr.Instance.BattleFinish:RemoveEvent(System.fn(self, self.OnBattleFinish))
end

function StageFsmBeforeBattle:OnDestroy()
  Super.OnDestroy(self)
  MapNetEventManager.protoCacheData = nil
end

return StageFsmBeforeBattle
