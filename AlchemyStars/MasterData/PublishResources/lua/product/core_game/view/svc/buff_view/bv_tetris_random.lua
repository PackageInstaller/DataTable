_class("BuffViewTetrisRandom", BuffViewBase)
BuffViewTetrisRandom = BuffViewTetrisRandom

function BuffViewTetrisRandom:PlayView(TT, notify, trace)
  local featureSvcR = self._world:GetService("FeatureRender")
  featureSvcR:NotifyTetrisRandom(TT, self._buffResult:GetNewTetrisIndex(), self._buffResult:GetNewTetrisType())
end
