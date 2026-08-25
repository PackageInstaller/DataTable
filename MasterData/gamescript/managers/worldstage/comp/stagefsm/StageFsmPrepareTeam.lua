local StageFsmPrepareTeam = System.NewClass("StageFsmPrepareTeam", LinearFsmState)

function StageFsmPrepareTeam:IsValid()
  if self.entity:IsRecover() then
    return false
  end
  if self.entity:IsStoryStage() then
    return false
  end
  if self.entity.stageCfg.BelongGroup == DT.GetConstant("PrologueStageGroup") then
    return
  end
  if self.entity:IsAwakerTrialStage() then
    return false
  end
  if self.entity:IsBattleTeachingStage() then
    return false
  end
  if not IntroductionDataUtils.IsFinish() then
    return false
  end
  return true
end

function StageFsmPrepareTeam:Enter()
  local stageId = self.entity.stageCfg.ID
  local cost = CopyDataUtils.GetStageReplenishCost(stageId)
  if cost > PlayerDataUtils.GetEnergy() then
    PlayerDataUtils.ShowEnergyRestorePanel()
    return
  end
  local callfunc = System.fn(self, self.OnTeamReady)
  local stageCfg = self.entity.stageCfg
  local panelData = TeamAssignDataUtils.GetTeamBuildPanelDataByStageCfg(stageCfg, callfunc)
  if self.entity.stageData then
    panelData.extraData = self.entity.stageData.extraData
    print("self.entity.stageData.extraData ", table.tostring(self.entity.stageData.extraData))
  end
  DBGTeamDataUtils.EnterDBGTeamPanel(panelData)
end

function StageFsmPrepareTeam:OnTeamReady(teamIdx, tAwakerTids, assistAwakerTid, playerUid, awakerEquipData)
  tAwakerTids = DBGTeamDataUtils.DealCfgNegativeAwakers(tAwakerTids)
  self.entity:SetTeamInfo(teamIdx, tAwakerTids, assistAwakerTid, playerUid, awakerEquipData)
  if not self.isFinish then
    self:SetFinish()
  else
    self.entity:EnterWorldStage(function()
    end)
  end
end

return StageFsmPrepareTeam
