_class("UIReviewActivityN13", UIReviewActivityBase)
UIReviewActivityN13 = UIReviewActivityN13

function UIReviewActivityN13:Constructor(id, sample)
end

function UIReviewActivityN13:AssetPackageID()
  return 13
end

function UIReviewActivityN13:ActivityOnOpen()
  local controller = GameGlobal.UIStateManager():GetController("UIActivityReview")
  local rt = controller:GetShotImage()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIN13MainControllerReview, cache_rt)
  end)
end

function UIReviewActivityN13:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION then
    return UIStateType.UIN13LineMissionControllerReview, nil
  end
end
