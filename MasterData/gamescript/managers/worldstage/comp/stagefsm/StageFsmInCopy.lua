local StageFsmInCopy, Super = System.NewClass("StageFsmInCopy", LinearFsmState)

function StageFsmInCopy:IsValid()
  if self.entity:GetStageExitData() then
    return false
  end
  if self.entity:IsOneBattleStage() and not self.entity:IsRecover() then
    return false
  end
  if StageFsmBeforeBattle.isSkipRecoverBattle then
    return false
  end
  return true
end

function StageFsmInCopy:CheckEnter()
  if self.entity:GetStageEnterData() then
    return true
  end
end

function StageFsmInCopy:Enter()
  local uiQueueOpenDelay = 1
  self:EnterMap(uiQueueOpenDelay)
  EventMgr.Instance.BattleStart:RegisterEvent(System.fn(self, self.OnBattleStart))
  EventMgr.Instance.BattleResult:RegisterEvent(System.fn(self, self.OnBattleResult))
  EventMgr.Instance.BattleFinish:RegisterEvent(System.fn(self, self.OnBattleFinish))
end

function StageFsmInCopy:Reset()
  EventMgr.Instance.BattleStart:RemoveEvent(System.fn(self, self.OnBattleStart))
  EventMgr.Instance.BattleResult:RemoveEvent(System.fn(self, self.OnBattleResult))
  EventMgr.Instance.BattleFinish:RemoveEvent(System.fn(self, self.OnBattleFinish))
end

function StageFsmInCopy:OnBattleStart()
  self.entity:HideMap()
end

function StageFsmInCopy:OnBattleResult(result)
  if 0 == result then
    local gearMgr = self.entity.map and self.entity.map:GetComponent(MapGearManager)
    if gearMgr and gearMgr:GetCurrGearName() == GearItemMonster.__name then
      self:SetFinish()
    end
    if self.entity:IsOneLineMap() then
      self:SetFinish()
    end
  end
end

function StageFsmInCopy:OnBattleFinish(battleResult, battleFinishData)
  if battleResult and battleFinishData then
    self:EnterMap(0.2)
  end
end

function StageFsmInCopy:EnterMap(uiQueueOpenDelay)
  if IntroductionDataUtils.IsFinish() then
    SceneMgr.Instance:SetOpenUIQueueEnabled(false)
  end
  SceneMgr.Instance:EnterCopies()
  local haveMapEntityCreate = self.entity.map and true or false
  self.entity:EnterMap()
  if haveMapEntityCreate and IntroductionDataUtils.IsFinish() then
    self.entity.binder:BindTimer(uiQueueOpenDelay, 0, nil, function()
      SceneMgr.Instance:SetOpenUIQueueEnabled(true)
    end)
  end
end

function StageFsmInCopy:CheckExit()
  if Super.CheckExit(self) then
    return true
  end
  if self.entity:GetStageExitData() then
    return true
  end
end

return StageFsmInCopy
