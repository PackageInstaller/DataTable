local RailWayController = NewClass("RailWayController", BaseController)

function RailWayController:OnInit()
  self:OnReset()
end

function RailWayController:OpenCareerLevelView()
  PvpController.Instance:OpenPvpHistoryLevelView(CareerLevelDefine.CareerLevelType.RailWay)
end

function RailWayController:OpenRankView()
  UIManager.Instance:Reopen(Urls.RankRailWayView)
end

function RailWayController:OpenTaskView()
  UIManager.Instance:Reopen(Urls.RailWayTaskView)
end

function RailWayController:OpenRailWayMainView()
  UIManager.Instance:Reopen(Urls.RailWayMainView)
end

function RailWayController:ReqOnOpenRailWay()
  ProtoManager.Instance:ReqServer("RailWayRequest", "ReqOnOpenRailWay", function(data)
    Logger.Info("RailWayRequest.ReqOnOpenRailWay success ", table.tostring(data))
    RailWayModel.Instance:UpdateBySvrData(data)
    if data.seasonId then
      local seasonGameType = CommonDefine.SeasonGameplayType.ConsciousnessRailway
      SeasonRotationController.Instance:SetSeasonData(seasonGameType, {
        seasonId = data.seasonId,
        data = data
      })
    end
  end, function(err)
    Logger.Error("RailWayRequest.ReqOnOpenRailWay failed ", table.tostring(err))
  end)
end

function RailWayController:OnReset()
end

return RailWayController
