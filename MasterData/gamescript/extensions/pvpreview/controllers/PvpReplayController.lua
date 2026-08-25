local PvpReplayController = NewClass("PvpReplayController", BaseController)

function PvpReplayController:OnInit()
end

function PvpReplayController:OnReset()
end

function PvpReplayController:OnOpenPvpReplayDataDetailView(recordData)
  PvpReplayDataModel.Instance:UpdateData(recordData)
  UIManager.Instance:Reopen(Urls.PvpReplayDataDetailView)
end

return PvpReplayController
