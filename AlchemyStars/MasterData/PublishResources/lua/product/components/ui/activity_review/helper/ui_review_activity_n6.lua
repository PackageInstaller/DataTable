_class("UIReviewActivityN6", UIReviewActivityBase)
UIReviewActivityN6 = UIReviewActivityN6

function UIReviewActivityN6:Constructor(id, sample)
end

function UIReviewActivityN6:AssetPackageID()
  return 6
end

function UIReviewActivityN6:ActivityOnOpen()
  TaskManager:GetInstance():StartTask(self.OpenActivity, self)
end

function UIReviewActivityN6:OpenActivity(TT)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIN6MainController_Review)
end

function UIReviewActivityN6:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN6ComponentID.LINE_MISSION then
    return UIStateType.UIActivityN6LineMissionReview, nil
  end
end

function UIReviewActivityN6:IsFinished()
  if self:IsUnlock() then
    return self:ProgressPercent() >= 100
  end
  return false
end
