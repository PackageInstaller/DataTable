_class("UIReviewActivityN11", UIReviewActivityBase)
UIReviewActivityN11 = UIReviewActivityN11

function UIReviewActivityN11:Constructor(id, sample)
end

function UIReviewActivityN11:AssetPackageID()
  return 11
end

function UIReviewActivityN11:ActivityOnOpen()
  local controller = GameGlobal.UIStateManager():GetController("UIActivityReview")
  local rt = controller:GetShotImage()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityN11MainController_Review, cache_rt)
  end)
end

function UIReviewActivityN11:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION then
    return UIStateType.UIActivityN11LineMissionController_Review, nil
  end
end
