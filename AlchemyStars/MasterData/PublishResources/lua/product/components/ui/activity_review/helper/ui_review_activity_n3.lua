_class("UIReviewActivityN3", UIReviewActivityBase)
UIReviewActivityN3 = UIReviewActivityN3

function UIReviewActivityN3:Constructor(id, sample)
end

function UIReviewActivityN3:AssetPackageID()
  return 3
end

function UIReviewActivityN3:ActivityOnOpen()
  local controller = GameGlobal.UIStateManager():GetController("UIActivityReview")
  local rt = controller:GetShotImage()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UISummer1Review, cache_rt)
  end)
end

function UIReviewActivityN3:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_LINE_MISSION then
    return UIStateType.UIXH1SimpleLevelReview, nil
  elseif comID == ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION then
    return UIStateType.UIXH1HardLevelReview, nil
  end
end
