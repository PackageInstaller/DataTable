_class("UIReviewActivityN7", UIReviewActivityBase)
UIReviewActivityN7 = UIReviewActivityN7

function UIReviewActivityN7:Constructor(id, sample)
end

function UIReviewActivityN7:AssetPackageID()
  return 7
end

function UIReviewActivityN7:ActivityOnOpen()
  TaskManager:GetInstance():StartTask(self.OpenActivity, self)
end

function UIReviewActivityN7:OpenActivity(TT)
  local controller = GameGlobal.UIStateManager():GetController("UIActivityReview")
  local rt = controller:GetShotImage()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIN7MainReview, cache_rt)
  end)
end

function UIReviewActivityN7:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN7ComponentID.ECAMPAIGN_REVIEW_ReviewN7_LINE_MISSION then
    return UIStateType.UIN7LevelReview, nil
  end
end
