_class("UIReviewActivityN5", UIReviewActivityBase)
UIReviewActivityN5 = UIReviewActivityN5

function UIReviewActivityN5:Constructor(id, sample)
end

function UIReviewActivityN5:AssetPackageID()
  return 5
end

function UIReviewActivityN5:ActivityOnOpen()
  TaskManager:GetInstance():StartTask(self.OpenActivity, self)
end

function UIReviewActivityN5:OpenActivity(TT)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIN5MainController_Review)
end

function UIReviewActivityN5:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION then
    return UIStateType.UIActivityN5SimpleLevelReview, nil
  end
end
