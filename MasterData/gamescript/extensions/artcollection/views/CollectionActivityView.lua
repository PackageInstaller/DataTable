local CollectionActivityView, Super = NewClass("CollectionActivityView", CGBaseView)
CollectionActivityView.uiResCls = UI_Collection_Item_CGResource

function CollectionActivityView:ctor(subFeature)
  Super.ctor(self, subFeature)
end

function CollectionActivityView:OnBuildView()
  Super.OnBuildView(self)
end

function CollectionActivityView:OnEnterView()
  Super.OnEnterView(self)
end

function CollectionActivityView:OnExitView()
  Super.OnExitView(self)
end

return CollectionActivityView
