local DonationBoxController = NewClass("DonationBoxController", BaseController)

function DonationBoxController:OnInit()
end

function DonationBoxController:OnReset()
end

function DonationBoxController:OpenActivityDonationBoxView(produceTid)
  if not produceTid then
    Logger.Warn("OpenActivityDonationBoxView param nil.")
    return
  end
  self:ReqDonationBoxData(function()
    local serverRed = RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.ProduceBox, {produceTid})
    if serverRed then
      RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ProduceBox, RedPointDataUtils.RedAttrType.IsNew, produceTid)
    end
    UIManager.Instance:Reopen(Urls.DonationBoxView, produceTid)
  end)
end

function DonationBoxController:ReqDonationBoxData(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenDonationBox", function(svrData)
    if svrData and svrData.boxes then
      self:OnSyncProduce(svrData.boxes)
    end
    if callback then
      callback()
    end
  end, function()
    Logger.Warn("Request donation box data failed")
  end)
end

function DonationBoxController:ReqGainBoxReward(produceTid)
  if not produceTid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainBoxReward", function()
  end, function()
    Logger.Warn("Request gain donation box reward failed")
  end, produceTid)
end

function DonationBoxController:OnSyncProduce(svrData)
  for _, donationBoxData in pairs(svrData) do
    DonationBoxModel.Instance:UpdateDonationBoxData(donationBoxData)
  end
  DonationBoxModel.Instance:UpdateDonationBoxRed()
  EventMgr.Instance.OnDonationBoxDataUpdate:Dispatch()
end

return DonationBoxController
