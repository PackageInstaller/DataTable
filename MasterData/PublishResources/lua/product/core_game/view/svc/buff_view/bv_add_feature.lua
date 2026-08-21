_class("BuffViewAddFeature", BuffViewBase)
BuffViewAddFeature = BuffViewAddFeature

function BuffViewAddFeature:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:_InitUIFeatureList(TT)
  end
end
