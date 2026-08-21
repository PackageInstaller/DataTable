_class("UIReviewActivityN1", UIReviewActivityBase)
UIReviewActivityN1 = UIReviewActivityN1

function UIReviewActivityN1:Constructor(id, sample)
end

function UIReviewActivityN1:AssetPackageID()
  return 1
end

function UIReviewActivityN1:ActivityOnOpen()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityEveSinsaMainController_Review)
end

function UIReviewActivityN1:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION then
    return UIStateType.UIActivityEveSinsaLevelAController_Review, nil
  elseif comID == ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSION then
    return UIStateType.UIActivityEveSinsaLevelBController_Review, nil
  end
end

function UIReviewActivityN1:GetRedAndNewData()
  if self._redNewData == nil then
    self._redNewData = UIActivityEveSinaNewFlagRedPoint_Review:New()
  end
  return self._redNewData
end
