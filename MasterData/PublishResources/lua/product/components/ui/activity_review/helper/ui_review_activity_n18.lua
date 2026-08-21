_class("UIReviewActivityN18", UIReviewActivityBase)
UIReviewActivityN18 = UIReviewActivityN18

function UIReviewActivityN18:Constructor(id, sample)
end

function UIReviewActivityN18:AssetPackageID()
  return 18
end

function UIReviewActivityN18:ActivityOnOpen()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIN18MainController_Review)
end

function UIReviewActivityN18:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_LINE_MISSION then
    return UIStateType.UIN18LineMissionController_Review, nil
  end
end
