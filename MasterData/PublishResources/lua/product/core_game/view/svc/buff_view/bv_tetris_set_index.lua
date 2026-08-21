_class("BuffViewTetrisSetIndex", BuffViewBase)
BuffViewTetrisSetIndex = BuffViewTetrisSetIndex

function BuffViewTetrisSetIndex:PlayView(TT, notify, trace)
  local featureSvcR = self._world:GetService("FeatureRender")
  Log.fatal("BuffViewTetrisSetIndex index:", self._buffResult:GetNewTetrisIndex(), "NewTetrisType:", self._buffResult:GetNewTetrisType())
  featureSvcR:NotifyTetrisRandom(TT, self._buffResult:GetNewTetrisIndex(), self._buffResult:GetNewTetrisType())
end
