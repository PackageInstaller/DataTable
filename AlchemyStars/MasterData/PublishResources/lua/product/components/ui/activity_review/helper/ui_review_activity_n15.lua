_class("UIReviewActivityN15", UIReviewActivityBase)
UIReviewActivityN15 = UIReviewActivityN15

function UIReviewActivityN15:Constructor(id, sample)
end

function UIReviewActivityN15:AssetPackageID()
  return 15
end

function UIReviewActivityN15:ActivityOnOpen()
  local controller = GameGlobal.UIStateManager():GetController("UIActivityReview")
  local rt = controller:GetShotImage()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIN15MainControllerReview, cache_rt)
  end)
end

function UIReviewActivityN15:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_LINE_MISSION then
    return UIStateType.UIN15LineMissionControllerReview, nil
  end
end
