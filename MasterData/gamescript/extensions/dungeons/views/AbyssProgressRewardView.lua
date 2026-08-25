local AbyssProgressRewardView, Super = NewClass("AbyssProgressRewardView", ProgressRewardViewBase)
AbyssProgressRewardView.uiResCls = UI_Chaper_Popup_Award_OptimizedResource

function AbyssProgressRewardView:ctor()
  Super.ctor(self)
end

function AbyssProgressRewardView:OnBuildView()
  Super.OnBuildView(self)
  if RedPointDataUtils.IsShowAbyssScorePrize() == RedPointDataUtils.RedAttrType.IsNew then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.AbyssChallengeScorePrize, RedPointDataUtils.RedAttrType.IsNew)
  end
end

function AbyssProgressRewardView:RegisterEvents()
  Super.RegisterEvents(self)
end

function AbyssProgressRewardView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAbyssScorePrizeStateChanged, System.fn(self, self._OnAbyssProgressRewardChanged))
end

function AbyssProgressRewardView:OnEnterView()
  Super.OnEnterView(self)
end

function AbyssProgressRewardView:_OnAbyssProgressRewardChanged(index)
  for idx, progressData in ipairs(self.progressDataList) do
    if progressData and progressData.awardIndex == index then
      self.progressDataList[idx].isGet = AbyssExtModel.Instance:HasGotAward(index)
      break
    end
  end
  self:_RefreshRewardList()
end

function AbyssProgressRewardView:_GetProgressDataList()
  self.progressDataList = AbyssExtModel.Instance:GetProgressRewardDatas()
  return self.progressDataList
end

function AbyssProgressRewardView:GetOneKeyProtoName()
  return "OnGainAbyssPrizeAll"
end

function AbyssProgressRewardView:ReqOneKeyReward(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainAbyssPrizeAll", function(_)
    if callback then
      callback()
    end
    AbyssController.Instance:ReqAbyssData()
  end, nil)
end

return AbyssProgressRewardView
