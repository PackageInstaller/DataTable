local WeekBossController = NewClass("WeekBossController", BaseController)

function WeekBossController:OnInit()
end

function WeekBossController:OnReset()
end

function WeekBossController:EnterStageGroup()
  local stageGroupId = WeekBossExtModel.Instance:GetSelectedStageGroupId()
  local featureId = WeekBossExtModel.Instance.featureId
  local unlocked = WeekBossExtModel.Instance:IsUnlocked(stageGroupId)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(featureId, stageGroupId)
    return
  end
  local stageType = WeekBossExtModel.Instance.stageType
  local page = CommonDefine.DBGEntryPage.WeekBossPanel
  UIManager.Instance:Reopen(Urls.DungeonWeekBossSubPanel, stageGroupId, featureId, stageType, page)
  self:RemoveRed(stageGroupId)
end

function WeekBossController:ShowWeekBossIntroduction()
  local title = LT.Text("WeeklyBossTitle")
  local content = LT.Text("WeeklyBossInstructions")
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function WeekBossController:RemoveRed(stageGroupId)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.WeekBossChallenge, RedPointDataUtils.RedAttrType.IsNew, stageGroupId)
end

return WeekBossController
