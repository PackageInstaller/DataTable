local PvpReplayDataDetailView, Super = NewClass("PvpReplayDataDetailView", BaseView)
PvpReplayDataDetailView.uiResCls = UI_Research_Popup_ReportResource

function PvpReplayDataDetailView:ctor()
  Super.ctor(self)
  self:InitViewData()
end

function PvpReplayDataDetailView:InitViewData()
  self.model = PvpReplayDataModel.Instance
end

function PvpReplayDataDetailView:RegisterEvents()
end

function PvpReplayDataDetailView:OnExitView()
  Super.OnExitView(self)
  self.model:OnReset()
end

return PvpReplayDataDetailView
