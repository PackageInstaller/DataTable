local ShareSummonController = NewClass("ShareSummonController", BaseController)

function ShareSummonController:OnInit()
end

function ShareSummonController:OnReset()
end

function ShareSummonController:OnCloseShareSummonView(clickShared)
  EventMgr.Instance.HideWhenCaptureScreen:Dispatch(true)
  local canReq = not DataCenter.gameData.ShareRewardFinish
  if clickShared and canReq then
    self:ReqShareReward(function(_)
      DataCenter.gameData.ShareRewardFinish = true
    end)
  end
end

function ShareSummonController:ReqShareReward(callback)
  ProtoManager.Instance:ReqServer("SettingRequest", "ReqShareReward", callback)
end

return ShareSummonController
