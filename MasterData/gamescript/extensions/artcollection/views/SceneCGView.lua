local SceneCGView, Super = NewClass("SceneCGView", CGBaseView)
SceneCGView.uiResCls = UI_Collection_Item_CGResource

function SceneCGView:ctor(subFeature)
  Super.ctor(self, subFeature)
end

function SceneCGView:OnBuildView()
  Super.OnBuildView(self)
end

function SceneCGView:OnEnterView()
  Super.OnEnterView(self)
end

function SceneCGView:OnExitView()
  Super.OnExitView(self)
end

return SceneCGView
